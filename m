Return-Path: <linux-wireless+bounces-33329-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ASEAHoXuWmOpgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33329-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:57:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9BD2A619B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B4E73042941
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A7E39E6CB;
	Tue, 17 Mar 2026 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iUbIHtBl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DuJApeQs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847039DBD9
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737840; cv=none; b=mulW9M/UcUo46pQ8OM8SZvU91oEx1DjXB8H7HQScqKuZz1h73144vrrK25R9Hh5oAR0nQJ9cyWZHHWTEzlc3Qu7Wn1fJOIXXFJC8AeU4+YVhbnfkRBZOpIKGWXIchmzxICHAXnaHYB4USxDtiZQ+23JCsJCaEURHOtZ4wcJ+/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737840; c=relaxed/simple;
	bh=myz6m8b4+tP0wxJJ8hY5Mp77suIGXmfzbkFMeJvBpYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8sahLneoG5a3bm9l/D/6s2X2JFR4e5rWPIzef8WlGwwVvNOu52zmGq9GUqLbVJwPOtp1VuLyun/ADouwyjmrm5lagyw6hltOVofZY4E8bl/cOcKUf48YS7kOE2LrKCnNxKJU137n28PAdRHugqdbW8ns6I13m0yv4HCQm1a4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iUbIHtBl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DuJApeQs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7JDLp3124058
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 08:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OV3obMQI/7J+K630Ukd+PgokDskPuEquhbpR1hWlpzg=; b=iUbIHtBllTEH6Rw0
	2lDK34soUaJvKtWFlJEp5DP9AbFgAonniIhUbmFYFkeUURa7STOxxloFbCd0YFI7
	tUR1TatwSMciw/+Zm7qTxXzz6UmCIiwRh2+BYLdRIs0rCrXyMVW0AfQlgLaHt3Lo
	elje1lOyWB05bC4DALFgHYKovxAIBA7TOxowyUnjBLiUhdygBfawWI9GCFRtmt92
	RF46+JeG9MhMk31QlBsHNN2Hgpc+EXNJqPIezmt9AvAAE7o//rcE/lXJdXUY0z+o
	cf6THapayIvToTdunrgDdMvRT8L8IEXbNVtuFDdZrsIr/jLIFqiOPVDCPtJ2ibtG
	CM0RSg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy2fbrbkp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 08:57:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso6277179a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773737835; x=1774342635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OV3obMQI/7J+K630Ukd+PgokDskPuEquhbpR1hWlpzg=;
        b=DuJApeQs1JCR9T6YCv2xl+pdfReiGbsBZ4212cjfgYETwk665XE2NysqZoi1c9ZeDq
         STVAVtPCfxR+h9VH2lRM/y2Q7eu8Je1tKU1uE3Wsz9ZcjK6IHlp/E1X0mvBa5XDUyw6y
         OwMJhZA7LsXWNOwdF4hk7H1nzX8KTvgqnSWM4X+/qHEtoV2L82vhVf7egpxVEfS9u3li
         /Gex1H4jUIG2BTTLsdlElmoYPz2JamyK2NJzci5H5j0nKz4AXtMNvenypAzxdwtzxjqO
         m9FH20USnv1VEXvGn7b2g/Ai9QiQTLt2NZLLPxqX639fKgxYAzRL/KTtzdJ7iL39D1qg
         w4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773737835; x=1774342635;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OV3obMQI/7J+K630Ukd+PgokDskPuEquhbpR1hWlpzg=;
        b=InNxiz0cuJZrDxMXLonJ34Od7OgCo9qzBzq2avOVHm25j2oCCWnIhFF7bx+QEFOitZ
         nPHTYtxHRwKkBZIu+EaPVD1oqUTDrBz8OMaUwo9ugyDSIHCASdPZ29J6ulyfHj3Z7rDh
         BRJdShvazLtN8ZySVlkOMIxNc/Pxd73z3UUK7T8ddIezVJe4SbSNwSJEtzFIHEAoQS2+
         qVT090X23YonagRWa7w9KWZstffp9tMdsX/hTqLx6llC96KPJsgxLywfz84Zd/vVuBEk
         a5JIVEVhfEhW2UMyTjDsdtuqDNmxX3+1r5UNVsCxfZu6FDby8qPITN6u2CLfRJoGNIih
         2SSA==
X-Gm-Message-State: AOJu0YwiECAhlDgV9Zrq9VwLwpVcp0xpvt9IAQLPnh0pWqDfFBQK1wsk
	aIwOo+Nxt0p5EPJoJDR7H2uIbxujDu0YIn8Frijf/26LAVOL1Ohc+qWsJL/8vMxHLCiDQ0022NG
	5t/+tDSXS3ITm8aX5rW7a/gEB1LqiE3p+LeC3v6mIh+AxFpuGEC5qZOQ+JRKx764pJqdP2Q==
X-Gm-Gg: ATEYQzzlWRSW2SmrM/kSI2A9yXmfOBkQeBsS+NyDSsfLt/kfGbgi4oWrtPqQ3oAx3lr
	c2APCJE0T6vBKiqQVRFMmScOE88B+xjypF+PuVXjtDs5aDUCQPWA7jGJ+Tc5aqRBNHC0IGaKkee
	vI+ZL0uG2LVy/EzoqrowJUpo/LZJGhhG62bhTDP7FriIncobixK8guzV8Ihb3spuqqSIVpCrRYS
	avLFMHbpqRzT/phEP/DTTDYWrmKA7UOUAcmYeoFNjyXBzc/WP88SD6c/UzSd5RT26SZisdO//S5
	d4Ej+4j/PV2YTBxx0pAs56bU0ZVuAs0cd7TOmbOpLknSUb+3MFu+J6ogY2tosS+353ybgAMJto3
	hhmoW+9Q67fDetkGyili61a4BoHyjC4lDie4VXeTI9Sle6wH7r7SwTi0eSD8Gl0Gn3pkpYu7Q61
	mFJP9lA0oPjfJGKGymL9g=
X-Received: by 2002:a17:90b:5345:b0:35b:93d8:6ab7 with SMTP id 98e67ed59e1d1-35b93d86c97mr8176172a91.28.1773737835506;
        Tue, 17 Mar 2026 01:57:15 -0700 (PDT)
X-Received: by 2002:a17:90b:5345:b0:35b:93d8:6ab7 with SMTP id 98e67ed59e1d1-35b93d86c97mr8176153a91.28.1773737835050;
        Tue, 17 Mar 2026 01:57:15 -0700 (PDT)
Received: from [10.133.33.128] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada742absm2229106a91.10.2026.03.17.01.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 01:57:14 -0700 (PDT)
Message-ID: <7e71e5cd-3d28-4ece-8d11-c6ac8f7bab1f@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 16:57:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260317084740.3756880-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260317084740.3756880-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2Yk4F42HtRfltxtvpptJj23mPaxWLqQN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA3OCBTYWx0ZWRfX2p5LEGqdAiYJ
 XjoCZd0XJiXfQwHU1pT8/ygxjBzYssRisA9TQjif1Sqyo0YNhhYxFOBDNuuZs5pVCMhu+BtUwo9
 KJhPqE5+25UB5JlSw9k8KWyNBF27a/NeJZjstHYr+YWHO5TTfPWfafySQHOoP2WUtvq65CWTXrd
 UfpxYsOyz6hwh9zF7Z8q9h2kIvnVluLeDkwrgM6j0gh3MFXIvVXT+qFbQElqR6CbNjyqkz4WVod
 t9JeCdpym6wPj5eihiEQDfrgqUtTYHRZAZMw5EwW3ookDHxLe/85kU1xwh6p2bbSQo+6SaBeW1m
 cYW9WGAk0Lo4qM3F9obDG4gCM2v9ARLFP/aeroEe+weiWY3cWhH+PUhh3zIDZftlwc4vQc6lMqb
 H+rUjJndnbdc/0WrWMZVE0GjRVypb/WbEzcsfjrTjVmqbDrU2JFBZBFRkCgA6iT20sRAijbhbAG
 mkY6fIKGDLXiq9Cjwyw==
X-Authority-Analysis: v=2.4 cv=fa6gCkQF c=1 sm=1 tr=0 ts=69b9176c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=2fhWZu5mPpoZkjORUEUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 2Yk4F42HtRfltxtvpptJj23mPaxWLqQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170078
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33329-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E9BD2A619B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/2026 4:47 PM, Nicolas Escande wrote:
> On each WMI message received from the hardware, we alloc a temporary array
> of WMI_TAG_MAX entries of type void *. This array is then populated with
> pointers of parsed structs depending on the WMI type, and then freed. This
> alloc can fail when memory pressure in the system is high enough.
> 
> Given the fact that it is scheduled in softirq with the system_bh_wq, we
> should not be able to parse more than one WMI message per CPU at any time.
> 
> So instead lets move to a per cpu allocated array, that is reused across
> calls: ath12K_wmi_tb that lives in wmi.c of the ath12K module. To alloc &
> free we added two new module_init/exit functions for the module and two
> new wmi functions to alloc/free this memory.
> 
> ath12k_wmi_tlv_parse_alloc() and ath12k_wmi_tlv_parse() are merged
> together as it no longer allocs mem but returns the existing per-cpu one.
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

