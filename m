Return-Path: <linux-wireless+bounces-21136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C274BA7A9BE
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4171735E8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4088C24EF61;
	Thu,  3 Apr 2025 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ozb6fp08"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEFF151992
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706345; cv=none; b=GlMQGIYlSb+EXOMFf87B+ODXuvbXNvvV8sUT6z+tG8COIt2em/hCcj+37eRmLz6NwUgCoQyFKyVAgpOUM9weMTjoJoVErl7U0glGTFX+HZyo41gL20Q4vGpGoqexh4E3nsqyv4FV6euwXt1AtiiYyj4k4+sh5T7eh/LGbt3MAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706345; c=relaxed/simple;
	bh=Ws/O8bZeIHj0IY/2Mn3zf4TAJOpAQVldsV1xq5LqVIg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tLg+N+z53/VJGcEj4JPrZjbeuK7HXTYvI0wC5S6fdVvIRk12Gzmsm5V8qyktsUpQZPtwievBonGT4Xa91nqgiOfjhXOiKxbhdr0BcRUrOseHr1sDNn2wgqqzAGJ9todgbf+3NVU/aC0mnG8S5/y8ZiefI75CrUp4puNj62G4je0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ozb6fp08; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533IUxDj019146
	for <linux-wireless@vger.kernel.org>; Thu, 3 Apr 2025 18:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zSzJzT/vvMpCdvsDvcyPFAkeAlYNVc0Lzm6ajjNU55c=; b=Ozb6fp08OrHB2H+x
	1kams8pZqzIoD7XhTaAm9qtpzm1ADkSm2WNxST9WO9V4UQKyE50F/8ABTaGb87v4
	Cm+ndZNHq966cL80tVtJ2gZGyMbmOe4aIvpVpfmOAHbGihXCPsb9mrjUmheLV1uS
	w1gfwz/eqaMpsf68cH25+OURsSsN5u6HnW6eHkDaBPMXLz2ELTWmrwvuZMIZofhy
	6QCJtabr/QvbjsUw+vHlLTII+fZa7yaG7tiMH5+DpRqUyzAvflXR1IK2dQRCt8GW
	tio7lpLXtSYca0QxdjRZXmAlY8EKM79fzftPrx8vvJ8knJgjMt2YcNSo9dBa5qcQ
	MQFsRg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbq00p51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 18:52:22 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af91ea9e885so1118245a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 11:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743706341; x=1744311141;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSzJzT/vvMpCdvsDvcyPFAkeAlYNVc0Lzm6ajjNU55c=;
        b=MbFPRK0C2f3oGMvmX6+ERw9GMXl6G/eWJZMkpJadm+NOk2XlJH9kV/rr3aSc1w/SHI
         eVVsTB/lFf7w2LCQ7gtqb92C5e/A3eJ3Zru2bnm8yhvUGy6TmdztP+1BO4tSamKNy2G2
         7f4pDxFfRJY1PbKQIK+2arOSTQuk7e+8hQ+LBvX0Os3k8mDM3F/dKwvl6NWdqPwhMKwT
         TDHNScJMbKM8hGy9G09KwMmxqRDl/H1nKTpl9Pgp8++0LqCAyIzw8HYsOw1eGdrXT7gl
         yygKavxi1UUWlTWTB38IspiyMlOZcAwC7ECvtCwQbhBPba4ptDcVm+jVqywzvR7UNaYf
         uiBw==
X-Gm-Message-State: AOJu0YzgV9gFM7Aag5FwdixucO17e+6u5YPiqmSmTdvIlRWTLRlb/Zpe
	e2XNl+s72xz7IFoDY6fZW1+XDNaiXHgUTZU+oWmz+nZkkRfY8fbQSK9o1bfkqwer6wTfcHWqg/v
	Su7nOBpfGJCMlzStB0l8cTKOAMjnWQtLmzplra8lq7qwiiEnsxayGRFEF1jX6MlOigD7owfAdoA
	==
X-Gm-Gg: ASbGncsW+eCCOS5WbqrhDxFrf8MgigCVo+bX/Up4LTTnjZnZwtI/Cc5wKemYXMxdFSo
	DyEOO0nBjZqU2SJdRXDzwVeq6+tsm2FmqOf+LaqeuDcE/RXC9Z95siPvKM4383h4dkbWP1ciDOb
	ZRd5Mwe69P0z8SnleXJyCHdGuLiT4Xvb/Q/yAMdhB4iMRJtxCTyYDLNp5zcByNAi5oRES6lZpkX
	HQFrTI2ocnwvAbOMhNRw8xmYavw2eJNvWdpELhJzgthSCcm0SVwBhlmjoF4xczBB+8XGIatxNZE
	qV7wCUaxe7IDT11qwFjXY8X45/frHynCWdCRnKNWeYipvu7cQhCK
X-Received: by 2002:a17:902:dac7:b0:224:23be:c569 with SMTP id d9443c01a7336-22a8a861c6cmr971835ad.22.1743706341429;
        Thu, 03 Apr 2025 11:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHETG/rVqQmv33fIgHiV4j9KCCV1gn8O/DHCsOjNMagAhYoD0frYdMBkLnbU0XTWcQ7NaUsKw==
X-Received: by 2002:a17:902:dac7:b0:224:23be:c569 with SMTP id d9443c01a7336-22a8a861c6cmr971625ad.22.1743706341069;
        Thu, 03 Apr 2025 11:52:21 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787776f8sm17927225ad.256.2025.04.03.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 11:52:20 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250402152529.1649402-1-quic_nithp@quicinc.com>
References: <20250402152529.1649402-1-quic_nithp@quicinc.com>
Subject: Re: [PATCH ath-next v4 0/3] wifi: ath12k: Enable REO queue lookup
 table on QCN9274
Message-Id: <174370634035.3124842.4515034622060851956.b4-ty@oss.qualcomm.com>
Date: Thu, 03 Apr 2025 11:52:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: oFwVP5Pg7vGMhHpgfkvv3_9tMdhhOmjk
X-Proofpoint-ORIG-GUID: oFwVP5Pg7vGMhHpgfkvv3_9tMdhhOmjk
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67eed8e6 cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=PiDKsrsRxseamtqovsAA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_08,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=679
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030097


On Wed, 02 Apr 2025 20:55:26 +0530, Nithyanantham Paramasivam wrote:
> Instead of storing the REO queue address inside peer entries, REO
> hardware module prefers them to be stored in SRAM which could be
> directly accessed by REO using peer_ID/TID based Lookup table(LUT)
> mechanism. This feature is expected to improve stability by reduced
> interaction between host and firmware during both MLO and non-MLO
> operations.This feature is enabled only for the QCN9274, so it does
> not impact the WCN7850.
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: Fix the enabling of REO queue lookup table feature
      commit: 0bbcd42b15fa730f393a01bc818802d9f0b04197
[2/3] wifi: ath12k: Add support to clear qdesc array in REO cache
      commit: 30b03edd265a79b779c29c12ad640c91830ce7ca
[3/3] wifi: ath12k: Enable REO queue lookup table feature on QCN9274
      commit: 89ac53e96217bd5525ee56eaa1b8ef2b398a9ad6

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


