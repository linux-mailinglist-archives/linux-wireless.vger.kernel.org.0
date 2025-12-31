Return-Path: <linux-wireless+bounces-30236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31CCEBF1E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 13:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0E023008548
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 12:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28379319606;
	Wed, 31 Dec 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P1+lzf8R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h1UZN//W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615131283B
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183647; cv=none; b=OcJHwi96Z0N8hJ93SC3no4mw1aclK5CqQ7p7eEhfXW4zDOUAGXBD2A/TknK4lgq/319ajKEnFhSxD2It9DYJn9ApCFWXEbuYGffq/b2pNhWdbBXj47Ihjq5AKILMAujZ/2s15kFnhoBimf+xLbJ3E+3FkBFEhvVVbjF20BnDIto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183647; c=relaxed/simple;
	bh=MQmo3DqHrNqw852pxcHHZYIycvRtZz0hHyNxKMK+caw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWIY6mS17b6REC9yoOEZ0HjontNvZDZHivc3kSnXez3sGEP5u0x783i488vDW7Lb5/rGBncMXa27X3ItaWhpcILZmiRTAWvXqt5rXfPzxXthNiAFjbisVpJthCQ+Im6uynz/f5pmbY4w8pJKxj7+Hu4ahDGGOxIMKIE17fs/Jnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P1+lzf8R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h1UZN//W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV12Okn3971194
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zllIvUd7nwiRGgPkDw+woicrVI32te+1le0taRMAsb8=; b=P1+lzf8ReZpj3byR
	hyecp0nAeX6fcWHGEXiK1bpbcfhdPjFhZStXSR4KGbAdbWUODhI/0jaG+ZKIIxK/
	9+c08q4AfIMdwTg6tGJlDuFgZsE2ujnVSQUJGJURAAKwTIOOqASq51eN2aAOrK5W
	xfgBrL+JmzhySsPyzFNKvpQJA1xubTL77TKekny0CwPlYJW8Dt09uW5DZGnejmPR
	tpqXB5VnPjZXHqlM8P9tTqe05TtSaAJpy4adj1ytUGjQc3knloZChTxwhnAlzjzk
	Iko0kEPxEW5NH52gSgbOM54c22sg5czZtO2l/t8aF4oAz1M76ML9dtenRsZhaBR5
	qUpqOA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcdky2mwa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:20:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88880bc706cso17230106d6.2
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183644; x=1767788444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zllIvUd7nwiRGgPkDw+woicrVI32te+1le0taRMAsb8=;
        b=h1UZN//WDEnKjJQ0tKE8UQc9TAatJ67vr3AfcipS6UjhZ4bkctv51G0GyK733eoeP2
         8R/V9CUULxviCjiihBqqG02Upy7tei+qU3qBgkMTp6da+lfU2T5bnzPtlsBEtAymtJbd
         l8Shwi5i3pNeprWXdeEadmmLw8UJ2mMIchg4kQkRd8+lZkvEtz/iYPR3wSvj0aAgjaeM
         FHUpj8u/CFoFKm3hXtZ0HMcEuNk19k9aiKMyopFbF1BnbCGre2AjceEGleSAhn8eyZPa
         4R51k/pH8hYmyTXuAFxHgRIbmOb1EAgSr3bPxMc8SPuiAB4kr7AuRZnMZ8R/Q1nC1ZQQ
         WvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183644; x=1767788444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zllIvUd7nwiRGgPkDw+woicrVI32te+1le0taRMAsb8=;
        b=GtmYDYW5pLDvUCog8PwTtY6GzUYGoOx3GU/WyHL8MQ0z7LHfzfTz3fio8cj+Ol7RU2
         7jaOfjYbC82cKbx6jL6uin9ITsRwvZ6vLfZkhf5cX4ybscrrOKB5N+/jhltXVSH6b8DF
         9WvZ1rlxQmQtagFgfu02msCa6poJ3lT5elxlRFY3fGxWRmDm3nGFmmvOsTLyTMWlFSl8
         e2/PrqFx74Z71z7B0kknrFjEmNmFaKzMc0lqksa3hm8KPrqWEm42iUFnBQCSnGy7kumQ
         YPX1ny1ijwqc43zfQmbGkKNC3Pe6S0xGCWDTxduluGG2YRr/T8wotuJr5cfVHdfewJoA
         JBWw==
X-Forwarded-Encrypted: i=1; AJvYcCXAmjWrN7BS4tMGyZ0kRRFBpzryT0t7+cf0ZmfuidGgkRVXoANfyTmpRL23jM+Y+/PPUCDu4JgzMZ5CLqV4Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3SFU/f0GQEiu4D1Q3VzW2jGIG+FByHjF46ZWiaHUVylVs5Zp
	QaxHJl94mSnNTZGl1/RuEoS66wtbrsRep5nOLYC8FknYUZfduF0MNKJKocfmUj82yjNwmk1rL7n
	2vfUACbfEMsTZD2RZPm9jMMv/cqzcCHgb1Vk/ceNo6/p0rVRjCfDrc7JCd0YFZYwUOyYyng==
X-Gm-Gg: AY/fxX5Fdw1NFPlB/OVq2/3TqdfZEzeiIngpvKtYgoOyGXT4C/uvJe3lZIxdficl1rA
	49jnTyR51GAu9NkHvK2XmEa90DZuUUU0UWP/uFw7apRsE+qR4a5EssM1dZuVc6zENAivbX37mtq
	W0RjqLoIBpPg9w91ZfbJ4thAV+GRNfgbMuevr25y6P9tpXglgydKJiTaJ3f6B7YP3CwzRgHzm3E
	O6LeWdq5sDTFOcttEhzd8P4hlonhDmQQDrQHf8XYZcd6d/lsJuNSdQegRj4XGlelHVD+OChlxHG
	N8reik0P/cfP2lcsn6UqT6NXcPGgWTFYpznMKOsAolNGeSjQhrY2E7UVqLTb5whoEkA8DyfClKy
	mIw/wZLpgrl7eENTxkMwdz9zpN3YmfmIWWZE5GZhXFBU5lxVurvY0KN19MFyAFG/cNQ==
X-Received: by 2002:a05:6214:528b:b0:88a:522e:f1aa with SMTP id 6a1803df08f44-88d876fef2cmr429758456d6.4.1767183643718;
        Wed, 31 Dec 2025 04:20:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNxYZD2jUzi4kfyb+ZH7BBn1xDuW5BG9mO7Ob5u6zKgvjm1mqF447/ECV5NVNX2+vlurqoxg==
X-Received: by 2002:a05:6214:528b:b0:88a:522e:f1aa with SMTP id 6a1803df08f44-88d876fef2cmr429758246d6.4.1767183643248;
        Wed, 31 Dec 2025 04:20:43 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5ea6sm10827713e87.5.2025.12.31.04.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:20:42 -0800 (PST)
Message-ID: <4fa4a6f3-cc38-452a-a724-d2dc19219516@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:20:38 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-13-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-13-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfX3eKWlut6LcyV
 pK+kqrrZBrUD/W6SAcbiNTdo7cS02kyFmUoUAMJUYAqMBLyNTQLfPb545Bwk9gcgJ1pKyTDRGFq
 eECaN1bvr/jScXttj1K/Yl56qrC/f1C+Z3qT3MgnHx0qZb65zCYlHyLtfeyS7OCWT2Z5SPrTw+h
 nLxenoFq5y7C9pZuktZRVQAPWgkldiWh2qpfVmo9sGYmv3J1SjBpeGsF2Bx9W5iY6qZC3c4GehQ
 /e1CCQ84U7JBZCDVKy1ihawwl0ubYLqTP2XrR85zd1ADE7fFIz8gbRjKJv3L9TP9r/ArCuPpv1Q
 QOEb1iXL/NBeOUGXZVwLa7FPsP+8ZAX903nUqUr1gC6JzpEqRkbB6NUxdOk/8IfzlQioHZYC46e
 hQJ+pC0zpqfpLJXl3Obv5Fa8jlZQPFvZkoAxfnOruAiHk9AzmQYh5gscm+Xbv0aT/kFI41b6eRy
 EjhQorRIPhFm4IxU4DQ==
X-Authority-Analysis: v=2.4 cv=Wskm8Nfv c=1 sm=1 tr=0 ts=6955151c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YN4nVyxdPvXl5XCbABQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: HRoT4FvWMyQXYU_gC5iZmmglF6leF2hO
X-Proofpoint-ORIG-GUID: HRoT4FvWMyQXYU_gC5iZmmglF6leF2hO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> +	sw_ctrl_default: sw-ctrl-default-state {
> +		pins = "gpio3";
> +		function = "normal";
> +
> +		input-enable;
> +		bias-pull-down;
> +	};

likewike to the previous patch

+ please confirm ch1 supply

Konrad



