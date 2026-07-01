Return-Path: <linux-wireless+bounces-38477-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id avMDJpNTRWo4+goAu9opvQ
	(envelope-from <linux-wireless+bounces-38477-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 19:51:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E75916F0703
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 19:51:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=T8RqQpLa;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=W857RdcH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38477-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38477-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A0113027965
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53134BCACC;
	Wed,  1 Jul 2026 17:47:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C5377559
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 17:47:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928076; cv=none; b=d3RubDNfPuy7MFwM6/l0aie4pnvMLuPSes5aaQsRSGqLu6EO1AX+6O7Vzb+lpv4ros5oBTBJec0yTaSEnxgOobRB6y2FxS617ffU4Ne9xfVpjqAReiWtshUmIPGwFz+jJ4liEFZVDfZ/ZlwcODEm4E8X+bHmOQEgxPouDphM5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928076; c=relaxed/simple;
	bh=Dip23BDhnUJis+qxR7eva4Y6chDo7mwatYq6gf43E7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCSTChsVkUNet03dxw88eAh/7wqUkGv5PiaUDN7JtlYVH2Nepk5zkHSKyQhXY0WrjVXc1lovBLzPYHX/FucInbyzXrgJ3qeGvS62FJ5yn4NVyXK6OMYCm6GYcPZxhglvCwgVxLwFSxF7Ljf0YExo9uABSsuslGaDTIPDiHgOlsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8RqQpLa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W857RdcH; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GmelS1730616
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 17:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wYFO4m0SG1MdW6YcRZcCBQ8zJ28koOmhlPhOmjE04rw=; b=T8RqQpLaV1KsUpBv
	4OjtB+MvqGvE07QLdzeM3J01iAOBQfNO3RdebvU64qeU49RjjDfX44QWDJtkEFnv
	OuxF/jOGaVGhgYMjbaAz0Yuv8H2ADqsj44j2034tO54YT9dowJF+Z2XijLsBJrm8
	ZwCIzAOsU/GSwlv8mMBgqTH79mIIj59t5i3vRW3yQeq08qIYugsXmoZLHNbJ3ctf
	VC3xVJ1LLtSozH/HdN2qhoo55w4WSIdYvrIze1ING0tbh8FwbnBDX7Bdy2z5XDsb
	PRmUfVDDwihgHcpXf3+EMS1b1EWTREzBEpw5Sc8M8sZsCEVpYJRY7rWC84S5h/zL
	rgYu/Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510ahx1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 17:47:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so637681a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782928074; x=1783532874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYFO4m0SG1MdW6YcRZcCBQ8zJ28koOmhlPhOmjE04rw=;
        b=W857RdcH6/7sHFic4DP+WeAawQmuEL7zHK/FEnBwmIPyZfBO55ftVRixJojoSgoaHp
         V3RPHznBholRSpST/OtSGc1o9jCPWOOHnBPo/7/joU2gWnOAXBLW/9PTa9FvbolL2nuF
         EQo6pJcbUjfzGP9rffXmXB6xUA+NLAHlpqimGjDsOokI3VZOaPaPR2tGHS8REWRjet4X
         YlknufmF/ABLfFlToeiESQkNbGGU1Yiy0ELYsSGHUwVth+Z2uuBcrMQud2gBc6evTcie
         lv8J1NHlBGGOX3P4c7sn/jAqQV1pGafcPm/4MqCM5O+XyGFnLdmVqpJ7lMWJyvwGRGMf
         HJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782928074; x=1783532874;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYFO4m0SG1MdW6YcRZcCBQ8zJ28koOmhlPhOmjE04rw=;
        b=DSGJTK/2NPEqaGHRBYh20B2cl1+sKzllLYyHttTx2zCQ35V0wAbCIe9OBZvbjoRILJ
         yMvnFuaTfVXxHBI07ARyzL/U9BacVqOqOGdYROzCLhsTY+joC9WnWA/VsqMAoUSXgnG9
         sVWOvyV0480/PEJLoOuruj9mtUsoOlSlQ60NfEMV0tm3nBtFNVNW81/USQn/EkXh2+a1
         J9RYJenfb8536beaORr7NW4SQkps7sTPBC52JQMzK59Hw9eKXfRxnTyqN4cAx7ysKdP3
         zSlVBbx2EcTPnK3uu3PFUzgftFpF+iSE7iRog52/kaFBNQ4LE74PbO/wiesTeciBPln/
         bVCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+X5wORPf4HRMXepoKZstGLaZCqBIjIdh/SNLlO1kYIoXw0DWazxvPbjcXv3bAK1EkZCVbdmzckBryFu6rmXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Y2Fk6O09pydR5oZOAUN5pRwUO7umQ8AsBl72E1LhMTQs0zUy
	gAZmlcno8iBqTZej8mw57FIKug0/eSGBX8mJb+Kw+H0qnbNhWyiQ8SV7SNItwLh3SJ0sfJzl/qS
	lHKiP1wsYmYhsUA9cVMr7Vi6tzTWF6k7xZnsUOpDP4h7FkmqIiGbxBt0rqXGC+KhLmNki2g==
X-Gm-Gg: AfdE7cngKbcFaA4ql6jTAonv9UO2UAfF3U+i3/JSGp1BZla8sKZ2hBrKADVUG5uh1Uq
	2LQTjrK12DRcvZWC32+AHhNRKl3P9qKRXpKUaqXk4dDbsL7Jnv4aq+kI8pzppOmmrRoU4UZxahG
	j5QL3kTTw9GIBxTPZ3yiSGLA1ofRospgXKgja4DkIOQToz9R2Ze7ZXSCTFeP+P6/XJntB5eEaR/
	slLasrvG5snBYXvK3oIMF9CkriJA18F5bPYf2JBDog7nZkr0Fj8LA35cQWYcJp8YKUi3GRavF11
	3YYw08492lu9AmG/7ZsOcv1k2ve1J1zxRhVbyZXFPnAjiLkR0R4H4X2tMXNHWhLsn92jONusoXU
	xjAqKvbpcO8Y75gAu3prWUEWwy06jRBC8xHAvveKJrInIIHsGbKQ69bAQx8lqDo7w3XPcBbA=
X-Received: by 2002:a05:6a21:4c08:b0:3bf:49c8:f69 with SMTP id adf61e73a8af0-3bfed3e6060mr2697823637.39.1782928073722;
        Wed, 01 Jul 2026 10:47:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c08:b0:3bf:49c8:f69 with SMTP id adf61e73a8af0-3bfed3e6060mr2697793637.39.1782928073236;
        Wed, 01 Jul 2026 10:47:53 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84405sm31660eec.17.2026.07.01.10.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 10:47:52 -0700 (PDT)
Message-ID: <b31525d8-e3b7-4ff9-bee6-4974fa9f9a6a@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 10:47:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] wifi: carl9170: firmware trust boundary hardening
To: Tristan Madani <tristmd@gmail.com>,
        Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
References: <20260421134929.325662-1-tristmd@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421134929.325662-1-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vLxc7RRppmhDUgva8tmZ943nLrnbYzOB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5MCBTYWx0ZWRfX03HiQ73Ojn+I
 8bxXjqQISN+tdsr76/vpe5/LYtu4ThItedXsKJhz/b0BXWDdpb7hr9hPM8XLfM7oPmnGmnxjPiB
 pYY/K4USmkgKuv7cNQHMNqDEiueGD/9xR2xVHDcYVZG1Jnnt2+P0/4cF6VFha+k2NTeD6y8Jy/3
 dGRF0CjmeK4QSx0Z1sqQcu+sAe/cGpFRLisPZE1Uw7HeGwPvI9ZqeqXbjVnbynhjRwVEJw784ni
 jIsqGAA6ewqQBmeh/cOPNONjhqpgCydTTtPO4KjtLxUNuHGSfS+Hon+Xq7Aqo48sjFGtBYGqyjy
 IWR6DnNIC5DJPUB/xvwzULVO7dCQ02vA0UpLwnuiVwKe9s9HGTYgqpKb/wVH9wAvAG3UvLnuqtJ
 2kmNiA1ITNoN/w4MNg3q4/gI3MLQwOn0zU+tHTMuJqFKa2UL+A2AxgVT1/CfoZ3rVDpnnJy3YAf
 p1hyUSdzLf7+niuPNcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5MCBTYWx0ZWRfX6d/I+vi2CGAg
 xjpkCHVK1aGHHZ1RndSekXYKgFgs/6HOXOqcUz+JSQBI2wlO3fb1r3GfVmLIfWxRi8veT1g/YKM
 qRr/Zp2pE5WYVGTx4VM93W2nPlFNJ9M=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a4552ca cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=J_-Nd1mkAAAA:8 a=Ta6mM2YIzGmWju0K0HUA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-ORIG-GUID: vLxc7RRppmhDUgva8tmZ943nLrnbYzOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010190
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38477-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:chunkeey@googlemail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,m:chunkeey@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E75916F0703

On 4/21/2026 6:49 AM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> This series adds missing bounds checks for firmware-controlled fields
> in the carl9170 USB driver.
> 
> Patch 1 bounds the cmd callback memcpy to prevent heap overflow from
> an oversized firmware response. Patch 2 fixes an off-by-two in the TX
> status handler. Patch 3 caps the failover copy to rx_failover_missing
> bytes, using min_t per Christian Lamparter.
> 
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch.
> 
> Changes in v2:
>   - Use min_t() instead of separate if-check in patch 3, per
>     Christian Lamparter.
> 
> Tristan Madani (3):
>   wifi: carl9170: bound memcpy length in cmd callback to prevent OOB
>     read
>   wifi: carl9170: fix OOB read from off-by-two in TX status handler
>   wifi: carl9170: fix buffer overflow in rx_stream failover path
> 
>  drivers/net/wireless/ath/carl9170/rx.c | 7 +++++--
>  drivers/net/wireless/ath/carl9170/tx.c | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 

Christian, will you be able to review this series?
I'll take it once I get reviewed-by or acked-by tags.
And then we can ignore the dups from others.

/jeff

