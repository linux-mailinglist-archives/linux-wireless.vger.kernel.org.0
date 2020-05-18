Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0B31D7812
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 14:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgERMDS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 08:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgERMDS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 08:03:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1080C061A0C
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2020 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=y0oef3oz1wN8/kuX286DzfPSsQJujeUDApdnxNZdIRQ=; b=K9bNvhVwjQE63j4RFnqtRkqKmg
        pmwhRF4Dv+UOW6EHSqDTNaR64hCLOi79Nbvrq9xAvPQPq2QC58P25xyHuOLds7tN299G/PZnFF2nM
        AwLS9jCdNcJF2fJkDfKDpz1V/dKe/4NdF9YnffTSACKOc7EdeVJZt2lsBt+Me8PzaTwM=;
Received: from p5b206c3b.dip0.t-ipconnect.de ([91.32.108.59] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jaeUE-0006JT-Dw; Mon, 18 May 2020 14:03:14 +0200
Received: by maeck.local (Postfix, from userid 501)
        id D89828707AF3; Mon, 18 May 2020 14:03:13 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix decoded radiotap HE flags
Date:   Mon, 18 May 2020 14:03:13 +0200
Message-Id: <20200518120313.32650-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Move assignment of .data1 and .data2 to a single place and fix overwriting
of values from the template

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 7ad7c2b7afdc..bf96b389c813 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -235,9 +235,14 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
 			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
 			 HE_BITS(DATA1_STBC_KNOWN) |
-			 HE_BITS(DATA1_CODING_KNOWN),
+			 HE_BITS(DATA1_CODING_KNOWN) |
+			 HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
+			 HE_BITS(DATA1_DOPPLER_KNOWN) |
+			 HE_BITS(DATA1_BSS_COLOR_KNOWN),
 		.data2 = HE_BITS(DATA2_GI_KNOWN) |
-			 HE_BITS(DATA2_TXBF_KNOWN),
+			 HE_BITS(DATA2_TXBF_KNOWN) |
+			 HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
+			 HE_BITS(DATA2_TXOP_KNOWN),
 	};
 	struct ieee80211_radiotap_he *he = NULL;
 	__le32 v2 = rxv->v[2];
@@ -248,12 +253,6 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 	he = skb_push(skb, sizeof(known));
 	memcpy(he, &known, sizeof(known));
 
-	he->data1 = HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
-		    HE_BITS(DATA1_DOPPLER_KNOWN) |
-		    HE_BITS(DATA1_BSS_COLOR_KNOWN);
-	he->data2 = HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
-		    HE_BITS(DATA2_TXOP_KNOWN);
-
 	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, v14) |
 		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, v2);
 	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, v2) |
@@ -296,10 +295,10 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
 			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
 			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
 
-		he->data4 = HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, v11) |
-			    HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, v11) |
-			    HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, v11) |
-			    HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, v11);
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, v11) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, v11) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, v11) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, v11);
 
 		mt7915_mac_decode_he_radiotap_ru(status, rxv, he);
 		break;
-- 
2.24.0

