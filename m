Return-Path: <linux-wireless+bounces-28007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42CDBE6445
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 06:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B365622A1C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 04:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06DF30EF9D;
	Fri, 17 Oct 2025 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThTAtmGc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2A30C37D
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674099; cv=none; b=pZi3I6fTJw5cO9s7qZWyI/IjMSyGSefnhKa7sSXLw2pfNfR1Hb0/sCQGMQ22X/H4st5UyKTAR8dy2weUjKJ7cINeJoiSGyLCKUMQv16I5lmmVDMpVVbLxNxPQvsSv3XVCpgZSE+nxDAfQ0BoVA26qGFhHVc4rFh94zwC24bhIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674099; c=relaxed/simple;
	bh=Jc3WcMYm9z1rzFSWkpg1DGFRH0PcKnzZH2dfx2eVJ3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sl1rB+FDDzUZPcjFwXepYdtM+bL0C2euatuqKpjeMOS0yOVb3bXxVxSd9ceyEcSvKQIKJNDoxdLHUisM3jsVDADC8kGZG9bTa1IHv7UvYqPZNeX1wmMNf4Ug8SYw4JFXHwS+g0T3yj8GqmgyciU0Qb1bBOCdiVcjS0CvrWtEUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThTAtmGc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLWpQ020342
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	asdZZKjyk0fwGLdaYXPlNfa31eWk+R36oHWV8aFgJSY=; b=ThTAtmGcdpJlA5Iu
	0VVpNooDZ7YMhimleUcUOHwbkxt5UN8/Gro4pOjBMjlr/J7/5QvZdvYRyrtHosTF
	JP8SjW6iUyo034TH98H/wBu4TPJyzitz20cxdGjD5tRGJ5RpSgEHz/U7gu9TfXm/
	mR+fZbDRvNrJfskXZFDDZZ4U9Qtgco4cZHn6FI2/oDvxJzM9NTieOVCQU6g7Wp1p
	Vi8W43cgztWJMWodvTs9lXjVI0fYNq5fkGJjUX94TEtz1zeOc9/k53c2UG8t3cz9
	oYr5kQ8G0SBszhYe0H5TXwKYnsmjC+ztBoEWEreFcCAKXbf2QK99KFVv3GhLw09L
	NUiquA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpm64c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27eca7298d9so32652985ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 21:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674095; x=1761278895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asdZZKjyk0fwGLdaYXPlNfa31eWk+R36oHWV8aFgJSY=;
        b=oIqmo/8KmA74LKukr5F3mnAHMgQBoTV0QP135sMo00A4L/dkLMGIdI8iYZD/1g3z9r
         Yd2FmKbE9XcJcd/5gM73IZEeiVrJNN8sxWgpMUsH4L1GLrRrzlgCwDLTb4Ngg9FF668S
         kkYBM98HzbpSuNaw4zMrJ5f4twnei34FteSZrFpwQRPcYsPNRE6ri8kLsP5Nv+zv1P4G
         dzOGZeiYKge1oRG2HHLm7iWN3fcbcRcdnnColQW8xxi2CUU+wTCat5tSExaVsQUQH08X
         33VO6/apGx5wLSzs7bEHGQAhJDi0mYHxH/46/rhJSo9a8JfCKP9nchDocyKXlRO8A/Tu
         GgpQ==
X-Gm-Message-State: AOJu0Yy+/oXic3DvKRhNFaS+SoOKyLAOTejg30/oZ1ogXRW0D32O9D6/
	Uwo0XZhAUeOil1DKnGCaju3Oc8MF5kSLJsRqcp/mG/TEt81GM35MZT9l0GPVreQPIwDZV4hy7LP
	FiR8DRIhE/jHD3JqwOGK0tRPGFnmSY/4CX+b9KXB63GmrWB6tqxUxi/O3D+zA1mlDouO3cw==
X-Gm-Gg: ASbGnctrzcXFmIMbyskZIZ5y7ZgVTZWLsTnGmdlGuqnbXsUVjPDYfKiJt2Vpjxp7nYu
	nwhrY2o/v+iBAeQYRL+CKV/QjSIkERMEzpxXL7nFUTjzSB/eW8uc4Bmx+qbPXebc0gjuWxfDL7I
	f+PCL3JeUi5ouNjMchAEoeesyXFawLnJb4D1k9jQr69xR629oknVQEgJoySIsC414gqrl+17L4w
	AyRqt99uuVlzcLPytoxjjj4Eo6cEHFoheuC8MtfDgJFwPVVR8VwLE7woYllDRkXCcylGci6DwPm
	VX/ZrP+hX9zBCe24Usk20UaYxCJCY3WGyYaWM2VyX4HI7PN8xbmWa0bwk5mF0mNHWrpQI25onfW
	C6ahvlHSuooYTKpB8/RSubf9SCottrqLTNkwo1q5xrtz+Ybv17w+v5mewl3V+/n0jRKBJTSqn+e
	NltXlb4Y13kQ/KRsgAk48NmyE=
X-Received: by 2002:a17:903:19cf:b0:27b:472e:3a22 with SMTP id d9443c01a7336-290cc6da03emr27126935ad.56.1760674095314;
        Thu, 16 Oct 2025 21:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSFzb7wjzoXwJcRXVoLB6Wm6cPtg9l7YEyvW8Iduat+Gr7L4HFg6g+CmISuItqlx3N8AR1nw==
X-Received: by 2002:a17:903:19cf:b0:27b:472e:3a22 with SMTP id d9443c01a7336-290cc6da03emr27126655ad.56.1760674094879;
        Thu, 16 Oct 2025 21:08:14 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7afcbsm47635345ad.76.2025.10.16.21.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:08:14 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:37:59 +0530
Subject: [PATCH ath-next 3/4] wifi: ath11k: add support for Tx Power
 insertion in RRM action frame
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-add_tx_power_insertion_support-v1-3-f08feacfca93@oss.qualcomm.com>
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f1c130 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=U2OQ5zEU71Qse62bi5cA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX5XaK+nHausTg
 wzm2+Pdx/AEMHufvUL9oyItz19rky901pBsUWhhYmkGHXcwsZ0WZFbu7tg0ouTDMLQqPLaQNU0o
 yojpxTkAiUkJ4OJQUwMHA5sH2DTRweKr9ftuMEq2V07b8mpkPpj5d980pVkttbvvVjxrmV8kG93
 TZRKGg0LxOLT8Wu5SaZhFqfYmcj9QTAqf2J+Nktdn1J8rltm816B1hSv5kMBsKI/6VGs1GsBGOw
 kbRNvwXoj9JSGBhcV9bpUOXzdSMiL62I6aABqTu6MUh2AVQAxGBzrh5Pcn1sPG/uHjOYUWKVE2i
 g7KLPkN4u6KW/mowawqA1CbBdBnX/+Tu+G0knEkKgsuhkaWkU6rEYPSwVTEpX8mN4nCxUI+DcDH
 2wPgFGNpWvopeDYWasAcDlfZGhRZKA==
X-Proofpoint-ORIG-GUID: FpI6tnoCiNS51wKO4H2Pl-c172J0RS2E
X-Proofpoint-GUID: FpI6tnoCiNS51wKO4H2Pl-c172J0RS2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

For certain action frames like the TPC Report IE in the spectrum management
TPC Report action frame, and in the Radio Measurement Link Measurement
Report action frame there is a requirement to fill in the current
and max Tx power of the device in the packet.

Add support to populate these fields in the relevant packets.

In software-encrypted cases such as PMF, skip insertion since the packets
are already encrypted and cannot be modified.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 166 ++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cd6e98ee1232..773ea1d4b358 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6251,6 +6251,159 @@ static void ath11k_mgmt_over_wmi_tx_purge(struct ath11k *ar)
 		ath11k_mgmt_over_wmi_tx_drop(ar, skb);
 }
 
+static int ath11k_mac_mgmt_action_frame_fill_elem_data(struct ath11k_vif *arvif,
+						       struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	u8 category, *buf, iv_len, action_code, dialog_token;
+	int cur_tx_power, max_tx_power;
+	struct ath11k *ar = arvif->ar;
+	struct cfg80211_chan_def def;
+	struct ath11k_skb_cb *skb_cb;
+	struct ieee80211_mgmt *mgmt;
+	unsigned int remaining_len;
+	bool has_protected;
+
+	lockdep_assert_held(&ar->conf_mutex);
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
+	if (test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
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
+		skb_cb = ATH11K_SKB_CB(skb);
+
+		switch (skb_cb->cipher) {
+		/* Cipher suite having flag %IEEE80211_KEY_FLAG_GENERATE_IV_MGMT set in
+		 * key needs to be processed. See ath11k_install_key()
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
+		if (ath11k_mac_vif_chan(arvif->vif, &def))
+			return -ENOENT;
+
+		cur_tx_power = arvif->vif->bss_conf.txpower;
+		max_tx_power = min(def.chan->max_reg_power, (int)ar->max_tx_power / 2);
+		ath11k_mac_handle_get_txpower(ar, arvif->vif, &cur_tx_power);
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
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
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
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
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
+static int ath11k_mac_mgmt_frame_fill_elem_data(struct ath11k_vif *arvif,
+						struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+	if (!ieee80211_is_action(hdr->frame_control))
+		return 0;
+
+	return ath11k_mac_mgmt_action_frame_fill_elem_data(arvif, skb);
+}
+
 static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 {
 	struct ath11k *ar = container_of(work, struct ath11k, wmi_mgmt_tx_work);
@@ -6270,6 +6423,19 @@ static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 		arvif = ath11k_vif_to_arvif(skb_cb->vif);
 		mutex_lock(&ar->conf_mutex);
 		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id)) {
+			/* Fill in the data which is required to be filled by the driver
+			 * For example: Max Tx power in Link Measurement Request/Report
+			 */
+			ret = ath11k_mac_mgmt_frame_fill_elem_data(arvif, skb);
+			if (ret) {
+				/* If we couldn't fill the data due to any reason,
+				 * let's not discard transmitting the packet.
+				 */
+				ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+					   "Failed to fill the required data for the mgmt packet err %d\n",
+					   ret);
+			}
+
 			ret = ath11k_mac_mgmt_tx_wmi(ar, arvif, skb);
 			if (ret) {
 				ath11k_warn(ar->ab, "failed to tx mgmt frame, vdev_id %d :%d\n",

-- 
2.34.1


