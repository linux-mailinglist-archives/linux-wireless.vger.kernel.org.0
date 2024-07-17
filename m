Return-Path: <linux-wireless+bounces-10292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B393394C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 10:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF551F21C4A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45B13987B;
	Wed, 17 Jul 2024 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fypPRxLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD21CA9F
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205753; cv=none; b=sLEMpKstwoTdCDFaEaN2D01SRRHYvirkwNOTNnu9yKfNw/f7gY4u1WzYoq2K0NiRQ1oFbtf36Ok5PQOO42XXbllATIY8GLL49xI2YSMdO0v1Adze0fqMSLmLxH/k6HzNG3yW6KvbS21qvD96iJZVwWmcqmDud9Orfvrjhha2z4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205753; c=relaxed/simple;
	bh=r6uYUYKR/YngTkYrYAdKErgFAmyeP6wUs2Zy+9dEzGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ezhcrOQ74PQr1vZGi/xnrwgHTV6J1ovUQHWzCGOaChd/cBThggtmgFyqN+OQazsiG1p7+KfPcIk3rBz2AzONOwEhVgVEz5XA2batYv1zjZdemoMQUAip0+TlQ8qLNqv5gk9cbO9gyyH7EXh94pL23DsChfQc+JCN3bZJCea6Ng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fypPRxLZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H6gxhX029210;
	Wed, 17 Jul 2024 08:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+A34RHYEqSPPVDgGu5ptqBFqvmH+w7wZ4mRVXiEHmt0=; b=fypPRxLZI5HyP+XC
	DadELIypIcrpikfs8dfeSVFRdD8xKiH1V5KiqwU541MfiDq0UXM9wsKxkT8P74jY
	ujebhz+kU/ybeHuG4hiZRUCMWBwhW1ZbGHiObrwcqLHwaR27U5+7SujPjHiwsbaD
	ju0tR9q7UAZ0gS48xi2n4kLQwA0QouXKL4WyecBjBPOys4zsv09VuW5EP2FL/CnX
	DIMEBlvWTKi4kQvns9xVOHBNSfWD/mgtoxMS+fPMcuzz8+0HyPAQ+iDd52ginlmA
	Ev9JE90yaWpziNTobqZY4bdlQTb2qXXookC7/0n12q2QPU+1drhjO5ZZpod7MeuC
	o/5zzw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwj1hqyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 08:42:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46H8gQAn018026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 08:42:26 GMT
Received: from [10.152.203.156] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 01:42:25 -0700
Message-ID: <399f334b-60fd-9aba-bc8c-ef4ed5cbc411@quicinc.com>
Date: Wed, 17 Jul 2024 14:12:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4] wifi: ath12k: Add firmware coredump collection support
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20240716063932.2627087-1-quic_ssreeela@quicinc.com>
 <ba6d7724-577a-4188-9205-58081c84f853@quicinc.com>
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
In-Reply-To: <ba6d7724-577a-4188-9205-58081c84f853@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M30ZerNvvePTmCImnSAVNd5oaHqb9mxP
X-Proofpoint-ORIG-GUID: M30ZerNvvePTmCImnSAVNd5oaHqb9mxP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_05,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=975 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407170066

On 7/17/2024 4:42 AM, Jeff Johnson wrote:
> On 7/15/2024 11:39 PM, Sowmiya Sree Elavalagan wrote:
>> In case of firmware assert snapshot of firmware memory is essential for
>> debugging. Add firmware coredump collection support for PCI bus.
>> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
>> format and also pack various memory shared during QMI phase in separate
>> TLVs.  Add necessary header and share the dumps to user space using dev
>> coredump framework. Coredump collection is disabled by default and can
>> be enabled using menuconfig. Dump collected for a radio is 55 MB
>> approximately.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>> ---
>> v4:
>>   - Fixed Kasan warning vmalloc-out-of-bounds in ath12k_pci_coredump_download
>>   - Rebased on ToT
>> v3:
>>   - Fixed SPDX comment style for coredump.c file
>>     Changed Kconfig description.
>> v2:
>>   - Fixed errors shown by ath12k-check
>> ---
> ...
>> +	dump_tlv = buf;
>> +	dump_tlv->type = cpu_to_le32(FW_CRASH_DUMP_RDDM_DATA);
>> +	dump_tlv->tlv_len = cpu_to_le32(dump_seg_sz[FW_CRASH_DUMP_RDDM_DATA]);
>> +	buf += COREDUMP_TLV_HDR_SIZE;
>> +
>> +	/* append all segments together as they are all part of a single contiguous
>> +	 * block of memory
>> +	 */
>> +	for (i = 0; i < rddm_img->entries; i++) {
>> +		if (!rddm_img->mhi_buf[i].buf)
>> +			continue;
>> +
>> +		memcpy_fromio(buf, (void const __iomem *)rddm_img->mhi_buf[i].buf,
>> +			      rddm_img->mhi_buf[i].len);
>> +		buf += rddm_img->mhi_buf[i].len;
>> +	}
>> +
>> +	mem_idx = FW_CRASH_DUMP_REMOTE_MEM_DATA;
>> +	for (; mem_idx < FW_CRASH_DUMP_TYPE_MAX; mem_idx++) {
>> +		if (!dump_seg_sz[i] || mem_idx == FW_CRASH_DUMP_NONE)
> 
> this looks really strange testing dump_seg_size[i]
> 
> the first time through the loop i will be set to the value of
> rddm_img->entries since that is the value it will have from:
> 	for (i = 0; i < rddm_img->entries; i++) {
> 
> but subsequent times through the loop i will be set to the value of
> ab->qmi.mem_seg_count since that is the value it will have from:
> 		for (i = 0; i < ab->qmi.mem_seg_count; i++) {
> 
> did you really want to test dump_seg_size[mem_idx]?
> 
>> +			continue;
>> +
>> +		dump_tlv = buf;
>> +		dump_tlv->type = cpu_to_le32(mem_idx);
>> +		dump_tlv->tlv_len = cpu_to_le32(dump_seg_sz[mem_idx]);
>> +		buf += COREDUMP_TLV_HDR_SIZE;
>> +
>> +		for (i = 0; i < ab->qmi.mem_seg_count; i++) {
>> +			mem_type = ath12k_coredump_get_dump_type
>> +							(ab->qmi.target_mem[i].type);
>> +
>> +			if (mem_type != mem_idx)
>> +				continue;
>> +
>> +			if (!ab->qmi.target_mem[i].paddr) {
>> +				ath12k_dbg(ab, ATH12K_DBG_PCI,
>> +					   "Skipping mem region type %d",
>> +					   ab->qmi.target_mem[i].type);
>> +				continue;
>> +			}
>> +
>> +			memcpy_fromio(buf, ab->qmi.target_mem[i].v.ioaddr,
>> +				      ab->qmi.target_mem[i].size);
>> +			buf += ab->qmi.target_mem[i].size;
>> +		}
>> +	}
>> +
>> +	queue_work(ab->workqueue, &ab->dump_work);
>> +}
> 

Hi Jeff,

My Bad, posted wrong version of my changes. Thanks for catching it. 
Yes, my intention was to check dump_seg_size[mem_idx]. I will update and send the next version.

Thanks,
Sowmiya Sree

