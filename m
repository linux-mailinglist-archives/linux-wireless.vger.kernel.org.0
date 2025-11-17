Return-Path: <linux-wireless+bounces-29055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14550C6578F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 18:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E224C4F5995
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F8335579;
	Mon, 17 Nov 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C7XIowE7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I9XGV3n1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414563358BD
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399591; cv=none; b=FSOSCGcm7qZmXs/MlPanLS0RiTINh0nUUeC5ZJKIW6VhbkBP1Q1VXaLTbyMEqzo8ZzW01cekA2flJW1Eo2SD3AsWbZtBexP8ALCN7fwnduWCDwQCo0TeoZMvTPPXwu9+XCuPUlqzI70BBC9rB0i+TcQ89HzyokmGUv3Tff8CJo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399591; c=relaxed/simple;
	bh=G6Xd+JXPPWved5fE1RTFaLQkWu3Udn2L7Snmw6lPCQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bk+VnnDqTVrMgxZryDECZYmjl8lldDkHvWxgFAoO+dfDQApOMczycEfdzOQY/O+v8V7RuYfnnaTIaIOkOXcnLXJtdr7uzPzaOi8ynsDHHcg+R/lrQ7jTheYSH5cUiRGUw+4L5Hqbh7zULKYC+lnuk0tMfccNRLc/9J5w2EL0XY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C7XIowE7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I9XGV3n1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHGOsJ94103613
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 17:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v/0skEami5ruCiAE/IK+mq+8/OKgh1FsdYkgBHL+f2A=; b=C7XIowE7CqFAg7jL
	gOVi782I/DXeZEo7tFffIC/G6XYPRfzYKR7s70SEIaSgAAY4yAzjGp7Kky2P1W75
	Ssi1FO1zyRM9oj3IoK6uE12gAFX9PXgZ6yd6//+8iEl6K+F7bgCMgOnPAmSZQ33A
	FZ7KaLXn+CRsI2POf7bn0ROuJYUtsLa+/HXHvEMmuzzzmVe8/uwIlBFgq9xObQPo
	45PMGvV4p+hE8GvTGd+uSl183wxiSE7TTLBgEs2EvxVGXkfzhBd7v6DpwL8/o52e
	IoyvPVK2wWRtxJl1FaB4x7YllpDXNmZwILYVKsLIKmiEBEY9xeDF2FmsBzcuw2XJ
	4oz5sQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag773r4un-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 17:13:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b8ed43cd00so4818056b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 09:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763399589; x=1764004389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/0skEami5ruCiAE/IK+mq+8/OKgh1FsdYkgBHL+f2A=;
        b=I9XGV3n1TJ5bV6bAvyhsjikM1LcWCL+91Uhi4EScP+1OvqKZ3MoxziY/szl6zi1fDx
         xdl+ummne5LdeEY1P9jTJa/vFjY7VXBh+WpbSykY8pHyHSs46UYgO83X+GdtzDToXlBw
         Pozi/Cwvh2h7Mhuxwic4lVLRHrSoyuIV0+P6OkYsP2jb8XWYvBtLzRI5Ix3vpA6bAtu7
         JTt+1N4kGm75F7paxuTc+2LfNxfoxjf3EVFCErz1yJkB+mIPdht08rVeRf2++gIB7FSE
         aOo/lnGPw83aTwQLYu+OFjWe8qSD+y6xUKtxAK6vCn91v4xqzaDjW46z8qKIkVaL+MHO
         NoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399589; x=1764004389;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/0skEami5ruCiAE/IK+mq+8/OKgh1FsdYkgBHL+f2A=;
        b=vGR8GR0RB7tO2GkkbSFxP6acyz7ilINXzw2CY6Sn1kfRfX8l+t8vP8pRbcwlMMnt3l
         GvEJupqS6rxqsdMCKf0YZfGWnbj02K0feVvkmZWCgxzu+E6IujQ6wyAXVwa/bd86RLCX
         JHYl4MEVoC0VPcKYHx1+idd2F65rzaUap6dHQrBewXSLSwv8YM38t/D7FU2KXPgDUM6O
         vSMdgnCKuaJqJzEAj8QjwHf+ebU4kl1g3SOxfCR3fMAEnckJG8luQzj4hz53DE4lEyGu
         lenzO8kiPqch3Fesw1zbvwYS+HPEcJHdSxkzlDhK89c0kjnsi0jDO3X1HxGTgQ2KEyFm
         rcMA==
X-Forwarded-Encrypted: i=1; AJvYcCUg1BvMcIoPR1hUs9RsZTsIuia+lCZjylpKR3wQOvMQAm01xd2JmrL/PFgGcq0WdLo8NtdVl0r/0P/lfPoGjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDKwKtLVr9zwptlm8iD52Eh4C1l06uBMlkkbeppwiA4yEqiXc
	oPHsdd6MPI5ITzfS5yJhaTMxSM4hflafLllY7O+cA14clwNi81Zb+HEcaDRjTJv65lFln9c6AB+
	RcSFP2TKKbU9pPVoaFE3wVk3Q/qd1ZL6XuSYy02w2VXzlNRaqf9809S02KmoqYxMVjaNeTw==
X-Gm-Gg: ASbGncsDk9Clzg/UAhsZR9b8CMGJQKYp6uG4JPIbo1h8LRJ/B70hh74SwlUAKhZxHe0
	NpEyIh+O0LRODJ1IO0zNFFUPqBzXiFtPLYbQYnydoBJbUDrwPoBCkzuXDMpd0y6HlgVExQoRmyT
	yp1N/D6cbTNPeV1R4JRolHU+NgxPUn4iWnDhLyKQNt9mEtgQY6DWZh6KF7jRVhIF/5tYIvtMRLd
	Koxo/9Fs0CM41mcRRWnaCYv9EfXuyaVCSSZYiETMjjg/ZWtzMmk964CEho+CG6sBl+u+o4dF7L2
	c+wCh8tB8qvdLfNCeE0jDcI/DFcXSztP5rbhZv0NaDxUVfFWsHMUzWzd8d7UrZCjzOyiKyoMRwO
	ADQpyRTT4qeQIjRI9Hsx2pQHbMKGjpXnYZrpfxExlSJqhjiCvVXG7Oa7cbQAw30cjxopDYmDjLn
	0H
X-Received: by 2002:aa7:8885:0:b0:7b9:d2ad:bebf with SMTP id d2e1a72fcca58-7ba3c478736mr14829468b3a.22.1763399588633;
        Mon, 17 Nov 2025 09:13:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXwUwPLWo7AJoocw7BW6CSXi/Qe1/n+JtC2PtqJDxbVtQW440K/74J4a2w0JSqqv+hvkmGBQ==
X-Received: by 2002:aa7:8885:0:b0:7b9:d2ad:bebf with SMTP id d2e1a72fcca58-7ba3c478736mr14829425b3a.22.1763399588141;
        Mon, 17 Nov 2025 09:13:08 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d332asm13915017b3a.25.2025.11.17.09.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:13:05 -0800 (PST)
Message-ID: <f853d9b2-47f8-47b5-a02d-6aa8f12a4283@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 09:13:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath: Use static calibration variant table for
 devicetree platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
 <2fd84ab2-2e3e-4d05-add5-17930a35fedf@oss.qualcomm.com>
 <jnggqxqv3rjzhyevovnnxzplfhl3t6auhhvmoz7wxmsf6awgdx@dusdgxwsxvts>
 <b8277024-f9d4-4f17-946f-c2c390669067@oss.qualcomm.com>
 <exfmj52dqu3uctwsb2gopcjg7744vq5avlkahtmgfw4opw4mfl@t2svrln72u53>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <exfmj52dqu3uctwsb2gopcjg7744vq5avlkahtmgfw4opw4mfl@t2svrln72u53>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE0NiBTYWx0ZWRfX8canmBcFyv4c
 PvgNaIX2psJ2/5Cn9ZnPJkPPQaZHuvthGWyZuYBPMF2pwj3f4rtwVHJ1u+v1nNzuPd49aKOmEtn
 RNqT+ROAfOa1LuCBqTfI9wy2IXq54135+rRfz/AJUU55fYx66ljoIEaVMe7+m06ShIjh2O3I1/4
 t8d7zDbC1KPwEDeYHcXB7ruORSua/PpxMmRoA4VMAkncD9qMqU8IONwg92f+ojUt54I9P+T9+s1
 S7NOfv3qS9x2Q1Ak9UeFVylxS1ROrR3F16j9ehesym3RB3jn7FoVeHZkHrJGjjyBu4qwO1DfbwW
 vWag8yU6g6jH63hv+HZLpcbgim4lTDcdbsw34le9jQ/WBM1YKMFotbxwB32yQInanwxNTj3dpLi
 9YvWymek+9jIoV8jkA1QSdp+GWwLuw==
X-Proofpoint-ORIG-GUID: eoI4-oDUn061JcSTTFjOKGI3QAnDAoWD
X-Proofpoint-GUID: eoI4-oDUn061JcSTTFjOKGI3QAnDAoWD
X-Authority-Analysis: v=2.4 cv=J6OnLQnS c=1 sm=1 tr=0 ts=691b57a5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=prETkiTXWOWpwK33hF0A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511170146

On 11/17/2025 4:45 AM, Manivannan Sadhasivam wrote:
> On Mon, Nov 17, 2025 at 05:40:06PM +0800, Baochen Qiang wrote:
>> On 11/17/2025 5:00 PM, Manivannan Sadhasivam wrote:
>>> On Mon, Nov 17, 2025 at 10:36:39AM +0800, Baochen Qiang wrote:
>>>> On 11/14/2025 6:22 PM, Manivannan Sadhasivam wrote:
>>>>> Hi,
>>>>>
>>>>> This series aims to deprecate the usage of "qcom,*calibration-variant"
>>>>> devicetree property to select the calibration variant for the WLAN devices. This
>>>>> is necessary for WLAN devices connected using PCI bus, as hardcoding the device
>>>>> specific information in PCI devicetree node causes the node to be updated every
>>>>> time when a new device variant is attached to the PCI slot. This approach is not
>>>>> scalable and causes bad user experience.
>>>>
>>>> I am not very clear about the problem here: is calibration variant device/module specific,
>>>> or platform specific? If it is module specific, why the lookup is based on the machine
>>>> 'model' property? While if it is platform specific, why do we need to update devicetree
>>>> node whenever a new device is attached?
>>>>
>>>
>>> I think I mixed the usecase of the 'firmware-name' property in the above
>>> description.
>>>
>>> But nevertheless, the calibration info platform specific, and hardcoding the DT
>>> property fixes the location of the WLAN card with a specific slot. For instance,
>>> if the board has a couple of M.2 slots, users should be free to plug the WLAN in
>>> any slot, not just a single slot where the property was defined in DT.
>>>
>>> Also, if the users plug-in the WLAN card of another vendor, not Qcom, this
>>> property is irrelevant/wrong.
>>>
>>> PCIe slots should be plug and play i.e., users should plug-in any M.2 card and
>>> expect it to work.
>>>
>>
>> correct
>>
>>> However, as I learned from Jeff, calibration variant property is also going to
>>> be required in cases like router boards where each slot is dedicated to a fixed
>>> band and the calibration variant is going to be different for each band for the
>>> platform. So unlike I thought, this DT property cannot be deprecated. But going
>>> forward, I'd like it to be used only in these special usecases. Most of the
>>> upstream DTS have a single calibration variant for the platform and for those
>>> generic usecases, this static table should be used.
>>
>> If that property is not going to be deprecated, should it take precedence?
>>
> 
> If you mean 'it' by this static table, yes, it is going to take precedence as it
> should cover the generic usecases. For special cases like the multi-band
> routers, existing DT node fallback will cover.
Does there need to be a PCI Vendor ID & Device ID as part of this lookup?

For example, start with a device that has an ath11k chipset with calibration
data for that chipset. If the end user replaces that chipset with an ath12k
chipset then with the current proposal the same calibration variant will
attempt to be used. But there will not be any calibration data with that
variant for that chipset.

/jeff

