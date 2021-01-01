Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D922E8343
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jan 2021 08:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhAAHAk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jan 2021 02:00:40 -0500
Received: from muru.com ([72.249.23.125]:40698 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbhAAHAj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jan 2021 02:00:39 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 8E4548057;
        Fri,  1 Jan 2021 07:00:14 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        Raz Bouganim <r-bouganim@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH] wlcore: Downgrade exceeded max RX BA sessions to debug
Date:   Fri,  1 Jan 2021 08:59:55 +0200
Message-Id: <20210101065955.63386-1-tony@atomide.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We can get the following in the logs every few minutes or so:

wlcore: ERROR exceeded max RX BA sessions

Let's downgrade the message to a debug message as suggested by the TI
support folks at:

https://e2e.ti.com/support/wireless-connectivity/wifi/f/968/p/352435/1244754

"The WL127x firmware supports max of 3 BA sessions. It cannot be increased.
 I think the problem here is the peer trying to initiate a 4th BA session
 (ADDBA request)."

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/net/wireless/ti/wlcore/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -5391,7 +5391,7 @@ static int wl1271_op_ampdu_action(struct ieee80211_hw *hw,
 
 		if (wl->ba_rx_session_count >= wl->ba_rx_session_count_max) {
 			ret = -EBUSY;
-			wl1271_error("exceeded max RX BA sessions");
+			wl1271_debug(DEBUG_RX, "exceeded max RX BA sessions");
 			break;
 		}
 
-- 
2.29.2
