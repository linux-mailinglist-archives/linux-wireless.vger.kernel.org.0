Return-Path: <linux-wireless+bounces-34910-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMNONGNs4WnYtAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34910-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 01:10:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3644A415759
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 01:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1B173066A3B
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 23:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658B374725;
	Thu, 16 Apr 2026 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fZi1sn6l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jO6K3Hvx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766436897F
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776380984; cv=none; b=mdhp/h6qOmo8aSMYmF/787syTSHr4640PGM+9PDSR253/DG1jswf49k/HPIoFJzToQX18ANxPTRqW/cVm8/3Yp5bweZ7O5EMKThfP5q5JfsXvE0TtRd2j0v86IDaCrlhLJiYFq02/zF+tYOOwX60bOn6iN1ROJA5ZkG8b3en6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776380984; c=relaxed/simple;
	bh=asTUn87Rm6+hwdZPJbsFUEGJwHeE8rgpedhqRFQ0tPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNlePMFLQhh6EE/XD49PY1Tdrwz55X/Dy7AMJau3O7bgEwDu4sLZKXwn+QkM/uJ9GnAjFeSO42Uy8hmY23ruHohmHlV1UXvdxMRI3d7KtwMIp6Cd+bDcvARSYodD1yW9N/UU10Bib5wK2qxZRawPLuXiDIiNfXEEViVtkJcg3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fZi1sn6l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jO6K3Hvx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GFdMTG701878
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 23:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+aHP4nPVHoAmAmUKFIT1cWrEkzcI4p7DdMYFC26Ynpo=; b=fZi1sn6lYVitQ+3O
	arMcKOjXyLsrsbuTPEidTI5m86gTrEiv4IFhENSy3zePlhOjp2a1erntFrlVFJQT
	MtJPQwsJMCsUeJwu5xTInihlUJJYJdd/Wb+9jq1z5K8Z5+K9xFgIPnBYl6LAtCrG
	cJkAgQscd0UX9pGUMLyBNLNUcINWY3DjPuXEWO6A0QnqbdpL3RcGhMhIfO7KrQHm
	Rw9rD47qYN+ajuMKz/ipodHISQMI6xXd77gHxdym7MOVHz/6gQxVHeMPkrJKHmuO
	wnjZr3p/BrTMGcehFOCfitdTZJ/FhHcFST/X71i6bg0vLpAhL6cg3RfLGQwrLUws
	y7WbIQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2kn9hqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 23:09:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2cc75e79b97so33308eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 16:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776380980; x=1776985780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+aHP4nPVHoAmAmUKFIT1cWrEkzcI4p7DdMYFC26Ynpo=;
        b=jO6K3HvxgNWs0FhsRgQX81ACiyQtEX3TrP/jZBgWmT2UqxI8+azd2HH87wzps0vaAF
         kLpDw6Z07LzZEP5P+Xaw8QXGJgCd1lR2T8Tib9aBGL2pJAoRJJACNc+XhcIzwSBavAR3
         EwlsHO9ujfuF3S0kjR0hc6mdtCog5GvDuBSIBSY3J6dRsdFE5DAd30s3w/gtVKXUlnCf
         SMjH8rZ/+cZuAVnGrOQ0f39S+ev5iueywhp5q7fLwQi080o/t9m/eCEWqJdHc7K2OdSy
         x034eiXsjv54aVn2KQp0zBTg+afWec5lPt6dSMjoWjDaqr4clheSn9CxACcd1uAo+eO7
         GwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776380980; x=1776985780;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aHP4nPVHoAmAmUKFIT1cWrEkzcI4p7DdMYFC26Ynpo=;
        b=ddEHr6h3QseiYbbQhKjKqm0CpGY2VQxjwMSvc8z+/Dv+OWA0taxy/aGo6SPEQ/MEr2
         oR1Qqt3ayVA+0xqP+PXh6SHUGmIqIshwd0uob8Q4omnr0i5XFGdW9A0Z/QsxUlTh2WQW
         HKsNICbewYGGR1/nzY6VYkx2+esHLAPzQkUsfXHySDYvzuQAdqlQDZzENenchf8mDdvo
         xzX1BIP3l/NnYbrzAzOZ2FvbfbTLfwYX+yYRREz2szb015lTnTJIwYs/Aafv9evZmMgs
         nD+2PgxM5eQlcnlfLU8nRR6R8tpqsxUYn5TNlMgV6jfDQtwnWz8am/rIW5XeVeaIIvNE
         4PQA==
X-Forwarded-Encrypted: i=1; AFNElJ+EdwPwoRcLDuSYXjUU/m09UG44Ccx2tu3L+N/NWmZNdZUz6vPHqYk40sdN9JqjZd+0909LZ7VxnvPUB9LzwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9vVedZxQLSXf4hBfwvrUChnIfjFWPnYRbxG1RcsSNyhuA31mD
	yAemuVgJ9BrhXgsNTiuW8h5VbvGz593+bMEJyYBGQDHX4cU2dBc2ttP6lPyejW8/FQ+wuhwVAUN
	cqgwcDVKk0bEfOOOfTpxnJfYoEX+OXZD7ObE01Ko7rtcV2TuRsr8cyNlK4z+ivvyOFKivRg==
X-Gm-Gg: AeBDiess/nSE0YSiYIziPEvnhVU2d1H79Bvg5X6FmJON9AkBLm5X9dTG+t4Pc5VPszc
	ktM9NqczqDWy+iTsvMmqk4+HR6TznJiPGTqTWlm4tZGJFS8XybosTUJDxgKwDYWhxFzyfHF6sor
	XAMyivzZZM6vJRZGSJYm0APe3ipOjcJ0tu1/CedTvj6VmhD52D1UR2bL2G04urDiNCTEXL8lCUS
	YCoK8wbChLEcn5IQ808rv4wtfNTesNUgIzrHlvyvN8uW0TDrRqvUQNB7BQcG5qWhIL2U5JYCN8o
	Wg4ioYNXrTue/jH2TQ9pd1XS/KFIwnFPN7FZ8WbS5k7iRf7eICnT6HYerWHRL5ebrLcy0a/G9Oy
	MZ2Zwb6MEyYKQMkS1QM2bZr9MYJv+6EOU+hpubofRseQ+Q/iXSvy7GgT1WgCWJgx+OOcB7uT1jA
	mCbVLNkHXVdwB6geF+N5JZOeBi
X-Received: by 2002:a05:7301:5784:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2e465293dfdmr156964eec.4.1776380980427;
        Thu, 16 Apr 2026 16:09:40 -0700 (PDT)
X-Received: by 2002:a05:7301:5784:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2e465293dfdmr156939eec.4.1776380979769;
        Thu, 16 Apr 2026 16:09:39 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e4c473d584sm110106eec.12.2026.04.16.16.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 16:09:39 -0700 (PDT)
Message-ID: <2e123142-b931-45e1-98e4-dc7283266d10@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 16:09:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath9k: use kmemdup and kcalloc
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        open list <linux-kernel@vger.kernel.org>
References: <20260223224445.27352-1-rosenp@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260223224445.27352-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5Qgw48Rl6x-wn-P02FyrZHS9xZczZcIV
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e16c35 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=TtsdHNRuPHlWo_I2SiAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 5Qgw48Rl6x-wn-P02FyrZHS9xZczZcIV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIxOSBTYWx0ZWRfX4uNHtONWDCnt
 TPQ8sLDcPGqer3e9yXjFELBKK5l6IOV/mKiyrAdK1vImxe2FWlL+d6+tDmedIpAZD5rt+Om2fmb
 olIUyv9Ba4fiFFQC6vQwdd3Kgr1KspCN0xEVEkZh6bjxVdUdfkJn+zLRasm+m9CCZ6AfHjWRGdU
 DY+ZSy3AbAn6OeM78i9dhkE2uHBRbt27AGB4Cx1ifTdbi1m+bjI75xbbP1PCOqtsZmGAwxG/2h0
 JFBEcT5DrXBAIt+GIWAvB/1dEgRC4z5TGegJMCGuP3cCvTzyUtGeexWwjnzksV9nH+XqIt46rFS
 uTXIjcVi+6KqwTPNEFa8VIDYqG9st433SiXepe+3Cud6MM+p60WdxMG7VD0uK1CTiCjlvWUfURL
 0tljZR5Og3DRnkc/wuu4Zd1IHvmdHp+aOef8THikviYmkuLeSCp+EZUeV4M+m/xwyk5x3ucjOAm
 oeXVEkKJjOebfs/HkBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160219
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34910-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3644A415759
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2/23/2026 2:44 PM, Rosen Penev wrote:
> Simplifies the code slightly by removing temporary variables.
> multiplication overflow is also gained for free.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/wireless/ath/ath9k/ar9002_hw.c   | 6 +++---
>  drivers/net/wireless/ath/ath9k/common-init.c | 8 ++------
>  drivers/net/wireless/ath/ath9k/init.c        | 8 +++-----
>  drivers/net/wireless/ath/ath9k/recv.c        | 4 +---
>  4 files changed, 9 insertions(+), 17 deletions(-)
> 
...
> diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
> index b52ddb237dcf..e52775dda6a7 100644
> --- a/drivers/net/wireless/ath/ath9k/init.c
> +++ b/drivers/net/wireless/ath/ath9k/init.c
> @@ -297,7 +297,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct ath_descdma *dd,
>  {
>  	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
>  	u8 *ds;
> -	int i, bsize, desc_len;
> +	int i, desc_len;
> 
>  	ath_dbg(common, CONFIG, "%s DMA: %u buffers %u desc/buf\n",
>  		name, nbuf, ndesc);
> @@ -351,8 +351,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct ath_descdma *dd,
>  	if (is_tx) {
>  		struct ath_buf *bf;
> 
> -		bsize = sizeof(struct ath_buf) * nbuf;
> -		bf = devm_kzalloc(sc->dev, bsize, GFP_KERNEL);
> +		bf = devm_kcalloc(sc->dev, sizeof(*bf), nbuf, GFP_KERNEL);
>  		if (!bf)
>  			return -ENOMEM;
> 
> @@ -382,8 +381,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct ath_descdma *dd,
>  	} else {
>  		struct ath_rxbuf *bf;
> 
> -		bsize = sizeof(struct ath_rxbuf) * nbuf;
> -		bf = devm_kzalloc(sc->dev, bsize, GFP_KERNEL);
> +		bf = devm_kcalloc(sc->dev, sizeof(struct ath_rxbuf), nbuf, GFP_KERNEL);

use sizeof(*bf) here as well?
If so, I can fix this in my pending branch

>  		if (!bf)
>  			return -ENOMEM;
> 
> diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
> index 34c74ed99b7b..93b41a1bb2af 100644
> --- a/drivers/net/wireless/ath/ath9k/recv.c
> +++ b/drivers/net/wireless/ath/ath9k/recv.c
> @@ -202,7 +202,6 @@ static int ath_rx_edma_init(struct ath_softc *sc, int nbufs)
>  	struct sk_buff *skb;
>  	struct ath_rxbuf *bf;
>  	int error = 0, i;
> -	u32 size;
> 
>  	ath9k_hw_set_rx_bufsize(ah, common->rx_bufsize -
>  				    ah->caps.rx_status_len);
> @@ -212,8 +211,7 @@ static int ath_rx_edma_init(struct ath_softc *sc, int nbufs)
>  	ath_rx_edma_init_queue(&sc->rx.rx_edma[ATH9K_RX_QUEUE_HP],
>  			       ah->caps.rx_hp_qdepth);
> 
> -	size = sizeof(struct ath_rxbuf) * nbufs;
> -	bf = devm_kzalloc(sc->dev, size, GFP_KERNEL);
> +	bf = devm_kcalloc(sc->dev, sizeof(struct ath_rxbuf), nbufs, GFP_KERNEL);

here as well?

>  	if (!bf)
>  		return -ENOMEM;
> 
> --
> 2.53.0
> 
> 


