Return-Path: <linux-wireless+bounces-10441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C843D939751
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 02:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFD91F2210D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 00:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DB318D;
	Tue, 23 Jul 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G3BrmQYF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE217F
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693464; cv=none; b=aBqrUx3ymnMJMC9k8tAopqXKBmhEs66cDwv7WQad7mbykeuzBf1alxi3xATcbvGkqRqiEEH7YWKLlRE2F+6qiTbSRD9sAil8GNbCkIScOuLDZJEXOdqNg0Ipj4slUIgTRnlsuBr+Dned6QZpiDbcoog7r11Hm3Tt6Q9p4mnRKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693464; c=relaxed/simple;
	bh=G665Cp7FB0K8Xwe5xcg6GuZWSVY1eJf0cxA1r13yWdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kfGgDXAvOrSqp9l46NkMusSt8dpve2wZ3MTuEsxJ2EcqH//BLeYjd8mD87Sgi9LsnDe7OWqPqRuBI37HcDD9AHvbkunGBKooVfRDUepSmmwQoPCxvL0vtHluM7UgLB/yPCEs21LAJOqHh+zZWJYibnimts/4ngX7jZncWFvrDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G3BrmQYF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MAn9Xd003255;
	Tue, 23 Jul 2024 00:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xc/7c8EyA7NuKLSZkl8JnxYlf9iDnVc1uk3+MRq8y+I=; b=G3BrmQYFihRgqY4g
	jF3xyP/BZVHC+GHIwCoz6vSHvZOxyBuKqtvCWQeZ7yf7PveybPwdn0qvSlQ1Fhg4
	qkObnfZ8Mn6dIzqfm+2N1Hkl4dKJiGJh9y2vEukf76iLX7cbvDxF0r4QNEjbRIcK
	c9OSFL/XcXoc/Od1r9QvmjIldUlJG+mIFY37ihf8d6zgUY8vKmMgu6oMRJFjkvCq
	vHUkERYjwo6vqkBnaFRz/uE0XOHKmE7ouqDEfB0B5MI5TblcJxq+nOywBbrAGbDe
	xisjaW43357ghY/XYto9n/34vhxoj5Fv2cKTP5KgK1LK6ESC4Y1MuaJkuckidbKx
	dQ8VLQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g6h8w0re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 00:10:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46N0Auep008278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 00:10:56 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 17:10:56 -0700
Message-ID: <a1ed48fb-8b90-4cfb-81b9-dc2c5cc49cde@quicinc.com>
Date: Mon, 22 Jul 2024 17:10:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: Add firmware coredump collection support
Content-Language: en-US
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240712100442.1790499-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240712100442.1790499-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JTaYKtg2sEg5Bqa1UpTrFS591zcvPtRM
X-Proofpoint-GUID: JTaYKtg2sEg5Bqa1UpTrFS591zcvPtRM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_17,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407220180

On 7/12/2024 3:04 AM, Miaoqing Pan wrote:
> In case of firmware assert snapshot of firmware memory is essential for
> debugging. Add firmware coredump collection support for PCI bus.
> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
> format and also pack various memory shared during QMI phase in separate
> TLVs.  Add necessary header and share the dumps to user space using dev
> coredump framework. Coredump collection is disabled by default and can
> be enabled using menuconfig. Dump collected for a radio is 55 MB
> approximately.
> 
> The changeset is mostly copied from:
> https://lore.kernel.org/all/20240325183414.4016663-1-quic_ssreeela@quicinc.com/.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> ---
> v2: fix implicit declaration of function 'vzalloc'.
> v3: fix vmalloc-out-of-bounds and remove CONFIG_ATH11K_COREDUMP.
...
> @@ -102,8 +102,10 @@ struct target_mem_chunk {
>  	u32 prev_size;
>  	u32 prev_type;
>  	dma_addr_t paddr;
> -	u32 *vaddr;
> -	void __iomem *iaddr;
> +	union {
> +		u32 *vaddr;
> +		void __iomem *iaddr;
> +	} v;
>  };

replicating late-arriving v2 comments here:

On 7/12/2024 2:38 AM, Miaoqing Pan wrote:
> On 7/11/2024 12:20 AM, Kalle Valo wrote:
>> Miaoqing Pan <quic_miaoqing@quicinc.com> writes:
>> I feel that the QMI changes should be in a separat patch and explaining
>> in detail what they are about. Didn't review those now as there's no
>> explanation.
>
> Minor changes for updating 'iaddr' definition. IMO, don't need a
> separate patch.

Putting something into a union isn't minor.
You should justify the reason for doing it and defend why it is safe to do it.

And note that if you make it an anonymous union then most, if not all, of the
code changes are unnecessary.

/jeff





