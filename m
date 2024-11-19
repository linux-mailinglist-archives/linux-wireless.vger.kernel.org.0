Return-Path: <linux-wireless+bounces-15500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9224D9D2227
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 10:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57603281DFF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD11925B3;
	Tue, 19 Nov 2024 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k0lhAKUY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091A12CDAE;
	Tue, 19 Nov 2024 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007297; cv=none; b=jEgd9NXxrF+QJsxzicIMJIPA8HfRL0FmE6nVBBcZO4l78vvGcTAgrv5PpESwwH5LtG6Anoog0h/SVrNymf3vq7a0bT/RFVolGvZMU+4us4cfEThFqUb4Y6XGeUGl9P7iOTJBt0cPzNrj/zF4vcFkeVAOUfwuj+xlOu5x4DaK4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007297; c=relaxed/simple;
	bh=zyp0FBBhS1CmIsQ+5S05zVbEtc0LE59r5jqk5h+utP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n41lWAq1l9UgdZROtl5yVJiOC31riGfJ03jpT3oYmJuSTX/RqieQGc3fplksj8tRdpEpZQoceeVJezUB1wRhVrciL7v0WjFai8wXw5O3aD8g9rMv5wv4Cmk6o8cJnwhF3a0Xvo+/kpmBrtHo7uUc1vvjaJlehzmivEqyehtX2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k0lhAKUY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ3XOcc017807;
	Tue, 19 Nov 2024 09:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LBTvq5
	FeQcEXe0HB2u4KxzCe+2KBG1BVObW72wTO6nM=; b=k0lhAKUYLfWeQR/iruaeBL
	sT36zBPtE39kDpzCoMu2DRWrobuiIG2L1eqFq1vXqJzf0/gb7CQUeh38WrcozwQQ
	M6aI6jMlHJCaBpCM59mOy+SuptIYsKXHs/f74IAk9ehsyjtLh/sF7deqktMlAIJe
	+zbQOtrpFF515rH+AD3k1XoCTptdYWW8NJqaUB5o6KYdnjPl1NrGA5yXVBD3rB2T
	mtbenxOouH3NvGd2NSkjUp7ehCNpmBq3MOvH39UJX0KKXLDC2JIuAVaSQn9YmTdg
	zxGjOYsVJO0DeEorU33F9dleyLdO/GqvIwIua5IMuZdsal2i1C5ib5w9TP5aIeTA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xjw7y4et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 09:07:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AJ8tcWY029951;
	Tue, 19 Nov 2024 09:07:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xjw7y4eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 09:07:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ92u4j030928;
	Tue, 19 Nov 2024 09:07:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y63ydxuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 09:07:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AJ97lj859834866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 09:07:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A31B20040;
	Tue, 19 Nov 2024 09:07:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC0A820049;
	Tue, 19 Nov 2024 09:07:46 +0000 (GMT)
Received: from [9.152.224.73] (unknown [9.152.224.73])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Nov 2024 09:07:46 +0000 (GMT)
Message-ID: <4b718b5b-8cf4-437b-b068-69e4fb729440@linux.ibm.com>
Date: Tue, 19 Nov 2024 10:07:46 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: reformat kdoc return statements
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        pablo@netfilter.org, linux@armlinux.org.uk, richardcochran@gmail.com,
        johannes@sipsolutions.net, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com, dsahern@kernel.org, hawk@kernel.org,
        ilias.apalodimas@linaro.org, jhs@mojatatu.com, jiri@resnulli.us,
        ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
        netfilter-devel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20241115163612.904906-1-kuba@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20241115163612.904906-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UjO_0PDyXYBIf731U8jF1w3Qb4A3iVRi
X-Proofpoint-ORIG-GUID: l2kWDXORmQCdCZd90FYMQrvCGk1mb_Hd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190064



On 15.11.24 17:36, Jakub Kicinski wrote:
> kernel-doc -Wall warns about missing Return: statement for non-void
> functions. We have a number of kdocs in our headers which are missing
> the colon, IOW they use
>  * Return some value
> or
>  * Returns some value
> 
> Having the colon makes some sense, it should help kdoc parser avoid
> false positives. So add them. This is mostly done with a sed script,
> and removing the unnecessary cases (mostly the comments which aren't
> kdoc).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> LMK if I should have split this into smaller chunks, I don't really
> expect much review here, TBH.
> ---
> CC: pablo@netfilter.org
> CC: linux@armlinux.org.uk
> CC: richardcochran@gmail.com
> CC: johannes@sipsolutions.net
> CC: loic.poulain@linaro.org
> CC: ryazanov.s.a@gmail.com
> CC: dsahern@kernel.org
> CC: wintera@linux.ibm.com
[...]
>  include/net/iucv/iucv.h            | 30 ++++++++++----------


Thank you Jakub.
For the iucv part:
Acked-by: Alexandra Winter <wintera@linux.ibm.com>

