Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBA15A3068
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 22:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbiHZUUY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344912AbiHZUUV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 16:20:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94365806
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 13:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=7BDfs3zY1q4ZJ80EnDObosL6epNX9UlV1q7NCAntau4=; t=1661545217; x=1662754817; 
        b=v+JB27iLCvNtsMcuPq+idMZk/bnoKM+hZSxi3o7Nd781qirFUxlIxlPtTPWsumMXVxHt/MyzVaV
        8fYL+3WLFCoC4DIvZiFMFl9HFMKW8qC+3I78HK2brt0XA7gtbq8O+BsvN2nNh0fbz5Xg/gUC1U6bP
        leJc3H2GTMGFPEptsAGpXAw2qYpyw4J1NIGQRqYfBfWsamK9j3mggiZcQUHTpYg/nXCUXkUrQOhfp
        aaA7jyLBVJtBfhbjAeX/GDzYjJH2XkpeOeI4eBdudA0L02BIaOIgqtZoL1kZcI+X4hS9DXuaFgRh4
        Lsw/klPHSn2oUu0YC1xm0cQnlSp1pPBEg3GQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oRfoJ-000Qtr-0b;
        Fri, 26 Aug 2022 22:20:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: use struct_group to copy addresses
Date:   Fri, 26 Aug 2022 22:20:08 +0200
Message-Id: <20220826222007.7acf78f1ecee.I7c75a7d3599f120c720a5d6ec170fd90ec0dfd51@changeid>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We sometimes copy all the addresses from the 802.11 header
for the AAD, which may cause complaints from fortify checks.
Use struct_group() to enable that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h          | 8 +++++---
 net/mac80211/wpa.c                 | 4 ++--
 net/wireless/lib80211_crypt_ccmp.c | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 55e6f4ad0ca6..b6e6d5b40774 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -310,9 +310,11 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
 struct ieee80211_hdr {
 	__le16 frame_control;
 	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
+	struct_group(addrs,
+		u8 addr1[ETH_ALEN];
+		u8 addr2[ETH_ALEN];
+		u8 addr3[ETH_ALEN];
+	);
 	__le16 seq_ctrl;
 	u8 addr4[ETH_ALEN];
 } __packed __aligned(2);
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 93ec2f349748..20f742b5503b 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -351,7 +351,7 @@ static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad)
 	 * FC | A1 | A2 | A3 | SC | [A4] | [QC] */
 	put_unaligned_be16(len_a, &aad[0]);
 	put_unaligned(mask_fc, (__le16 *)&aad[2]);
-	memcpy(&aad[4], &hdr->addr1, 3 * ETH_ALEN);
+	memcpy(&aad[4], &hdr->addrs, 3 * ETH_ALEN);
 
 	/* Mask Seq#, leave Frag# */
 	aad[22] = *((u8 *) &hdr->seq_ctrl) & 0x0f;
@@ -792,7 +792,7 @@ static void bip_aad(struct sk_buff *skb, u8 *aad)
 				IEEE80211_FCTL_MOREDATA);
 	put_unaligned(mask_fc, (__le16 *) &aad[0]);
 	/* A1 || A2 || A3 */
-	memcpy(aad + 2, &hdr->addr1, 3 * ETH_ALEN);
+	memcpy(aad + 2, &hdr->addrs, 3 * ETH_ALEN);
 }
 
 
diff --git a/net/wireless/lib80211_crypt_ccmp.c b/net/wireless/lib80211_crypt_ccmp.c
index 6a5f08f7491e..37fe93ed2529 100644
--- a/net/wireless/lib80211_crypt_ccmp.c
+++ b/net/wireless/lib80211_crypt_ccmp.c
@@ -136,7 +136,7 @@ static int ccmp_init_iv_and_aad(const struct ieee80211_hdr *hdr,
 	pos = (u8 *) hdr;
 	aad[0] = pos[0] & 0x8f;
 	aad[1] = pos[1] & 0xc7;
-	memcpy(aad + 2, hdr->addr1, 3 * ETH_ALEN);
+	memcpy(aad + 2, hdr->addrs, 3 * ETH_ALEN);
 	pos = (u8 *) & hdr->seq_ctrl;
 	aad[20] = pos[0] & 0x0f;
 	aad[21] = 0;		/* all bits masked */
-- 
2.37.2

