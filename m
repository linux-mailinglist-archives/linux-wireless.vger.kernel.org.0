Return-Path: <linux-wireless+bounces-29780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BDFCC1248
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C66E306DCA5
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0690343D76;
	Tue, 16 Dec 2025 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aba3aRH0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FhezEqL8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20E342C9E
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866458; cv=none; b=LOkKYP1l4ojIQCCRt3W5FCYZN891jeTQHdgji2FsJFN2ZeXEprtzDXVcKLsvG4n9lPitfc8tBYpKinKhgjtl3CuBeVn+qaLSf+jAFNGT/OR6An+ioqEAOresngI1y0C4fyW323h2fGUPDW5DbreOcwlrKy9MnHJqrDnJmGrK8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866458; c=relaxed/simple;
	bh=gc3wL84Q0XX5JSafNRjsF2GKOGTJtXE7paesJ45cN1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEFKQ4JxRIEuTw4eDHcYR9P2vp24hmyq0P99xpycfndRMxLM72MZPZhftjYujYCJVDdiFvqgnAC/aZn9ZWqEwFGs7jB4FwYoKRk27ywyPIs+W3LvTExreRvODwm43W5z0OB4ci1A4F0+oibiodaSKZY6QdEuZf8ox9rA8OILunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aba3aRH0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FhezEqL8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG4fCu82278610
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cfiryIgwWtx
	bq/KnMAC/VKKOZxMIlnI06yxKdvSB7A4=; b=Aba3aRH0jFMOc26fLP0u4eCSlez
	FDIEHlOLV7hb4jTG80iFKf8osvWwB0hHH5aFEWR0CDM8lo1hkRj6lOCt2B1YcMkQ
	Qt//T0yelwRgg27zI6r4hYtcPvv/N9QMiOp+qQqUI8Wb4YEOcLz2OUwS2YvMCxjS
	uJefuW5e1lkQbGin54+g7i+JvfrvINtbPjI2oma0rHA3oU5xYTGVC8QvCWwf6CpM
	18PLXyJukuYhCctp3ehMyG2AKPVaP2iJ4MauzL5gXYllVMZtwQbCJK7DnljN1ltY
	odkrBy97N3rsad16tdZ/qKirpN9SMsoKB6j9RoWibK+aBaeP8M9tS7Gxncg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2peractd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a13be531b2so7415565ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866450; x=1766471250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfiryIgwWtxbq/KnMAC/VKKOZxMIlnI06yxKdvSB7A4=;
        b=FhezEqL8j/2zhMmuZMm+A8O17Iuc3Es1f+WBQ5YibckTpK3LC/tLn07pg+GBDtNGqJ
         Zn/RXs1Me4MdO4ggx+P2cL6A2v8/3UIgZahDXTQi/RcY3ZKek+0wfxXkUd0PJwM/apU+
         N3K5r9A1Zb1TshSGUtBApwC20nfMlfKkZ6iim3bwvB+gptTPGYX4ND/Z0kI9RplOm/7v
         7sqN7g37Ara2fDKJ6+THI/w7EMyeedTi8vcb6c4xBnr5kBV0mgN6jHnZKrrbArOrvsCD
         UAW8x5p213gVldrLnYnQOvaY+boJuIW7tLdZ15DeY/AUMAzXmJSad0bSiYB6DR+Y5l3u
         oU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866450; x=1766471250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfiryIgwWtxbq/KnMAC/VKKOZxMIlnI06yxKdvSB7A4=;
        b=sYfMPo/1fc1+AMUFAm00nEm9KlA3kOSo7WdMXKQDMbEKhkmLxDtwONFTn3P2DemlDy
         hc9uPOX1cK41GLuMbFP5K0ojRaEvfLWeaLknd5OpRxWvoasWisNFaGDRlmUvR39Jyo1E
         FYKBifJtJV6vddAYcbsp1wdnR/dcNy5wk6dYwqmRbsD5+mcpFNY1Bg6L6sTAdYxMfM80
         ENcS/f0L3qn7R6dJoEqa/4KfuBT/vrSJLq4+Q8kKHq46nGFV+lmJ6kKGUqFhIin46P3p
         jO9/X+z1Xz67JLGK4GY4i7teKolaj/jG2Zpsu1Ie559OfEyl6cSdGaAqE55P0WZrH12e
         183g==
X-Gm-Message-State: AOJu0YxS7IqElb0Rj3G6cilEbnC93+jKTcKugk8I+oJYQauaz/JWVx3S
	1hiMW27hnNUn66skEZrh34mFcVM/7JIcJQsJyJ8ClElOU5qmPNWtP2OAntSIF9WjpxNOjjaW7VJ
	e/nkAMO1zN3vZqmQLZiSfIrX0K+BbtFWC+D+Zq3D+4Pcsa3KQ/XmqMJ7UOgBn4nQ/YgtlCY55nK
	fEmQ==
X-Gm-Gg: AY/fxX5hxPVEIzmnx7eRCd7ywfDww/rFXYSPXyoTfMXXwrKIKjxXSkS4efiDCfUsa8A
	oU+YM6zad2vCk9orFbeb/4IIrh7TDwCF1hhVMCr2IXlosnsdkMsKaToO3Rznq7FnX4y8tXzqJwh
	ziuvkN4H0XpyUN6OHu4QWkoUbIZbkLAO1v9DYQaXpkLcU5mSZ6ZaeRhoOV9QYeI9ZJN9qTdFoux
	SYiKG7ZZwe1/osoe1Zy9Ln80UpQX5h6IT3YglTJW452WC36T1jewT4GPfs9yJHjVbiWo2QA0dQJ
	az1hBJvMCzYPHuw6bprfmx0RUZbt1FvPHoy8S7unaK6D33OoTzc6ro63WMNj8A64oqLWeBpOSUK
	Luqc/5YywqfWHWiBqT2RgPd/AfS0fxoD0fESP56LWuDo85EcTgUvF2A==
X-Received: by 2002:a17:902:ef44:b0:2a0:a9f8:48f7 with SMTP id d9443c01a7336-2a0a9f849f9mr88619375ad.55.1765866449739;
        Mon, 15 Dec 2025 22:27:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBHNbaT8CHAf80gLujRi2rcPy9BET5eZToHkM+TAVoHdhh5Dj1ntZBLpkWcY6YGWgb0Mp7eA==
X-Received: by 2002:a17:902:ef44:b0:2a0:a9f8:48f7 with SMTP id d9443c01a7336-2a0a9f849f9mr88619085ad.55.1765866449177;
        Mon, 15 Dec 2025 22:27:29 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:28 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 07/13] wifi: nl80211/reg: add no-UHR regulatory flag
Date: Tue, 16 Dec 2025 11:56:50 +0530
Message-Id: <20251216062656.1738022-8-karthikeyan.kathirvel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 67J5NVgorpXFRDur2EKPaWnv5fMycV7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX2GvyAx8V1z4B
 4T0KNOYbIpT0AdwxEMIVe1VNo/1tMhlWYw89y4W9ArcZsarcTUcA7i+QvnuGTqCf+kn+QkOMwzy
 gxt07nIi9aCVnLg7imKQcKU6tWEHaj44GURu2EDmQ8LPXHm+Tu27Z9uSAd89lno/lXmAjnB44z7
 SN90zT34LzRLCbR1h//6MUFuM/L+GcAX6zxFCKAJA7von+qrfsQ1zOsrHHIuKKO6rTMtrSsujNF
 6udsAWytOI/Cbf8aBxwv6WMHo3jg/7H1iEKB2PjsSkNHWrXkR3RyFEE7pjCiopj1xi1DkzyW5To
 F3A6L4C+vp2Y9qEwUd1grrG2D9jNjApsofJp9PrLrvxzZhHHpehwNpJfmmYgkcC+o5dHaKq/yAS
 cTUdPqD1IGiTWpJYU4zcQLQemNFFuQ==
X-Proofpoint-GUID: 67J5NVgorpXFRDur2EKPaWnv5fMycV7j
X-Authority-Analysis: v=2.4 cv=PYHyRyhd c=1 sm=1 tr=0 ts=6940fbd3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=nvWAtuQM2l3KN6pT3GcA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

If driver disables a channel based on its regulatory rule with
NL80211_RRF_NO_UHR flag, disable UHR operation.

This is needed to disable particular channels which are not
supported/allowed in that country.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 5 +++++
 net/wireless/nl80211.c       | 8 ++++++++
 net/wireless/reg.c           | 2 ++
 4 files changed, 17 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e3b66da4c243..85321948b7ec 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -126,6 +126,7 @@ struct wiphy;
  * @IEEE80211_CHAN_NO_4MHZ: 4 MHz bandwidth is not permitted on this channel.
  * @IEEE80211_CHAN_NO_8MHZ: 8 MHz bandwidth is not permitted on this channel.
  * @IEEE80211_CHAN_NO_16MHZ: 16 MHz bandwidth is not permitted on this channel.
+ * @IEEE80211_CHAN_NO_UHR: UHR operation is not permitted on this channel.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED			= BIT(0),
@@ -155,6 +156,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_4MHZ			= BIT(28),
 	IEEE80211_CHAN_NO_8MHZ			= BIT(29),
 	IEEE80211_CHAN_NO_16MHZ			= BIT(30),
+	IEEE80211_CHAN_NO_UHR			= BIT(31),
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3488fa638bbd..9e957378f43b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4463,6 +4463,8 @@ enum nl80211_wmm_rule {
  *	channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_NO_16MHZ: 16 MHz operation is not allowed on this
  *	channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_NO_UHR: UHR operation is not allowed on this channel
+ *	in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4511,6 +4513,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_4MHZ,
 	NL80211_FREQUENCY_ATTR_NO_8MHZ,
 	NL80211_FREQUENCY_ATTR_NO_16MHZ,
+	NL80211_FREQUENCY_ATTR_NO_UHR,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4724,6 +4727,7 @@ enum nl80211_sched_scan_match_attr {
  *	despite NO_IR configuration.
  * @NL80211_RRF_ALLOW_20MHZ_ACTIVITY: Allow activity in 20 MHz bandwidth,
  *	despite NO_IR configuration.
+ * @NL80211_RRF_NO_UHR: UHR operation not allowed
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM                 = 1 << 0,
@@ -4750,6 +4754,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_6GHZ_AFC_CLIENT      = 1 << 23,
 	NL80211_RRF_ALLOW_6GHZ_VLP_AP       = 1 << 24,
 	NL80211_RRF_ALLOW_20MHZ_ACTIVITY    = 1 << 25,
+	NL80211_RRF_NO_UHR                  = 1 << 26,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7fc0f675a383..cb0592c292b4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1317,6 +1317,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_16MHZ) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_16MHZ))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_UHR) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_UHR))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
@@ -6576,6 +6579,11 @@ static int nl80211_validate_ap_phy_operation(struct cfg80211_ap_settings *params
 	    (channel->flags & IEEE80211_CHAN_NO_EHT))
 		return -EOPNOTSUPP;
 
+	/* Check for uhr_capa if it is parsed in start_ap */
+	if (params->uhr_oper &&
+	    (channel->flags & IEEE80211_CHAN_NO_UHR))
+		return -EOPNOTSUPP;
+
 	return 0;
 }
 
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 73cab51f6379..c995f33cb212 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1605,6 +1605,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP;
 	if (rd_flags & NL80211_RRF_ALLOW_20MHZ_ACTIVITY)
 		channel_flags |= IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY;
+	if (rd_flags & NL80211_RRF_NO_UHR)
+		channel_flags |= IEEE80211_CHAN_NO_UHR;
 	return channel_flags;
 }
 
-- 
2.34.1


