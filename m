Return-Path: <linux-wireless+bounces-29381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51238C8EB12
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39BC04E1D86
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADE13328E5;
	Thu, 27 Nov 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JWDvBX8I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f7w4eYjg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA05E3321B2
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252391; cv=none; b=DGbiYz1IhaOjJiHcwydcq6iTtrCrGR2F+lnYpjekMFyhJNAq1Yz3aE8Fp1wGu2a84dLdc8AMg9RADrCOgqtoW85pe1xeDSuFOYPPcWQqk4wj7xKNoT+j3nqTtE24JhkNUoDjld/vMHBEUHYiOH91VSh7HBZVJeoCorGHgbnIy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252391; c=relaxed/simple;
	bh=z5qBE15MMSB9hxkb/vJSIrhZ7CgvyiXtuUlSsKrtG6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rOBTQ0nv9mnajhnXuD9y7GRQYR9O9csdWhLMhVtoVH9pJZDZicA/l13+NYkOZN1ryxrugcYAiNFWu8SUQ2jMVDul7plZn3lGOaXvRwOS87TUNb4WQmMBgNVkTOMSOF/wE2OQ/FhPNo9kxzjMxxAh/6Vg6brdYBEbhpi+WPJIipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JWDvBX8I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f7w4eYjg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR9sEHl3840173
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 14:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=o4T4SW4UDFhahqvXEU1rmAM5lP8u1HXRqYP
	sI4u1qVY=; b=JWDvBX8Imwxeqzvw4hCqLZg7hTiEoMpJLV6Pjb6c1NkhlK6lSxT
	CcYyu1JjO8/cvtTIb4XS9ky0uhL4BWVbKp45UjDSMjMOSRg1aJYls6V+0xyDKVtG
	NFWAzLkXsyhY6AHOkQiGGKrTo9hcU+oM1yWHo6pHON/8R7/BrVWW86hjX150L2+q
	s9OTAIM8tFRzcbW7X6GHGgUiEzyaMfdWW5uqRP/pun3E4pr/5GAgIJPWobZU3JCf
	wI+gAgPjkHgdjr/AhYocRsRR8vVIunD0n8STbaNoLDow/O4UYrg7XH823d8bf/SH
	kpzvF/imyF1yvhsjtMPyHyl9rK+gMwHlyyA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apdj09v2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 14:06:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7be3d08f863so1312373b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 06:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764252387; x=1764857187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4T4SW4UDFhahqvXEU1rmAM5lP8u1HXRqYPsI4u1qVY=;
        b=f7w4eYjgn1sWuvfg88iKis+qkyPLx6lPmwMN1NOaDyeAqjmOWOqKIltOvZKgUrEZ8E
         oJPeIYujZpHxJ0Yb9t/qU9uIjdWOyzHi9ppEOUaW4cJ/An2M5G+AJ8pQdtlqdCZ5qujd
         fVQNBEfMGQdq+uUBIMQRxLzthA51dC3vcMwB9rNvZ3zjXoyZN0Oeocs0nvla6aSIZa91
         2OlOnqqfonV4lI5LZv3Tubq7+MeKZimwkG2i0Vk5Dk0ckoUt6deAXoH8J24x36EtXDn/
         Cm1jqw69D4WtkhcuuswZ2aThu4X7pxo5paujivXMhVVHaLKIa4bFaU+LL0JZbg6LnvYd
         it1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764252387; x=1764857187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4T4SW4UDFhahqvXEU1rmAM5lP8u1HXRqYPsI4u1qVY=;
        b=bMUXgykb+yBbqw6UNsBFmGX1qiqlx+YPWs63dMtn7pGGDLuQ0w4NLlziyJLDXca5St
         xf4I+qi5t6mVreWgqlVWGmgL2mMfSZG2lM76Rou/LMtlcrzGnn/qUI+VvxB/j8ZybqLb
         /eSU7TZQtROa/rZmjTv1N4ra37C4YonghDAFL6yz8kWxGpYao2YoI/gH/k5B+iMu8GN8
         79QyKq3UiqpX/zNJaniKTfLwfmP3KJMnf88mwcVviKT7LAG6wiXIJivSYBijpDV8abTR
         UjZFPQ7lh0slPih5y/PaAM5aj1BaheGECUo+MwbfF/RP+YjD26u+NqF2SX2330dt6RcY
         440Q==
X-Gm-Message-State: AOJu0YzH+uPEDFmdKDukY2fEkP1bTg0fpxA30wHR57BMLQb7cdA6YaYo
	VFpVCiXSqaf2dgPX+4NEgV0PI6sCJLFK6YTGZdtws7elQ46rY/EXdm8ofOd9H0Nh8Q0xFN/WMcN
	Wq+vXFC3rWlSe98M1qMF8oRbNY1XZjt/BO7fMVYP4qVEZsQB6vCfqmpewcdTE7XqH/67ysX4HVd
	qEiA==
X-Gm-Gg: ASbGncscpEaBD6bgpbnYLiKS0H0WA43N/XylT98maRTmfXEQMQpeargXcGQZy9F9rjA
	GXAjGoYvJ1VkvhfAITf0sHx6ZCMvRz/dl6NowODvCbh3nJLtfviI4R7yMv7UWTEpmtrRGM2O/Xz
	ycgz+K1DtjFbX/rhMg6XAuG4DHGgxH/3JzhPzuzmtDeuW4XeZDyheOBiHlLnVtHjgkWaRaAIzVd
	8QK4xUd5ERw96MiiSesMbMrdoQY+9GSz+fqOyF8T3i3ZZQ7ZYCJ7F/TSa3i0jqwlc+2uRtG2Pxx
	wHfMrSxCHJHVVKxbI46wNX2sLlTD8iaNXRPYjOYq4Aekmg5zxTUIMsCHUBr6GfnzJN36ltXLN/Q
	H2orfNsOBPqV8Jka5rFQsI6B3bF/5oXd6tjtJqmcCtAEsHf4xLyGqjCKks/+xepnah/ygGFzwUo
	U24ALnRoBljxvwJGsrkpRmd7IjQrVFu+f/bmg=
X-Received: by 2002:a05:6a20:9184:b0:340:d065:c8b3 with SMTP id adf61e73a8af0-3614ed971edmr25111048637.36.1764252387313;
        Thu, 27 Nov 2025 06:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmWIBDfOlraTYS8FG6Rdu5y3SdkMGwiJEcic14xTn2Ssk/iAlvqGjMDY6tCXRQBWz/mG0jwg==
X-Received: by 2002:a05:6a20:9184:b0:340:d065:c8b3 with SMTP id adf61e73a8af0-3614ed971edmr25110977637.36.1764252386643;
        Thu, 27 Nov 2025 06:06:26 -0800 (PST)
Received: from hu-surapk-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fb24942dsm2125631a12.6.2025.11.27.06.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 06:06:26 -0800 (PST)
From: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
Subject: [PATCH wireless-next 0/2] wifi: mac80211: Fix issues related to sending NULL packets to probe stations
Date: Thu, 27 Nov 2025 19:35:53 +0530
Message-Id: <20251127140555.472327-1-suraj.kizhakkethil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEwNSBTYWx0ZWRfX//a8vLMYHC+n
 BJGlosX4cbLqVYu7LKJPH78tkTBkhYyU9E9QblCrP1V7fhOXgIhNZ769YzbMIW2tQeJ8rUcggQM
 YETGLSf/8exNVR08WC8Wd9dFklZfzxzGdHdLjHqOuPhAhfqQBJSj9oTGJwLeLCcywcMtHcLT0wk
 FJyviTsnhV/nfSA9WjfXOLl7kuprHHAmM3c/S1RPGQsLeE7lub0ybFrOC7mBJNFynjJUwz82mxG
 FhHAa+MBuODQg94FrYOoTD5UZ6gZAtVnVj72PsmoFaDF1fF/TFfuA+xDtbUjsYZQnCgBpdIktbv
 dGBrMVK65xlis5W90MlVrgOwQI2FM6RAWT6ifB1gvX5ZX8Ozs8eO2PF/vMVBH4lyerfx5CfWjWY
 q6oWHi6RuQx8FkZtCdzmkgna61xbfA==
X-Proofpoint-GUID: hp-hDuyun5uVqA_2ra4jpo3TZictmCVe
X-Proofpoint-ORIG-GUID: hp-hDuyun5uVqA_2ra4jpo3TZictmCVe
X-Authority-Analysis: v=2.4 cv=PJoCOPqC c=1 sm=1 tr=0 ts=69285ae4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uAuzlYbcAT95frd4iJkA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270105

This patch series addresses issues observed when sending NULL
packets to probe stations.

Suraj P Kizhakkethil (2):
  wifi: mac80211: set band information for NULL packets only for non-MLO
    stations
  wifi: mac80211: set addr2/addr3 to link address for NULL packets to
    non-MLO stations

 net/mac80211/cfg.c | 51 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)


base-commit: f9e788c5fd3a23edecd808ebb354e2cb1aef87c3
-- 
2.34.1


