Return-Path: <linux-wireless+bounces-30348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D19CF2390
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 08:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45EA33022A8E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 07:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3D32D94A7;
	Mon,  5 Jan 2026 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n9xGQCiK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="khLGihNp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60E217F53
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597927; cv=none; b=TRkrH72HGgIMFfQUqeKE9OF+9+PsWLWlmYX3HTKxsKNr+kCg+lEyOGgWxNgWKhwAyYYfP9+wRopDJ4/fGuebz2lpRoBdw+YR7todR6RnmayxbbmINzdaznHf2/QlRwOgm3ykVwGTlvh4h0MRPbQ2nTwwnVJC+UZ6kqNv++kvxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597927; c=relaxed/simple;
	bh=NhVtziSLS+H/CN4qE1XqrnTx/DavfkxoWUlFeuYEeck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gtjh/08EtUrGAk3Es8F2+Lxh67QqkyCCWdifpI+B6mPvsVcIRLE3tQ1XOIkD/N6tMkr3dWLgblz1Vb3X3MKvhiRDpj+wAra6YnAiXSi9pd6KOiv87cNcmUByNMUd5dwkm3agKRtsAJxkVEa9ZaIJ14Xgm06jru3mlgKBeJDF2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n9xGQCiK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=khLGihNp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6052o5aM091251
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 07:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o3s40Mqdbn4
	jif8lMjdVZbrCGlXLLFCYvsBOMfLzyug=; b=n9xGQCiKXo4JmzgzyffGmze0Vps
	EiSEBqa9j3RA01nE1gvTSY2htRYBT8Ndra1uIlQvvryN1UOQJuv5gGOyytLsxVmw
	Xfib3e1rgZgrJHp3nD2stR7ouIJE9T6xOZyFxVu82QrxaSUrChJs8SdpVaD71GNf
	i06zRFC9uDCGbmLd6IKzzjm4PmX80vRJ1GgElFcGLe5TskOFXBd7J7LiS+dvTfzl
	/BObERL9ywGx9uz+MFkVY+qEF2g08OPGDsO3WE19gm+v6dZJpXQSsUQFXpkGsbTc
	7aDmRlY23C2OVhIEaxsVfNF59p7/R6kvtM2sgB5rmTpcsYfS1rdtWFp8ekw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg4v60mpn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 07:25:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f2381ea85so306104175ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 23:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767597919; x=1768202719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3s40Mqdbn4jif8lMjdVZbrCGlXLLFCYvsBOMfLzyug=;
        b=khLGihNpeunnO4tBkbeSmKOrsbyod6edRBc5CK0JZwlY/uA0olyL2gQ6ZGrDnlJj4d
         iO5UI+Ex4ynAQHeFDiR1QaYYo7SFmnEz3VFfmL5vWcp5h9hKoP8Vcejj9tcawQNE88lB
         CzRj4U8CAVqvFHD9Zu6yGjHURNcKxI+7628lPwDPWCKkb5aZ7tO1gRh0cVQFYbH/PGM4
         kYeX0vKb4vNlF/i1C/p2t4WwHsSyrHuO5EdO+0Ms78qU8DH30Rke9wf5ZfPycqZjSDO1
         xg+uQP1qNBbr3iuYjs8Gj//5eOVBSsB61wEclbmv8KhcbPNYFCJGGKN+2kTd5hlqcUrl
         eD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597919; x=1768202719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3s40Mqdbn4jif8lMjdVZbrCGlXLLFCYvsBOMfLzyug=;
        b=Ee0MiUrEQ1wfbsxuOF32eu7GfglCyw8NTNxhrepStsKUuqristc2tJYsxNjv7mWilG
         KuhsXbYRs5gKXCruBnBjTT3GjPNPsPHlXlmC3at9nLwjwrNe+YK6qDSOSwPro5IcceiY
         iCYaQIvEmme2Ehj2uDAEwIkWhQbm0vFJq2Cdued2hi09kFtl5QS1XoJnQ8ryPgZc5u5P
         A9XIrPOr+XFecVtvnmvpUAEsZP29N2l2jWt/EQLmAfQoj2S/oaFqsUjh8t1Yia4c+1LH
         VItCx6aoEZNY5eWbt8lddcYdsJCusUpf6QwrnRrZL28HU6sE3YIALrEQXrC6tXXbmY3c
         c7qw==
X-Gm-Message-State: AOJu0YxfO2qWSVkMX1Cfecjk2Q41lLW/D7xTEXIe/OpDrm4N1ktY3evL
	vBVvXIdBCRlL+cYDNm715wu9qjHnxLa7rFB82ce4oVbshBIOBig87kzTifWByViousPL61FtWmx
	+6HuEv6pwBMEyx9TRXjN8dN4ClQOSdcsQt8YFrLVtm2xThDJqSsp9zoY7Nwtfg3ARiSPlpueeVo
	hcKg==
X-Gm-Gg: AY/fxX7uXdmZso5updLOk98+L4nDoJm4Vhla6hV0lxJVdZTs0XQ55QxHkLvnf5iWbCa
	ILxiZh9Y7EvJm6PMLGdDhpffphTa7zl6jhSjJR/FIT8pIjocz3rm6nLY5xyx17LWUXvr5flQVru
	zL5YrmUmbobWtonKN6WIdeQQjR8Nw1+NYTQRFKevgzAe5Jt+qjGJbpmcMrY3Xza1R/N3dwoaLY8
	blDDTZ1554C/TgYWY0wqZ+JAojDhez2vHRQBSVGHFn6MHKuJq3Kc3prH+owvl9K6oSh9Nn1UHNb
	j1Ek7sNecEzys0Wu+TdRgMPNvMtHPzregktzYOXRklu6JTSLKQgLp4PX0n6VeCq+zvrrVcyCUQd
	HUyBcu5WPlvSsUe7Qn2MOeV6r1RlBnk0Xynm6Ytcf+g==
X-Received: by 2002:a17:902:ce91:b0:2a3:1b33:ae11 with SMTP id d9443c01a7336-2a31b33aeaamr465719565ad.53.1767597919463;
        Sun, 04 Jan 2026 23:25:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH877AWdUJTAk2TLU0BGP/2V3GJVT/RFJxznq53TD1UFU8GlUhR59Ex77P/JIWfiOzQeSP1A==
X-Received: by 2002:a17:902:ce91:b0:2a3:1b33:ae11 with SMTP id d9443c01a7336-2a31b33aeaamr465719455ad.53.1767597918971;
        Sun, 04 Jan 2026 23:25:18 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm445201205ad.34.2026.01.04.23.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:25:18 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 6/9] wifi: mac80211: Check for MLE before appending in Authentication frame
Date: Mon,  5 Jan 2026 12:54:12 +0530
Message-Id: <20260105072415.3472165-7-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2NSBTYWx0ZWRfXzlh9DwjdGSNC
 kWRMHFx9yTa0qSN55JPr15hyitDD/1fttRMb7SfoBCUlpLDmwksk80Z9k81hAJPwqIFIxNIJy4J
 K556JoAJXK2djDAkWCikN9rwFMsW3e12kf5qzH61JMT3IPV8DRnzT164LwX+PGqo9DrYJ3YdwDy
 56VonCgIBiyfOu8EJlnFu+uq5imtNKBUjEvLrp4GI5nUgvJBfb/BIhJb74+rUB0ti+Oh9IIOIoQ
 lvylKZP0F7rWXzv2ojlvkRIToduPpw5DCszWV4A8MiMLAQtKrbXAQ6mb65qLbjbdjh8S+Yj4BTy
 DeOM7fW0VUG2SKy/29DFLPA6sH0f5/kXL2hTNF0Ym08/e5O+p+uKPLNF2H+HW6ruDM3Vz2wGb8M
 RgehK3RkidbbxQ1OfJTNbS1G4sWMP0JuFdI8vZbEAPHtXOye0s9B8Tyqv8thaljQGag4WjshOgC
 GxtyIv+7JirxEPAOzqA==
X-Proofpoint-ORIG-GUID: 0WYPX7xLE9K3AB6cC3vsRrSI_9iccaiL
X-Authority-Analysis: v=2.4 cv=c4ymgB9l c=1 sm=1 tr=0 ts=695b6760 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=nsG_Zr0jnLD6Zk_6mugA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 0WYPX7xLE9K3AB6cC3vsRrSI_9iccaiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050065

Currently, in MLO connections, userspace constructs most of the
Authentication frame body, excluding the Multi-Link element (MLE),
which mac80211 appends later in ieee80211_send_auth(). At present,
mac80211 always adds the MLE itself, since userspace
(e.g. wpa_supplicant) does not yet include it.

However, for new authentication protocols such as Enhanced Privacy
Protection Key Exchange (EPPKE), as specified in
"IEEE P802.11bi/D3.0 section 12.16.9", the MLE must be included in
userspace so that the Message Integrity Code (MIC) can be computed
correctly over the complete frame body. Table 9-71 specifies that
the MIC is mandatory. If mac80211 appends the MLE again, the
Authentication frame becomes invalid.

Add a check in ieee80211_send_auth() to detect whether the MLE is
already present in the Authentication frame body before appending.
Skip the append if the MLE exists, otherwise add it as before.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/util.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0c46009a3d63..3dc712bad8f7 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1096,14 +1096,17 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 		.ml.control = cpu_to_le16(IEEE80211_ML_CONTROL_TYPE_BASIC),
 		.basic.len = sizeof(mle.basic),
 	};
+	bool add_mle;
 	int err;
 
-	memcpy(mle.basic.mld_mac_addr, sdata->vif.addr, ETH_ALEN);
+	add_mle = (multi_link &&
+		   !cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
+					   extra, extra_len));
 
 	/* 24 + 6 = header + auth_algo + auth_transaction + status_code */
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom + IEEE80211_WEP_IV_LEN +
 			    24 + 6 + extra_len + IEEE80211_WEP_ICV_LEN +
-			    multi_link * sizeof(mle));
+			    add_mle * sizeof(mle));
 	if (!skb)
 		return;
 
@@ -1120,8 +1123,11 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 	mgmt->u.auth.status_code = cpu_to_le16(status);
 	if (extra)
 		skb_put_data(skb, extra, extra_len);
-	if (multi_link)
+
+	if (add_mle) {
+		memcpy(mle.basic.mld_mac_addr, sdata->vif.addr, ETH_ALEN);
 		skb_put_data(skb, &mle, sizeof(mle));
+	}
 
 	if (auth_alg == WLAN_AUTH_SHARED_KEY && transaction == 3) {
 		mgmt->frame_control |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
-- 
2.34.1


