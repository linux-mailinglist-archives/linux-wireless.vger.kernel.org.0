Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA1707109
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 20:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjEQSoj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 14:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjEQSoh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 14:44:37 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2194C5FDF
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 11:44:35 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 47AD7280073
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 18:44:33 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C6E8D13C2B0;
        Wed, 17 May 2023 11:44:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C6E8D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684349072;
        bh=dQWWeps64Hb6iBrt8IcSax38qocHA25d5jDhOu1MrGk=;
        h=From:To:Cc:Subject:Date:From;
        b=VBKXeVdhC+MWiVyV/R6+3H38jtOBI7MG6sWRqBhUui9DDfDuYWaAOzYxjLS6MvB3C
         GH/o3Z7QvVKD/2VbTTPoLEl9VQIYJpWoWD0r0OclO2YPj28znO+3jY7KfU+nw6qCX2
         VARyE0yTiY7C+k78uOnnOE4q6Tw53V79qUwKg4oE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211:  add eht_capa debugfs field.
Date:   Wed, 17 May 2023 11:44:28 -0700
Message-Id: <20230517184428.999384-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1684349073-BQlD_W03cvpb
X-MDID-O: us5;ut7;1684349073;BQlD_W03cvpb;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Output looks like this:

[root@ct523c-0b29 ~]# cat /debug/ieee80211/wiphy6/netdev\:wlan6/stations/50\:28\:4a\:bd\:f4\:a7/eht_capa
EHT supported
MAC-CAP: 0x82 0x00
PHY-CAP: 0x0c 0x00 0x00 0x00 0x00 0x48 0x00 0x00 0x00
		OM-CONTROL
		MAX-MPDU-LEN: 11454
		242-TONE-RU-GT20MHZ
		NDP-4-EHT-LFT-32-GI
		BEAMFORMEE-80-NSS: 0
		BEAMFORMEE-160-NSS: 0
		BEAMFORMEE-320-NSS: 0
		SOUNDING-DIM-80-NSS: 0
		SOUNDING-DIM-160-NSS: 0
		SOUNDING-DIM-320-NSS: 0
		MAX_NC: 0
		PPE_THRESHOLD_PRESENT
		NOMINAL_PKT_PAD: 0us
		MAX-NUM-SUPP-EHT-LTF: 1
		SUPP-EXTRA-EHT-LTF
		MCS15-SUPP-MASK: 0

		EHT bw <= 80 MHz, max NSS for MCS 8-9: Rx=2, Tx=2
		EHT bw <= 80 MHz, max NSS for MCS 10-11: Rx=2, Tx=2
		EHT bw <= 80 MHz, max NSS for MCS 12-13: Rx=2, Tx=2
		EHT bw <= 160 MHz, max NSS for MCS 8-9: Rx=0, Tx=0
		EHT bw <= 160 MHz, max NSS for MCS 10-11: Rx=0, Tx=0
		EHT bw <= 160 MHz, max NSS for MCS 12-13: Rx=0, Tx=0
		EHT bw <= 320 MHz, max NSS for MCS 8-9: Rx=0, Tx=0
		EHT bw <= 320 MHz, max NSS for MCS 10-11: Rx=0, Tx=0
		EHT bw <= 320 MHz, max NSS for MCS 12-13: Rx=0, Tx=0
EHT PPE Thresholds: 0xc1 0x0e 0xe0 0x00 0x00

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/debugfs_sta.c | 185 +++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 607ba9367738..a3bd4fd0de7b 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -1239,6 +1239,190 @@ static ssize_t link_sta_he_capa_read(struct file *file, char __user *userbuf,
 }
 LINK_STA_OPS(he_capa);
 
+static ssize_t link_sta_eht_capa_read(struct file *file, char __user *userbuf,
+				      size_t count, loff_t *ppos)
+{
+	char *buf, *p;
+	size_t buf_sz = PAGE_SIZE;
+	struct link_sta_info *link_sta = file->private_data;
+	struct ieee80211_sta_eht_cap *bec = &link_sta->pub->eht_cap;
+	struct ieee80211_eht_cap_elem_fixed *fixed = &bec->eht_cap_elem;
+	struct ieee80211_eht_mcs_nss_supp *nss = &bec->eht_mcs_nss_supp;
+	u8 *cap;
+	int i;
+	ssize_t ret;
+	static const char *mcs_desc[] = { "0-7", "8-9", "10-11", "12-13"};
+
+	buf = kmalloc(buf_sz, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	p = buf;
+
+	p += scnprintf(p, buf_sz + buf - p, "EHT %ssupported\n",
+		       bec->has_eht ? "" : "not ");
+	if (!bec->has_eht)
+		goto out;
+
+	p += scnprintf(p, buf_sz + buf - p,
+		       "MAC-CAP: %#.2x %#.2x\n",
+		       fixed->mac_cap_info[0], fixed->mac_cap_info[1]);
+	p += scnprintf(p, buf_sz + buf - p,
+		       "PHY-CAP: %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x %#.2x\n",
+		       fixed->phy_cap_info[0], fixed->phy_cap_info[1],
+		       fixed->phy_cap_info[2], fixed->phy_cap_info[3],
+		       fixed->phy_cap_info[4], fixed->phy_cap_info[5],
+		       fixed->phy_cap_info[6], fixed->phy_cap_info[7],
+		       fixed->phy_cap_info[8]);
+
+#define PRINT(fmt, ...)							\
+	p += scnprintf(p, buf_sz + buf - p, "\t\t" fmt "\n",		\
+		       ##__VA_ARGS__)
+
+#define PFLAG(t, n, a, b)						\
+	do {								\
+		if (cap[n] & IEEE80211_EHT_##t##_CAP##n##_##a)		\
+			PRINT("%s", b);					\
+	} while (0)
+
+	cap = fixed->mac_cap_info;
+	PFLAG(MAC, 0, EPCS_PRIO_ACCESS, "EPCS-PRIO-ACCESS");
+	PFLAG(MAC, 0, OM_CONTROL, "OM-CONTROL");
+	PFLAG(MAC, 0, TRIG_TXOP_SHARING_MODE1, "TRIG-TXOP-SHARING-MODE1");
+	PFLAG(MAC, 0, TRIG_TXOP_SHARING_MODE2, "TRIG-TXOP-SHARING-MODE2");
+	PFLAG(MAC, 0, RESTRICTED_TWT, "RESTRICTED-TWT");
+	PFLAG(MAC, 0, SCS_TRAFFIC_DESC, "SCS-TRAFFIC-DESC");
+	switch ((cap[0] & 0xc0) >> 6) {
+	case IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_3895:
+		PRINT("MAX-MPDU-LEN: 3985");
+		break;
+	case IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_7991:
+		PRINT("MAX-MPDU-LEN: 7991");
+		break;
+	case IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454:
+		PRINT("MAX-MPDU-LEN: 11454");
+		break;
+	}
+
+	cap = fixed->phy_cap_info;
+	PFLAG(PHY, 0, 320MHZ_IN_6GHZ, "320MHZ-IN-6GHZ");
+	PFLAG(PHY, 0, 242_TONE_RU_GT20MHZ, "242-TONE-RU-GT20MHZ");
+	PFLAG(PHY, 0, NDP_4_EHT_LFT_32_GI, "NDP-4-EHT-LFT-32-GI");
+	PFLAG(PHY, 0, PARTIAL_BW_UL_MU_MIMO, "PARTIAL-BW-UL-MU-MIMO");
+	PFLAG(PHY, 0, SU_BEAMFORMER, "SU-BEAMFORMER");
+	PFLAG(PHY, 0, SU_BEAMFORMEE, "SU-BEAMFORMEE");
+	i = cap[0] >> 7;
+	i |= (cap[1] & 0x3) << 1;
+	PRINT("BEAMFORMEE-80-NSS: %i", i);
+	PRINT("BEAMFORMEE-160-NSS: %i", (cap[1] >> 2) & 0x7);
+	PRINT("BEAMFORMEE-320-NSS: %i", (cap[1] >> 5) & 0x7);
+	PRINT("SOUNDING-DIM-80-NSS: %i", (cap[2] & 0x7));
+	PRINT("SOUNDING-DIM-160-NSS: %i", (cap[2] >> 3) & 0x7);
+	i = cap[2] >> 6;
+	i |= (cap[3] & 0x1) << 3;
+	PRINT("SOUNDING-DIM-320-NSS: %i", i);
+
+	PFLAG(PHY, 3, NG_16_SU_FEEDBACK, "NG-16-SU-FEEDBACK");
+	PFLAG(PHY, 3, NG_16_MU_FEEDBACK, "NG-16-MU-FEEDBACK");
+	PFLAG(PHY, 3, CODEBOOK_4_2_SU_FDBK, "CODEBOOK-4-2-SU-FDBK");
+	PFLAG(PHY, 3, CODEBOOK_7_5_MU_FDBK, "CODEBOOK-7-5-MU-FDBK");
+	PFLAG(PHY, 3, TRIG_SU_BF_FDBK, "TRIG-SU-BF-FDBK");
+	PFLAG(PHY, 3, TRIG_MU_BF_PART_BW_FDBK, "TRIG-MU-BF-PART-BW-FDBK");
+	PFLAG(PHY, 3, TRIG_CQI_FDBK, "TRIG-CQI-FDBK");
+
+	PFLAG(PHY, 4, PART_BW_DL_MU_MIMO, "PART-BW-DL-MU-MIMO");
+	PFLAG(PHY, 4, PSR_SR_SUPP, "PSR-SR-SUPP");
+	PFLAG(PHY, 4, POWER_BOOST_FACT_SUPP, "POWER-BOOST-FACT-SUPP");
+	PFLAG(PHY, 4, EHT_MU_PPDU_4_EHT_LTF_08_GI, "EHT-MU-PPDU-4-EHT-LTF-08-GI");
+	PRINT("MAX_NC: %i", cap[4] >> 4);
+
+	PFLAG(PHY, 5, NON_TRIG_CQI_FEEDBACK, "NON-TRIG-CQI-FEEDBACK");
+	PFLAG(PHY, 5, TX_LESS_242_TONE_RU_SUPP, "TX-LESS-242-TONE-RU-SUPP");
+	PFLAG(PHY, 5, RX_LESS_242_TONE_RU_SUPP, "RX-LESS-242-TONE-RU-SUPP");
+	PFLAG(PHY, 5, PPE_THRESHOLD_PRESENT, "PPE_THRESHOLD_PRESENT");
+	switch (cap[5] >> 4 & 0x3) {
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_0US:
+		PRINT("NOMINAL_PKT_PAD: 0us");
+		break;
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_8US:
+		PRINT("NOMINAL_PKT_PAD: 8us");
+		break;
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US:
+		PRINT("NOMINAL_PKT_PAD: 16us");
+		break;
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_20US:
+		PRINT("NOMINAL_PKT_PAD: 20us");
+		break;
+	}
+	i = cap[5] >> 6;
+	i |= cap[6] & 0x7;
+	PRINT("MAX-NUM-SUPP-EHT-LTF: %i", i);
+	PFLAG(PHY, 5, SUPP_EXTRA_EHT_LTF, "SUPP-EXTRA-EHT-LTF");
+
+	i = (cap[6] >> 3) & 0xf;
+	PRINT("MCS15-SUPP-MASK: %i", i);
+	PFLAG(PHY, 6, EHT_DUP_6GHZ_SUPP, "EHT-DUP-6GHZ-SUPP");
+
+	PFLAG(PHY, 7, 20MHZ_STA_RX_NDP_WIDER_BW, "20MHZ-STA-RX-NDP-WIDER-BW");
+	PFLAG(PHY, 7, NON_OFDMA_UL_MU_MIMO_80MHZ, "NON-OFDMA-UL-MU-MIMO-80MHZ");
+	PFLAG(PHY, 7, NON_OFDMA_UL_MU_MIMO_160MHZ, "NON-OFDMA-UL-MU-MIMO-160MHZ");
+	PFLAG(PHY, 7, NON_OFDMA_UL_MU_MIMO_320MHZ, "NON-OFDMA-UL-MU-MIMO-320MHZ");
+	PFLAG(PHY, 7, MU_BEAMFORMER_80MHZ, "MU-BEAMFORMER-80MHZ");
+	PFLAG(PHY, 7, MU_BEAMFORMER_160MHZ, "MU-BEAMFORMER-160MHZ");
+	PFLAG(PHY, 7, MU_BEAMFORMER_320MHZ, "MU-BEAMFORMER-320MHZ");
+	PFLAG(PHY, 7, TB_SOUNDING_FDBK_RATE_LIMIT, "TB-SOUNDING-FDBK-RATE-LIMIT");
+
+	PFLAG(PHY, 8, RX_1024QAM_WIDER_BW_DL_OFDMA, "RX-1024QAM-WIDER-BW-DL-OFDMA");
+	PFLAG(PHY, 8, RX_4096QAM_WIDER_BW_DL_OFDMA, "RX-4096QAM-WIDER-BW-DL-OFDMA");
+
+#undef PFLAG
+
+	PRINT(""); /* newline */
+	if (!(link_sta->pub->he_cap.he_cap_elem.phy_cap_info[0] &
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
+		u8 *mcs_vals = (u8 *)(&nss->only_20mhz);
+
+		for (i = 0; i < 4; i++)
+			PRINT("EHT bw=20 MHz, max NSS for MCS %s: Rx=%u, Tx=%u",
+			      mcs_desc[i],
+			      mcs_vals[i] & 0xf, mcs_vals[i] >> 4);
+	} else {
+		u8 *mcs_vals = (u8 *)(&nss->bw._80);
+
+		for (i = 0; i < 3; i++)
+			PRINT("EHT bw <= 80 MHz, max NSS for MCS %s: Rx=%u, Tx=%u",
+			      mcs_desc[i + 1],
+			      mcs_vals[i] & 0xf, mcs_vals[i] >> 4);
+
+		mcs_vals = (u8 *)(&nss->bw._160);
+		for (i = 0; i < 3; i++)
+			PRINT("EHT bw <= 160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u",
+			      mcs_desc[i + 1],
+			      mcs_vals[i] & 0xf, mcs_vals[i] >> 4);
+
+		mcs_vals = (u8 *)(&nss->bw._320);
+		for (i = 0; i < 3; i++)
+			PRINT("EHT bw <= 320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u",
+			      mcs_desc[i + 1],
+			      mcs_vals[i] & 0xf, mcs_vals[i] >> 4);
+	}
+
+	if (cap[5] & IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) {
+		u8 ppe_size = ieee80211_eht_ppe_size(bec->eht_ppe_thres[0], cap);
+
+		p += scnprintf(p, buf_sz + buf - p, "EHT PPE Thresholds: ");
+		for (i = 0; i < ppe_size; i++)
+			p += scnprintf(p, buf_sz + buf - p, "0x%02x ",
+				       bec->eht_ppe_thres[i]);
+		PRINT(""); /* newline */
+	}
+
+out:
+	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	kfree(buf);
+	return ret;
+}
+LINK_STA_OPS(eht_capa);
+
 #define DEBUGFS_ADD(name) \
 	debugfs_create_file(#name, 0400, \
 		sta->debugfs_dir, sta, &sta_ ##name## _ops)
@@ -1333,6 +1517,7 @@ void ieee80211_link_sta_debugfs_add(struct link_sta_info *link_sta)
 	DEBUGFS_ADD(ht_capa);
 	DEBUGFS_ADD(vht_capa);
 	DEBUGFS_ADD(he_capa);
+	DEBUGFS_ADD(eht_capa);
 
 	DEBUGFS_ADD_COUNTER(rx_duplicates, rx_stats.num_duplicates);
 	DEBUGFS_ADD_COUNTER(rx_fragments, rx_stats.fragments);
-- 
2.40.0

