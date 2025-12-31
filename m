Return-Path: <linux-wireless+bounces-30240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B47CEC3AD
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF553017679
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9522836BE;
	Wed, 31 Dec 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PKiaatVk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UdWzDXZ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA9280A58
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767198058; cv=none; b=unBxszLnN7gmB4ZalJt8M9Cd9mXjjO/g0WFSTAdLsqrnpefonJzHrkfTb3r9l5yHO8/67VHT62IhrjOQhSGfKvm4uknNrvQP5RpCh9IunjvkNekMt8P1o+l/fPYh9zs8byO0e0UFcruha1x+or/HCXy+Ac3EsmrZyo5Gd164TrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767198058; c=relaxed/simple;
	bh=UVAg56rkM+auEpEP194lxDA2RuqsebNQ02WdwnZoJ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaK5wBjPR7KrwH+LCxApQFMWiY5vRSsVk+9S3rVxnGo802nOWL+6GAIAGFfXAH4xihJoY3LBE5GzFvPYQy4bDuwvHfn5xQ+ioKtXFVw399jhAYFBOrRMlNt8pEsr9Osiu+owxZ3bWeTQcM9+y01doOL7FSqJniMECOfZqa613m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PKiaatVk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UdWzDXZ7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV4o6Iv1429080
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GCtRj0kGJkzqJqbBi+nzUzz3
	hAt/gdZ19OL7R78+TBg=; b=PKiaatVkwcqrWuY8DFvYqxHgFWBTdDtGeebn3+7m
	dTlCiYdpxYrotSGQN3J3EzH5e4Uqi5vyxAys7qOVn9+vYGNtfeuZWRQNZ15gdRyC
	XTYw5OCExmIoWrDa/699sbcu0o5P0SPvJyCEqg5BbIwNqxv3LlhZRKKIPWd+nR37
	7J4nR3ki4eRZIcJbFk987EGPu0o2/dG4/payno8QEF0lgpMwVdGmKIO2sZEtQrdv
	YEfIoIMWUvGxiRfY85cSRrW7NpwXdctXoeNYplYYNxT08Fn9sJNzsGYJ+pFUfd9n
	kIVFKkeXGsE0T78aGjFK/FvIAeyea8c6iS1YkcUoTMa89Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcw5e156u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:20:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed6ff3de05so301021281cf.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 08:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767198055; x=1767802855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCtRj0kGJkzqJqbBi+nzUzz3hAt/gdZ19OL7R78+TBg=;
        b=UdWzDXZ7G9IwQYC3SDoGAHjz1Z4/TdPz6fZpgvOTGaD7CaLGNkAawjkC9REDKjElbB
         1aRXbDe2XWUBa6E3dykDlHGgih2w0J7a0XC92SxlfC+omkOIDjiJjGKGDA+0H7ai7kb0
         0P2DTtmfKMfn3EfQcKD8Y/ByzDulJCjGc5eDKlZT6AlL366AbkXPDU4nzArxJY6N+yK6
         SMyTdly4ofl6shtCvDTcUXXqxgGM2A489qzlIgZXVr/qTxrrC2TfDSlBq49rhRoo92sN
         n2ho82bBq3iihtPOFKku5RkVHmzaXSglz7Dhlwgm3kguTawpevSImuaPZsKuXRGdTUK6
         U6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767198055; x=1767802855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCtRj0kGJkzqJqbBi+nzUzz3hAt/gdZ19OL7R78+TBg=;
        b=UgGgVxsARbLzRsODF2vNEXSMEb0cgUbQE/tryJ9erHkTNN/ASflsDQRzB3xpl09phV
         vbTVe1Qbelgwvz7U8+p6CdfiJtogzA4RuZBRIoYPqHgEWFWsJ8XVv6+u7Cx/6Ju/zd6v
         p/QEKqN3hc4NN5xS1vUsob4AV+EGBB56jY6o1NtcqgWETjekVSqF/4/DUCtCdKXkz1Du
         On/WgKlZhrLTZob4EMTLtEjNwgnX8zUtZukZvrrVORUoperYBm0vBRB2QrbbrOCwmdRn
         XBpMwNIT3XtFR06ypj/lIOIWKsVWnRgMJNOzmIRV0a0/IkGgm3Z7HgFTPoGLqhtNhUkR
         y5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvdLgbTdJSLnHcxkYols9Mb5Amyoa93VxxKg5twqXvFV2NyoI+9loJ5GMcBFeGtiPYq1DzNCEubXRX5O08FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQd2dK+JGu2h74hhCe3MzTC98HvxYwaR8ID/Nv+e4o2Ufc0pS
	RQCtLnhYO/V3oSzg6ahquhsGBT1IddTHvd1ob+iUFGjpfJbSU/mrFmowJwpBHD9LJ0ROrg5PHuU
	ifuERWSjF2F+IbPNz+oVGcKcKJAyLDxGiZZi2edRRodRqBDZt6u7g9KsPCMecp27LcW81LA==
X-Gm-Gg: AY/fxX4a7KywWxLeG/LJi2JLOqShYxo5u0cxDSx5MdIRNLjBRc4WjAZI3zHgeZV6LFM
	qtFg2+S2vY164K5PrEjQVqW6YmQpKlTM0Aqvgc09Exhs3wZGA5ilVWVLOy4EtsXX8c3PskdRj6C
	DYws72HDzDlBoJBxJJdIfwCNkjTCyNzTvcuomJeSlwilsgBMRaiSRozSjUHPeAeK4MYavv8tLRw
	8kLCbR/52KJRi7wqJD1vQQtvTwqbbE5Rd0LxRULINwMIBbJmnKpqgYcZY+z1kJNqP/0f5wOgidh
	FqyaCauH5F0OAu7Dbcs9/d+itIIuO1bU6I/Dp3NYbQG4YO0NJ5egF8i2UzPI8V7zqfFfQ3xmc5H
	k2fZSgIP24BvgP1O43jX+Lwwt8BgG4ZVWMEllyLwG7eIclr9pToa83T97e0wINKVLRcz1XeJ3Cj
	2aEXwWse++w0X9LWVUimUIeMQ=
X-Received: by 2002:a05:622a:4c15:b0:4f3:59a7:67b3 with SMTP id d75a77b69052e-4f4abcf0be2mr535752921cf.20.1767198055385;
        Wed, 31 Dec 2025 08:20:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV93a2/ytBr0yG7s3l17noCqyNn3HiIII00axJsk7y5AoZm/pGqNYSP6VR1gOdPsz+SL1V2A==
X-Received: by 2002:a05:622a:4c15:b0:4f3:59a7:67b3 with SMTP id d75a77b69052e-4f4abcf0be2mr535752671cf.20.1767198054918;
        Wed, 31 Dec 2025 08:20:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a186282ecsm11179301e87.94.2025.12.31.08.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 08:20:54 -0800 (PST)
Date: Wed, 31 Dec 2025 18:20:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 12/14] arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT
 properly
Message-ID: <fk75wduux3dilfx32mlufx7alz7cbz2xa3s5ubdpyosd2t74yh@7x7q7yhogmne>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
 <ed3e9128-cf11-4ba7-a7f5-cac2c537c2e3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3e9128-cf11-4ba7-a7f5-cac2c537c2e3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDE0MyBTYWx0ZWRfX58JjHoqC27Wu
 cy+uIkR+e8u+cag/aRnFh3A80Niw48abOeRWR0pQm2N8w7AUbGU1rb4awV0Okrgj+SJ+NUPK9S+
 FQU5B4Gnu1lvLBjjYHx+fXJapWdHteWeDs4NwTbVnAUuvNtg20o3O9Mw43rNnR3MZPK0aCOZ+Hc
 nXRLq62C3W3+gvdjmL4XUU/PBHPmtUNRBsPxTvC6OTSaJ/OptvBcfWYph/aI08lUNgc+QhrA0PP
 A4+tBz75VuA2xvgW25/aDf5LU6hVRGMTd3zn8d/+Q/dQDc8dJ32YOSXZVxYFwddQC8hUkl2yhpS
 ++/KOrWKulHTEf2SnBt5okSH0LVbqRtkbywxCDhv0DP5VdJk/yIRx2Qb+Z1ftS8CJBFADtPHrvH
 TVowmamwtZo5uw1YAurgXUc+MxvAT7fudwzJT9dTmUK5+gKLc7HriML/kWYqacY0lY+SqYvMi4z
 di5SqGkOALadG4IeJyg==
X-Proofpoint-GUID: PcfG_boM25lTIWJmyQOk2Vwa3kC0M6j3
X-Proofpoint-ORIG-GUID: PcfG_boM25lTIWJmyQOk2Vwa3kC0M6j3
X-Authority-Analysis: v=2.4 cv=Mdxhep/f c=1 sm=1 tr=0 ts=69554d68 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YM-ir784Kfn1-1I9OqQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310143

On Wed, Dec 31, 2025 at 01:19:23PM +0100, Konrad Dybcio wrote:
> On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> > The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
> > further spreads generated voltage. Describe the PMU in the device tree.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +&pm660_gpios {
> > +	sw_ctrl_default: sw-ctrl-default-state {
> > +		pins = "gpio5";
> > +		function = "normal";
> > +
> > +		input-enable;
> > +		bias-pull-down;
> 
> Ideally
> 
> func
> (no \n)
> bias-pull-down
> input-enable

I'll try remembering this for the next iteration.

> 
> anyway:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

-- 
With best wishes
Dmitry

