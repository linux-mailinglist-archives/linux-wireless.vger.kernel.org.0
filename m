Return-Path: <linux-wireless+bounces-37258-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J/WInKBHWpZbQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37258-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 14:56:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF90E61FA49
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 14:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482473029ADC
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B478287E;
	Mon,  1 Jun 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VvxLvE3O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ocra9Rth"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45561A683D
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318180; cv=none; b=rmp4AI3zM/hShFdh8ty0VtfOLAESgR9p89kOlea4ufFb9TiouW2TGHKi+jjOP0zegmfviwY3WlbuTZ9FkX5pTzmMxee2HV45/l9w2wsx9l+434IfHIA6X+91MpFR3pfZJ4I1FGymbQ+VqcpcKXfGN/I8eMrSDzeA9miwPMWKaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318180; c=relaxed/simple;
	bh=Gx7Bra8TaTs3dAQpGbWwRfOF31yAZI8wp7GYqg8Sslk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCYgJkXtc+zIPv84eVH9ed+Z0HWh99/72iu5XzR/2ZQE/Q2SO+J6hLHp+gSuLLOGBOfsWPFwQT9dTKFj/AM/NJGuotgQDCW5Q+1mIvGf1DRcGIE6vYG4wsUSFH2HoO5EFxqDFyqACvHSs2CggN+eLaoBM8FAuxpGBav8ATSq5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VvxLvE3O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ocra9Rth; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518f7nM2740397
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 12:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FMiK8OgpXNqn+pLMaKARtdgsOHhiw9538/Yziz0a0G0=; b=VvxLvE3OSRAoZ/lI
	NEIdxNLsDjKcXNRqxsMZHWtPKMRXlgmqwkaP5muTTDCkTFbP7XbqcwUa8zaPFBPV
	Hv7IP/XE3wbHrsyuysTo8sNFC9BDIDghn3A2yJMDfo04dZYzekHMQ+9Avrv+/IfJ
	J8BuRTDq6MXjtZaa6ypSSZpMTbdz0idoDkGAow0uNpIAOLHfY47KiydHH2d3240s
	LYI2u5mC/gnVgmj/cspJe/dOt9M0cccy+6RtmaFGqiLIOAVZvo84hV8MAl1IeBEq
	AVEE6jjyd46137OJsq0n5/3nkPra6yzfvgXsQEn6+LLBKmGT1xMzb0X5w7X3Jy0w
	Mmm76A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sqh0bp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 12:49:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84240b58211so1048587b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780318178; x=1780922978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMiK8OgpXNqn+pLMaKARtdgsOHhiw9538/Yziz0a0G0=;
        b=Ocra9Rtheiq8M00zVITX0/vSmUd+lAVeXqT239ihpBxgJBS5eM3YcItyYAdgqcp/WH
         6R7nB0coHJxQ2DJRSzbqM5HCQoS/lqTpw25DBpRUXDQv4FsmMbkj+Ta/1SgBMxQZ2f0+
         psZMMMW5ppLo8GDQkya/PYGjSMeNhmB4yGlO+T/pyMCIyo8tsGW6gVZljApdbdISK6oQ
         BwncnK4SgVQiPekH7+PZFtr0YST0z0US3XMm/YhX1wdVPGmfdWAM3BdcuQLL8v4MFlWw
         vyQPjlR9nG1fy1iitrBTj1MDy9c/mngRgUjqLQAK7Bx3OCb+LNVVkLAPgCOmRLGgJlr4
         6/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318178; x=1780922978;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMiK8OgpXNqn+pLMaKARtdgsOHhiw9538/Yziz0a0G0=;
        b=HVtQ7a0IJryumrxrr1o1bMZY1rNNdD1V18WzaS8XX3kaq/V3ZptcqVcXDCYqEWkxJt
         2hwRlYJRjgDRMr0NN0jQurE86QqrZI5tYRriT9hmZ8dinbUjLuJ21ahKyEJuAVG/HlhJ
         qoEo6yZVj0OLWX7h4Z/WVv5XO8ceTnHaevHC3Aq+fqEZHF3VNdmA+XnTmfPr2w2jR3Jr
         MaFp4wRRHJAH1fGRxql9S9v/gO8UQpGO3Gq85xpzofy4CzRCYEYvv1n8okDGjeJbZe+s
         h/+DCesPP5L2m7zYYp4K23pNG2Lh2/9u13hYeW67dFKRyaKcN8w52Nofh5XP8P5NxIT3
         tDEA==
X-Gm-Message-State: AOJu0YwQOCMBwAysfg8kYH2FDpHmc/WeduxZaOPRrtCHEMUGvcy4HjAD
	ZEDcoo0vgO+p0V4E/vSLZygkwvyX0mPnncE9TSPh18lUPOPvlRVhI6MnzSDBu6Dl4I+1qelV4uM
	KQ8+YCgHqDYoV165uxibSrr1IXWmbYe7NdTUjo2lm/wWTYKYu3Rzvx9b6LvopBnqmt4yrLQ==
X-Gm-Gg: Acq92OHBGdxV62zAycEB2h1O3mDJ0tgBU8nsKJF5eSg3VaSeDfAqfxUYmO0o3qEnQ9E
	EadUsK4+6mhwuLky6LMqmWHnnjOGGI2NTlEbJdwRo1DB0Rpg5SC3vD2Bfj/E1q7a4iC666n1bX6
	ZCXKjRtse9c2kpiH65Kz0a3RLhPrwD0j0l3sDUI868yf+hrd+u30OUVtlh2Pzm1+7lfVVkkPiqC
	/zXfvUlqCKarAj/5wh+m1he6MCAIkMX5+xLl3p/ERiAGX6Uwcb0xLicm767+ZhPFhjOWscVdiIX
	7vCHaI7mMDGKtrc73v1v30zGcsZlEsmlNnmSJGOEg5Bv049AqnLWFk19FVPU8ek0J/cpWkluTZ0
	0oa0ea7SstqyJXEIdr1SPLOD26xdsjKPEOodNoQS9L+2Kb66o7ZoX3pMqRROAviW6syphlwvhI8
	Rq
X-Received: by 2002:aa7:9313:0:b0:82d:62ed:b01d with SMTP id d2e1a72fcca58-842255d2908mr9910389b3a.45.1780318178224;
        Mon, 01 Jun 2026 05:49:38 -0700 (PDT)
X-Received: by 2002:aa7:9313:0:b0:82d:62ed:b01d with SMTP id d2e1a72fcca58-842255d2908mr9910361b3a.45.1780318177740;
        Mon, 01 Jun 2026 05:49:37 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423aeff467sm5590616b3a.25.2026.06.01.05.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 05:49:37 -0700 (PDT)
Message-ID: <11cc2fb6-e717-4f1e-8a9c-62e21e82ad00@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 18:19:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: add hardware parameters for
 maximum supported clients
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260515030909.3312511-1-aaradhana.sahu@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515030909.3312511-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nEbtn7eazMR5yt45nBXYx_nYxhyRNzjn
X-Proofpoint-GUID: nEbtn7eazMR5yt45nBXYx_nYxhyRNzjn
X-Authority-Analysis: v=2.4 cv=eqnvCIpX c=1 sm=1 tr=0 ts=6a1d7fe2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=MKq5ULF0EFEncfcVwOQA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyOCBTYWx0ZWRfX6fUjORMzNYoV
 AUYcB2IOXUTXtU4xHb/XaXfez3hpIW6+j/fTr27UkfXYa4vsQLm8HlnUVOGN3QFbIZCRScoGxbX
 PIHiO8irLQOsoAb7f9VZrBfjrZQOB9fK6GO7Fy6r/Kpoub/rpTUAAT7n6kFXq8Cinljcdj7TjbJ
 UzA0RKBnbj+FaXNsHVNekUE7erz8gp/bkX2r0LuNi6mrs6p2m5w6hOo2haYyP/AYC+6eG07iSxA
 8haWRyUGfk+OxWm3jFm1mGFKaHRrSDOosif7jRgw4ehskvcbTMBYCpUD3Yy9DjStUcUF79g7UcJ
 6ol269doi+jtvQzaEGciuc1V+9KuauE6qMMVZWdgtm6lK/r6ujWSFBsCvZh5eJo1XOYANaOu+bG
 5Bgm1PkiKFn/1mGtvpHXYg2OKxkmFo7uyNVHccbF+EICMpx1JoE3jTpxV8UBs9nQ+DS7gHPoONY
 +JpKDhXnqYA00Dvx3iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010128
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37258-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DF90E61FA49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/2026 8:39 AM, Aaradhana Sahu wrote:
> Currently, the driver uses memory profile parameters to determine the
> maximum number of supported clients, with a default limit of 512 for
> single-radio and 128 for DBS and DBS+SBS configurations. However,
> some devices have lower hardware limits depending on the radio
> configuration. Exceeding these hardware-specific limits can lead to
> firmware crashes.
> 
> Add hardware parameters in ath12k_hw_params to define the maximum supported
> clients for each radio configuration. The driver uses the minimum of the
> memory profile limit and the hardware capability limit to prevent exceeding
> hardware constraints.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com> 

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

