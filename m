Return-Path: <linux-wireless+bounces-2792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94851842163
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A04B29655
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D78383AF;
	Tue, 30 Jan 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bR8S00wM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E070360AE
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610951; cv=none; b=L5qBJnHUm7zUTvrGGmM8T1CA+gCNRzpSSKFSXdWdO152SHvDHQT3zbaYe26nPNVHz0vhNXfdWMHWpjmtX+yEGVpvHrBVj6HyeyCJ80ARmDJo9QdJJjkqP5j8Ok2UbMy7o+mZAmxwtmQijMgGY/Fo6STr1soy892YoEintNL29xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610951; c=relaxed/simple;
	bh=lFeocY9Py8WhLSaeEXUuwoCN+RTZwrqPdJiirbsSIE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V6TPruHkpOQqBhy+ftkJG8zrpFGC/fzTMDQdq2Fe88irgRMg/AH7dmktGRIVHoqCNbqZ3L06lM/m4WNWiTXzlVK2d4+B28iD78c8qh3h16PI6qKWUcRfRPj4ZK4wFRbaycuKviotp5JiDlsxvzEJzwMZKPsRU73aV98EpZ5phsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bR8S00wM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9TY2M002506;
	Tue, 30 Jan 2024 10:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1aePI3LPjmq4zaHM2vR2zZeXM0TF+JKYpcViOoJxWRs=; b=bR
	8S00wM3FOxRnwonk16uFphZX71tWIZm8OOXEw7afkTt2G92iS1HNTrewPHkXRoTX
	JtIw32HdVDbWWW2D9+Nx00z6PA3S6N+deYw2IBxmb2o4FrB4P+96Vbk00c7I/ovH
	S2R/6KGnbsduseQMdl4+Nbhb5L7HfEBOCI6c6KfiOmx+VdpN1BLrKrQht+f5ctF1
	HKJOY6FjDBTmV3Af9A1yy5b3LFZ134f+G7xMm3XPsWN+lwqqRCheQhRUUYPOA1Lr
	p+idebggrbR9t8GwJwVEgpfAyVrZYP1hPfaG3P20Y1R2Q28i01gMFV4nX5wz2cA8
	3/deVeeWbnNMmjWfTJCg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxr2v0uqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 10:35:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UAZi5q001319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 10:35:44 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 02:35:42 -0800
Message-ID: <c3ce6010-5cd2-4693-a43c-c89947cdb047@quicinc.com>
Date: Tue, 30 Jan 2024 16:05:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] wifi: cfg80211: send link id in channel_switch ops
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
 <20240130043225.942202-2-quic_adisi@quicinc.com>
 <184a2907d637cd924160681b40f1caffa2fa1e92.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <184a2907d637cd924160681b40f1caffa2fa1e92.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ky5QtUzmt2_bSVdzyskH31MnfJpyRSXc
X-Proofpoint-ORIG-GUID: ky5QtUzmt2_bSVdzyskH31MnfJpyRSXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=627
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300077

On 1/30/24 15:43, Johannes Berg wrote:
> On Tue, 2024-01-30 at 10:02 +0530, Aditya Kumar Singh wrote:
>>
>> + * @link_id: defines the link on which channel switch is expected during
>> + *	     MLO. 0 in case of non-MLO.
> 
> please still use a tab (only) :)
> 
Now I get your point. I was using tab as much as possible and then 
spaces to align it to ':'. You are suggesting to just use tabs alone right?



