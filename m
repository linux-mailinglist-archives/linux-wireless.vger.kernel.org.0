Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7548345115
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 21:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhCVUrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 16:47:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:38743 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhCVUqx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 16:46:53 -0400
IronPort-SDR: QxyO/9M3FvG0XMRr641ePljlrKSKc/uCaHDJPqrrJSbotPi9h1iivPzrZSggd2yU+j7MROY0We
 R82T3XWLveJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189746691"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="189746691"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:46:51 -0700
IronPort-SDR: NsvoX11hLp/zj7eO2OtcDDpxOT3fkS24ZGOVqimxMrfyZDS/2fxyNqxNEy7Tw8OWpYPmibsgOa
 kBdbMgZx6gQg==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414640834"
Received: from isutskov-mobl.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.251.189.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:46:48 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        luca@coelho.fi, Tomas Winkler <tomas.winkler@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 1/5] mei: allow map and unmap of client dma buffer only for disconnected client
Date:   Mon, 22 Mar 2021 22:46:29 +0200
Message-Id: <20210322204633.102581-2-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322204633.102581-1-emmanuel.grumbach@intel.com>
References: <20210322204633.102581-1-emmanuel.grumbach@intel.com>
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

