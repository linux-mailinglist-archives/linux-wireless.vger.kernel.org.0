Return-Path: <linux-wireless+bounces-21688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F32A92D6E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4531B64B4B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6770221546;
	Thu, 17 Apr 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRmebsEe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1421CFEF
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930662; cv=none; b=aemhhH7resWKIZinojX2ejoRxHpA451MCLFB0Wk2zhRFRFAeNIkln1fN2lfi4QNa3cE/R5JgqBALR1u2Qh343vUPhYbyNLOsFvrASROFRoSC3AwQ3v+ljzWJXu9zethjSHdSahTm2Q//W3KAvjJyl+2/rndVieJuiYoiab3r9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930662; c=relaxed/simple;
	bh=ubjKTB4jqETmE1f0xf4JwjXlUGypEj23dITKQnrRoaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LPdZHBU7CIiVxHLvHUS60FSAOXBCRH7cMqmQC0o9uBaJ0vqFIc4sr2/JgUDkumgn0pbXCwwv0joTkPyCgSsO59GPh3+zvuA3JZHW5QeikqMP3qrezkzMiz/F3wS/V50yGK6tgoIL+EGmPiKHeMg9TXcOYgxPxoA7b4OfUZfEJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oRmebsEe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClObZ008150
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zz/5RmEBo3xYPpjZX3PGMsauq72vwKPpecwWuOh+MFA=; b=oRmebsEeIeDENBP7
	bWvC01eI+5mD42zRzxmCkPPC4rfiCmKpqcGqlBuV0MjjD0SLQPxnJombCjUSo4yM
	rHrDWroqjdqwUZsx0vm0HaV4eMvJZneMVOhiSR67GIDRSyVPANDN6lCljyotCLRM
	Qcr4Hw1cS5UfJqCtwbn8MFy2XBtHud+hIyADvIawApDha0DQX24pl5gT9Df8LLgS
	bNbK6LxYqY48RrmhZSqWJNSt79C8WqBSGRszDx8J/1YmFtg4xLCQ68NxKeB6dypT
	ez5lAsT6jCLu+2n12LRkYAjs9kNCxrNH2aPZJl00/y6m3wLBygcsDvoQbLkn/MDV
	3AYLSQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk89fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2262051205aso10008935ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930659; x=1745535459;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zz/5RmEBo3xYPpjZX3PGMsauq72vwKPpecwWuOh+MFA=;
        b=MYF5SSvWODcqgCXGXWdgyWzyxDepU7Uc1rRSiRLXqoCCyF6wHvsF+ovNM5uFXwvLDJ
         z9K9MFwvFijd3tVjzl7DwEKmKnNDeYrwi4PoioFjSEydjOSt9yuttBhcOZG3EVti7Ppc
         rDrB7yjnDK1g8qk/+rrghyEHVFw0XwmxJKWT5uHqMAMxi8goqkBndoIAbswsmEOo+bNh
         Qx8izru6alzNzWTADgAN1/D1MBBcvhJmy+XyeN+lD+YzJfQG7UWI+f+PBupa88aDPb6d
         ZSuJXJgmfOejrOBWgTMlm7evgae8sd6yK8RTqxkvK6KYYzzLXsMeLVw6kdIWa0y0v0sq
         gjvQ==
X-Gm-Message-State: AOJu0YyvaSu5h6IP06yogHsHXsJSin4uAPD1C47tZ+Z9hP+eOLyF3UpD
	diTIXsUwRSeq8zCTrsn1Q1y3wDRbMBVTYTU7g0p4D+BsZ+OJwRPLbVum/f75VRkMGBlSUT+BqgY
	82Kky/t2hKclN7471EWDefehbomoQ3PN5LcOujB5wJ4kvXoTMPCscKz2eAcAOUzrZnQ==
X-Gm-Gg: ASbGncs4640r6Dx0p1+sN9zAUBgnVDSv/Qd4gN2vibxftmAxzZl3izSntctTCUex+41
	8enlBk29JlVpVxPA88WdUOXQsDWH5Y8tA9S+A5M4wPEYpeeko9e9vNQneuVBHr3Wv8sSZGdXzAf
	emb/UJgMnpTNKIPM72jBj3AmTO1gMqazIvipxNY2rXKJknPqbTmDvE3hwEUXBNBfO7kjeY8EggX
	vB1c6EvMvHPi4TQyo+JFCHxZ7iuB8d9QkCB3mewz9GJU4UcTUP9dllkf0RF/Et4KBkC91QDWvhg
	srSr461J8SnX2AmPDvITT36JUZsapDFRfZy6dh+89YhTSIU4
X-Received: by 2002:a17:903:250:b0:224:1ec0:8a0c with SMTP id d9443c01a7336-22c535acd5cmr10394275ad.29.1744930659334;
        Thu, 17 Apr 2025 15:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBAuEjwHaEZXENzYVQE1lvTT1NCzReKwLeY+hjH58qSnO3+/ge+Ko9QKnGemzx9qGvP8N7/A==
X-Received: by 2002:a17:903:250:b0:224:1ec0:8a0c with SMTP id d9443c01a7336-22c535acd5cmr10393975ad.29.1744930658831;
        Thu, 17 Apr 2025 15:57:38 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:38 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
In-Reply-To: <20250415184102.2707300-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250415184102.2707300-1-nithyanantham.paramasivam@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix the QoS control field
 offset to build QoS header
Message-Id: <174493065820.1347382.15327906368454984938.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=68018764 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=Z1h1_94KO-iqibAjzYcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 7zc7ML5IgxuPD7EIAdsHGNpBas3PVRie
X-Proofpoint-ORIG-GUID: 7zc7ML5IgxuPD7EIAdsHGNpBas3PVRie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=507 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Wed, 16 Apr 2025 00:11:02 +0530, Nithyanantham Paramasivam wrote:
> Currently, in the mac80211 layer, received EAPOL packets are dropped
> when the HT control field is present in the QoS header. This issue
> arises due to an incorrect QoS control field offset used to build
> the QoS header in the MSDU data, leading to a corrupted header in the
> mac80211 layer. This issue also applies to other frames that contain
> the QoS control field, such as QoS data or Null frames. To resolve
> this, use ieee80211_get_qos_ctl() to obtain the correct QoS control
> offset from the MSDU data. Additionally, ensure the QoS control header
> is copied in little-endian format within the MSDU data.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix the QoS control field offset to build QoS header
      commit: 8599d4cc4191c8c1af34207a8b9414acca4afb59

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


