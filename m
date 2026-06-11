Return-Path: <linux-wireless+bounces-37669-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YiQ4HCWmKmp7uQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37669-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 14:12:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D506A671B4B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 14:12:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=fX+52gJa;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=G1QFzKHO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37669-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37669-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18E9E300D682
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4ED30D3F6;
	Thu, 11 Jun 2026 12:09:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9342E06E6
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 12:09:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179774; cv=none; b=OWlzUjyUbSFyw98Dc90G5etA8HZmbKU1KosYL9CecOY4Nv3oHQ/kkKdZue5xLNONAWJGAQ1gZ/AGpS/GIB86yKP1qwSEm2zqhAC4yuLzdlT39IQDEmVRMEKA7SqnWaeNIyqQZfp8O6IFyPl+e/ByBRY3noUPBiRGvQ5QUdIo0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179774; c=relaxed/simple;
	bh=PvuQ0Mdk6NxDmi0CVM4MzXjDM2sWs1KzMrzzbVZ/HAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mob2Qyk37PTx7bBgBRQNh5MFXoLecE3CejqmRrev3NiDJjiVj1Bnr+YbpkdE3VWjrm34Qn8fka0GEfTH+s59ZKiYO6hc24k+yb+OK/gFTiqloj7xAJibxU2gDzVsOqrEN557QmI4R6ETS0/gt45XhewC+YEfyGcEjeFLki/utI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fX+52gJa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G1QFzKHO; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BA1V1C168321
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 12:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yanaRHSayxwfAY3It1ezK9zv57klScwZdrWFXBHHX20=; b=fX+52gJamw398GVK
	gyubigFeKdi3+9/GX+7kBBj6HY42+3HdRKhPsu9mXy5dbUXS90EJqjsSHDC3G8CC
	ujFt7Rt0wqppB+I402QBxcq3vY6l3hU4eZmp4tlXDqXI3o46pazyIElutRHRxWLJ
	aEgj3/0kX0o5BsLwO/PzMC5X2dBUcJhBZI3XcbFvhnMqDvi5OELS82WE6F5sH6hI
	hYNgSUlZlUqqSTneeKkl00PR+tpsBSZNrbtsjmaeyjjYMC7MqNVdmDXHOXFSbqgD
	///S7kA36MeheAERQvf+Mhsvk4jn96lMD7qFNpb2p9Ce9BLpMN2HwqV1Y3COO66A
	0wy0GQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uba30-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 12:09:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51759082206so23471961cf.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781179772; x=1781784572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yanaRHSayxwfAY3It1ezK9zv57klScwZdrWFXBHHX20=;
        b=G1QFzKHO+FbmtnEAl3cgJ0RO5AAC8b4riE04qiEmvuCy5IpV7zXK0ZRH1B6XG7pW9p
         9nguGU+sAwb6S6Y++D77HeQ1TX9QZQ9l325y4Q8dw+gg76TVEnKku4csMaVGGbGLWG3z
         f9RVhD7CHTy3UmgVnhfR9uwru76L8d7IGXM/6uvKB8CvsUZOn1h1KWX4v42fKyXD/hja
         XWXpj48cVsJfpQBx4sSbQ4HGcyWAV6cJoYb3QRHYBJ3dAR7fIlih4CNZiZkF69hBgqZH
         m7r3SyqbdKwN28l7gQDNfP6vWl71VvQccVcMGjOuxrOfMRJE/HSI9pWkvHGxDYt50sBP
         s4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179772; x=1781784572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yanaRHSayxwfAY3It1ezK9zv57klScwZdrWFXBHHX20=;
        b=TF3pHHoU3tDZQvvVMQMJA5+BspoaRX4W9GCrXAzSQekIVL6oL70DSshyftVAehs8nK
         QrLZPeFZQTNfsHvNIQjls1B5Vz+k0X7FZb3Yr6bXjDltfhfLbYxj3G4jowsO1OCe/tV/
         YgLC+MASBEhL+WPVaUqQ7rvVnqBbdXeepkQAgTv90/5tCC9qWZM+YHb/B93lxTiQ+EAC
         wp98yJauixrFPeeHGRmhiPOyUfXqTHSlvoQEduvpx3eezWyqSf6Ox+h/7jfswFYH+jWD
         KcTr1HK/KjLO+8yjjT5hFIzGINgG3P+DWHy6UYNuFq7DYna6K/uCMB0+bV1Y1FCzYigU
         RwVA==
X-Forwarded-Encrypted: i=1; AFNElJ8kKq/YfozI9OfUq72dhskKdNtDuHt4WAh+Myd8ZzOxJZuWG8Nx5gFvtT85xXsE9MkPvp8PB0ewxFacYwHiww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0qCWOD3JqjM6Qbu4ncvlT7MpK863TsCbB0Hmc7SiEsE9sEt2
	RjaN8xBBPNOiiVbTK7ngC6hiXMktqHglQWl5k2/DFeXS40hEpM8FH7HL/A2RLsqbOLGI3M98KbQ
	OgKCCehiQgUqGp972sCMrfEE+JZt0vildq5UgiqqBlOZo/qrI8ahKiGURuha6vbhHHoqQfw==
X-Gm-Gg: Acq92OG0Qqkg5eOFBA7JgiudK4BCm594M1z3mecn7aV4n+EITLbvg1JFFQDLwM/gNKi
	qRCFP4iHnp5gz3yijyGtDqWaMTGQOI3WoaJzdRbctFhaieD5IehtT23JX9K88EyLYs+8+S0n1DF
	AhRmkCimlj+ChNif6JgbCoy3Nxl6Vooe8fUnZj//n6JGY4chbr50hSbc+8mVsb6hjfIC6eSC3uU
	7qJ2diL7N5Yp0myqaGSi5M3x3v4BSGnY+Oqd5OqBxjhEQHKH0LBAWa+Y3p9mp2K/1ViMGiCcFQr
	tQ73Vk4J2smc87fpefTRjnQMtky1/P+o48bAKKh3frnjk3EG+EAOdGPQgoDdWmD8WRPc7wh0f/o
	/TKXXx4g1jdcDQERQe1SGHiOVHJvVxHk6xeZ6kH17rFiFONLqZtzhOIga
X-Received: by 2002:a05:622a:1449:b0:517:8999:6c4b with SMTP id d75a77b69052e-517ee262f43mr23989001cf.7.1781179771918;
        Thu, 11 Jun 2026 05:09:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1449:b0:517:8999:6c4b with SMTP id d75a77b69052e-517ee262f43mr23988691cf.7.1781179771522;
        Thu, 11 Jun 2026 05:09:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb60ae379sm56540366b.50.2026.06.11.05.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:09:30 -0700 (PDT)
Message-ID: <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:09:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfXwhYwJGkRtEJV
 KallnPGRYDTpBOo67p+i2ILCnxlepgw/sn7Vc7oBYB9ic+j51lMx0ZQLetEkHGXSbl9HLxOWseE
 Xa5qA4LS8mkEXQJtRqOA6fU3mqJdlDQ=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2aa57c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VQxyErZXnhhA2ehoMNgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfX9B/I4fGS9NDB
 42Dy8y+Ii+m5eNyOJi8d1MkjeexSn3kJTPSSNhLQ+nRuI9QK5aar5ViJoDB5eUTI7OxEjYFdL4k
 38khdGMajuACvaY+UeZtc1Edy7FRfnpaaoPGHFdJ5iuSMRvqrHhaqiK0k9p3z1LKFZIQJfIaPiP
 SXx6+FItUip5oepaUy2Uizrh5a4JyOAg7yznYJtC/CdOdcTi8n9pzNH97zx9bD2ClfOYl6T3/Bt
 krY4cHq+7W6J37sGpuTK8oPX1ir0WF0ArHhqwHKWllnQcYnaZJdO75z8BEM5vwqJliC5xK9fLSA
 Ot/yBR1wy+pDwl6G0qcm3nSQPE34N/WDfYKH2et/M8EkXqCo4JW2LfDQXsAYbDRhC4ElHGUkse3
 FUXL/Kab9q8XnV4wzTcdYVLXNFBbvZ+sdfVuhLAisoE+OTfM8j+x2XBETD48NFhltupIvzYqfOT
 oOVOAPkGx4p1UqEHugQ==
X-Proofpoint-GUID: dhuo9VUEo0d1Vg3MYOkiWbvo3mFNB06C
X-Proofpoint-ORIG-GUID: dhuo9VUEo0d1Vg3MYOkiWbvo3mFNB06C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110121
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37669-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,google.com,gmail.com,holtmann.org,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D506A671B4B

On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
> The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
> version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
> parts of the device.

[...]

> +	wcn6855-pmu {
> +		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
> +
> +		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
> +		pinctrl-names = "default";
> +
> +		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> +		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
> +		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
> +
> +		vddio-supply = <&vreg_s10b_1p8>;
> +		vddaon-supply = <&vreg_s11b_0p95>;
> +		vddpmu-supply = <&vreg_s11b_0p95>;
> +		vddpmumx-supply = <&vreg_s2e_0p85>;
> +		vddpmucx-supply = <&vreg_s11b_0p95>;
> +		vddrfa0p95-supply = <&vreg_s11b_0p95>;
> +		vddrfa1p3-supply = <&vreg_s12b_1p25>;
> +		vddrfa1p9-supply = <&vreg_s1c_1p86>;
> +		vddpcie1p3-supply = <&vreg_s12b_1p25>;
> +		vddpcie1p9-supply = <&vreg_s1c_1p86>;

[...]

> @@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
>  			regulator-name = "vreg_l7e_2p8";
>  			regulator-min-microvolt = <2800000>;
>  			regulator-max-microvolt = <2800000>;
> +
> +			/*
> +			 * This is used by the RF front-end for which there is
> +			 * no way to represent it in DT (yet?).
> +			 */
> +			regulator-boot-on;
> +			regulator-always-on;

msm-5.4 maps this to bt-vdd-asd-supply (asd being a keyboard smash,
perhaps?) - what is its actual use?

Konrad

