Return-Path: <linux-wireless+bounces-3263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B025684C3A0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 05:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E296C1C2183D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 04:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7091CD1F;
	Wed,  7 Feb 2024 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C0SSRUr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51A1CD13
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707280578; cv=none; b=a5WJbM8TEJQI+qMBII7lgTkroDhmZwynSzdj4wF8DOH/4aNonGbKt8DoSgZwZsRY4b1rC2yRi+/vDnGzL45+q2EZK67T8BWDFYhV3xz3V1jsVPIcVT40tlY6eNye5B1PJK44AUSZdMeA8KkzY8HZdIVvwMndG3nhng+I3i0ltnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707280578; c=relaxed/simple;
	bh=JDacfQ1uWPbL63MxKRRyIWXqEVJCUy0DyWYqmPTl9/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sddu5teHH7DcGj8PKBYE05O+nqRQSoj6u0FQx4BGxhjgIBcsxmoaBz/jAJJvGtRPYJZ0CRZk/4CGgTPmT27a+SMdyCmW/JmOe1/7byLUUKNXvOJJgR2jqLNX8rcZJGE9KCKF2jl3heaXe2tzynutVOXIWWEs5hCjuytvXKxsfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C0SSRUr2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417301n6020477;
	Wed, 7 Feb 2024 04:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lsfvL1orhfSM92OZrydbgJoiHsV+bhzutSRQMeeKJM4=; b=C0
	SSRUr2PwBVL64I7RPayqbW8N6O4R3raq0pDT5d/ti3XpIQniAZpENNd2uTlaCZhf
	ax2bGjRCaJ+K4CEWKNiQ/xpR/hWlBLUMoZuPiTrsBNwt3/HJpg8irPb2K98hcnBM
	xIMwu+/sCi/ERcuqfssAXHwRGtCwE1VKrH9riwhSRlozJLPX1wAZe8LxMo2mh/+P
	BVf9oPOzBXNcWJEssOI6NlNmj2v7186/9EReEqgNAcy6T7J3zgLqnIApg7hPd3TD
	iUzkAm+oxp5UnWhV9ik0tJxd1kWqoWJ19JLeQotJnBmN3dDe2SPvwpY5svc4Lq8U
	b7PU7PfUI0pcf2VgN1oA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3ugngt6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 04:36:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4174a6Jw021527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 04:36:06 GMT
Received: from [10.253.13.207] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 20:36:05 -0800
Message-ID: <f2feaa66-52f1-4a13-bf69-5033bd0cd919@quicinc.com>
Date: Wed, 7 Feb 2024 12:36:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] wifi: ath12k: implement handling of P2P NoA
 event
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-6-quic_kangyang@quicinc.com>
 <87plx9r2rp.fsf@kernel.org>
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87plx9r2rp.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7UAjuC_oV5ZRrOmDdQzMhDUzCaIfvE7u
X-Proofpoint-GUID: 7UAjuC_oV5ZRrOmDdQzMhDUzCaIfvE7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402070032



On 2/7/2024 12:11 AM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
>> The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
>> signal its absence due to power save timing, concurrent operation, or
>> off-channel scanning. It is also used in the P2P Presence Request-Response
>> mechanism.
>>
>> The NoA attribute shall be present in the P2P IE in the beacon frames
>> transmitted by a P2P Group Owner when a NoA schedule is being advertised,
>> or when the CTWindow is non-zero.
>>
>> So add support to update P2P information after P2P GO is up through
>> event WMI_P2P_NOA_EVENTID, and always put it in probe resp.
>>
>> Create p2p.c and p2p.h for P2P related functions and definitions.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> 
> [...]
> 
>> +static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
>> +				    struct sk_buff *skb)
>> +{
>> +	const void **tb;
>> +	const struct wmi_p2p_noa_event *ev;
>> +	const struct ath12k_wmi_p2p_noa_info *noa;
>> +	struct ath12k *ar;
>> +	int ret, vdev_id;
>> +
>> +	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
>> +	if (IS_ERR(tb)) {
>> +		ret = PTR_ERR(tb);
>> +		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ev = tb[WMI_TAG_P2P_NOA_EVENT];
>> +	noa = tb[WMI_TAG_P2P_NOA_INFO];
>> +
>> +	if (!ev || !noa) {
>> +		kfree(tb);
>> +		return -EPROTO;
>> +	}
>> +
>> +	vdev_id = __le32_to_cpu(ev->vdev_id);
>> +
>> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
>> +		   "wmi tlv p2p noa vdev_id %i descriptors %u\n",
>> +		   vdev_id, le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM));
>> +	ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
>> +	if (!ar) {
>> +		ath12k_warn(ab, "invalid vdev id %d in P2P NoA event\n",
>> +			    vdev_id);
>> +		return -EINVAL;
>> +	}
> 
> Aren't we leaking tb here? In this function I revamped the error
> handling to use the out label to make sure we are freeing tb in every
> error. Please review:

Yes, i forget to free(tb) here, thanks!


> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=12e182b47078a48169e873c51d438d7417e7e0c8
> 

