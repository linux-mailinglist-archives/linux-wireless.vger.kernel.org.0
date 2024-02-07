Return-Path: <linux-wireless+bounces-3264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FACB84C3C9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 05:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546721F25DE4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 04:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8D12E78;
	Wed,  7 Feb 2024 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VEF2Nw1f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1112E74
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 04:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281103; cv=none; b=p7w2WssxFyctLuDXCWEo/sIMNYW6k4Wu8omY3VgILqaG61ftRQpCDXJ+eY7mbzb6n2KekURQoEOQbQJwFnuwQrrqfYOBmCTneN51MqrrEFybY9Qh8ydfrs3GfosLvYfz3rHESDk4LL327As1zX6WlnFVkbOCu/aLMxDrlIEtWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281103; c=relaxed/simple;
	bh=ZQ8C6PBTTI4gAGZOGpyLppNO9O6EU5sZTPe50fd49sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UUKN9J8CNE/6CCBcRF/MKKAVLZnQRTZFmd46+OgGa017D1/HS/LxLI+m7b38ctu2/OfAthZehw8VOkKIPLRpPqgiDOlumd0m3vo1JqjrrNMta4QIm92qhEEehrVUihBQBC1gVkRqWH5uDuhx/kKmscBDTXvFYqDrnCbW2x3jqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VEF2Nw1f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4173wSgR004838;
	Wed, 7 Feb 2024 04:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QuLmviIynL5TQakGKuF5+ilM7aQ1ryEzr6yeSq00UIg=; b=VE
	F2Nw1fIplPD3Qk3OEmYKPqnOItUarLYHI+a7Oc00ZToyfGbbsQNT0Yr+cRs1oQ5Q
	XOxaksyYqJZaXaxqUWRIS5Ju51OKmBVZp2Rj2yFzOhY7NnkR477gqtqLlIxLoho0
	B/Obt1CCUqQSI3xP7aZOfYDuOW24aKUA66Xi2kgfD9No/ri05p7/RJXSsWaC+WF8
	DAlbUoAYvbrdr7N7IvTh4KkqJna0FDT2HJrIPDmKJx+z+d60MMXw6eY7PThShZrW
	EX6AQPQ1853FejAEtnwqBNNYf65y8aRyBeZrQPPT91GTl1rcmSWCrPuYkWLQGuCo
	CaBqMp341is+e5Ue2v6g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3ywbrasb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 04:44:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4174ipJm000942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 04:44:51 GMT
Received: from [10.253.13.207] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 20:44:50 -0800
Message-ID: <19181296-bb2c-40c8-b84c-bec7127b117c@quicinc.com>
Date: Wed, 7 Feb 2024 12:44:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] wifi: ath12k: allow specific mgmt frame tx while
 vdev is not up
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-9-quic_kangyang@quicinc.com>
 <87il31r26k.fsf@kernel.org>
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87il31r26k.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vRXuHHk0pHrgonv0CsKJ9pxJNA18Xm1H
X-Proofpoint-GUID: vRXuHHk0pHrgonv0CsKJ9pxJNA18Xm1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=634 impostorscore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070033



On 2/7/2024 12:24 AM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
>> In current code, the management frames must be sent after vdev is started.
>> But for P2P device, vdev won't start until P2P negotiation is done. So
>> this logic doesn't make sense for P2P device.
>>
>> Also use ar->conf_mutex to synchronize ar to avoid potential conflicts.
> 
> Please do locking changes in a separate followup patch, I removed this
> in the pending branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=d357dcb3cd0cd3bf57064dc673b5477d884454b3
> 
> I assume you are referring to ar->allocated_vdev_map and access to that
> indeed doesn't look consistent. Most of the places take conf->mutex but
> I see some places which it's accessed without the mutex, for example
> ath12k_mac_get_arvif_by_vdev_id() and ath12k_mac_get_ar_by_vdev_id().
> 
> I recommend in the followup patch checking all the access to
> ar->allocated_vdev_map, fixing that if needed and adding documentation
> to struct ath12k::allocated_vdev_map how it's supposed to be protected.


Will do it in the future.

> 

