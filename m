Return-Path: <linux-wireless+bounces-35953-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIJZCSM1+mlLKwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35953-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 20:21:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E984D292A
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 20:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2292E301435B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7393F4A33EF;
	Tue,  5 May 2026 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K3lsaq+X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YFE5BSLS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21747DD67
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005276; cv=none; b=Df/Gi55P0iFoDrH8/zeJdy9c+l5zp7N8Qc3WJR7HKa7NgVTDwTDQqmuY9CIIqOzwp+oJ0u4+vVDPVBxxexLVsi4b8AYD2FH4HXHjja8Q7s6cFmVSUHbAEFM5bO+1skrojaAPAW9dohgGcd0RP7+0eOyWxciJEoNge33RKb4DsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005276; c=relaxed/simple;
	bh=q3on6vu4RFRoJHxsHMB2RvdNlrm+SW5B5JUNIznhbZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ey+ZKQmY7AQiaFHclyd9Xfe5wPe37LRpLx/+bYEQLXgB0drwQfTGfzF4RFNHlVpyKIQpFAMD25KV+tTwHq8ZeCwl7IF0ZKUrwXKkWHqMkhEY7GJUUsdVPAHV/DY+RVE5n/A1NLp6icCxqMw5QBw23yA0x6/88/k0IWfz3WxyCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K3lsaq+X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YFE5BSLS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EL58p152202
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 18:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dOsUUMt6BTrN0BjStRiRjvAMP7d+NymxNXe+fzOcsqc=; b=K3lsaq+XW/YDmhre
	ZPGu7IMZNviYuO8CB2TlKGrpiLiAomsTc9FxBVe4bQ8r5wxhIrW/esSBfyoqlR/B
	DGjd05Dab+fzwbtupH8l+wQax7m0Aof2JFSzG7vRDX9gjYhfVhCJbbfCrlvXKyYt
	3/evZdsBdQRsT4xNcPIn3E8IfA3QbMiRusYhoJQxAnC7oc5AfBp7Vi3wEPsbGjSb
	oIcCe7z3+oD8YpKFKqkHB9Q425ZAH/FQQZy7Vp82MWOBwLdVYJej47wg3XR7zQ+j
	W/2XSaezEsOTgMG+0V7GvXlfpFyOqjzOBUcfqZuQZqRQLLlWqPyGOQ8O7W5AWSt+
	TtipsA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj8092a7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 18:21:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso5549354eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778005273; x=1778610073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOsUUMt6BTrN0BjStRiRjvAMP7d+NymxNXe+fzOcsqc=;
        b=YFE5BSLSIjBRyEz6zSrSpw1CmC8aljRSElnu+G3KFyYlgYTnQ4TxS4CG7psTVu9nlV
         FPxOmn+vZUIk3o+H0GDi1l5No/ZacKn5DGFibs9D7l2gCfduBi0bLfUFakJQLBtv8A6C
         qE8Xz6b4iqYBZfGM7KCGyTEZSSt2+6K2UuxeIeXBj6DzP19Q5f7iZQfzfVvf27D+w/9B
         J6RFZMTVBFDg2MoXvnIhXvL5dLG47fnYt2YDcXRzw9lMyvTMtFVVNUssb/DA5MBL/nUW
         ZJU/M5V9pMD7JYP+n5pOLlC9yxfj4g2JZNy5UlZDGlRLZlZPUp8oyv+EOwf4LHXHxtcY
         cuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005273; x=1778610073;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOsUUMt6BTrN0BjStRiRjvAMP7d+NymxNXe+fzOcsqc=;
        b=TyWOgqETX6jl8LbW/dGeY7elTtNxWmNZQtoVeYTMFY/3sJBl455fLKrmzbe2MVLn3o
         lsyw0aImzwowVBc34TrN/nIb7nVst3xHK69bOkDjTwKS1PzU1TxDX1uNHvLD7wdUq2r5
         frQInSAC0nIZnaWMiXbILCzOyIHIA6CWRAkAltf9/+/lXQq8Uheqb8kWLd2GVqDY0WWS
         Lpk2jaZVavecY5/Gwo4B5s6sqUkZxw45bhHKNeV9NBEzkLI/6y96RlsVQUwSlaNqyiky
         xv8hpMd2yA2YNRYp5EXD5oTWDXIZsbni+vCmXqnmPRMCQaf9v29y5PAeDQWxwlhofuvB
         8+eg==
X-Forwarded-Encrypted: i=1; AFNElJ/JlLPxCk5ILgsIOHFBgYf0M1rmTP3T4oKyVMEd054KgNgRKk3Uxu7idy9SbncoCEBhJSBXQtpl/dzDiH4GKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIWfu9xF95J8wpasafLHeKEpJ+b0xXWMSfnFE6GJW3gUj7nJnb
	9d4SwEQyhmBqZhs/0Snddy9satBRyriILCcut0ieAC/BSmWTO23au0LrJmezeC/bZEFm2wpmlue
	bPwF/ggdYOBqwDIbl1hVp0Hbho5vziVSpw818iTijUQFp4Wsff1/6VU7aBp4noV6JWjAg7M69vs
	U4sQ==
X-Gm-Gg: AeBDieu1BsmGyyLwwmz6x7y+Ca0A0Otg3s6nHyIdkus2aWpN9XVehpXYFXmbOUfaick
	5Y9wL0Cc0G70Y+Qt4BgOX0gf9BIaum7VLvxsr8DFmJcZUBHcV0ZwKYqA4bdf92QCaEQCOzDpMSq
	9/++6fm7Ks/Cm4UStFaGxCaFpUNr9J95RcxW0So39qeSFuzWH6S/SdP9fro+XLO/5kg/KnFy9HS
	Fnmb9fp8hk+3kA3NP9wKvsMaGk2o/x9XW4J0kfotR+2WOx1euY6zrEu+1cDLEeZMZIgJy4kCj80
	gqeOSBe5vxhuuM7iB99d1Jlilm9x1lxmY/YBFSZUOH0C/XsE0oL6dCTRcb6Rt3XPdyNIjQSeEHU
	dsKxmCrphNKehEI1dvPVSdaHszjqCweKvpaDTVWEPUn30rCQ2aeZb7RUldn7/o0ZJfZNtx89UB7
	stLKWsOFrM0BFbc7hL
X-Received: by 2002:a05:7022:672c:b0:12d:de3f:f3e8 with SMTP id a92af1059eb24-131a69f54a8mr121182c88.40.1778005273247;
        Tue, 05 May 2026 11:21:13 -0700 (PDT)
X-Received: by 2002:a05:7022:672c:b0:12d:de3f:f3e8 with SMTP id a92af1059eb24-131a69f54a8mr121160c88.40.1778005272684;
        Tue, 05 May 2026 11:21:12 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df845e220sm24006184c88.15.2026.05.05.11.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 11:21:12 -0700 (PDT)
Message-ID: <775d31ee-47a2-4c45-b413-f88771f64e97@oss.qualcomm.com>
Date: Tue, 5 May 2026 11:21:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath9k: fix OOB access from firmware tx status
 queue ID
To: Tristan Madani <tristmd@gmail.com>
Cc: Toke Hoiland-Jorgensen <toke@toke.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260415222343.1540564-1-tristmd@gmail.com>
 <177758464420.1848985.2616333328470266377.b4-ty@oss.qualcomm.com>
 <177792000685.1981216.17336161796486784437@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <177792000685.1981216.17336161796486784437@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XvnK/1F9 c=1 sm=1 tr=0 ts=69fa351a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=J_-Nd1mkAAAA:8 a=6zEim6sfw6TwFx-W-GsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-ORIG-GUID: eA7o0Y53caK1lYyAlvgr0X-Zfi1_MeSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3OCBTYWx0ZWRfXzhjGBmh/6+0U
 UO/xWu+zg8MOxSe1MjLB5/qeyq1sl2gnjsooXle3ywqyud3HN5+EWaP0MWP4jFk4rNzJ2XU659C
 KGvG4DDaSHA7alVANoXris8xYzXwueT3vJ4RfzL/OM4/EuAB2hskhc41mZ4wt5QY9HvjUFuzaKO
 ZWgEukMY0YrDVg5/40tpErymzopcPPTzt+cKhuyTThfJ/PpErS6Ad23x8l1bDaeZLI61WXhSo+l
 ImqoDen/7qNKbICk+3edgd6b3D3xmStWZLwZ0X1CPm0ZV5LRQxGCX32m32OUHukT9aGTi2Dua69
 +PvldJcNGxuanQw2XZ/fHVPKNIfJiXwGZz+z8GTQ8kOtRGk0PI7K0aitOxvBPh+VlLNIxrptxFY
 EzDJR2YoLR/SK6B/GACPSl3T/oFGlGhBsiTVvP17H6xH8xdmEErfwdvio2Jhffxt+UeJKyK7DB6
 1nL8w6zbzWEZ+oGIqgg==
X-Proofpoint-GUID: eA7o0Y53caK1lYyAlvgr0X-Zfi1_MeSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050178
X-Rspamd-Queue-Id: B3E984D292A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35953-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/4/2026 11:40 AM, Tristan Madani wrote:
> Thanks for applying, Jeff.
> 
> Would you mind adding a Reported-by tag as well? I am both the finder
> and the fixer:
> 
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
Unfortunately that is a public immutable branch so the commit can no longer be
modified.

/jeff

