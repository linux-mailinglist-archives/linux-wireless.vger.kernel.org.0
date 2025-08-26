Return-Path: <linux-wireless+bounces-26636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4FFB36DF5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 17:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8C32A5025
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369A92BD5B0;
	Tue, 26 Aug 2025 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X4P3LLgH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47826E71C
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222745; cv=none; b=tpPhaAFdOCk5zii/Yrh7agjrvJStMZ/TOR86pF8tnABfMjchPfCsgOKl9zkGiBfCjip+SW6fA8XM68FDo1mV5a5cfapcBzRDYJHVm1QHml64RYu/1kHxeNFq5yDuoRWwdghshl9DrDLPMMGSNjjnj8BBRsTdoms8qvYMKaAJQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222745; c=relaxed/simple;
	bh=bkCkv19S9wHdnx0Kc3+tOj9A6SmyMAB9oyi/16jxTxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+k0RFL0sDhodG9t8VfTWhuLYqxpyQ5aDMLjywo70KrxRP+B6WQWtycaW4OwTr7s35wPxJoMtezv1bKKoPkaGh9zZ5jAq3xQRsF2/F3dwPtbJqs92Ju9qkPslrSpGf3rhN0O15zFf2LhENt6iGG5zewy5dsjfgL5QZ6OXZkj+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X4P3LLgH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8mTJA031417
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1//9ar4mn96BTeRcegh7QawnDMTKdyK81gfdwaa5TQA=; b=X4P3LLgHNPk2C2Jd
	5x2qMx8myzFcDvd3GsgCO3pcGV7w/koG/tWWh8qqUqFLDyP4Xd3ZwtdBIaPmaidi
	CONaiwJ1SXb0I/hfrCPY5IUnND3ndfEJ4BbY0/s0gcu3Pdjj53rWqbLM3QetSuDg
	+PTAZVmBdEg58qEPG1qHl+l5GbRyM65DPxZrLo0x7Vj8RHPm2B+DsNnNOpj+WWAL
	nssxfJamSDEvzBJMGG6JfRcIIZ1IbW5tIrNFPT4mVAaU9PFInlQq3qkxyP06VT9X
	WRWT8Y+vIIHPMy4g2iPQf6Erh9HUUZCeuJu0VqcU4h0OTCckdFf9SAEIApRkXmu1
	OkHQIA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfhcme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:39:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e5c4734so5746663b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222741; x=1756827541;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1//9ar4mn96BTeRcegh7QawnDMTKdyK81gfdwaa5TQA=;
        b=BuTkQT56MauQDOOA7/CvzOE62tFuvoFckWPSaeX4080UjcCvs2MekXmtKMWSkzK3kH
         CDcoEwQM/4TNq1gmBbpHvpqp8jffHbStmMi5mAZ4qke4mJApMbw66R7Lki1WobyJv1wz
         XrLfvQKs7A9UGX6+HsS0J67BLIXDq/uOmTNFDyVgp9TPzPbmDRlLXs7HfzyZjdfVL2lC
         40wTAZcbt9QuyXMX8C0+i0s+KGfopA/uFlE4ycMgW9d9xE518/9i+6wMszi7HW6NIOVY
         37uhngQJxYgOuT8rPSLME+0Cw75JUUoGcQ6eiWb18iDq4pBMM7LhbsmFqRsFHzdu1Hdw
         5YWg==
X-Forwarded-Encrypted: i=1; AJvYcCU35AXKbcIWPr1fF6JdQ+g2kOTxQImNrfhGYJ1KnkRXUfVCvm394YCPHQXKrAwZPSj3rsQcKj3mvF5gtoOtTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWG06fchMGcljiD+J+43Jl0jd3wNg/2CcKYee8gyIuQHUysXD
	+fvqSn4ePQN3U0rmSFHRhIebyDB4ZQUMPBk8hK2TuG+NYLR6JOWf3xG+dZMFIoIvetw7GPzr1if
	cS23HXAcpQUKgNTUnggWVRL/kiMCjwEOXRjcFcrdEVhiDVNZQ1jYHT36KOVB/VQc2yp7/dg==
X-Gm-Gg: ASbGncsuX20kPkiG/RT4PSbQhgnJH7YvH2/++hzpbgIpuuzr3X0FuPAicGwn0ezjq+2
	O+6PgTMqazyJzAG7b5XZH9iRaZW8/pYrLRx6SB6XugWsvtliK71n1BlXDENLcA91top0Rlp+F5V
	aMsvlr3vrlGhViST7lzFioVDXZwrAIqs5OrRGRjc7okITzvJ2/2+AFvCvYT85UhqbcnfS99Mdm6
	B4wEgsM6l0Grm8LyIgnc/xFXOYIsg3Trss87Y4MVOGvGpVomfmxVxCASy/uEJ1SYi0bVc0V+6O8
	qDazGlUHLKhwxgG3sDwh7Ky1C5zcG95NTLuRM+qY59449U/5ePWRaLgkfZ3D2QR6Uw3yLPayvf8
	pksxg8HSJrxFHmn5SA38=
X-Received: by 2002:a05:6a20:3d12:b0:243:7cff:6251 with SMTP id adf61e73a8af0-2437cff65ccmr9026067637.26.1756222741359;
        Tue, 26 Aug 2025 08:39:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL0KSG01yve3r3qzqiKchOxZo/p+aKsbAcVtQItkNd7vJ4cyfMgvyDRPq539k48rr7cMjN6Q==
X-Received: by 2002:a05:6a20:3d12:b0:243:7cff:6251 with SMTP id adf61e73a8af0-2437cff65ccmr9026009637.26.1756222740816;
        Tue, 26 Aug 2025 08:39:00 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffae973sm10724369b3a.12.2025.08.26.08.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:39:00 -0700 (PDT)
Message-ID: <2fab10a7-8758-4a5c-95ff-2bb9a6dea6bf@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 08:38:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] wifi: ath12k: Use
 pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXxngEPtk9TxZF
 seUY+aROhg61x4TCvucRGGiEcbNGNnpJW3pM8GogIc6cMUp7PxrNU2wTe7gXcBn6wwNcIH+LAdV
 HRm9FF9sS+Zw1JnA2CrtAkceHDQ7hcycFE/aDQEfvi3qrkJH4ZIBLzzxOq4JA+nmOfjmwPg73DA
 1t5wbcXYrzy5C1dPbXejTUlgZhCFugd5r9LKBS1UWC8Qi+AQ+vhjmxP+5hoNpscTmvJfBKh4Hxf
 4dP0/TODlKg68ajb0Gi7hKtA6dBKuoUK/DTGEYMH8Y4XRCmB9lFF/Sl3oq1ukOIKh6JyEoBdGCx
 ZhV4u+Fvmmj5+QGRXLEk3kymB0XtIfKOYG4PMs1LO3EMABL0qU9GI7WGn4mvbjj/4qCtVmamvCs
 x6jRqt9z
X-Proofpoint-GUID: t6ZMQF5L-vioxAUDrqE3n0SYlIDIx0wi
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68add516 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gMjHX16tY-KYiP7tJ_8A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: t6ZMQF5L-vioxAUDrqE3n0SYlIDIx0wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On 8/25/2025 10:44 AM, Manivannan Sadhasivam via B4 Relay wrote:
> --- a/drivers/net/wireless/ath/ath12k/Kconfig
> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause-Clear
>  config ATH12K
>  	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
> -	depends on MAC80211 && HAS_DMA && PCI
> +	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM

As you point out in patch 1/8, PCIEASPM is protected by EXPERT.

Won't this prevent the driver from being built (or even showing up in
menuconfig) if EXPERT is not enabled?

Should we consider having a separate CONFIG item that is used to protect just
the PCI ASPM interfaces? And then we could split out the ath12k_pci_aspm
functions into a separate file that is conditionally built based upon that
config item?

Or am I too paranoid since everyone enables EXPERT?

/jeff

