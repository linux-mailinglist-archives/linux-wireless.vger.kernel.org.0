Return-Path: <linux-wireless+bounces-37843-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5CcEF3MdMmrdvAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37843-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 06:07:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16C696616
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 06:07:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=i0HbIFaU;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=PHi4jB6c;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37843-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37843-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BFC230421F2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 04:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BDC175A66;
	Wed, 17 Jun 2026 04:07:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC2165F16
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 04:07:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781669232; cv=none; b=RTdxBW5ZYEw3DhRtDqdczBJLYPTlAGaUIaR5zw4XrdfA9pk+QC/ia42q+xkF43sq9YKRonHnORFUON6trbKUDnL39jhPhK8JHyiAazIW1y93FUQqM+W7MAPuKMOoBA82y5Ir1ppl5SBEHcAL3ThlcbXadCa2BkNUirHrLrRC5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781669232; c=relaxed/simple;
	bh=IC1JdzTnrPYHRkzaBQ07ZRctqOPu55fH9HC5ljAa0F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WArh2nNnX5/fvamlrcKsd13qGqdrPiYvGh4QF2EujJwipxKnanH1ug7BjvnSxlEH/jHkUcpBNfa0RTA+limlK7Qy1iHMa033bCwPNaw3VL3HIhl+tBBJfm5FW1fj18xDklrDmfCNNlcvMpSql1+jKsQGPLPoUriuHQCc8wNxPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i0HbIFaU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PHi4jB6c; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLTZL4833763
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 04:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bGtFzS5K7FSIjPV/USiU2uAPspsmavcgKmt4Zb4HTBI=; b=i0HbIFaUuuKWiuIS
	EAtVy9U/ebi603qhUifaU3YyTebHMUtrjjVaWfTvau4KV71ssiKrYlMBKdeio8nL
	Jtlr3He8JAo7nC492mtOK44srv+cumvl+viKcq/ySYyGTrZ5xlP4fwErazAZHaAI
	P0jIRfITcWSEoDTDDBjvIp3JceOpnjkjUxXgbbXuGptV+M52eObYJczZ1hoKEQ7z
	G+Wv72CZ82QR/eh/0QPejQtLBBCBqdqYRFpN6M3eE1vP0n3Qjc+7VeQSd7V0HPXG
	NqZ8KPhKoS1ZUcTLLq+c23nUKATh7RMvflp1jbn8uwSAvNxi19K2oIx44qOK59Rd
	RkBN2g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueevh9ur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 04:07:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84240b58211so3550505b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 21:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781669229; x=1782274029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bGtFzS5K7FSIjPV/USiU2uAPspsmavcgKmt4Zb4HTBI=;
        b=PHi4jB6cZ+U4C2yabjK/wxv68RGtLjDKRjJAFApjzt4CFUdUp3o2jHxc/6ArmMeT4R
         D5SogWHz90mwrR/P0EeELpP1jqnNtmc659HCvXI7q/WhhJauN1xo6iARsRTusLvU1vWj
         mEaX4bWUDditSaOvk0/qEOQqkoN76TxR4B/EzFm3A3soDdf6WZMhUcbopGg59SFzcpL/
         qsvvgf6cjZW2anSR1pBsUc4NCD7JwlA1CIbhjxIuY2dPAnAq28u2sSCLUwpBxfeVpZzT
         ETSYbbDRK2zr66M+mM/70l6QnhZO/iLWoGxzcMj7oMn/j3+RmpyYM5TjQKnNtDkLM3lE
         hmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781669229; x=1782274029;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGtFzS5K7FSIjPV/USiU2uAPspsmavcgKmt4Zb4HTBI=;
        b=WPPhcWM6pIt1SMKCVUKcU38MucykFmvkjsL5WBBCJXBsdS8KsARWYaZoU2iS0Rc/bm
         7uF0PQI/i85UTRZbnd6R0MB9aWjsVUIpuWH6CwtBCpISuTkU84srXNmiGab+5vKSqk65
         Bmy4UZm8FcS4i9amDm9PlZAYb0P/tHswOFQ9rlpMnLdE0gnsAfmeMkgS1Ae53VVdy2XQ
         WfO74BmSXk2JLnxXpgJyYaijFHhBStS/rdkL4WCnLXV5ynoxfJHC+QGa/s5zexDEgtFZ
         txEQVKee2wko2LQYn17djC7UZPDPrkzTf5M4b7fFlKNZ34mLPgbSZERhqu3ranyODl58
         /ZXA==
X-Gm-Message-State: AOJu0Yz5tzq2TcWKjJlp98bQ1nPUSbrDWyX0K4yxREQBNBRMDex/1tcY
	QPszi/kN4Y0n39I/qYXdaVJgxJomvnRYngtjAwEZoy+uDFrC3LFC2QGc+rlfNlDm4HGVb85o5Gq
	hGz2aZfgfXnS+gGvSZfK2CoxBcIrj2/kKYfOEIjx8a18JnzBtCQdWwgLmacRerFRKTuwdzDczMJ
	Y5+g==
X-Gm-Gg: Acq92OHpASwTvQ8RENWwUgKbojTvX1vOV85F3KdmQsDWgs03vj1wIlc2XiZd4T1XtKE
	Ll1zZe19FMYMnTGm4HBXr9KFm8Bisl6cMDZ/4QSObgUqfuVQKClLnXw0GYerDMKUXknobAoUW5l
	bxMuwGufgStiPwvegcCxgzFeOtS+tjODbLrB4evT+bUZ14OWQWWzqJYpUEoCesAtgZzf9wbxwEz
	/chJTZOEyanArQfvfGsRnDWYHwwNBztcKQ0gX6yXAUeDYVkgjQVprMCDPLeuA4oOUsd4Ch628CZ
	wqCBQgnWYWUFSG63nxcWaJTSom3muggQrnfMJ7NQtCjcEV+o15J5tYda5yoJb6MQZLHjUepJDZQ
	fW5JeU4AItnoVfprV5WIPdDBkb8mBaQGa1TuofZsthDX34wxfOIw=
X-Received: by 2002:a05:6a00:2d21:b0:842:380a:1ee8 with SMTP id d2e1a72fcca58-84524464424mr2010149b3a.17.1781669228869;
        Tue, 16 Jun 2026 21:07:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d21:b0:842:380a:1ee8 with SMTP id d2e1a72fcca58-84524464424mr2010118b3a.17.1781669228408;
        Tue, 16 Jun 2026 21:07:08 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd50f7sm14044351b3a.35.2026.06.16.21.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 21:07:07 -0700 (PDT)
Message-ID: <07b84480-6cb3-4746-88d0-fdf99ccc18be@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 09:37:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: expand UserPD ID mask to support
 up to 8 PDs
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260604031551.4178754-1-aaradhana.sahu@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260604031551.4178754-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDAzNCBTYWx0ZWRfX7QypdoshNhOD
 bbTq4ivwRuUxiNwPRmUUtDDiy8AWNHhkqHxmeWtX9UktnGJlYGu3IwIeW/ZRy/nptLJPDcKF+YX
 Q1cPEG4Ak2ZgRodTC1MhxM6U5svpikvSAV4FJeJvIjA3lgKjVAZhxFtRGDsgbqfYTrhvxHtgX0H
 Yz+bn/jc/WYepbF2d4dPq3XcYcBtwhitEbZbH5vTDkfdT7oj1U9fbFtQCjfbpR5m+ITUZ4e926k
 79zfd2g8qd5qSmNBJVLDGRBqJ4q8Pd0GYNLtpFlDjmYWt/rSzEQ5EbwLivwrsYDjCcD0n7HZRWy
 P7hmfl0MAC7JbuAyhhH4lQ32jlvWh++YiPRxGpBUZyzqQLJlPE+qIf/2eu3OAe50bpA0luo4lFZ
 dr3Ga4KM2lKea0boaAlFkiJcohFsVXJJ8MeE/cFzedphxrsVDTdMjs2wXkUIjiIdHnTZQ5yWc0K
 Nw0B7oBsedVyPFexL4A==
X-Authority-Analysis: v=2.4 cv=LM1WhpW9 c=1 sm=1 tr=0 ts=6a321d6e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=qcwypVmIGuKwP8SevUEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: VedsqWH5flJp9aPh5Ry3nFNPBtjN6NHa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDAzNCBTYWx0ZWRfX2/GBL1dFCZ9Q
 33qIvEr36YV3tY9KKcmkpscM3LDqSlDnpW3de0dvi9TZLSxUjYqZrzQXVduHzmhrJNB9H53aE+n
 fI+8cOXniCg2bLO55bmhgD/p+a8RGMM=
X-Proofpoint-ORIG-GUID: VedsqWH5flJp9aPh5Ry3nFNPBtjN6NHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170034
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37843-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB16C696616

On 6/4/2026 8:45 AM, Aaradhana Sahu wrote:
> Currently ATH12K_USERPD_ID_MASK uses GENMASK(9, 8), which defines a
> 2-bit field and limits supported UserPD IDs to values 0-3.
> 
> Future IPQ5332 multi-PD platform variants support more than three
> UserPDs. Expand ATH12K_USERPD_ID_MASK to GENMASK(10, 8), increasing
> the field width to 3 bits and allowing UserPD IDs from 0-7.
> 
> ATH12K_USERPD_ID_MASK is currently used only while constructing the
> ath12k AHB PAS ID, so this change does not affect existing platforms.
> 
> Also remove the unused ATH12K_MAX_UPDS definition.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

