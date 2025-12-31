Return-Path: <linux-wireless+bounces-30241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0C0CEC3BB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 17:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F8D23009C16
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF1F279DB4;
	Wed, 31 Dec 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fx+zSRLF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GO3oUJUn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AB283FD6
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767198065; cv=none; b=KDNfP/jhfuZrkpYCxuY4x5JLP4usNv3Ihr7U5GpnzyPiQ8em4gPNMYMa+xUVpK4Ydfofc2/PWEVbIRvjGz5dwGDfwsk4LzwCSoYSOtDfYYV2c/aiOWHD/edxOQHAn13XJ8JoGalS5/tkPY+ggmR+O5kG+5NW+s23wmUN9paVd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767198065; c=relaxed/simple;
	bh=kbM7z9JEF3+IVedIrrNRCqTbuPN31Pl90mNSYZKtAHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2S7woAXJGtgqsKnDuvLv2Y279JiVNhjLNiPUQD1yuu1PNK9tjIH0ytessKVm3o7B9ZWAb7nI0qkTNvlXwIw1/Hjc5AJNWCtEgcJaIBLAY9BMxamCGU6UqRqS+/JL+U71cuyj4adZYN/X+BNYamCGqu9/khmmR+BuhXJ4bD3NYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fx+zSRLF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GO3oUJUn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV5wAow901151
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ljd4mva5mujjUnqpJoZXVoIX85H4ZpUwFFA6EsmB5cA=; b=fx+zSRLFZvxLc/Wk
	sxuk/y9OxkDf3w8pJdycnr3xa8KYdDRiWRYflDNTDWXm5l/t6L0d9y9lyO002xO9
	yiH5JZ3hOlYUgIjNoITvvtIjb60nSMk9lOLMc6LPaY+J23qof6JKBOX97B/PimSW
	aPRFSdKQZN1iCN7D6XAZV4C0+eV336hYi+/281EwtHp9hzl8TqlBpM8TMqVjYkNa
	bXY3nM23ZF6aSAZ76LLBdX14FiTcNzkB9AMsUFgEvZkvUGXpaeLJH7MNPe7So2ci
	3mkPQi2Pwo7rl8ipc6JY4olMcGtwnW7P5Pv3kCw2CBjTjMfLLNYaphE4sJkYTi5i
	SSepGQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc8ky3ubu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:21:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ede0bd2154so34751721cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 08:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767198062; x=1767802862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ljd4mva5mujjUnqpJoZXVoIX85H4ZpUwFFA6EsmB5cA=;
        b=GO3oUJUnMc+ZCOywlbxCgpvyEJ+N7fRQbFYAESQPmYqX1OIlT2TeIEjX06vTD6CB6o
         tIQZPKkuX3sU+NorjePnbbSCg0U9N7HvN2aQt1YBOH7WvOSbRGEMGFB4lDz5bVb7VVnY
         PS5/CUBQfIxwuQ32OHWTzQP8ZqrvalBE2f5UYQUlTF7HL3wfROK4pNHG20wq8WBlPrO+
         i7NbLHtSI3ZXcNF/es9GcSSkPuB49Z3+1eNl6VsKmt5y1if+NkvxZ4Z0+Mj2IqbkPY2X
         aGHre7fewYSNYdKi5Qcy90fiTpjKDD6kaxq3f6Sv4a2HDoElNrrxoUYf9mWkRdad1/Q5
         WGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767198062; x=1767802862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ljd4mva5mujjUnqpJoZXVoIX85H4ZpUwFFA6EsmB5cA=;
        b=hGxAguxRjLETN7BDiMlJztA5Sus0L8UjIARnmML2Svq6IdxVoKWJ1cDMf8ROEHCayp
         qTBEd0rlOxWiTC0ooA02LCI7q4u0bEvef4GMnQJl3Bax0tE3M3/BNiKe+IAZICy8Y/xa
         iD5rAWcbXxlJ/latabXhQvEkHYcISt+S5AauKZdK1wZPSv6FwQS6PSQgfmkNxmVI1bGH
         N6mvibYBR6r0uPiCcHwjDvS9f/guOFhYp+ovbEs6Gke+MWYzPuKqesnOdqww92Smc312
         tCCcQxoYfiImKTYoNSgdCYKEu8xMzZ8Ot2S2ZrkqZHbW42vax0kDIS9pvgbXHxMOdQRd
         uBjg==
X-Forwarded-Encrypted: i=1; AJvYcCVT1OB8+8ofVs+4N2ndLZVo4ZTQhuZXN99yqvXMuV20LJTaNahG8IHpUFRLMXD4rdw96HXFQl9gNokoRmPsaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGT9/bjVtTsBCETChiOucKZihBHSbyBtL8CHxg8BubHmqt/j4
	v+pj7W66XNuR4pv4URsjvlmqTs7M+4/TzGjEW/ph+T6LrTZtgg2o9cZGWql28bnApOfseMNJG08
	TK01YEvryC6Sy4iv7qmsvgE8XKohNnIqb1je2pXJxyHboBTna7Q+VaHHgxYXL9Dul2NzMOg==
X-Gm-Gg: AY/fxX76km8vR/G9R3knOOF7q6imvEYbIB+i+qWD47V5EnV7kYf34TnB6Ey3cCO0bYT
	jXDpjj0tpk6SVslfCKHnN5BSMtW5Rc/JRnOBCmWkF+J/QnzYZSuBsGR0C+K2E+7PdaM2QWUg0YQ
	SvWCNcCEW+n3/hpQiDP76H1zIS8PZMMoewVtnFDovrg1NeJWhwi3lxt69svR7FUS74GOaRTrkGV
	1/JziLV1DbS5AlV0iCKJQxjmjkjTRKe/N1LLBYJZHEDh/17WW2iDXqrbjRPJiHsSLlz4x9BTiG4
	zB79RQq+4tli9LenQb/hsAW82uLTVdaN4tXkooQ3HEbisyrIw6C9n+EVidigc1HHX6AcB1zsOdU
	J10dZ60RIDD67O4RCTnhQxYp641u6N7LOGQxpx8THzQOvMT5Ejru0CBGCZK9O1xCdYQ==
X-Received: by 2002:a05:622a:87:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4f4abdfd1ecmr387024011cf.11.1767198062250;
        Wed, 31 Dec 2025 08:21:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMs7MfskDvZ0rub/w1y0ccNjJcVrFegP0hECmfEFgKIU6B08slw1DpmpECfkYr53xsN6+lWw==
X-Received: by 2002:a05:622a:87:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4f4abdfd1ecmr387023611cf.11.1767198061751;
        Wed, 31 Dec 2025 08:21:01 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80464e01d9sm3907587966b.42.2025.12.31.08.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 08:21:01 -0800 (PST)
Message-ID: <00b59998-33e2-450f-bdef-db370c5d6e59@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 17:20:57 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] arm64: dts: qcom: sdm845-db845c: specify power for
 WiFi CH1
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-8-1ff4d6028ad5@oss.qualcomm.com>
 <ab7d6780-4328-4c77-9133-402dd1c4fcaa@oss.qualcomm.com>
 <brzdqbu3uiy3gd5a2uyzcgx24wvuhjrrs3fs5b4qbnj5jvmra3@rfbiy5kgwlbn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <brzdqbu3uiy3gd5a2uyzcgx24wvuhjrrs3fs5b4qbnj5jvmra3@rfbiy5kgwlbn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDE0MyBTYWx0ZWRfXztpkTaXef69n
 T/PfasPrDnx6DvAOW8qvhtbGJo/p3GYfWodNDT3QeKJpxDIN2Ftqa8GT6d2Q8VMKyZU7OstTWeS
 HZdqsJXR0ECOhGt+TuoBBukRhiqEKfFwlyeGYw1aTSdJZTUC8WmnmCkDPQdgEBhxnK1PGMnsCGn
 b6g17gjo57T/Gw4ssNCCyR3QIwFQyZHG9czYwznT7qoEEo4Vry45c22GnwCgez4w/ioMiOMmvDF
 0mJjcvYH0qrZ1rPDLi6j044mvLmBQRGOFdr91PiC+9LEiIt2GjNUZiyXtjOKIphpU7hPsu55kbs
 nhRiLPGPJxmjfPbX9445FRrL1wG2KR80QzQUOfyQLmQb8t+BB6eSvaX9v1bvRqHLUEv6xMtinQq
 umn4GQUjnOlBh1Ntkshlt/6KPLTlajTdd9g5pGb7VRh7DIMno9E1gOGymwI5eD97yFTkGh/gCos
 AevbgoXnZkmJhhdPmxQ==
X-Proofpoint-ORIG-GUID: YtmWxEqMrDzYJzVLxw2qXUwhAMZjIsZu
X-Authority-Analysis: v=2.4 cv=BuuQAIX5 c=1 sm=1 tr=0 ts=69554d6f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Q4P5HGrx6TCjuT4AK04A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: YtmWxEqMrDzYJzVLxw2qXUwhAMZjIsZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310143

On 12/31/25 5:19 PM, Dmitry Baryshkov wrote:
> On Wed, Dec 31, 2025 at 01:09:49PM +0100, Konrad Dybcio wrote:
>> On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
>>> Specify power supply for the second chain / antenna output of the
>>> onboard WiFi chip.
>>>
>>> Fixes: 3f72e2d3e682 ("arm64: dts: qcom: Add Dragonboard 845c")
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>
>> I don't have schematics nearby, but jfyi downstream doesn't do that
> 
> I checked in the schematics, it is L23A.
> 
>>
>>>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>> index ad283a79bcdb..5118b776a9bb 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>> @@ -379,6 +379,12 @@ vreg_l21a_2p95: ldo21 {
>>>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>  		};
>>>  
>>> +		vreg_l23a_3p3: ldo23 {
>>> +			regulator-min-microvolt = <3300000>;
>>> +			regulator-max-microvolt = <3312000>;
>>
>> Do we benefit from the 0.012V spread?
>>
>> (i.e. is there anything else on this rail?)
> 
> I must admt jere, I just copied defition of the ch0 regulator. I think,
> they should be the same.

Alright

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

