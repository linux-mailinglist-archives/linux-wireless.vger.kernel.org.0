Return-Path: <linux-wireless+bounces-10277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D1293347C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 01:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691591C2243D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 23:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424B3143C72;
	Tue, 16 Jul 2024 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="etVMN8nK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BBE13CFA3
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721171577; cv=none; b=jeEn5eG7V2iBbMgV/yO5A2FVK/ndjQJyeV+9bkbnETxHsCZeySdQ+XA4TXd9XLrmspe8JXQfIsiItkt/ArjgnNN0mf+caVVD/wPFrteCX3vOS0VN2Ng/cPB41ftnqKOmEiOKo/iW14eRF9VasCuETZ7niKetn2aWNZG+iVTN+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721171577; c=relaxed/simple;
	bh=8/kDldz6pStm04q4qi3EmyHgTCqCokGuTkqOBWtBR30=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HsdHzEhGo6hSdLrFVA+2HCE2Ide/kQsK3PLzOfoBeE3dOOSYGVlLoRp9q6IXFYwa8LmnIK5CIjhoKh5HHhhI30gZZBCdxbnON8fxOUfJwnsuPw+MX86u4KhnFXTB4OX5YC05Xd4bAxWhcVPVmWaenjeno67+7A4Ay9utKVUbryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=etVMN8nK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHev6f026959;
	Tue, 16 Jul 2024 23:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O3bzu4lEl4FrcLmHSyYl+vMEdSRfBEg69MDObo0mrX0=; b=etVMN8nKqSieNDiL
	il31/vE32PH/ng7E/u99/yo8a8/Z5G1ycalIKH5NWZU/CMDIvPnP8MgMR/SXkzFi
	hTbtqM+EgxgBlgnSVw6F5VmN43ADtPnxSwOt5jRCGpah6gcJuFdKqJsWhfU/l91V
	zJmW/VS/4KbGEoYn8rvk5I2ANHPEUs5wIwvH7D46T9PQ569HgXZe39D3q8++4BvS
	SHJv/inaOuJmyWUUnF8pRzSioRDudSNPzxD+BL48JjKSk9uYikpxO2tp0V6ugnAV
	QPd8AfeilsU1QUttSjN1gBbaBkEll5MmZERwLGRMpodKFvAHRquK4Bw1K82SoCSc
	Ls5NQw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs0juv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 23:12:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46GNCn3i028142
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 23:12:49 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 16:12:49 -0700
Message-ID: <ba6d7724-577a-4188-9205-58081c84f853@quicinc.com>
Date: Tue, 16 Jul 2024 16:12:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath12k: Add firmware coredump collection support
Content-Language: en-US
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240716063932.2627087-1-quic_ssreeela@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240716063932.2627087-1-quic_ssreeela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PXddbWAuEKNMiKqGr-abucekDmUM2z6E
X-Proofpoint-GUID: PXddbWAuEKNMiKqGr-abucekDmUM2z6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-16_02,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=957
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160171

On 7/15/2024 11:39 PM, Sowmiya Sree Elavalagan wrote:
> In case of firmware assert snapshot of firmware memory is essential for
> debugging. Add firmware coredump collection support for PCI bus.
> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
> format and also pack various memory shared during QMI phase in separate
> TLVs.  Add necessary header and share the dumps to user space using dev
> coredump framework. Coredump collection is disabled by default and can
> be enabled using menuconfig. Dump collected for a radio is 55 MB
> approximately.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> ---
> v4:
>   - Fixed Kasan warning vmalloc-out-of-bounds in ath12k_pci_coredump_download
>   - Rebased on ToT
> v3:
>   - Fixed SPDX comment style for coredump.c file
>     Changed Kconfig description.
> v2:
>   - Fixed errors shown by ath12k-check
> ---
...
> +	dump_tlv = buf;
> +	dump_tlv->type = cpu_to_le32(FW_CRASH_DUMP_RDDM_DATA);
> +	dump_tlv->tlv_len = cpu_to_le32(dump_seg_sz[FW_CRASH_DUMP_RDDM_DATA]);
> +	buf += COREDUMP_TLV_HDR_SIZE;
> +
> +	/* append all segments together as they are all part of a single contiguous
> +	 * block of memory
> +	 */
> +	for (i = 0; i < rddm_img->entries; i++) {
> +		if (!rddm_img->mhi_buf[i].buf)
> +			continue;
> +
> +		memcpy_fromio(buf, (void const __iomem *)rddm_img->mhi_buf[i].buf,
> +			      rddm_img->mhi_buf[i].len);
> +		buf += rddm_img->mhi_buf[i].len;
> +	}
> +
> +	mem_idx = FW_CRASH_DUMP_REMOTE_MEM_DATA;
> +	for (; mem_idx < FW_CRASH_DUMP_TYPE_MAX; mem_idx++) {
> +		if (!dump_seg_sz[i] || mem_idx == FW_CRASH_DUMP_NONE)

this looks really strange testing dump_seg_size[i]

the first time through the loop i will be set to the value of
rddm_img->entries since that is the value it will have from:
	for (i = 0; i < rddm_img->entries; i++) {

but subsequent times through the loop i will be set to the value of
ab->qmi.mem_seg_count since that is the value it will have from:
		for (i = 0; i < ab->qmi.mem_seg_count; i++) {

did you really want to test dump_seg_size[mem_idx]?

> +			continue;
> +
> +		dump_tlv = buf;
> +		dump_tlv->type = cpu_to_le32(mem_idx);
> +		dump_tlv->tlv_len = cpu_to_le32(dump_seg_sz[mem_idx]);
> +		buf += COREDUMP_TLV_HDR_SIZE;
> +
> +		for (i = 0; i < ab->qmi.mem_seg_count; i++) {
> +			mem_type = ath12k_coredump_get_dump_type
> +							(ab->qmi.target_mem[i].type);
> +
> +			if (mem_type != mem_idx)
> +				continue;
> +
> +			if (!ab->qmi.target_mem[i].paddr) {
> +				ath12k_dbg(ab, ATH12K_DBG_PCI,
> +					   "Skipping mem region type %d",
> +					   ab->qmi.target_mem[i].type);
> +				continue;
> +			}
> +
> +			memcpy_fromio(buf, ab->qmi.target_mem[i].v.ioaddr,
> +				      ab->qmi.target_mem[i].size);
> +			buf += ab->qmi.target_mem[i].size;
> +		}
> +	}
> +
> +	queue_work(ab->workqueue, &ab->dump_work);
> +}


