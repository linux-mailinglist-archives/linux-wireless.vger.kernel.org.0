Return-Path: <linux-wireless+bounces-3298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABDD84D020
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 18:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB31328EB9C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F78288A;
	Wed,  7 Feb 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="etE/ULZw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E682D82
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327800; cv=none; b=Hpc59mHjQFI0OOMEj//IxvhChL14YVLEBHll7Mn9pHHjbfrOaiHVsJTLaHiFkKXwiJ5OzkZS9w+3CmhvCRyfKL/3sc82DTLWRa0CKSouYdU7H8YlGBMCuJ4vbcAIZwSTsQfoZHbi/rQtHh7Hxk0myNLtvyduw+RzHF9PA3Z6Spc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327800; c=relaxed/simple;
	bh=NPvhkXU99dJ3PoPHDmgl6gdGH9NBmF3tlr/bTzOjybg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nRRiLgYwV7ZQcrCHyPhifFuUsDhMgCcXY3z9HYYEFOfTn7P1yKc0J1d8SfBdZlz07i5Z/z94DgbgEkYSxvslyomdLE8BzDiYgx7KvzVRWQGDVOZ6Si1765AZlGmqN1y0Ioo6ndbTDfsaIJPyItKSTTFFXuCFwYcQvwB/Eg5trEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=etE/ULZw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417D2cE6011772;
	Wed, 7 Feb 2024 17:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4kxLxkoweed2TxxYILjc92714iKBzsNAZuTMz3ABe1A=; b=et
	E/ULZwfL9eGk7e0WpYWPgjVMoVspAcg5D4+pYMsbBURPYhjFoArpSL6GfJfNB9Df
	3PefAWw1JaEEELNsq6udg0fV2VpoAki8ZJ5j6N2HgopMYDPwB/hS3Sd1ws8Ykkh6
	tPXoxdpOLzyoU7LLIXP+Fk912imofAeUpzU/xeqtFEXU3HcvPLVpQmgYP1Db7N8r
	HRdxfqsvqE5Oy+1+oTNT7s40AQK1tQ3rIOQsZlj4NNsYiOib1Ai7QRzNTusAeat4
	9vxT29nlT5EWoNoYN/xAoCv0WZ12u4Yx7yLfA7Ogs3ii6I8P5qmcqZ3mcKDTcpTT
	3MYKgFPWxS4WPwXP1q0w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3x41t27m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 17:43:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 417HhC7l022503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 17:43:12 GMT
Received: from [10.110.62.200] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 09:43:11 -0800
Message-ID: <1f46c0cc-6cd5-4081-b91b-fb6cca830eaa@quicinc.com>
Date: Wed, 7 Feb 2024 09:43:11 -0800
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
To: Kalle Valo <kvalo@kernel.org>, Kang Yang <quic_kangyang@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-6-quic_kangyang@quicinc.com>
 <87plx9r2rp.fsf@kernel.org> <87eddpqwym.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87eddpqwym.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uf8E1rZy1eN2nouGp0avimEc6gt2sPl5
X-Proofpoint-GUID: uf8E1rZy1eN2nouGp0avimEc6gt2sPl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070131

On 2/6/2024 10:17 AM, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> Kang Yang <quic_kangyang@quicinc.com> writes:
>>
>>> The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
>>> signal its absence due to power save timing, concurrent operation, or
>>> off-channel scanning. It is also used in the P2P Presence Request-Response
>>> mechanism.
>>>
>>> The NoA attribute shall be present in the P2P IE in the beacon frames
>>> transmitted by a P2P Group Owner when a NoA schedule is being advertised,
>>> or when the CTWindow is non-zero.
>>>
>>> So add support to update P2P information after P2P GO is up through
>>> event WMI_P2P_NOA_EVENTID, and always put it in probe resp.
>>>
>>> Create p2p.c and p2p.h for P2P related functions and definitions.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>>
>> [...]
>>
>>> +static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
>>> +				    struct sk_buff *skb)
>>> +{
>>> +	const void **tb;
>>> +	const struct wmi_p2p_noa_event *ev;
>>> +	const struct ath12k_wmi_p2p_noa_info *noa;
>>> +	struct ath12k *ar;
>>> +	int ret, vdev_id;
>>> +
>>> +	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
>>> +	if (IS_ERR(tb)) {
>>> +		ret = PTR_ERR(tb);
>>> +		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ev = tb[WMI_TAG_P2P_NOA_EVENT];
>>> +	noa = tb[WMI_TAG_P2P_NOA_INFO];
>>> +
>>> +	if (!ev || !noa) {
>>> +		kfree(tb);
>>> +		return -EPROTO;
>>> +	}
>>> +
>>> +	vdev_id = __le32_to_cpu(ev->vdev_id);
>>> +
>>> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
>>> +		   "wmi tlv p2p noa vdev_id %i descriptors %u\n",
>>> +		   vdev_id, le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM));
>>> +	ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
>>> +	if (!ar) {
>>> +		ath12k_warn(ab, "invalid vdev id %d in P2P NoA event\n",
>>> +			    vdev_id);
>>> +		return -EINVAL;
>>> +	}
>>
>> Aren't we leaking tb here? In this function I revamped the error
>> handling to use the out label to make sure we are freeing tb in every
>> error. Please review:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=12e182b47078a48169e873c51d438d7417e7e0c8
> 
> I realised that ret was uninitialised when no error, new version:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=43f3069f6580b8a67969a6f32377d35aa7dd8d9a

Thanks Kalle, looks like I had a review failure on the original :(
The version here LGTM :)

/jeff
> 


