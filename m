Return-Path: <linux-wireless+bounces-15465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA59D14C3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 16:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE9D1F237E4
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B321DFFB;
	Mon, 18 Nov 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ozwjawsd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE013D251
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945173; cv=none; b=f0WuugtfsGYppecNMSFJ/SnyXsNXgnnSS3vKfuYg0qgzZ0Iif4GHUqcpOOkCwSJ/x3cC8/LUib+X8M/Yo/f1oQysN8j5RxVmJ0BsBzvjOxaiGVjaDYt3C2WFQCRNSgHSfaitIe8dzPjGJe5cAenLEteAgssu80C3y4AlQUDz8og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945173; c=relaxed/simple;
	bh=2OuFl0bUVPgcyFU+iqutdgB1eEqfurnmLZmnFJGiJuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=HkH8h/nVVralvQSzodAiaSZOBlaDEYt+cD7LSPe8EJPXVniW+EnX+pJB7xGmnrxC91HTnJP6Yt6RWSJVbG0mZgMeLYXYiWamTeGzJWo1SoZOYxqnNLjNC1TmVhZV6wznF4Nk2S1wJimP5B5KT4ge3tIDkCknkbOvwuzaOK3ff6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ozwjawsd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIECvcj004229;
	Mon, 18 Nov 2024 15:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t7ZSWrSrcg5o61XWcz8hWD8eaRzY8YGThlUqTefC6aU=; b=ozwjawsdpU2wVwYP
	O/IKlnVXmrM+rPqTaBeEUSijFAtgv7OjBqrzIXRZnKzS6/4NmkT/2acw0jNQSyh/
	1OuFoKg3KYhI95LXUnZDNMkuVNK3KF/d+ErmfvAmSy4aYmV/W0GxzbsTzeWu62On
	C0ksnL7PEuye5x0LzZuAkS/DTV027O6OoNIFX7AJo82ZhnO1Z2uDFQIygv4F0iws
	ZXqPdwtrqZZZpoNKpe077AAXDVkUoRO5XngVry7y+6chSBH63W4Ye8Ad0zbVzRfQ
	bhZV4kmZkqtvK7ustdq5S4/86GG0VcL8pu3addgtGhEVIxGSSthHuYbGAzz6sKRV
	7ZnnJg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xm5g5343-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 15:52:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AIFqhtP024988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 15:52:43 GMT
Received: from [10.111.176.82] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 07:52:43 -0800
Message-ID: <6b9c0664-f58a-4978-a371-741c6e6eb133@quicinc.com>
Date: Mon, 18 Nov 2024 07:52:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] [PATCH 00/13] ath1{1,2}k: support multiple PCI devices in
 one system
To: Mihai Moldovan <ionic@ionic.de>, <ath11k@lists.infradead.org>
References: <cover.1731858971.git.ionic@ionic.de>
 <4c5a9c95-13a3-440a-9947-a11209876c0b@ionic.de>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: linux-wireless <linux-wireless@vger.kernel.org>
In-Reply-To: <4c5a9c95-13a3-440a-9947-a11209876c0b@ionic.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hwWyFJ6YAI5nTb7wKLYHYGciDitBxP15
X-Proofpoint-ORIG-GUID: hwWyFJ6YAI5nTb7wKLYHYGciDitBxP15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=706 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411180132

On 11/17/2024 8:59 AM, Mihai Moldovan wrote:
> Just some spelling fixes I'll stage for a v2, since mistakes naturally only 
> become obvious after reading what was sent out...
> 
> 
> * On 11/17/24 17:05, Mihai Moldovan wrote:
>> [...]
>> socket and bound to for client sockets, which will automatically filter
>> messages from other endpoints and also make sure that messages clients
>> send are routed to the correct endpoint.
> 
> [...] and also make sure that client messages are routed to the correct endpoint.
> 
> 
>> [...]
>> and additionally new API is introduced so that other parts in the kernel
>> can either get an endpoint ID for given endpoint-specific data or even
>> register endpoint-specific with a new endpoint ID that is generated by
>> the QRTR driver. [...]
> 
> [...] or even attach endpoint-specific data to a new endpoint ID generated by 
> the QRTR driver.
> 
> 
> 
> Mihai

When you post v2, please use scripts/get_maintainer.pl to identify all of the
maintainers and mailing lists that should be notified of this RFC.

I suspect you won't get much feedback without doing so.

/jeff

