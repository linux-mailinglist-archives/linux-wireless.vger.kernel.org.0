Return-Path: <linux-wireless+bounces-21690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF6A92D70
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722A01B64CC1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0D215057;
	Thu, 17 Apr 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIkC8FB3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227B221573
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930664; cv=none; b=Qn4gsPMrXiFQYNRfT5ucaKzUhGaCVFlikRrQgQbGXUgfUtpXX0Vcr8Yu81qSzX06KPxEZ5CHImKJ6AOc3rE6/CSFUUBW/jnBBSzdh5nmWHJN3Vp3hGw4DUDzVnGZLdTl2+4mvZ8iY4QL+DzJ7VajuNuJ3QVdYLaAvTSMd/gq6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930664; c=relaxed/simple;
	bh=oU/uRhS6RtJfMUaLoEPIo1iHvOgbA9b+135J87gnr28=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A2TwiYH4HrYSTB+mRwrhkxwvAIEWrnK7fGgoWC5aIJVVZzGAap8n2kJ4ijIDK78AlNKXPEQGi9jdMB2vVqpZQdRHjE2EzRcOKnwc9f3yurfRRXBygpTaPIlFBI67N2jV16fgQb+2JhuPB1NgMHzKLGWS0wOOly7CEGHgskalvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SIkC8FB3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClJXj031946
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UrZ/A8qE3TmNhXxPvxfyh1Id2vxVljbuWbBwYswI28s=; b=SIkC8FB3sf98GXsq
	39pQcmMiJfA16SD8n3DhlVO30KkC7pKcxXrYiQ2a3qni6DUKI1ddx6M67Vo+Vp6f
	+Ezur9b/gkjizAJkEsagKZc/pn8T+fdi3+oTrt+Fts6i9GwubIKYju/nMqABhOYV
	650EH4fiLQ/fgduj+KnsJkt4CuHyXioBLPK9g0EvzZWafbPQsPUns8yjcsG/UYkH
	Dq2W9AjfKDUjR+VGZAiI2sx1L42qf+TzFwm5ofujIoYC8sXPfAz1H1tvwJAdUNff
	NUQPDgPoqlP7i1Z6M46ZjnioOr9vzjLcjezkACVBDrG+nID5J3EoZSVdQNHkWAyR
	hnN7Gw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wredd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736abba8c5cso1605505b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930660; x=1745535460;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrZ/A8qE3TmNhXxPvxfyh1Id2vxVljbuWbBwYswI28s=;
        b=Q/6QM1ixb820p668ZIxIKFfHnRtip7z9aVfydULpDXfNHX1R5drnYxhNMaWnh2H78z
         UIFyWUi+Sh34ZE/hn/2hFG07PhjNaFsBe27DE4nTujC8EyQdBpxRQuhy4vszzx6adlPU
         wKCiCwB2Y/lEeEcoVkFqqe6S1m3le/tbnumeAystmmugKdRIPWDKq1s+4gExczJWIggE
         3RKc+PGj4GdkJveBrZ8JVKKmMavDgwIlogvPHO/yfYZ/FXKkw+5AvsCGwATA7znLGWw6
         GtIRklcukxhi55oP97/aR7NmtOKTxXyY9H6SNaYyuENmFLSpJMshfrsIFCNx9tILUmlz
         pIFg==
X-Gm-Message-State: AOJu0Yw+6b1QaqJ1n9uU9LCHpBKfqL9l9b1fixTlBHSl6T549JtCYgxH
	TBHP7wLuQ0DQ8u4vPIlzVMshZXJQKg4GMAK2DRSYsPiJO7bRG9pgEm5a3Z8MW9jBNIY1pVyoveg
	J8wSkiicLXehjZ35pNne21RSxCiUF+Yf/cPtgM+nUUWYD8L6BFJ1kqQco3ln44mfAmId+QeIeEw
	==
X-Gm-Gg: ASbGncso4zRGBg2EEZOX3vwsyAuBwvoZzNx0kFR3OT7uhuKC+yO0lGr+O/Rw8aPMliS
	0YncOuxEWtF7GikijHYcz6mOg1OAvCPggiMTpcdu6pYfBCN7yxnWoNrkDNwRob89QJD4hb0yc9U
	tZBFSjcEA1Wqg5e96dqYZxl5Vfn2ehpSp9Qs9ED3Ay9dnPYZTipzkIoZsJTOdt0BjxZyb2X0xK7
	ulRYobTtEVKhpL59wKUYuJ0mwVaxV4R1SVdvLObXXYOfz/tEK5nqXNhPF9I9kgTXofeiJ/ycJBp
	zmsOK3v5DHXAry4AvwqWZXiXSzxGBp+EksMt2kNUoEO6xzKN
X-Received: by 2002:a05:6a00:e14:b0:731:737c:3224 with SMTP id d2e1a72fcca58-73dc14a56dbmr637979b3a.10.1744930660051;
        Thu, 17 Apr 2025 15:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu+SuEbiUZR/tcgbY/kyQP+XQi6CyUvoWlkjtezDxDK+rygvzSl/3PJzW50WKH70r5Mk6l0g==
X-Received: by 2002:a05:6a00:e14:b0:731:737c:3224 with SMTP id d2e1a72fcca58-73dc14a56dbmr637962b3a.10.1744930659658;
        Thu, 17 Apr 2025 15:57:39 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250415195812.2633923-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250415195812.2633923-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: set proper key flags and
 MIC space for CCMP256 and GCMP ciphers
Message-Id: <174493065907.1347382.7895541725664427227.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=68018765 cx=c_pps a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=0LDGy-T4u2czxLXLstwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: g704MrDnIM72Yb8IwXkx7Wl88drc5-DX
X-Proofpoint-GUID: g704MrDnIM72Yb8IwXkx7Wl88drc5-DX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Wed, 16 Apr 2025 01:28:10 +0530, Rameshkumar Sundaram wrote:
> Currently for CCMP256, GCMP128 and GCMP256 ciphers, Management key flags
> are not set properly and MIC space is not added based on the cipher used.
> 
> This results in unexpected drop of protected management frames in case
> either of above 3 ciphers is used.
> Fix this by setting IEEE80211_KEY_FLAG_GENERATE_IV_MGMT flag for above
> ciphers and by reserving proper MIC length for those ciphers.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers
      commit: f5d6b15d9503263d9425dcde9cc2fd401a32b0f2
[2/2] wifi: ath12k: avoid multiple skb_cb fetch in ath12k_mac_mgmt_tx_wmi()
      commit: 0ca04ad0cdfb7ac2ebd79dcffebe4806e8707a74

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


