Return-Path: <linux-wireless+bounces-29860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 139B0CC9DC8
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42F1B301E5B2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 00:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3FA18B0F;
	Thu, 18 Dec 2025 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XnhpDrrh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VrMzGrst"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6518DF59
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766016436; cv=none; b=jkd6IncYIVCP03XAUp5jFFVwt/fE5rJVTqOtnvGjYhpz3vFZHEbVqvwjRaLTTmBRvnC8GJNzt+/4lOz1f4gCNXKq7i72ryCx2B1tYd00tjKmkXCelFxP+wQu9dI8iLufUmweKKcZjATXgMOyCXwNNxPYZaHJVzmQ4rNRIZMzqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766016436; c=relaxed/simple;
	bh=MkZFiW8PVfEXC9iEw+RiF1rkp6MiXEJyjsZ/QWm8WpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ds0aC4uOJmy6OPRY+jXnsbAFWQIfdJhTKDc5f14YCKhZ+Fr1y6HN7dEtq2sKyzRTxnjb/FF5HT9xzBO/yzFMUg87KLGbjF+OYVNpK/HBX3OVeXp8Nom+pUwgWpJp+XPp/Y6IfqIGM1wLDabD0S+lk+dM4KLymlJmPi2FpWRzbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XnhpDrrh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VrMzGrst; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHJBY8l3888811
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 00:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+6X2ksbSDC2ya8H3LtEZEvp5I4IfOZ3iAR1V5pLfhRE=; b=XnhpDrrhKEMqop6K
	ZJxFdaUizCFjoYmS6Rm2/mPPWnuGlZYv2J9PnMpWNmwAf2HgWh8m642pU56Mfacd
	AHH0PdEGeZLU+7lun5fMhLro4ANvHO4McJst2HoGPpiAwos0qsEqqXv76EZiUDuu
	Zj0eFh4AQjjqYWOP8X6ISk+7UUNajlZZGZ3GWK7238Pi5ultBuKCgsy9ea8UpmX+
	oHlAwwB4ZQQNIGLKR61LztS2qWcWi2TBcQWxwXPokWxSL8Yi4UrULot63nwox0zY
	vBR/05yeaJnLdq2hXVu6qTL16Na3RUy8BCnU7LfreSbZsn0HFPpPGZUtIWUPfbcX
	aneM+g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3n333g8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 00:07:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edad69b4e8so1449341cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 16:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766016433; x=1766621233; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6X2ksbSDC2ya8H3LtEZEvp5I4IfOZ3iAR1V5pLfhRE=;
        b=VrMzGrstwYuwqKB4LgYwOaVP5BbGAct7hlDGhtWzqLJ801lRTL0rr28/EDgQtuXGHY
         HTTfErxvL9WpUQgHT7SJqhOm8weNq2Wttwx9M7FFqUV04sHQhxHh4vmRJO7w76D1CCwR
         Hw5rOFCvg619BlYoLpIDtPG1e37qvKoi2FoPcg1hyT7MAD6d+eSkKfr4GkXc6pxiSyNF
         2Zh2lIaQXhNmo55ZPukLlmaZcXuvgc7Y37UDOCmwqpDVelUpLQW2nTGUkWPL16UZ9Lh9
         haMhCg+B04P2bSbof8OtDL3oTno+bYlHOU+ODvMEis9q7AvU8E4P3BFlptUu4zV323jN
         psTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766016433; x=1766621233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6X2ksbSDC2ya8H3LtEZEvp5I4IfOZ3iAR1V5pLfhRE=;
        b=ZnM3e0MTajij/oT/Q/QGeFpK5DiFstsGFlj3sAY9BrRkvHo7+FcJNfxWUZ0HhZhwJ+
         5qPuN2NVdelLPneAQ4sxVy56kdxSLbMZcKEYZmuPBuv3ugPvoLvyvSHSmOKZbEkj/7z0
         0lZ7fo+HO8wsu4g/Y0hk9ma5plJlzh6mazeO0o9761GZc+je+cNb6QWCXxIi2+2QMFpj
         MRv6Hd9Dwxc+ezoYzdIXoyUMcOtOz32Io+hMdIXxP2huFWUhJ9gt/npgwAGG8waZJQmg
         wq70ZrQwK3qnLfGvSS0bpWcGHot+DLSyBB6jXHfG9YtbjG4WbF0gPL1JOb2Yakl7H1zG
         8/oA==
X-Forwarded-Encrypted: i=1; AJvYcCWl3D6UpPyU2WFoz1zvY+Ph7Fl1GWpgXGBezYA1vfulo2VowWr2jXty9+xnplsbpNh8xYdaSLlTVT4c5hopXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz787tIzNT9qFcfG3PVtGfjZoQlKEpXk9JCm8C+JMGTsn2Ik1vb
	Os/1nqCVqPHUp/rnyvOgdLbyCb8p/iuHg/t3m0SBZiI7Wtbp5KWMTYslHYDqejoMpUioI1j4jWM
	fpjvPbsEySgo+1AHLptAaCBknh/+DbATPqY4CdaGyRQSPJWqXp3ohSE2aYu13xl1i4Ie/eRNL19
	b2Ng==
X-Gm-Gg: AY/fxX7cqiFtg47wUcuf/FoMPSv/qDaEU+l084lkJqIuOjKUsTQZrRSKDz6HA6XivIU
	BQMV7ruEAA14dvXKdGRJ43x7Y5fcISjmut1NIGtFc5YfWwLrUDjVGkXQBjyfApz4W/LCYpHHn1N
	6vqnttSKwABFhoZ5prW1prytlmOnZNVAliJeeruKc6XJPk8bHQtRX0UYiV8lcMhjPc8RydsVto4
	tgkzZKfhQha3XUvdClO6VYsyByGdk13FF7EAaIIN9UZFgKE208tDDJaZ0XRrgKWPUO1tevC1RaN
	vV9V+2+xe1VbApSvoDYVIun3aW4OCCoro+HqPrO1EDGWr4uYksJhZG4JVNRDNUShpkiiJnzZo4B
	Mxfq4UrerZLzp6BnOibkDTKAhy5swXAO2VRzE9JH44Cqp2eHDKE17Bhmdia4Sufx4XU+mJPRYy6
	6xqB4iuJoPawgRBn3hnh302eU=
X-Received: by 2002:a05:622a:2d2:b0:4ed:a2dc:9e51 with SMTP id d75a77b69052e-4f35f43ab71mr22024321cf.21.1766016431935;
        Wed, 17 Dec 2025 16:07:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7r9ikBXTn9EQK+HDVKOPnuyMaSvuztty6xD+BwyGt1UHdgEs/NzHIQGQgsKy4i7SuFf+65A==
X-Received: by 2002:a05:622a:2d2:b0:4ed:a2dc:9e51 with SMTP id d75a77b69052e-4f35f43ab71mr22023971cf.21.1766016431146;
        Wed, 17 Dec 2025 16:07:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a132cb5f7sm321357e87.4.2025.12.17.16.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 16:07:09 -0800 (PST)
Date: Thu, 18 Dec 2025 02:07:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: jerome.debretagne@gmail.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ath12k@lists.infradead.org, Dale Whinham <daleyo@gmail.com>
Subject: Re: [PATCH v3 4/6] platform/surface: aggregator_registry: Add
 Surface Pro 11
Message-ID: <s45ki2ckgw7fu25h5wd6mb3mc4kzs6qq5eitv56asqf2suxh6l@s5tbqce7gz3f>
References: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
 <20251218-surface-sp11-for-next-v3-4-875afc7bd3b7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251218-surface-sp11-for-next-v3-4-875afc7bd3b7@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE5NCBTYWx0ZWRfXwTfqHdOVV0+e
 SGBp+inL9QA0abWbBylN/olTNOF8wGR9bgutkXgsU97JM7Et/KNy0q1ugJVTaCqtakJ4HeVCSYB
 nY81lnqzX8tFnsgA37j538zCcC54lK7NYLM1+ZHzismEOWEEObyQXCXcoqXF1OOrbottGcErvH2
 0aXg5pPGo+TeDMyl3sW2WApganzwhpRwEpCnX3zBVRPQaqgqr5f83hVHebq2tWwlSFHMmhALTui
 0NZWlpBuE7r5+ytAdtaV8ZibmP/hxiqMYr21kyeDVEC1mSFpcv8uMtwzlJ8i+UDa1gFAfYn1V+3
 TdnOfpb/F/yB0bagkl3hWhGv6irAHbyAK1B2iUEoPLQZWvxScs/Y2gbB3GLxdGc/vuPJInhVckR
 2+XPSU8mhG4+HHWjsFQZEz+p7WF5kw==
X-Proofpoint-GUID: Jnsb2we0V6Wyr0X8dFTS7SXQK8Tz86iM
X-Proofpoint-ORIG-GUID: Jnsb2we0V6Wyr0X8dFTS7SXQK8Tz86iM
X-Authority-Analysis: v=2.4 cv=U82fzOru c=1 sm=1 tr=0 ts=694345b1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=27tkrN_41n3i1SKUIiEA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170194

On Thu, Dec 18, 2025 at 12:56:40AM +0100, Jérôme de Bretagne via B4 Relay wrote:
> From: Dale Whinham <daleyo@gmail.com>
> 
> This enables support for the X1-based Surface Pro 11.
> 
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>  drivers/platform/surface/surface_aggregator_registry.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> index 78ac3a8fbb736384f7e50f1888a71297a892a7c3..c18d991afc8b0a0bbb26966351b75b8ea01097a4 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -406,6 +406,22 @@ static const struct software_node *ssam_node_group_sp9_5g[] = {
>  	NULL,
>  };
>  
> +/* Devices for Surface Pro 11 (ARM/QCOM) */
> +static const struct software_node *ssam_node_group_sp11[] = {
> +	&ssam_node_root,
> +	&ssam_node_hub_kip,
> +	&ssam_node_bat_ac,
> +	&ssam_node_bat_main,
> +	&ssam_node_tmp_sensors,
> +	&ssam_node_hid_kip_keyboard,
> +	&ssam_node_hid_kip_penstash,
> +	&ssam_node_hid_kip_touchpad,
> +	&ssam_node_hid_kip_fwupd,
> +	&ssam_node_hid_sam_sensors,
> +	&ssam_node_kip_tablet_switch,
> +	NULL,
> +};
> +
>  /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
>  
>  static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
> @@ -485,6 +501,8 @@ static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
>  	/* Surface Laptop 7 */
>  	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
>  	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
> +	/* Surface Pro 11 */
> +	{ .compatible = "microsoft,denali", (void *)ssam_node_group_sp11 },

Please keep it sorted. arcata < denali < romulus

>  	{ },
>  };
>  
> 
> -- 
> 2.47.3
> 
> 

-- 
With best wishes
Dmitry

