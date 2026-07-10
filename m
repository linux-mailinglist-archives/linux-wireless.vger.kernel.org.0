Return-Path: <linux-wireless+bounces-38844-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J/+/FDGZUGro2AIAu9opvQ
	(envelope-from <linux-wireless+bounces-38844-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 09:03:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C2C737E4E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 09:03:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="U/gfnc9J";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=YOR0OZPe;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38844-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38844-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 133A230624A8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFF9377579;
	Fri, 10 Jul 2026 06:58:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F83B388E
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 06:58:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666724; cv=none; b=Gi3yW5tY/h/uqSiHGIQ00EIKUFTLBKHaJiBj62RZ9PImCzz9/elw75KBtRbrZi3T3hesDPGx+mbdnDDzB+6bqzZW7sQiZYVOQ8ex5sN5HzdB8y+p/OjgiLbK5H2t7waFWkmSALnFS4AlGkcMvM/HNelE+GdtiJVSLxhYJkjSA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666724; c=relaxed/simple;
	bh=fKyp1TFvzj5pZbJJfWEanDSehzkXVvh8kAbEXF7JOUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2JSOeRO3azAfdxWkSLHGXK0i0BMuGOTXWI5NVn27At94jg77a4+R/w8j0h7t3BB2lDKTApwarLjOkwy3h3bYpyn1c6Uk+FErD4B1fKOJmIIEX2GaWPNLuI12dX2fSc9EPIGc3OA2m/iaiBJWTOkxx0qderyacdQ+JjB87P7dNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U/gfnc9J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YOR0OZPe; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3p4rF3855226
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 06:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yYlcCGv9F5rwLeM3JpG4cosoDRi4rsg+0+seCPsDMaM=; b=U/gfnc9JKcXkuRaG
	9BxWtucsPMxnJUEALBhYgWc8DRKnwbBFPBBdE/0PJOiYpZgw6sRgmx6sFuJFGCgL
	F8bSg9wwZlrA6Tbd19QDtM7q0e07ZkkTRCOp9HrLYIK1qUlQPQ7V3TiGK2J68EP2
	g/H9P0ate7jJlXdUT4z8LKTI67x4rW4ZY1MuM1qYw6YIiT7h8VEGXDYCNfeaAU9j
	kJ5bJ32LiC9JGW/1mP2wsumpu2Qtk/rBRgR0n/gqGx4UmD1IF9dxoPTmlnpN5kb1
	+WmJ1p1tpmOOV2Mi+WMb+96oRwQuRzKdjtCHlhLayjw+1ziZkoOQMzEP1xDJ5gzZ
	TLaCrA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0nh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 06:58:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84857446424so1166911b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 23:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783666708; x=1784271508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yYlcCGv9F5rwLeM3JpG4cosoDRi4rsg+0+seCPsDMaM=;
        b=YOR0OZPe7LjQgjTZGMZ9yHBeswigWkccGnl+FAN7yGJhcRqib2FK0ijWf2DmF4RGNk
         uJJKtZBz79j3VwZzMTD+PpikHAlD2yKL9VzCAChjV7VLhnxx/ID6sADrsDwQBUUWmPqH
         ANIVTu61Mhu1f38wB7lr1LJSd/r4p11vrZdV8aklZvkDsmDOkq7Zdz/ERHA7FbBAmDq9
         1rrPWXNXeAeYN8YUxtpce35L3ONF3OsXpJI3vvR0l1OcQZVnMWBUOrMZzlZsjbte2gBH
         PWW7nqmTJQdEf6s6xRnShWLOND6kWbwe3s63ZNEoziF+yMMQC09uR/XIYT3bZy0wehrL
         jf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783666708; x=1784271508;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yYlcCGv9F5rwLeM3JpG4cosoDRi4rsg+0+seCPsDMaM=;
        b=UIbu77hoDdhPBpyuKMvYjG9L3+PJwuMlNidqP7w/h2wCydePQ2SpzugpVyHIkplUO1
         JdF5bIWUdK7P2qnB/BiG56f4ct5WGqOSRGf2gfoIwN65UvQrWNEljBLEqZ3TbyJIMSM4
         nUyqUXuGbhDKVqKAB/9ssnpG2J1DxtjinYsJnQEUcT5GF4/JGPnxTQg4UR1+5PpDOkzj
         vqD4fyio+LToL/PKpFFactIiLgyspr4bGDye3qSdUO1ltt9jPlG8V3Ddfw0mWPlav/3Q
         mtOjyrg56xGYtkWwoSMy2UJBbB4tZwT5LZcFqxi4nklb6TLwxmRMSBe38VaF6WFZn21o
         g4Qg==
X-Gm-Message-State: AOJu0Yzabk2CQSryQlGLkcwqIT2oqpX6zobmnBWhDXxygyjirGLPoYfK
	WLI4WnrsGaWZq38WFGchI2OMOrXiFxR0mpp6NUEiZGlrXeonELHDNTtoY6EN45MquMGWgPs7OC+
	8FqLQ+kVhf2B99Nj2JsnA//OlXZqzXOoWkyF7ULFzgYjWnZe+m287IKnRcjCZTvq5BmvetA==
X-Gm-Gg: AfdE7cljpQ0TzjF5TagGAfbtGx8TGB65bPTk/AgoNfLT/6T0aW/K4hhEtzqOV5DRy/P
	7MEFPLyL4ot6ppKpGEyGJClfgPKgLP0UJrZMcOnkqlMQTrJeSZOGd2Kf98dERVGz7TYUuOoYEPU
	WIzUgu9w5QMldJj/79G1Vo4kJx3JOB5DAmjMlHRj5AFH/Oi53Am/fUmUbLY4c1HiWXk28eRvYf9
	gKqrDoEp1VfMqHOEFJ8cMSsvz96zUZqBzkVCjduQPqwEwXdylKtzcS6Avjl1A0F8iRyO+8JX4cF
	jSO5Of9G4gKvAXE/VG2nsIOechlJUcQCbIU9BYSRNR/j65FvUjwoIVEeIiJYc3WXgeZeGcdDIq9
	vYhyL2xw1dZz6b7dg5GK2plp1qKb0DQthaX4mCiCyw5ZFWmKoMPDaf/1pkActF2SLnvj7EEYJYv
	EvLdVMEfXi
X-Received: by 2002:a05:6a00:c88:b0:845:18b6:1154 with SMTP id d2e1a72fcca58-84842fea0dbmr10202167b3a.8.1783666707548;
        Thu, 09 Jul 2026 23:58:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:c88:b0:845:18b6:1154 with SMTP id d2e1a72fcca58-84842fea0dbmr10202138b3a.8.1783666706986;
        Thu, 09 Jul 2026 23:58:26 -0700 (PDT)
Received: from [10.133.33.227] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84854bf8c9asm2527585b3a.41.2026.07.09.23.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 23:58:26 -0700 (PDT)
Message-ID: <d300a113-9de5-49f7-a2a6-cae1d3323d49@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 14:58:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: update IPQ5332 BDF address offset
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260710053534.879233-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260710053534.879233-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2NCBTYWx0ZWRfX+hkrNwFU7sf6
 B+Dfo5yW/VwVxy3+H2wLh5PGvzHIDA6D45ycdjJhquISfjRbscHFYuGFTuN5LQuuV6lcb3B/R83
 NPyovH6EKLE/fpY6uh9gg+r5p8k4pNo=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a509814 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=viQb0OZrn-eQzSfuS2QA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: ltYV-v1HzPkwsi2rBdhPMAbS6P5v44gb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2NCBTYWx0ZWRfX688CcV1pZ6/U
 N29JnrphMMKFI9goy0O0p0a6Wci79T7rSmnsPLTa/8uJd9R5b07RR7P0v0rrZnnUadm5INZj2IU
 Vs+lmrYt8FxsYjCB1N4Ts96U4Wg1tctQfBpQCsqmNOCypF467lWuGvxDEsNx5amjemjvJosauu8
 xrTVovo+Ft3v2HucZxY8+zeUI1E5Wtn5JZCSMZ0IpPx9Ft9u48WbBtrR1zdX4ZJNotuA1mi60ce
 K+geifXaL+92qfqy5ulqTe+HFH18KCgupEBzmaYNdsS3vTtqRL0counaQKSTkeBgE7oWi9o7wxV
 2vpG1fQ6YYgABurC9N01AacqndOkOZo8ICAuQPUQCjCkaBAr5JXmUe7HDuoK6kzdJaplvS516nm
 SG3lKKeSOqgYO2U51xuN63JdDXUCoeFSKMKf8V53FVPhlZCflCwnXSlS3yWkz+YjsNxnRHZz0ST
 Hxxru521VsAPxx8HrYg==
X-Proofpoint-GUID: ltYV-v1HzPkwsi2rBdhPMAbS6P5v44gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100064
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38844-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95C2C737E4E



On 7/10/2026 1:35 PM, Aaradhana Sahu wrote:
> In the ath12k driver, the BDF_MEM_REGION_TYPE address is derived by
> adding a fixed bdf_addr_offset to the WCSS Q6 region base address.
> 
> The current offset (0xC00000) works only when the Q6 region contains
> the IPQ5332 ucode alone. On some IPQ5332 platform variants, additional
> devices share the same WCSS Q6 processor and place their firmware
> ucode in the same Q6 region. This results in multiple ucode sections
> within the region, and the existing offset can cause the BDF memory
> region to overlap with firmware read-only sections, which can lead to
> firmware crash and driver boot failure.
> 
> Increase the bdf_addr_offset to 0x1A00000, determined by analyzing
> firmware memory maps across all known IPQ5332 platform variants. This
> value represents the upper bound of the largest combined firmware and
> ensures all IPQ5332 variants can allocate the BDF region safely without
> overlapping firmware regions.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

