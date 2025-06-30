Return-Path: <linux-wireless+bounces-24643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60DAED33B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 06:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8392E7A47A0
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 04:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC41A841E;
	Mon, 30 Jun 2025 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P7fj5ShU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E82AF1B
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256942; cv=none; b=B9BroY6aZABKPHmm2/MeFLK/nOhtNaPw2yCD0RMJQQFgGkcA7InDEdqFcs+9od+ZWKbHSqLzjtYgNRxXhBDbJPQuud7el5zEwY4IM0bD7YHcnSO1ZS3GpHFBPiFmcCJcd+ajwQoKfoSXUc9aNhJnuz8vY+Bh3gjHfl95pWzK0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256942; c=relaxed/simple;
	bh=gId2u+fplwARN3H2Gx3Mt3u/2TqgZ8s8QJu0KktFhqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+W+q5KwWguibFhUQYXaz+s+VHOVNa3kKyhY3LrLHSLJcvl4vmTykgTLMXHi4qEmlJ/CwcBlaDTKqsQnUatpxTKyYUq/wLxFUZSU/dMx3bnuRqkdWPA1ygoC/vKVxnMCfElvWxhjcekGkROIwQAJVfwxIr3O9V0NWJib/hcOEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P7fj5ShU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TMJIDQ015587
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UdTye510OYDYG62A1JsNtJ9LFBEkO+WKF1r4hc3opg0=; b=P7fj5ShUWJgFqBXy
	DgGTo17iR+d6NhJrBlx99DEI25Zd6h0Vrfheqbgkc/YqkCtsXV2SJf0jkdiCLRam
	V6NYPtVEYge2UnfWHBP7ThZzPrej7HuhH8fceFToBn62UOgeasMeRCAaprUlmWkv
	/BD6iSmJp7Zkt08hWkAarBNwus5KnqScnOOu6EtN26Ue9g9AhCJAm7LE0S+9OFT4
	oPdFFJ348mKY4HZEQBI2aVH4jEMcllmzVL6e3L0p44B8Pne6yx1rVGVjXgh7sURN
	o/DLVhGem3f7AwRM5rO0j9tJ0EDPLBHN1grN5WknzhQRePUUtHq+e5/JaqZeV0LG
	8ckh9Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9jpu6dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:15:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2354ba59eb6so28176805ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jun 2025 21:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751256939; x=1751861739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdTye510OYDYG62A1JsNtJ9LFBEkO+WKF1r4hc3opg0=;
        b=uBE5BXumweraBkOabdILyK9nRDe37fZh27NpTM2ZuOEI/0aqXi6ZLv3WrSPkwsY7Xy
         dbWQXqL+0FfcVuKefi+66Y8tqOyuKxh/4oW5yP10zCw9KbZ0K0ExRXFkETOZurn0utJy
         KiUDiGATfahkbXU2fSkiO+arhs+ma5nXiOlYph0Epdkw/nrVNF1a6YEuYRE3WYXQ5bd3
         uxHGMjekff/Fi0UThL+zkKBvYIPi/V7NR75CBQgBrgocxjksaE1nxyEKyOuyesmmzuvH
         Y8zaAKV1HP5PvlxZWHyjfcEHbD7Y+2HyWh5k7b3FlVOOgkAt0y0iVBlDGmARHuBHZqDj
         fepw==
X-Gm-Message-State: AOJu0YxP2OQDODALhZSVd6fTRFFDe/VIVpgZty3EiecLJEk0QLJsbLpF
	RoFw/+4/uYR7uXqNQ584Em1wrnSVAJoia2KjKGPQ5wNOOdS7H+Bs9qstW3H9p/7Ie55jFj2lLWN
	RYZHg/4m2Z9X6KlfoTTERvWIUeJlpBpStbXCU8mke8pVYeilog9aQTJnLMzmkQroVV1FnoQ==
X-Gm-Gg: ASbGncvdj4Y1kNQ5uSNTAc3oI44NWV3wYL/fr77nMAUXfd7pWEJ3WGK44FwVr8n+t2a
	67T71+KHOmubji7dRW1ynqNhuybx6vW87wuiSInTguHqSy9sNrzvgr2F0KpRoUFFQL1gwLDCkb0
	0/TJsjf/KnU/8aoo0i35oCjxyNv791P7OJOIGQDE8a8cavIV/Z+lOkDtSr6P7WqbOGh6si5Uq4y
	3gM+pDoErEgM21mhAOFSkFaoJW4a3DBV2IaaFz2a7t5ceFgu4DnjOfTGtJPHxb7Q0r4StiDVMkE
	XmL44GupcvKwVQ1mYsWKyEMecYtIppGr/TusHjnu8tjfl4ihsW8dHvFcOejBMgCUD0+4G1xzV80
	ZX01uQ9BiAFxyvI/DAXFHPjPTiq3VeNSYKQ5SO1kJYW9q1cU=
X-Received: by 2002:a17:902:ea0e:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-23ac46580damr170504915ad.46.1751256938709;
        Sun, 29 Jun 2025 21:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9G96ApR0eBbaENnYeG1mS8KI5XaYp1Xqu3Vniu/Rg1UqzEY9srtAkAlTndfRFWKHOFEgZNA==
X-Received: by 2002:a17:902:ea0e:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-23ac46580damr170504535ad.46.1751256938319;
        Sun, 29 Jun 2025 21:15:38 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f069csm69366955ad.59.2025.06.29.21.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 21:15:38 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Mon, 30 Jun 2025 09:45:15 +0530
Subject: [PATCH ath-next 1/2] wifi: ath12k: add support for Tx Power
 insertion in RRM action frame
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-support-for-tx-power-insertion-v1-1-77f45484d5bb@oss.qualcomm.com>
References: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
In-Reply-To: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDAzMiBTYWx0ZWRfX0zFIr5HI/S5h
 n0C6LQXM/8IPVHjJgrDw69OWhaBvEkWvmfw5WabeFD4Eypa0IfzWxsL/FVW+WqxNzgtiZhXQgS/
 AvNGK7JLek3ne3hM2O1TWwA5Ykb66pXHysq67T744d7ZzcIcdZOW7Fxxr2jlUro237Y2r4xm6U3
 0o8qA8TYiNGptdszK4wx/l9Ph8un5UsbKBpsROTfHyVEJrWpUaixwwEcdG4OnNjF0l+b7zEVJ1h
 8GNW9me1hQTbgX8QRUz5hqXVQhYzN9QIgFWqbBPvck7nZYI/9W/hZuw+TQX6l8aTQdDJWRZZSDF
 M+oUxxOaeZzfLsmkNmh7qfDIYqFXoBQkWzABCeiDWs5mRKENX08eYvVoUlEN5ecvFYuXc5S7usK
 wTGGRQIObcCxkyEz1pf95f+qExprsYFheYUeUMmuKC4I4OC6i4j0z2CdSTzJD/rrPuB5oF9Z
X-Proofpoint-ORIG-GUID: Mvlv-xjccsmoVBV4a5K0obY0UBcyg0sq
X-Authority-Analysis: v=2.4 cv=Tq7mhCXh c=1 sm=1 tr=0 ts=68620f6b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=U2OQ5zEU71Qse62bi5cA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Mvlv-xjccsmoVBV4a5K0obY0UBcyg0sq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300032

For certain action frames like the TPC Report IE in the spectrum management
TPC Report action frame, and in the Radio Measurement Link Measurement
Report action frame there is a requirement to fill in the current
and max Tx power of the device in the packet.

Add support to populate these fields in the relevant packets.

In software-encrypted cases such as PMF, skip insertion since the packets
are already encrypted and cannot be modified.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 182 ++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 71e07c546a2dfce62101770ea54948df5db35060..241f11bd8c4051db4873d1109acbafa1aa9815c2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7807,6 +7807,174 @@ static void ath12k_mgmt_over_wmi_tx_purge(struct ath12k *ar)
 		ath12k_mgmt_over_wmi_tx_drop(ar, skb);
 }
 
+static int ath12k_mac_mgmt_action_frame_fill_elem_data(struct ath12k_link_vif *arvif,
+						       struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	u8 category, *buf, iv_len, action_code, dialog_token;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_chanctx_conf *conf;
+	int cur_tx_power, max_tx_power;
+	struct ath12k *ar = arvif->ar;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct wiphy *wiphy = hw->wiphy;
+	struct ath12k_skb_cb *skb_cb;
+	struct ieee80211_mgmt *mgmt;
+	unsigned int remaining_len;
+	bool has_protected;
+
+	lockdep_assert_wiphy(wiphy);
+
+	/* make sure category field is present */
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE)
+		return -EINVAL;
+
+	remaining_len = skb->len - IEEE80211_MIN_ACTION_SIZE;
+	has_protected = ieee80211_has_protected(hdr->frame_control);
+
+	/* In case of SW crypto and hdr protected (PMF), packet will already be encrypted,
+	 * we can't put in data in this case
+	 */
+	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
+	    has_protected)
+		return 0;
+
+	mgmt = (struct ieee80211_mgmt *)hdr;
+	buf = (u8 *)&mgmt->u.action;
+
+	/* FCTL_PROTECTED frame might have extra space added for HDR_LEN. Offset that
+	 * many bytes if it is there
+	 */
+	if (has_protected) {
+		skb_cb = ATH12K_SKB_CB(skb);
+
+		switch (skb_cb->cipher) {
+		/* Cipher suite having flag %IEEE80211_KEY_FLAG_GENERATE_IV_MGMT set in
+		 * key needs to be processed. See ath12k_install_key()
+		 */
+		case WLAN_CIPHER_SUITE_CCMP:
+		case WLAN_CIPHER_SUITE_CCMP_256:
+		case WLAN_CIPHER_SUITE_GCMP:
+		case WLAN_CIPHER_SUITE_GCMP_256:
+			iv_len = IEEE80211_CCMP_HDR_LEN;
+			break;
+		case WLAN_CIPHER_SUITE_TKIP:
+			iv_len = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (remaining_len < iv_len)
+			return -EINVAL;
+
+		buf += iv_len;
+		remaining_len -= iv_len;
+	}
+
+	category = *buf++;
+	/* category code is already taken care in %IEEE80211_MIN_ACTION_SIZE hence
+	 * no need to adjust remaining_len
+	 */
+
+	switch (category) {
+	case WLAN_CATEGORY_RADIO_MEASUREMENT:
+		/* need action code and dialog token */
+		if (remaining_len < 2)
+			return -EINVAL;
+
+		/* Packet Format:
+		 *	Action Code | Dialog Token | Variable Len (based on Action Code)
+		 */
+		action_code = *buf++;
+		dialog_token = *buf++;
+		remaining_len -= 2;
+
+		link_conf = ath12k_mac_get_link_bss_conf(arvif);
+		if (!link_conf) {
+			ath12k_warn(ar->ab,
+				    "failed to get bss link conf for vdev %d in RM handling\n",
+				    arvif->vdev_id);
+			return -EINVAL;
+		}
+
+		conf = wiphy_dereference(wiphy, link_conf->chanctx_conf);
+		if (!conf)
+			return -ENOENT;
+
+		cur_tx_power = link_conf->txpower;
+		max_tx_power = min(conf->def.chan->max_reg_power,
+				   (int)ar->max_tx_power / 2);
+
+		ath12k_mac_op_get_txpower(hw, arvif->ahvif->vif, arvif->link_id,
+					  &cur_tx_power);
+
+		switch (action_code) {
+		case WLAN_RM_ACTION_LINK_MEASUREMENT_REQUEST:
+			/* need variable fields to be present in len */
+			if (remaining_len < 2)
+				return -EINVAL;
+
+			/* Variable length format as defined in IEEE 802.11-2024,
+			 * Figure 9-1187-Link Measurement Request frame Action field
+			 * format.
+			 *	Transmit Power | Max Tx Power
+			 * We fill both of these.
+			 */
+			*buf++ = cur_tx_power;
+			*buf = max_tx_power;
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+				   "RRM: Link Measurement Req dialog_token %u cur_tx_power %d max_tx_power %d\n",
+				   dialog_token, cur_tx_power, max_tx_power);
+			break;
+		case WLAN_RM_ACTION_LINK_MEASUREMENT_REPORT:
+			/* need variable fields to be present in len */
+			if (remaining_len < 3)
+				return -EINVAL;
+
+			/* Variable length format as defined in IEEE 802.11-2024,
+			 * Figure 9-1188-Link Measurement Report frame Action field format
+			 *	TPC Report | Variable Fields
+			 *
+			 * TPC Report Format:
+			 *	Element ID | Len | Tx Power | Link Margin
+			 *
+			 * We fill Tx power in the TPC Report (2nd index)
+			 */
+			buf[2] = cur_tx_power;
+
+			/* TODO: At present, Link margin data is not present so can't
+			 * really fill it now. Once it is available, it can be added
+			 * here
+			 */
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+				   "RRM: Link Measurement Report dialog_token %u cur_tx_power %d\n",
+				   dialog_token, cur_tx_power);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		/* nothing to fill */
+		return 0;
+	}
+
+	return 0;
+}
+
+static int ath12k_mac_mgmt_frame_fill_elem_data(struct ath12k_link_vif *arvif,
+						struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+	if (!ieee80211_is_action(hdr->frame_control))
+		return 0;
+
+	return ath12k_mac_mgmt_action_frame_fill_elem_data(arvif, skb);
+}
+
 static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ath12k *ar = container_of(work, struct ath12k, wmi_mgmt_tx_work);
@@ -7838,6 +8006,20 @@ static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work
 
 		arvif = wiphy_dereference(ah->hw->wiphy, ahvif->link[skb_cb->link_id]);
 		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id)) {
+			/* Fill in the data which is required to be filled by the driver
+			 * For example: Max Tx power in Link Measurement Request/Report
+			 */
+			ret = ath12k_mac_mgmt_frame_fill_elem_data(arvif, skb);
+			if (ret) {
+				/* If we couldn't fill the data due to any reason,
+				 * let's not discard transmitting the packet.
+				 * For example: Software crypto and PMF case
+				 */
+				ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+					   "Failed to fill the required data for the mgmt packet err %d\n",
+					   ret);
+			}
+
 			ret = ath12k_mac_mgmt_tx_wmi(ar, arvif, skb);
 			if (ret) {
 				ath12k_warn(ar->ab, "failed to tx mgmt frame, vdev_id %d :%d\n",

-- 
2.34.1


