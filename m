Return-Path: <linux-wireless+bounces-37886-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AEUBNhqaM2pUEAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37886-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 09:11:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A7D69DFCF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 09:11:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=S1YSiq7t;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ker7KfG6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37886-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37886-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A9D300EF68
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48383376BD1;
	Thu, 18 Jun 2026 07:11:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881531A7EA
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 07:11:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766672; cv=none; b=utPQQu71KWyg6Bu5LokKt1CGtWTM5VrB5KfRWKCcfjT7YgD8BIU1CVSHCn7eyQG5ZM/pR12ka4z2H4dvrBw2TTCmBbZAegHKDDPSR7JWpCReWsoY0oYOwsxOzdrwq/+ttvwfGElxjaa9VnSHsVtztIUVuNYlVpjZ/W7S7QneuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766672; c=relaxed/simple;
	bh=LAXGhUnh3GKTwqfsfUBB+nFPoaEy3EKhOwbqlwtoZjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGHU80j4Z7akzZlghwUnkdnr8Km0fOUM2vXEeI0HlSaf2D5IPGJurNDf8BtuCBiIwbWDk0Wh1GXh0Me4ST8ImRlCLFUjdtZWFx9eAQ1aSv1Txa0yYlRTDlykKq7IOjJSjmG85Vt+iXAliYS91FcQ3tJqsEONjJZQ5qQMjgyXnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1YSiq7t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ker7KfG6; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I4njYK1597057
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 07:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83E4y7HOfo+A3U1jqpxIrPDf/ezN6kYtehTSe1XNNNw=; b=S1YSiq7tCG6dFT1u
	BLOWy1D/GZMpMflKdjw54qXNKfnKv/mq7C4C+SSMnKyXoi06A3Nz84jp2vPzP30n
	kdJe6Aau952Q2J5dIDy64qptoWPAiGs9hYZJ7yy8DRfoQMPp8+0SJhm1isH58jn+
	H4AjPFPROTTwptpHGpWKBDgH0aHveG4BUNgCYiKRhs4FFuhtui5AI/thLi0+Hnfb
	kynu9l73tWAVl4SaxiKxXiQpQ5szyAr1uSM9hpPvq5P3f5/kYnp43J6vA/tBCJGp
	sdcWyqUQ63o63MfUwKQcqZkks6bhpDzwiePs/pUXQCKjQTZ0bc8o4LU5pxWQ43nJ
	0gUQJw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vk287a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 07:11:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso707614b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781766668; x=1782371468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83E4y7HOfo+A3U1jqpxIrPDf/ezN6kYtehTSe1XNNNw=;
        b=ker7KfG6ImDBjPys/fA5EdtL46WOGbqi5Cq742LSwnrtJ9pWi2qlQ1h95Kuas9xJQ8
         3IS/uJMqbEyZ984sFAS6XMXVVK2EsGof/z1Afqjz7j50kovkw5BCdHJJX2hoRRgN4HpS
         lgmPJ86GoXXybOTjC9lXl5b4lu8I62H9vM5MwcYTNWNZA4vyBPmjULig5jzCRUSKHms3
         GVeHC0Op4QgA/113gdkPl5mpvFn1sThtUwZnp0DUtzwb0HSKLmxWTMsNSjQLYkxcXPUW
         jjRMAV2CxyY3WrfW01EVAAfPcOiUxSbUicfJ/yRUYBTVPr51DPHbx6zJyym5Vq0L9qD9
         8eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781766668; x=1782371468;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83E4y7HOfo+A3U1jqpxIrPDf/ezN6kYtehTSe1XNNNw=;
        b=pH66FRK17w1BHF5dsB9cyS4S/OP5R0lJIHQnjVp3FEmnSnsXXGaaHXsQrpHSiDZ3wu
         kPcfurTjl9OxlZi4SoBPO524iMqbFXFZtq3mSAip5eOx4rRFXfsGps0JhZ1m9XPMBwRa
         llEX8kp//Pp5wExALIZ9knKjolNXQGCEbZJ4s76mju3ShZHol0LViIJ3WfH1gXQaKup2
         AgCNs91bnWscFmf5XesOQScNu1+apuAapusYl8+MvRjJEJCgoxItd4KuERF13eaPq6yA
         ld7NndN/1W7ZAh8SRnMY1EamBoluO1DGeYHPoYgkGnf3bYioClldaSULBrm6qWCgBkQf
         DhJA==
X-Gm-Message-State: AOJu0Yy9DI/uNgrbAIImSXY/rqopzcJCEXrZMyayvPdxj8dQcUfaZi3H
	U6S5uSPW4IIZ5eJhxLjbmaPFVbI+Hp6Re6ynB9fCPtvGALw0E/hwu3oHreY7LewYD+2OhA6XUGe
	adY3CRntyBeR1Gsgluz+DkwhKA2ClJc2dBMunj/1/tqci6DsekyTPQJQpDEXj26BeJYOFAhXx3c
	b6flYK
X-Gm-Gg: AfdE7cnK3F9n7/LQsLRfAOCT6xXo7p9LaGgplpvQtzzUc3cB0GpnbE8Vn1QoK4MHhgJ
	smjGbMY01IIngvqC9BCiLX556UxJBluirMQ1FHc3jy+jA+LilqDzXdzUl25yHPYrxz8WNBeYNkm
	dD8KfiQXi8YEB+bnmDUZ7kAYrN6/1wgZ3777uSOzkmypmA28w22hxB6ap8K7ha1hSXYQXILSHDk
	p2vIlgDf9ojQ2LrlxpU78+whP0gJDtkZExvcmEqHwoUDJQpPvAkvy99g9jZLVAgABIwpyU5JoHr
	cygBhU9/+Hqb0ufzkAyOKGwkrExrE48AJDSKUZnov1tNPD89+vAsHGkNBaiQRJePzwzALDhqAa0
	6DeCwS+ZKq71rAGTJMMVObXTvzrAZzCuSxWBRtbKg1XOKG3hNsUg8qPzBKQ5RONHMFepIOnth8x
	lQ9LHcYAM=
X-Received: by 2002:a05:6a00:6c94:b0:842:6004:3fb0 with SMTP id d2e1a72fcca58-8452452b3ebmr7813555b3a.24.1781766668595;
        Thu, 18 Jun 2026 00:11:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c94:b0:842:6004:3fb0 with SMTP id d2e1a72fcca58-8452452b3ebmr7813520b3a.24.1781766668108;
        Thu, 18 Jun 2026 00:11:08 -0700 (PDT)
Received: from [10.133.33.65] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b0112edsm16574313b3a.45.2026.06.18.00.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 00:11:06 -0700 (PDT)
Message-ID: <19533f4d-9fd7-41ba-bd57-f7af092aaf6a@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:11:03 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/2] wifi: ath12k: enable threaded NAPI when DP IRQ
 affinity is unavailable
To: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>, tglx@kernel.org,
        jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
 <20260519011627.713068-3-hangtian.zhu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260519011627.713068-3-hangtian.zhu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CpVVbVWvsA0IlRun7V-nk9VDn_4KoaPR
X-Authority-Analysis: v=2.4 cv=DNy/JSNb c=1 sm=1 tr=0 ts=6a339a0d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=p1D2W8PGoTfUkLiTzOkA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: CpVVbVWvsA0IlRun7V-nk9VDn_4KoaPR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2NCBTYWx0ZWRfX97anrxwPSvfh
 nPy7cTPWDh6LRa/gygL/AtPdUiJBl8fFmdzmCefszTPe+O6fUNDVMXPqe4C0aHQrI6rI5UZct70
 tgiC8yXuEWb/ZFf8pzoHwwbfZVM6x6s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2NCBTYWx0ZWRfX9AoPo6sMnXKr
 gc3xUHINhejEY8BUimcSDN6jHcLS0puoFPbby4RW2VBc/UBzD1OoLgaEib5jvyoNSXyy1zcH5dP
 g5b+nI6oqOyXHtFfCFpmqeXBoV1bn2DvUAny/rVXZrso1uN30AghhhzxhMPnbRk1MktxvM+g/sB
 iK2flX0jYFOP82r9HMFCK1EzPZZfJ+I0np7xBsYBvAgy/zkthm2u7bZjItayClychSynJx2Dv2n
 YH0Ln9mUAqfAqS4Lt0npEXpxs/YyHS5ZjstE+bLG9v7kWWtu/hIoRCcpxpfhiBwkF6AQVsWm9+n
 TyCia3dWiN4J+sdfE6JFh7Qf+jwoTKnN1giTNx+2HIGe+jVsfxwF2i/u/hQwZQB77HGAq92/xh8
 vF+nfojgYaZdYfKtLe1BtJcrju69u+vR+S3umIVpoeTKYxjz81xP8hfoHpEQGtzmbcwP2lHRcDF
 CgslNkxBMp8/LPOv8RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180064
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37886-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hangtian.zhu@oss.qualcomm.com,m:tglx@kernel.org,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37A7D69DFCF



On 5/19/2026 9:16 AM, Hangtian Zhu wrote:
> Determine threaded NAPI policy from runtime IRQ capability of the DP MSI
> IRQ.
> 
> If irq_can_set_affinity() reports that affinity cannot be set, enable
> threaded NAPI for DP interrupt groups so datapath processing is not
> constrained by a single-CPU softirq context.
> 
> On RB3Gen2, where IRQ affinity is unavailable in the effective IRQ path,
> EHT160 UDP downlink throughput improved from 802 Mbps to 2.58 Gbps after
> enabling threaded NAPI.
> 
> Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00074-QCACOLSWPL_V1_TO_SILICONZ-1
> 
> Signed-off-by: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


