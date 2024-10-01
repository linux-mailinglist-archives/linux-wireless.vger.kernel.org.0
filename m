Return-Path: <linux-wireless+bounces-13365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B898B816
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 11:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F253282E76
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6BF156C4D;
	Tue,  1 Oct 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YKkNlIwJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED51C693
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774190; cv=none; b=gQfQ8AH/N5YLGeYOSOjcI1YOVIhR01r8P2on+cZ/JyZxwmJF13xxA7GE6bm1rayXgAzm7knlq/8B+IOY7d5/RkDhU2hkyRkpOEKWC+TUvT/EI8pbl52IAaiEUW5orWWbXOVy+Wm+ov9lvKCvDqR8cc/1/TIkWMprGsqeu864HBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774190; c=relaxed/simple;
	bh=JJsNupdkuJYAl9OvAqtW3yYJyWfTps9LlGYY7W+wsWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A022IAY+mrgQrywcu4ZVVy5xVMRROz0VPoyYusxa1Rn82X1KpmvADgySmGVULhY6Ufv7xDxVgG3PKEZCpLthTqQM86KApeCAJ5xGHzcVLNe79GP7i6pgO/8D5vkaF1GbWbVL2bhKeDfwjJvbHeG3fTmmipMFd7cG+VQP3mwefNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YKkNlIwJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UNxRUr015533;
	Tue, 1 Oct 2024 09:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/19Tyxgrt1SEVblNeRF8Z3P7nByNhKfHz19N+7mP6UE=; b=YKkNlIwJTszdi9VM
	MoxUrODTO+FuV+Tylz4dJjy2OuTKkRmwAyvuMUguyWOkYHT5m4eOn1YCPgKw9Zr1
	kqn7IwP9uw+HJzFk6+WQKKVeNKsjyDqCknDDeH2bXJQUs+TaYBEweCOQGKuN+zgd
	ujqDI5A6/0ASXr0tVpLTnbvI2nrFj3SVLwW1HNRviB+kEpElb42EePtDawXE4IbV
	91t8pxOBfBBbhPWkimeoZb0q7g/qU3T1eLR9dy7yn9lmhpiZbk8O6B8havEAPWs+
	TIEoS18h92SFuto9OeoucocErPugkaQohc8BSM0KJVOclk/SBqlCQqORYSl0PT4H
	pm4EEg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xaymfp4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 09:16:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4919GKSg013871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 09:16:20 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 02:16:18 -0700
Message-ID: <99b6c9aa-ec20-4385-bf6d-49f4c59276ad@quicinc.com>
Date: Tue, 1 Oct 2024 14:46:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: fix assigning channel in activate links
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20241001041518.2236297-1-quic_adisi@quicinc.com>
 <0353d31db76afbd5d9bb2e7d42246ae3c8e14044.camel@sipsolutions.net>
 <fd731cac-7182-4de3-afd4-0fc5892a9440@quicinc.com>
 <c103db90ed53a75cae10baba0ae52dae85bf1c3f.camel@sipsolutions.net>
 <5fe9fdf2-ae5c-4d15-a095-0203a814e4ba@quicinc.com>
 <16ad03533ab6aca65c3fe9db94ae53ad11fdb9d1.camel@sipsolutions.net>
 <39b73ddd-5478-4599-a92b-00b274d2ce02@quicinc.com>
 <d66a63e31e55249bc88faa5731abb2859fa2a940.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <d66a63e31e55249bc88faa5731abb2859fa2a940.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rNIGCmJBsCEHjGS0gPVK6BPYBcf7xvOV
X-Proofpoint-GUID: rNIGCmJBsCEHjGS0gPVK6BPYBcf7xvOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=848
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010060

On 10/1/24 13:58, Johannes Berg wrote:
> On Tue, 2024-10-01 at 13:56 +0530, Aditya Kumar Singh wrote:
>> Yes please that would be of great help. Let me send a next version
>> having the changes as discussed above and then you could pick that for
>> testing and let us know whether it is working as expected by Intel driver?
> 
> Sure. I suspect it'll work better if you do the ordering as you had
> described in the comment.

Sure, done and I have sent the next version. Do let us know if you face 
any issues.

> 
>> It would be better if other MLO based drivers could also test this? I
>> mean if possible they could also test and let us know if this breaks any
>> of their expectations! Or if not test, at least ack this change?
> 
> I guess they'll just have to speak up here too :)

:)


-- 
Aditya


