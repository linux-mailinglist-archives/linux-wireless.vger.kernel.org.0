Return-Path: <linux-wireless+bounces-17543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEFAA11B90
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 09:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFC61889701
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 08:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DEE22D4FE;
	Wed, 15 Jan 2025 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UlKXb1dz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCCB23098F
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928591; cv=none; b=AjmezyPOjFdTN0Wh4IxhMEJV3VwdQ4i6bxdONCxLkI4OebBVRyXD3FpssqiFmCHup08ExppLRAqUfqcXgmOGZ1g9XLYxFYXhMPte4QLRuMz5Gg1cOUh6BnR5ZihU4OTneFUZVNUByqK/7jNou4AyV05nP+u0xD7bKT3I41eq7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928591; c=relaxed/simple;
	bh=Z3b1ROmNPkB+l01n3xOpxzJaDpLwKIAyFUbzq41jh74=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dlJD19F4EMJzOtKQL7z6bnGKo9JXZ4gRpgeenxirTB5GDcI52USlQXW42znfD6mnv2riCGUsBB7AOkCbY0tsZ3wHJrOM4eBj71RK6AAe7g59XhoUCQDrSgTSlCW0HPP1hXM3wDlHDY44xoImu1usXycozfRSschvj0rhJRKQxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UlKXb1dz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F0bhXm002544;
	Wed, 15 Jan 2025 08:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7SE0z/3TF1CLRiF/vkf7oMPDhtyX0N4Usv0P+pgvfEo=; b=UlKXb1dzmkbyqapQ
	JsI7N+98a0EtO7hXS6i9NF68ZsOgz9H0MJbX+9l57QM/GDAxn8WAapEPitvK1AJs
	z99Y8KIVN8Tow6x1YEwGyAPnWuCcDXGUihgaRJqOOYh2PWQg99fvQr4dCP7saqWH
	nI/BOFCTM5fGYX1nrEnO/v4cYQA1jqQO8ZH94B/4aLtwFz+DefxwrAEkpshSHAQE
	uKJvg1paKLDlauGEofpeg6MpECytNn3HMltTGUmgFGaH8Gvki+0GPZ4sdWDrulrg
	XgS32ZAXdJCdLJWjYtF3FMXSzUd4N1kwRq4llWYNgYlfC8i7vE7xRjjpo775XJhk
	LMWYuA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4462mkgxb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 08:09:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F89ieO023221
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 08:09:44 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 Jan
 2025 00:09:42 -0800
Message-ID: <3b8a9231-e568-440e-90ef-679deb9f3655@quicinc.com>
Date: Wed, 15 Jan 2025 16:09:40 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath11k: fix leaking peer->tfm_mmic in reset
 scenario
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240826014942.87783-1-quic_bqiang@quicinc.com>
 <20240826014942.87783-3-quic_bqiang@quicinc.com>
 <d64f87fa-aad2-bc76-7de6-3e5056e2e637@quicinc.com>
 <8b2d2ed1-88ff-475e-a4c5-8740591f67a7@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <8b2d2ed1-88ff-475e-a4c5-8740591f67a7@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HXJVDl4n6_i9PFcTn5_G1VaPqiMFx3XX
X-Proofpoint-GUID: HXJVDl4n6_i9PFcTn5_G1VaPqiMFx3XX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_03,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=827 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150060



On 1/11/2025 3:15 AM, Jeff Johnson wrote:
> On 8/27/2024 5:33 PM, Karthikeyan Periyasamy wrote:
>> On 8/26/2024 7:19 AM, Baochen Qiang wrote:
> ...
>>> @@ -883,7 +883,7 @@ void ath11k_mac_peer_cleanup_all(struct ath11k *ar)
>>>   	mutex_lock(&ab->tbl_mtx_lock);
>>>   	spin_lock_bh(&ab->base_lock);
>>>   	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
>>> -		ath11k_peer_rx_tid_cleanup(ar, peer);
>>> +		ath11k_dp_peer_cleanup(ar, peer->vdev_id, peer->sta->addr);
>>
>> peer->tfm_mmic is allocated in ath11k_peer_rx_frag_setup() but its not 
>> cleanup in ath11k_dp_rx_frags_cleanup(), which is not symmetric now. 
>> Instead its freed in ath11k_dp_peer_cleanup(). can you refactor 
>> allocation/deallocation symmetric funcs ?
> 
> There was no action on this review comment.
> 
> Do you plan on submitting a v2?

sorry for not manage to respond timely.

Regarding this comment, my impression is that peer->tfm_mmic is not the only filed being
non-symmetric, and it is not easy to refactor it to achieve symmetry. So my plan is to
leave the patch as is, and a separate patch could be cooked in the future if we want to do
refactor.

> 
> /jeff
> 


