Return-Path: <linux-wireless+bounces-35205-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGCoAdB56GlCKwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35205-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 09:33:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9912F442F68
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 09:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8A74300C01C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 07:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA95370D69;
	Wed, 22 Apr 2026 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JN6QJcNP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hGAJezH9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BCB35C1B5
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843213; cv=none; b=V4BwqKxgemZI3Mj2/WCOFwZysySwGEsxs35GIm6I8xYlZZxh5eifUIggdrLf9nD1KjI5cV7jLi8jY8mWPhCyEWxjkU0UI1afMt6QucEen0UtR9r8pOmtpspfgmck727j7wQNkDFjZKWNPJ2ewW6C3CuJbYCrfCJzyCM9PZbrO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843213; c=relaxed/simple;
	bh=aosl6rV15/wreA5xMI1XS6wi+BXhDQdDzUmn7iC0RKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqzOb+xZF0ieET4OKlGMTImBxRdBFm9I3+ZoIIz9CPOp56xp3QoqKrmk3MPVF+mp/Je3KY3cUxiNicCOWFmj4uOpz6jz4rj8HEiNaDAwRZhm3y9XCrXLjg0eNTsgwA3pwMtm6Iyi4fq6y95AVbnZQ8f337YrIhS8liFX9Kz9vsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JN6QJcNP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hGAJezH9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5KLKx2000979
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 07:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tUHf8ulEiPw7CaBhxw+DUSr/H4AXtAj3Vn1bkVwKjM4=; b=JN6QJcNPFGSKj+78
	XiCWi1bqDNVZWHSqDBDU+yezOJy7lMxooxtOpdjBPbcvbzPtjKnxRXHypSFI28JO
	NhO7T/lfPRkFsJLXGbV7c/Gwk9Ojv3gZkg2Lpbyswsj/lsqFfBQ5sZz2+DgnMDw0
	CTSF31oADr+O6R4yxcMI22jPLelQ31jd0/P37ihhXRbPyG97p2naCEJhb7gKI58W
	p0+3bjGWVLGB7M5grKGV4ASsFfURrigZ83jo9PX820rw4IC62Dt+tvNrnAiAogPS
	p/QtCT4ljmTh+TiNA1sSPYgmzJSkRjnu2NOM1TdFzDx/RmiLpsgEkItePBBBduIw
	pxch9Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfab5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 07:33:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b4678c6171so56913805ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 00:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776843211; x=1777448011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUHf8ulEiPw7CaBhxw+DUSr/H4AXtAj3Vn1bkVwKjM4=;
        b=hGAJezH9ai/PTnkzSQXduPQTkoS2/ztWq5+eYps9ievTmD5m+wofK2/YzjOr0p71S4
         mxe0fCp3Pe2qvvefrDSRKyrCQWx1OFWh1KbQhIplFTpEPUq+LXZkxMli9RDXTJYQ0y4S
         8sjhn29LnXMb60ftuGyiRETlAA5dKb9chIQZHHQHLcQC4YP88jQVgwhKm5wbUyLDFPih
         xq487LWNjyX4XGrSOwFiI+OmVa7ecJsUcL/774zROZ5RqmhrxXv0H+O0vzbNg+8NH7IT
         LPv2MfDRuN9pRKnO6R8z8/E6Py4I5A9fhrU9OrgLANN8MlBd6SoRDBEggYhU5fd9+5MT
         n5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843211; x=1777448011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUHf8ulEiPw7CaBhxw+DUSr/H4AXtAj3Vn1bkVwKjM4=;
        b=Mtw1clqgyzpnQQPB6TIOe8MSZdBPkJx7a5AvsmycMPH3us67wtbROH6AaJi65CrIXh
         Ch04K3+fpRYwSpTiNfYyi3/3wUvrgmm8aGsT3ZjNtQSRQ92JQNmVdYja4lTfpYtGpyEE
         N+VobETEYOkG8x5pDss3ZC/xbIx+T5x32wQShs4Fv8i30Q7hYtDrnBLA4aKKXTErw+xx
         fdd+jdkZRXHjX45W+dn99uUMlTaJf1/CtuSUChiTaOTmBywkR9fDbiikJvpnfJvK5kUe
         Dadm0F9MbcoOe6MddwV6SZyCsUg7WFVuAxt1unSPqdlGGzSzhCYImh3XVkDdk7TTzi0W
         RtcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ANs4QODh7mpY5MpeNjza9/0Px2LfBq2PZET7f5y1NBfzkVMxj4dYok/jbIQtqbzZVXDbav3hUGk9oWn9Ozg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4FlfdKyNa9YmG0Qfjc/1hbBDGcqJzJUx0+7Hi9Tj/XVjiA0CN
	nHzV2SrsSwtxlAtZZNYRc2mOYiSZ6sMDq/m13AhEwu/AAntQk1p5CzoRlR4PqYnYP94F7XYH1zB
	mHzsk5+SFavZ2YHgMpMsrlRcvfQJAKsskikh00N/Q1YuAsNoEFyutoGKXtyk36ilSJxf9Vw==
X-Gm-Gg: AeBDievZiMxpRFZoVTJMMVZMOsFQUdOpUCx4KaW67C/C8TqWPH/8fbISuFHdrU+zHAb
	rdIUpM7QqePEEZ2Cw0A0YzLNG8RloOnQQT8Po+HdwrE6ZBh6Dgsohiy5ZFKwuR8QD/csyAexRX8
	JIDLC1VIh+pT8jG0G98lZU2g51BNSf7ERQ2RDmE4yijcHN2KzqcDeA2Pkiz0C0cpEl19K8UhCZV
	qA7Da7syOKV6I1ChIHMPPgVLNLf1GnKtVxmDx2jsvrs1yez2JgOAuJPZLwjK3MHsPKsTbov0b1U
	F4Skk5WDp/nRWLblcFf3503lwkCZFmlr0HjY33wlwjeERkjr6KnO6U7DcBL9EImMubdsY7gMiKZ
	vrZimMNn7ixTECrxrqa1OPzxQYh0YCJeZcKiiXe0IbqmJckCKN35epv/rOmPQEyzoNQOc6zHw
X-Received: by 2002:a17:903:3dad:b0:2b4:5dff:310f with SMTP id d9443c01a7336-2b5f9fcf868mr132251795ad.34.1776843210802;
        Wed, 22 Apr 2026 00:33:30 -0700 (PDT)
X-Received: by 2002:a17:903:3dad:b0:2b4:5dff:310f with SMTP id d9443c01a7336-2b5f9fcf868mr132251575ad.34.1776843210296;
        Wed, 22 Apr 2026 00:33:30 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff8d6sm148998515ad.1.2026.04.22.00.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:33:29 -0700 (PDT)
Message-ID: <48ec0ab3-96f7-449f-a1a5-d1e76a3cb139@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 13:03:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 ath-next] wifi: ath12k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATH12K WIRELESS DRIVER" <ath12k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260421213544.6238-1-rosenp@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260421213544.6238-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8fQJ7x1lTC6g4FSOYd3-ZwLN5vK6uhLi
X-Authority-Analysis: v=2.4 cv=fozsol4f c=1 sm=1 tr=0 ts=69e879cb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA3MCBTYWx0ZWRfXyo8XjVL+x2f+
 AfBauJ7J2xI6N9HGaglnBukACNTLCjbmcIHIMZ/GIkqdtifx+vL32mbkMYP1mcFb6+O1Dr9LaBw
 VBp23PCfv3XZW8cTavtqvaMnh54COAGsADnR4irxJXWkr09bTImME7NqFfGjSnce/auvy+71XP7
 IsjMXNTr0PVaCHf0+Mu2Ldp5sNwnupWAPXEuFcay+ou5TDF38ixBiHJ+06ovnsVWmnMxgt6RfvR
 RsNfGQWVmPRPRj3etOYe9q8q2iMWo2Q2u+YsjjvoLqp29FyrzGHCt73GNEBG4Hrx0uvoABqKeFc
 WSUQhSWMtYLljRhwkRiOloJqjBECKfHNnsuah5OH1k73H01sR4wpAhnH3sbZDOPT6t1HozmECYe
 lm4NG+nXHuqZBBNgiK2ElXe27dskJ7j2CB8k+ia7FX1H8ff/mUpG7s0785HQIHZ1ipb0t06F5hB
 NtDPavx4xRzl8e57Bow==
X-Proofpoint-GUID: 8fQJ7x1lTC6g4FSOYd3-ZwLN5vK6uhLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220070
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35205-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9912F442F68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/2026 3:05 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

