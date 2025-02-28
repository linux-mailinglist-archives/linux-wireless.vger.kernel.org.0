Return-Path: <linux-wireless+bounces-19598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D937A49E4B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 17:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925BB1898B8B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8818318FC67;
	Fri, 28 Feb 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AzI0zl6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB778188CCA;
	Fri, 28 Feb 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758796; cv=none; b=l560K95ISfYtrVvC+udOoe2m0vGObjMI8A7Ql+Uex+uGQbwALTP0rT8hltxIij13Ffcv6Lbuf0VzGYNvzhRr+snguVkolYZYFpowW/M6V9LitKF3ACw23BrAgU5nKiJoEvsYO05PXT8RB8hRVXoj0ZRhR3F/0tj0nkEvc4Wn88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758796; c=relaxed/simple;
	bh=dXAorRSjssnR7ekcMMO6QNLlWu/MVv+vqvNfNfvlUrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hwn6PtXXTFE1KUiIPxRUaA/u8EvEsmHSKvBG1ztpR4xE1rL7hgT3XGw1l/9WPMPnS0qmjlsx+tbHtnjSPJlY81mlSSEqq/X5ymbqQgdXZmxxOKtK+1f9+K/s6CD0LQAe7OlmrNYrLz4v9Fy4Ss5obJPzP7uzCi9w9biBLD8gJ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AzI0zl6Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXFD3020127;
	Fri, 28 Feb 2025 16:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	toaKbtWzPqfCKonl++yXx0474yo6RKTVtoUSN/vQrF8=; b=AzI0zl6QB8CN6n1Z
	YULzHYME47bzzjuyL0Hk25qD+1AzCNPMhdjcAxBom/bxDEXO6NQvbdz8Y0GMgNjw
	Zu470QjN56RcFX+MM66chsJV4kF39pg6lHyi/pGT+yYGO4Bn/qxx9SyaUgnxXksZ
	ui9R6W7ygL8i0IvM3X9WDKANf0lD2+zpLms/TApDAc2eYSpz5jSHRKHUjraYHGHL
	mEf44YT7+o5Qtd9xIGAkxApdGCzSwd/7hhDsLxbQtef+4Wln5Bkb7Bkqb9obLNBR
	WDOkSziN43njgHtqJdNaNdCSTyxAFw60tUuBJWBVqwWxv1iXYiQPJ20sZtjTHzNU
	5DEbpw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4539uphaap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 16:06:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51SG6PhO011248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 16:06:25 GMT
Received: from [10.216.20.93] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Feb
 2025 08:06:21 -0800
Message-ID: <8f35ef14-49e8-4484-9a66-58b91a537681@quicinc.com>
Date: Fri, 28 Feb 2025 21:36:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/13] wifi: ath12k: add support for fixed QMI firmware
 memory
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
 <20250227191034.1949954-8-quic_rajkbhag@quicinc.com>
 <e702e39a-e199-4ea4-a066-0b2e26253f98@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <e702e39a-e199-4ea4-a066-0b2e26253f98@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FsXWok401kwqd_11_vK3FRmt0B_GHnf4
X-Proofpoint-GUID: FsXWok401kwqd_11_vK3FRmt0B_GHnf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280117

On 2/28/2025 9:08 PM, Jeff Johnson wrote:
> On 2/27/2025 11:10 AM, Raj Kumar Bhagat wrote:
> ...
>> +static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
>> +{
>> +	struct reserved_mem *rmem;
>> +	phys_addr_t bdf_size;
>> +	int i, idx, ret;
>> +
>> +	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
>> +		switch (ab->qmi.target_mem[i].type) {
>> +		case HOST_DDR_REGION_TYPE:
>> +			rmem = ath12k_core_get_reserved_mem(ab, 0);
>> +			if (!rmem) {
>> +				ret = -ENODEV;
>> +				goto out;
>> +			}
>> +
>> +			if (rmem->size < ab->qmi.target_mem[i].size) {
>> +				ath12k_dbg(ab, ATH12K_DBG_QMI,
>> +					   "failed to assign mem type %d req size %d avail size %lld\n",
>> +					   ab->qmi.target_mem[i].type,
>> +					   ab->qmi.target_mem[i].size,
>> +					   rmem->size);
> 
> The v6 version had a kernel test robot build warning here when building for
> MIPS and it looks like nothing has changed.
> 

The kernel test robot warning came just after I posted the v7. Thus, the v7
version also have the same warning. I will send v8 in sometime to address this.

> I don't know the history of why struct reserved_mem::size is of type
> phys_addr_t, but that type has a different size depending upon architecture,
> therefore you can't use %lld.
> 
> To print it correctly you either need to use the %paa format that is meant for
> that type, or probably better would be to assign it to a variable of type
> size_t and then use %zu (and use that variable in the size test as well)
> 

Sure will use variable to type size_t to address this.

> (also consider if the other %d formats should be %u instead)
> 

will update to %u.

>> +				ret = -EINVAL;
>> +				goto out;
>> +			}
>> +
>> +			ab->qmi.target_mem[idx].paddr = rmem->base;
>> +			ab->qmi.target_mem[idx].v.ioaddr =
>> +				ioremap(ab->qmi.target_mem[idx].paddr,
>> +					ab->qmi.target_mem[i].size);
>> +			if (!ab->qmi.target_mem[idx].v.ioaddr) {
>> +				ret = -EIO;
>> +				goto out;
>> +			}
>> +			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
>> +			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
>> +			idx++;
>> +			break;
>> +		case BDF_MEM_REGION_TYPE:
>> +			rmem = ath12k_core_get_reserved_mem(ab, 0);
>> +			if (!rmem) {
>> +				ret = -ENODEV;
>> +				goto out;
>> +			}
>> +
>> +			bdf_size = rmem->size - ab->hw_params->bdf_addr_offset;
>> +			if (bdf_size < ab->qmi.target_mem[i].size) {
>> +				ath12k_dbg(ab, ATH12K_DBG_QMI,
>> +					   "failed to assign mem type %d req size %d avail size %lld\n",
>> +					   ab->qmi.target_mem[i].type,
>> +					   ab->qmi.target_mem[i].size,
>> +					   bdf_size);
> 
> the same issue exists here.
> again this would be fixed by making bdf_size type size_t and using %zu
> 

Will use a common variable (size_t avail_size) to address this and the above.

>> +				ret = -EINVAL;
>> +				goto out;
>> +			}
>> +			ab->qmi.target_mem[idx].paddr =
>> +				rmem->base + ab->hw_params->bdf_addr_offset;
>> +			ab->qmi.target_mem[idx].v.ioaddr =
>> +				ioremap(ab->qmi.target_mem[idx].paddr,
>> +					ab->qmi.target_mem[i].size);
>> +			if (!ab->qmi.target_mem[idx].v.ioaddr) {
>> +				ret = -EIO;
>> +				goto out;
>> +			}
>> +			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
>> +			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
>> +			idx++;
>> +			break;


