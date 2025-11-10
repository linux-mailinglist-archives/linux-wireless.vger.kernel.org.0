Return-Path: <linux-wireless+bounces-28812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB367C492D4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DF4188EC03
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 20:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F5F33556A;
	Mon, 10 Nov 2025 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iHZoEb+7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z0QGnCEN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41DC221F03
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762805076; cv=none; b=X9vGxG00PjcXURUspCQiEpt1OHqsOFi3S8GyKuhrZG2UQohLE4pNDqNn7YiK7q1qN/MKAFkCNktTxj7+398WeX76CI/QRm7mj2UxVzmoEx5EW3+SHnyRUUtIGTcCTPhWF59iuAZyCEqRc2lxxfVty/SdYM7Ysm536KB0HmWDzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762805076; c=relaxed/simple;
	bh=Fkcw2qew7eVStl/+jGAeuW+KaRb7Jjz96jXXyII4x7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qd1cjZhKDKtssV19Y/cCQEw0FDKA92+A6ZVmR2wMypxWSF+Lrmkm6fdR9n6HVPPqeOTRg7V7CzdVESJeUMrnxhoqLzHWRLvlUPkZZEb5Hh4ykXG0mzXIwrkdlr798NI0Y9cfnLBZAH4TaIW/2nw/kXr24PRPDhMIxpojloHm9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iHZoEb+7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z0QGnCEN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACOJVW2407325
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 20:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wywLQuZS84UaCfivN9hBRyvo1mTqLh2yeP1DKGiRq6I=; b=iHZoEb+7rvrtIGQY
	ZdifNm7zQg6ObBnG36sLNVmkMToc6JglIPMxJy+j4phnAhWq8JdOK3rZqcOuCjsE
	DiVo5rYj7xi8eg/Un7A7vRRh3TM1+tSH2+nAdhMWS+qF28anMvbdkLpLngazP6wI
	E+diKjovVkFr9MyuLeBfj3Bei45WdSbnWWoJKu/cK0vruY7q/cX1DJpClJfaiUOh
	c95agm6xEj3zDG/f3oVL9T6UfIDhxsUFJ8oi6otHx0T0ttsMtMP4LFNPElBZx/MP
	21YUa7uKEC1qe8PF+x8gaiT8YwV8G/kYqHSFY0UlOInvwhnVsdGaVd/A0146OewZ
	NO3//g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatdag3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 20:04:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b471737e673so5676154a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762805073; x=1763409873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wywLQuZS84UaCfivN9hBRyvo1mTqLh2yeP1DKGiRq6I=;
        b=Z0QGnCENeqnBC1x4msz9V78SSG1mSFNbdjn/kmikSlDnYlnXKm8Aeqhw/9OdMPFs1z
         iTL1zaCInEyALdqvLpeesmCfr9xuvI2sxrSou8koyUZdfkzGJjm/BYtvXgw/2w9pKgWZ
         pX0MORfru/gJqioEwgfyADXh3k4s9rdBmzOKiWfImfzBVtGZ0BKvdcSJu38zaJBWJpeN
         6yZto2mZCne0+LYE8r8QyGACS3KyRgUvpdmOpDnvJ7ZlyvYVLj7mHNJfojwk258c5TGe
         fhIkb3sNQUgnt9TXeglsBlvsk/yKEEuP/ahqh7Uu4isJZbt857fl1fXo2pVxSQykJrDm
         GMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762805073; x=1763409873;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wywLQuZS84UaCfivN9hBRyvo1mTqLh2yeP1DKGiRq6I=;
        b=NjlGCtHyegLsfaSAWWvKTOhFAcHf2b83lHQHPMnPDmIeF1J/D1YoM56lTffTBPKl51
         sjcPA6nTrnEnmC2iXI3cqW2DKa/cv4tyxxT6aQDW0de6ssA3jUQcFe5jelGTz/2ECzSu
         UlvHIjRRFuKoZps4S56Jl0Qw+Gq6QpWQwywYZLi0RzieN44yAJILosjW5aS8kTeg7sQB
         cmAsgxyGjraUwv4Wc0kv71Qg+/FqeOMSrk8EKnv60SnvpgN8gQRdFGcPm9ZpEF+M8p0v
         7kFP3G3Gi95KnOAZ1urRagna4quKDMId2olDJWxfh5ZX0jVBurognJkAlpRr/wZ9Bo5B
         YkIw==
X-Gm-Message-State: AOJu0YzFI8ggeFH6Nyrx6Qm6P84cr4NKx2fyFBMTGhVwLU8QKtx3avQu
	DvyMt4KpKM/BMHTfXn5mBqkcfvOW9YbIIdwskf1v37NwyyrIYoyo4gYFLWrueCoNbeFySSaBo2I
	M9V+ioL1rdGcXu2VntAljQTV4hED0iLFfm8PIMlac6KwoEchTxhT0fU9p/H2PsrGZPvudYg==
X-Gm-Gg: ASbGncu1SR6tf+feVRa7ckeOPH4cPnllcQhFFsIpE+MmJiKfk5jV/8Uetq1i6NvZNhJ
	7EDB2J+hT6oZJD7Ex6nnhhwYc89Iv6EZqzjtu7Ta/Y4Jq88n4bzUaycvE+YG+f0sK3EFv3PVOIJ
	/QZby58UhZDZTM2dWRCxZ49TunR5v0HoouQF30gouDSOc71ytgGBtlhBk5wQYtfD6tMJwk1QX/Q
	bOG07VKhcJfcjOTXnQ93bEWKT+O/vqxsL6SBiPaPWaBZXkUCYC0DSFxNQixJwuRPu/dLDSj+y8I
	B4G+SL5+Qr+GtlqIxTTnkjasG+Pm/QnUd/GVB2gBgXrRFhGkxthcxbshrgibH/VGk56KAoXO6Th
	s+v9QyTL5kdax7rpLWgLM7UWpGtWGVS1MpOdJJsRbdmQ+Ej1VjQ3pJKt4/I/jmIGCsQ==
X-Received: by 2002:a17:902:c94b:b0:294:9813:4512 with SMTP id d9443c01a7336-297e540dd6fmr127849555ad.3.1762805073087;
        Mon, 10 Nov 2025 12:04:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgRlu+QHDT2qRkN8FN4ZfcELPFfekO3p0qsOXqvaypumnws68i1D7DWIV/z8geDOvCYuPmxQ==
X-Received: by 2002:a17:902:c94b:b0:294:9813:4512 with SMTP id d9443c01a7336-297e540dd6fmr127849065ad.3.1762805072440;
        Mon, 10 Nov 2025 12:04:32 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297ed6808ddsm81285505ad.17.2025.11.10.12.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 12:04:32 -0800 (PST)
Message-ID: <2b34ceae-5e31-4dba-93e5-3fa35754fab6@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 12:04:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] ath10k: Introduce a devicetree quirk to skip host
 cap QMI requests
To: david@ixit.cz, Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>
References: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8ocws3ezUxTKREE3PhdZd-0JOhaO8aPm
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=69124551 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=p0WdMEafAAAA:8
 a=V89vUnNgf5GAzAs4dTEA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: 8ocws3ezUxTKREE3PhdZd-0JOhaO8aPm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3MCBTYWx0ZWRfX71tsvFb7Fgi3
 9lyQkorsmhh5i54Q8w0qE90pctKGsExM+kjbFybp1vapeLGGdABjfkXs2v5MXWfeC7HDaKWBXc9
 N9HluZb5051pNc0JF4U/R2FzEtkUSgzhqNpC5kPEsiSgHt/EINsHMtKq8frPvxmXl/IiSeNg1qr
 LNSTrnuXGOW9ZuQBM2jjlI+EP7z8rVOsW05Uro5WpElnlVB+dUYgruDBGlKMfX5YW+sUlXT8evG
 E0G8zVdoguKOrpmeKWRp6b0m2Pop//JjzyXG9ZKP1hTAhsVKOtPcD4bIZoU42qRsaVc0jYy1d47
 qL6sCXHuOVAw/0tCy5s060iSJIskFuoZErihKLMgt2oPJ6VDNtiSW2EKO7MdCnQ23Udh4PwnzIP
 RqADDTBT9WLpm+3PDNatb/l5vxMOlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100170

On 11/10/2025 6:26 AM, David Heidelberg via B4 Relay wrote:
> This quirk is used so far for Xiaomi Poco F1.
> 
> I'm resending it after ~ 4 years since initial send due to Snapdragon
> 845 being one of best supported platform for mobile phones running
> Linux, so it would be shame to not have shiny support.
> 
> I'm very much open to suggestions how to solve this in a different way,
> as the original discussion thread got quiet, see
>   https://lore.kernel.org/all/b796bfee-b753-479a-a8d6-ba1fe3ee6222@ixit.cz/
> 
> There could be other devices in need of this quirk, but if they're not,
> we could make it compatible specific quirk.
> 
> Until merged, available also at:
>   https://gitlab.com/dhxx/linux/-/commits/b4/skip-host-cam-qmi-req
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Amit Pundir (3):
>       dt-bindings: wireless: ath10k: Introduce quirk to skip host cap QMI requests
>       ath10k: Introduce a devicetree quirk to skip host cap QMI requests
>       arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable ath10k host-cap skip quirk
> 
>  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml       |  6 ++++++
>  .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi |  2 ++
>  drivers/net/wireless/ath/ath10k/qmi.c                       | 13 ++++++++++---
>  drivers/net/wireless/ath/ath10k/snoc.c                      |  3 +++
>  drivers/net/wireless/ath/ath10k/snoc.h                      |  1 +
>  5 files changed, 22 insertions(+), 3 deletions(-)
> ---
> base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
> change-id: 20251110-skip-host-cam-qmi-req-e155628ebc39
> 
> Best regards,

The original thread predates me becoming an ath.git maintainer.
Just for my information, is the firmware and board files for this platform
available in linux-firmware? Or does it leverage the files already present
from the original (Android?) installation?

I ask because the alternative solution suggested by Kalle would require
modification of the board file on the device, and that seems more of a hassle
than just modifying the DT.

So I'm personally OK with this suggested approach.

/jeff

