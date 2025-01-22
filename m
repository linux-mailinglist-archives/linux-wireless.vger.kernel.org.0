Return-Path: <linux-wireless+bounces-17842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16778A1988A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 19:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3FC166FC8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48985215F71;
	Wed, 22 Jan 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i9sTW0Ep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2E215F57
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570988; cv=none; b=Fou0EwJ1WAnzyziwH8yaO1n1QJQil7kfITWRhmxj6e/wAZizA/hWglT+ERLV2lSTG8UUnzLecsXv7LECkNt2gg70sMQSsOylVG3XTc98VEf2Yzb7sYS1xyY6Vegupp48Z2VMk/7V4rfrn/vdfpRhGxVxa6bDX8lBZT0ywllZnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570988; c=relaxed/simple;
	bh=5a1K+A5dsNOYWqaK8R4X0HVWzS4pSE8WJIZrDvYwtfE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HEpmFgkBqDT7ZNY8/TgO63Z27mlipXsFXog1XCep063hhhCSMmTGQWkvgHbn6wTxeKq/G6gXoimpJ8RfyrrcV+QiLIrVF6L17pUI6dQFPopZyTibeoX2cWv1AVvwaPJPCTSNoc8Q3ss7FtWWokhQ9wjdz2k01q3rryZHRTnKQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i9sTW0Ep; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MB889s001910
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 18:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SJLJV6ONtrcfpP+rHoQCYGK0rdyIfz89lUUHS2Gm7t4=; b=i9sTW0Ep1wKdBedW
	nrTn1CI6GaeLCyUNrebWO95lZpXU0gwWxm9zAI/rWq5k+vXAanZ4wQpttZ7PZerR
	SOMinEMGQTLy0jfd1FIVM0lGy3V6xDrbpXwuH3kX+79FvIKGTlLKnFhL2D+o8eAD
	JOr2uSkFgDQ/9iV3YgzCKYgs0nlVDWaT29Xo1RvG4xzmb4VyLqhLh7tQp4IOf61z
	Pa95gp2JgFgClI0RZXyGoDTkSsCEdexrhNooYpeU3tvQhHea/NNiefYRHNQGVhOi
	0Qyxn+8dLhzClW0kpvooH3c+6suehsJQgC/OeKNiNkRTwsmG+sPFiSzZFNIBiDgd
	w7HKug==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ayhcs1mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 18:36:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166855029eso454125ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737570972; x=1738175772;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJLJV6ONtrcfpP+rHoQCYGK0rdyIfz89lUUHS2Gm7t4=;
        b=wwNBKn2YyBAaJ13bYBP77LlBgbg00LNVvxiGv1U1Kv32CyoJFzBElzjWPqFI2K25EJ
         H6tJ8/IohrNa6V1KzI/SIznA97TzTmXY4wMuderJwtSEvv1XxyI8D5THsFPC6NqVqP1/
         fSM3YNyibdkQgLNRgzGUsy9DmfD8vlVYwX92RsIKJmn47bmTv25XzCZmQuTlY36e6f9G
         rzCRxccX2eFCHJ0oFjcLvVZ0IBIf58w/7SctH/YEnY4E/28YvRLygMX7Bs0IgqZKlEml
         GI/UUrNSUdbw50kd0xpUR2nzS1J0k4aaM4QVAzTgQ0Mps3Nae6uDEylKLAQPN2Gc/KyX
         xB9g==
X-Gm-Message-State: AOJu0YxwC4zsbV5tuMas/HIGQl3TvApBG/0POU3Ehgb4jVX5QYaTYgs+
	i5MwhjKQJggz0mh/3wVA8uC72RMVSvHGkleJMfOgmhKnsn1otHdB/+3oyZpOyNDyFnJGU0EYXHy
	2QUwxYitDy3ubdchamgHLtLM26H+oL0QFwhUq/luXXGsygYKO2RxGUxuaw+T4s61sigqnbETwGw
	==
X-Gm-Gg: ASbGnctDkqG+LdbiWliW/hbFRS+RrkgOlKSZO45B6a8T6UpJYrHi2g8H28eZ2lyyBPG
	jkN0iOVaO2Iv1VyHha4mscNwSoZUxGheedBOck7aOWleJYyxfbAuOo8sxdKp1JFAe22TAbdA2XP
	AyIplMvxKtnRSXRZU2rvn8O6dCWKmwHXZESFTR51eyWzBuwN+QbN/oIFq1ry7PfB+KsxJtcJlS8
	8btnJY5IkJ/TsYiV0hTbN7nXqGPshdUq0Guun9YC7o4kocDzIK3Wngr3XFKtCrQ03LIh9Te19xf
	wCyxJ6vXfH4qhfHZLDL8lAwP2v52RT8=
X-Received: by 2002:a17:903:2b05:b0:212:4aec:f646 with SMTP id d9443c01a7336-21c355a4af4mr348553435ad.33.1737570972623;
        Wed, 22 Jan 2025 10:36:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeYqvxZz2gE0tf6uC8zNL0nYsBquftdA9I/M4H2x39XsSIh61i/n1nYMyBJkJG2jhFCbyQmQ==
X-Received: by 2002:a17:903:2b05:b0:212:4aec:f646 with SMTP id d9443c01a7336-21c355a4af4mr348553075ad.33.1737570972213;
        Wed, 22 Jan 2025 10:36:12 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea1fdesm98146145ad.26.2025.01.22.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 10:36:11 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250119083657.1937557-1-quic_aarasahu@quicinc.com>
References: <20250119083657.1937557-1-quic_aarasahu@quicinc.com>
Subject: Re: [PATCH v10 0/4] wifi: ath12k: Factory test mode support
Message-Id: <173757097158.4048395.14541165281726073253.b4-ty@oss.qualcomm.com>
Date: Wed, 22 Jan 2025 10:36:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: yDkXlh8zb2PaMAJd_E__8FGPdqa2Xdx0
X-Proofpoint-ORIG-GUID: yDkXlh8zb2PaMAJd_E__8FGPdqa2Xdx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220136


On Sun, 19 Jan 2025 14:06:53 +0530, Aaradhana Sahu wrote:
> Device is booted in factory test mode for calibration.
> The commands are sent from userspace application, which
> is sent to firmware using wmi commands. Firmware sends
> the response to driver as wmi events and driver sends
> these events to the application via netlink message.
> 
> Also added changes related to correct pdev id access for
> fw test cmd.
> 
> [...]

Applied, thanks!

[1/4] wifi: ath: create common testmode_i.h file for ath drivers
      commit: 6fabed4052176a18da9519fc14a18897ed4f820d
[2/4] wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
      commit: 786d5258faba099779fe0d14d344893f9215d6be
[3/4] wifi: ath12k: add factory test mode support
      commit: 3bc374cbc49ec39891381d2e25d81a6f74fa3364
[4/4] wifi: ath12k: Disable MLO in Factory Test Mode
      commit: a93185b708f259ace63414b8529e9e15c6323b69

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


