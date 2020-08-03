Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B619223A971
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgHCPdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 11:33:49 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51534 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCPdt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 11:33:49 -0400
Received: from legolas.tu-ilmenau.de (unknown [141.24.111.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 7ED1258004F;
        Mon,  3 Aug 2020 17:33:47 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/4] iw: print current ext feature set
Date:   Mon,  3 Aug 2020 17:33:33 +0200
Message-Id: <20200803153336.319773-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/info.c b/info.c
index f7889fe..ee2faeb 100644
--- a/info.c
+++ b/info.c
@@ -710,6 +710,8 @@ broken_combination:
 		ext_feat_print(tb, BEACON_PROTECTION_CLIENT, "beacon prot. for clients support");
 		ext_feat_print(tb, SCAN_FREQ_KHZ, "scan on kHz frequency support");
 		ext_feat_print(tb, CONTROL_PORT_OVER_NL80211_TX_STATUS, "tx status for nl80211 control port support");
+		ext_feat_print(tb, OPERATING_CHANNEL_VALIDATION, "Operating Channel Validation (OCV) support");
+		ext_feat_print(tb, 4WAY_HANDSHAKE_AP_PSK, "AP mode PSK offload support");
 	}
 
 	if (tb_msg[NL80211_ATTR_COALESCE_RULE]) {
-- 
2.28.0

