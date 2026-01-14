Return-Path: <linux-wireless+bounces-30820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63839D1E5AB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 12:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6385830080C3
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1732BE629;
	Wed, 14 Jan 2026 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RaRKX8QL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g9R9woL3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272838A9AA
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389586; cv=none; b=I4LfeKawmuarg8fMPXCWSSnqMgwCungetOr5Y/zNX3iD3JIM7LeSBaIQ/hbGqi6cIDSa4vy7EttMr3Mp3hms032ea57MAlJKX6T9cq5Mx2T2bPxaTgGpyRMCji4wo+vHz6uZTybhW7i7Ai8deG2xQ3Jhg6dyMZbdUAeqOAOJj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389586; c=relaxed/simple;
	bh=RQf4ezBxY2reacGxF5cZVd2pmBQLZvfncfJ+VC7Khjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6r0OqzQgH6F6k7+FQrWQuLsZ7dvcEzhFgfZTyN/XQ34YnRZLP0/f+4q805L1bq5sBu64kvM6rgGSSTveByvnS90st3Q/KqkS4+y/l/ChhPz0E0dse0gxFofDuBVGr/32s/q6sZiLQngYmSV4j/Iu1Z9Qz9uSKWKIbKZadZZP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RaRKX8QL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g9R9woL3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E7jAKZ2497501
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TlybsUjaJL/
	5ORjaGpRQjVnQof5l5N9cvn8daqYascI=; b=RaRKX8QLNA2xqseyW8p2sbiisld
	lg6NL0mWNWkEtp0BRnmasehsiGNN3o1mnulgU+aeOtlnR/Hy2ESZH3vmOx9IVedv
	Zn0JXi6vz6ZjI1Wn9UE/1WHCTLtP477yEz8BJSH9wB8GIdVr4VD6Dpuc8uXft++/
	V8FllAaj55TOQrR/7rZzDpOm2nekrMA1+QmIjAZNnC9Ls/YuWw/upcNfHpPgrWgX
	8S91EtVMWXTvt1fJZJCIHurBERX2XI8v7NMIB97rcBYsNCLfXzS+2wtU259izGg+
	DI9ancdL2lqBdb3o9716WGgTLL05VQTriJsFlxeMqfWGfyNXnDt9kjwQS9g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp16x23rp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0a0bad5dfso49518985ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768389584; x=1768994384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlybsUjaJL/5ORjaGpRQjVnQof5l5N9cvn8daqYascI=;
        b=g9R9woL3/8ztDIWSLCXcqOiD09c1a3+WIsZh0dMTPYVnCg4lggo3MPj/EWQqA2dOUt
         FrcUwokcS11tbUo3DbToiE0rnZ8VriOalADHqx5DM6gSzXz16LGQTRnEfJeuDrYhKGyr
         TFl8UqcHvqXM9fKupK+C+cvyfDNGyTtnkDiDSkiFalQq28yvM1LO+d6i4k/jUXnJAdkQ
         VfmcQxEbzDeiLGkSQoA8iRZiZ/owvjZI16dgotd9wAW2sMIvuBwN266qS9m1y36LphGP
         h0LrVwbBnvKzUh0bolK6iDGg9J4nu6Q1bteXgo2Yn499jjGdOyzyeq3o5ze6yErjlWAO
         kjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389584; x=1768994384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TlybsUjaJL/5ORjaGpRQjVnQof5l5N9cvn8daqYascI=;
        b=fRObum2pluR9kdbdUOvyUNhCOsti5oGUxGlrCjclMPso/fqDL5h3heyDB6YwWChbZB
         Ft6aaGLVTCL5QR0dVEuO1oBc9y//EVdwwASDzS1nFruWqXPmKDMjczjzTXnPPAgb9p7V
         yMZKBwrH1plCYRwyXWoKrD1412dx5rqyTpchvSPuDxC/vLBj/omrVqfFrkpY5pANgVSS
         tt3B+u1a1xIxBIIQI0FlPAX1ciaZnR/IuJTA+dEuXbQm42e14CK3wh199qEcRpe8LE1f
         8JqSkUo3QWxSl+j7FKr8j8X0ZZ66W97XawtWVhpxHS+yl4FEkVVfCjBMEH0TQq6eDoAu
         RTRA==
X-Gm-Message-State: AOJu0YzhpVFNk8SPEQczohGAfxdNb9U4D8hlSGlUDOwq2lsd4YoAlGHq
	LfRZcmcwA6akUXNxCSanX9WcWMmskx7dOiPJ1V98TGCoPcNBQ8qkewbFLcltpmlOq7u94fuWIz5
	siNGHsCJ4Hh4Md/hz1k/uk/SSZQkB1k6huqxqXOObpJlfl2MnvO9c84RNhDyECV7VErLRIg==
X-Gm-Gg: AY/fxX5WB/RVH9kkQKCnUqccz/OwlBHFzRn+1N8Kq54tEuFs8qPDTmaoQeRpjerjkbX
	/2r32WzKFlmxOgUWhqWy4Z5/lsM5EkutwvwFaFJ97sAgJoyyUu2w+p5vVRYPJfwNiP1wTK5IB6P
	4IPTa8bgT0S+iltUsJ3FB3QYMruJjHLAV1Ds5RHpJ91i9enpfnlVOtGDVO/d8rc+lx4u+4EXYkJ
	KHiOo0CO1xwyteHvMOT/pFHKgiE4eM15WTHh2NJLE6JMJRnXZ0vJnAFqydjsAEGiWIli5RIi0UF
	0ctzwSYugRF5eqP2HfGS9W/Hb/YadF9EamYtP+CAflCd7uRm3cYyPoWaUPpBx0EtFue5ONdLOUb
	ZaPS751V+Mx4OPXDDgmamT1X1hmTPL/UbXJfmJkP4sw==
X-Received: by 2002:a05:6a20:e290:b0:38b:e978:ca7b with SMTP id adf61e73a8af0-38befb00d37mr2137655637.36.1768389584027;
        Wed, 14 Jan 2026 03:19:44 -0800 (PST)
X-Received: by 2002:a05:6a20:e290:b0:38b:e978:ca7b with SMTP id adf61e73a8af0-38befb00d37mr2137622637.36.1768389583444;
        Wed, 14 Jan 2026 03:19:43 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22402512a12.32.2026.01.14.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:19:43 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v4 9/9] wifi: mac80211_hwsim: Declare support for EPPKE authentication protocol
Date: Wed, 14 Jan 2026 16:49:00 +0530
Message-Id: <20260114111900.2196941-10-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
References: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ng6ug7pHws9fGnKEijZM4AaHn5sBDtwR
X-Proofpoint-ORIG-GUID: Ng6ug7pHws9fGnKEijZM4AaHn5sBDtwR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX9ab6gdG986xl
 pXMge8mfMDgqz8m7GtJ3xxNAzd8lYB/J6hacOzfvranjpG8awhm/Y2cFuB95/zxvBIcWKQmDzXu
 DJ+qhHbBeFdg5916ql5c3ETfy3LvTjyVrWRJzucMONPckl5ryHFmX5zDLgGABYxpwC1F+x1mU8V
 5yK9eI69G4rroPT6GN4+fTYmPLNbLXKluamYx8BVNfGyjdQ/g7fOlbiAFn5fUMgm14Y8P5129MM
 qvShyol48RfDLUg5S6icQpfA8GiTZ7odUECOsGy4kZnblRWvzNYAZzqvXxuZFnRfZXO71K2TGgH
 fWnBvVfU/htyfrAkg5xbcdBJ4flWlF+deTrH9RAgw1/8TXrWZdlZfeLwr9fa/97cieTtyx7EXfU
 BesCfaf1+CJp6st0aQISX/sDOE5X+OEoDVYnLC+koZRCtXg4Q5MZawZ26mIvvutaArEEnQa2Fpe
 XmwA/esIdu1p2WM/Lig==
X-Authority-Analysis: v=2.4 cv=JvT8bc4C c=1 sm=1 tr=0 ts=69677bd0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=a1T-8RYyaUdGYqk8DgAA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140093

Advertise support for Enhanced Privacy Protection Key Exchange (EPPKE)
authentication protocol for testing scenarios.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..88b2f74cd45d 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5640,6 +5640,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_BSS_COLOR);
 
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_EPPKE);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION);
+
 	hw->wiphy->interface_modes = param->iftypes;
 
 	/* ask mac80211 to reserve space for magic */
-- 
2.34.1


