Return-Path: <linux-wireless+bounces-29777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E738CC1254
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D21B302B77E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262FC343207;
	Tue, 16 Dec 2025 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dW9Jdetz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iqA31NUH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56AA341ACC
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866454; cv=none; b=hh4eLzPwfvsFiaathOJj3Motu+uCe6ZFjoKgvFgJI7pnG1J9ajb4OhK7/Ysi7wcEOxc+VlFtOmnblcah+0Xi1mMxjiCIiTbfj6XdC4Dyzn/xbrTUMpVzGE8MLMFQ8r3jJ5XQumMxBjZyTdCcAkcfcfosNLakLTL7r/MCfNdyLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866454; c=relaxed/simple;
	bh=wKgZrGnMTdxRajpOpry0LtXKbdY6p1JF2w+QraCyc2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j14i1DidCGmR/Ss4MqsdGnz6wrQEN5EkkwyQaq9XxYj0xUNQFbhu8XHHX2xFTD/25fQT8+cpvqzbUm3gU3sPbs48nR4TNpIFYPj9vD1fvyW94rxZ0rvSL+YHPm8twtK+rVIQvIa5kBx1ZI7Zo41wYfc7wb/SMMuZccS3QjZPLeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dW9Jdetz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iqA31NUH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG2bRm81756137
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=w7rtXsnBhR1
	yxHkGWkamVfhKWOyjTemCSrlEADgYB4o=; b=dW9Jdetz/lKj4pkv6o5/fQCrbA1
	HJ1j75QsgxgbXm2s/4cTB4kLo+KKWxrJfN0P2QVyjiZt0KbaZVr+TttimngZZ5eu
	R523a9AfpriI8fB3N89cBoNQPimcY78rTzqHNeuxzYKXAQqYiaOgV6gff86PM9F4
	ynlX88FGjAUH2AzfMTxtHR1KL3t3w0jmLWc4ysaC4nIrCsdd9FCMmc4u259+ouP4
	/vvCzMTgYCJF20aA6qqm3zwayfxG7dv29f4nQKniRdnKwnXCRo45Hw/iyfV6j39O
	Ww6OtLa6K5NOElaZKcy/Sre40unlRLx7OSDnkMa2WwknpnLwn0gKEBUnY8A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2peract1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f8e6a5de4so38373695ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866441; x=1766471241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7rtXsnBhR1yxHkGWkamVfhKWOyjTemCSrlEADgYB4o=;
        b=iqA31NUHr2FyuASJ+mm8JlowK9wFzohqAfhT6n9Hu667RZviVH/NI0fFghqGxPKFO6
         +xX00tJ+QRIbsAY6NN5EOmtqF49NgzEHAfCmAlYjZZdq6zqs58JmIo2uFE3X2g7MQe1b
         MhRnSuRsJZd3Luf6TwvBWvk10D+uu/u0U4ghiEuQs0/iM+8nosbvsGO6TddgqxS2bNsF
         LyAJ3fMH6tfRSfCWB2261DPWOe/G/R/YS05smTbcXFJ0r7AoyglQGoOWsDsovHgxeLsB
         2BYn8wnsxSZbPShShmfj6PI6cia4Iv0bkG2EeVmO1F/bBzFAgcWBctmJNnuYosKwkWIR
         X8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866441; x=1766471241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w7rtXsnBhR1yxHkGWkamVfhKWOyjTemCSrlEADgYB4o=;
        b=vASDySLFvxVg20shnpUtr/6/X/qicj/Hk8eRE925XiysMSVXbsB0ndRDHbK1QDw8qM
         DdlNntXtPqWk8VQkGVUHAwTSSqTyv+bHE++YWHDzWhUqpGjgq60sSE2U0e0Keb5fvxss
         XT7k8AAQgZD7Gh4/FFCRvT6lYVXq61RHk+Y79Ols2RhpJFbufnlNKckN1EyrPMU98v74
         TB89a42j45qrFHT7/rUT3mE4lz6jYNhbstiTq4RIo1mJjs6OpJcUSYwFfK5yTzYwFnz+
         f2D8NruwYMGe0XA7wB3/L3bJrgHDVs4WZ3L+emyhjN7uq0dI8PCZ+//4cdrtwAT0xlt+
         LAdQ==
X-Gm-Message-State: AOJu0YwC/bZkPb57cDgququI4PpqffzS0KvAoCalSKztEUkPDBpmpb4e
	IxqEO2ReXLhdpG08czlEuzsolJA3C8FoFoiIPYrinizdPxWobx433XzwemggDOZ3Dt3VCWTGuc6
	4pkXcQZqZ79auYtMvZKg7utErQLlJlBS0YZ3H4r7cOrYTKsEWYxzNHu+TxHvAkvL3CkgXlpVZGS
	fzIg==
X-Gm-Gg: AY/fxX4TG6dqt44RqAMcwjWOO1/CAglUEA/X/XRXrEAqc1vV8SdoJpUAWWDVDHE9+Fb
	Z2Ag6rwIAKVEsCPT5dnc3JWVQZRGQffittvsauBxkls0QtTK7kF7xygq7itB4ooTf+ClEwZnZkS
	Si2bXFx6xN0CUBYswKIrMoC3e6B5aSK6MOKt0YVx5HpLhsDEy2TknhHQzfAQ9HItGojxUVFjn2i
	ostfGLnE4tXUm0DVibOzeJM7pIZ/jEnymty5FZ0JjzGVP8HQA7cNJH86OIv7HHZIg/A9xYQbSOG
	dlcYrYHsbvqeLzvu1Cthi0Ri35/Z3JufrxCvtTXXnY40qvmGR5wgEFU3OjON8oIzyuN5U/lAznu
	6OK/weWCFbjZ6/4DGxdu/93QKQt4/REno/6O814arMHr5djAXTjayXg==
X-Received: by 2002:a17:902:da8c:b0:2a0:b02b:210a with SMTP id d9443c01a7336-2a0b02b2272mr92262425ad.37.1765866441190;
        Mon, 15 Dec 2025 22:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENyghWeRsZ0OrszPyO6c2o/1P5aia5CcIfLrt8PaKljpp2VGpdKJRdQWFeyh7uKAOMntJ85w==
X-Received: by 2002:a17:902:da8c:b0:2a0:b02b:210a with SMTP id d9443c01a7336-2a0b02b2272mr92262045ad.37.1765866440693;
        Mon, 15 Dec 2025 22:27:20 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:20 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 03/13] wifi: cfg80211: Add data structures to capture UHR capabilities
Date: Tue, 16 Dec 2025 11:56:46 +0530
Message-Id: <20251216062656.1738022-4-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eNwEghM8e_xc2qFgXTZquOtIw0ZgmwGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX/PRuj6xjcw2Z
 uyJl87mjkVONo8M5Bm1H1ZGwWQJhWE7ltoTsxSr8cqKCiT27KijmQAj4SG34vHuYQD7g+kTdvJ4
 V6sxdzeUmgzq3FSvKxGgsoqknyhsW/1n/RHPZnDlIGvLHha5WtqiRJaBGBwKfQTsO2PyaABUDs/
 ZSc9N+xoxLeB9329OOtSEUUfMwfpbLU77Bz5RV+X/OsG9HJI7GB9Dp0uuqln3uY9wM4F0AqxMZT
 S0KXhgU+4Xd/ZZNkCgI1dGMF9b9GmUYDiEsdzu5xSD/0Tv+y0b2Pbnf2WSNEo9pSEjuHQdKKtok
 QFBQyVmdULtNUu2my6jF4ATSbptkTo/qKZs0WSnCeHhC7lXs5pmpDjKww9VTxGh94A+9vLhRaKx
 4lEfX7nrIMjyyXD0Osgb2E2q2uwx4g==
X-Proofpoint-GUID: eNwEghM8e_xc2qFgXTZquOtIw0ZgmwGr
X-Authority-Analysis: v=2.4 cv=PYHyRyhd c=1 sm=1 tr=0 ts=6940fbca cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SNSM3LDD58Q2ToA1RzUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

Add data structures to capture UHR capabilities and advertise UHR
capabilities to user space when supported via NL attributes.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 16 ++++++++++++++++
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       | 11 +++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 899f267b7cf9..378fd54c282c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -429,6 +429,20 @@ struct ieee80211_sta_eht_cap {
 	u8 eht_ppe_thres[IEEE80211_EHT_PPE_THRES_MAX_LEN];
 };
 
+/**
+ * struct ieee80211_sta_uhr_cap - STA's UHR capabilities
+ *
+ * This structure describes most essential parameters needed
+ * to describe 802.11bn UHR capabilities for a STA.
+ *
+ * @has_uhr: true if UHR data is valid.
+ * @uhr_cap_elem: Fixed portion of the uhr capabilities element.
+ */
+struct ieee80211_sta_uhr_cap {
+	bool has_uhr;
+	struct ieee80211_uhr_cap_elem_fixed uhr_cap_elem;
+};
+
 /* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
 /*
@@ -454,6 +468,7 @@ struct ieee80211_sta_eht_cap {
  * @he_6ghz_capa: HE 6 GHz capabilities, must be filled in for a
  *	6 GHz band channel (and 0 may be valid value).
  * @eht_cap: STA's EHT capabilities
+ * @uhr_cap: STA's UHR capabilities
  * @vendor_elems: vendor element(s) to advertise
  * @vendor_elems.data: vendor element(s) data
  * @vendor_elems.len: vendor element(s) length
@@ -463,6 +478,7 @@ struct ieee80211_sband_iftype_data {
 	struct ieee80211_sta_he_cap he_cap;
 	struct ieee80211_he_6ghz_capa he_6ghz_capa;
 	struct ieee80211_sta_eht_cap eht_cap;
+	struct ieee80211_sta_uhr_cap uhr_cap;
 	struct {
 		const u8 *data;
 		unsigned int len;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8134f10e4e6c..8d9038ba1208 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4248,6 +4248,10 @@ enum nl80211_mpath_info {
  *	capabilities element
  * @NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE: EHT PPE thresholds information as
  *	defined in EHT capabilities element
+ * @NL80211_BAND_IFTYPE_ATTR_UHR_CAP_MAC: UHR MAC capabilities as in UHR
+ *	capabilities element
+ * @NL80211_BAND_IFTYPE_ATTR_UHR_CAP_PHY: UHR PHY capabilities as in UHR
+ *	capabilities element
  * @__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST: internal use
  * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band attribute currently defined
  */
@@ -4265,6 +4269,8 @@ enum nl80211_band_iftype_attr {
 	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY,
 	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET,
 	NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE,
+	NL80211_BAND_IFTYPE_ATTR_UHR_CAP_MAC,
+	NL80211_BAND_IFTYPE_ATTR_UHR_CAP_PHY,
 
 	/* keep last */
 	__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6b99416862a4..d05d098c4dc7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1947,6 +1947,7 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 {
 	const struct ieee80211_sta_he_cap *he_cap = &iftdata->he_cap;
 	const struct ieee80211_sta_eht_cap *eht_cap = &iftdata->eht_cap;
+	const struct ieee80211_sta_uhr_cap *uhr_cap = &iftdata->uhr_cap;
 
 	if (nl80211_put_iftypes(msg, NL80211_BAND_IFTYPE_ATTR_IFTYPES,
 				iftdata->types_mask))
@@ -2004,6 +2005,16 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 		    &iftdata->he_6ghz_capa))
 		return -ENOBUFS;
 
+	if (uhr_cap->has_uhr && eht_cap->has_eht && he_cap->has_he) {
+		if (nla_put(msg, NL80211_BAND_IFTYPE_ATTR_UHR_CAP_MAC,
+			    sizeof(uhr_cap->uhr_cap_elem.mac_cap_info),
+			    uhr_cap->uhr_cap_elem.mac_cap_info) ||
+		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_UHR_CAP_PHY,
+			    sizeof(uhr_cap->uhr_cap_elem.phy_cap_info),
+			    uhr_cap->uhr_cap_elem.phy_cap_info))
+			return -ENOBUFS;
+	}
+
 	if (iftdata->vendor_elems.data && iftdata->vendor_elems.len &&
 	    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_VENDOR_ELEMS,
 		    iftdata->vendor_elems.len, iftdata->vendor_elems.data))
-- 
2.34.1


