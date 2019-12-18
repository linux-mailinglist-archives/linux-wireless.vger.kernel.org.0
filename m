Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393A5124910
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfLROGG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:06:06 -0500
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:4869 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727137AbfLROGG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:06:06 -0500
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 18 Dec 2019 14:59:55 +0100
Received: from lx-merez2.mea.qualcomm.com ([10.18.173.102])
  by ironmsg03-ams.qualcomm.com with ESMTP; 18 Dec 2019 14:59:51 +0100
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 2/8] wil6210: minimize the time that mem_lock is held
Date:   Wed, 18 Dec 2019 15:59:41 +0200
Message-Id: <20191218135947.5903-3-merez@codeaurora.org>
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

mem_lock is taken for the entire wil_reset().
Optimize this by taking mem_lock just before device is
being reset and release the lock after FW download.

Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 06091d8a9e23..6d39547e20fd 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -1654,6 +1654,8 @@ int wil_reset(struct wil6210_priv *wil, bool load_fw)
 	/* Disable device led before reset*/
 	wmi_led_cfg(wil, false);
 
+	down_write(&wil->mem_lock);
+
 	/* prevent NAPI from being scheduled and prevent wmi commands */
 	mutex_lock(&wil->wmi_mutex);
 	if (test_bit(wil_status_suspending, wil->status))
@@ -1702,6 +1704,7 @@ int wil_reset(struct wil6210_priv *wil, bool load_fw)
 
 		if  (wil->secured_boot) {
 			wil_err(wil, "secured boot is not supported\n");
+			up_write(&wil->mem_lock);
 			return -ENOTSUPP;
 		}
 
@@ -1737,6 +1740,8 @@ int wil_reset(struct wil6210_priv *wil, bool load_fw)
 
 	clear_bit(wil_status_resetting, wil->status);
 
+	up_write(&wil->mem_lock);
+
 	if (load_fw) {
 		wil_unmask_irq(wil);
 
@@ -1786,6 +1791,7 @@ int wil_reset(struct wil6210_priv *wil, bool load_fw)
 	return rc;
 
 out:
+	up_write(&wil->mem_lock);
 	clear_bit(wil_status_resetting, wil->status);
 	return rc;
 }
@@ -1811,9 +1817,7 @@ int __wil_up(struct wil6210_priv *wil)
 
 	WARN_ON(!mutex_is_locked(&wil->mutex));
 
-	down_write(&wil->mem_lock);
 	rc = wil_reset(wil, true);
-	up_write(&wil->mem_lock);
 	if (rc)
 		return rc;
 
@@ -1905,9 +1909,7 @@ int __wil_down(struct wil6210_priv *wil)
 	wil_abort_scan_all_vifs(wil, false);
 	mutex_unlock(&wil->vif_mutex);
 
-	down_write(&wil->mem_lock);
 	rc = wil_reset(wil, false);
-	up_write(&wil->mem_lock);
 
 	return rc;
 }
-- 
2.23.0

