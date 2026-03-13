Return-Path: <linux-wireless+bounces-33177-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGzMEjB6s2kZXAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33177-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 03:45:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4827CDDB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 03:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60C9130AB845
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 02:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9EB33FE06;
	Fri, 13 Mar 2026 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJbRNwxa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QyrecCBJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB1E1A681F
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369901; cv=none; b=gdvKOfR6wIG0VroATexs5d8N+K7eWxsgSfoXZbAkb9G+2Txz8B3bjE7weB+FsVpCVahUzpHbjqhKEXZHMxULdXkpEt8WKQmegiF4rQO8cnDodwKsEKrtq8v7wgsF2xl7TUdJE1I/EAkK6YVpnzzuSrngCAF6RVRrEhX0Boup9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369901; c=relaxed/simple;
	bh=8/NJB35AdKrR/aXcBjIDCakUMBw+grM65cuAIzxZVGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uY1skL7rVIzc6M19s/SXVn8gO0SVQKzBkwcKzkDBNCPqyUMTmp06Q0pHl21IlxgX/0mudC9VH4WOvcYykNPiYga8oT3X9jPv7WJ0m5Qh76F7XnlycMr4JLQuaw1OiRggO/DljLXqwebncHr92PKZ1q0n/JcT/DpSYOXMJ05wCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJbRNwxa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QyrecCBJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CI2Pou4133000
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 02:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fRAKzLrTUACG7+9Y1arYEb3137UjTwTGDq/sWJpNAI8=; b=HJbRNwxaSht0Dk22
	TfShIPbO79ZK3o9dfg7GovCtsL1sB8V+w1zrS6fZ48wzGXq8DBCUNCehO3ITYGt8
	052HTH88TKahiTOmMvtMSfvLNCLFvTyGqtLL746TiZq4XcxRZcpSTApyNTNczWbO
	ZL3np0Jck6YC/6E58T+MxxbxNensbAyYLFhjIPd0TfY3ZZp6W+ItKZV+8IKH8vb5
	zqQM7Nr9uEAPaXKSbXUhrNp4HdLtT0RfxpcAD5gNm434XKI8qM46q3opyl5K+6Ey
	BrUMw3n9Kday/Hpc3LFb/W/l/Yn09jynukMa5RI+5U3cCqegE5Fj7OJYbXjC4F4O
	cQNxNQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4w47vg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 02:44:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8298150caddso1330511b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773369899; x=1773974699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRAKzLrTUACG7+9Y1arYEb3137UjTwTGDq/sWJpNAI8=;
        b=QyrecCBJGm2HN5m2rZ+e3uuz8ATTxtvlc2DXsqKF05fUhEH727CuDiCUJDTKsjU1HR
         7KCZkITc/vvsqMNJZZsh6zQtb4/XNq3rHAuSsCREzhE4NQpVmlLBjQh5/Mmj43qaxuev
         226Ciwol4/ggWwbZqPYpVEbft6T7NySrrtGl6ONuQezvaMOq7IZUtMLw2SnaKLbk1Wp3
         4Nj4noOwwg0jdhBMeYS1wmUj1sQUI4lr7andLNRd+aWW5Ak173HO/yRIVNoDA42HgRXa
         yiZTpwCVY6jvWWNDB9E+PhMYMaIrQdyVE/4FVuU7vp+JQ6Qwt1hMbBeX7yJH5989JaBJ
         H7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773369899; x=1773974699;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRAKzLrTUACG7+9Y1arYEb3137UjTwTGDq/sWJpNAI8=;
        b=W2ER6zwcKS5nQd230a+3B36Dg4n1BowF/NkaHaSNAK5jcH3IT/aCdyhl3bJ/HFp/FS
         fs+zLbp1AncmuV0eLxyq/yyTG9dVRlyJZpDVJDOxvKSWRp/9wLd/H0G6DcperM6+z2S6
         T8yztrCAcmhor6/VZ9Y29Nz/xcJtnYhQEHnG18UgTSh3K2zroIcFT1+EZYgBJxMN8diU
         CZyGXFO/MqttjMltsb6kv2qI/2z1CinM7f+KLeMYQDOdqnWallUgiybodSiRSgdUb6QS
         spsGz9ZCpTS39rMhNxJsBsQP2e9Uryp1Su2dWKcFdcGtRFof5l0x55rKg9OSLoNldk/z
         ekgA==
X-Forwarded-Encrypted: i=1; AJvYcCVedjGlQx9DirIC76WJMrytkOcIX5QFp1BMBtnwBeKVhOzkl4CA1y4UMy1v7VzEZcYupj0fl2CfgrBnpOlRyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0jEG0nVhS2NZPHEFgpXZwcW2Hbf0WnWWB0DFsGe9z9Zo0oM9
	qyIZg0GT6OBiVv3CNZ0Azgl1eD1qsWGewAPpVZ04qmPi5FU4PrkoHk4XruIOr1S5Bbzfkq8FadT
	dYucyA2tEiy4S2gV7sdesFu2ky4Wx0z7OWPJJKfuhbGgxjA8hI43dT+RwA7qiUuonzFrrow==
X-Gm-Gg: ATEYQzzWoF0reKC8RIOp8L71x/vApFxRT1UionBMA8odGIOW0XR0+EL3MGJwwC5UthH
	Geq8DX0Dm7Q9UNnlW+q63xW+QO6qBtUhNxXHyDxhADZS0GqVvLOC0gZNB5odGddvxRi3gBSPpBD
	6pVr211UdlVQmiMkub480T3Cp6hyaNWbVejmciAP9TGHceWB8c478Lf50RBocaAoRmE2OSVHxPy
	31G7EqvyVJe0PRtxObx29jgPTD3XAKrBSKyIQzexVLNBGljIjmY6zZEdhgNEQ7Ojds8g+9fuqHA
	/8pZ3sUtLGFDqbonALjMe2gc1X2av8BJJN54y1QQAzKTZVgQKeVoouXDahSx/dioJyLw0LZpWAb
	rGEHrRcAsDuJXvgJ7eZYw+fo/TO4KcYPJor4nlhigOxJ1+2BvC+0prr4AbgTIzF72X+7NkYljdr
	mM3gTPwudeeCFD99imhA==
X-Received: by 2002:a05:6a00:909b:b0:829:803e:6798 with SMTP id d2e1a72fcca58-82a1990205fmr1198292b3a.56.1773369898701;
        Thu, 12 Mar 2026 19:44:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:909b:b0:829:803e:6798 with SMTP id d2e1a72fcca58-82a1990205fmr1198279b3a.56.1773369898268;
        Thu, 12 Mar 2026 19:44:58 -0700 (PDT)
Received: from [10.133.33.71] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0724407csm4196019b3a.8.2026.03.12.19.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 19:44:58 -0700 (PDT)
Message-ID: <6948d3fb-d3aa-47c8-9a40-4ad8e3b72ce7@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 10:44:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260311102416.224621-1-alexander.wilhelm@westermo.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260311102416.224621-1-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 48kS0g_GwXKL5ozraE3QhK_zdZ9K5Nvg
X-Authority-Analysis: v=2.4 cv=Cpays34D c=1 sm=1 tr=0 ts=69b37a2b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8 a=mClSoXhwh1Xnl1UuZHkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: 48kS0g_GwXKL5ozraE3QhK_zdZ9K5Nvg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDAyMSBTYWx0ZWRfX+KEN8osMLfli
 VGDD5D1TE50aT1ywiE3x+h68MOmxwB0p7DJKnm7JpJ8Or+wuLN5SdqPyyj8vhooOjccaTrE3N2t
 Lvs8K9fLfXy+9Mak8uKhnzMEEYfvFlcqo5YLDlQambJD+fqhEBJMrHwfclCFApaP8w6iDtDlZju
 S+dvaeNpx2hpUij6PnC64PjrvnGdB9qiu12CEVziYDzxZSBh17eytTl81gaxO+IlnoLibBi6SbS
 NN8Zf+X3xT5KLAyJgO8eaWKSkPIP8hauXBqM5XjqUEj9RjV8NYuy+mgyvu0OAj41ArsUuaSO48m
 il5QaFmeHGE4IG7xUwc4nW2pCRIxaAbhPg/XSHBfe9xRSlW6t9zkA8A3qRW5sIgWayVXFrVg0RW
 YpopFLMAnxelVp1uHrmwoSHf3+srkRQPhAs0pEb8cend5QOAJb7yWqMgP8a1KTtlnbbbBtSEoeo
 U2Zcj41ilOwxlazwJsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130021
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33177-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,cgeckpatch.pl:url,westermo.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A1D4827CDDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/11/2026 6:24 PM, Alexander Wilhelm wrote:
> The SRNG head and tail ring pointers are stored in device memory as
> little-endian values. On big-endian systems, direct dereferencing of these
> pointers leads to incorrect values being read or written, causing ring
> management issues and potentially breaking data flow.
> 
> This patch ensures all accesses to SRNG ring pointers use the appropriate
> endianness conversions. This affects both read and write paths for source
> and destination rings, as well as debug output. The changes guarantee
> correct operation on both little- and big-endian architectures.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Changes in v4:
> - Rebase on latest 'ath' master
> - Remove volatile from `hp_addr` due to the `checkpatch.pl` warning

by 'cgeckpatch.pl wanring' did you mean below ?

"
WARNING: Use of volatile is usually wrong: see
Documentation/process/volatile-considered-harmful.rst
#64: FILE: drivers/net/wireless/ath/ath12k/hal.c:504:
+                       *(volatile __le32 *)srng->u.src_ring.tp_addr);
"

But the documentation clearly says that the case here is one of a few rare situations
where volatile makes sense:

"
  - Pointers to data structures in coherent memory which might be modified
    by I/O devices can, sometimes, legitimately be volatile.  A ring buffer
    used by a network adapter, where that adapter changes pointers to
    indicate which descriptors have been processed, is an example of this
    type of situation.
"


