Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54316261B75
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgIHTDd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:03:33 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52646 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731691AbgIHTDZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 15:03:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 14C594F9B07;
        Tue,  8 Sep 2020 19:03:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3kQOUspzD9XD; Tue,  8 Sep 2020 19:03:20 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 5BC644F9ACD;
        Tue,  8 Sep 2020 19:03:20 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 01/22] ieee80211: redefine S1G bits with GENMASK
Date:   Tue,  8 Sep 2020 12:03:02 -0700
Message-Id: <20200908190323.15814-2-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908190323.15814-1-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The S1G capability fields were defined by ORing BITS()
together, and expecting a custom macro to use the _SHIFT
definitions. Use the Linux kernel GENMASK for the
definitions now, and FIELD_{GET,PREP} to access the fields
in the future.

Take the chance to rename eg. S1G_CAPAB_B0 to the more
compact S1G_CAP0.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/linux/ieee80211.h | 156 +++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index c47f43e65a2f..53fba39d4ba6 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2330,84 +2330,84 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 }
 
 /* S1G Capabilities Information field */
-#define S1G_CAPAB_B0_S1G_LONG BIT(0)
-#define S1G_CAPAB_B0_SGI_1MHZ BIT(1)
-#define S1G_CAPAB_B0_SGI_2MHZ BIT(2)
-#define S1G_CAPAB_B0_SGI_4MHZ BIT(3)
-#define S1G_CAPAB_B0_SGI_8MHZ BIT(4)
-#define S1G_CAPAB_B0_SGI_16MHZ BIT(5)
-#define S1G_CAPAB_B0_SUPP_CH_WIDTH_MASK (BIT(6) | BIT(7))
-#define S1G_CAPAB_B0_SUPP_CH_WIDTH_SHIFT 6
-
-#define S1G_CAPAB_B1_RX_LDPC BIT(0)
-#define S1G_CAPAB_B1_TX_STBC BIT(1)
-#define S1G_CAPAB_B1_RX_STBC BIT(2)
-#define S1G_CAPAB_B1_SU_BFER BIT(3)
-#define S1G_CAPAB_B1_SU_BFEE BIT(4)
-#define S1G_CAPAB_B1_BFEE_STS_MASK (BIT(5) | BIT(6) | BIT(7))
-#define S1G_CAPAB_B1_BFEE_STS_SHIFT 5
-
-#define S1G_CAPAB_B2_SOUNDING_DIMENSIONS_MASK (BIT(0) | BIT(1) | BIT(2))
-#define S1G_CAPAB_B2_SOUNDING_DIMENSIONS_SHIFT 0
-#define S1G_CAPAB_B2_MU_BFER BIT(3)
-#define S1G_CAPAB_B2_MU_BFEE BIT(4)
-#define S1G_CAPAB_B2_PLUS_HTC_VHT BIT(5)
-#define S1G_CAPAB_B2_TRAVELING_PILOT_MASK (BIT(6) | BIT(7))
-#define S1G_CAPAB_B2_TRAVELING_PILOT_SHIFT 6
-
-#define S1G_CAPAB_B3_RD_RESPONDER BIT(0)
-#define S1G_CAPAB_B3_HT_DELAYED_BA BIT(1)
-#define S1G_CAPAB_B3_MAX_MPDU_LEN BIT(2)
-#define S1G_CAPAB_B3_MAX_AMPDU_LEN_EXP_MASK (BIT(3) | BIT(4))
-#define S1G_CAPAB_B3_MAX_AMPDU_LEN_EXP_SHIFT 3
-#define S1G_CAPAB_B3_MIN_MPDU_START_MASK (BIT(5) | BIT(6) | BIT(7))
-#define S1G_CAPAB_B3_MIN_MPDU_START_SHIFT 5
-
-#define S1G_CAPAB_B4_UPLINK_SYNC BIT(0)
-#define S1G_CAPAB_B4_DYNAMIC_AID BIT(1)
-#define S1G_CAPAB_B4_BAT BIT(2)
-#define S1G_CAPAB_B4_TIME_ADE BIT(3)
-#define S1G_CAPAB_B4_NON_TIM BIT(4)
-#define S1G_CAPAB_B4_GROUP_AID BIT(5)
-#define S1G_CAPAB_B4_STA_TYPE_MASK (BIT(6) | BIT(7))
-#define S1G_CAPAB_B4_STA_TYPE_SHIFT 6
-
-#define S1G_CAPAB_B5_CENT_AUTH_CONTROL BIT(0)
-#define S1G_CAPAB_B5_DIST_AUTH_CONTROL BIT(1)
-#define S1G_CAPAB_B5_AMSDU BIT(2)
-#define S1G_CAPAB_B5_AMPDU BIT(3)
-#define S1G_CAPAB_B5_ASYMMETRIC_BA BIT(4)
-#define S1G_CAPAB_B5_FLOW_CONTROL BIT(5)
-#define S1G_CAPAB_B5_SECTORIZED_BEAM_MASK (BIT(6) | BIT(7))
-#define S1G_CAPAB_B5_SECTORIZED_BEAM_SHIFT 6
-
-#define S1G_CAPAB_B6_OBSS_MITIGATION BIT(0)
-#define S1G_CAPAB_B6_FRAGMENT_BA BIT(1)
-#define S1G_CAPAB_B6_NDP_PS_POLL BIT(2)
-#define S1G_CAPAB_B6_RAW_OPERATION BIT(3)
-#define S1G_CAPAB_B6_PAGE_SLICING BIT(4)
-#define S1G_CAPAB_B6_TXOP_SHARING_IMP_ACK BIT(5)
-#define S1G_CAPAB_B6_VHT_LINK_ADAPT_MASK (BIT(6) | BIT(7))
-#define S1G_CAPAB_B6_VHT_LINK_ADAPT_SHIFT 6
-
-#define S1G_CAPAB_B7_TACK_AS_PS_POLL BIT(0)
-#define S1G_CAPAB_B7_DUP_1MHZ BIT(1)
-#define S1G_CAPAB_B7_MCS_NEGOTIATION BIT(2)
-#define S1G_CAPAB_B7_1MHZ_CTL_RESPONSE_PREAMBLE BIT(3)
-#define S1G_CAPAB_B7_NDP_BFING_REPORT_POLL BIT(4)
-#define S1G_CAPAB_B7_UNSOLICITED_DYN_AID BIT(5)
-#define S1G_CAPAB_B7_SECTOR_TRAINING_OPERATION BIT(6)
-#define S1G_CAPAB_B7_TEMP_PS_MODE_SWITCH BIT(7)
-
-#define S1G_CAPAB_B8_TWT_GROUPING BIT(0)
-#define S1G_CAPAB_B8_BDT BIT(1)
-#define S1G_CAPAB_B8_COLOR_MASK (BIT(2) | BIT(3) | BIT(4))
-#define S1G_CAPAB_B8_COLOR_SHIFT 2
-#define S1G_CAPAB_B8_TWT_REQUEST BIT(5)
-#define S1G_CAPAB_B8_TWT_RESPOND BIT(6)
-#define S1G_CAPAB_B8_PV1_FRAME BIT(7)
-
-#define S1G_CAPAB_B9_LINK_ADAPT_PER_CONTROL_RESPONSE BIT(0)
+#define S1G_CAP0_S1G_LONG	BIT(0)
+#define S1G_CAP0_SGI_1MHZ	BIT(1)
+#define S1G_CAP0_SGI_2MHZ	BIT(2)
+#define S1G_CAP0_SGI_4MHZ	BIT(3)
+#define S1G_CAP0_SGI_8MHZ	BIT(4)
+#define S1G_CAP0_SGI_16MHZ	BIT(5)
+#define S1G_CAP0_SUPP_CH_WIDTH	GENMASK(7, 6)
+
+#define S1G_SUPP_CH_WIDTH_2	0
+#define S1G_SUPP_CH_WIDTH_4	1
+#define S1G_SUPP_CH_WIDTH_8	2
+#define S1G_SUPP_CH_WIDTH_16	3
+#define S1G_SUPP_CH_WIDTH_MAX(cap) ((1 << FIELD_GET(S1G_CAP0_SUPP_CH_WIDTH, \
+						    cap[0])) << 1)
+
+#define S1G_CAP1_RX_LDPC	BIT(0)
+#define S1G_CAP1_TX_STBC	BIT(1)
+#define S1G_CAP1_RX_STBC	BIT(2)
+#define S1G_CAP1_SU_BFER	BIT(3)
+#define S1G_CAP1_SU_BFEE	BIT(4)
+#define S1G_CAP1_BFEE_STS	GENMASK(7, 5)
+
+#define S1G_CAP2_SOUNDING_DIMENSIONS	GENMASK(2, 0)
+#define S1G_CAP2_MU_BFER		BIT(3)
+#define S1G_CAP2_MU_BFEE		BIT(4)
+#define S1G_CAP2_PLUS_HTC_VHT		BIT(5)
+#define S1G_CAP2_TRAVELING_PILOT	GENMASK(7, 6)
+
+#define S1G_CAP3_RD_RESPONDER		BIT(0)
+#define S1G_CAP3_HT_DELAYED_BA		BIT(1)
+#define S1G_CAP3_MAX_MPDU_LEN		BIT(2)
+#define S1G_CAP3_MAX_AMPDU_LEN_EXP	GENMASK(4, 3)
+#define S1G_CAP3_MIN_MPDU_START		GENMASK(7, 5)
+
+#define S1G_CAP4_UPLINK_SYNC	BIT(0)
+#define S1G_CAP4_DYNAMIC_AID	BIT(1)
+#define S1G_CAP4_BAT		BIT(2)
+#define S1G_CAP4_TIME_ADE	BIT(3)
+#define S1G_CAP4_NON_TIM	BIT(4)
+#define S1G_CAP4_GROUP_AID	BIT(5)
+#define S1G_CAP4_STA_TYPE	GENMASK(7, 6)
+
+#define S1G_CAP5_CENT_AUTH_CONTROL	BIT(0)
+#define S1G_CAP5_DIST_AUTH_CONTROL	BIT(1)
+#define S1G_CAP5_AMSDU			BIT(2)
+#define S1G_CAP5_AMPDU			BIT(3)
+#define S1G_CAP5_ASYMMETRIC_BA		BIT(4)
+#define S1G_CAP5_FLOW_CONTROL		BIT(5)
+#define S1G_CAP5_SECTORIZED_BEAM	GENMASK(7, 6)
+
+#define S1G_CAP6_OBSS_MITIGATION	BIT(0)
+#define S1G_CAP6_FRAGMENT_BA		BIT(1)
+#define S1G_CAP6_NDP_PS_POLL		BIT(2)
+#define S1G_CAP6_RAW_OPERATION		BIT(3)
+#define S1G_CAP6_PAGE_SLICING		BIT(4)
+#define S1G_CAP6_TXOP_SHARING_IMP_ACK	BIT(5)
+#define S1G_CAP6_VHT_LINK_ADAPT		GENMASK(7, 6)
+
+#define S1G_CAP7_TACK_AS_PS_POLL		BIT(0)
+#define S1G_CAP7_DUP_1MHZ			BIT(1)
+#define S1G_CAP7_MCS_NEGOTIATION		BIT(2)
+#define S1G_CAP7_1MHZ_CTL_RESPONSE_PREAMBLE	BIT(3)
+#define S1G_CAP7_NDP_BFING_REPORT_POLL		BIT(4)
+#define S1G_CAP7_UNSOLICITED_DYN_AID		BIT(5)
+#define S1G_CAP7_SECTOR_TRAINING_OPERATION	BIT(6)
+#define S1G_CAP7_TEMP_PS_MODE_SWITCH		BIT(7)
+
+#define S1G_CAP8_TWT_GROUPING	BIT(0)
+#define S1G_CAP8_BDT		BIT(1)
+#define S1G_CAP8_COLOR		GENMASK(4, 2)
+#define S1G_CAP8_TWT_REQUEST	BIT(5)
+#define S1G_CAP8_TWT_RESPOND	BIT(6)
+#define S1G_CAP8_PV1_FRAME	BIT(7)
+
+#define S1G_CAP9_LINK_ADAPT_PER_CONTROL_RESPONSE BIT(0)
+
+#define S1G_OPER_CH_WIDTH_PRIMARY_1MHZ	BIT(0)
+#define S1G_OPER_CH_WIDTH_OPER		GENMASK(4, 1)
 
 /* Authentication algorithms */
 #define WLAN_AUTH_OPEN 0
-- 
2.20.1

