Return-Path: <linux-wireless+bounces-27505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775DCB876A3
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE1B1CC0CA9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A53302147;
	Thu, 18 Sep 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="auI2bXpx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B9301472
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239255; cv=none; b=BR2ad+aBv7fsQLKe4Scn0nbgTcEl0hUW2q2QPZL/HNvBizDhIqYaiCEuD8uPxHLUIlcy+1BoDbWgTQSQxFQXLe0Z+cc9adITsAMipDmoVsVy1yOlvOFteqTFPs+yoaxDBOaJVyXx0oHxsRtBisR5ouzhUQqF0/4z0nJZLXE5lCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239255; c=relaxed/simple;
	bh=u5dkiDLGLLpIEEL8m7otOp1bmRW2jxmvczE6U1udaAs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J2tD81GKEN1yJgy4lRzZrv57vcNWNxLKz8VRXJDMd0c66pLIaE8UM8yhvjNVZhGDA19gXaWEa8S9KGiz9FzOEw6rV2E3XORu2v8Uzt306APrmMdodsr2eGlgWmP+qynyCS8oarq8aWeES5Wi3oex/PG7Wp/ZK1TIEsp/M76+hUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=auI2bXpx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIRYvg029493
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W7r7Imi2vfNVSSFkOKQmhXkXZJL+oLzQLqzpBHTEulg=; b=auI2bXpxcDyOoBmF
	/facPtrg7SWI3WTk8sX4ORk/045VlCuojw+r78jcNP0lqL/t+ZMehjEqWL8gZanD
	0oaDnMMIlMARuYbxJ8BjgdLwR96Bl4jxN29pXcD7nKwO3AIRRIGnB+YQM5qEitLl
	1VXlNVEOKw0sojUez9BjL8SY4l3dncOptMKYu67zr95l9VaLCbLVP7m2tTSF0TPP
	RAgC/VsAwZtkrLHWCAjKz3nyuMnWoayIjpLzVHgqncftDlb6xgvMctylpBDgmL9j
	oaBlN1M/yEllqYIAtdXKSFz+gHbNLjmJwmY+uQXIfDE1pUsxyCgGyVxG37613n3y
	HLu+fw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy10bhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25bdf8126ceso31012215ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239252; x=1758844052;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7r7Imi2vfNVSSFkOKQmhXkXZJL+oLzQLqzpBHTEulg=;
        b=jpyIVYVWugQ8w5lJMaPjXUcJ6gO8q/QCozuCFZGksnqsp8mCTNUCI4zWd7h/qCYUY1
         mf6eEKJPfhN4I8OU69BaLMWG6pL8ePgIbHhxTgXSdQRJjZlkvZDLlcCBQvuu4Eh+iRzJ
         2HaeXATE85x7Rz5Dw6f6ehYBjYJ89J0eCn8NGbm07SJYoXZct5nTpatEWzb6hIvUqzYR
         lQhHOkl/oWEN7HZrbIliBIO5bzOMOkOSagUfOMYAQiLVy8zhnYEUiebNgX0UeFkhCxrP
         ZtjNyGtGbp0dcZSKA/uFH12eWb2JfBzawIVddXWGzolDkSI/Dmr/ScxjGIle6WNE1nsX
         CRmw==
X-Gm-Message-State: AOJu0YzUL+mceYm2M0VdYw/elf3UK1dbfICUSGdCPHGHASH2xxak0wM/
	c3ppnW2DskBApA9H8b0pilmsfRZPBsGMRFsrnPHj88/TuE2y/WsjKxeoIHJMNpXFOIGyUcsEmJz
	kqe43KNBzgyiEswTXiE63v5lVfm88Nji/oid9em3gM5Se52NO9QP1E80hu7jiUaZ0d7xcyd0Z3z
	vWyA==
X-Gm-Gg: ASbGnctSMAVrAYgGlfwvM1qvEtD5AFE3lk2vpDT0RrQERoRu3cduuJDaMPqEqtBqSWN
	EMIDHzqH/ip9FIKAbBX3HSf6rKzIfwyenvDh+jEkBDQUn3KiUcDEcZZZ+yeriCYN4oU5ON2YMh2
	aEFRdq5MLdrgAw0HXrmsVECado79O/dUWkvkzQ/JziUZmVTRmLXUJvfA3blDlxD29pO+HpYhdYm
	m1xWwb6dV8kbTdxrFXUc5ihNGKZWh04TIok2UwgZzDusnXKEoyzNRzs4w+PniRuRDR/DJbI93At
	fQ5O4eQShpbaya96Sd3H3U1bcmS/NKAOrS5Dt8319g4k+sthWbmgER/CFb013dfNzo6w/eq4CYl
	P
X-Received: by 2002:a17:903:234b:b0:269:7427:fe37 with SMTP id d9443c01a7336-269ba512857mr15663495ad.29.1758239252282;
        Thu, 18 Sep 2025 16:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD3D7F7WkpxU5WDuNIA4iddPfpHaW1boJOtIRz+2CMCerf3Ppp907ZNpE5jg4CxUxXkLbfNA==
X-Received: by 2002:a17:903:234b:b0:269:7427:fe37 with SMTP id d9443c01a7336-269ba512857mr15663295ad.29.1758239251845;
        Thu, 18 Sep 2025 16:47:31 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:31 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: Add support to handle
 inactivity STA kickout event
Message-Id: <175823925118.3217488.6929910029455029263.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 5Fkbi4r5wEfzJ3BNGvg_enF80IA0_uTW
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cc9a15 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=EoySuBRnP2zY1VZUk8wA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 5Fkbi4r5wEfzJ3BNGvg_enF80IA0_uTW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyL3I6UFiY0f0
 jyaICwPQoLsbW1QQrC8rdbELPjm5fJtqxJqluhgTHSsT6RfNiY6ZkQrAJgToERUH5HW5dKBAf88
 xq9TnReuJR/vi6j1YcxIi8p1K0hXvwr4iLRxKA+nMEVfg4RmdQSBIaS4wPDzrI5hxYr7EvOa482
 h9bJNi68EWNRWYXN40Xw0+bpu+7nEcpNwZIeR2a2rnr3LDOMRxhdfH9O9zJbvtiYpBLxgQu2ctt
 LMNo5o3uO5/JNDSQGoe1cTB5/UBg/XYzKkxdkZOn/hJgxKKkvjmtAJVBFNCie6wrS0KpRBuSokw
 wLW0wjtH1pIzmsXtbqBPj9escFZnw2eOJhN7sG+VihHdnR70LgSfwmMMB3Yp6CqhhpMjVsNvTEO
 BoYkbxxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202


On Tue, 12 Aug 2025 16:47:05 +0530, Maharaja Kennadyrajan wrote:
> In this patch series, enhance the WMI_PEER_STA_KICKOUT event by adding
> support for reporting the kickout reason and RSSI value.
> All reason codes are handled by reporting low ACKs, and will be leveraged
> in the future.
> 
> Add support to handle the peer non-AP STA kickout event for the reason
> inactivity.
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: enhance the WMI_PEER_STA_KICKOUT event with reasons and RSSI reporting
      commit: 59a2ef69ec1d0a754f9a229adee64c229f70ed36
[2/3] wifi: ath12k: Add support to handle reason inactivity STA kickout event for QCN9274/IPQ5332
      commit: 9891fbd9d8ec1710215b3c1ce1a5e9b3f33b5c1f
[3/3] wifi: ath12k: Extend beacon miss handling for MLO non-AP STA
      commit: dcdb05a43df9d2e40116a1ddd1460846bd98a6e0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


