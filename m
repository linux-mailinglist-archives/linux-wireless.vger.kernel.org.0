Return-Path: <linux-wireless+bounces-24045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A118AD6AF5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 10:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4985417F386
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6202222B2;
	Thu, 12 Jun 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ofTkKVd0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC922259F;
	Thu, 12 Jun 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717400; cv=none; b=kvA3SKVkr+2OU5lkOzSWutKyCAbE4+S+snm3Pa5EJp/UDalZTzxw8JSIo4u2SmyhR3RJWRRDQCpX+FJqCMR08+NRbGERayFrOylWuan6RiPXytN9C6aTMkdt6r17p0YEgvzQHEHm8TkajeSqF+2vftGDFN2ocE1d1eZiX/wwugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717400; c=relaxed/simple;
	bh=QWusFwyJCN64pgDrgn4qUvLzOMhMziLG3us47SDguwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pZ1cz4z8XEQjtPG+rtiZi6lSAbyi0f3mUx01Oxq+TqjLSHhH9wUSK9pDLcwXppZWEvXYV9mXGDxswyV8F3QGUINSCTvtgnSexi2pgocXKLC7W8iV85rkX9RZSIlBEdTn6c8SBRt3Iedkak4j0OA73bsd0si2hw7rYoDReocfJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ofTkKVd0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7XJC8029246;
	Thu, 12 Jun 2025 08:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KGDSpqUz2cRHwtVx5MfMXXVll6loPNtH2PlrNsxSpfg=; b=ofTkKVd0Q0Zt+QOI
	6Rxv36enIwTPCNsdpV2W1nMCyq5wGvwjSsfa+TPoX3zrIEaNDOilEWxvACyr0F24
	qMmA1BepnGHhl6UxP/21KORTd0MKkwiYiYoVG19Bl5a5U1lqZYT1ZxadH+K7at6/
	VaACQ/Dv2tQK52WFegzjYUJBQslCCIZFbpfgTMUymcL3TvZgkTMMwXI3iPnyKQN0
	e+K8v2BDsfe9OvP6qOFVmCrP1rbdODCUNqiNh3d2psCuQ+0nVNtrd88v6Bhjr/4+
	I9Olzap8oRWzIH83IfAeilQHJkZEgSGcjIFf87bzyUW7843zfj8N9RbAhUoLsLym
	d+GrFA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn6ftng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 08:36:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C8aXla003933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 08:36:33 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Jun
 2025 01:36:31 -0700
Message-ID: <ec013f29-ae0a-46bf-9ddb-4b66bdc13f3f@quicinc.com>
Date: Thu, 12 Jun 2025 16:36:27 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250529035708.3136232-1-senozhatsky@chromium.org>
 <5857380e-ced9-4118-b9a0-ce926b25c11c@quicinc.com>
 <rxaibpgtf37w3th5lnt3w574w443yononqjoglyfktlcxe26qg@jpmtkckrotzp>
 <2f77045c-6763-4fc4-bf09-50fd9b76a394@quicinc.com>
 <xr3n5pbohquhaloonctfqvpb2r3eu6fi5jly7ms4pgcotqmqzh@msrgbaawafsj>
 <ce3c0e51-4df0-4164-adcd-e98f2edee454@quicinc.com>
 <qqhs2mzhg6mgq23wej5a65iau4ysfjh2raakcsvwc4fuqtpwk2@4ouqfld6mrnd>
 <d48a228a-5f48-4732-b12d-78f03541ae9e@quicinc.com>
 <kuawjsglndjvwmq2ki2kctvgcdci6mhfp7juux7tzo3g6h5txh@hddxo4o5raea>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <kuawjsglndjvwmq2ki2kctvgcdci6mhfp7juux7tzo3g6h5txh@hddxo4o5raea>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA2NSBTYWx0ZWRfXyr2I2dZrcyqf
 XzUFrwXlCwpHGFgTJKdr/UWXWprSmaVOpnkV6So82UzCBULjEx9CWy0rS4Z3m42TiKuYBslE91B
 qlXmtosD+k/u9mVIiw8yX0OdpZFZunQvl67vpHthk4Z6vPEDpiFCv++2ocHmDkVSgnsNMlaXEpe
 lYx02GzQDKS4jmsg73F7dJiK0lib91UTI2XoCNmGZN7INsakOMSGiJdNWjxFIYDQXmqnJPKgSax
 bHiS1nKIyS7bEgjIoWv2UYXZ+puXgA80TUl7txWM9zJyzrZF4R5jtfg+3ZjrgKbk88MCSQ5HEq4
 xxZFMK7jxquignScttLo6XIXRQQicjofmtpxgrrCEdJvswUvnldb7qGM+aM3bfEG8U+3fU2iTzc
 dJo+t1wxtlfKyPaVsS5+JKTzAO/lkBQxcG4qc7GslZLjbu/BVe+FW8vsMUciqBQgkOIDwvYS
X-Proofpoint-GUID: A_Y639chkTDV-Im6Xres6sd79qBSG-sN
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=684a9191 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=ATmZjSGgzA2CBFBw7-EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: A_Y639chkTDV-Im6Xres6sd79qBSG-sN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_06,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=659 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120065



On 6/12/2025 4:31 PM, Sergey Senozhatsky wrote:
> On (25/06/12 16:14), Baochen Qiang wrote:
>>> <4>[23562.576034] ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:6cea 4)]
>>> <4>[23562.576058] worker_thread+0x389/0x930
>>> <4>[23562.576065] kthread+0x149/0x170
>>> <4>[23562.576074] ? start_flush_work+0x130/0x130
>>> <4>[23562.576078] ? kthread_associate_blkcg+0xb0/0xb0
>>> <4>[23562.576084] ret_from_fork+0x3b/0x50
>>> <4>[23562.576090] ? kthread_associate_blkcg+0xb0/0xb0
>>> <4>[23562.576096] ret_from_fork_asm+0x11/0x20
>>>
>>>
>>> There are clearly two ath11k_hal_dump_srng_stats() calls, the first
>>> one happens before crash recovery, the second happens right after
>>> and presumably causes UAF, because ->initialized flag is not cleared.
>>
>> So with above we can confirm our guess.
>>
>> Could you refine your commit message with these details such that readers have a clear
>> understanding of this issue?
> 
> Sure, I can do that.   I didn't want to throw my guesses into the commit
> message, stale ->initialized flag looked like a good enough justification

Yeah, it is indeed enough. But would be better to disclose any known issue caused by it.

> for the patch.  But I can send out v3 with a more detailed commit message.

Thanks.



