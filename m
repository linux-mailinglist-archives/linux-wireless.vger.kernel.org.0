Return-Path: <linux-wireless+bounces-38309-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2QlbFyIOQ2rkOQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38309-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 02:30:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE60F6DF639
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 02:30:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZHakZSkX;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=KoNLIoVu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38309-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38309-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80EEA300F5E5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2256FCA6B;
	Tue, 30 Jun 2026 00:30:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E1487BE
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 00:30:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782779424; cv=none; b=iQ78GUlIJ8Mm3makOVYT2DpuyE8Pk2rtHMrLCiuKjoeg4C5HUlcpEGaWLuFr8tj41y3iMnuEQRxbUV5Jii1PtVIoWAym2wjVWjFUuz0dhLjRw8gy3tixDWaM7l2wsX51LykXa7Qfyt0JGvYbVUPWHbpI94R4olmKMySJ2Of9fpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782779424; c=relaxed/simple;
	bh=85G37XO3FQXbqjI8prA1jN/b3+pukxJzFuzyf/wNguk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+oT0N2o+QF4Hhhv73Ia1aE0ev5Qgby/Dbjng2mAhLZpTFD9EvpIOtkOVxhNQBiwFUb+BlUpL3eTMPyuwEV8oYYV5FZ5lQ4lPJFoeYszSj8geBzYi78iTDnb28GXjjOmiMGTb5lzbcpCnYMMPzqOs99I2Z43spkxMYJbPoyaaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZHakZSkX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KoNLIoVu; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TKfS7q4028297
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 00:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x5YqGTWadi5yBMHeS3jpvfnpejEaTq3yOX4W/eiD4Pk=; b=ZHakZSkXZoi9NX86
	AwRPrWEUcrtWXeVIEO697NlCUOupGGQSJMltVN22+AN4mDp0L5y7x8chasa8jN7X
	he2z56rD/plItiLO0dOm0BtWz7jOetEXeTRAZu2m76oYMHQHENSd0EVA2PrF09oM
	nNEXdbVQfCUiHMwzZ71VFvgPXbzEnafm0/5gcNIw8KHAMEZoJYJKnUvtZxmKCZG7
	VB9mvo8PIWCXjrJ7zEBdl7zCbZWv6QuXiiRnVaucvmCYr1ME8cFw1Qjl8GwJUqbh
	eHCWb+skuc4wvkmhu8ARl+osdXHaoPUtxbCiFxJhiFK4WIaC2rH5yKgRIwOyecfd
	tU1llQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k0r8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 00:30:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139f5f5eae7so9849337c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 17:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782779420; x=1783384220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5YqGTWadi5yBMHeS3jpvfnpejEaTq3yOX4W/eiD4Pk=;
        b=KoNLIoVuQmpy1ZO+mUbQDR0rCHKSFvBaoSnS8imubETL6KzDUep6NNOjSX9gRw+9Me
         yf5U1zgTEmzUlohe6E5GHhUP49Ie84cm9nYAz9ZL6Tf3saXxXM7hvkAjD9LUrZdJN4wH
         zBd4zUkw52/thMexfIIcvwIE20BkK/uelYysfVQTGg6KExl6KMTqsPeHcaJD/AleMBL4
         DTPXFdzr2eRKEVE0SOM3ZTfyzR8+Y9qz/dcooCNMjdNEOSNYIZO6Iwx5CbknDMllvO28
         2yyAPLQ21TjitXOGevrsWbCr4IAohtEh20bSqZy1fRMdd8rJ/4hiEqsooOtAbQ+YCSjN
         UvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782779420; x=1783384220;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5YqGTWadi5yBMHeS3jpvfnpejEaTq3yOX4W/eiD4Pk=;
        b=UiVfoBkAZIiO6on99kalBKq5JZeYu0GaADUYRVEeyoi9vatLZg87YY/8HoeEdclEfg
         FzT8X9DCDBdDZ6xNw6EOVhlPp5OClUpXTbD5JNnTAfo2qiy3ILlYJZwegSnWLQQs3vVI
         UVun4KdJV5EeFRT07mbs2ABdsN8uw5m2qswYphHjZPpStacs80Bqn4OvoK3iKC79auNQ
         zqYuc31MBPuRPPzeS4iiuKk7Uji0p7TGS1dDFS9/G04dgu9zA6bFzXIofGbc1mTRFrG5
         In/wFJNrZGe8MVH8d9ecfSIfQiV/WnqmWHHprBA7btynFdoQJ0F4M1kls8rKG5D38Kh3
         GJIw==
X-Gm-Message-State: AOJu0Yw4zSodJFpiklARxgBvfoRmxoIH3aH8Lvvt+RV+1MP100oSphdC
	QpHf9AB1pzfAgvrQ5qfh/OPCaCjhBHKu5bNj9J4ENNXnT2xUC4Ot1Hdtiv7A2ZI0unUa/jTxrb0
	xi/1k4VIJ8hXOMZTII2Sz9l5dDjbCrgePMG6uSd42Ui6fUckhJk6D/AqVRdvE/Vx2KiJJtw==
X-Gm-Gg: AfdE7ck/kv2pH4MVoc1PlmYuKomUnAbRCBJH/fsxchr5H6XnHeE7f2UUc8D3wP1qn0i
	+aACXdSFYh4vTbhPuWTlrNdQlTzX5vH/zxmtDf2DOYzBLtf7nDuarU+WuOCwXLqmeiqQCB+VUdT
	NOx6od98LcTPO08ejSCrABBB/OTmuYtFjOhgkyb+eE7YQEVYH6JD+SFJvcz7KdsN4p5q+1a6Zmz
	tIEgi+CAUhxdwv8lZletVSl3nx7yMyTPbOahWCJs2EOLwbilEKj7mNFxpzqU4x/zbEW5LsoQBaT
	lZd/dRVg+62QiZljnfuIY3TVj9xhOIB+VdPu/8KyqX3I3bMgZyTjBZnd7KwVlPoA331Tz34mJDd
	qWLBwa0VbIaeFAbJApT5416qoFOHlV+F1s92s8h/xd7CbHcNGJLUbPeqDvRv9NkQ/bPRR
X-Received: by 2002:a05:7022:2594:b0:139:d923:f8f7 with SMTP id a92af1059eb24-13b2a14191emr929660c88.4.1782779420186;
        Mon, 29 Jun 2026 17:30:20 -0700 (PDT)
X-Received: by 2002:a05:7022:2594:b0:139:d923:f8f7 with SMTP id a92af1059eb24-13b2a14191emr929646c88.4.1782779419481;
        Mon, 29 Jun 2026 17:30:19 -0700 (PDT)
Received: from [192.168.1.11] (222.sub-97-215-84.myvzw.com. [97.215.84.222])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2cd1be7bsm291233c88.1.2026.06.29.17.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 17:30:18 -0700 (PDT)
Message-ID: <7fd9e186-fce6-4c81-8aa5-f0de961fdefe@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 17:30:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/3] wifi: ath12k: switch to name-based reserved
 memory lookup
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
 <20260611033314.2330-2-aaradhana.sahu@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260611033314.2330-2-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAwMSBTYWx0ZWRfX5WZNFFozU0PV
 KFEQM5+XEYN8gYGUHsxgjkQ4tjsXCdVe72BrYICtz/aJSWORVbgvf5so+kOisryfvABVhBPFJen
 gannIknNmWix+KIec1m00IIFRKvchag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAwMSBTYWx0ZWRfXzNIQhaxHlVTK
 6wVwjrqfp4YHAUrvrqVyj3I1DGeldjvoqUNnrvNkqAUZSfL+/fQ4BIEBRf+P6cw+07TKzr7PvnM
 FW//gO35Jw1xKb9zB06UhqwDTpwfQ+weI4dhCyAWHQFPwI2g2KOGPsZIYI+Vw+APgaSSuO/ZjML
 8yzQLrjTkS2RugZPFiDqCwnVA5sMqJLU2wEK3oiy0H4dJrSyHWHDJkAzMYGFBSNb3dkj3mfgfKf
 pmPzG8Ffk4bp6gFjQojzoWR89mlUne21KdNtsvCyWfQsTuMgYXa2NxGQdi7vwBq7opH8U+NnaYA
 5mMUj5FQAg2nwfO17O912ATRKizqhoomqhG3OYJ5kxVl7engeXiANySEWRxtjPEthTNWWHsqe7o
 1+qKQ6LWQWG9fpm88Ow0FfRIGiu9fYckMpu4Bh46AOBdGBu6v1RYH/sfoPeGSX8LCjvRV+jXmQF
 fHx9ylbY2BLrXvtVjyg==
X-Proofpoint-ORIG-GUID: FIXdwZeVF_XsUTOgzLgKrjSAk4BKCgUA
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a430e1d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=i4k25I72rCCN9bAAQd7+Jg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=6mlMAM2_b4rmZgvfR8EA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: FIXdwZeVF_XsUTOgzLgKrjSAk4BKCgUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300001
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38309-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE60F6DF639

On 6/10/2026 8:33 PM, Aaradhana Sahu wrote:
> The driver currently retrieves reserved memory regions using index-based
> lookup, which depends on the ordering of reserved-memory nodes in the
> device tree. Since different platforms define these regions in varying
> orders and combinations, this approach is not compatible and can result
> in incorrect memory region access.
> 
> Switch to looking up memory regions by name instead of index so it does
> not depend on node order.
> 
> Use names already defined in qcom,ipq5332-wifi.yaml, so there are no
> backward compatibility issues.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/ahb.c  | 18 ++++++------
>  drivers/net/wireless/ath/ath12k/core.c | 25 -----------------
>  drivers/net/wireless/ath/ath12k/core.h |  2 --
>  drivers/net/wireless/ath/ath12k/qmi.c  | 38 +++++++++++++-------------
>  4 files changed, 29 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
> index 30733a244454..695b605a92fd 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> @@ -15,6 +15,7 @@
>  #include "ahb.h"
>  #include "debug.h"
>  #include "hif.h"
> +#include <linux/of_reserved_mem.h>

system includes should come before the local includes. I'd fix this in my tree
except there is another issue in the 3/3 patch so I'll want a v2 for the
entire series.


