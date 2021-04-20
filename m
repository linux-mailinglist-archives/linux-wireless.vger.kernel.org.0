Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE86365E91
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 19:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhDTR2l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Apr 2021 13:28:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:10868 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhDTR2g (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Apr 2021 13:28:36 -0400
IronPort-SDR: q6ZtdALoJRfnz/eJk0/IbkVTLaiE5YAEPQeOn4nW1opwJ6Em9GXt98uTV12jv5CkkS7To8ZDsh
 ESNHLA2Cpnsg==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="192364306"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="192364306"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 10:28:04 -0700
IronPort-SDR: XVnuKekf59d6ZtbK27ullxfoM5KEn0iHaouT4AGiC4QLpenvbngzHMjfpYuVOMxN6xWRNsIKz4
 wOrzX+NnF6Qw==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="616975340"
Received: from labadi-mobl.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.214.223.251])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 10:28:02 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes.berg@intel.com, tomas.winkler@intel.com,
        luciano.coelho@intel.com, gregkh@linuxfoundation.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 1/3] mei: bus: add client dma interface
Date:   Tue, 20 Apr 2021 20:27:53 +0300
Message-Id: <20210420172755.12178-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Expose the client dma mapping via mei client bus interface.
The client dma has to be mapped before the device is enabled,
therefore we need to create device linking already during mapping
and we need to unmap after the client is disable hence we need to
postpone the unlink and flush till unmapping or when
destroying the device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Co-developed-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
This is a another version of the patch:
https://lore.kernel.org/lkml/20210206144325.25682-6-tomas.winkler@intel.com/

Greg asked to route this patch through the wireless drivers tree:
https://lore.kernel.org/lkml/YB6sIi61X5p6Dq6y@kroah.com/
So here it is.
---
---
 drivers/misc/mei/bus.c     | 67 ++++++++++++++++++++++++++++++++++++--
 drivers/misc/mei/client.c  |  3 ++
 drivers/misc/mei/hw.h      |  5 +++
 include/linux/mei_cl_bus.h |  3 ++
 4 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 935acc6bbf3c..7a325572ad1d 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -643,6 +643,64 @@ static void mei_cl_bus_vtag_free(struct mei_cl_device *cldev)
 	kfree(cl_vtag);
 }
 
+void *mei_cldev_dma_map(struct mei_cl_device *cldev, u8 buffer_id, size_t size)
+{
+	struct mei_device *bus;
+	struct mei_cl *cl;
+	int ret;
+
+	if (!cldev || !buffer_id || !size)
+		return ERR_PTR(-EINVAL);
+
+	if (!IS_ALIGNED(size, MEI_FW_PAGE_SIZE)) {
+		dev_err(&cldev->dev, "Map size should be aligned to %lu\n",
+			MEI_FW_PAGE_SIZE);
+		return ERR_PTR(-EINVAL);
+	}
+
+	cl = cldev->cl;
+	bus = cldev->bus;
+
+	mutex_lock(&bus->device_lock);
+	if (cl->state == MEI_FILE_UNINITIALIZED) {
+		ret = mei_cl_link(cl);
+		if (ret)
+			goto out;
+		/* update pointers */
+		cl->cldev = cldev;
+	}
+
+	ret = mei_cl_dma_alloc_and_map(cl, NULL, buffer_id, size);
+out:
+	mutex_unlock(&bus->device_lock);
+	if (ret)
+		return ERR_PTR(ret);
+	return cl->dma.vaddr;
+}
+EXPORT_SYMBOL_GPL(mei_cldev_dma_map);
+
+int mei_cldev_dma_unmap(struct mei_cl_device *cldev)
+{
+	struct mei_device *bus;
+	struct mei_cl *cl;
+	int ret;
+
+	if (!cldev)
+		return -EINVAL;
+
+	cl = cldev->cl;
+	bus = cldev->bus;
+
+	mutex_lock(&bus->device_lock);
+	ret = mei_cl_dma_unmap(cl, NULL);
+
+	mei_cl_flush_queues(cl, NULL);
+	mei_cl_unlink(cl);
+	mutex_unlock(&bus->device_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mei_cldev_dma_unmap);
+
 /**
  * mei_cldev_enable - enable me client device
  *     create connection with me client
@@ -753,9 +811,11 @@ int mei_cldev_disable(struct mei_cl_device *cldev)
 		dev_err(bus->dev, "Could not disconnect from the ME client\n");
 
 out:
-	/* Flush queues and remove any pending read */
-	mei_cl_flush_queues(cl, NULL);
-	mei_cl_unlink(cl);
+	/* Flush queues and remove any pending read unless we have mapped DMA */
+	if (!cl->dma_mapped) {
+		mei_cl_flush_queues(cl, NULL);
+		mei_cl_unlink(cl);
+	}
 
 	mutex_unlock(&bus->device_lock);
 	return err;
@@ -1054,6 +1114,7 @@ static void mei_cl_bus_dev_release(struct device *dev)
 	if (!cldev)
 		return;
 
+	mei_cl_flush_queues(cldev->cl, NULL);
 	mei_me_cl_put(cldev->me_cl);
 	mei_dev_bus_put(cldev->bus);
 	mei_cl_unlink(cldev->cl);
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 2cc370adb238..5e71f455db35 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -700,6 +700,9 @@ int mei_cl_unlink(struct mei_cl *cl)
 
 	cl_dbg(dev, cl, "unlink client");
 
+	if (cl->state == MEI_FILE_UNINITIALIZED)
+		return 0;
+
 	if (dev->open_handle_count > 0)
 		dev->open_handle_count--;
 
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index b10606550613..bc240b88abf1 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -22,6 +22,11 @@
 #define MEI_D0I3_TIMEOUT            5  /* D0i3 set/unset max response time */
 #define MEI_HBM_TIMEOUT             1  /* 1 second */
 
+/*
+ * FW page size for DMA allocations
+ */
+#define MEI_FW_PAGE_SIZE 4096UL
+
 /*
  * MEI Version
  */
diff --git a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h
index 07f5ef8fc456..8c8d46ba33bf 100644
--- a/include/linux/mei_cl_bus.h
+++ b/include/linux/mei_cl_bus.h
@@ -116,4 +116,7 @@ int mei_cldev_enable(struct mei_cl_device *cldev);
 int mei_cldev_disable(struct mei_cl_device *cldev);
 bool mei_cldev_enabled(struct mei_cl_device *cldev);
 
+void *mei_cldev_dma_map(struct mei_cl_device *cldev, u8 buffer_id, size_t size);
+int mei_cldev_dma_unmap(struct mei_cl_device *cldev);
+
 #endif /* _LINUX_MEI_CL_BUS_H */
-- 
2.25.1

