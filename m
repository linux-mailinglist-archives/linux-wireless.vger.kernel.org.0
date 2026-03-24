Return-Path: <linux-wireless+bounces-33790-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGnUJxP+wmlXngQAu9opvQ
	(envelope-from <linux-wireless+bounces-33790-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 22:11:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2506531CB66
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 22:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B0B4302D5C5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 21:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD98355F39;
	Tue, 24 Mar 2026 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MSyNag0V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvd6BazR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BD2E06EA
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386549; cv=none; b=JP3jdPSW2u7o4diVWOcC9XJNNiKrRVJ8Gm2W8FF/NHUoc6ap6TNpvmeSWkfVZch29C6gkpouIWQy9qntJf5ZHlUd5rgYI1dKjsoXm8TEs4juVk3RzFBDQh3jI74lIeoQ+O6FGMQw7BSdM3UJTaUJ0TVrZQFlVieGqW2o0KioOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386549; c=relaxed/simple;
	bh=oio7+2TSpehHP+cy7VaK+z1BN8iuje8iTeHZshwifIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeUYRH/ooZSSIdwyskkGdjBgplELRBZ+nLwDONtb/wu/pc9s9S5ENSjA+2BMpWt8JCGWd/o0g6hiWHm98jUPBRmep+ZF4so3hhABUwp88IRVpc+DnHlhmgma/opVuKZ0sr7LV1gxhhqPvcqQbbmA79DHryZ5ElSoGgKZXUTkTRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MSyNag0V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvd6BazR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJObpT1862775
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 21:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Eo/xLhqTxGStSv2EPTSDhQLs
	jCktVhIs4u9mvMOHYwk=; b=MSyNag0V4AijtRz+rydzkPWOCINL9DbJykc6w3Nn
	QIwlmMePIjqbYRGubStG6C0Di5l2eO8U+0Mm9IE/fr6G6Y6s8KRWzcBCLqKdXMyO
	3vI4WMXqAqlpSsC3eAByoEWMTPqSERjU3irvcKfLBg9wraFdViye8rYPBylnjjsY
	DM7TkOaE+WPLJfRbXSO8kVopkVdf2YTL3k5xqSdxwuePII2sa65YSylBVixqyHYJ
	vIGumc0ULLYSjj6+12ph7mDzoToJFmJ38KYKSa/6tZr1KueRNdd3CMybZF91UzIP
	EekeOVWViPSM+QTZdkuonfcPoNgUVOx8VCaOvcJY5gW5eQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40rar960-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 21:09:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b4b81c632so63506181cf.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774386547; x=1774991347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo/xLhqTxGStSv2EPTSDhQLsjCktVhIs4u9mvMOHYwk=;
        b=kvd6BazRxUoP/uz2TmQlWyuweU4vdDJDgWd5lAhkSlUubzaLYIEqPyMu8iaPbE2N6e
         xSvanvlk+KqXTHQrjGY/Id2JbNJgehJdqPeadrSE0nyyr1OQFYvref7WxVWziRnRhtHK
         H+XlbpkhSso5cBqNpFBpvCQXHOahB+sWF1CCKPGeaSYHYs6CQutQjZlowtr4YxH6s+Df
         2k3ewz9C4Kudw1j1arghMe2WSRqn75XE0iNopX8d7qBEYb6QYJOyJHsPYX4XCj9FeVXO
         pqkP7fnFHWKMjckkC5ufo9e+F7pMws1OQLjLLbNZfKfgGogrn+u5JGXEOhxV2MZTCSPd
         BjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774386547; x=1774991347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eo/xLhqTxGStSv2EPTSDhQLsjCktVhIs4u9mvMOHYwk=;
        b=Ma+5IfH/gLwPBxvAi4HcteVIbPk3vj6mjORxhXXyc+ThDvHhTVdOuvoT4/iG9wMmdd
         pNXU1n7wdrCOF0cMl32Hqt4BNGtKE8qkXtOBDZWPRlWXH4gESesbQfUEoMa7bIEeCIvq
         DvUOXrgi7SyprSjPFgRut6RxnU0xzumA6KmA9H1XB38/Kx4ImMrsNa9M27HWA6EnZzxg
         eZcGbcJJhq2ZH7X8QMuSRl0w1xQ+6cfz4tFYSw7+mrD8eLi8WzRDYU+uzXmqwFpZ1l0t
         AhuUWmvSf5n8NeR+/gA8EbgXCwsBnC/5duMeaNCV8XlfvUSaCd0gW85BCMffvG3/Ydhr
         0+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWX4f8Z+LheGD+SS5xqqfRjp2xcqvw2X2iqrTQBYPMxmGiVrreymlfBVlnNnti5GCLorg+McFgGPtjN5nSonQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4t4tM+JmFNUuohSlu6R9IcPGCBwnHzuE4skdGln3OzkcRt/uJ
	SNfRPQSRbmTSp8n/4ZGO/dY1c7CELb6tLphnLKwbqI/c7OodpGve5c397Z/qnSaRCzbCYnTYU0t
	Mc/3il02Ng60gRKAOcvLT7nUz7SDm7GjzZmia7NGSb1wPFEUZ118kwU/N8U31+R5VwBInXg==
X-Gm-Gg: ATEYQzzitLwR3iC1tD2an2QI3F3XgxnaD3n3HSt46oQoOY4FW5z/H+aXF+NfIdXDvhy
	EHfPyeXm/SIYIMtsAHOvK/+z8JegPiLuQ9y6xx7qV/7V7HLi/pm8llc7oCfG93slUNiZIxRxKRW
	WLLee72fBuD1z3ttXDdSzwAHrjtVFrT3PV6/OCjYxnuTRAiQZc7GHT/XbfshJGcsgmyrh6fZTnJ
	QAw51ZOmMqPuZMjYB1zD85UYRVF4j76whqEpBqO4h4SQF6u+QQharA3sgU0faXYg89U213UZc22
	7ZReBhZBHlAp5wyb6T1bi8qc3VJb+gLwk6THlEFBuLQ6TySffto8KhNEW5AgNSjxXxZ93QktC8d
	wQIv2Ce107LibP3w+Jn1BkdENbD7DSFK8rXC71JGeOdAJvTuMi2twLQx1SQxBPRkzYIvD/IgCNb
	NflR13qmnmNQSbu2GbwGwlDOZcbGJjISw/Yro=
X-Received: by 2002:ac8:7dce:0:b0:509:1766:2f45 with SMTP id d75a77b69052e-50b80e563demr18810121cf.51.1774386546873;
        Tue, 24 Mar 2026 14:09:06 -0700 (PDT)
X-Received: by 2002:ac8:7dce:0:b0:509:1766:2f45 with SMTP id d75a77b69052e-50b80e563demr18808641cf.51.1774386545042;
        Tue, 24 Mar 2026 14:09:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a288268a0bsm3166444e87.14.2026.03.24.14.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 14:09:03 -0700 (PDT)
Date: Tue, 24 Mar 2026 23:09:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 0/3] ath10k: Introduce a devicetree quirk to skip host
 cap QMI requests
Message-ID: <qjqw4jpvgwzi2kd6xsgewow7azyjoxqm77sn62iipbonuffeep@fs5ra765krhv>
References: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
 <2b34ceae-5e31-4dba-93e5-3fa35754fab6@oss.qualcomm.com>
 <ttka4uevai7tzf4c3r7rgozzpd3hsdhjzf5uyysfzj24ex2o2v@r64z6pvxb6sv>
 <6a3448cf-dd18-4b3d-a8fa-fe282ee779de@ixit.cz>
 <b7gibtoind5srjk6ncybnen3ikdvwnktg4epyzbltg7alipmex@k5zzpbnmzlso>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7gibtoind5srjk6ncybnen3ikdvwnktg4epyzbltg7alipmex@k5zzpbnmzlso>
X-Authority-Analysis: v=2.4 cv=Jvr8bc4C c=1 sm=1 tr=0 ts=69c2fd73 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=mwY33ePZmbrgUz7sd2cA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: oKsk7HL7tvZj2zTIO5V1_wpL3_YD0OZd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MyBTYWx0ZWRfX96sROcCWJ+ou
 iQp9/Af4rhlupnYmBsLpe/ApKjhFIUEqgB+wCDtnsSTezMJdkBU5OWZNoCnYfJZENPH/FKko3mL
 wj9CLYHT16XkUfWyzDTkIj4hKrnncvFQHXq5uYXVnDLSSjy9x0/HoLEWaXLZ4s8aP7Vz6embO8z
 iLDsesPpaw4WqCpRUdpFME3tVpF042ZygxUOcxJwlfUjYhjPdkGAU7K9KH9/XSx+sFEKFy9wuXV
 VzF0q75d2IBESwVb0AqXVaadst6mTFhMJjCFlRZeqO8KBrMgFmHAkLZSJW4ZA4zoD/NrfnxTDSa
 3MW44M12Rhle2SZtX81f2PsG/LJnaJ6dSBW4Nmki+YvdZm5c2lNzuX0qYBS87kc40qkcxos2Hm0
 YZZSmdQCFSO7Z2o5IG6aX46jNVLNarAM0yyAYbN0ecuYjodTlVHjYEYqzIekUdTKPjQcZ5WKuMk
 YItsl3bFJiXaH1IUjUw==
X-Proofpoint-GUID: oKsk7HL7tvZj2zTIO5V1_wpL3_YD0OZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240163
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33790-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2506531CB66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Nov 25, 2025 at 04:42:15PM +0200, Dmitry Baryshkov wrote:
> On Tue, Nov 25, 2025 at 10:29:23AM +0100, David Heidelberg wrote:
> > On 10/11/2025 21:41, Dmitry Baryshkov wrote:
> > 
> > [...]
> > 
> > > I think this should go to the firmware-N file. SNOC platforms now allow
> > > per-platform firmware description files, so it's possible to describe
> > > quirks for the particular firmware file.
> > 
> > Since the approach to put it into the firmware failed due to early
> > initialization, see
> > https://lore.kernel.org/linux-wireless/20251111-xiaomi-beryllium-firmware-v1-0-836b9c51ad86@ixit.cz/
> 
> Is it required before we load the firmware? If so, it must be clearly
> explained in the commit messages. In the end, if it happens before
> firmware load, there is little you can do. That was the reason why
> qcom,no-msa-ready-indicator was implemented as a DT property.

David, gracious ping. Could you please describe your findings in the
commit messages and repost? Please explain that there is no other
sensible way to provide this information to the driver since this
happens before we load firmware-N.bin / board-M.bin).

-- 
With best wishes
Dmitry

