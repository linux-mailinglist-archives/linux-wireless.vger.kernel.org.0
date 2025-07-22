Return-Path: <linux-wireless+bounces-25865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19319B0DF1A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 16:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525F81C244C8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ADE2EAB6A;
	Tue, 22 Jul 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ccuwPdlH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC02EA74C
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195030; cv=none; b=lm2vpqaLc9MwIKeQjL2S0cg/3mHVkVjrs3opjzr4xRgDB4N3caCAlhu3MhuQPaOkjgVGSpg4gntuWo03qy4ZfhEZsOexdylL8UU5mk44pwfu0rzHUlvB26TrxtjEVu60bq44fbu9FCTKr1iXhddZgbEKZ7ZHfw36Wt+kRz452a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195030; c=relaxed/simple;
	bh=5WVGe8wXO9JfYnQEr4Zex3JT4JXY+mBHCCJsU0+LFcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzN0sWNmf9s2W+ETCOkHOJdjgkjSmeACnShpfBrRymKLB4RfhiT/Sn2v3uVMpAKJ2F9OTWW/iT67BkJIyxBLs/3KgfUkgX/BTJ1XW5dGGql+6XdpBzxOyIZ8oJy45bGEk0sJxayQmjurGm/5WbDcn4wPnLfZlFTKMz7480krwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ccuwPdlH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MBdIOl006465
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 14:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R8R1wAZwL02u+Cgf4TNMtyfaka474kDZXFvf2HapMfg=; b=ccuwPdlH3EwTqfPU
	N01lm3dbw8ct+OlY475e89Ce6UGQjn2mMBNWua8YiVUDGoP3zENJL3Jbbla/wyH0
	JmzPe19yYc3IR+LEl4nfNhs974Ha2YFAOimRLijgrJBJfywiWQ8Rv6066kqTCuW3
	1gOIbTZreTVLP2B3KvtREzrQ2MMjwv2l9AUd3+Hq+0mxy/TbtoNA9hiVzMXutuGO
	Z2YPdxVC4DFsHsW4XLcw+75Xdh34z2fkghkGDFIjRM31eO7A/2odiivsLOfNEEmm
	iO5AhW42Aw3MldZvc+r1ZRuUqhKL1nKUQiNg0NN8kzcoG+gT53iAeraViEBzAcBm
	5MU9TQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047q9tg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 14:37:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748f13ef248so5191007b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 07:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195026; x=1753799826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8R1wAZwL02u+Cgf4TNMtyfaka474kDZXFvf2HapMfg=;
        b=RdrjzwOxzwP+aTylsI/qHdqKfXNj1O+fAfEZOW9U0/Fvoj/k2hwGvUJMja4N6nYdRW
         hHhjM+Z4cUe6EgKH4mgmOgCI6QEYJOTNcZZWx3irNTeLoFK4B+L80QoeF2Iy7w7VA3dE
         9mXkZUCb16Av2URx0Cl1mnO3gRjzj8wsy1exmmUrr5WYN9d5fDIhFFlFYQ98qO7cU/ol
         DtmtHPaYXyHVkHv+EAOyFaEni/BvW2nyKvBfy+xmg688g+rmD1k1cr73z5u0MLnxRAGL
         Pk7+E/IlCDs/8Gbay/es1lm6ahwbAgK9n/J2Pg+V1QziVZ0v6wbxZgkboPPDS8Bp0Qs4
         TrmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLoCJnmCK0KqHur1ExRd0KLppUcy6jA8GL0CPksMklbTOA7UCNaHl72uWcBEmc1IhyK8F2wE8lXCBBQa8nAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbM8J3pGrigbf1ON0NRG8nxeCovyw0CksoYq86UbCEIQTRg0L
	4WOaxGeXGc3onDXoDupfCsGUQJy+5z6Z/SweycfdDAe5SlLR3uV3Bhn9106eCBKEDd/UFIhJ3fW
	9ITBqZfMvZn7d+BuetFdU8XqnEm9gEOQSvZ4i9m+S2yuo7AQC612WkWkC03j1zVC3Jl/vog==
X-Gm-Gg: ASbGnctTHXqrMJmg36kJEJvnzxeTSBoZObyryOahvKtfZkdniBcVxr7x+/jJLldjXrj
	G1N77lffTt5Tl2JwBVpwi/yhnbwDPYW9ULbNUg9GOyeFzUZal0fXo/vD9TJlD/sNQPDWI8c5NaJ
	fUIpJRMkkgUy1/ePa3l2P1EymnL3Aq2RD44/xzgtZgEo+GMt9RbK3MUjs8D4KUZAImSKnDHlG9i
	8pOYwjrRrwEg+hpX2ugmx7tfRQ6xdFapADY72AWoBWNTOLLYjJC/Vm6csV6xeAaXXp+AyXstBkm
	j6KGNDsg8DjHzlksuaJ8FRMVSfqtSVo3fJAmx8oKjKMmzMMsEgW7v3PAtjB5AGk5dtHcKKj2Bc8
	J3lToRQMYON0M0hnxUJuyLJKdQ7Yyqr1w
X-Received: by 2002:a05:6a00:1252:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-7572427b8fdmr36738869b3a.19.1753195025750;
        Tue, 22 Jul 2025 07:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSPhGKEhB0JgMYruRFjOhVDxgydpK42cBLpYkOMPpgZ1BkxU5wACmfS4bw+XPwlWlvSmBTxg==
X-Received: by 2002:a05:6a00:1252:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-7572427b8fdmr36738827b3a.19.1753195025199;
        Tue, 22 Jul 2025 07:37:05 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89cfb3dsm7692085b3a.34.2025.07.22.07.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:37:04 -0700 (PDT)
Message-ID: <83c62cb2-7d85-4a9e-ba76-63faa27faedf@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 07:37:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k_pci: add a soft dependency on qrtr-mhi
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
References: <20221202130600.883174-1-hch@lst.de>
 <0b28bb5f-56b3-4be6-b4f4-89ca546a24d0@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0b28bb5f-56b3-4be6-b4f4-89ca546a24d0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEyMCBTYWx0ZWRfX4ME4zDntzX9D
 KsIyOgf15lr3/MGGT9DNNPzZ6gcrs0X9rB9y8LY1mVTNkQZNvzJqZqHwh6vJnagH3niBooazzw8
 ZcqorIG4xeW2Vl7r5X7ghj1GlEx+sN8R05KMGzQfPj1oEMtnPZFdL6bBPUY8opTNKEjHbH8fWQj
 1WHEKSJ7ZLxlneqHqANSTpf7Rm3Z4ENJnje/Z3rPobqrJPWt6LKQRo/RDSPY4Pj4DsnkEosmFZp
 KlTiQez/4x+dyi4D1gQ/QAnbV+jjE/i5PrdHbk6HcLRmRfRA3q5KZPG/lsvusm3/UFWg9/e25eS
 xyUiX9RYvcSXG6IUgiAeVP7xR6alzwdH2Sb1xhkVKtKV31MEXMeWPC/Hr08qWtU9cCvCtiJQSES
 6Y8SzXW/6XBknhuH6ls5dJCSTx0XDiCCLAIDd6r+tlnFme1EEY5ok0jxzWsqliS1tTd6itRL
X-Proofpoint-ORIG-GUID: rd-L7xskR-FAA2V19gPKi8vf-4yOYoAi
X-Proofpoint-GUID: rd-L7xskR-FAA2V19gPKi8vf-4yOYoAi
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687fa213 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Kj1WHezUp4T6SZPGUyIA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220120

On 7/22/2025 1:35 AM, Baochen Qiang wrote:
> 
> 
> On 12/2/2022 9:06 PM, Christoph Hellwig wrote:
>> While ath11k_pci can load without qrtr-mhi, probing the actual hardware
>> will fail when qrtr and qrtr-mhi aren't loaded with
>>
>>    failed to initialize qmi handle: -517
>>
>> Add a MODULE_SOFTDEP statement to bring the module in (and as a hint
>> for kernel packaging) for those cases where it isn't autoloaded already
>> for some reason.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  drivers/net/wireless/ath/ath11k/pci.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
>> index 99cf3357c66e16..9d58856cbf8a94 100644
>> --- a/drivers/net/wireless/ath/ath11k/pci.c
>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
>> @@ -1037,6 +1037,8 @@ module_exit(ath11k_pci_exit);
>>  MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax WLAN PCIe devices");
>>  MODULE_LICENSE("Dual BSD/GPL");
>>  
>> +MODULE_SOFTDEP("pre: qrtr-mhi");
>> +
>>  /* QCA639x 2.0 firmware files */
>>  MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_BOARD_API2_FILE);
>>  MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_AMSS_FILE);
> 
> Do we know why this patch is rejected?

This predates me becoming a maintainer, and I don't see any comment from Kalle
to the patch, however he did have the following comment in a separate thread
where the issue was being discussed:
https://lore.kernel.org/all/87cz8v2xb2.fsf@kernel.org/

> Though I am happy to take your MODULE_SOFTDEP() patch, just wondering if
> there is a better way to solve this. For example net/mac80211 (the
> 802.11 stack) has a lot of crypto dependencies:
>
> 	select CRYPTO
> 	select CRYPTO_LIB_ARC4
> 	select CRYPTO_AES
> 	select CRYPTO_CCM
> 	select CRYPTO_GCM
> 	select CRYPTO_CMAC
> 	select CRC32
>
> And it's not using MODULE_SOFTDEP() at all.

So I'm guessing he considered this to be an issue that should be solved
external to the individual drivers.

/jeff

