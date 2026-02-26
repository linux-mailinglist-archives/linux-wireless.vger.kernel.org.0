Return-Path: <linux-wireless+bounces-32192-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBduACy3n2mKdQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32192-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 03:59:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 558811A0436
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 03:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2DF23031E95
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 02:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FB4378822;
	Thu, 26 Feb 2026 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c+cfxvUj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kW05zPK0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E8372B3D
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772074793; cv=none; b=I5xZuy5GGGZrfdnvbmcIbebCSBHrDtgUbtqbjFxapsS2JDiOAaKP6nlu2sOmTS9Qfcvc/Firv8wvZZuJDhIRfWV0Wh8/aZ+VcWk250enyneuGp1S+no0kWGKaBT9G6toQ/ffhPiTOS1clVlLc82qt7xE63tM4P/M3ZpTVi8iynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772074793; c=relaxed/simple;
	bh=0JIOtyy8nuQvTZEf7WVudvEtqBb98NrwUyHEfqzdPCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mOCVUJlFa652yZQ54T3kfbU3MinAGu89A2xz0NTjlqeoODOpTsExDs+aoTJ5GLOUWqO38YEwL4eJUGyxa6UBK6VESQdT+ZqFMOxRcVcZPSoGrm9SzoOcH7kYUViIpnc9sq8gUfk/dgV5RtlK1868udnS78boIkX8hdLK1g3mtt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c+cfxvUj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kW05zPK0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PGkG6Z3632307
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 02:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ApDYTBYwmae7TLEHX3umlqwjGpIiVGPq8syu79mqRSw=; b=c+cfxvUjmGc2Xg6S
	ybaysQ/QD0bOWY1YE5ov2x2pDpFn+VFzygFfTmPUz+izyre0zPNX/A/zhEKGqt4u
	Hb8C+eFCNh1HIwFTLdHkgn464hxjDyH1uzppB6Tx4JQweMJAjqDRWbPY4Gh+3xbR
	wpkWgiJm5RNQEZ3kQzeDoWzq/xvyfFQ7C5xovkv2sXWkQLJBsJz2ElY7sE2d5wzM
	YdM7v/ipjb/FD+2/NPsQXlBHJBwJL7A5NxPlxfRg/PpsNp9XLO8+UEbvV8/cKFqm
	hWT9gi0dG2GSfnOTs4yhjErUwRHkb2WCwOqT7lqmgk53nydlmUYhaNzUZht4NMc7
	v0Oscw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj4w4sky2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 02:59:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358f4ed4eceso261292a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 18:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772074790; x=1772679590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ApDYTBYwmae7TLEHX3umlqwjGpIiVGPq8syu79mqRSw=;
        b=kW05zPK0gR9qSKbL7s10YXW+O9oaaESa7/UGTQXyM7yqnQ4/1a9WC94KKHbwN22dZQ
         4QLLtP04MOvNLnAhs1oA7aXsvaX9euRUtYNvFomW8IYUEg30LMjT+sayBUHCInnXuVE9
         PxUwYNGAGq2dwEdQpAwU23hnGUr9m3cpCLfBaWFacHiAOwhXrfyHmehdfejJLkN6+MzH
         A8UX1XjBRn086SX8Eq1WicXTEntu4ggkjCGCIO/Axbe5sgsHgvDKddLwOPt9/yQzGee6
         4rrCXV3NODxCDixFmbaFCGzhun3PQ5N+2qI7YDFH9douD9zXqpZgn1sTQCErp0qlr0vU
         D+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772074790; x=1772679590;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApDYTBYwmae7TLEHX3umlqwjGpIiVGPq8syu79mqRSw=;
        b=h/ia7kWeKE14X4hs/UdYo23t1WigtoDbVZx/zNUT8KnMbA3/GdjxcWGiOnrsIvXNfv
         LSjSJeyn5WnrIUS9IdpgaXX09Nn5BqxNKq2Teva0u67LgoQrghupaozfLrx8xmB3JzRv
         WNEPlm6RX+QA8CQgvZdLm0MvhSTdNzP0jaucrJnUb+IZjOHzhOva/l406jR3BH7Aro0p
         HnbAxx/fKJZAsicGiqDUcfPelPNOQsq/Pi8cozqbjhw9Go71RRVCOFsZ8GpVwBs9DRhq
         DhCwsMedxyTAe5Q6fZLd34d6Sos9Rn69Ux/sdVE4h/nEgA5VFg1ANFwRabYyUutr6cfx
         ajeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0T3C61E9s3SA7VDdF7OvwIevA7kFB1w1cHCijBh8k04eISt41LwXzxsiGi65qWflolH/+hBcYKSqDuQaQpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEn/DmnuApi9bJtoOJRZPKCpOQTimKXP2d2A+PxkCl8Y9zeDt
	xPomyxblsMn8y3x7pGdYQYNvo1dhdQnmrAH54r0l8VLXZEObwmxiontzlieMYm6PrG3pK4TCLwY
	jujM+iQuPOP0huGR6cc+Rv5NvZvtqS+NZewTq7s2GtSsPHWMrZ1I+1zy2nbe3rjJArAfpkg==
X-Gm-Gg: ATEYQzxUeV59YUEOnvNKixfTG5epUzNMa0dLSZ+NHcjF60/u9QSz+r8ereWjOWco0Xz
	QBnWKCukwvAjnzBx+TPzWkpekvlG0JoJVKezTprn20kOZY7h4+VACsjeLWFxZD3P2DD1rsUoEA6
	nraHR4BxkvRP4Rihk82rsMijbxY1BuxDr5bvtnjBSRaltil/MoKDBbrXeAL11CmIDH8RB3cehwn
	vAEUSvJmtYe8oIbGHeg1gXSg1xkSys1b5XG8/YCR9AaahsZ/fjgzcuWBTslALaYVnHcPrxad+LS
	iVvuTk3sKRgYL4f1AGh69xiUtS+RTjECFA4o5GpwPy716S3cOsKdbr6lWPgvJrKGsReIDP59fc2
	CE1V2oAvKiq5wSgUje3Z7KQ1T6yVzsmQa4RgjBa9nvx1eshaaTigTfkok4ToBrSOKTiBztSXsWu
	TpbtFSIDEijWsRUXj8DqM=
X-Received: by 2002:a17:90b:3504:b0:34c:aba2:dd95 with SMTP id 98e67ed59e1d1-3593dbf2afdmr811184a91.26.1772074789563;
        Wed, 25 Feb 2026 18:59:49 -0800 (PST)
X-Received: by 2002:a17:90b:3504:b0:34c:aba2:dd95 with SMTP id 98e67ed59e1d1-3593dbf2afdmr811166a91.26.1772074789068;
        Wed, 25 Feb 2026 18:59:49 -0800 (PST)
Received: from [10.133.33.106] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dda5ec8sm443651a91.12.2026.02.25.18.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 18:59:48 -0800 (PST)
Message-ID: <8b468ad4-39e3-401f-a2f2-7484759137df@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 10:59:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] wifi: ath10k: only wait for response to SET_KEY
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        James Prestwood <prestwoj@gmail.com>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20260210021249.12132-1-mailingradian@gmail.com>
 <20260210021249.12132-3-mailingradian@gmail.com>
 <dd019903-f8d9-4bd3-a90d-b4d505f489f3@gmail.com>
 <3e1274fd-fe95-420c-94e3-ac34f497b7ae@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3e1274fd-fe95-420c-94e3-ac34f497b7ae@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rsRO-bp0W0ldjuZbc8CpAZhZLOue5_KX
X-Authority-Analysis: v=2.4 cv=IqMTsb/g c=1 sm=1 tr=0 ts=699fb726 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=JOXQ_UV0D9vJDna7EiIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAyNCBTYWx0ZWRfX7BX3q+m3la9y
 m1R/YT0Vl6rjkInlQho8dYD1DaWHkSbEgAokNy2fQN1qZq4QSvbXrtgnHyI+H0D1js5XgyOi08E
 tN91kFTvfBHin32Ksj0kAhYRK5mR9gAE7Ije6f/oTnj6APii5Dg9/xylHht4yX2eG9vR5WZOs1K
 crcXJEbsLV0N3yAIL7H0n21i93EpI8Q1HJ6YfORiENG0Un5rwMm/nh6VDBZGaCI7k/FkBSjLJ60
 +Zxt8t8jm48svB/KoH41EUTpR6+uKslB30aUZw82UZuuoy4dkphUx4uZ9pRl0kFFm7pruF3PVUy
 ufMAm/qkfDX24UjJlkQ8GHRRohXqfMZjepzA0VJydeirFgAPrsJSbnjW046VuXplc3OzsndmRgH
 fTEmZPp6Isgn1xWdWFWxbNBtSpI51E/nhByTguwZsPXto8iXyvIk70ZRhRwe21grsBacdeTbdje
 PpD97FgFXMf9QXkIEIw==
X-Proofpoint-GUID: rsRO-bp0W0ldjuZbc8CpAZhZLOue5_KX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260024
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32192-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 558811A0436
X-Rspamd-Action: no action



On 2/13/2026 1:56 AM, Jeff Johnson wrote:
> On 2/11/2026 6:11 PM, James Prestwood wrote:
>> On 2/9/26 6:12 PM, Richard Acayan wrote:
>>> When sending DELETE_KEY, the driver times out waiting for a response
>>> that doesn't come. Only wait for a response when sending SET_KEY.
>>
>> We've run into the exact same thing on the QCA6174 and have been 
>> carrying an identical patch to this for at least a year.
>>
>> https://lore.kernel.org/linux-wireless/b2838a23-ea30-4dee-b513-f5471d486af2@gmail.com/
> 
> Baochen,
> Were we ever able to reproduce this?

unfortunately no

> Do we normally always get a response to DELETE_KEY but in some instances it
> comes very late (or not at all)?

In my tests, I never hit this issue so seems can always get a response.

> If we remove the wait, is there any concern that a late arriving DELETE_KEY
> response might be processed as a response to a subsequent SET_KEY command?

I would suggest not to remove the wait, but instead reduce the timeout to like 1s, just
like the patch "[RFC 0/1] wifi: ath10k: improvement on key removal failure".

> 
> /jeff


