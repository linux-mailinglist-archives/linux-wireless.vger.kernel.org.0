Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AE9345102
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 21:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhCVUml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 16:42:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:48250 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhCVUmN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 16:42:13 -0400
IronPort-SDR: S5Bf2zdXP3aNe+BBpIvUsttjN+qX+5XHAvJQbsYM/ZboEQDMS4iV8w/QuGekpKLCrwJFuE0jIX
 9nWX5xV5W5aQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="169675983"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="169675983"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:42:13 -0700
IronPort-SDR: R4uohEB8K1QQi151sRe6AL3tJMP/NxpriDHVUMnTwLGwM5PtkNGAzZCJtYhAiuBrn0tzFa9wb1
 LR0qg3Hnaudw==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="407978314"
Received: from isutskov-mobl.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.251.189.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:42:11 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        luca@coelho.fi, Tomas Winkler <tomas.winkler@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 1/5] mei: allow map and unmap of client dma buffer only for disconnected client
Date:   Mon, 22 Mar 2021 22:41:51 +0200
Message-Id: <20210322204157.102078-2-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322204157.102078-1-emmanuel.grumbach@intel.com>
References: <20210322204157.102078-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

Allow map and unmap of the client dma buffer only when the client is not
connected. The functions return -EPROTO if the client is already connected.
This is to fix the race when traffic may start or stop when buffer
is not available.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/misc/mei/client.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 4378a9b25848..2cc370adb238 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -2286,8 +2286,8 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
 	if (buffer_id == 0)
 		return -EINVAL;
 
-	if (!mei_cl_is_connected(cl))
-		return -ENODEV;
+	if (mei_cl_is_connected(cl))
+		return -EPROTO;
 
 	if (cl->dma_mapped)
 		return -EPROTO;
@@ -2327,9 +2327,7 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
 
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(cl->wait,
-			   cl->dma_mapped ||
-			   cl->status ||
-			   !mei_cl_is_connected(cl),
+			   cl->dma_mapped || cl->status,
 			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
 	mutex_lock(&dev->device_lock);
 
@@ -2376,8 +2374,9 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
 		return -EOPNOTSUPP;
 	}
 
-	if (!mei_cl_is_connected(cl))
-		return -ENODEV;
+	/* do not allow unmap for connected client */
+	if (mei_cl_is_connected(cl))
+		return -EPROTO;
 
 	if (!cl->dma_mapped)
 		return -EPROTO;
@@ -2405,9 +2404,7 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
 
 	mutex_unlock(&dev->device_lock);
 	wait_event_timeout(cl->wait,
-			   !cl->dma_mapped ||
-			   cl->status ||
-			   !mei_cl_is_connected(cl),
+			   !cl->dma_mapped || cl->status,
 			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
 	mutex_lock(&dev->device_lock);
 
-- 
2.25.1

