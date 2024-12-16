Return-Path: <linux-wireless+bounces-16420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83119F36C3
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 17:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BE41892600
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB12066E9;
	Mon, 16 Dec 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kcWYU8iJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86D1205E01
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367865; cv=none; b=V5qm07YlHpezDEMaBbcQltsbXacjEd8mUSVgsJ/lbvq2k/nzlK+lN+IJCvQrac9F738m7W7KELDdYARomCUGEpKE3/a1baohTJ4TWNRTXjL/hGuM56VuBP5aypiorLCHSaz6jmjRDLEzin4Aw0hJSH7MudGxnwWwnN2QnR82cbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367865; c=relaxed/simple;
	bh=2ucF+AEQvcgtC2INo8ga1WiOc1sBgnMjFIYO0/5Sg9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E8Hasj6wzXpV6glc8KfbPLqZwV+MBIutrg72+uJ2JxAkfgc7Zb2E/k0Xc+hxwL6oCMSbFNjnhYm5XFle4i1BKt6ixjGz7YoOJyhsWC41KAl0uYrUWlDsl8rG+b9yLsQQXCQHNx33QB+A+4NYuU/8xO/lcoUUvlGf0V5b4pDptk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kcWYU8iJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGBCWkB007303
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 16:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mpXHKXHw98BsiTXyomIpWXczQz8SYOfxnAMHA1bryRU=; b=kcWYU8iJMfU56ScF
	3R0RCmLZMntWj2tPiUBWzy1+/cRZSDA4g1+Ytl7BJnQQxMQnp4njA71LbwyVVqtU
	XJ2upeHPChBbO2LLpbjJlB/Arb32mKOVCvO6q3eAmKlUigy8M239HNoJwtaHTltr
	LGHJRSJvATcAU5c6NdVZvSWKdXgutawjVaT/9ainqlHoRnIFH6yQWKEQmCe837cb
	sPtlqKoRAYlf3XmbjwrsQk6GoQJKWFY8fUE4dU3qlKWJxdQnpP2JbqOdieIl8OTq
	HomKjaNb6cCtrjLOZpFoFRTrza4wT24/So5YdVBjZb/4l/jl5Ad+jVDrelV7AB1r
	CDMoTg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jk4ngxs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 16:51:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-727c59ecb9fso3838805b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 08:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367860; x=1734972660;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpXHKXHw98BsiTXyomIpWXczQz8SYOfxnAMHA1bryRU=;
        b=pJfTdrnKEROmuBfO5f4qpdWP+UNaaqWpZO05YPgVIqlWMt1NRvOdB1K+S61kwviPMS
         lDdmT3ypkXbx+vSuN0TTj1tNRBB6NEDlC2KzCeQQptG4YZG644EiVKwDBxJRSS6lyRoJ
         GRMomKPpcxEjSlx0gCRpx8vmPNSQuGggp6V3mBAp7wk2uxxlrjvFnqpQ+DES7bRwi0CG
         mvEJjbnvyG46vpnmutYvT6AEX3fEykMXCq91eSemJIG2ELz9C7qmdFs4VELwzLhfg7e4
         d2jpFuMfJShU93FR9alEunVuoUrdc1AzM1k/vuplmIzDufuiAxHyvBYMj1nuPC9YtaFo
         69KQ==
X-Gm-Message-State: AOJu0Yw2jppD+D5CDSWMpd8gv+KRuePQcwkTegBzf6HsI7hiOw/BOUb/
	XFDQeZsuWQTVuCEKrs+kkYz5OnbeD0+mTS15/u2QgVaOSig/V8zDkT87e3pl+23hNjfZx5jSsZA
	ckdTLoc8dumpZdBUAqA2HlKTZDRQVJZ582zqESD4Tnvyk+5rZRgzBNIu8MsHo7LZJoQ==
X-Gm-Gg: ASbGncsBuBcfrHwDdIiNATE8FGDpt/kxPtxBGxAb+DMNfnD98gb1zVY0iMqfBBZL3hW
	tX1i0vSXUYRoWEjcxe3cytjDvewXe8qvsdWlnX/28BZ0QZmdQm9wLHhEnpGODIQG3y5eN6LRBsi
	EZCMUb0EkvPaugn+0NqKPhyDTuqPYxfKp0gN9+65pNe01vVdj4jOSHQN790Qe+F2+B3YsYOPSxs
	5F3qbYf4xsmzMkEs9h1VyBn3lrm/iFYxoEX7wCLXDZlaNVC+xmvrJ4Pa+xHdxY3RjtpBbHZ9szD
	1qFHHb84ocNldP0gHQ==
X-Received: by 2002:a05:6a20:a11a:b0:1dc:bdbd:9017 with SMTP id adf61e73a8af0-1e1dfe43afbmr23646935637.40.1734367859984;
        Mon, 16 Dec 2024 08:50:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEV8A6FtU8/weso+KmitSxASicvji+fw+OyGjA3CopQT8obo7DLsthuhpEbsRgydCESlYvdPg==
X-Received: by 2002:a05:6a20:a11a:b0:1dc:bdbd:9017 with SMTP id adf61e73a8af0-1e1dfe43afbmr23646896637.40.1734367859552;
        Mon, 16 Dec 2024 08:50:59 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bcde43sm4937486b3a.194.2024.12.16.08.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:50:59 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20241211153432.775335-1-kvalo@kernel.org>
References: <20241211153432.775335-1-kvalo@kernel.org>
Subject: Re: [PATCH v3 0/8] wifi: ath12k: MLO support part 7
Message-Id: <173436785894.3413746.14923997859754791913.b4-ty@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 08:50:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: mepOvz7PsFct7_Lq9wCHVW2DkUuE0b_D
X-Proofpoint-ORIG-GUID: mepOvz7PsFct7_Lq9wCHVW2DkUuE0b_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=934 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160140


On Wed, 11 Dec 2024 17:34:24 +0200, Kalle Valo wrote:
> Implementing Multi-Link Operation (MLO) continues. Bindings document is added
> to get WSI information from DT (patch 1) with the code parsing the information
> (patch 2). Rest of the patches are about configuring MLO in firmware.
> 
> Device Tree bindings were reviewed as RFC earlier:
> 
> [RFC PATCH v3 1/5] dt-bindings: net: wireless: Describe ath12k PCI module with WSI
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: net: wireless: Describe ath12k PCI module with WSI
      commit: 30e36fa89d8266d9221ee992d4f43553a59a3431
[2/8] wifi: ath12k: parse multiple device information from Device Tree
      commit: de61173d59082575d985c89a58db0e4055605b48
[3/8] wifi: ath12k: send partner device details in QMI MLO capability
      commit: 59d789c212eb9c11b02f2fd06c06cabb314913d2
[4/8] wifi: ath12k: refactor ath12k_qmi_alloc_target_mem_chunk()
      commit: c445894b9a0504727fabac0ddf3aab27d48b9fcc
[5/8] wifi: ath12k: add support to allocate MLO global memory region
      commit: 157fb81feda5c646b77d8135de6e29214fcd74af
[6/8] wifi: ath12k: Add MLO WMI setup and teardown functions
      commit: a085667ab1751a3b821ff926a08934d42dcb99d1
[7/8] wifi: ath12k: enable MLO setup and teardown from core
      commit: b6529891f04659c5279f4b58db230fdb589dc2ac
[8/8] wifi: ath12k: avoid redundant code in DP Rx error process
      commit: bdbb676320a22eddacf3188726b359e179b9bc07

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


