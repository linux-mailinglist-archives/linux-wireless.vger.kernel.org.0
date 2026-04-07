Return-Path: <linux-wireless+bounces-34465-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD7DAp8D1WnOzQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34465-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 15:16:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F40CF3AEE92
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 15:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DE5E300C356
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7A3B6C13;
	Tue,  7 Apr 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ppWcSLxq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kgiOXDfa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9C25F98A
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567769; cv=none; b=M/DPVKNst4ab5T+/5QsOXkwSsNH57fEk88PFSDwWS1VdqKxOWHEeALFUJXBuCgTfvawMLMuSslzRPiksYPvwZJTYZfRuBKyCRcUTG6HiCxa/ldsakJo+aPlwAyCK3WWZZRpjiAciX9qU9mUcpmCD/Q/MABI1J37RZ23ODi7uhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567769; c=relaxed/simple;
	bh=ZhvcqY6r1tq6QhvYIMabKOvGzftrA2RhnzWMy/baQZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZFqfxSH+6FTwiZ9x4WDFYJ53PFJ314MambOuBrIM+mG3grlhg29VW5GYzlv2YJlGmvMKkq9CidA/yxwrE1SdpFoGcpIzJnBX/F8ECkwJEJRTPZYvJkvSkjmbXiXy714e6APgudXzz1rB592peUWAKTc+taufDhKdfrM7Ff1mmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ppWcSLxq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kgiOXDfa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CxsWE2580027
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 13:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XKnEUyjc+ddoTTjBnULfB8xhWcYvXVbs8lR0FNjEwO0=; b=ppWcSLxqr5d5b9/h
	OZE7Q/KsO6xrwkRE+iJkyMXvUzZ2FHC429n0VxXDoAKUuMeeNxqlu+YiU9jT2+aK
	HNv45y2ToeC/B+P53CW+nbnaDOxNMuMco7kqoq2TpnigXwgQRJGkjmxAFhQCj/Hv
	9FlvYA1OMWAFVSiuGOKzW3gWIpt90V3EkfR/2+SrQMBzEoFvPwkjYPYhZJ4u+RvI
	F5iAxX9snpkLXYB04U1vbOQBxsBuYJzw59EqrOmWGi1y2SPmF2ESqETCHkEpFnGX
	ZJpHUlgLg7CH/sG+4Kg9SB++Zd59PFWq3IG7h6bJ23Pi3jERXb0pt5WqTC+2Hq16
	6Ld0nA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf2v56-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 13:16:06 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4bb770b3bso2928650a34.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775567766; x=1776172566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKnEUyjc+ddoTTjBnULfB8xhWcYvXVbs8lR0FNjEwO0=;
        b=kgiOXDfaJV5jSPXRAJSF6AA96V8D1FIJjXGQcD1/QRG/RMZPrJhYlhPBpyUZNFdUJH
         1Y9DklGoavAV0ClD1Hte3p0liu98+3X0abL4EbZ+UmaF1xYDbNFGJo2M989b3IFNuHBy
         nzm5j+90kXmOowm3UGXCaxWOBZNA+qq/gmu1CTTmwARr4msb1Fmd/0i1lWH8VeIbrjQ4
         edoC9oJkxrU/v0/tTFL9Eo+nW8yPM3TDpDdffnvaQihijP2oUrzEUVdmltQ459htiRKR
         HanrdAtOffKIyIgyjmNSEPGYyruVkc9F0BOXKObAM0WU1nn5OCTt8jGdf9js1sq80J0k
         SxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567766; x=1776172566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKnEUyjc+ddoTTjBnULfB8xhWcYvXVbs8lR0FNjEwO0=;
        b=NZOsAfKOYksiXZzfes7xMepXi2/+zs0sQk8GjwcgppkNNQPJQ8QlM0LTKRq1m9seKv
         qGuUKOoqEWe/Es6jxWIsm/sU8ab2SyiHBuabUdiboTaZFPo0o/h+agHdyIASXnPQuWD9
         WWC3Q1edt6F3QfdN8HuvHDRvjqHo8pHK5Mgfq1fJZjFp9Y6NX/kkW8ky5xYPIaYX3s/0
         Ptnv6O/M5v75AJMZx7CUWTNzU1YtsT6b08oPqP89SbT4xwWXZO1v1LmYV9cMWHlTBhcy
         hwfJNSpliHMKPnQHVyhxefMgIsYU3EuDEXqkhN7q5mDMZlEUa2Tm/HQyaPIHtjfdwb5m
         uElQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpl6VL2pSmxYpyw9JQr1oimwcTXrKTpcb//n4MjJd0f3w1VC2BUZnySFqv+tKbL/bV4w9Ys89Y3H+uLgBJXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbLyQ3QL2jrjIdW9zZad2JGqnIsb0Z4EFJOp4P59q5i+11Svo
	mpbpLCb14xw18/bJ9FiitnWmCIXpXp3ihukBHIs8bNWMk3+44DZAqGvBacbS5pSBMaUrCizjfD3
	PqUblGGM+u6q5jlfijShFhcIbKqHQ2w7jACzpjMm/Zs3QHMziicGo3+UQlX7bZ6DNtXyQVA==
X-Gm-Gg: AeBDieuK4yC3My9TbPbC6PeeJQjVJ5MTXjrE76VD842i2nAnq2ZxU9HtJI3mL+xmU58
	axOxmJOd9cPpxMqQmY+B7yVtnz4XtKhP8ncF1wQEeMjK8u1OBYBS7LMYyt+BR3LOf6d/tOBNHsL
	/nPxute5h850cJCNW3bBYkQtXBRFvy+6SU475GyMFpRYID+VihZE0dQiiXzPt9qCinoEZ/5tlab
	l7bX5i8F+eGI6fAVc15j4FFMvuOLD0k0kp387Qr91DAY7GGELMqqpI/U1ebjNtofbBeVcClTose
	bChxerlJRNGUa13K4LS6VFGB+pMK4fy1WAYd7kBHKhN387mmhkGHZcvPD8tSlDsMOwibAjpGqsP
	ScjXFthakl0/vQ4a6oTCW43g7cjmHVIOR7nQipIgPSt1zrmZq7toZ7rg8+VAiRvegLO9AfkW/pV
	rOTUA=
X-Received: by 2002:a05:6808:4fe9:b0:462:dd41:414c with SMTP id 5614622812f47-46ef831d5aamr5805579b6e.6.1775567766109;
        Tue, 07 Apr 2026 06:16:06 -0700 (PDT)
X-Received: by 2002:a05:6808:4fe9:b0:462:dd41:414c with SMTP id 5614622812f47-46ef831d5aamr5805526b6e.6.1775567765296;
        Tue, 07 Apr 2026 06:16:05 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c99ec5dsm567712966b.15.2026.04.07.06.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 06:16:04 -0700 (PDT)
Message-ID: <2514523f-a43f-4470-a69b-3d5175d10385@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:16:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: milos-fairphone-fp6: Enable WiFi
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4fbs4arx6sez6fffy75ctmzecfvitr6aocau3cczlr2ps2ptld@v7wpa2irsihl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyNSBTYWx0ZWRfXygRiLX0VEzni
 peLgt4Y5OFsykHdFX0+EOQe2fVSz/PDFsr74QraQAJS1CdZ/LggLWdpyNExS0XbxsW7sVQKQ9gz
 8QvVn3RlydWX8hqfB8dgC91LTYXZJnnDWltcLUwrcLi7z4tWx2OfqIupPwb633VCWtyxTzisMtM
 pL70PCms76s9LPDg0RR0gX+xMBBdGrnoeH7OSj3tqXtajXO1DHYAdJFynRQ+TKHTaHP1BJNLT56
 qM4pynB9j2D9kiTungi6C4HosCoD5a388aOKv5bj9BmdbOWFYTzlJoHuJa1ksTCuLilpvheS0mi
 BqErOetwJ4fJvLiQ3clPUEenzHAEa1qe/to2u5Ka21/+QcHgeprqaw1DD6NI2LdMfZW+mpAxuCO
 KZMdXwF/DnoTZ4aGVNabYGo4tPiSuu6q6GEPlN1xH7ELQL+6ehXIs0y0Ps6q9nw0+iYu1BQ02da
 fZGKYmzkKty98bPTwrw==
X-Proofpoint-ORIG-GUID: 9lEwmBRzbrgbTkfqT4MrAiRYiw45NaWi
X-Proofpoint-GUID: 9lEwmBRzbrgbTkfqT4MrAiRYiw45NaWi
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d50396 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=iIL34To0PIL57gYWuS8A:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070125
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net,lists.sr.ht,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-34465-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:email,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: F40CF3AEE92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 9:35 PM, Dmitry Baryshkov wrote:
> On Fri, Apr 03, 2026 at 03:52:53PM +0200, Luca Weiss wrote:
>> Configure and enable the WiFi node, and add the required pinctrl to
>> provide the sleep clock from the PMK8550 (PMK7635) to WCN6755.
>>
>> Thanks to Alexander Koskovich for helping with the bringup, adding
>> the missing pinctrl to make the WPSS stop crashing.
>>
>> Link: https://lore.kernel.org/linux-arm-msm/DBF7OWAWQ94M.FSCP4DPF8ZJY@fairphone.com/
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> index db72418b7195..d8ac495ca7c8 100644
>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> @@ -242,7 +242,7 @@ wcn6750-pmu {
>>  
>>  		clocks = <&rpmhcc RPMH_RF_CLK1>;
>>  
>> -		pinctrl-0 = <&bluetooth_enable_default>;
>> +		pinctrl-0 = <&bluetooth_enable_default>, <&pmk8550_sleep_clk_default>;
>>  		pinctrl-names = "default";
>>  
>>  		regulators {
>> @@ -766,6 +766,17 @@ &pmiv0104_eusb2_repeater {
>>  	qcom,tune-usb2-preem = /bits/ 8 <0x6>;
>>  };
>>  
>> +&pmk8550_gpios {
>> +	pmk8550_sleep_clk_default: sleep-clk-default-state {
>> +		pins = "gpio5";
>> +		function = "func1";
>> +		input-disable;
>> +		output-enable;
> 
> Hmm, if it's a sleep_clk, should it not be handled via the power
> sequencer?

If you mean that it may be needed to toggle it with specific timings,
possibly..  seems that WCN6855 has a "xo-clk" GPIO defined. I requested
access to some docs that I think should have the answer, hopefully should
get it soon.

Or maybe +Jeff/Baochen could answer faster?

Konrad

