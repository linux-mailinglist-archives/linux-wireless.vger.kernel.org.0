Return-Path: <linux-wireless+bounces-29667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC50DCB5EA6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22C3C304FFDD
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D431063B;
	Thu, 11 Dec 2025 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="juV+MUJk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZalfJid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B93101A0
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456910; cv=none; b=ajidGXahn7W1PsZYkp/Zwfx+DcC2zR2ke+hAzS32e3c8O8xX62Ot+FTrMMNslBOiZukVNCwnV0ByFfzJRRv+EzolAxKNN10guUIe2H3V3vCoK/TspJfzrszF1NXS6qk8QeXpzwThE7kFKQtdhsyCmu93zkE2CvFHItxBSGGamt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456910; c=relaxed/simple;
	bh=QdeDD7lV7OW1PWJICgftZv90s3y5cbY/z/3bqwpO/kY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VVBzmKHXbeiW4U/VvIns1w/n5VnGZpkFtid2aIVOBGXBnLUqwCTcbSRDhSJ5yuRa/LHkb4g00lte5BDbnau+bZYgcwanvJBKXbxzkplDCu6pROmAhvsYRoBXAp9H52BTQvz228+K2L0jmfJTltaUDkVbDsE7zcMCll9BS7cXe2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=juV+MUJk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UZalfJid; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXtNR673616
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RnMGu7smMCl
	QbSsVOpYFwfGvVfskaXoeGQoT/UevPgo=; b=juV+MUJkxrUBsEjaj0Qa7MF5A2r
	kUf7N4Ru7eX/IXo/moQw3UGpE6QDzgHu31NDyYh+fbYaGnSy1Uois2DrormUX6Ao
	pBxFYiE7NMW+qetg2t/VitfPmfYZpYhdiBhoMeH3DyALJGYfBfCJiY6l9nfyT7Ev
	21/PqMwUq01slAtmhe+Jkp+3sANRmT71NKohkWVn+74IdVZ0zACXOs1uZa/4F9QD
	OK5YSU6yRZZwpGA6aqXf6hpA8UPmAlJl4bvAVSN3IEMnS4KSD6qiDnlg2wdM9HWJ
	ZXoq9YSzf4lg46qhnQkT9TUVyNdL5dYeq9+KbXRTMhK/XbX6EKu/QEPpfbw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aytwj8r0t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3437f0760daso37058a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456907; x=1766061707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnMGu7smMClQbSsVOpYFwfGvVfskaXoeGQoT/UevPgo=;
        b=UZalfJidlaNiCgtqdzZHAc0ni3BU1Lbi4HmN7xNrMoZwwrpu+zfZvJPNQoc4Hk2lsh
         R9EzluAmyW0YJHGJ8fwTXSweYP98kUvfv0yDPTSImfNEwxmL8gX3Ns3d30YzYeglu+Fe
         Iz2qNkq6PYbgPJj4d8br+l+HIbelbq2+Uc4dOiXLl3YwvcQ5fjmSolX6l956UxiFWYge
         GIxbWTdOwYjzD/zl5abO1SzAkwxkQbaL2i0VRPrlI3g/8dhIWmDN7PdTGUUDB2MjqSFc
         S05zUESi7NJCnvLW8mnVEXNRvlPRsBEu6XdRoQuDw4UtP0a8scYT5rOVs7lORIUeES8d
         s6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456907; x=1766061707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnMGu7smMClQbSsVOpYFwfGvVfskaXoeGQoT/UevPgo=;
        b=YOHKI9cCu5JOSkzrLBkI33UHehbvPFDnj4u5hr9YfQUmKiGKkC0VjsQehjQHkPS4sJ
         qRE6nvGryRrIM9tSyw9xIeuoChEUTuyRSn6XLIPR2/lXIyremX5npOEaFcWtwUMK/8F3
         PLnEpcF+pylPkMI+ZjesW5a5pvTlB36SVriwD0wksQSRKVEsNVTuZ9peP4F+Oa8PVOAO
         O3nHdNqtJYIoErB6q4IFHT6F3Wvlo2WMys4lhxXoLljr7Q3/dE5xj9Q2fI+njNHBDwCa
         ytQ/iNIxaFOsW4/3g2Eh8l1RFD7Xz+I+QQ25OqoRwLlBpdx2midUlGUjYQtCoev8DdmN
         LWDg==
X-Gm-Message-State: AOJu0YyZgp3U5IQJsI9WVwQ+Uf5dGyBcm3PKnRNZatgcRI9+pXqWLHqT
	KkB0hSGKTpf8sHgKtQufYO1BQUrwYjRS04l1ESaztZ/9lsxJenztAw2D59/CKMjtm854RGpucej
	gtjNXzJt9yRnoMSoDsDRQz8c09xRWRi8l4Bv/pU/CNWxb6dMmDYBVaKKttag4kuRnSoF9OA==
X-Gm-Gg: AY/fxX4qacU9jDLyzrulwm+eXispK1w1DzxP39CfXnlRcaJjfuXzkhbgOd27Rrbh7FV
	SZWVOrDZtzBaHwrcw4N/sS5mv/24gfg96XrvJpvaEqwm8dqvKLDBNUSMd5nW0iSJ0o3H/38euXk
	bj8lPi59vLlKbg+grR/8Zmc8F1XrvxXD1yYxC1RFJeKYsDpDvvzR1WFAR6dWco7EFmfa44VmdKc
	9vPRIUzjXUcqK7TVOFZc5aZ5nLJkW0hBMc/5AviSAMNv84fVrSv2JWFRV9RB2coQSsAvrq9BHRr
	w2EpWnfcG0zl0Tei5ot2mCom5lYVrmrM+Y/bqEzMoi0SKY3KX4VWjVLTpxF6zVkeN/gnJmQdjem
	aVwvcixa5rYAzFjUPFg14SU4eDT406Z9GA+KRotHaJw==
X-Received: by 2002:a05:6a20:918f:b0:366:14ac:e1d7 with SMTP id adf61e73a8af0-366e31b504cmr6249297637.61.1765456906527;
        Thu, 11 Dec 2025 04:41:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZaLQRpA+biSCYoNlJKgU7PqciUxo7T93gPLofHDsZW2RrYJpRC9V2gPtSp2pyVGmp5u42PA==
X-Received: by 2002:a05:6a20:918f:b0:366:14ac:e1d7 with SMTP id adf61e73a8af0-366e31b504cmr6249276637.61.1765456906012;
        Thu, 11 Dec 2025 04:41:46 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:45 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 13/14] wifi: mac80211: Support for encryption/decryption of (Re)Association frames for AP mode
Date: Thu, 11 Dec 2025 18:10:50 +0530
Message-Id: <20251211124051.3094878-14-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ybs0BkX5SfPbBzwGOrGh6_1ShL5OZWmI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX4GupooRyL1Fv
 qRuu3BIjZcDyoRgHFPMjwXLcDOFAtDOo5h4pGmM+ICYxehbQ0K4qOdcVwYmx7LxzGGsOWrNC+8M
 8K2z6CsCn4GFJS0yCwvjZxH7d3vsT/TFDmPBVIBCrsoI81kMntAZlijgZRLwF0hShN3GkWeRvuH
 4GYYEKRDIivVLKJyZ0PObRgZC0y0TGyKKvyTA5Xezcn+4wlzIxsAeIFUlHpHNM9z1zhMqxo9ior
 vg6sYGkdRBvlAktd0Z9i3TRu6ruBX3RmbWhg8WQ6xuM+RKX1CQb6BTJ1zS3jDT79i+BXTk1BlE2
 8IvyjAQaJvCrDH5BHHAZxjYF9SdQMtORhxt9RKfB+i8ewlbGoE9VG/VoE8Dn1lLOcw3ymKHHNsb
 TMYhiceu6S3gtcjA68W1oaRt1/b8HA==
X-Authority-Analysis: v=2.4 cv=YokChoYX c=1 sm=1 tr=0 ts=693abc0b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=M2-2voBrbRgbOWl0GisA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Ybs0BkX5SfPbBzwGOrGh6_1ShL5OZWmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

From: Sai Pratyusha Magam <quic_smagam@quicinc.com>

If pairwise key is found to be installed for the EPP enabled station,
allow the tx key to be populated. In the presence of the pairwise key,
this adds support for encryption/decryption of the (Re)Association
Request/Response frames.

Co-developed-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <quic_smagam@quicinc.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/rx.c  | 6 ++++--
 net/mac80211/tx.c  | 6 +++++-
 net/mac80211/wpa.c | 8 ++++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index bd2d57b4360e..65183367a08c 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2610,12 +2610,14 @@ ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 		return RX_DROP_U_UNPROT_ROBUST_ACTION;
 
 	/*
-	 * Drop unprotected (Re)Association Response frame received from
+	 * Drop unprotected (Re)Association Request/Response frame received from
 	 * an EPP Peer.
 	 */
 	if (!ieee80211_has_protected(fc) &&
 	    (ieee80211_epp_assoc_resp(fc, rx->sta) ||
-	     ieee80211_epp_reassoc_resp(fc, rx->sta)))
+	     ieee80211_epp_reassoc_resp(fc, rx->sta) ||
+	     ieee80211_epp_assoc_req(fc, rx->sta) ||
+	     ieee80211_epp_reassoc_req(fc, rx->sta)))
 		return RX_DROP_U_UNPROT_UCAST_MGMT;
 
 	return RX_CONTINUE;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index de117663cb6a..36f77e4f7c0d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -644,7 +644,11 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 			    !ieee80211_epp_assoc_req(hdr->frame_control,
 						     tx->sta) &&
 			    !ieee80211_epp_reassoc_req(hdr->frame_control,
-						       tx->sta))
+						       tx->sta) &&
+			    !ieee80211_epp_assoc_resp(hdr->frame_control,
+						      tx->sta) &&
+			    !ieee80211_epp_reassoc_resp(hdr->frame_control,
+							tx->sta))
 				tx->key = NULL;
 			else
 				skip_hw = (tx->key->conf.flags &
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 660d5bac2188..43617b77e0a2 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -529,7 +529,9 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 	if (!ieee80211_is_data(hdr->frame_control) &&
 	    !ieee80211_is_robust_mgmt_frame(skb) &&
 	    !ieee80211_epp_assoc_resp(hdr->frame_control, rx->sta) &&
-	    !ieee80211_epp_reassoc_resp(hdr->frame_control, rx->sta))
+	    !ieee80211_epp_reassoc_resp(hdr->frame_control, rx->sta) &&
+	    !ieee80211_epp_assoc_req(hdr->frame_control, rx->sta) &&
+	    !ieee80211_epp_reassoc_req(hdr->frame_control, rx->sta))
 		return RX_CONTINUE;
 
 	if (status->flag & RX_FLAG_DECRYPTED) {
@@ -727,7 +729,9 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 	if (!ieee80211_is_data(hdr->frame_control) &&
 	    !ieee80211_is_robust_mgmt_frame(skb) &&
 	    !ieee80211_epp_assoc_resp(hdr->frame_control, rx->sta) &&
-	    !ieee80211_epp_reassoc_resp(hdr->frame_control, rx->sta))
+	    !ieee80211_epp_reassoc_resp(hdr->frame_control, rx->sta) &&
+	    !ieee80211_epp_assoc_req(hdr->frame_control, rx->sta) &&
+	    !ieee80211_epp_reassoc_req(hdr->frame_control, rx->sta))
 		return RX_CONTINUE;
 
 	if (status->flag & RX_FLAG_DECRYPTED) {
-- 
2.34.1


