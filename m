Return-Path: <linux-wireless+bounces-37893-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VQ1vHeG4M2rmFQYAu9opvQ
	(envelope-from <linux-wireless+bounces-37893-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:22:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C707869ED2A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:22:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="K5/9KXST";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=OqSq7PXo;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37893-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37893-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A5530AC1F0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C73AB29C;
	Thu, 18 Jun 2026 09:19:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2993655CD
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:19:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774373; cv=none; b=iKkK/w6DexCqsRfx/ZZviEeh7bZRaMfVBqNhLbuKD6GNWaHTHUm7KrDw5IS0vsgK67iBBVdP0rGXAldyCVTFon/EixOJOxonVCQxL5MEgjgzKDG2F5muwAoidyPhD/IpMiDYmo5TliRtF1U5n+L9z3BwbnO6NxRSzHtZkdORJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774373; c=relaxed/simple;
	bh=fgWJ/+87MOid3M1d2KnUPab7AXCBQy11iCqSaaEbGsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBzCYKyu+jOyeB5nc02kkyEcYujkcKKThljj08Ve5mHFqagDyDY+JcSWLaZdg5YAx+uGYDJaZoC9xdONzb4pqQazZqhmwPHs47eqlJmAU3Q9BYYsplmyg0VepvL5CilVP/VhqcfpbG7jdorwr9cHP/BSzHzwMr2prDC+/1sJwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K5/9KXST; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OqSq7PXo; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8FadJ1011294
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BCppw5saOM5VodB6jl5v2xnwLEdEl/ypS18lhiNEjQc=; b=K5/9KXSTc7aqcWsx
	LmApMB3soKR1wm/NTVERol101kTx3TD1iVnm7w9ajkCzavFLMKPdl5CqZxE+JYQk
	yDlYjdfKlMZ4DSzwzhZklwHn4vHd3+HDxPd5JdQfsYb2u11x4rlQ3yTMuvEphzXR
	pwpPZMY3ny9Yivxwfl3v68qDvXbjHwmjxj4oyP89N1rnMWbhX60sJVrNncGx7o7y
	Mrg+1DBGnZ1EKeg4ZPijLuB2y4GmFtRMgZcKmeJPZ68V5bG+XxNn247ChJO2Li9j
	YW2E5zBPKlLohnXb+Vt5upJLurowh6ppzgS/ab+i8dTUTR6+7pf6U8WjbFZ0iKGH
	4BTSFQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1rttk7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:19:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8422f987f2eso1104613b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781774367; x=1782379167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCppw5saOM5VodB6jl5v2xnwLEdEl/ypS18lhiNEjQc=;
        b=OqSq7PXoFDV/su2efUxj6Nz93nS0/7UJF4nkemigw4UAFjKrk9yF72FtH3jwC4j4VD
         oAXY3vgNU5KeS2fwE3Q37fUp6G99ri8qcSaDTuiXl9wB5fMUR7UMsVhXgp1Z87ZQybIW
         IDcWHRwekiBDwPZg/h6KcMEZRo2kGgbifiKRY0pTf44ES0nVoOFZVNZ1rEfUBTbKDzby
         QTo+mqzgbhGFvXLkY/NaUHlW0XurCnahbULIKn80nnSSl+4GRB7WAebbAn9iSgbdDv89
         YUmIJ6pkZTsrAgoXBea2bK9JwGBgr3fNrJVs/RYm1D4i2jMELHWl/IdeLmmd3cKINiT3
         q3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781774367; x=1782379167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCppw5saOM5VodB6jl5v2xnwLEdEl/ypS18lhiNEjQc=;
        b=RpCdnd+Y+puXGOOI84PznylukDkgTfUq0q822qKlUSK0mAkyLWz6uP10WXYPeBWtgn
         iMDvkkS4PPvBI5KkIYzVPxJoXz4w/HNFK7y18cKJdwJ46EojYr98RNWkh6u80imhlLyD
         4hI8p/+S3ULzJnOrYwXG4+4xjHEoiWBDbtqGSPUSG9I2zgxSZDxjZCF/5dYLRI5CS90o
         8AfZgONUT5Fo0OPjOyOCUWdqg2anTLZtHZaHpcITljDcdIz+z4u2/j5Z2tOTkzgflTJy
         G+ii3JAYVArskkn4RLiWce0qKYkkOcCJmXDnE1FtvlBSrRdL+3/OixCiPaUTDc9ParvZ
         6V6A==
X-Forwarded-Encrypted: i=1; AFNElJ8DPBGUL9KyW6TtVHmJqcn0PK11pnG5nvS5kv7oRuj6kHohga9gAxiBWxIam2Sb2VUs8uGATHwu1EDffTK9dg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3ccbXGI70WgnUF3w5TIadDoEJqBk4Ro/ClP5xtjF3O8GisBN
	NQAEUDmG6GYdsHX6h0awGLjLHdcA0qdlIaYukKuEJZ72ojxmhjrS0EryOZQdpdeddYfba6bIptv
	jO52fR7fCkcyqAqkwsPphp9Gfq22qsFZIAPSmO5/21yikXU9HSyUC0+4n+2TcC3Lzae365EKZXH
	Jd6w==
X-Gm-Gg: Acq92OGQhnFYwHAN7JxkRepBypl7viWkSCQWj9byhZtacyxMY9vXjSx8VxzIByhHWl6
	Fs13zK7UAp/nsXGT22qvYTyM9eFaDmISfupMXzvXWrJ+eYVihZLz7rwXqDtsK24wutVb1Dmi0Gu
	RXfmvjmHx4k+C1JCmf3VUbO3u/ogRbbRiY76+N9ZbfffsgT9DAWOu/haJfY1huwlj+zjJ8tIOCA
	3ianRO3am/yWfHVBejvuRhNaK+OH9bSYOTuAVN949fyOZwZfmerqnHl0mWby1YjpfVIf0JFS7qi
	GZeiSM+Ek7CrIIrPT/CXTk8yCja35sv/pmoTVcOlNqrW0NQCC6DnQvGDnYh1DnenacTvX2utYXt
	hADr1yXZz77cf+oHsBMh2BrAKQNyShWKqlTKQ+LTyT4TlEvL+CvaSpjR9JeDiFNwiMwZi3Bz4nK
	Ot5qHaTA==
X-Received: by 2002:a05:6a00:3a10:b0:842:5564:2e2a with SMTP id d2e1a72fcca58-8452442f49bmr7847090b3a.6.1781774367158;
        Thu, 18 Jun 2026 02:19:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a10:b0:842:5564:2e2a with SMTP id d2e1a72fcca58-8452442f49bmr7847058b3a.6.1781774366684;
        Thu, 18 Jun 2026 02:19:26 -0700 (PDT)
Received: from [10.133.33.90] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b00d4f5sm18512374b3a.43.2026.06.18.02.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:19:26 -0700 (PDT)
Message-ID: <bbda9e75-b46d-48e6-83b2-761962fcdf2c@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 17:19:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 3/5] wifi: ath12k: add HAL ops for monitor TLV
 header decode and alignment
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
 <20260509025819.1641630-4-miaoqing.pan@oss.qualcomm.com>
 <aa5e214f-2d9e-4c97-b45f-7181c81cf023@oss.qualcomm.com>
Content-Language: en-US
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <aa5e214f-2d9e-4c97-b45f-7181c81cf023@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNpQXsZl c=1 sm=1 tr=0 ts=6a33b820 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=qWpXrtrtBgBgn8a_gTkA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4NiBTYWx0ZWRfX6KqpRpvULCL/
 8tIzm0//OePEt3fUIKl3pO3c1A4MUtwZ9uP07tw+e+d/7STuz0WL1Xw44XWrWjqcYZvpXksFmcO
 g/82ruCziLfQt5rEXSbf8yaEza7ITOddvjFpz4+hkjFW4/Wt8OBm3stHiG/p77wYnBC9hnyJOoH
 Yk0JQuleEoGYPac/yHvlUalyXltfxGJqVLUg0ecSKPU19O3y1I78OTj8fj8aVU2G3Z6ZzhH41ke
 ASEIUg4cQTTQ8Bz+oOZCCYr5Dt+mhazaCXlWdetJF3Ac7++yCXOvlSpAlg3gQVtmHe195uvz1e1
 9o42ovartxB2WlSa9kaKt2aF94s8yWTEa24UKaH0WbwEB/olCpUTyM+4ipNkRvs59kpvDljOW7U
 tKxwxNCQbF+FdHjHYAPaJ931kTRgnMkbulQwGxJGo+64KdwTLFcNQ2fkrb2uR+sDrTqlkHNNqj6
 Joe0chR7BLS0zH4FKCw==
X-Proofpoint-ORIG-GUID: vBfeV7WwsTreT91dhOVDFjxLsOVFRqRB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4NiBTYWx0ZWRfX8DSu3MYmDhN8
 f9hIq96JSh4TAYu0GRHIGcir1aAEGc7z0CSQqK7L7dLEai3NWkapS53XGk5CP6MCgBULJXrEqLf
 LhhbXGG6XL7qpv6h0yoskYoUZKBCt4Q=
X-Proofpoint-GUID: vBfeV7WwsTreT91dhOVDFjxLsOVFRqRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180086
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37893-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:jjohnson@kernel.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C707869ED2A



On 6/18/2026 5:13 PM, Vasanthakumar Thiagarajan wrote:
> ops get_tlv_hdr_align() seems unused, may be patch 4/5 is supposed to
> used this ops instead of removing the alignment?

Used in patch 4/5:

@@ -2973,39 +2975,38 @@ ath12k_wifi7_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev,
  				  struct sk_buff *skb)
  {
  	struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
-	struct hal_tlv_64_hdr *tlv;
+	struct ath12k_hal *hal = &ar->ab->hal;
+	u8 *tlv_value, *tlv = skb->data;
  	struct ath12k_skb_rxcb *rxcb;
  	enum hal_rx_mon_status hal_status;
  	u16 tlv_tag, tlv_len;
-	u8 *ptr = skb->data;
+	u32 tlv_hdr_len;
+
+	tlv_hdr_len = hal->ops->get_tlv_hdr_align();



