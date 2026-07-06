Return-Path: <linux-wireless+bounces-38653-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zuK0BsQyS2rYNQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38653-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 06:44:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A369E70C7AB
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 06:44:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GkgvlNG4;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ALtfCdai;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38653-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38653-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22CB8300CEB0
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 04:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93BC3750AD;
	Mon,  6 Jul 2026 04:44:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC0230BD9
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 04:44:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783313088; cv=none; b=QeVDOS6xHhPK050GPl3Ml4vjJN4O/XGnDgesYvLA62w88DHrdtbsrpJVjdmPrSDAV4ORdeLlfk0ZPKBlpZc4gqrhjrBikLzvrq4qy6YDksiHnql8XLv29z6NAUUPCgQHhym9e3lVgkJVB3iq0ar+3ajkY2gtrTftjgtQd5PsdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783313088; c=relaxed/simple;
	bh=hFfAQZz6tSzEHl1Hb7IEkv06RShSwBwpP23LwDDXuxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqMaIE7Wvitaqf20Rs2CatrIiOs8Iyi1rX5Gbds6Qq8FGQmww88LOTP6JpBjcpvtJCZ6zZQG4ONGOlqY5GZ/PtqqPhy22bC8LdGuwOsRjDas5RvFZCT5tVzQnzM7Q/CoqBuEneB+5vXc6xhsKS5B6zytQJeGhldvKDb70GbJFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GkgvlNG4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ALtfCdai; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66642BBf3595286
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 04:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e8uCEnvdXlL4V0kIs2HNz2HP0kgpCCW/AbbXVNw+D60=; b=GkgvlNG4VS+EYFD+
	Dh/agRMZJPi04HXCxg7pAty+XO6ToYhI+Mr9sQV69rftYWGvGGC+Vw297/VVp125
	L6CBYc+LywVurcmmZjD+g62hR6bKyjLt7AFlSgRFu3ftggQWiGgk0PRgVNjEpNUU
	LRz4lfK3EPK65hzC6ZV7+cNqDErLWwdqkRsmqtpZkp9NVqKsUpbzgkm3PEtznf0W
	zhda0gUj3vlKKIruXsnXu19T2hhKxzrqfFD5MpBR6DRZYrVDFBbj1tXB5kqc5BnR
	h4mav/s/GZMzQ5YWVb3R4lJ8o6arqDcnBGq2yxfAN+UNKDpMwa2olqI5Pkse53sS
	i2633g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgvp14-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 04:44:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c98136ceff4so4616444a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 21:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783313086; x=1783917886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e8uCEnvdXlL4V0kIs2HNz2HP0kgpCCW/AbbXVNw+D60=;
        b=ALtfCdaia2Yg3Gi8S05e/UUUFKx/ktCnCbmXbjgcYV9+k8qoEnWtZZJRa3m0wUASOo
         EGTpRGMT8y+ro6T1iT78GGuXJuZlCX3ViECf3LLRQ2qbRl9h+HHObkOo1ZJ3TyteGEkt
         IHUJbUtY4G2JO+WlOKcIvFE+FkD2KwgPf7rxTpgEllQtsi5rM2d2caEnbYyoiFMK8ekv
         d0Dsx3USeI4SSgb/LehNouUHRgirPeELSms7nXiYjQrGmziNQb1ohpcj7C0yc8cSnnWK
         u0m8MO6xaUE57aAEICtTSdG9/UixrY/lb5W712hYdoAQMdu5f46f4vGjAhJvYoeDtxAc
         izNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783313086; x=1783917886;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8uCEnvdXlL4V0kIs2HNz2HP0kgpCCW/AbbXVNw+D60=;
        b=G5ewZugpQAiUqewPFFAm5P6yYyoN9R5T7i3EBy/TyIBNqcNrXrVI+HatVOpnoXql0y
         c7LjOyE3yFMnGbQaomb+XWkEq4bjmUe2CLtPPRXtCWdt9q9C2t0gmR0ayuK0e5R6qWpS
         OqTdl8m5HBLrhyJmk0RrELdeZ6b215TC3xdQrixaBAsY1zwlTSoAi2CjFy/P2Z7DXo/V
         coRvur4/cllWA86wZHeMRbOfVfjrkbSWZq3CzD/+ub6Z2pC6PwEbT1iVkhfsDiiT542x
         txhIBSR8rWp11XwiZaGsoJP1JIU0r3G+kCcN88/cGJmCNcPqA/7/fBsEbpzHW/vrWuJ7
         tpgA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7Urrz/gtmO4SHRabeL9xTiIDSoiSPI68QYs1cVTuGGbIwhGj9GxQAGrwCRRcota7aDhcCS7Uo72OLrCKBlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7YfgfQWafiLOQZAnOqhEo6s+zMVyeUJYD5m3Z7tn7ghMacav
	s8IMZpi1d8efuaUFoFWHJIfYGqSbM6PwbHQ/0w6qUh9NNiHMEWc7YADfSKh15SCj1uR1z1wuX67
	XSCQvEoMYnZI0By9PSLaYt3bOlbnfECfXa+2gjvbFaYjok5ICNhq3GJJGWhO12vKhUZ5AKg==
X-Gm-Gg: AfdE7cn4b5iBkJxOYP2N35y2HeXEptyB9IibBn0p4161lsfcUk1M7oF089p/46+gazA
	DOGspSVDXxoWyXLMvun073GQA8OEnjtuH36LpkUtlb8Y6gnml3EaNb7Iu8p0sR/jqfU73EWDydb
	H2B4SaeJ7vUWXv72ONNaHxk9jlXV5ceZqKkxFIxrWUro7cZoyHVpXYjHZQBAUlJwJAc5hrBQyH6
	/kN9D2H5Ji9nYcfsYOzvoLQYdzGcQMNFeoEy9JP8L9geo7f+8IOKgh38UsudMoYQpUY7sRTbVtr
	Qjnh/hV8V1g4uHghzSLBFp+jdccrBPY9PDTboDAXCWdnMHQjcfv12NqxtgGaEKy+vUq/vn3cPUA
	+5gc2n4Z57aPaM8cfnn02CnMHFW7Rwun8NlSwpnWM14g0fsaSAw7Vv3fG/QtDqw==
X-Received: by 2002:a05:6a21:48b:b0:3bf:db2a:d164 with SMTP id adf61e73a8af0-3c03e51e2demr9199845637.53.1783313086033;
        Sun, 05 Jul 2026 21:44:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:48b:b0:3bf:db2a:d164 with SMTP id adf61e73a8af0-3c03e51e2demr9199823637.53.1783313085586;
        Sun, 05 Jul 2026 21:44:45 -0700 (PDT)
Received: from [10.168.91.130] ([223.185.219.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm44980361eec.11.2026.07.05.21.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 21:44:45 -0700 (PDT)
Message-ID: <55640c9b-7f7c-4edd-a629-6fa98e56bef8@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:14:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: fix ML-STA authentication timeout
 on QCC2072
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260704073000.3300099-1-miaoqing.pan@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260704073000.3300099-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4b32be cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ziM92C7oNnnlFgKtw0sKeA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VGMtm6mGyxy54b47EEMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: ePFHNIaA5KYfTSZLsugxGj-0IIYf0aeb
X-Proofpoint-GUID: ePFHNIaA5KYfTSZLsugxGj-0IIYf0aeb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA0NCBTYWx0ZWRfX8NyzgjY0KQZO
 oWz4FCYap+K8jye6JAJNhjZj1l+7MTf4V70VuONnU73Zu+3vrLlTZnjfq7z+chBDZYvoqjB56l9
 HxsI7S6fqri4m+AramgcARvRexkFPK4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA0NCBTYWx0ZWRfXzd8f7xD8WFnP
 uf/Lyh1YS8GnlrrWkeGlxvkAkqiYBSZs8Rgf1/nV/yDo6yZMlXFtwst1aWMvhLFncI8h6WlmOaP
 8CgKEgP4FZcIulDJbzTiMwLNxc/I04L3Y8NGxeeKuoGDBRCF/Ii98ro3uw31kV3ssxSRxSvm8mM
 PBkO97lr9X9cgBrfmhE9lMtLynQynkniIdE/VTBrot4XdB6QKmSiKtTvzrnBcBi1yQ18B4RxSkG
 tFVdjJjsMIZuIG4RqeRsS5mfQcxfKilzNDvqlHaZZPm/0QG5xHQ8NCGBAcUkYRwTSSBcRshD+eE
 IUmk3DLpTjO6OkthIDivgdLHbEYwwBwOJ3eL1tKefF9+YxVNOqzLt9yVQPjGAOJ93Kie20weDnE
 wfg7WvC/B2wo4EVkK9o7aiYb7GCo2Ua05JMyQiZMD2N6SQHSQw30Y7o6Fc8dfNVspV8GFlQ3iUH
 nQg68bVu3SiYusC8paQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060044
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38653-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miaoqing.pan@oss.qualcomm.com,m:jjohnson@kernel.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A369E70C7AB



On 7/4/2026 1:00 PM, Miaoqing Pan wrote:
> QCC2072 firmware interprets the MLO_LINK_ADD and MLO_START_AS_ACTIVE
> flags to control the link state during MLO vdev start. MLO_LINK_ADD
> indicates that a link is being added, while MLO_START_AS_ACTIVE specifies
> that the link should become active during the start.
> 
> When an association link is added without setting MLO_START_AS_ACTIVE,
> the firmware may transition the link into a suspended state. In this
> case, authentication frames transmitted by the host can be dropped,
> leading to repeated authentication retries and eventual timeout,
> for example:
>    wlp1s0: send auth to <AP> (try 1/3)
>    wlp1s0: send auth to <AP> (try 2/3)
>    wlp1s0: send auth to <AP> (try 3/3)
>    wlp1s0: authentication with <AP> timed out
> 
> Avoid triggering this behavior by setting the MLO_START_AS_ACTIVE flag
> when MLO_ASSOC_LINK is set, which tells the firmware that the current
> vdev must not enter suspend mode
> 
> Note that this change relies on firmware behavior observed on the QCC2072
> platform. The firmware on WCN7850 and QCN9274 does not use the
> MLO_START_AS_ACTIVE flag, so this change is effectively a no-op on those
> platforms
> 
> Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00068-QCACOLSWPL_V1_TO_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: d8e1f4a19310 ("wifi: ath12k: enable QCC2072 support")
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

