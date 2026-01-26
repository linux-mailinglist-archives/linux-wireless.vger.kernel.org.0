Return-Path: <linux-wireless+bounces-31162-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id npJUNk8Dd2k1agEAu9opvQ
	(envelope-from <linux-wireless+bounces-31162-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 07:01:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537B84559
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 07:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FF303001581
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 06:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6983227E95;
	Mon, 26 Jan 2026 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1IHYIUN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pz9cJvku"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC682253EB
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769407304; cv=none; b=RlcuJiEl64/IGpDhlRfF9zweJXHyDRXi7b1y/SrMjKSBVBU+gNSyzXsm2N4HcN87OsYkSr/vmXIEqOAje9VIiWM0yshyf4eJaDsTuj2EbnpLFSTlNVaJQQnHFp6DGau+sJxJfkKlHjOFdQwnR9m9QZ1coEEghbx6pzUyMl1z9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769407304; c=relaxed/simple;
	bh=vDR6tswNEsLbWUGXVZiNGDmKvSoNzJ5QhrOgyKDTQXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsykY1dvPS2KkFchd/oMk5ghJ1RTeYpSZu5n+EIk+yuh3kUyx0//KWJLawrEQaV4GJRo7Ju4WiaIv+0J9LvmzEYOJQST95ozd8NBfuKe0ZC3K10q6EIBy8aTdQahbc6uovAMP/BstCQLtd00fCh1F8+bjnTP9bf0gtCuMb4SepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B1IHYIUN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pz9cJvku; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PKMAT5860194
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 06:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WhYkT4c8bqYuaFAAd9Og1qwa8NpefLNuln4Q611IPFo=; b=B1IHYIUNp0yOLs2k
	cd0jl+KXHa3h3dmJHpEA/d4mAf94W1/O+mEmn4XSdF9l1/0kOLW8Mc/XypIpnSwv
	HduvcuK/QJDTLYmj4ITp6tvru8Ki9Y91e474vZWHRhh+Dm06NQQWBlYEZozq3HHz
	USxG24li9ILBytE4Z0efEevd6irhV856vtNgknKfvDk/Hzk5Ylh8eLfrlIxLZoBX
	5zaz3Ntz7V+JuX3rCiCwpCWDCXunfrS8Q1aXG+YMgklNDomjA3OUXvy53AVP/C3E
	E6MNl5zjd21yrbOLgqZgDS/UZ+15ym+9jlqebOd3jdIq4XJs5vU3qiV7Rqljrjzq
	mzV+GQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvwtyb15x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 06:01:42 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81ea3358dd3so3115052b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 22:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769407302; x=1770012102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhYkT4c8bqYuaFAAd9Og1qwa8NpefLNuln4Q611IPFo=;
        b=Pz9cJvkuXd9Ixuv4j3aDI1MNtkeg+6FfMFq0CIKB9ddjnoIuUlqhPShn+e8BirI0O9
         kguRuDF7Hrn44DIerKdwsAfWu5QcZRH8K83DK9yECPpn3GcjGhUoMwP4dA3G65p7M/R5
         nkd2U9W+iuBPc5Te4/F+ukXueBKjdeJcgSSZvF1RfLbXqQntU6MNL9teTV6qan9KJJbZ
         eMJoN0Ic+flejBqhY3oqE5/tcmhATVnDagE6nqS5BooB7wy9DAb5lJC5NIBzJh8qo+2C
         2yjRRqVnMyr8n6kUw8Y2SPFemB8OKeaojtsWIqrbBDRgBl0AlzNBeaPBC+mTTFK8keVc
         KA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769407302; x=1770012102;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhYkT4c8bqYuaFAAd9Og1qwa8NpefLNuln4Q611IPFo=;
        b=o2SA0et8fNai1jx4/TsyHr9JiP7Gzm2SZgmrmQBldChiBtFUHtxfJ3u6LerrJI+n4e
         yyf1OgqO1q5+QR36zxfUNZuyCjRBa81r5FvIjdhC5++K47Q4Ku649jU7vqqh1Wdg4/z5
         NxRe1g5gPQ6GcjUaD+7DHVDyit+6dApa2Qo+eo4zTgb5ayd5rGjl1BdG3iyj/lwGitsS
         p/CrYrI8oABwJQzmhl343eKbVRt5TmhOc4GAugeOVy3FW3VAi+sALN6ADvVP9KEnxq0O
         GtEzeQpMasd/wRqQptAC9UvG6djgDzfOpL37YspdK+wVhOn+5X2fOg5mVgcnmKWWqPUX
         D+Zg==
X-Gm-Message-State: AOJu0YyjYK6+YaHXCDXei5qhO/1rDmL230hJs4hv4eFQP5eMosNpjUSt
	qYFnMupY4DouFv5oVph0DBHcqzSIwVBfdyy9UQZV/081yyPoDCnKYVlJCLh3cWCg4eL8HVoULSa
	zzMnv+mUzyFfC5xjHoseO+ALHUas0R8qAqksp+YJat0OOuPI0JrLDUnxnDV6y6IYvzA3yrQ==
X-Gm-Gg: AZuq6aK0vR0NUQfuL3TWanW7B4d/VZ+zT2J3YuLKU/Bq54VA8z11d4OtVNpSutwAM1c
	QVtednChK2u7smBSEifVSFq9ji2bzOBfUUnY7f3t3eTzaceZ4Yc+IQahYL4zn5jbomxjtG2g5gj
	J5ckp/yUH+xyIwE/ID65LIKQSvCgFvnj0fz75ZSekvE7mjZzAdmqirt2v61eNyM9hdgnH4XksMb
	VeI3vJOGCHwkDObPli8eNFrHROTtpLKsFT9j7U3ciVtowSj7YEERLIXoqhsUOSvXTcj/Vk8w4E0
	TZB0yjdDJuHH1gYNXWu5whTlVKwpO/nxdi/XORRPihHBfhDBB7IrM0XRMjQaUzPeBozCtCiGgr/
	yBQTMlutmu0Y5am5CB9H6Z9f7BNS4n8cjxlyvsYq0gTuPYrykCXhwyYgAYydCIMpLfFEQT5o=
X-Received: by 2002:a05:6a00:4c14:b0:81f:31c3:2e38 with SMTP id d2e1a72fcca58-823411d8314mr3094663b3a.19.1769407301644;
        Sun, 25 Jan 2026 22:01:41 -0800 (PST)
X-Received: by 2002:a05:6a00:4c14:b0:81f:31c3:2e38 with SMTP id d2e1a72fcca58-823411d8314mr3094641b3a.19.1769407301035;
        Sun, 25 Jan 2026 22:01:41 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e8e0sm8449355b3a.57.2026.01.25.22.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 22:01:40 -0800 (PST)
Message-ID: <e580107c-3b19-49a9-94b9-09d06e5e7a30@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 14:01:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: Add support for RX pdev TX
 hardware queue stats via HTT debugfs
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260123071253.2202644-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260123071253.2202644-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: c3n00s03NkZxvy6jAigFjp7cFBEIuRe-
X-Authority-Analysis: v=2.4 cv=BteQAIX5 c=1 sm=1 tr=0 ts=69770346 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OlFMsxEj8GJKrJqdkKEA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: c3n00s03NkZxvy6jAigFjp7cFBEIuRe-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA1MCBTYWx0ZWRfX0TsKr0pPjCHa
 u376OFa44F1ZpymEOPIqSU50J57DHf1IenmvZZmqcVRloqFSrZx9tFp1hw72frXcExX0+AQw0P8
 fDh/vpFJ4iYU2A7bPMf8+zMNFtxW2ezkhKa6zLPRD1kg1Hhv9ZNs0JFyV4JHMmyYA0QcZ2IJTE3
 deVvKI4pmvUXKSMNsCnlVVhyUdMRmurItYpdOr4wxFLlm+CVrc0bnpLi5gHNTo3oF1clpwqcLpE
 LHg3wmzkklqv5ClGyQ+rUv7/eg8PTBcNap/d7elaiFMImuB7yygZkDn0yDB15LSNUYfPZA6fCCu
 jjJibSn0wy2NcPbyYpKKMimzZhnxZ/IzmmTzTVCgNzFvbc3ol6O4HcgP4ssea1O3jCeFSBybKtV
 uheO8pOgBkNGUqZRamUlwILYcUk36g3hSfrYNGKsIlBPVfTqJ0fs3LaZOU5WAHnyng69RT7stLC
 Gzdfy8JlzZer1BnjJHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260050
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31162-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0537B84559
X-Rspamd-Action: no action



On 1/23/2026 3:12 PM, Aaradhana Sahu wrote:
> Add support for HTT stats type 2 to report RX pdev firmware and HTT stats
> type 3 to report TX hardware queue stats. Also fix invalid buffer access.
> 
> Aaradhana Sahu (3):
>   wifi: ath12k: Fix index decrement when array_len is zero
>   wifi: ath12k: Add support RX PDEV stats
>   wifi: ath12k: Add support TX hardware queue stats
> 
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 197 +++++++++++++++++-
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   |  81 +++++++
>  2 files changed, 275 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 758064145fe77e06d07661b27dfa9c24fe0309a3

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


