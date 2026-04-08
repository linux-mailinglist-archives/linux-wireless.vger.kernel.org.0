Return-Path: <linux-wireless+bounces-34496-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCTnBF+m1WnE8QcAu9opvQ
	(envelope-from <linux-wireless+bounces-34496-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:50:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 680B33B5C56
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBB953021700
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 00:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525172EC0B4;
	Wed,  8 Apr 2026 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8z9LAxW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="atkFKt6h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330C26158B
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609430; cv=none; b=uTEw0Fuv27G3kIeUYY+OM69G+Bgvl4v3VrWYpQQ9cBDYHi6br0yu6/5XUww8hdnhSz+cGbn7+RBgRwirJXTc5I9SxrCmJY71iWGSKqCz+mfuPbl3zv2K3RBmBzTWmRc7ppGStShE9nVB5orjObw1CGuW+fmFRWCUCdrr5Z7GS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609430; c=relaxed/simple;
	bh=75rKmNooJBR5DPjoXDRnmeUzuMRv8L9o8ENLsBwNJKc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HRu5SHVG81DmiRtZiKCwvbla4mj0PWHOG0R9ESbfgfCuUbVBkqv9FBEnPG7NptbSLN0CZRePfuG5/D2mMI65sJ4zjmC4PLG4RnxASB2twXgKSSWkYE5OF0HB955sBAkti1RVEiIt+Se0qS9NGFel8PFRP50Au4sfSTSnHEWMLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h8z9LAxW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=atkFKt6h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637M6UDO2451216
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 00:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/oayEGvkBr0JcfYTbu+bTCKJ0ZiuWTOtAGet9ZO6me4=; b=h8z9LAxWhInsgSIA
	wEbeC+kdT4VjIPGjbccnmdxgW0xHb58dxACQvs17t8LhcjrEyX5G0RhFSIe8XVjA
	XSWR0Sj3VPKVU+mmDoPJldABcXdyH6mhaNDa7ctm+CGq3T2xkx7v2/Xu3Oe96ehx
	p96ub6Rk6ma+YqM6JuQdJPmd9LIS3n1f5HucUBjlkZZ2I2nczSRQqlcKeU6MAiUZ
	sjFYqLKoWdb/kcylSasbKO0JJ6WGA/DqAmqSR432inANPt9yVPck0nu+W2bFMeLo
	UGpULzNE/Az86JbPZL2Xr1BJLtIuewP87QjiS6itpzySOVPT5Rg+pd9/lURMVOBF
	jJshjA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddae68bqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 00:50:27 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1273dfdaf5dso430683c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 17:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775609427; x=1776214227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oayEGvkBr0JcfYTbu+bTCKJ0ZiuWTOtAGet9ZO6me4=;
        b=atkFKt6h03SRnDCLfFC6iNnnpfzl9sUA2TMx1a7i7xWP0ugTySwev7z210vYQh6zkd
         vPs+maLCkp1xx/ygWOHIeX8H5gpknzBIfrMrFSysdIc2TbWQc65E6hrQiRrJigVjln5E
         Wxv+KEeOa2VWhy+rc6qZFsyOwy1TmZ6RwxC3GBCluarX88viZdd2B1HhINDWmU8v8gxs
         tcl+sGB6+uDgZhHMA+i1vUnos12euSpZCxXpoZAHpT93BekJq4vjk5ywLS0O0Po3Tzv+
         42fc76cNIreVjUP/x1H8uzNDVbX87820BSWqDY+JuegVH0MBGJG24JF2gIx+c6VYwSz5
         OAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609427; x=1776214227;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oayEGvkBr0JcfYTbu+bTCKJ0ZiuWTOtAGet9ZO6me4=;
        b=nTLACKbfjMqer+349mctyazUdBkaZ3BV77g4sd56YWcBOo1ujTPdzXK+yXFPvcmRwH
         /EtmcqMLsrDhD17gokzqU9gA0nMksoUpAMKD1kQVJn8TISBkGTkG5rB/RdGG7FE7+nvb
         Vy36zId7vczRN77PN7px5cN8ecdwTI9H3gxMpBarB2vyVUHDMF73nBQDE6GY66MQr5BT
         R5pgXewMAGEAJ0y6Pb+Uu6z/uvYjZJCkS46c6zHTwjZrRu+GdLxBw7M9jeJTyqTEU3b2
         //KeoQfoYfq3nROfOHt/PQUsREgvpoxQIpdcYoxPVaR48GYHVOypOKVyYvrCfNl0Y+5T
         17iw==
X-Gm-Message-State: AOJu0YyZ4xLLfMWhCINogpAQPNwV0ayWHK8osLVizthzfopDJMzg7qeg
	hpL/Vn0YTIyI6edD/ntrUzvrT53MbSX6X+Lk5SK+pp7tJudPS/Me0C3JC/TwUQIvz79AfXFk7Vk
	0hUgRiS4AZkYKqf2vHwlBe7vu8mElb7oNHoKjifw6/Plvv/Kt0oObiXsOSlZrhNjdBM9sSA==
X-Gm-Gg: AeBDietiMWNhKeFnajghkdYSEyH6c8ZfrtU378J1F5moIuYMchVyHqbhdZuwQFZzTdb
	be+MA3So5yf4T9xaq8j5quOh0ub2HboYXcTUYc1GgLHhatL2RvbGjpVgpYJ6+8d9CwI6xZNjsvx
	4Wwe+8AxCLkDB4l6H+vYcXqsxLdUId+NZhCueYGHw84w+H9v/WpoVZPTW3EYlObWttMjXG37ik5
	PzooktyXQ5pgTV/NhDcvE5cnGZOLkaDf8Yt7zh08z8qAUsd6+DU+sASRRUFaa7bMvrLMrapYl0v
	HY1buGiHSPAQzJAuv1sU6H1HRLo1UVLwJzmOpEA3Mpx4nUvpo0uhm1/DsSMGqYs4NPaXoQP04J8
	oi3o43wYHVhWs2mRr2wSdhpJyIXhQGls8IkyEsM286tZKZCRR3HuZpsHqi56M5fFvQ8lH4jNpWZ
	A9
X-Received: by 2002:a05:7022:e1d:b0:11a:fb0a:ceca with SMTP id a92af1059eb24-12bf08566a1mr9854680c88.16.1775609426610;
        Tue, 07 Apr 2026 17:50:26 -0700 (PDT)
X-Received: by 2002:a05:7022:e1d:b0:11a:fb0a:ceca with SMTP id a92af1059eb24-12bf08566a1mr9854671c88.16.1775609425907;
        Tue, 07 Apr 2026 17:50:25 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d2d5409fd1sm1257301eec.13.2026.04.07.17.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:50:25 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Harish Rachakonda <quic_rachakon@quicinc.com>
In-Reply-To: <20260326050641.3066562-1-roopni.devanathan@oss.qualcomm.com>
References: <20260326050641.3066562-1-roopni.devanathan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Support channel change stats
Message-Id: <177560942499.2878209.4098664055076965853.b4-ty@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 17:50:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAwMyBTYWx0ZWRfX9ZOgjwimfMh+
 zQqIIaLBc3XddvvBc6NmZ6G+NyWEAAVTqoKaLS3vxHBW3d5PoaxX7izSrOP/lpnBx6p7FWrmR1h
 KniAsypVIxuRNzd4UuNGtAoaZj4iycKQY7TVps0u6P/r5gp0jRPmGyS/odkhJ3zlVQqaqTuTB2H
 zSGMNM29Hbv75A7Zd5mv+LYgpyOs+t/2/zgOZ0M0DLAy/0nR56dZQqUvUX1e2spPscFRjhv6m/i
 pEHTGXT6l4vypynX2ZSw5ZY2Z5qV9IcWQvoAbJeJipmBOLKWpTUF3Qd9YttkliRAILvDCPpzMA8
 xUQt2Duuc8RAz4QtIBAIJ4BLUP6Sj5MxUEvr0uKvRl8Kwc27v5qxHDibPa+AvGP9nRi6Fph+5ij
 qVRU7iZ9OLvRYz2fWL/wddtoPk3SDUeqS1IiROw6NzkRxBZSBv/wvc5nJyikGI4MG/9uULN3Jq1
 mU+KfP+BK8sDAwpPh6Q==
X-Proofpoint-GUID: NQ9j9lOHPZupbhVZWEvUD-KjLONDd5Ch
X-Proofpoint-ORIG-GUID: NQ9j9lOHPZupbhVZWEvUD-KjLONDd5Ch
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69d5a653 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ifKrZIL7TpvmNkHrtDcA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080003
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34496-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 680B33B5C56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 26 Mar 2026 10:36:41 +0530, Roopni Devanathan wrote:
> Add support to request channel change stats from the firmware through
> HTT stats type 76. These stats give channel switch details like the
> channel that the radio changed to, its center frequency, time taken
> for the switch, chainmask details, etc.
> 
> Sample output:
> echo 76 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> Channel Change Timings:
> |PRIMARY CHANNEL FREQ|BANDWIDTH CENTER FREQ|PHYMODE|TX_CHAINMASK|RX_CHAINMASK|SWITCH TIME(us)|INI(us)|TPC+CTL(us)|CAL(us)|MISC(us)|CTL(us)|SW PROFILE|
> |                5200|                 5200|     24|          15|          15|         448850|   2410|      10546| 434593|    1071|   1100|         4|
> |                5240|                 5240|     24|          15|          15|         450730|   4106|      10524| 434528|    1306|   1150|         4|
> |                5180|                 5210|     26|          15|          15|         467894|   4764|      10438| 451101|    1337|   1508|         4|
> |                5200|                 5200|      0|          15|          15|          13838|   2692|       1736|   8558|     686|    802|         6|
> |                5180|                 5180|      0|          15|          15|          13465|   3207|        855|   8579|     578|    760|         6|
> |                5200|                 5200|     24|          15|          15|         570321|   2441|      10439| 555661|    1574|    949|         4|
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Support channel change stats
      commit: af5708ed67fc562bc45fafbd0f95789c464c0105

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


