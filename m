Return-Path: <linux-wireless+bounces-34864-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MVFInwT4GmPcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34864-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:38:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F69408BAC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F176730908DC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13FA248166;
	Wed, 15 Apr 2026 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oi9x4VUK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CYKAJrSp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C402224B05
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292728; cv=none; b=kZJrHMIF/1X/WkuuntmSqHSlA3lXh+d5RbU0Tr4wK3A31PZbNes5fqXNQQazLkUCDlWHTimDH0AEUiHW+j2wfo+8muP0HPWBlHw+RGZAyJ/kIp05Hr66P4f4OKGktDItjf4XyUwXYv/3xiBE5t3MHntBHTn7tK6QMHpPIuslbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292728; c=relaxed/simple;
	bh=EunNstxLHLLbtvC3RWED6GjheU/DxveshyqFgvUIgHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZm5lOzEcicShDuWOtkg8MmrN/YtyS+Oy67CdQ6IAkIx670V2j6GcfffuEDX2qFO9B5/h1AIkSE3Xj9CsU6tqsSid45N0m8JWAisIlKmyUdSv5zylekjzI11ocqBmrk1l7EH51QAKprZSfjRnbcyMzX7nXAj4YbtauogVshT5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oi9x4VUK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CYKAJrSp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FFFfLr1792377
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WNuPJOvo/Mesdgr80P2aCUgpUBEArchI8LAvFFV1cpI=; b=Oi9x4VUKuAWHZcfo
	foeQ2NQBy+oRldZD0AbtwZcBC003VaJ0goV85etH6cYt5dACma1tPchJ6Yeq0T8N
	pkb9OPji0HelSwm92JD1SlTvSaTY/hYBlWd4pgQYUiUN+72+wy9fzWZn1f58m7mS
	7MubfNaYCTN6p03eTCyMDPJLWT8P7ooZgSDdYM6mPWmFhIxsbksxWpwMGj2C8RIF
	u2cDCz2d3prZa4lSLHppXxKbKhFEP3RkFf+X0s15OSbp1+g38/yYBUI57/5JHz/C
	DmG5Q2kyXOByZuRk2DYIV0LQ4Ej0UkicnB+ko7mnwB5w8b5zoFdHNtuaeYRSTjJA
	R7UhLg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djd5psata-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:38:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2d889997495so15698660eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776292725; x=1776897525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNuPJOvo/Mesdgr80P2aCUgpUBEArchI8LAvFFV1cpI=;
        b=CYKAJrSpAs0XjsMxLFMTkNsUDsuQB1YF9N4kfP/Veu6+3GOA5JRmEhRN+rliWRcICf
         F/yvWHw7CHuCvREUS3UaxgX7OtMsbfV7RCVxnFJbP3OWfh5qENQnsYEt6KpyUr4Ok+qW
         TMO6XlimMCeaWys0w5kH92dgspM+kXxJEwUQ8RsWrHA7BXARZBe23XeUL3K6rxX/23wO
         bldkHuc4dlaKw1u7NAm4N+dfWvP4UONXx3533IvPKm7eY7RcZvNNzeA7PrQ2LalD50uz
         +p2yGygO5EZipdm+29nK0kd3AZX3HppBBODGYaM+1QoQpGY+hHfVXsN0gJV1Lz4LUtfv
         8rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292725; x=1776897525;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNuPJOvo/Mesdgr80P2aCUgpUBEArchI8LAvFFV1cpI=;
        b=KIkX17QkuyFodTjq95TolB/Kdh99TqW1wkvAixtx5yEGCcqTS0jQWsRm3OU5EUQqzO
         MzWBEwEGSXJzQka+kZE9hK3rjDxNrUmHlp0JdFDQfAca43CkjfgWXca9dUUvFOE7waLP
         wK3IEEZpNAdSyMh5Ityztke4FFfruMCuZuRU8GQwPi5OiIOCT1taAFbNNJFCgxuN+Dsc
         d+iqMtMlYQGJ2MgtWT4C4DquX3C0ia94rV0rytgVBke8zJgkELwXdYGI1FIZHaGl5nUs
         cy/sRypYg+VBOQlV0By6E1IKLSUSEd6nglkaKY/WXC4THhBOhHSKLR6KI1I1CmHiyfr8
         ZG8g==
X-Gm-Message-State: AOJu0YwsCBdy8diQ5ZJcVtw+5xZdnJAKX8qJTWO59CvTTvDfC0o0Erqe
	SwrO7N/Y+6kvAa1ekm0OQ+3NpRpAi4IQnf80qsAscuuAhPsymS//Uuv4Wjo2fUM5qNbjKJsSyBI
	SeBvV7Y14tG0hw1nMQEy9eQBAxpIyywh7Eri6J8Ap0hNwkkCVw/jlD732XBV4DUlxhb8J9w==
X-Gm-Gg: AeBDieuxcFHdxjHpdB0m3iRS1+RvGGh7gpgHXm2Mnm/8DTsvOG9QleDFYrIfCVlUpkc
	cVd4exAD4vhF/Lnm7rTX/YIdbalsjMe9RWIpBfjRlmJ1KFGdSMNlhcXhbYX8wKWuzJkuSb7beh9
	M1Lz1Oim7e696rZjQnvjC4Qk0zRCcdRKM31ET1cSpItyZsFes0AQza10YNQ0WRjGyhROMuUa1Gz
	CZQ7+Fj/Phck3WNyKuz05s+Jqlf7UvK0zDP3aEkA/Me9i9/50dkyvQwo423YNqjd90sCdq/rG6F
	9lpkpU6nY1QAd7Lc1phEXC4O81bnXYPvI14ug407Yt8v7Fai8JGmUkYNTqeNu2+IbPha7p0DtMj
	y7u5P/MlD2mqNTomwoMelUP0/iBNgqUasNJ5t/g9Kb7/LOAMRt8au3w+GwykJ3HW1HLbqyVgKTg
	yj1AAyBLbMRfcKbAb+S9ifZO+d
X-Received: by 2002:a05:7301:1e91:b0:2c8:7172:3b7b with SMTP id 5a478bee46e88-2d5881ace9amr15361336eec.18.1776292725023;
        Wed, 15 Apr 2026 15:38:45 -0700 (PDT)
X-Received: by 2002:a05:7301:1e91:b0:2c8:7172:3b7b with SMTP id 5a478bee46e88-2d5881ace9amr15361325eec.18.1776292724493;
        Wed, 15 Apr 2026 15:38:44 -0700 (PDT)
Received: from [192.168.1.44] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f65f9bcsm5558156eec.22.2026.04.15.15.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 15:38:44 -0700 (PDT)
Message-ID: <4e3266fa-d9cd-40ef-b60a-985ef2170224@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 15:38:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] Do not read band-dependent reserved bits
To: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: P4hM7rXvgPELT-zvW_IAF23ZenyjHFuw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDIxMiBTYWx0ZWRfXw7YJ22Yf3GkB
 d1JakipMdrtw/ZjRqidYPUXsKJH2dxlC4TWw08rgN/VMRJdhuAxVogVm0Dp+q+7GBTvnT47RLXI
 ukUnlaI3jKInPlbgDwbVJxOxAx3g5curXBWTyKmuwZFE7F+oIhDhrZdca960Jw0fuCCFrMnrl6O
 74iOtNNkD9M8rCH2szVQjyFxXjiucX/DOnseIba2ATeu7+fog7NF3hvocsaJ+bFk/FVU06BHX4m
 ZzZcBGoxBrw8NkCB871YyDYnUQ7WIbn72XEBnPb9lnF/RdBJo8g1bDet+34/eGaGrKergiBENhn
 bfVvgFSUZ/ZrESF8GzmlEUMt2pQ5YjUdlwMj+6+K5o/uVadWKxUklts7PGtlD1cmP2tZ0d4mcVQ
 nbc6WqvkBNcr7UzeGcc+SdZOdAD5lpBszu86EMiNzcY2woopJRE3qpfEILiqz99VSeP2HfBrks4
 dTUeGno9IKKiTMrJb+g==
X-Authority-Analysis: v=2.4 cv=AcmB2XXG c=1 sm=1 tr=0 ts=69e01376 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=jKZef_YxSM25nulNdpsA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: P4hM7rXvgPELT-zvW_IAF23ZenyjHFuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150212
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34864-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F2F69408BAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/2026 12:03 PM, Pablo Martin-Gomez wrote:
> This series is a recyclying and extension of a previous attempt [1] to 
> not read reserved bits depending on the current band for HE/EHT STAs.
> 
> Convention (section 9.2.2 of 802.11-2024) states that reserved bits
> should be set to 0 (unless stated otherwise) and not to be read. Some
> STAs do not respect the convention in transmission and the kernel do not
> respect the convention in reception. The practical effect can be a
> really low throughtput between a MT7927 Windows STA and a ath12k Linux AP.
> 
> I've been quite drastic and added a check of the current band before
> read a bit that might be reserved whatever it's from an IE that was
> received or an IE will be sent. I also removed checks where they didn't
> make much sense and the current band was complicated/impossible to
> retrieve. That is why I'm positing this as a RFC.
> 
> [1]: https://lore.kernel.org/linux-wireless/20250120114551.1542812-1-pmartin-gomez@freebox.fr/
> 
> 
> Pablo Martin-Gomez (7):
>   wifi: nl80211: remove EHT IE size validation
>   wifi: make EHT capa size check not read reserved bits
>   wifi: make HE capa size check not read reserved bits
>   wifi: do not read band-dependent reserved bits
>   wifi: ath11k: do not read band-dependent reserved bits
>   wifi: ath12k: do not read band-dependent reserved bits
>   wifi: mt76: do not read band-dependent reserved bits
> 
>  drivers/net/wireless/ath/ath11k/mac.c         | 11 +--
>  drivers/net/wireless/ath/ath12k/mac.c         | 35 +++++----
>  .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 16 ++--
>  include/linux/ieee80211-eht.h                 | 58 +++++++++------
>  include/linux/ieee80211-he.h                  | 21 +++---
>  net/mac80211/debugfs_sta.c                    |  7 +-
>  net/mac80211/eht.c                            |  3 +-
>  net/mac80211/he.c                             | 73 ++++++++++---------
>  net/mac80211/mlme.c                           |  7 +-
>  net/mac80211/util.c                           | 12 +--
>  net/mac80211/vht.c                            |  2 +-
>  net/wireless/nl80211.c                        | 31 +++-----
>  12 files changed, 149 insertions(+), 127 deletions(-)
> 

Please use scripts/get_maintainer.pl to identify all necessary recipients for
your patches. Or start using 'b4' which does all the work for you. You are
modifying drivers without including the per-driver mailing lists and maintainers.

/jeff

