Return-Path: <linux-wireless+bounces-15013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D49BF531
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 19:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C9A1F22F76
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64168208234;
	Wed,  6 Nov 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Il0fUvoI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BB209671
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917420; cv=none; b=cuEAcCk+0d5CWuRmGX04E5dlkKOqGOLe9uB9e4RsyrJkA9MtaVbHqM5WdzqBglNi6Tv5JlRjhWWGQ1rj9kLYO2qqu4V9B+wnLc+UJVXN/kec7eqtPRs/Qe6My3GYoCuo0PaXAi/gS0yXE1MTAXx4LSNVfuZnKGXnRvBl4e304Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917420; c=relaxed/simple;
	bh=gDdlb+vzjoUW01wwH2yHozhAZfhQHVTY8eHyEfqp4Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lN9yngaJ/M9DIHYd0Bx7VTxccmKC2VG3n9VKc2EJOtr6LJLxv7KqyVPD3Ic3P7L2HJffJK1DDsdahxzBpVvReN736dqvx6NEP+3oycOjd1hAqDUKjcxyNiisi/b2GOIsrSLPmeafJpQCMJRz7Oagd1e1KhmUJxVaMQFAP1h08t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Il0fUvoI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Fqx9Q013161;
	Wed, 6 Nov 2024 18:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rOz51ybN174/NE4VmqTygjrL3+d/cxjHeOuIyEPAqt4=; b=Il0fUvoIGwYf8Sg7
	/rZgXUsXQBt/b/6vFRnfEkqzWo4bYbsivw1f9w+ApMtviPOBdibb5MPlUuVhUlWp
	9ka8gbVJs/uSpw0HuEc5HsDZVfr68o9j+CHN54mtmeAv4PXJTslxWXq7rzacjhA2
	outhJLqMNO/qo8c7ZLvjLO4JJZGFEUsd9RsIRq6kzW9eoeLyl8WOc9Luiz78FgVy
	3Z+pwc7m4kbMEVcaeDmSXCwPmBtOoEs/wyz4GKnzldBGhLht3K3Y+cq9sjFxM50+
	CESTh1m7pigB9pd+aP2R0wK1PLhtMCNdhBNSQrNAG2sM3VrnInlzK09FJCmWJV6o
	BZkLrA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qp2ruvt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 18:22:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6IMwst030379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 18:22:58 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 10:22:57 -0800
Message-ID: <5c6a887c-db74-44b4-9d8c-2e412f938b47@quicinc.com>
Date: Wed, 6 Nov 2024 10:22:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Kalle
 Valo <kvalo@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Loic Poulain
	<loic.poulain@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder
 Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean
 Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Chiu
	<chui-hao.chiu@mediatek.com>,
        Breno Leitao <leitao@debian.org>,
        "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
        <ath11k@lists.infradead.org>, <wcn36xx@lists.infradead.org>,
        <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20241106170706.38922-2-u.kleine-koenig@baylibre.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241106170706.38922-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T1aSXxpDUQsJs2sd2RbFf2FLmhPdtqyi
X-Proofpoint-ORIG-GUID: T1aSXxpDUQsJs2sd2RbFf2FLmhPdtqyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060143

On 11/6/2024 9:07 AM, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/net/wireless to use
> .remove(), with the eventual goal to drop struct
> platform_driver::remove_new(). As .remove() and .remove_new() have the
> same prototypes, conversion is done by just changing the structure
> member name in the driver initializer.
> 
> En passant several whitespace changes are done to make indentation
> consistent in the struct initializers.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

I'll let Kalle make the decision if he wants to take this patch into wireless
or if he'd prefer that the parts that have driver-specific projects be split
out separately. If he'll take it as-is, for drivers/net/wireless/ath/*:

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


