Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37EF47898F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 12:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfG2KX6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 06:23:58 -0400
Received: from nbd.name ([46.4.11.11]:51526 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfG2KX6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 06:23:58 -0400
Received: from pd95fd89e.dip0.t-ipconnect.de ([217.95.216.158] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hs2ot-0005aM-G0; Mon, 29 Jul 2019 12:23:55 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH V6 1/2] mac80211: fix ieee80211_he_oper_size() comment
Date:   Mon, 29 Jul 2019 12:23:41 +0200
Message-Id: <20190729102342.8659-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes mentioned that the comment should not reference mac80211 as other
subsystems might call the helper.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 include/linux/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index a656f31262f1..9c81895c63c1 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2053,8 +2053,8 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
  * ieee80211_he_oper_size - calculate 802.11ax HE Operations IE size
  * @he_oper_ie: byte data of the He Operations IE, stating from the the byte
  *	after the ext ID byte. It is assumed that he_oper_ie has at least
- *	sizeof(struct ieee80211_he_operation) bytes, checked already in
- *	ieee802_11_parse_elems_crc()
+ *	sizeof(struct ieee80211_he_operation) bytes, the caller must have
+ *	validated this.
  * @return the actual size of the IE data (not including header), or 0 on error
  */
 static inline u8
-- 
2.20.1

