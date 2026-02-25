Return-Path: <linux-wireless+bounces-32178-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLyuENkIn2neYgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32178-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 15:36:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C1198CF2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 15:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A754130439C5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3532C3B5304;
	Wed, 25 Feb 2026 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AqNt63yI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d7pGJvwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF363B8BB5
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030146; cv=none; b=i+O5MZOHlxjDnf6O7rtWuTYxwm9P/m1+1sgObektNnMXps1mq8/56SeZqpvfnKKXFBfQt7OIlJjx4X3Xnda3hDvdwa8rDGLLM2cg1b6ZOGLTqveEt/LodWofn8UGxJqgFBcbl5cdenqOpL1rx1EPiInMd3x0OYn6b4e1pKcnz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030146; c=relaxed/simple;
	bh=d/uiwqBU4ToizU0f4PtPuKFbdsRdDqaWt63ts1S0YWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iz0rdbqHhvolr7A616aFTS4+I6NggBkR+TUyZxH1lmBovpuoVi2KNM7fHtVgcGmP2n1KVUy7d3s9EvksG2ijBdjn2eddSxYm8LBBzsscYdtdbPQTRdjcBUxxIaPuaGSdzC2Q0UPdksMGBjKHDaa2K73scTFty+CWR56d5H7B+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AqNt63yI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d7pGJvwh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PB3SiF1512166
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 14:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mqQ3ayJ2d8gZzfwZpLATgNYy1XPgI1m/wWKy2F5sGWw=; b=AqNt63yIFdzh7W+c
	ZOZC90xpoL93QXyOtvU/QjoVTQezyW9sdr2C/z01vKNx3oPGg5Q7fZNDi7TI57r+
	RqI4YWNlU2W16u9a//TGIIMTdgiHCE31bhAptSV40k3lW9BBaYnZ+6DaPNRtgRTv
	z3cWQLV/gWGLpvzvCqFuoKAv9SthmmoyKAqlHkW1n/kJ9hW+y3aL10hnVAEJMMGr
	GMN2C9EsLq4hiOlA5ojQE2dlaoUx+AQa5UPJCceBPyEBESY8Ect491/fzU+uyKS1
	vckEy5hiZPNvZQSKevKJT1V4eQbt4bTSCqQBkPKynBMVpnwFV3zgKkh/SRdrWw22
	oACUQQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyvf0hsy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 14:35:42 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d192f35a9dso65847301a34.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 06:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772030142; x=1772634942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqQ3ayJ2d8gZzfwZpLATgNYy1XPgI1m/wWKy2F5sGWw=;
        b=d7pGJvwhxCe0JhKe1He6VtTMYrR0YJ6DJQSAr2ihY6FagopyZJnQuFOZr4TNYGOwot
         M2OYUSSR1z5wHFmJTD65uhK9w1H9O2x69EkslOkDDJBXERkCMZxRUOq4A/XpnIfdWpk7
         LT1JWMh6xoLT0SnxdKbfPgVb3ayAd2Z7tZ5+hghwvNL6HYbthyiy6HnKSlrb6Iw518xD
         ou3vT/JpaMzz4EBAaf6HJDd3fTkyFgVOA+XV/au05Zqe7ieHNqaulddaoUdUd5cFxzr5
         S0cdWD9WFMLR/HmSW0pid32e+HA2evS4lh8IpSzQiARvkD9B2nMKqYSioU8Z8qAu3Tzc
         IJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772030142; x=1772634942;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqQ3ayJ2d8gZzfwZpLATgNYy1XPgI1m/wWKy2F5sGWw=;
        b=ZQQYzwYeQcQgHse2cUZCMNMy9TnXpVfYD/xf3LDsmCA45IFt+T5ASjqBkvXOR/2zZl
         yhrV/dz4bE0FrGpOF5pOzVPD+X9TWDvahLsT6Z30PYF9NcBa9myY0gXnrNx0bEkSRRp3
         5zg0VlZb0B2Ssk8F3HGhgitVBEitYl7cVk5LzdUbQzBLh/9Hgcl4Nl9fpHkYe83/u2Xy
         IGGjWOWEMT/sj9kBaFyaOLs868P7bMW5DsN8KJq9VpiYmzFBxu9vafRJwui07K4q+1zi
         QqSMzabGuko4EPvnTJFL/vVwqmY3BDuYhHrVeffRuO7hXHHuGFa4WUopkJmQQSp5R4UD
         7WrA==
X-Gm-Message-State: AOJu0YymkbI5ENFEfUH2tETrEq4o8aldKY2DJT45Q7Wb8X+C/QxIGWPB
	Udd3KgI480t9gUrMA6prjSuM7Aa91pOPvSv/h9PD3XhBwR8vItdIt5mALCEjsJlcxz6GOJJ9h29
	qgb3VaHndrOHhZb6U6/mEV7VFm2r6Pddv7sC0D/Ch9j6Hf7vYYRWLmqNz5klQEq1SAm4k/Q==
X-Gm-Gg: ATEYQzxof+7y/xKmFmlsq/PNd2bpfOy24JA8vnfAhfQJgPoIkyNCTXaqI+ghCpA1YAJ
	7WZwgciXJc8fG5INtkQSn1NmFoTX3YNr9DKHDWiMDbLYED+gTtjsVjL91IVjO2x1pRbId8IdrWR
	jI94W0IIk3zgCkgaE7iWFYhfYiz0Qn1gSEt0CDh61k59Rp9N7qFo53Chbj9uS5oomD3JyXl3PNa
	SyrzO8kRtQHfBsM0NCHxamsx2c04Ay8aBfmG4ObrOd4rHr18ylT0U+gbgR5tZhIfRXLS9CeUzBv
	tCySa1FtBmcCxLWMgwjonNSSx0519F06nIWD6xnwbhvMLeXp9qORNTZZ/vYiyKN6nQpfdsukpdt
	hSGswkeGh5mHIcaM4ybqL8bHbSfwlKv5c4kcBNgUAP7x0E1umEw5H9GWpYvazmbylCPqmBzsavp
	W7Zw+dQw==
X-Received: by 2002:a05:6830:6c13:b0:7c7:64b7:83e2 with SMTP id 46e09a7af769-7d582a9831dmr300809a34.31.1772030142386;
        Wed, 25 Feb 2026 06:35:42 -0800 (PST)
X-Received: by 2002:a05:6830:6c13:b0:7c7:64b7:83e2 with SMTP id 46e09a7af769-7d582a9831dmr300792a34.31.1772030142071;
        Wed, 25 Feb 2026 06:35:42 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cf78736sm13467883a34.5.2026.02.25.06.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 06:35:41 -0800 (PST)
Message-ID: <6c0b6eaf-c925-4b02-87af-b3a7f3757025@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 06:35:40 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4] wifi: ath12k: add basic hwmon temperature
 reporting
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
References: <20260223132622.43464-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260223132622.43464-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bbAvyPhoDuvtgN7LVnDvpcCF9gR-q4Ql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEzOSBTYWx0ZWRfX2g7rvJBO6Ng2
 TjDZ03hYN5p+hNPzUcIh/5kvA1fII4GhBFqDJ0pdcN0EjM9CuM8sBBOppljHtyCiVjooRhAKXyQ
 hffdFfHXa4EZCwBm7aMh0lFb4TgV0mSsHhMwyc7Cl9PgPSvQ83MU2fI47zzato9HdvQUwswS04e
 zsYt/0HnjQ5YaYN5RLIEUlTGIP2ivL7i7uEoLPCR4uXIK5qfcwjpiK4h5FADL17OysXTQZUu/WV
 09k9MUN9/3Kw5prALjpepXEm4Yjrjh4i4OLrNvFHwxQ6A4+vhMgklg5WRSO5yUN1MwIicwP4rSl
 K9GdYF3637+BE9Qb7njicE/J1G9L//fHiwKtnRU6izv+STzLF126o/8aOC+qGO5XR7EsujR8BN5
 RN/NmbV+RrmH5JCgU6SYkuLZin3DkmFEUUAAkmPRdxwfU30h0T3Lq340UqpDoAqkI4PA3ZsIs81
 0eTD0eEpntbs5079kXQ==
X-Proofpoint-GUID: bbAvyPhoDuvtgN7LVnDvpcCF9gR-q4Ql
X-Authority-Analysis: v=2.4 cv=dZWNHHXe c=1 sm=1 tr=0 ts=699f08be cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=TIRtq7bqiOsBIkxYvl4A:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250139
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32178-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AC8C1198CF2
X-Rspamd-Action: no action

On 2/23/2026 5:26 AM, Maharaja Kennadyrajan wrote:
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602160145.YQdvbqYY-lkp@intel.com/

I'm dropping these tags. In the future please make sure to follow the
instructions provided by the bot:

	If you fix the issue in a separate patch/commit (i.e. not just a new version of
	the same patch/commit), kindly add following tags
	| Reported-by: kernel test robot <lkp@intel.com>
	| Closes: https://lore.kernel.org/oe-kbuild-all/202602160145.YQdvbqYY-lkp@intel.com/

/jeff




