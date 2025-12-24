Return-Path: <linux-wireless+bounces-30100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714EFCDBD80
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 10:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E156300D4FB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BAF33556D;
	Wed, 24 Dec 2025 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DCRQI818";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwTSVLzX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A9329E62
	for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766569479; cv=none; b=FeoBTI7NhRejLmKLf7d26G+lnSyuMKFhyYKBehfMb7h16nxISv3j5qWIIzYtgMaaTaX3/fqD6V6IcESTY7n8h8qCMgymzmvzpbwtQdjgXawND8qn5HqRJyO+Vt0NWvSu1XvHWSlkJw9Ciu55IX0r22qQfaJ+WvUyiy0r9E++cG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766569479; c=relaxed/simple;
	bh=tlec59c7vzI12AdpQO5MvuW2XJ692+QIG1D25DoEfbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lgbz3v5ecfrVGwz+ZeTiNnUKUR32+HKQqc5a25qHzyUjfEl1z0vM2R4k+8og1DY9e5F4tUn6wgWXjOiRJ9V88ME38c0/mkJVU8LWv+3mA5ZZNM14UAP+OVLkBTCVWxKey/D/1L8HOAHbr6WoUMAGFc5OazsE3XLt+/oNXCozGE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DCRQI818; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jwTSVLzX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO17X9V1597821
	for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 09:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j8bMJPL5URsN9kC02yIvSGN59PPsUlvnLYy8ovug86Y=; b=DCRQI818VJNfhxvy
	vcwkm144QAC59iKG/n+dX/NEbry4V3bERWVgC63J830y2+IxplKJu81zvnBHVDr+
	YYxhtg3kBdrboHCwaF+Y+tHK3Xt0I2PwdEh92WqpOYFYGxANzU3pp7MnexhOL9vB
	SeFLB5G2ArFIq0saOFNc9u62sZiisH0/kXKVrEHEcas05swDUkddohEtr2op6gHR
	Y9gYRKW04/BN6XURT2F+bDBQv9FdNKyU9ds4H0NdtAyOdSeGhhDW/K7/9J/tc5qo
	Mbn1zfc7sK5GIFF7U/jCnzwbFzxqQlbYEkvQuTyz8fxGqGUZhESpB3ziQe4ZvS6B
	buSDfQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8683h79e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 09:44:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1d26abbd8so156852901cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Dec 2025 01:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766569476; x=1767174276; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j8bMJPL5URsN9kC02yIvSGN59PPsUlvnLYy8ovug86Y=;
        b=jwTSVLzXCtJalP3udR5mbXxnAjnorYa5Myv5f7+8Xdud/ohFVomOqmVIssbkANHNmV
         RC1pI9DTvhsLOjv8XjUU4q53i7mkVn2+i8YnJ1sMDaodqpa7AkxP8IL/0DwTsAG4tHAr
         opjxOXReumcVg0oe1525dHXIn0Cl8Zoih2Gmxsv3woflisSGSomKIukD0cyfIWDLNijc
         Isx2FiNcUk8oP2WZSdo00lVGCvtOLxv8Bz48zT8US8ptEaw2ZoKadG2duivaJXb43ElO
         mC74B/gSKzFAqGinl0g/tzsdq+aRtdf1aj36Ekli5omknfS8OBEoK/ZvIG+FkxQ3Har6
         kUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766569476; x=1767174276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8bMJPL5URsN9kC02yIvSGN59PPsUlvnLYy8ovug86Y=;
        b=OJKEinSRXELFs1knVmbQwRUAUj5fgdepRVDx632J6A6DrrY649ZQnP+L6ObkCSXm5P
         bogIqZqFmOLsItJybDq8l3Yyu1otoIRF9pC8cWcLLWpQ7hBjdNaXOYA4ndnRZwYBCyLj
         PQj1iRfjhgts3sdbZrQugNaefzoXxGdmPvJduAUuVHEmr20/6GLTshWqCMy7Kct68VST
         GhKnJknVnmyPPHXBpRYj6hGMIP65wytRskXSkn5BY4iPjPfLruS+o7piPQQwYAO14wE9
         0dz1D1MpO71hkKRsA/Aheol2PRXZHhXIQd6eysj51YHIwxwsTsZWSkb6JS97iJH3QMpZ
         JtCw==
X-Forwarded-Encrypted: i=1; AJvYcCV4wr55bxnfzWFya3cvO5EtOWBcP8uUD7E7HsfrQRAIUl+r8SPGtpkz1ffycc9JlxjgJFFVnD7JWOaxqe7PdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4NbPrYLM4QpPMJxwW4fOFFYLZ9Jfzvg+zO53BFbvN+5FHodf
	rLfKH6vwBrJS4JYZFDjyu5ExQA2pR3oQKb4ZrKd4q548UoPa1iN+BCDNh2WFHfdVIFsNkHxv/NB
	SkFDf/imDqI7ySmk0etSCa3f3LLpLhbfif8eaK7G1j/YW8IGU3INetPfIBgP1XcFgADPX2A==
X-Gm-Gg: AY/fxX4rYyTu0LNU9+y4SRN4rPB6B84MywSFhWWp+eRpRIXSBGM0t/Vax19VnpO1oz1
	ZFDBkf+m3UAh/hQJw7bNtWs5iBNlmRU1u7KN02ZLJjz4e6f5idDZzTMlkpnp6fMS4VPUImdSO20
	B7u+dt4SJ2jsaJSBsQ3oLcgIeKI6xEzYoLFJGvE7vEyU1AV2b7s/1dRW1CaX/dUSJrvlTJmr3Am
	2ZWW77yi8XhKNMh2M2P1dRT6Fpfk7nqv1DEwdyhWrzT4qQIZGzzteMNpFH9w23HTjvy6VVsyDWi
	Iv6ISeb2kURqE/LWOSFdSscMzB/rH0pDuhR+m7WU3btjPsddkG6axfWwcRbkImdkL4crFEN+/KC
	VgJt3OhAt2EGciSS9CHocqA==
X-Received: by 2002:a05:622a:1aaa:b0:4e8:aa11:5869 with SMTP id d75a77b69052e-4f4abdd77c5mr248981401cf.70.1766569476160;
        Wed, 24 Dec 2025 01:44:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkNB3ACPi/FO+hv3JoHsZTBX5MuwuJtcjQ11szAJg+HHnPlCeIsNXx5g1+5A2cYrPCZrtUkA==
X-Received: by 2002:a05:622a:1aaa:b0:4e8:aa11:5869 with SMTP id d75a77b69052e-4f4abdd77c5mr248981161cf.70.1766569475653;
        Wed, 24 Dec 2025 01:44:35 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab257asm33694829f8f.38.2025.12.24.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:44:35 -0800 (PST)
Date: Wed, 24 Dec 2025 11:44:33 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
        ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Dale Whinham <daleyo@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 4/4] arm64: dts: qcom: Add support for X1-based
 Surface Pro 11
Message-ID: <qptvyecgevfbknaepnyplv2543wojt2cgj26kdsaaytnt6r3rk@kko2bjurdbyp>
References: <20251220-surface-sp11-for-next-v6-0-81f7451edb77@gmail.com>
 <20251220-surface-sp11-for-next-v6-4-81f7451edb77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251220-surface-sp11-for-next-v6-4-81f7451edb77@gmail.com>
X-Proofpoint-GUID: TeObxHoUXKczDvWYBtI5lBq20uY0fyF-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA4MiBTYWx0ZWRfXwoY3Qv4pE/mm
 CMdOeiyTdmaXqMbb7I6q7AAl0ZfFNL7EQacz6fad8mkaC8jm5VIaFRubrZY28ldw3fs0rgkLnrU
 uJCzcc50xI0n9j3TxFEdueHL6Iz/o1kHRdYqkDtsok+qW4PSvkG5fHt54GniMeYaabnXpmATkXT
 pKpj0xSVv+IHZMa5BJYOb2cKTwTH34i0fZ7vr44L/KeJUv2Vv8zCDVRk7rZtTjB1nLj3u8xG2qH
 YFCSS4GpR7DwjS2K6BTyrBbB3CV6o5ewrWWSP2sKOeYAnUj+WbAezFj83wQBqpPUWh/r0y4pacS
 mEHvS10Sn0GSEpUNQiEXplFDUFM+cV0yUCdqLeidcyI+/YckxgdYSYp7E2olO8pz9qvKPPufwZ7
 nO2aIs9kI0OuC/5U0mtDc6XUYaR9P/JGctqPGu5Oj49rl6kIYfbf2FpsE3Wy/u31A38wKvY1jry
 I4eXEuskJ7iTy0r1w8Q==
X-Authority-Analysis: v=2.4 cv=HqV72kTS c=1 sm=1 tr=0 ts=694bb605 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=DdBtMnqNxkYIvXj6ev4VzQ==:17
 a=8nJEP1OIZ-IA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=GlChVbD0Fj_pvowmbuwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: TeObxHoUXKczDvWYBtI5lBq20uY0fyF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240082

On 25-12-20 16:26:32, Jérôme de Bretagne via B4 Relay wrote:
> From: Dale Whinham <daleyo@gmail.com>
> 
> Add device trees for the Qualcomm X1E and X1P-based Microsoft Surface
> Pro 11 machines (codenamed 'Denali').
> 
> This device is very similar to the Surface Laptop 7 ('Romulus').
> 
> Use a similar strategy to x1-asus-zenbook-a14.dtsi so that we can create
> x1e and x1p-specific flavors of the device tree without too much code
> duplication.
> 
> Hardware support is similar to other X1 machines. The most notable
> missing features are:
> 
> - Touchscreen and pen
> - Cameras (and status LEDs)
> 
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

