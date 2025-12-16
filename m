Return-Path: <linux-wireless+bounces-29781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8138CC1251
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 367BE3076A1D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7BB342512;
	Tue, 16 Dec 2025 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLuMsz+V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SgCxQrTo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE01342C8C
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866458; cv=none; b=sgzvAk7/ddFNGrx057nmsiKqzL8cVRz5vkT7hLHXaxhqps0ykYr8+rCkUSTBe9DTVLQv0ebyMpN7pd5CdGS+YeoccvEb+DBaDRyZZGWGYpKOZGkRHhbQ5hDTxUSAWsq5mdfoy7MtkQ2VYzmnMH/P9l+GKlSSXEAu8Jk6yzh500A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866458; c=relaxed/simple;
	bh=CdoJIudTC0Dh7iY/u+kcZQ88f/3rLWfIWv1PzW4cddw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndNRKI+/ZCULBqeA7DXxIuyBkphZAIfvg5jquBrbGoD7LMTaoirnXRpjYNFANgM8gWuJE2DQiIJlYi/xxzjk8xbO6w3wDghh+xpT9lshuJJdFNsR3gATKSUEzp66+wn/tK1K9MoeK8oTAZ00SuVpYMwUAJ7RI2CpZqm6iBvr6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SLuMsz+V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SgCxQrTo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG4fCu72278610
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Hq14bMPk70Q
	bIq/eh4LlIiABBZbYAe3hK75GvVxPf5c=; b=SLuMsz+VYJacA0qpV+i2kM+Tkcq
	EqqcFIZcrEvOgj5rZ5V5+KTpm7CCckU7U9ZbHax1+siNnYjiwOqTThiH+5Wv+FYb
	zswqd3rc6m/JKPgxVVnL5JjrwcapNndf1Z0h8cOmowdWMrvxtbgswbLIrXlKXydO
	bODPQUF+q+LXRN8Kmcr9fHxrIyjfz60CMMgPGTgLJNql0L4nyR94aKwJUFlpx4jS
	GXBS7A5u9pbMNdR9+ipThVPNTvrA3vQGdrrAKlUHrajkcO24KKoZSx/k5HofAqlu
	3tqZY/Ajuwl93FCo8peZBcY1iVAk3IRFa11gIAEeYHbqNShQC+gf/oDV0sQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2peracta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0a8c465c1so17252465ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866448; x=1766471248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq14bMPk70QbIq/eh4LlIiABBZbYAe3hK75GvVxPf5c=;
        b=SgCxQrToui5QvSIl6TK4ORlxAkOA8OmJasGh2eLbWu1fJRwQNOAL5psQuVMonIsiys
         9p0a7ZH2+/oqFc2ksByNd3pH+MK7K/ZjVzjJNZsCtXvJqVlEbzUwpj/pVvrB4SjMImdW
         z4AZOCe4rtiF4FsY4fLFCG2IsYABGPWLggPxSwGQwhZ/rxZT1QiwMKbBtBhqR+1nJoe5
         xTu8bk9RNNUD1b0+0ihpK7H2Jre6c8MkOk4EdK/pmv9laPotl1cUO4+XBMor/YNDc+US
         6oJX67PU2+OB9MXzFJZB9WdvB/U7AdvdrVsN0Jc84/5qLqLdty58FmLAwiTm76CRqtLM
         BYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866448; x=1766471248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hq14bMPk70QbIq/eh4LlIiABBZbYAe3hK75GvVxPf5c=;
        b=KTz4pJhCH9IkJIemMkCObIJbAIlPijTzd0yHR00R4V5DaE482NV+tmUaUBScpdGT00
         fJE07Cd/453tVGUp+2NhWW7psRytX63Q08B2mIT2wtSWTR2AIl61vFm67Suqthljn2Pa
         EUJWO451J/5bBy5laIu9SvZItfwDBdSWrrNFVNiWwDucULxOneIv/weL7tBi/Qk7BC/b
         qnFzTzIq6FclVq57T2BSIwlKc351d/PI337Jz5MFj+Tz+VQWFapGBEeEVvfRWB7RGWar
         c9Ef9oNvmdl9vrHxjEaRpkBcj7YFt98kaHnObuzE6H8UqNklZSFifS5vnBoc91nhsTbO
         3j1A==
X-Gm-Message-State: AOJu0YzW9apLvfu1VQRDuVvm1/22gaYk2eklzN5Dbv2DG2bnF/GBlJRX
	dNk8miLYrF7BkbsFrX9fhtITmOols47KbRiuQ4AxOUzUHZNRCveywPtP+asAlBxYbzIxwiEJOcw
	xyDmWqZiLBqG5FE4E8b6egGyQTkQ9gCMeAF+MXChnr5xClZlicIZ9b4RS1iCLdvp9z+hrZQ==
X-Gm-Gg: AY/fxX5tdj0qFaSpkH4PsH7ezds88EmBPhYeYLNIJcORri+NkD2/xt7r2wWjZpX/MHK
	cwyQzCzR1AkC/4+ehzWpFPNreSorLKpAbLp4Lj3+cj0oiBkXdK4MdCa7LPiY6V0nI1DA3/1E8u0
	ADPF0cZ+Q6C1mya0YDnzR2u9DCSOIs9TZyYY8Sz+D70Y6Wmf968GtWZK2XR33w/5lnO/xI/TiCI
	hRWb2dy+ntA3j4TmEZa5NhLmYGY+FMDyuuqNXmA2dLyK+qfgMRPDgu5mFY9Ec8+8KGKdLWvLpuc
	7DBlaMDK4Xowbi6Q5LZNiyAwdAOz/dFCPhKtzEvth8xS81YNo1e/2YS4WvIT1TFFzjQlGt1T3Wa
	VC+kT6fDMXNyd6m2Hxa4tAcPfZrbH4BN82awjjb0ASxv3iipvO1bqCg==
X-Received: by 2002:a17:903:2308:b0:29a:69d:acdc with SMTP id d9443c01a7336-29f24eb128dmr116524595ad.25.1765866447662;
        Mon, 15 Dec 2025 22:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeF6+NIgb38BUPU0Y3iOrPK8Xd1070p+PiwP1wdfWTPWXCH12lcZ7k3YYoyjWs4wbZZdk6vw==
X-Received: by 2002:a17:903:2308:b0:29a:69d:acdc with SMTP id d9443c01a7336-29f24eb128dmr116524345ad.25.1765866447143;
        Mon, 15 Dec 2025 22:27:27 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:26 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 06/13] wifi: nl80211: retrieve UHR related elements in AP mode
Date: Tue, 16 Dec 2025 11:56:49 +0530
Message-Id: <20251216062656.1738022-7-karthikeyan.kathirvel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: DQsQHHkeY40J_bMHJF33wM7Il4q5hqUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX/TbVomym8ey+
 IXRs9XoTf83yN6mSBleLWjw5wvujSqg8Wqwo8+BxyXWJYvfLQSbiYDqiDLNKYLzvsaxUXvOr3Rn
 AvHQl0M2p+7ckkbdFm2n96tLr2mOof3i5jjty1YGIvaHvVHAn9iy+fP63c0B3T2SIhTV/Pfmf3W
 2o+r6r8w+uGoDF75PSab0AgjU56RK13bOwQqwtGMrsaZzqxoSbs50fjt7i7hONkunONSSJEmeng
 /m4u/TXGvBNMH35doXZqVpsPERo3ykO6YEsGrt22aMbMiIRZZeZ/7shFvBA8IKGUes9Cli4zxl8
 jsOA0uXX2aNlpivl1/W7t7uWDRUTjFU0bxmZsqHDNsd4eH8dZT4wq+btoX37oZzjUUqqFJK1i0J
 hlSLQoVQ7/26ijrCYEuTODx9cIjHWg==
X-Proofpoint-GUID: DQsQHHkeY40J_bMHJF33wM7Il4q5hqUB
X-Authority-Analysis: v=2.4 cv=PYHyRyhd c=1 sm=1 tr=0 ts=6940fbd0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_UTdrhmLPrCkqZ53gewA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

As per spec, ieee80211bn D1.0 Section 37.29 Beacon Optimization,
add support to retrieve UHR operation elements passed by the
userspace in the beacon template and store the pointers
in struct cfg80211_ap_settings to be used by the drivers.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/net/cfg80211.h |  2 ++
 net/wireless/nl80211.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7593f1a1875b..e3b66da4c243 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1522,6 +1522,7 @@ struct cfg80211_s1g_short_beacon {
  * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
  * @eht_cap: EHT capabilities (or %NULL if EHT isn't enabled)
  * @eht_oper: EHT operation IE (or %NULL if EHT isn't enabled)
+ * @uhr_oper: UHR operation IE (or %NULL if UHR isn't enabled)
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
@@ -1561,6 +1562,7 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_he_operation *he_oper;
 	const struct ieee80211_eht_cap_elem *eht_cap;
 	const struct ieee80211_eht_operation *eht_oper;
+	const struct ieee80211_uhr_operation *uhr_oper;
 	bool ht_required, vht_required, he_required, sae_h2e_required;
 	bool twt_responder;
 	u32 flags;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a54618eae8e5..7fc0f675a383 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6443,6 +6443,16 @@ static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 						cap->datalen - 1))
 			return -EINVAL;
 	}
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_UHR_OPERATION, ies, ies_len);
+	if (cap) {
+		if (!cap->datalen)
+			return -EINVAL;
+		params->uhr_oper = (void *)(cap->data + 1);
+		if (!ieee80211_uhr_oper_size_ok((const u8 *)params->uhr_oper,
+						cap->datalen - 1, true))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


