Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9012490F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLROGF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:06:05 -0500
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:32078 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727130AbfLROGD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:06:03 -0500
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 18 Dec 2019 14:59:55 +0100
Received: from lx-merez2.mea.qualcomm.com ([10.18.173.102])
  by ironmsg03-ams.qualcomm.com with ESMTP; 18 Dec 2019 14:59:52 +0100
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 4/8] wil6210: add verification for cid upper bound
Date:   Wed, 18 Dec 2019 15:59:43 +0200
Message-Id: <20191218135947.5903-5-merez@codeaurora.org>
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

max_assoc_sta can receive values (from the user or from the FW)
that are higher than WIL6210_MAX_CID.
Verify that cid doesn't exceed the upper bound of WIL6210_MAX_CID.

Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/wil6210.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 97626bfd4dac..bf00f0693a3d 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1148,7 +1148,7 @@ static inline void wil_c(struct wil6210_priv *wil, u32 reg, u32 val)
  */
 static inline bool wil_cid_valid(struct wil6210_priv *wil, int cid)
 {
-	return (cid >= 0 && cid < wil->max_assoc_sta);
+	return (cid >= 0 && cid < wil->max_assoc_sta && cid < WIL6210_MAX_CID);
 }
 
 void wil_get_board_file(struct wil6210_priv *wil, char *buf, size_t len);
-- 
2.23.0

