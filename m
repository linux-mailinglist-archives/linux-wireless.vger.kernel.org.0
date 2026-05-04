Return-Path: <linux-wireless+bounces-35860-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFXrL5ic+GmdxAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35860-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:18:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAB24BDBAB
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DB4630C68F5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367183DC4D2;
	Mon,  4 May 2026 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZSvuHGy9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XMhwT42B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9163DB622
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900262; cv=none; b=mj4VSBKXw5tEndAB8bF62yZuozqpAZUlvOFcvcTWQkEQpq1qbyf3ZEXh7Aw6d5BgOyyYsXHEdRNa5Br8qRKSrqRtS8U7Nw58jbnvgwhZNo6JzB+tXr6F2CGBqVMWqRJU6IXp7rpDJ9YTBuDThihUdW5eFrpyf/uvgGKvO827xyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900262; c=relaxed/simple;
	bh=65BCyDO9jtqHt0rIS+TTWdrkvghKnA/Z0GBZ5zaHOzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rorrByTbnXuiNJFbs223cvDdSEwL1iEAaA0Uyq2X8bYXmwCNPpgSyCDsAkpHmuhHGTT1BZLgxDLKXwoV5LOrLIB2EHK6l8123qvr7HKk7msJ9DsOkl8pMooR6CbAUX+n4WARFz0n7m7QKwikIyBfHo867rIeThmdnL8oDXEe1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZSvuHGy9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XMhwT42B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644B484l4128666
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 13:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EyL+ckv32prGhdqPvBC96FXpnqbIVDmGry2rLJFtils=; b=ZSvuHGy95t9IhfsP
	U3AUnAAWUZb4mq54JFS6nvzoZ9btK6EbfUg23V7kI56xOv7GPGAzijdIcg4NtuwA
	QQzmGEQyU/M8acpw5M99WmnZoh9sOA+qPIXl0bAnsEezyx4ZT6VH1emP73U+So1v
	P7dUn0UWcIkTpQug6+gD66d4Umg7wTExv3+MGH+pzOShYIhqBy74moGYuJ7yqwDm
	qW8DAN2Nh0Yov6kGScLpG+Pb6VQHKwO1zbNqBJ1kq530dm4W+d0SNFH8E8kP9XW6
	SVo8kV2gK42wvtxUL6SkLKEtx02NFmBDUEtCeGR1dxi/jjEP3YV433YmTCMgLyDY
	E780jA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxsdw0h03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 13:10:57 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-62f375d49f8so41378137.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777900257; x=1778505057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyL+ckv32prGhdqPvBC96FXpnqbIVDmGry2rLJFtils=;
        b=XMhwT42BYOa/tG22c5TqncrG0WSs8tKCsN2doO/JXG8VgUpTHTnSgrdBFk4rSzfJ/s
         bSbWubMyxaZbQ/J1aoiXx+Ac8BUXJQwkv1O9+6QHcbm8tMzlWacj2HVy1O9TnwZxuJmC
         0zOCXYIYB1doyquaS7YVyMsDrl3PEfskfNs5x3rvmmBlNiWQglWeS6irATSTgT8jPEbh
         DVw3Q++hjcJyuX5AmE8kmRG5blbynWQ1Lrz6Ul0sXjzDy3d3hBBIRdqYHZatQJzZxKyU
         DER3eEAiaCLU4s/vc9S6TYXaGRFiGud0IfsPCF9RxyAcUi9ZsUEbw/Gkmb6xLybr07lv
         DEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777900257; x=1778505057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyL+ckv32prGhdqPvBC96FXpnqbIVDmGry2rLJFtils=;
        b=EhVcsjiF2Hq3bB5MV65LZeFC8W8dWWnYIjdR044yhpLrYWquXcB7kZW0Ah+cxMEMwq
         FpS1W76Q6VliTsb/8ZZH5Sw71Mz5kPBAY3pBV3NgIyhUF59gVEhHk9wxsGeghlrDtnuF
         4PDFJMW3X/8dRx20vbHI3qos/7mmfbaPiSNp11/nBVe8FvDGLt9SuyRh1EZ3XxeOrVnw
         60AFQeSb/qGXvRg+kUsAYCd1lf/ndfnPgJjRPdbH5+z8zyFndI0A2t2+CIY81IBNLe0K
         4CvMrIDnpx6KxYIvwWwLGSIg4EXYns1dH9GYTqfXq9Z2O6cbP6a37CF6jNWxv+nCYfyQ
         PZeA==
X-Forwarded-Encrypted: i=1; AFNElJ8DdKElygcN696FjHOraVdk0odtxPKJaSolFV2cjwX7oOGvfJp7qAAbhbvWCxXLTrAsIL1Ft+wU9xw+jSwRQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4AO6Apm8HVRVUYHcDb2CA4AmP3fZiGt+wtUKm+ccaT/ZE5zVh
	wxkdjNsX9OLIPwkP52rfrbGRCe9RcXIr7d3hRzFzHlQVkezqPRTJ73F3xFa5YGOcGXBr3AyrFb7
	B9W1ocGGTWFbfiGtnVJPNBwhtamirOWlG9xgBGioBnT10ZAsdvOBvaW7NHB9HKL35OjODsg==
X-Gm-Gg: AeBDietYtsLBiXMd0uGhALnQnDvRx4Ibpz8HohkI8Artp+ZgZSgmDkE40VdVFFI5uJU
	CxDoQsAApyd85wcOQiidlJ/n2qKOVZmd8Ih4fo6HQUUkqNjCVPozNGcCAOYU/ZbzXvmmZ2oZbZr
	bU769ZYef8hin2/D2v9HCHpe5MzccUzRVgqtia6SZxRWhEbay6FYRxYCiZIMQcOnk69YvUqTcAX
	PL8p5GzKhK6Ke6yKgEhSMnkJe0iew16ft6jh6J/VFFFMFifxxg11SwLaoYOFQY/3Ho90zbyLTNJ
	XS6el1RaGS/RzQYuyBDpWUrb7WHHkK75IW4l0YTHIIiGYTFhDhmT/yRIzDqd3iTA+tf9Wbxg3Ze
	NwYT8xJpk3AtvGK73yKNwpyBwDhFgNwCzKk8T7w2myMz22dXnCvGtJbEjPoriqB0jvE4kztmQ6i
	Rf3wJfREkcBmqhmw==
X-Received: by 2002:a05:6122:3611:b0:575:35f9:66b7 with SMTP id 71dfb90a1353d-57535f97091mr279797e0c.3.1777900257420;
        Mon, 04 May 2026 06:10:57 -0700 (PDT)
X-Received: by 2002:a05:6122:3611:b0:575:35f9:66b7 with SMTP id 71dfb90a1353d-57535f97091mr279764e0c.3.1777900256820;
        Mon, 04 May 2026 06:10:56 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1ad2d59fcsm149037266b.45.2026.05.04.06.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 06:10:55 -0700 (PDT)
Message-ID: <870d16bb-b426-4285-a299-deb09ae90243@oss.qualcomm.com>
Date: Mon, 4 May 2026 15:10:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: milos-fairphone-fp6: Enable WiFi
To: Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Alexander Koskovich <AKoskovich@pm.me>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-7-393322b27c5f@fairphone.com>
 <4fbs4arx6sez6fffy75ctmzecfvitr6aocau3cczlr2ps2ptld@v7wpa2irsihl>
 <2514523f-a43f-4470-a69b-3d5175d10385@oss.qualcomm.com>
 <DI789NOBWJHK.1V3SFQLCFLS4P@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DI789NOBWJHK.1V3SFQLCFLS4P@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a7AAM0SF c=1 sm=1 tr=0 ts=69f89ae2 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=1iLxIbVeREuL6hqEqU8A:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: OOvwi8RPvVnqgxQlv9xthcdAnaVxlMlN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0MCBTYWx0ZWRfX0oHTxp+a8hWt
 nItwGjdYjSb27X/nP7qCEPlj7r0jBx2KyerbnY0fkQisoYiKhQOtIu+E8XFn2sTs0NNvKMTHUlE
 HSR///4ICMcrHn/lMK95v8jqTHY2qfj6wRZrZa5hmHLIKAx/UgySB7W/TYd81Lg97V4yf8wV49K
 KN/Si28tmi0m0V1F5/p9b/E/5kwP7PaQdGEtqskKsoKcWYRLePDo9Zo+Ec/Rt+xzWQ98F2hhW2r
 ofhRO5XZ0AWyd8tWqTI+YyKj0oJGGFWqqQuY2RfaZXOSe7tAXpnPCOuCOSSR7akp8Kpi11mbAVL
 c6Zsbn1ShgEXZXsKuhX/zxuFJKXpKU83MOrvMY22WfSolv8aCm0nxBRuPKOsPkjjl9/mJ09cyEt
 2j48JTHysS7dRTsuF9akrOp2FDd+ZBmqEiHfBVRZl/Ht8Yl6dlqC2VkRheUoVytvfTmjxSlWRiy
 dkMA/wiw1eunGbUPMpw==
X-Proofpoint-ORIG-GUID: OOvwi8RPvVnqgxQlv9xthcdAnaVxlMlN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040140
X-Rspamd-Queue-Id: 4BAB24BDBAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net,lists.sr.ht,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-35860-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,fairphone.com:email,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/1/26 11:20 AM, Luca Weiss wrote:
> Hi Konrad,
> 
> On Tue Apr 7, 2026 at 3:16 PM CEST, Konrad Dybcio wrote:
>> On 4/3/26 9:35 PM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 03, 2026 at 03:52:53PM +0200, Luca Weiss wrote:
>>>> Configure and enable the WiFi node, and add the required pinctrl to
>>>> provide the sleep clock from the PMK8550 (PMK7635) to WCN6755.
>>>>
>>>> Thanks to Alexander Koskovich for helping with the bringup, adding
>>>> the missing pinctrl to make the WPSS stop crashing.
>>>>
>>>> Link: https://lore.kernel.org/linux-arm-msm/DBF7OWAWQ94M.FSCP4DPF8ZJY@fairphone.com/
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 19 ++++++++++++++++++-
>>>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>> index db72418b7195..d8ac495ca7c8 100644
>>>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>> @@ -242,7 +242,7 @@ wcn6750-pmu {
>>>>  
>>>>  		clocks = <&rpmhcc RPMH_RF_CLK1>;
>>>>  
>>>> -		pinctrl-0 = <&bluetooth_enable_default>;
>>>> +		pinctrl-0 = <&bluetooth_enable_default>, <&pmk8550_sleep_clk_default>;
>>>>  		pinctrl-names = "default";
>>>>  
>>>>  		regulators {
>>>> @@ -766,6 +766,17 @@ &pmiv0104_eusb2_repeater {
>>>>  	qcom,tune-usb2-preem = /bits/ 8 <0x6>;
>>>>  };
>>>>  
>>>> +&pmk8550_gpios {
>>>> +	pmk8550_sleep_clk_default: sleep-clk-default-state {
>>>> +		pins = "gpio5";
>>>> +		function = "func1";
>>>> +		input-disable;
>>>> +		output-enable;
>>>
>>> Hmm, if it's a sleep_clk, should it not be handled via the power
>>> sequencer?
>>
>> If you mean that it may be needed to toggle it with specific timings,
>> possibly..  seems that WCN6855 has a "xo-clk" GPIO defined. I requested
>> access to some docs that I think should have the answer, hopefully should
>> get it soon.
> 
> Did you manage to get anything there yet?

Yeah, sorry, it got lost in the sea of emails..

The PDF talks about the electrical requirements of the clock signal and
the section titled "Power-up sequence timing" doesn't mention it at all,
so my assumption would be "OK so long as it's ticking before you power
up the WCN"

Konrad

