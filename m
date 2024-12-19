Return-Path: <linux-wireless+bounces-16599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D11999F7A92
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E93716AE1E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3C223C7A;
	Thu, 19 Dec 2024 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C24S+QRr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F4C22371F
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608559; cv=none; b=kaMfkxOEYo78W+NgKyz45seeCC/WLROEXyw37ybY/757u53vFvOExiRe1OBn1qDFDN5mhb7LxdAWzMv+nFEakL0lY9r2HM6tpwmvRXl9xk+0vk3/TxB5xkEc6Vtc/lERqd4h7lOAcbZp1sY4qehzZffQapFALAnl+zsNc/H+MR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608559; c=relaxed/simple;
	bh=WXC4jRXWQASyWWQqyHdPGe34+cCn8qcYcZypzLgjSzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bdwUA/DjtJdTVS2I3mmhrUJec2cXYkIKkUaft0RlvKzB1hd9TiQKrrGwFoXl21TPXbb205nPdPIyUEg4YEb5UOWPbJIriJ0Zr1g8Kmht0MUxiqkDYi2ZHgKQig0NAqZYigPDbvkd7cGr4vda3OIUa5rLKAM5pVsAZr/zgBHq2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C24S+QRr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJBWH1c026543;
	Thu, 19 Dec 2024 11:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y5YC7ebuc+lMCHIQ3VM/pOuoAPe7RMBg+cimf6JfoqM=; b=C24S+QRrTcUB85Pk
	Xv7IEhgFrQM/KzXLBbizOe8VdkBozD0t3vzFs6tZHwDb8UwPMNlIiRUjZzAzvjzN
	NPgj6JQEM6XejotphYIvXB3o97FWBFZNQ8yEk1mHLqrXubcsoRl6gi42yDQO+hzA
	mAgrYTlz8qN0URKDxXPuvVbYPP67UlUdrAwL6gek8v6J33PSEa1Hv8TOZfme88GE
	wIHBPv82ArJsfvZrtP79IJSCxvJ5QOKNTRMCvjED5SCt33JPB9fTW7EBpI7s15kp
	EnEwZZ0jwMtieorJheFbCgrdUSnLPOBo+EPcUP7LWiTO6IMey9lrFsh3BdaDpbZG
	nQZIdQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mjpyg0vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 11:42:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJBgVLY026358
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 11:42:31 GMT
Received: from [10.50.7.133] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Dec
 2024 03:42:29 -0800
Message-ID: <44bfd319-caf2-7459-f62e-0f61de452a84@quicinc.com>
Date: Thu, 19 Dec 2024 17:12:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] wifi: ath12k: Refactor Rx status TLV parsing
 procedure argument
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
 <20241219001006.1036495-4-quic_periyasa@quicinc.com>
 <87seqjj48p.fsf@kernel.org>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87seqjj48p.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Qu8LiXJff3jP9HYXRy6iQt9AgyacvOUd
X-Proofpoint-GUID: Qu8LiXJff3jP9HYXRy6iQt9AgyacvOUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=360 adultscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190093



On 12/19/2024 5:04 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
> 
>> Currently, ath12k_dp_mon_rx_parse_status_tlv() takes the TLV tag, TLV data
>> and TLV userid as separate arguments from the caller. These argument can
>> be fetched from the TLV header itself. Therefore, pass the TLV header and
>> retrieve the necessary fields from the header instead of passing them from
>> the caller.
> 
> The commit message doesn't reply to "why?". Is there a clear benefit in
> the future or are you just doing random code cleanup?
> 

It benefit in the future for supporting EHT monitor functionality.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

