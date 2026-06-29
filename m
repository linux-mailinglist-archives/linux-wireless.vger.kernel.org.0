Return-Path: <linux-wireless+bounces-38237-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 97oCCEHVQWqYuwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38237-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:15:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A23B36D57B6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:15:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="QoQuEW/q";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=P79hvuXb;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38237-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38237-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B11830039A6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 02:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27160379EE4;
	Mon, 29 Jun 2026 02:15:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458537AA66
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:15:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699327; cv=none; b=i1G9nR+aXi+D8J/yBu3nGZH9+6qvti9g3XeZNaqW69ONc90kXGpK6espcARA2PbegxvGj20rlZ+ymQdOl6uHP1JJ5g5aJppGW1aKs08QU7ERfjfWfn8Rf8/gWD+bB4Lqs4N7YTr2rVFIS9XA/NMirop92VG6xnpNqhi1vjbiHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699327; c=relaxed/simple;
	bh=qUbtYWmUVWRysX1HW0OmSqrI03pcnUZspr3uJ6CXOSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrhTJNpz4BNiJyewRaU/x9cih8i6EHXCOQu66Ve+jQzsHKWUfCQQyAs3z+AjJmBv67EHPZl2PUYGrbq48b4wHnXGfFZ1YhNJ55+yk0L7GagPSB2BdIV0c1Mp6GbQUoQ9ZFb0RxhiemnRw3H4z7BQ55jh5qB8eXsyMSSlVClDleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QoQuEW/q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P79hvuXb; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SM9AmY986228
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LU9MgakiWMszdxz5hUBJe33ypmJuJW5jEJEkTuH/BTs=; b=QoQuEW/qY0XiN3GO
	rlxjcrI82zz8yAKU/+p0szhbysKvSpc7rwCrCUjbDmxl5BK+qoiqqOXu0pZOYGnF
	qDS+UyfEwseMjDZpCSbSuMjqHZP48JQd9821JqCryBXBCrkYSqXyKko4IypNFCF+
	ZJhbrK/NNDxdH6DInezlZAGx//dfjaJiJVMxr8ezkvOQGW8f7a+UOSlrvSOl6fxQ
	Iln55sjc5+d5diaIRoW8VaUXQNItTZxDD7emPZYVRAFLK0Jn0PhLjeyZu/c8RShf
	GyzuWlkqLmyWdrGxu7nWL5PQBpEI3t1XDEkNs2vziXLb/FR3NZ9HIJw1xywYbfZu
	OCjxBw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8m4ue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:15:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84531eaf8a8so4103494b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 19:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782699323; x=1783304123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LU9MgakiWMszdxz5hUBJe33ypmJuJW5jEJEkTuH/BTs=;
        b=P79hvuXbX9OPV8xR1d6oGTdzTrZsktp0Vnb0cECrRnX+9Mp6EW1KY8MNROLZUj/zMq
         0NWcBTCkAPg/Hdrz2SZ1M28nnGnejYBwNWZmiZR3g7/PO/W+l6/FSQZFoKZDuG6OkDmm
         WmGM7RzbJTGoGSz4ki8s+tIgkgqGusljaNdGCM3BjzhOB5cL8mTZHS6dKQ3sT2BYoUhg
         Qq+wMKUdWl5Jd4oE6YHTBL2CkwHbNSlmOggJrNz/LY0leH7KtKup5jsPZIIwmdYfoyv7
         uZNrIGiUhEfVRMEMPLKFv1GgCiayJ0Wr6Vk4wGoG96HuRdXcrq2+oBU6AHm8wDp7nTe5
         sKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782699323; x=1783304123;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LU9MgakiWMszdxz5hUBJe33ypmJuJW5jEJEkTuH/BTs=;
        b=lFgA3jNWPGkHfKCxggYKoEGzIpEscMrBeyd6V+iYOiC1ADoETMgmYvl9d9fZpn6gp8
         goicJe6hIgzRMz+xAR2OdRM+inYRt4lDFX229YC8jyNYhVsm7ViC1zTNEpSUbiHoGFRf
         85kmrPAJRumd/eZsYcqWfFDeVSzG2Q+1gFQLxOB3PxEMjl94kEHUIAlSDDfv45JmOpRg
         ZcBo6MSW1/ch4ziKRJFAFs5rscj26xHE6gFTkf6Bhea4qgmzAwwBU6Vqsg4e5Wyz8VUP
         ABdrrLru0t+QZUajppp6TzoiFJ8AihoPGueQO9PdAGvYcZ9Z1k2l1P2Qrycmyb28Z9MO
         yqRQ==
X-Gm-Message-State: AOJu0YwB9gdOyRHh25BLjmOKM/Qgf67eDb2clFiuNVMMNR4waUnHdrqi
	66RQGy3aWyzR888niKLTVrvTC9SXnxd2fBDmcSdZW0pT4OLyAqa7gs88ew12Jh3Jurbnbui6n/N
	a+9wv/yZkR3ZoPsroIOrUzuC0dWzdfv2Sj9qkUCpW8tciw3hYfqfuL2DBQNiQiGqaI96nDQ==
X-Gm-Gg: AfdE7clnpe4RM0mT8q7DjXSsUhuK5xEs2saqxSSHYxUG7pZVeCQlHoQPEi9jQ1BHJ0f
	7tdFZ6opoO+AEpTDKA3B99PvDq7iSiaVZbkoqX2689Ls+BAHNkGrniOxqbYswFKLtdv2ERAklb6
	VZYF0/R/1cxI3JCVtRwDQVJs3ZXItM6wRnexhrWHSN8C3jWrQEeGXuK7I9gv/LNajrIlWvRtakP
	OpfMrylXRmMGNPkRgRrQxQofR4YLt2+AI86iKwU32fzTAh0zQDZ32dd001HTrDBwZG+LdFeDerQ
	we5XDX7AFg13HKpKqDKGI/JTyy5JqlBFOhh1eCegVetfb/BhN6SXGCY0MYwBql/5tn6aDerHGyu
	jAmt0zBgd2UwISNCWb7ePi5CIkwfXy6Lyco223YWJtwDcQmNuFrLgWsW9FZ8wQrukAYhzTJjxws
	QhQHNtiQ==
X-Received: by 2002:a05:6a00:2d25:b0:846:22f0:2cf8 with SMTP id d2e1a72fcca58-84622f042f7mr3297751b3a.57.1782699322676;
        Sun, 28 Jun 2026 19:15:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d25:b0:846:22f0:2cf8 with SMTP id d2e1a72fcca58-84622f042f7mr3297723b3a.57.1782699322082;
        Sun, 28 Jun 2026 19:15:22 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84783756e32sm960090b3a.43.2026.06.28.19.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 19:15:21 -0700 (PDT)
Message-ID: <8fc0e9a0-73c3-49a7-af60-6c2fb1d3c043@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:15:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: Fix memory allocation and
 improve reserved memory handling
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAxNyBTYWx0ZWRfX/v147/V+ErRX
 0J7QX2nplrd4BovjJRu8mwhrlDZpIIxtfkEpLVsVsxSHlBOIMMpiw8hLKoueida5ev6Na0SIShV
 BTBAzI/5fWnydv8gwwhSNHvN3tzWJII=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41d53b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=vXKvvKVVOfj-LW_19uwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: LdowX5JbrsP-n53alQ699To8wm29Rgyq
X-Proofpoint-ORIG-GUID: LdowX5JbrsP-n53alQ699To8wm29Rgyq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAxNyBTYWx0ZWRfX59Ul5ySByZwi
 QS0P88LBWeHVkQJPViOQl0fUnkG2O/k3d4HT+ti42F0k7cQtOZ3cWH+twP5J+2ba3DVy97ehcVV
 Z0f1U2nZfzpv5KWNKwr3MRHWHhqW3qiaACMtyM5TIYrSj6LkVc9+IdhmR+lspK5fkTT5R1PCOwT
 m+a7QPLI21DoOrz3FuwnKJdhLKkZ6tfz5FEPYQkMLnZRPWP25bDdKzOKU4I/mKgOQVwUhz4oHbn
 6zzAtsfM50B6ou01ujA30myCBRLaYngZfZz/pptpb9kGQ/I236xQqg9scdTo6P37vxAxXP4d47R
 ty6mYzG0TXux/D9fSzVTsUDDZlJSHvIGPg80n60+g82H9ShoRAojbhL3ZMjbvnB/zhh6xM4O09t
 8Ni5URfNl4TxvB81fDDmAx7/CSd9/5Zaf66KfhdsKNL/86GJkM7UBVvBHhxglt87Hn5AwHgUBYC
 tXrLEPBueuO7/nAg6uQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290017
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38237-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A23B36D57B6



On 6/11/2026 11:33 AM, Aaradhana Sahu wrote:
> The current implementation relies on index-based device tree reserved
> memory lookup. Different platform variants define reserved memory
> regions in different orders and combinations, making the index-based
> lookup fragile across platforms.
> 
> Currently, the driver allocates the HOST_DDR_REGION_TYPE
> starting from the base of the Q6 region, which overlaps the Q6 read-only
> firmware section. This causes firmware assertions during QMI memory
> allocation, as the firmware expects writable regions to be placed after the
> read-only section.
> 
> Address these issues by:
> - switching to name-based reserved memory lookup to remove dependency on
>   device tree node ordering,
> - refactoring QMI memory assignment logic to reduce code duplication and
>   improve maintainability,
> - placing HOST_DDR and BDF regions after the Q6 read-only firmware section
>   using the bdf_addr_offset parameter.
> 
> This series ensure correct reserved memory handling across different
> platform variants, prevent overlapping memory allocations, and maintain
> backward compatibility by reusing existing reserved memory region names
> defined in device tree bindings.
> 
> Overview:
>   - Patch [1/3] switches to name-based reserved memory lookup for platform
>     compatibility.
>   - Patch [2/3] refactors QMI memory assignment to eliminate code
>     duplication.
>   - Patch [3/3] fixes memory allocation to place HOST_DDR and BDF regions
>     after Q6 read-only section.
> 
> Aaradhana Sahu (3):
>   wifi: ath12k: switch to name-based reserved memory lookup
>   wifi: ath12k: refactor QMI memory assignment
>   wifi: ath12k: allocate HOST_DDR and BDF regions after Q6 RO region
> 
>  drivers/net/wireless/ath/ath12k/ahb.c  |  18 +--
>  drivers/net/wireless/ath/ath12k/core.c |  25 ----
>  drivers/net/wireless/ath/ath12k/core.h |   2 -
>  drivers/net/wireless/ath/ath12k/qmi.c  | 168 ++++++++++---------------
>  4 files changed, 78 insertions(+), 135 deletions(-)
> 
> 
> base-commit: 83f028be15fe071efbee8e27837538d6cca77e87

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


