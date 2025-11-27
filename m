Return-Path: <linux-wireless+bounces-29377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A398BC8DB38
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 11:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23D254E6BB7
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC58319871;
	Thu, 27 Nov 2025 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UQY9Oyjh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cH1u0gHi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8F324B3A
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238300; cv=none; b=SsMBT+yurTuRZ0ap12IoYPIbF6pU+bDMOz3GH+UchFkRwwQknYuXLLoV5kXK9YdcyKDZ+VNqJqvCa6kfJEguDGcDxFM3+qT4qTrtbeEkv847ythe/rIevn3aFyqMxxHS2GGApCOA6laJ2Gch05bZ0O7jXJ+GQsj5ApYmDqNhiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238300; c=relaxed/simple;
	bh=eSckozu/DfTXaI0BNfk761OpuemQm3CUTEF0IhjYBYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dYYSbKOFOEJIS8J+r1kBdZ3g4mY2GgAsKs6W96/cRexVHYvGwaj+0PXAzAzk89NuN+r2DO/b4uSNCd7XsET/WWmGmmgI+ZtGk4/OVOm16+IfIuv4xfpiVtncr4AqgQ2cKh4DzhsQMNMVUliR7az+rzzRKSphxKZTtmEwP6weI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UQY9Oyjh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cH1u0gHi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARA1VZk3840085
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 10:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	do/L153z9F4m5vVk2FFCPmUOwHsWw3qA6I3gLpuJMOo=; b=UQY9OyjhLB50/6Gj
	UVx1JvLO8COtDdeqy7r2boTfF0s6d9NCUCMHByInFW0EdNY/lctLjm/syYu5gRlo
	kHWk0ZIcRcxeK87Xo81MlLPMQOfq1K+rPvC+e8eIup8EnY9pIknVtIUaAVpdM+Ly
	6fnBPL00nLo6DgBuJ0hsDMkf+rFIKrnYJYSzDWrFqL9fUmhUjdcxvatcLL03D+AV
	nt2LZ4uMQUCzdbdqpSyD/MIXuCRsJQd3bgm5PFr2ppBpOB484ZwlrfhCh4ppiDwZ
	DkxeeiTd96+n5IfkI0qrcY6VXiL9S2Rwp/J8DSyIGkMLdPS37nfJA8EpdkDyQCqb
	Vo98vA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apdj099tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 10:11:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297d50cd8c4so22278495ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 02:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764238297; x=1764843097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=do/L153z9F4m5vVk2FFCPmUOwHsWw3qA6I3gLpuJMOo=;
        b=cH1u0gHiwUWXEPiV6tM9Xms9KsdnpbbSmzN0ZmlWBhBxqVC1djJWMbw9m/qUc0uMID
         6MzDvljkfIkCntINajA1Y87axXD5RP68fbpicNizF3HlHfwz4QUPneDKXWQFexQpt/C4
         lsT58RAzwa0OI3EwVsAj3nXY/SWh8c7vBFfDb8l4cPvGsbPIX4DiQ3soK3gvbCfq7X7I
         nffqAHjxOdLvC9BC9CGT9HgawLhsZiXYmjCDP5Y+sK5g9gHrv1S5J1OJFbw3OlGeWnw/
         T5mnE2f9E2ZCRajYxWYjmbWgOfhWI9oigrEstvI1hVY9o07vsLafc2eNuo/FKLc9tZ1G
         8UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764238297; x=1764843097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=do/L153z9F4m5vVk2FFCPmUOwHsWw3qA6I3gLpuJMOo=;
        b=HWN+HPAvrF3yZ1WyU1bGfwbZr2cCUPazQOWGwptulB4zkb3tqDR4YeTKjUqhtTJVkJ
         Zlhg0wyWDcIPTH7Po8E8fxL64gw9BI2F+T/fnHERjqlkEX5hWLc6xlTRh5yR4e9DR5x0
         Op698Db9L3okv3CHpduzT6XiLu1plwO/gaGz31WrdCxfj29sQgmh1kc6eQGQCpZAvf/B
         37pi1oItTKrfTEVs96RAEPPCsSGGgf8Xaz7tMBc9cg2GaAR5mw9cuWPjV4dvXrY1pcKw
         a3+yB8dSwA9jw4glXYe8S7q7NgXgqKuWoj/DWWlTYw5GjMztF6eIyixahoQEerLVeoKq
         LPsQ==
X-Gm-Message-State: AOJu0YwcvE60aZgKfD8UWNXeO453TO198NOqNzdoly9CRCbh4e2q5Bdl
	k4l+E+YCZBFm6soUI8vmLohIr6kj2EL4ifop6vffwaLfxGfP4V8JBeS6R7gVDyOF5+SrJ117mSY
	EaNusyd+6PE1PpMfS6W+WcexpsNOZjoIHw7fo7nKRM8iUzDihWOylR/3IU7Wxp5gjLygOcQ==
X-Gm-Gg: ASbGncvbzSf8ZU+Y7iTr/9JDIM72bowAlrz7ku6rTjieOyKnlMh4tLUTh57fqDA32cP
	hqGRegdogCZESx/kpEIIvVQpGA0cDXUmQ0UHdKI4rkpdQ+7zbujcnEAWpRrqscy9GZ2Kkj+SWd8
	oWmGU+YV9z+oYEm5JqjjHahTw5nBnrUalHjQOOJDvTWcBHXz4pCfz9c3ZMD192P+H3PaxhD3H+m
	jg9xVty4hmn1bmpOmP1c/xQGx+09HCxz4b7pdgmYOy1hJjWdegdB4tdN3dDMeI9DmtaftSuoZkk
	gzt0JaSDuDaRajnk+b0D/FHyQYCN7UJrtFF2ervzLR9JvZl8ld+vXjNjr5+KNt8geD/2xj25UTm
	X7Jvqto6FQKK9AGM4J1SdsKUIreR8iaITOrP0tJh8ZxTzU/bniUvU8f6nBvyAm30eaa49dd2Z5i
	gQhvQ0UWnSRLfQRK2u5PcBCVzbgbP2L2WTM6CmBimtlA==
X-Received: by 2002:a17:903:908:b0:295:5da6:600c with SMTP id d9443c01a7336-29baae4224cmr122372065ad.2.1764238296960;
        Thu, 27 Nov 2025 02:11:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEymcN8Taie7E2KLVTDVQM0rXHPDiilYubAXgHTmg3WqXD3G3Dh94WikOWlTw6A1LNacmvQZg==
X-Received: by 2002:a17:903:908:b0:295:5da6:600c with SMTP id d9443c01a7336-29baae4224cmr122371785ad.2.1764238296586;
        Thu, 27 Nov 2025 02:11:36 -0800 (PST)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce44389bsm13586425ad.32.2025.11.27.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:11:36 -0800 (PST)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 15:41:24 +0530
Subject: [PATCH wireless-next v2 2/2] wifi: mac80211: Update csa_finalize
 to use link_id
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-stop_link-v2-2-43745846c5fd@qti.qualcomm.com>
References: <20251127-stop_link-v2-0-43745846c5fd@qti.qualcomm.com>
In-Reply-To: <20251127-stop_link-v2-0-43745846c5fd@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA3NCBTYWx0ZWRfX6hDl2+b+qMSQ
 lF7Y50mS9kyYE3e48mf6yalAOVRwSrH0qgzwZLfzU6zwm8knb8EDs3MmPdclzs9k89/paBGHI95
 5tOxxRLX2NxJ2c6tv1Li2ZASk/1yPUiNF/l9rYtORZsyJTtF5pysj7BXLuSZPzX35Rw6gA91Jqi
 RV0VsUHWVTW9Sd4NJINai41rwOSxpEXpu8sofk8tpD3WYKhyguc4gozbEoFtIbuF0dTeYDidG10
 PFtVgzk4Kv/mU5OyJlIqSpo/zXrnJ3oC9xEFM8TB6ZH/zFUac13hQm9miUtDy87XqJxwmFvev0D
 0qvIuoTYp/zs3iiorlpK1T+4MCxfdRWRtflTVZOx+JJ0TWsyi9i+PKhx7P5Lou+fQdZiuDJ05VK
 thnIvAcqH+1eX5KAV1O3Q4gIoEyTIQ==
X-Proofpoint-GUID: X6Axu1_P3YJwokiF5LX6_T6J6mIEE17Y
X-Proofpoint-ORIG-GUID: X6Axu1_P3YJwokiF5LX6_T6J6mIEE17Y
X-Authority-Analysis: v=2.4 cv=PJoCOPqC c=1 sm=1 tr=0 ts=692823d9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=llnQJO30CDeKp1v_nCkA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270074

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

With cfg80211_stop_link() adding support to stop a link in AP/P2P_GO
mode, in failure cases only the corresponding link can be stopped,
instead of stopping the whole interface.

Hence, invoke cfg80211_stop_link() directly with the link_id set for
AP/P2P_GO mode when CSA finalization fails.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b51c2c8584ae..4be80d87ca1f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4161,12 +4161,21 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 static void ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 {
 	struct ieee80211_sub_if_data *sdata = link_data->sdata;
+	int link_id = -1;
 
 	if (__ieee80211_csa_finalize(link_data)) {
 		sdata_info(sdata, "failed to finalize CSA on link %d, disconnecting\n",
 			   link_data->link_id);
-		cfg80211_stop_iface(sdata->local->hw.wiphy, &sdata->wdev,
-				    GFP_KERNEL);
+		if (sdata->vif.type == NL80211_IFTYPE_AP ||
+		    sdata->vif.type == NL80211_IFTYPE_P2P_GO)
+			/*
+			 * link_id is expected only for AP/P2P_GO type
+			 * currently
+			 */
+			link_id = link_data->link_id;
+
+		cfg80211_stop_link(sdata->local->hw.wiphy, &sdata->wdev,
+				   link_id, GFP_KERNEL);
 	}
 }
 

-- 
2.34.1


