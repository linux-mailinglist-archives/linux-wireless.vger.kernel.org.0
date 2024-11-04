Return-Path: <linux-wireless+bounces-14881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34509BB755
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7945C1F21E4D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187EC139D04;
	Mon,  4 Nov 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fOXV+QK/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EAC2AE90
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729825; cv=none; b=DmJaWTyTKFCqJd7wgU50O8YFM8Nmixi1GOBSS7qFozctvp2bVOeeLWhmJen/cLWmCKwRxLNWZfvYNzzFGSpqR3ZS2eeB8EEdEWNQ7Kf5hS6MtwxV0jIgMkpA/aPMGOXs8J1ZeO4Dr4dYCzCDps7lXlb4HxPOkGIVGEav9fP5sBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729825; c=relaxed/simple;
	bh=Q+LVHLVvV23psnH5k8auFoe6nsaJjyQzXDADndrFqXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmKl13Pxx9Qu8+fmMfOR9y7VbeKqENWyIADDLWw/EefKzWEXkmjnCD/A6gUEva4ogEcMSZ0Ca4ZdqYUIljc5qS47+RDDihZOLuqefIIG1dVsQa8H9lnFXcP39z3aAXD/yYJ376SadZxyo4FGnmLM4wEhSPTZvk1uSvz3CRYUZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fOXV+QK/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BjXL9019792
	for <linux-wireless@vger.kernel.org>; Mon, 4 Nov 2024 14:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+LVHLVvV23psnH5k8auFoe6nsaJjyQzXDADndrFqXc=; b=fOXV+QK/hyhMCDXy
	PjqJed/kJ3Z2YbnFXQpjjKWfJ5PXO4X7j77P+pgicDAdzqIOQ35Iq5cS0J/aSNEv
	gyUgDreEe46iHdnQ+TxlgX0oQt9JGf+w6W6s9MWZLheFjUvJi4kRrEmAF0CsUhQW
	UtEmYGQaxJ+MeQx2to+7+bxmUo8gWUO7Wfi647rYrLFEPjULi2nZ3BcoZX+lg4Zb
	I/Xz+QK6n+GF0QxddXppoJXIcqcySMcJyaJfhznUuA29Y4bISc8igzdsAyreE84H
	DaS4LJtNTKpOt0jmg/zjEEH19zXgQ4/khs6A9Gih3ZhoAy8FndNtdK+5sB1f89D7
	M7E3kQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd11vfpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2024 14:17:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-460958ceccdso7619531cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2024 06:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729821; x=1731334621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+LVHLVvV23psnH5k8auFoe6nsaJjyQzXDADndrFqXc=;
        b=lK00xiT0ssF0tW7W0ow+HJy/BfyPRMP8bmDFGK6+9Z4QemCRUKMDI/8w9D7fcE2juY
         H7NeSn6onsh3G6HJyDDKuigaDm0cSO1+Xgwfdwfb7RE17TSwEIc2bxpLi4kb5fUzHwzn
         1j1NNM/qyipx9d0gg4YXGiCbv6aPKaGUEFxG2bPsnVSaFutgpXHZ7kmxKKxYT+fa1uLx
         uQjtwedKIRmswILcg7yK2Eojf8y+21areVT0meHKsaNkW/6iPCHJQwTTo3iSF+VGxXzn
         cj+Tq+Wa0OLbqpPJiA/lvJrDLs374bg46MYGacIf/xxA/Q+/UF7fS1wUid2I8lmPAHhc
         8ujw==
X-Gm-Message-State: AOJu0Yx1Vvg36cZ+BN2d84lOWTe9LiNnNOO07zdpU7xPhntjSXT1p3HA
	1ZoCI8A6RnP3Wrs13nfQFWXTTlkv2FO+LE9cUhjw8Y0Eu+J7R82xRszVrrBEmXI63aSEVMoJib+
	xPTTy9a1cVmuUvlbAj36Nx/OOF5oMTAM1tjDniuSHzAIXEZxb38ElPXUYBGHz2rjCLg==
X-Received: by 2002:a05:622a:104:b0:461:5d78:4ab0 with SMTP id d75a77b69052e-4615d784f13mr181254051cf.3.1730729821604;
        Mon, 04 Nov 2024 06:17:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7oonLih/OW/AF9dZ7ubomiq4C6h3xeUDXyivjErSr0Hk8yihCCrZnRm9ZrUOTpV8rhO6nzg==
X-Received: by 2002:a05:622a:104:b0:461:5d78:4ab0 with SMTP id d75a77b69052e-4615d784f13mr181253691cf.3.1730729821072;
        Mon, 04 Nov 2024 06:17:01 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5663fdaesm567059166b.148.2024.11.04.06.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 06:17:00 -0800 (PST)
Message-ID: <142f92d7-72e1-433b-948d-2c7e7d37ecfc@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 15:16:59 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/22] wifi: ath12k: add BDF address in hardware
 parameter
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-16-quic_rajkbhag@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241015182637.955753-16-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dIHJ8jQeXqkpqHssb8YP4WkK3y4rgMyX
X-Proofpoint-ORIG-GUID: dIHJ8jQeXqkpqHssb8YP4WkK3y4rgMyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=985
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040124

On 15.10.2024 8:26 PM, Raj Kumar Bhagat wrote:
> The Ath2k AHB device (IPQ5332) firmware requests BDF_MEM_REGION_TYPE
> memory during QMI memory requests. This memory is part of the
> HOST_DDR_REGION_TYPE. Therefore, add the BDF memory address to the
> hardware parameter and provide this memory address to the firmware
> during QMI memory requests.

Sounds like something to put in the device tree, no?

Konrad

