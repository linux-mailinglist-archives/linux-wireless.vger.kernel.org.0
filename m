Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D128124912
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLROGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:06:12 -0500
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:32078 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbfLROGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:06:05 -0500
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 18 Dec 2019 14:59:55 +0100
Received: from lx-merez2.mea.qualcomm.com ([10.18.173.102])
  by ironmsg03-ams.qualcomm.com with ESMTP; 18 Dec 2019 14:59:51 +0100
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 3/8] wil6210: take mem_lock for writing in crash dump collection
Date:   Wed, 18 Dec 2019 15:59:42 +0200
Message-Id: <20191218135947.5903-4-merez@codeaurora.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218135947.5903-1-merez@codeaurora.org>
References: <20191218135947.5903-1-merez@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alexei Avshalom Lazar <ailizaro@codeaurora.org>

On some crash dump cases mem_lock is already taken, error
returns and crash dump copy fails.
In this case wait until mem_lock available instead of failing
the operation.
Also take the mem_lock for writing to prevent other threads from
altering the state of the device while collecting crash dump.

Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 .../net/wireless/ath/wil6210/wil_crash_dump.c   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wil_crash_dump.c b/drivers/net/wireless/ath/wil6210/wil_crash_dump.c
index 1332eb8c831f..89c12cb2aaab 100644
--- a/drivers/net/wireless/ath/wil6210/wil_crash_dump.c
+++ b/drivers/net/wireless/ath/wil6210/wil_crash_dump.c
@@ -46,7 +46,7 @@ static int wil_fw_get_crash_dump_bounds(struct wil6210_priv *wil,
 
 int wil_fw_copy_crash_dump(struct wil6210_priv *wil, void *dest, u32 size)
 {
-	int i, rc;
+	int i;
 	const struct fw_map *map;
 	void *data;
 	u32 host_min, dump_size, offset, len;
@@ -62,9 +62,15 @@ int wil_fw_copy_crash_dump(struct wil6210_priv *wil, void *dest, u32 size)
 		return -EINVAL;
 	}
 
-	rc = wil_mem_access_lock(wil);
-	if (rc)
-		return rc;
+	down_write(&wil->mem_lock);
+
+	if (test_bit(wil_status_suspending, wil->status) ||
+	    test_bit(wil_status_suspended, wil->status)) {
+		wil_err(wil,
+			"suspend/resume in progress. cannot copy crash dump\n");
+		up_write(&wil->mem_lock);
+		return -EBUSY;
+	}
 
 	/* copy to crash dump area */
 	for (i = 0; i < ARRAY_SIZE(fw_mapping); i++) {
@@ -84,7 +90,8 @@ int wil_fw_copy_crash_dump(struct wil6210_priv *wil, void *dest, u32 size)
 		wil_memcpy_fromio_32((void * __force)(dest + offset),
 				     (const void __iomem * __force)data, len);
 	}
-	wil_mem_access_unlock(wil);
+
+	up_write(&wil->mem_lock);
 
 	return 0;
 }
-- 
2.23.0

