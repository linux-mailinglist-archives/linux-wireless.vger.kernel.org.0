Return-Path: <linux-wireless+bounces-24261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1330EADFCF0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 07:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED6E7A458B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2BB241CB2;
	Thu, 19 Jun 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SWU0jgQ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C31B6CFE
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750310876; cv=none; b=q17BqxDGaAQaN1tusD3j4SH9oEwU9Qc8lfVCG3Yty4bnp8Ry1AmC11MMRY9xwXkDZnN4qw7MUyXsfUuPfqXrcmhdb7qIuBmt8uFKgN/MurLgdfkDOgJK5f2X53x9WPHPxC5+lvBQsT0+OJ8mZ4PEVNjvMiCDvGvaI65KqllmPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750310876; c=relaxed/simple;
	bh=iJ8QLU6SERJ4EcDA3r6T+8IV905tGZU+klolUAnisyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCF5+E1NWaWLLdQnq7oVsQZn2IYwptZPOJeaA4RmSTXwHVpVwzoORYEnj9TcalQiP3MxzEw5qWLLgT4Pzd4Ql6NTBj8x9ayQXWn/d+4J0iLe/Z1IYwBFzECoZoyVWSu4oFrZhIdtRc2GZt9XSNpj9VmbY6Ic1aKasON03ZmvDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SWU0jgQ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J2OdiF009463
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 05:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hkLtY1EvcRL1vNox+lIJDsNTt/CTAK5Hg4Fo2ctved4=; b=SWU0jgQ0I4mgFOe0
	HR0LMYy6e6+JTHt57VqlznuNnU6fkHtQCKmdr9sz15KW6PIPmcNLClscKxYVkul2
	kPRZMzBiN1A7CC0p8LjkfOErzfYotfCIDkEytQpwgd20mJemyuP7CG0mN/t0TZgz
	MXb1W4nR+YCBX9d5CO8h5WMYjNg0GLs5DwEfIzZKUodCLAIypxEsUGmfeHCsx3+b
	uCSfU6vfylD7JIZZ+r3BOJURgg2pKQe4Q2u0LCDn5d2ahL07t6Rc3Zgxa5q7gTvV
	E0nkgri/Nyz61CgOzvdwWD+3qQPPDL/ZW06sq4NQgM9XJqbnJn/5ah9hGygDUkLX
	uAb7rg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag23amk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 05:27:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23507382e64so5236715ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 22:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750310864; x=1750915664;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkLtY1EvcRL1vNox+lIJDsNTt/CTAK5Hg4Fo2ctved4=;
        b=fpb2/YE3Ew3bO4RnGyn1cxpd1LS6bXR5jQGOgcM5bZMKSt6yQmoq9jllM4OdIsuuCo
         NVsLDMm1/bB5Ni4q4Xcc7tUXDzsJCLUAku+fNj+9qZYwd2NExc6pTPBCxLgAjV10kATb
         aJ/mjr6dlj5HkHEPslCEINTtnrlb2o/GyCWc3Mwe48D42274w7lfM+djsF4LwGhkd5+7
         K0p1NqPRGzWPs23dEXRUWV7l3kMhfhjjLwcWOU8D351lOmGIdouvBa+eD3FAWcTcjPgf
         Ntn+Tbl+tP5kak8PlAgNT/8431U8Wdmz73KneDkUuruSrmEWwXN6fALWwQzwC75rO6pi
         twCw==
X-Gm-Message-State: AOJu0YyVCKoCpB7E5LuFnIat5L7+BuqkjKZqwFfU2CBIwBv/6WKEXERg
	v7LyAHrvdkZdHWhIiAxJX9BXrYc696w0f4tiYFE5u3+OSBoMlHfulSBeZWzoYttZbarxXvRdlhK
	reDcIdODZfEZSlX6BwgoU9ZTtGf1aAR30bhQA/QkRrl0g+G3tEBAyPFYLwbQJOwaOR/bApQ==
X-Gm-Gg: ASbGncvETg9VF5dlPCefjjAhPkOhxp8cjCe0/AXqXue+JZwrRFW+DTCe619GB9bRgDR
	HXEpbmGBz3wEX+UcUEnPi8U1iRsfpiruTlTDmyBUHKG1zcO5OFWtz/eNWcNSNQ32wfQAub7RaZ7
	n5/xF5t2X2Se9UJxm/DOBD+CBXXQ6SmQFty5xR7X0vKB20S4Fo4+YaisC+GIl/lrpnKS0HDp9Q2
	BC46RPL5kw64Np1ztJL2B/HPn2u6q1PDDE8rr4d6fAe+kySQyKRtwFM3MCgbfo5kRy2/7i2DOFU
	m8P5NOkJImVyWsqMfjTinGg61YRfsW9ETqo0x0EPY9F6JYbR+P13NhzXjsDn3s+exOS9UIbdAEQ
	2Hmr8jZ5NKiN2+a4=
X-Received: by 2002:a17:902:f551:b0:234:ef42:5d69 with SMTP id d9443c01a7336-2366b32cc99mr264842945ad.13.1750310864153;
        Wed, 18 Jun 2025 22:27:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXnYxKoU4DZ28JuX3ZTfKsndaa2Q4xJTU6aH8rVJzZGOuzvZuUU0R2oDXxrblvMfJQnzwimw==
X-Received: by 2002:a17:902:f551:b0:234:ef42:5d69 with SMTP id d9443c01a7336-2366b32cc99mr264842675ad.13.1750310863693;
        Wed, 18 Jun 2025 22:27:43 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a4278sm111465615ad.78.2025.06.18.22.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 22:27:43 -0700 (PDT)
Message-ID: <311686ba-d0d4-4e9b-a0e4-02a1652bbdbf@oss.qualcomm.com>
Date: Wed, 18 Jun 2025 22:27:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] wifi: ath11k: clear initialized flag for deinit-ed srng
 lists
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250612084551.702803-1-senozhatsky@chromium.org>
 <73c6cd0a-9c15-421e-afa4-27fe173bb428@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <73c6cd0a-9c15-421e-afa4-27fe173bb428@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3HMnv3Zz-_pa8W9BqIb00IlK1LCQSgnH
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=68539fd1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=cm27Pg_UAAAA:8 a=COk6AnOGAAAA:8
 a=UqphAtYn3tvgA1B2ULoA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA0NCBTYWx0ZWRfXzhTFdrRYVrpx
 RoRS923EpDtSJtnkfszHNkr14VA8YESsAkypbpOjDDDzQ8SnJEbo08wVNTewtI9bjGOngLylPpD
 YhpI28ouokGIGkClh6UWY1ga6N7T2iyly4yXDG4sfb2tuIjBjx605sNbDTfj60crzXgSYdZfL0s
 hsDeKk0G/NQFFyTwXODLn68mqDnAZeDRpyKrKpatg/cI2mtGclwrcIUOjz4/SvKLyNjKvWbcSaH
 vgtmd7fcDNgXyLKxtqCbioTr+Peyx+aD2o1b96u6VcVPyC36BahJNQ4nup/rQm5sU4OkPrk38y7
 Eb3GCpef8DxQBE4tWeFjPMHMjeDTpur64r35SRhfVvjyhr2lDZx0UkuQYP8HcpOIM5G3wWAN2WZ
 exvl2V3EfPJY/7Jdlif34rLrLbfffzmmQCMBVv/20b5iIIErHuGhnPhPRN/w1AH34KAJz9Vq
X-Proofpoint-GUID: 3HMnv3Zz-_pa8W9BqIb00IlK1LCQSgnH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_02,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190044

On 6/12/2025 3:49 AM, Baochen Qiang wrote:
> 
> 
> On 6/12/2025 4:45 PM, Sergey Senozhatsky wrote:
>> In a number of cases we see kernel panics on resume due
>> to ath11k kernel page fault, which happens under the
>> following circumstances:
>>
>> 1) First ath11k_hal_dump_srng_stats() call
>>
>>  Last interrupt received for each group:
>>  ath11k_pci 0000:01:00.0: group_id 0 22511ms before
>>  ath11k_pci 0000:01:00.0: group_id 1 14440788ms before
>>  [..]
>>  ath11k_pci 0000:01:00.0: failed to receive control response completion, polling..
>>  ath11k_pci 0000:01:00.0: Service connect timeout
>>  ath11k_pci 0000:01:00.0: failed to connect to HTT: -110
>>  ath11k_pci 0000:01:00.0: failed to start core: -110
>>  ath11k_pci 0000:01:00.0: firmware crashed: MHI_CB_EE_RDDM
>>  ath11k_pci 0000:01:00.0: already resetting count 2
>>  ath11k_pci 0000:01:00.0: failed to wait wlan mode request (mode 4): -110
>>  ath11k_pci 0000:01:00.0: qmi failed to send wlan mode off: -110
>>  ath11k_pci 0000:01:00.0: failed to reconfigure driver on crash recovery
>>  [..]
>>
>> 2) At this point reconfiguration fails (we have 2 resets) and
>>   ath11k_core_reconfigure_on_crash() calls ath11k_hal_srng_deinit()
>>   which destroys srng lists.  However, it does not reset per-list
>>   ->initialized flag.
>>
>> 3) Second ath11k_hal_dump_srng_stats() call sees stale ->initialized
>>   flag and attempts to dump srng stats:
>>
>>  Last interrupt received for each group:
>>  ath11k_pci 0000:01:00.0: group_id 0 66785ms before
>>  ath11k_pci 0000:01:00.0: group_id 1 14485062ms before
>>  ath11k_pci 0000:01:00.0: group_id 2 14485062ms before
>>  ath11k_pci 0000:01:00.0: group_id 3 14485062ms before
>>  ath11k_pci 0000:01:00.0: group_id 4 14780845ms before
>>  ath11k_pci 0000:01:00.0: group_id 5 14780845ms before
>>  ath11k_pci 0000:01:00.0: group_id 6 14485062ms before
>>  ath11k_pci 0000:01:00.0: group_id 7 66814ms before
>>  ath11k_pci 0000:01:00.0: group_id 8 68997ms before
>>  ath11k_pci 0000:01:00.0: group_id 9 67588ms before
>>  ath11k_pci 0000:01:00.0: group_id 10 69511ms before
>>  BUG: unable to handle page fault for address: ffffa007404eb010
>>  #PF: supervisor read access in kernel mode
>>  #PF: error_code(0x0000) - not-present page
>>  PGD 100000067 P4D 100000067 PUD 10022d067 PMD 100b01067 PTE 0
>>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>>  RIP: 0010:ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k]
>>  Call Trace:
>>  <TASK>
>>  ? __die_body+0xae/0xb0
>>  ? page_fault_oops+0x381/0x3e0
>>  ? exc_page_fault+0x69/0xa0
>>  ? asm_exc_page_fault+0x22/0x30
>>  ? ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k (HASH:6cea 4)]
>>  ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:6cea 4)]
>>  worker_thread+0x389/0x930
>>  kthread+0x149/0x170
>>
>> Clear per-list ->initialized flag in ath11k_hal_srng_deinit().
>>
>> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>> ---
>>
>> v3:
>> - updated commit message and subject line (Baochen Qiang)
>>
>>  drivers/net/wireless/ath/ath11k/hal.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
>> index 8cb1505a5a0c..cab11a35f911 100644
>> --- a/drivers/net/wireless/ath/ath11k/hal.c
>> +++ b/drivers/net/wireless/ath/ath11k/hal.c
>> @@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
>>  void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>>  {
>>  	struct ath11k_hal *hal = &ab->hal;
>> +	int i;
>> +
>> +	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
>> +		ab->hal.srng_list[i].initialized = 0;
>>  
>>  	ath11k_hal_unregister_srng_key(ab);
>>  	ath11k_hal_free_cont_rdp(ab);
> 
> Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>

Baochen, should there be a Fixes: tag? If so, can you provide it?

/jeff

