Return-Path: <linux-wireless+bounces-8853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566590507D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5007282695
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349A616EBE6;
	Wed, 12 Jun 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZwRpCdgs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C816DEB3;
	Wed, 12 Jun 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188575; cv=none; b=MfSqshWnL7FvrfgKFpiqMFpPQnOno3LuZ+RsNaVsl6FdSfxA0Kc9SFGJVUhHMM9/fL6i/wyg5b4W0jkkSRMKOz+r8DUSnnkkDhZpTjXrG2nAInK3wQ/KhTk7zjBensMEtf3c37khzlc/7+8j14n4MiNpQxlierwJXVkeZP/d1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188575; c=relaxed/simple;
	bh=hFupyZsi33AcwavnY/ungfcdsWku+nTO4HRR0VGSMnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=psyUWoXgv56aeMF9IyWE+ii1YYG57mNNSQGrM/jlWsq/ZPCxiLqt2YvCpBtaLpdIaj85B48gheArgf5Tt9Xd0fyc023Dc1tQjMUHKhMEobmlOvArfJwuS23e2dPBEt0JnTS5QvPemGKZGDm9NRceX8W3Ch8CVVJznUpwTGmB24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZwRpCdgs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C4Z0V1002481;
	Wed, 12 Jun 2024 10:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xIWSh6h/XSgseHh3f/3TH9aqVr8oMm6v/yqMmJRphcg=; b=ZwRpCdgsJ17pI3Sv
	zlkXZm9tMSd3WzsI6Enc12+sy2kGzwJAJMJtEIi0aW4nlj9HyMHw4WXzKjONzG6v
	Tvnk1j1tFoptoFOPqSOyLSexxiDn86gyT5cp7wFeG6xYzpgKoGf/k0/2hfkzQErq
	LmIt1oyecvAf7EjSzu6pM1ADXR/DG0WFXsjULKl0eoglAd+/F35t4j3YTrq+ai5q
	atY7Q95u+lJZdEWr41PxsHQ4QTcYLgMzZPYKeBF2uT3ajsQJ62KNT0hupZKOS2aw
	1F63eI7PKDy9tAFSfgwyekpx6mJ4GTdiHYuD/40XZ12HrggA8OTjw13f6uUv/FhV
	S1GcWw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yq4s08tfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:36:00 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CAZx7J014380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:35:59 GMT
Received: from [10.253.72.168] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 03:35:57 -0700
Message-ID: <440b1e9e-cba7-4716-a78e-570dbc733606@quicinc.com>
Date: Wed, 12 Jun 2024 18:35:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] net: rfkill: Fix a logic error within
 rfkill_set_hw_state_reason()
To: Johannes Berg <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <emmanuel.grumbach@intel.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
References: <1717771212-30723-1-git-send-email-quic_zijuhu@quicinc.com>
 <1717771212-30723-3-git-send-email-quic_zijuhu@quicinc.com>
 <c0ad3896334014ba2f12a7978b912e9c49b30d58.camel@sipsolutions.net>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <c0ad3896334014ba2f12a7978b912e9c49b30d58.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M7Nhm-SIgFzevZntDIQXHY7RczKXOy0p
X-Proofpoint-ORIG-GUID: M7Nhm-SIgFzevZntDIQXHY7RczKXOy0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxlogscore=946
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120076

On 6/12/2024 6:18 PM, Johannes Berg wrote:
> On Fri, 2024-06-07 at 22:40 +0800, Zijun Hu wrote:
>> Kernel API rfkill_set_hw_state_reason() wrongly gets previous block state
>> by using its parameter @reason as reason mask.
>>
>> Fixed by using @reason_mask as reason mask.
>>
> 
> Actually, this *introduces* a bug. I'll leave it to you to figure out
> what that is, I'm not convinced that you're actually doing *anything*
> useful here.
> 
i feels that current logic is weird and it is very difficult to
understand when i read rfkill code.

i think it deserves a comments for current logic if it is right.

current logic was introduced by below code applet of the commit
Commit: 14486c82612a ("rfkill: add a reason to the HW rfkill state")
-       prev = !!(rfkill->state & RFKILL_BLOCK_HW);
-       if (blocked)
+       prev = !!(rfkill->hard_block_reasons & reason);
+       if (blocked) {
                rfkill->state |= RFKILL_BLOCK_HW;

i maybe need to find history to try to understand current logic if it is
right.
> johannes


