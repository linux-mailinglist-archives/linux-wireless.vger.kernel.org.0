Return-Path: <linux-wireless+bounces-26957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DFFB41048
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 00:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0E724E2312
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A76A1EE02F;
	Tue,  2 Sep 2025 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pnadynPg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB9258EED
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853219; cv=none; b=eZGr8kzpW+laV1FgSKMbhhZXmaf0Aa0sWXNxLNVIAfylk2sxacK2WNGtYALBLy4Apzq86M3uivG7WHKmj5R5IYrzv19XzHBXuZolON3c30Xr+U4QKDjAJoAM68GexWntCxsWu7GKdPGgtZ7k0sFMaRRC0G/Yd7GLsKb1XHdFdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853219; c=relaxed/simple;
	bh=pmYcw7uYuyFMPWGymWggproQ5V5rREITB1dvjPpfKtk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nn8giAKjBJsiQCixAkWn+ETlC3wgpM7olhWBXoly4ejCLahOALRmAG8h+6xJHib2pxMCQu5mg/iExoukXL6Ju4/uH5DvtV4EC7WfLtzoqf5hXjCnQ5TiRk9cZR+JpFhjHII54GI45cB0ExkLkx6IvJwUDMwBncPalw9xPjuRcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pnadynPg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqDBK025377
	for <linux-wireless@vger.kernel.org>; Tue, 2 Sep 2025 22:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zucT71ouAiCeaIb77mSjfcSNqEy3XsFXZs+bwZ11Org=; b=pnadynPgi9HiP4Oi
	DzZxir6erC8e3hW/qN+rZuE3MPi5ZFvK4TYyNT8qDGK1nso4SEwLKx1zrhScwJ7G
	urBsL8r/KxWKQiBVh2mJrLs0yDMxg1gQQ+MzwhruqYims6//1mRvbPrVwOlinkdY
	49ytk3zQdPMsAc6/New17WPj7JHtWh4L9bfef1t/q1nCOaGyDZbWAFXQg8kaAmlc
	/cpq6FZ8xa4Gg1u0pH8hwub9GE8d1cGhQagf4cBh9hO1hvc1dVBPp4MdzI2mTFpK
	EQ/am7fcn1DFPO7Lhx2P719u/aJCjouhMgQelA06WjhxQ+p0XV0nnendbeTjtCLB
	LE7qDw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv1hfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 22:46:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7726280f7d0so2340101b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 15:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853215; x=1757458015;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zucT71ouAiCeaIb77mSjfcSNqEy3XsFXZs+bwZ11Org=;
        b=lHO00z9gXqJzDMCjnHvU7jEiXvLQ+/EKcMBvwMKGgrUDW7vymKdwojyWWdVCzb1ntA
         6U5mAtozcshHRtAPzoTuH2ehI++RW16pU+rLyGZgn9s+pkocW/s1S6pIQhC/N2p3aV+q
         uxCt7wrG4ObO325180f9OmdlD6UeJuu728IdWTMqVJcUAyyKtLjyemaYq2AgroCK29qd
         IN+sNQz/3Rjt4ZtpCy0FbItYcf2F4dvuyqVeNaUqhV9LGjGpHSWOuAFiNeqelU7OBR1c
         IP6cqtoLFrFLk19xttj4jJW8UofmuNLIMenesEKr8vpVCYVkyl7gflesJsLR8n3+nvjZ
         af0A==
X-Gm-Message-State: AOJu0Yzp4tiKGiR7IZS861FqPP9yU1Ptp8Pkhy7gh3W5kSp1nCMFLXQd
	WszEd4NE7jGzBQx35KPm8w12Gk5PzugG8p6g2DWMu78Y2V8giOlJguJFXucKaYlWtQ7QBVCTvlw
	wkub+Tj7py3x27v1QXueBSMgO4HDRRvugLb+1tTk06gM6cTMBttKmucOUUFhiKiFPdK9J8A==
X-Gm-Gg: ASbGncvdFHJ/6lrChwy2X5u1Rj2iE50Xam7aNTFiE39zGM3e/OzD2U1GJd/AsaYA1+O
	bXmWZ74PDBb+7szg0Qtx4XyIA5wSZsmPyJ7nOJFPDyuKS4hmPJT9vsrBQhqx8+mhFUZfKHPht3G
	KDJIkyuwSC/JueOuZ/24U08N2ypuINNzx04W62UbVxjx5rR5rbcIRn4X99JCbUZ9To0fGKryA85
	5ScuK0gcR+oN7h2IgCUlZR3k49aDqLauUgoZLq9XWhj8Ih29+QR0KFJ1xMs1xSZaIGgIjR4mlsO
	z7IJuKtxxLl23xdoNKTmNbY5e8slaFKTI6iISUCa5tF9kdWgkZWeXbHWUtHnj867+1OxOcjGNBP
	P
X-Received: by 2002:a05:6a00:1a8f:b0:772:4759:e433 with SMTP id d2e1a72fcca58-7724759e59emr15320129b3a.2.1756853215201;
        Tue, 02 Sep 2025 15:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB9qv0eFVzvl5nEblgwwyWD57ltVYbxlrH1yVZyYs108Q6uR+ONxW2OmtRwVKSH4m6/Xuycg==
X-Received: by 2002:a05:6a00:1a8f:b0:772:4759:e433 with SMTP id d2e1a72fcca58-7724759e59emr15320108b3a.2.1756853214691;
        Tue, 02 Sep 2025 15:46:54 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm11129947b3a.4.2025.09.02.15.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:46:54 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Steffen Moser <lists@steffen-moser.de>
In-Reply-To: <20250810170018.1124014-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250810170018.1124014-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-current v4] wifi: ath11k: fix group data packet
 drops during rekey
Message-Id: <175685321400.3902096.17516915412398086477.b4-ty@oss.qualcomm.com>
Date: Tue, 02 Sep 2025 15:46:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXykduTrH5Ycez
 /Sg9+78TKmltqPzLtTjU+W9KCBZlqPs4wCpdPi60ryfnFVR2PuihScAjUw0QwwdSaWtb5kKjMUT
 epe/Jl7hmkG9Y9uZibilLXKQXDCUVIzEEd3Z/EMRibf1Ewwo3W28VMN1BRgECPWhq206TSKXCam
 ZvXsDNr2FARIAt6Hp58R3B641rhWLOYnh3jl9YNsnISlhSXQFsfPLUuH04+a0Jx6XH1lZD/p7N7
 X8b1H2v9b5FA2wvJzwIPYT7pL960NuidOkZCqT46W51EYUyfYgOZOAuxw1a9vjKxMeRV8vgw2Zi
 njFXOY68PIPSytMvRK8slOkQak9h7X0vM7kbkjLz9SEju+Iq6yTXiOAMCbjZllDad9gPrcO1D0Z
 EJz3BFZY
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b773e0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TGNEUY_dwaX08I1wFI8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 13yPTPXydw1wzoaJjw0dHD8SSjkBUyaX
X-Proofpoint-GUID: 13yPTPXydw1wzoaJjw0dHD8SSjkBUyaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031


On Sun, 10 Aug 2025 22:30:18 +0530, Rameshkumar Sundaram wrote:
> During GTK rekey, mac80211 issues a clear key (if the old key exists)
> followed by an install key operation in the same context. This causes
> ath11k to send two WMI commands in quick succession: one to clear the
> old key and another to install the new key in the same slot.
> 
> Under certain conditions—especially under high load or time sensitive
> scenarios, firmware may process these commands asynchronously in a way
> that firmware assumes the key is cleared whereas hardware has a valid key.
> This inconsistency between hardware and firmware leads to group addressed
> packet drops. Only setting the same key again can restore a valid key in
> firmware and allow packets to be transmitted.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix group data packet drops during rekey
      commit: 97acb0259cc9cbfbd7ab689e25684f3d8ce10e26

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


