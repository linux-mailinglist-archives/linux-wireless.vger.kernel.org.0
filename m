Return-Path: <linux-wireless+bounces-39086-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /cKgD5BqVmqt5AAAu9opvQ
	(envelope-from <linux-wireless+bounces-39086-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:57:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EAC757289
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:57:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GZpoAOv0;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=GqA1Ytvx;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39086-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39086-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1655301ECE0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F63E4DBD85;
	Tue, 14 Jul 2026 16:54:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27E4DB559
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 16:54:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048098; cv=none; b=lWf9vFkFaRvo3DRX4sXynWwqZymM8viNTOuLgfhS2Ap5/sibQCJFEJZqjxZ9Rx/ONMn+sEoKUcSi8cxE7EQMR2Ojn0SE/Yrnsoqv92tJVOSLcDfG9LRwIvxIkwQBpcCYYfOBhMwdfDw7jGOkMRrAVLTrrvatVNZ9/WMt39cDeAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048098; c=relaxed/simple;
	bh=7Nk5BtqBcElEka/opXuP5vbQQ84EZSsq21Y6eDKBKwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIk3SYwLUHRbHtC2NwsVCFAOOHU5pXxerhCDlAQZhVgGdtVoaxSQ0v0walS+1z2APSzTZlEdwV4h9bEbJacIZh+dgNqNptQfnOnwFbDtXN0KHwjJGsjo3NO1XTmD9cGm+dHtdGeWYzo0JrdjdzmdgeOpy2Rq/tyZdv/ra7dc8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GZpoAOv0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GqA1Ytvx; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6n2R1097021
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 16:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZXStIofx2Ks/Ov1D1CRqtChNqm+QT8Ta8UAz2fBO7uI=; b=GZpoAOv0HDIAzBem
	NnUmgPGxN5iCJLO88ELx02gAHOmLiqSVvYjdkG58OFf1hxlFkaAr8v5sI/hoK5Bd
	LOR6MZZkKlHLCO4E2cdomAjoGGJU/s1Q4i5KvHQvM489Zk74O/rq47NrZqVKUgJX
	/8YxocjBETJBgGAy8KksNc/ht3b5WbFG85sSOHHHfVUe1944zKPYlip6b/zGfrnk
	C+XGFOlKwH14lmx81NsTSzEM/wfVrMnbBUcNM5EEIdYFF7ZwAheXfOTJejuc6fAU
	uPhzFHPJ21HWLkirPSWJAIjT90E4PMprolUNON6/+BDsCstQmyGzaUnUR0JFBA2+
	2+XEKQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqs0fj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 16:54:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso3953781a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784048095; x=1784652895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZXStIofx2Ks/Ov1D1CRqtChNqm+QT8Ta8UAz2fBO7uI=;
        b=GqA1YtvxER/Z52mTTag0SOEzi7RXggaHiwY7CNVGxtrBKcc+cMWTsezey2RVnM8RH2
         Dkf/jS9e7zEyez37VmoN1WCe4/eTbnl3QwhvjgSzHxC5L5Mx61emWvhvwzXrQjzqXrSN
         xjADXFfSUAISEkc2iX1WG1KN5BOgCWY8xAWRMVoZCCxVu0AnFnknQiqhwnqxSGsKNRR7
         MnAG0rB0kjeMOGJ/SFzMchS2k66nPgxZwjZft9UMhFW47FaS3ePLxrsNgNL3UMJlv5zs
         GRY7c20zRtQXMVaBuchEBim9WoJEGv0kPPGurIgOv4toTVwIQw6ClNb6KkdXgmGT/km0
         CprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784048095; x=1784652895;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZXStIofx2Ks/Ov1D1CRqtChNqm+QT8Ta8UAz2fBO7uI=;
        b=gC0kBiDrACB0Gy8DVaGR6h3zRkPZx//v7PYbwqr3cW4UoqGZ5KB/KD5VvRuE73AMO/
         szr2MKMaJCt7U4Zk5cHv5nYymKGlxWnFcrrk/ZVZyG96iXBYOM7MYcxjuFp6QrQ3oyCv
         dRdyhjM44w6WQQDNRzorwYkUUiZTz3AL9dJHI+YIV1NUT8g7CM+kWa0SPerB5DtTjSWD
         UGAvT4UcnTzk9JSw39BDk5nCrK9ATDOgrJMUsVFWNZ+EFCkz9s3Y6rd4Crbf+tOz77YD
         webXTGc6U3IbIdsjBVG5UuPQVbBpTIx8GBmALRSaA6ZjAI4AN4348evn170+ZeZNsotf
         tTnw==
X-Gm-Message-State: AOJu0YxpByy6GrZ8O3F5ekCPNUqXNFSvSgAu9sNJAaOXneIbToRphH4k
	M9vEUnWvEda+/X8e9yIF1AZV+z1w+TlKmwXbaNB0UZbuRQRRdu97F3+f+VO/tPp8uoWsUisdFK1
	ZRKfjRuiFSZCNQleLy+gXQ/BOmFZ1zBhv6XJYOIK0NkITr4s752qOEBX7LmLP8ZTDGQJ3IQ==
X-Gm-Gg: AfdE7cnFlOLwi3pz06IMq8w5IpF6xYdRfgP7YA/jJrPYlHVW0CGyrfwH6dSwbaTkRcc
	86O0XjI08vrY0pv3wSM+0D5KuzBzEAuekJIc6DUMVv05V11wlIfaepLoGNm18ZIvU0dMOLXuwKF
	y7j68Aj1afrefd35JGbjSuUVjXX/0qlIPaWVQMtHUe5FZMdyvoZXn2E/Hn8MTBLJ89Dgc/daWoU
	+yROrtomcGJGDY5zK+aM0Xyz+YTt2b2Ur2mnkHXJhl/4ZqzRtGpiHoIb9uOr5Jl0VT3EYOKyyyD
	EljH9n6fArshHK0y2R4SbgXLA2dYdFsYBMAzUZiI9EhLDIaGrplJQgMnCn0TUvXaI56TtO4qQcK
	9pySNHAtgd15unXnciD5yfocbI0PRQzNR/1YM0Nfnoh9C8Q2YuYuCoZA=
X-Received: by 2002:a05:6a20:7283:b0:3bf:7c02:c46f with SMTP id adf61e73a8af0-3c110007a93mr14875212637.14.1784048094915;
        Tue, 14 Jul 2026 09:54:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:7283:b0:3bf:7c02:c46f with SMTP id adf61e73a8af0-3c110007a93mr14875189637.14.1784048094441;
        Tue, 14 Jul 2026 09:54:54 -0700 (PDT)
Received: from [192.168.11.107] ([124.123.80.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm83472151eec.18.2026.07.14.09.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 09:54:54 -0700 (PDT)
Message-ID: <de1e6499-b3a6-49fe-a2ef-cdcf57438ef2@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 22:24:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Set congestion control max MSDU
 count
To: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260622062614.760166-1-thiraviyam.mariyappan@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622062614.760166-1-thiraviyam.mariyappan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3NSBTYWx0ZWRfX4KxQDNVp+onl
 h0LQ2QqT4vRw4pWguKVISdfAZIRdsN3CBwDV6t1Du5KHXaO/YRggosNtJZh733Q2Bd+MMpc4FUm
 nYIveFyBwqcjGbOXSR+o0JD85a7LgkJASCYc1HkefTcGQ7KuQQDpYgn32tyCmVbbdAe2XxbVd8k
 QDB8a5X5+2+FPk5qMx0fQn7hqVRK7Qmqcmt2ho9kyM5T1T3e6pLThJVyfjATkL0LmC9d2Laei/P
 s1G8uFnyQ7IaZiRt0Od+fbBYQumH9JWoxB2cATQXmMtnDc+XWmJfbPoMeg4WRtCKxgr++7pymM1
 nuKYqXypoe5HT6YjT0HNThpAjA10fbzSH/NESzTxaFZj9Tmmh85tlB/WTdHn5Xfu/WeKko2ogvz
 Gku7MDIXUGIV5J2v6+3mbbAPUY6etaESENayHUgv2CCASXiXTVfBRJXmEeQP6UjtaOV5Vi0JeC0
 8W/B013Af6o+P1XrsRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3NSBTYWx0ZWRfX4bkLSzN7Gcni
 C/F8ebKHoqHDK3x6kAge11rlpSxuCDxv7rBOfEfXXXgJdEZFvmPHi6ppfL8FTGFzc3QoRsIZllG
 nJGzMeEKkiI7PkUOugd0S7+hLxC0dzk=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a5669df cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=kllYWVK2JqQtNyhMtAlpJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=APCbmnoeBd6G2hkCapYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: lV_zD1V13y2r_PXxUhEIkuE3Utst8s-p
X-Proofpoint-ORIG-GUID: lV_zD1V13y2r_PXxUhEIkuE3Utst8s-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39086-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:thiraviyam.mariyappan@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92EAC757289

On 6/22/2026 11:56 AM, Thiraviyam Mariyappan wrote:
> Currently when running 128 clients UDP DL test in 5 GHz HE80 (NSS 2x2),
> firmware uses the default max MSDU count (16K MSDUs). This lower limit
> causes the firmware to compute a smaller TQM drop threshold, aggregate
> packets at a reduced rate, and results in increased packet drops with
> TQM drop threshold as the completion reason.
> 
> To fix this issue, set WMI_PDEV_PARAM_SET_CONG_CTRL_MAX_MSDUS to the TX
> descriptor count using ath12k_wmi_pdev_set_param(). This increases the
> TQM drop threshold, reduces drop events, and improves throughput from
> ~722 Mbps to ~1060 Mbps with 1200 Mbps ingress.
> 
> Add a new HW capability flag (supports_cong_ctrl_max_msdus) and enable
> the WMI parameter only on supported platforms.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

