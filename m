Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28AF3D6FAD
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 08:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhG0Gvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 02:51:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:21751 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234349AbhG0Gvm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 02:51:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="212104819"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="212104819"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 23:51:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="505368794"
Received: from lgeva1-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.255.198.250])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 23:51:40 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     luciano.coelho@intel.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Cc:     egrumbach@gmail.com,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 1/7] mei: bus: add client dma interface
Date:   Tue, 27 Jul 2021 09:51:28 +0300
Message-Id: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
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
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20210420172755.12178-1-emmanuel.grumbach@intel.com
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
index 96f4e59c32a5..0e90591235a6 100644
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
index dfd60c916da0..b46077b17114 100644
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

