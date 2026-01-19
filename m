Return-Path: <linux-wireless+bounces-30954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE35D3AA14
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 14:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D1130741B9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 13:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD9D368278;
	Mon, 19 Jan 2026 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oDLeTa98";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aa5HH3MJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28F358D1B
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828635; cv=none; b=rVNO091wUHeSFBZzvLrgFHfzOxIHcmTfbal048BMdasIWyFwxfiulZW9pML8v2mmG4AoDgX9sfCd6qfuHNUww0WDg4FChfS1OlxB90m7L1Hxtnd+EEHfUa7EOemu+s+RpY5gjkBV5AtJBZIxCwvT16fsGFOEjZpkiC/MKqozNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828635; c=relaxed/simple;
	bh=hRPX/4q3B3W/+xeikY0rnVLE2p/ocsro4qEJc4cW5ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=do7ZnAzyl1RPT3sFuE13akbK8d1eXuB6ONfWNqzgpocMQE7ejDdhkr4lSdBGA6sTwyGHS4xe96V4XBVj4Xdc4NM7Z7ZAQamJzhaHB5FO9v4aBRBn5O74zuX6/OeSnr+elbfZBNJKHzQ7OfLExMgOQHd2v0uW46nUaS7qnGBOirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oDLeTa98; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aa5HH3MJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J90jbe227888
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 13:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u9PZi2OyyufDNKhBcS5/qm2h+QzQ/icLvJSkPYuf8NU=; b=oDLeTa98h0MXuM+B
	+biRMfTckKUDbYIV2Sst4j2ZCajYc6EBRVR1WDHkQOO+K24FO1AqASwWoMY5bOgY
	JVFF0yBgNoWN7fykbPoBongn5Ly5spZGEXnNd1g+h3xSDkSCAcBISvZ2EbVoBlu3
	WSOF+xs8x79HCaD4ssvXUlU0Z2IxDss1ou2GhReAR0U6kj1K80U0TCPVkswEZkFb
	T247LVV+bSEkNKLCuiX+fwICiBPVvVtUfqL3hBjyESHg6hRJAnsdnJxi1Lb2ugfS
	+EC9fjuavpcbQ8HDjB0jEIYvGEBV1yK/H+Q8jS7d8ZXgENeRhhj3k8PoMhMKe16F
	uYX2kQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgfr91wk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 13:17:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34aa6655510so4188106a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 05:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768828632; x=1769433432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9PZi2OyyufDNKhBcS5/qm2h+QzQ/icLvJSkPYuf8NU=;
        b=aa5HH3MJaNfhTVgG/sW3JIFRF3eShhC87R+OIgn3ZmGl+g5N0EFbUWW6zGBUZtl3aD
         byBvBJn5r1SbeZdSDlwZKrtBpFUGQDtgmIZ7eJTPAm+8YkTrt3qDfWHRV5q1Mv9etjBS
         ItcSGcmcPhE9bcv2JSSNBveBQ+MtW7U1GIQlXClzEdmmqS0RoYGDEP/GXoEIZHY4zWnh
         rOt8jtnC0+VVC60xnPROyqGl+4upoqmpLaevVTjqcwd29lFJOdAYD7+qhO7GKoIeAnJK
         Y4hcegLMdJ84j4aVGdaaB6w8bUoevanRI36WdTfk+pbDU0xash9oqDkMB2TpsSHi85Nq
         eLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768828632; x=1769433432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9PZi2OyyufDNKhBcS5/qm2h+QzQ/icLvJSkPYuf8NU=;
        b=tzsZ6I4cYXr9sVhApmFCdGfTyl+nGVCLc2mKQB4S1x4a4CIKVvX9usx4SesEHFLI4x
         XnO+N/kXGxsEVzmCKNFpZ22BShZQdfwAqAioT1n2wBrwLslddI1pTz2Ii67sj6VLr1Wv
         Hnz1blI7QWcyCN61CFA7tbrXya7pNZ4PIUIrlgzj30NJQkQ8c7kxECTq2MYgway/Bm7q
         9kxz5u+VeXoFqv7ig2xY96vSkkoysOQYmXEh0jqIVxeSsJ3XqZBYMi19YbvqgfrX7PrI
         42LctjOj6+ecQVZNtOkmU9OgySkMSuEJOySW/6VDslJbX7H9lJ0HAlUxka2/0kN8F9Bw
         qB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFHHSWebmt/cnjcNq9IjFpdbsDB/7ANuUT8BZDhVsBFacxUlCJa3XLzR9xixXGpa6qaPvhco+YWCxGE4I4wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgwL6ar4v+P2hBGCUXHjvlkvv+ldwQezGKoyinRFv8e0yht0/+
	MzTPqTBfHGhimHKtsGCftkWMmIo0oGVffNzaQ/RnbzFzIC4WUgclNm7drPVsYWz0IUxlZvCEr5h
	kfvMX0wcabC1zkuxpl3J3Xsnt7SGj1o3iKIv64+erN2ho5bpmhqNQ02ww47Pc7SW7bBce2g==
X-Gm-Gg: AZuq6aJdILXI9H7g72pGcEjyhex1+KjuUN5Nb6B3vgiOFzcrNsvcfjBfPXMnHBSQA7T
	sJNfxI5RDEsMUp46ZZuqKl3SzapD9f+nV1M4p3kgpvvQXxrEiIRMcdiFpJRxfYmh4ZXF9hu7tC+
	E9Jj0jUPMFaorc73Nzsg9nSLOtZrq/nIFHX81E22FsqHP0C3KtWZ7E9hmaZTWEkv468NJdpdQsl
	46Ncq4DEpzz8ZSh4SdJKHr23wRrVHDilufNhNyhNMXgj8pyqt3D2MPgHLMji2rpbScX/CpGRzn5
	4fyhNNKGf7ij7iAbhjNIf39M8sFhwqjTFJ6ejdPfiHSlwrFxs7TdsD8uJezlqrJvtIbal5t8s6l
	1Nbqre7WVXASc4HxzfqoRH5EgQbdz0vhcASYHdV/ct1WSVCllPrI/a0tKCmy1VbLAwqvfnDMlI3
	yDHAas
X-Received: by 2002:a17:90b:4a8e:b0:34c:7182:cf9d with SMTP id 98e67ed59e1d1-35272f92759mr8016392a91.25.1768828631789;
        Mon, 19 Jan 2026 05:17:11 -0800 (PST)
X-Received: by 2002:a17:90b:4a8e:b0:34c:7182:cf9d with SMTP id 98e67ed59e1d1-35272f92759mr8016373a91.25.1768828631285;
        Mon, 19 Jan 2026 05:17:11 -0800 (PST)
Received: from [10.133.33.36] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37b380sm9291384a12.34.2026.01.19.05.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 05:17:10 -0800 (PST)
Message-ID: <2e707d63-ead2-447e-bc90-e2bbdd995020@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 21:17:04 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-current 2/2] dt-bindings: net: wireless:
 ath11k-pci: remove obsolete firmware-name property
To: Krzysztof Kozlowski <krzk@kernel.org>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251214025230.716387-1-miaoqing.pan@oss.qualcomm.com>
 <20251214025230.716387-3-miaoqing.pan@oss.qualcomm.com>
 <fa997674-402a-41cf-9334-f7fc89ae5ebc@kernel.org>
 <4562bdbc-9811-4f73-bc4b-f5a62ba1c965@oss.qualcomm.com>
 <a62401d4-0008-4a69-874a-1870fb690886@kernel.org>
Content-Language: en-US
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <a62401d4-0008-4a69-874a-1870fb690886@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 19Wg43QYQCY2UxIOYtwBmrsiSdoZcxrA
X-Proofpoint-GUID: 19Wg43QYQCY2UxIOYtwBmrsiSdoZcxrA
X-Authority-Analysis: v=2.4 cv=c4OmgB9l c=1 sm=1 tr=0 ts=696e2ed9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=CBmV5aUEGw7Cjg3Rx0gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDExMCBTYWx0ZWRfX/Eo4TxFHEFPH
 pL1BciHsCKldjvKlrR4l/ZvY6++DSwhbbTEA+cumVv98E+knZCDOk/5XzLSn1c2Enj+kPQNumUR
 El8kFnRR0Jj4IbMxNpu2A7YA5aFu2ggCAYwJSGPzZIaSCLNQ/UBkaaIYexmI0LF/PPL6N5n431q
 rotDujhs7vQB7dN7lRuFqivUesGU9Lf/PjcEPH+cY4l54820PYmdHWU58O7EAlDzwB9eKvuqHkL
 kBQ06teSsOEEQDPAY5/ouSjpuJkfFfvTkKURTaXsYxMHogFXl84iji1Xs4YE54E50tSOTkBtRPg
 pNmQYFPLhFtWg4ETIixrnYj11qRxPESrW8OlUV2TkJRRBCnrS28DeAcpgxbqfLJekhjz7kUYejy
 nGi6P2MEgZaTZnbbPuYhrnMnk+/et55ZXy4y5UbpjW7w7s5sFe7nWuXzCOeQJ2aAlPb7araVv34
 mQw4iEpFsTdyLJ2YefA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190110



On 1/19/2026 3:08 PM, Krzysztof Kozlowski wrote:
> On 19/01/2026 02:34, Miaoqing Pan wrote:
>>
>>
>> On 1/13/2026 3:28 PM, Krzysztof Kozlowski wrote:
>>> On 14/12/2025 03:52, Miaoqing Pan wrote:
>>>> The firmware-name property was introduced to allow end-users and
>>>> integrators to select usecase specific firmware for the WCN6855.
>>>> However, specifying firmware for an M.2 WLAN module in the Device
>>>> Tree is not appropriate. Instead, this functionality will be handled
>>>> within the ath11k driver.
>>>>
>>>> The driver has removed all support for firmware-name, and no upstream
>>>> Device Tree files reference this property. Therefore, this patch
>>>> removes the property from the binding and marks it as obsolete.
>>>
>>> No, it does not mark it obsolete. Point me to the place.
>>>
>>>>
>>>> This is a DT ABI-breaking change, but safe since there are no in-tree
>>>> users.
>>>
>>> It's not safe. What about my board using this WiFi? Or Mr. foo's board?
>>>
>>> Still NAK, you did not improve it.
>>>
>>>
>>
>> I think it’s necessary to clarify the background here. As you can see
>> from the git log, all changes related to ath11k firmware-name were
>> submitted by me, and the intention was to allow the lemans-evk,
>> monaco-evk, and hamoa-iot-evk boards to specify dedicated firmware for
>> the WCN6855 Wi-Fi chip. However, the Wi-Fi‑related DTS nodes for these
>> boards have never been submitted upstream, because adding a
>> firmware-name property for an M.2 device is not appropriate and would be
>> difficult for the community to accept. Therefore, the original approach
>> was abandoned.
> 
> You added new ABI which can be used by anyone and your commit did not
> help me to understand the impact on other users of this ABI.
> 
>>
>> The alternative solution is to propose a static lookup table that maps
>> device compatibles to firmware names. As a result, we have not submitted
>> any DTS patches adding firmware-name for those boards to date. This is
>> why I believe that removing firmware-name from the bindings is safe.
>>
>> If this explanation is still not sufficient, please let me know what
>> additional steps are required for accepting these two patches. Thank you.
> 
> You need to deprecate the property and keep the ABI backwards compatible.
> 

Ok, will update in v3.



