Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3EC383B34
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 19:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhEQR0B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 13:26:01 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:32949 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231681AbhEQR0B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 13:26:01 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <pborgers@zedat.fu-berlin.de>)
          id 1ligyx-003AEb-P4; Mon, 17 May 2021 19:24:43 +0200
Received: from a36t-ffs1.berlin.freifunk.net ([77.87.51.11] helo=mi.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <borgers@mi.fu-berlin.de>)
          id 1ligyw-003amJ-J6; Mon, 17 May 2021 19:24:43 +0200
Received: by mi.fu-berlin.de (sSMTP sendmail emulation); Mon, 17 May 2021 19:24:42 +0200
From:   Philipp Borgers <borgers@mi.fu-berlin.de>
To:     ath9k-devel@qca.qualcomm.com
Cc:     linux-wireless@vger.kernel.org,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Subject: [PATCH] ath9k: ar9003_mac: read STBC indicator from rx descriptor
Date:   Mon, 17 May 2021 19:24:26 +0200
Message-Id: <20210517172426.15919-1-borgers@mi.fu-berlin.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: borgers@mi.fu-berlin.de
X-Originating-IP: 77.87.51.11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The rx descriptor contains a STBC indicator. If the indicator is set the
frame was received with STBC.

Signed-off-by: Philipp Borgers <borgers@mi.fu-berlin.de>
---
 drivers/net/wireless/ath/ath9k/ar9003_mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.c b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
index 76b538942a79..5184a0aacfe2 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
@@ -522,6 +522,8 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
 	rxs->rs_moreaggr = (rxsp->status11 & AR_RxMoreAggr) ? 1 : 0;
 	rxs->rs_antenna = (MS(rxsp->status4, AR_RxAntenna) & 0x7);
 	rxs->enc_flags |= (rxsp->status4 & AR_GI) ? RX_ENC_FLAG_SHORT_GI : 0;
+	rxs->enc_flags |=
+		(rxsp->status4 & AR_STBC) ? (1 << RX_ENC_FLAG_STBC_SHIFT) : 0;
 	rxs->bw = (rxsp->status4 & AR_2040) ? RATE_INFO_BW_40 : RATE_INFO_BW_20;
 
 	rxs->evm0 = rxsp->status6;
-- 
2.31.1

