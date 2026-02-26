Return-Path: <linux-wireless+bounces-32202-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLLXE97un2kyfAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32202-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 07:57:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D61A181C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 07:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F4C5308F8E1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 06:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48693341ADF;
	Thu, 26 Feb 2026 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K5Rk7115";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P22Z77dR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD238BF92
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088931; cv=none; b=Eik4AX/hMe5Zvjmrwxqu2r/RqCa+xogfiJoIzUe4ayQo+7GS4eQ26ynicHQfSQIoiVwnmydB11Q+kB2U/13oh7iFN1+jS4NscJLpHRAfG/ZJRY3BkazCpzRL6ETh8NHhtun9qQ6IXzVUF6GBDG0xIzyTGtLv98azBN8M3WBxHxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088931; c=relaxed/simple;
	bh=iPf/NT4FKh7OItF0Z9L0x5t7DLBGUykRauTVZdr1lL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQS/M+b8gyDfW8+5ntYeqBbUcEH/wADMI6Rs+auDSZp5n7mpgJDje4VFCLo0O/mD/ocTmSDKHdF2gCN5sHZscgcTb6S1DFoVblF3B+n5RQE/DgMn3uHAvfiOvdmDi3PKBkiXUJkzyk1/T6Ff8GAoRqPmDgqmKTWfzf+YEUQmH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K5Rk7115; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P22Z77dR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VHFj350885
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=s3G+DT3Rcld
	Hfe/TGvSRg3SFqbNh24h9p85xQ6wyTcs=; b=K5Rk7115fApBhe9xRDmkdZN23KM
	41hIcJWVEmWCC3tuhJknU/QyWaASbUwCuAFrBp5L2hlSNLv27tOHg9lBVONlhKM8
	nG7dAk8FaLRzRcgBsrqtRbGFpFP3RE1TR5qCL6WH28rkzfmWqW/ihcFTTI/Q3R1f
	D/S/sdfiESKDiquGhr7zEjUeW1bB5GzeWETXPalWf2MUZ2Y7+1tsTy7L2LWUTQ6h
	z0UAoKEUE/nO7q4U3PUlig91FAykHaskFLGNp+B2+JTGt34WvQLaDFL5XIV8lD4m
	bnd11bpBpw1UIXZDBb5wRsrfcSVkL+OBKIX+aOf875b+/CTWa9EHSugHljw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54pa55d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358dc09b43eso451887a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 22:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772088922; x=1772693722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3G+DT3RcldHfe/TGvSRg3SFqbNh24h9p85xQ6wyTcs=;
        b=P22Z77dRbNrjf2wMfhVruNkLdkv36bHjaab/yRI7Ff4nASP3p+0D7uYLm5NA/01hL0
         jKHam3DVodwywKZmpokTCrLkS2L9NbXXxidJeBSj9W4E9rWl+uFf8qczG+vww9e/pT1b
         zdFrhZTOfxUcc4tTlLDKNKptf3v0gtc9lOhw64Hoax+aiK3lT8DixAFLuCoIRMjZHGmS
         Pi1ABxNKBdE/ICIZhWRdsifo1b70xZKvtVK/kUrb4JmuzmqHJF8gHg58xhYS00OQdFN+
         B9nsCn7CEinK3hmHvsDPfnL1BTy/ci7OHJIUIKojc5AnlZkUjKnXQiQDW2ipvCkujCcz
         yEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772088922; x=1772693722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3G+DT3RcldHfe/TGvSRg3SFqbNh24h9p85xQ6wyTcs=;
        b=qdYuVVt/mNq/OpbLUcbnQHCzpmIww6rfhy2P9VgZlgWXA1ERXbiA9zj0xvY5WcbvAX
         ner9Zga5dWtFdmjfMuUQlo86h7E6kg83uChmx6J7I3xldqqHzOGmw0/VR/Mi08M6TWM+
         yMGxmN7m8nQgKKobdARamSdioBCdL3BHbENd0qCqYAd+00Cht736wYNOQaia6ULQExy8
         mutXwWg5hwJngeX7Rmf/3LPR1/kss8noNI7NIlgLJwWPDmHLoRmmUHCVcfW85+TE0j3X
         VnTKHsJPfbMv1l/7ZLZGK0bqcbNeZ3nwPjbtdJCMqKmMOq+ASks75j7agliEviwgtyPo
         AfPQ==
X-Gm-Message-State: AOJu0Yx7R35ju7VWLDwfP5p+elSARu1fsk8jQWl46CJINOoLLXSnNqX4
	WoARBIUdBYaC9QxArW5Pt5mxSqM/RY9BNOzxIsVHT3Dw46GNbCO4KkKa1gSONDoNc+driooKgdx
	rCLxfrN2/uZ0lQGY+sykpoglee+2gb3nLSn2nUOw4ixPVWK1cddezwrSMtdVhq9CQSOlk7Q==
X-Gm-Gg: ATEYQzwiLBkvGnpm00e/orYz/bRF61SqEmgY3T1ZmqEoLJ1cZDRxS68NpdI0IPNq9a6
	WT+Jo6XtJFPZMy+OHbRxroGHUNORvhdpmsQSj57mePSdZR57sRaWmK0+8Rn8VvXZcR0Qg0afk09
	snVkmP/ioX/HworqMqZwOef4Rq9SEycsXVdhGOZMU22pH6Qeu8226ZYDuwudotFKlfzKbsaEMtt
	o/4xJauXs/Ro406cSJdVY3lgavsdg9GsAw+tYk1Z7p465zbBpA4XgPKh5P3eE3CBr0t17hrcNS9
	QqnI8IeZ0jPd8H4T9/IitbIRc/u4Y3w3mxI8P8u2LZpS6IDSDQzxsbDvP4RlhAaO8FnGQxgfVw6
	zReO0wp4G5yWit6woeyVF4hGR4B9CefDnUa6u4Oa7ROWRP9GtaA5dVg==
X-Received: by 2002:a17:90b:4fd0:b0:340:b912:536 with SMTP id 98e67ed59e1d1-35928c32742mr2288346a91.31.1772088922057;
        Wed, 25 Feb 2026 22:55:22 -0800 (PST)
X-Received: by 2002:a17:90b:4fd0:b0:340:b912:536 with SMTP id 98e67ed59e1d1-35928c32742mr2288331a91.31.1772088921586;
        Wed, 25 Feb 2026 22:55:21 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35900700e69sm4791066a91.0.2026.02.25.22.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 22:55:21 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next 3/3] wifi: mac80211_hwsim: Advertise support for IEEE 802.1X authentication protocol
Date: Thu, 26 Feb 2026 12:24:42 +0530
Message-Id: <20260226065442.4182232-4-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
References: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MCBTYWx0ZWRfX7YdA4BPsOoSW
 ofQ3Ixhs/tF9e0EhI6FiY2HrkDL1zA/zft11iUdEPDXWBNE30ZXRXRvBWb5i8pSRYZYXZGYERUP
 JtQ+ZN0sX01KUHng0aGPyY+Sh/43Mm0wuIlqtl5QQicFiwRZi08NlhSbtu39GprcbHscmgO+BjL
 eG7Jc7FxRjDR8yTRNy/Cw/Q1KB3K6JOxab1VZI70ZOBXG4JdUZsBpm/uE6N3lBwxiLUzUQmiMxc
 QH45KmfHMJlkrXO3v+Fp+6KnMqfM91p9e+9X/mJQ98JhfR4xVa9qJekJCm1aQ7Hl7Ztood9ETuC
 X3KOc/f63vo83CetGey7dL6lbYiQHAr4JVrgwqXvAkkibWnC7ntUZKfuGZVNcj79L4nFws+7kd4
 uHVsOJ5clLfsNvSkaYiSE7OKSDTHKbITfyqeUbIQF3sPqrJ6aCqsa9a+pXN/eHwEzD+GIU1fK20
 iBWzrty0oZkIBmvMGyQ==
X-Proofpoint-GUID: 0AKnsFSqvTaOW99RzB-JFMy3UMp1oIB1
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fee5b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=a1T-8RYyaUdGYqk8DgAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 0AKnsFSqvTaOW99RzB-JFMy3UMp1oIB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32202-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A75D61A181C
X-Rspamd-Action: no action

Advertise support for the IEEE 802.1X authentication protocol in
mac80211_hwsim to enable testing scenarios.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..c86ceb5f6703 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5640,6 +5640,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_BSS_COLOR);
 
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_IEEE8021X_AUTH);
+
 	hw->wiphy->interface_modes = param->iftypes;
 
 	/* ask mac80211 to reserve space for magic */
-- 
2.34.1


