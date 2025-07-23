Return-Path: <linux-wireless+bounces-25891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88606B0EA3C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 07:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC5717C883
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3091B2F4A;
	Wed, 23 Jul 2025 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pe2dzWi1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E752594
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250304; cv=none; b=HN5ZB3Rf0hUk80wQTXJ4dc97Es4dq5hyR/+WgY6luWiQeqL4xV8ciP5P0LSNtjbjGA4i7dM8j/eRFb5rYgZLSdiJk1MCU/3V1z3zvZX2EeNW2sdcTU0cy9VCHCLUUgcJAbNFocJ2uYWDXaCJsnXbIT4DgFep5lspPkoYFt7QHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250304; c=relaxed/simple;
	bh=VkOGoQ7UUL5haaypwih0KLF7A76itr8hWkSa17s8flU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THrYgDx3mY2em6/OV/g4XN21F8kbqPW1KEdnOJPnr6ZsCC1FLxNQy+hwbA/JczP7U9QUxg8zEsBlJkAb0pxHfgLeaqUwFDiLIGBHc10V5sUkdjaS7NIRMD+BFPcyKvcChbhEV9LpTkn10RYmqfXS+zyT0R1EHyC76gQhBzU0lzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pe2dzWi1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMNuHD012834
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 05:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YzAlWwPyl11DobQ4XCJnSqZiGHQh2UO3s/x4QZ068e8=; b=Pe2dzWi1DlTugsPP
	pMZWzIM+c8dkEzAe9yDdidTgUmvuz2LWfi3Nk//5qaNCjBEOIMYe6c9w3bd/RDED
	49QkjSwFaQ/UFKeQa7WPLOV1FwutBU8y4Z2pk6fo70hItU5YnfvQZm8NbA+GS/Rf
	tVnzMLx4meHly92sZNaOjpVl56Bi9Kb9jdUVM1ntOxY3dRI7ipBsI2vVTEB4sMnU
	4TDU9C3a7j9fSf6y95RmWlS093ZhEcSt+dbQr3eiIUmwZiS84NYjDtszlLFwgF+3
	myFGGDBOM7gSSB1ISGcZprIiVXh4wcs1lXZEKQq6eEyMPTPVI7AUvCAM97cl+nrZ
	itliIQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vaapv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 05:58:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so4885643a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 22:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753250301; x=1753855101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzAlWwPyl11DobQ4XCJnSqZiGHQh2UO3s/x4QZ068e8=;
        b=RV0KDjW4fX8K6AMlSSNmtLmKHClfblT6WtC6K5vS/Pgp3v7I2PciYJzVfNO89oIFjH
         T+6zaYU9PH55gjO5irkLNuLx0D6WM6F7c9xwM2ajSEUSbcFoch1R8DfOzDbNu6enE2QM
         vhXodalTM7g29BVF9XhWC+z5M333nIkiBX6Xy5idc+mvksWvoufICMJjw0eJf3ig8FVJ
         dPSwU/xbuAtrb69lcw894V3G+z2vDw0P5F+kUYU40L5Je2aDsayd9b0j6SDRJv1Mxv8j
         nLpDGb3+q4uwErVnyTqGVG3NLZGP8REuxqcYl7dSWRFyT5yRsT74gF8qpBPn6LC9pXhF
         36Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWqw3AHCtOdg0q5zno6HEBycvbFlwsU0R1JITd6+Uu8TEI2yMqQNgAXjNzT5axu/EE/csPdO6G1D4yia9DB3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjnIfH2Ggf9LuRoosLbV1/cckz4AcNl+2e0MspuSHZpXfrGgJX
	aaZzztZZFJYgj60gU+i9tf/iUz62tKTaRk/Oux+Til1J/XRnOavn/65I28Ewyi5GS1TK9xhTavj
	pLNctH/c83/8FtgZT+neKy4WBHVJ0PxQtKcHTLn+22Grd3qxsEYDKBIBHlOKeLK0ARpe+Lw==
X-Gm-Gg: ASbGnctlhNLVqLRCIMwVS7Wchd5z3bn/xtMpl/vs+P3TcXLVPHV0dNMOvFC2I6ONWFB
	DT0nYqL+dUxnC3v+MVgOh7P+vor+t/xuAtrd5T02fI267aKKLaECvFdnAYtCmndUxhZIXHBG6cn
	uwv6SLDyUQU/3agWWRIF06xR+HPHcvyWnsZG6m/5RVdqKsWQbhl821i1gD7NvzHGbrVlhFUm8ar
	QgVUWt9WZtZSQ5IVeiJ6TIBoUj4iFEG8BAycpUedr/NOxhLbjtC6Yj0qLRRIX54Pp8uC3FFR9rq
	vgUnirLwxOqWDtQiKym6WmfrQ5vLcGuTTPoU4Rc7PJLgV7YCKwn1Y/QLlHIIT9MVIM7o0cYPAPG
	m24BanFEFCRNq0oSDyY64eGul/zYxj20=
X-Received: by 2002:a17:90b:3f8f:b0:312:639:a058 with SMTP id 98e67ed59e1d1-31e5082e792mr2978015a91.27.1753250300686;
        Tue, 22 Jul 2025 22:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+Dllea4dAoEds88TCilmkFnz0an9y6OUH3WvLxWNlLxgWLGEnGgF98AiavG4GsOxkZ4osSQ==
X-Received: by 2002:a17:90b:3f8f:b0:312:639:a058 with SMTP id 98e67ed59e1d1-31e5082e792mr2977978a91.27.1753250300115;
        Tue, 22 Jul 2025 22:58:20 -0700 (PDT)
Received: from [10.133.33.45] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e51b9337esm756858a91.36.2025.07.22.22.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 22:58:19 -0700 (PDT)
Message-ID: <6b411f8f-b4e1-4252-a9a2-04e36043e252@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 13:58:16 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k_pci: add a soft dependency on qrtr-mhi
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
References: <20221202130600.883174-1-hch@lst.de>
 <0b28bb5f-56b3-4be6-b4f4-89ca546a24d0@oss.qualcomm.com>
 <83c62cb2-7d85-4a9e-ba76-63faa27faedf@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <83c62cb2-7d85-4a9e-ba76-63faa27faedf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BeFJ1CziWEl1vafJ20cZbhTYuwVxYgFi
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=688079fd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=7D9JVqTAamdkZGSUpmsA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA0OSBTYWx0ZWRfX6FNxWKZiziZ5
 eKIRH3/qMuI/GBnx1cDCidYUAe5A/pvsVCsAP1UzNASHT5yFtx2KX3XOrQkM9IR4YEzlEJxkX2B
 g8YCXA//1PnC9FULFoWvZMV8J3YQchlmFBgYbPxQ3SdEL8k4awfnjAm9StfoDSr6ZpUc0pY50Ar
 RE8wlpQch8k59aBfStFlk4sSUiWASbkPEh/FM1qMvFKOVJB7QNwLo+ahSfcvYvmuvc+q1NiOZxn
 a/OFIx/J7HzmmxVIy61JstY4SA0cmWRglG4GgmHtUYLk/yFqq3/xXsnGi7Neo24Zu6AewjYSLnE
 PiTKcb7yLhhG83o4sek10PRfRF7dW2Od9aW69heNfMlLjwkAvtpjt67OemgArptFihLWmQlFN9m
 LqoaVNbY1PjPepZQYyR12r5j5PVcS42R/RAnJ3t6mRmAr4ss4BwGj1l5eaSUfiZ+FKULZ2BX
X-Proofpoint-ORIG-GUID: BeFJ1CziWEl1vafJ20cZbhTYuwVxYgFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230049



On 7/22/2025 10:37 PM, Jeff Johnson wrote:
> On 7/22/2025 1:35 AM, Baochen Qiang wrote:
>>
>>
>> On 12/2/2022 9:06 PM, Christoph Hellwig wrote:
>>> While ath11k_pci can load without qrtr-mhi, probing the actual hardware
>>> will fail when qrtr and qrtr-mhi aren't loaded with
>>>
>>>    failed to initialize qmi handle: -517
>>>
>>> Add a MODULE_SOFTDEP statement to bring the module in (and as a hint
>>> for kernel packaging) for those cases where it isn't autoloaded already
>>> for some reason.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>  drivers/net/wireless/ath/ath11k/pci.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
>>> index 99cf3357c66e16..9d58856cbf8a94 100644
>>> --- a/drivers/net/wireless/ath/ath11k/pci.c
>>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
>>> @@ -1037,6 +1037,8 @@ module_exit(ath11k_pci_exit);
>>>  MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax WLAN PCIe devices");
>>>  MODULE_LICENSE("Dual BSD/GPL");
>>>  
>>> +MODULE_SOFTDEP("pre: qrtr-mhi");
>>> +
>>>  /* QCA639x 2.0 firmware files */
>>>  MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_BOARD_API2_FILE);
>>>  MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_AMSS_FILE);
>>
>> Do we know why this patch is rejected?
> 
> This predates me becoming a maintainer, and I don't see any comment from Kalle
> to the patch, however he did have the following comment in a separate thread
> where the issue was being discussed:
> https://lore.kernel.org/all/87cz8v2xb2.fsf@kernel.org/
> 
>> Though I am happy to take your MODULE_SOFTDEP() patch, just wondering if
>> there is a better way to solve this. For example net/mac80211 (the
>> 802.11 stack) has a lot of crypto dependencies:
>>
>> 	select CRYPTO
>> 	select CRYPTO_LIB_ARC4
>> 	select CRYPTO_AES
>> 	select CRYPTO_CCM
>> 	select CRYPTO_GCM
>> 	select CRYPTO_CMAC
>> 	select CRC32
>>
>> And it's not using MODULE_SOFTDEP() at all.
> 
> So I'm guessing he considered this to be an issue that should be solved
> external to the individual drivers.
> 

Thanks for finding the thread, it really helps.

Hmm, I agree that we should not blame this on the driver as all dependencies have been
clearly documented in the Kconfig file. However seems the userspace tool (e.g. depmod on
Ubuntu) does not care about it but just looks into ko files under /lib/modules. So if we
currently does not have a better solution, maybe we can take the MODULE_SOFTDEP way?

> /jeff


