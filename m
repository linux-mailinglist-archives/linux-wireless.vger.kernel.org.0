Return-Path: <linux-wireless+bounces-25633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D72B09B22
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A642189653B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8551E1EF092;
	Fri, 18 Jul 2025 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HTP2xdWl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B621E5207
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818945; cv=none; b=YTuE1Yuf6W2B1dAc1IbZbt6c4etaarYpmdGaxQyP+oQjE3AfhOm4S6tQS1YWFx3ZD6YpAWeT7ufrnfd4SYpFYkiSHbL6g8h6ZdWN+Pk1QrpJL6ZoNy7BpRY8dha3bAZ4byfd04cKUzFghkMG6mUzPUKg5dA2z9FgzIcOLpH5iLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818945; c=relaxed/simple;
	bh=OlbUYbXyDI4/OjK7HZxPBktL4A56ejMXLuh44rIZU3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XYq61G4aLsZ8JvgjaEtqtW+9AzMETEl67Blv3peSpv6jVRlEHJWVgPwUXHRzCa6gXIg5K3aRDMOfaby5WDp+CqAjsTk31qZFL6S/G/1po5XOArfsnfXU1Q5ase5brVHoX0fi2ZmUOozOB7NCn8U00mhGbWjp9WuzuNX6jpU0L2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HTP2xdWl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HM2dnu025200
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=NtZIO/wcYcaXJbg/YcKGnAnLFnk/8uLtdneQiFrutIo=; b=HT
	P2xdWl8srKtJ+ijhPm5fRS79Rru/BzwCekfYEytxQPelE27Y6pj74FT97hnYboL/
	QKQyk2SnMjOX0TStbbZVRBdzmlaT4Ap04LJ210YoZ2WVuor7Fx6HUm4OeAVKYpDQ
	lNPFUkop/zXEvr0YTE+5Adfhy/pzonxTtHyILfPhAkK6w5SxJZd3+GyxlsN54rTs
	zFSuvmxOT59A7kyekw3aMp40bsrAiqtl3pWbPQzpZdjOmgJdokXsTDfTR3ICmIG9
	ftLqtQEEDJFK5TZTvVoN/NCGUE6we0ldHbPKGAuOg3aXVHABwbXRNERgSNA6kXHl
	eYr9nW04GADWADns7/eg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqehm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-756bb07b029so1699443b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 23:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752818941; x=1753423741;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtZIO/wcYcaXJbg/YcKGnAnLFnk/8uLtdneQiFrutIo=;
        b=jeKDxHCw21a7HMeJf7u3pNUQqDmwy36OE3n3BgX29D3APVYxObTuV//GsqkZSyFxXB
         Eftv0gR+KKRYeLEakV5/yyk63QsDzdbE6BrPtt8UAUCxqywwg1HCm3baL3ZfxGubontg
         Fla5QfkPjxF4gtiEyt13dPKe+HX1rwP2HndcDwppO8mInG/xVDvyY1CBuAK0Hw0X826I
         LvQ+YR/LNMzN2EckPF3KSzH3x+wvqdTT9ZnTbsEabA3y9s+85dtoj0UMzQY5x++nhpVc
         Sq6CHyAFL0ElvSYwrv1hVPiI4czbF7Jel/rgV/WH67cv3IQyK6uSI5SMbtAaQ0YosJO2
         9Wvw==
X-Gm-Message-State: AOJu0YxrLyU3VuJCCPCMN30UYGtVeOSiV1sP5HRIEZY65Jla3zaW9iBO
	HebSbTCaHiH0RybBtPa4Ffh0Y3rfHlzIZDCuKi7MaOFgg1UA3gHoADEQRYlWetGExhR5LvkAkMZ
	i0YAoAsD4GrJaRX0p21GHmAmH/igyXH09ugZXSsdVvzDtObzw7zAMGiv8ss1svm8kcmuFHEC/+P
	RT1w==
X-Gm-Gg: ASbGncu7nQ28S6bLB0y8p95CA8W0O51Lm2eN0dKO2wfDuVycuBpOrRSVq9ByqI3Q3Xy
	dGlc/kZmkXGenZutis/CNi1xSfWTW0b0OYNH7kx1v1gCZKDs89veEvbjwqM2QaAolSl3IVWmymG
	3Ftg4zCqJIr9/9wC56Hx4LUCVFn3NxsHwXP5m9c01OI4tD6eOqjw6nJixdQwTWWU46Vb2tmEtgq
	OxkRJy1OiA6ChYosQDi5XUeZMPu7NhZTgtB2MrN+PbVDexLpedjhZCBvagrl5SOmzBCd3r3ghll
	db598YzaSQAt+1lbcSeS/nK56ZPFFEbjL9UkkwuCVnCrsMnVAN/j+vKEZ94YI9F0VuS3SHe8S3D
	78+waIl8=
X-Received: by 2002:a05:6a00:846:b0:736:3979:369e with SMTP id d2e1a72fcca58-7572315f3cemr13400992b3a.9.1752818940950;
        Thu, 17 Jul 2025 23:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoTTj+A0l1SPbvwSHLVROX/VtBwtnc1zzWHo047kpOb68LU6DIXFw5DjaSPGlnr1U14c/YBQ==
X-Received: by 2002:a05:6a00:846:b0:736:3979:369e with SMTP id d2e1a72fcca58-7572315f3cemr13400944b3a.9.1752818940435;
        Thu, 17 Jul 2025 23:09:00 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e26d0sm531236b3a.8.2025.07.17.23.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:09:00 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 1/4] wifi: mac80211: fix macro scoping in for_each_link_data
Date: Fri, 18 Jul 2025 11:38:34 +0530
Message-Id: <20250718060837.59371-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718060837.59371-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250718060837.59371-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=6879e4fe cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=uoc_zonLh4WDVtuW5XwA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: HimEIhQmySX7YdwNv_J7mw-R6mRMejLl
X-Proofpoint-GUID: HimEIhQmySX7YdwNv_J7mw-R6mRMejLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA0NSBTYWx0ZWRfX/jhyUNgvQIpe
 YEErfD9nia2I6tsno65VTvr5brtf6ejfNOYp+26a6F/OfsUH0p+RS+U0NrbFiOAHFxGi92VTOp7
 zDu9eJ7vGQQGb0LNRlk0Ws/MP6GUMIF/UEKpfeLmhJDNSq+2Jyq1DElo0BgLJrSLM7QXAtZD+So
 nCnprJx+ZBmiNh1tLjIBsBeDw+005QI9D73mSknfzLOExe32UK8kvwqBJNybvjMMq3ojFRHxuaE
 sUyzo8zANSOH9r2K9FBZrg+VtMMrQ0g/HUg5RSkRfPftcckLRI19PtFK2auSZPAUdp3fVGpheVD
 bu2nvGP75cbuK6UGaCt0NPI45R3OkAYd4rBDn3MAkLBX6g6qWXWDyGGCW1AdOzocR50+eNIEdHo
 P4fXVwofTtE+Gajqu/BTZJiMEzjG1VQyiRI+XOb0Sdj13Y1DxEeaU0rSwuuKCFaTPWDK8i3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=882 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180045
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

The for_each_link_data() macro currently declares a local variable
__sdata directly, which could lead to compiler warnings or errors when
reused in the same function or within switch-case blocks due to variable
redefinition or invalid scoping.

To address this, restructure the macro to use an outer for-loop that runs
only once, allowing safe declaration of __sdata without polluting the outer
scope. This ensures compatibility with static analyzers.

No functional changes; this is purely a cleanup to improve macro hygiene.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 net/mac80211/ieee80211_i.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 084e2673a27e..7c18c51966d0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1242,7 +1242,9 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 	if ((_link = rcu_dereference((___sdata)->link[___link_id])))
 
 #define for_each_link_data(sdata, __link)					\
-	struct ieee80211_sub_if_data *__sdata = sdata;				\
+	/* outer loop just to define the variable ... */			\
+	for (struct ieee80211_sub_if_data *__sdata = (sdata); __sdata;		\
+		__sdata = NULL /* always stop */)				\
 	for (int __link_id = 0;							\
 	     __link_id < ARRAY_SIZE((__sdata)->link); __link_id++)		\
 		if ((!(__sdata)->vif.valid_links ||				\
-- 
2.17.1


