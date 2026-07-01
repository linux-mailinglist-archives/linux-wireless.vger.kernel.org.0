Return-Path: <linux-wireless+bounces-38481-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e6+NCNBlRWqH/QoAu9opvQ
	(envelope-from <linux-wireless+bounces-38481-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 21:09:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC0A6F0C63
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 21:09:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="JjkJ/n9S";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hxWi2yqA;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38481-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38481-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2E53055D49
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD7395AFC;
	Wed,  1 Jul 2026 19:08:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558BF3815E3
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 19:08:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932919; cv=none; b=teS8Sc5KyWk2FFbtx1N5zfDgqzrjDtJrCR23ILUxwWWRz9CJdDFR1MoYUTGYG1SUcxzVcpJVftO9Sm4dKoZbMSVY92zHy9XC9nkMbyr6506Hi4lTjsh3RfFrxv6GYsgaOqD1eaBKZLluH2QR1XwYj0mCvkfu0F5H+liZOueZzc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932919; c=relaxed/simple;
	bh=/caxDomtmq3CZidESZwEmWi8gpBX1dAxgotRykfCjxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zl9K3sQBbTAfymorC76U2Mf/JiZF1FWy6+3JOc4k5iUliwDXvvQFTtQAyfUI6Lb5EAl5Nf0fRSPTgk0LUpvs0439qw9eIe3SSs6PNRfRf2UdLT/31wsgaZ6MgC+nvzyTxBNXpkoUrTQ7FQgLuTbKYGIX3Md6PQFO91127OkZvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JjkJ/n9S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hxWi2yqA; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Gmvur1619052
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 19:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jlmev16MCLxmtjyWUwIYdrZl69vYkO/mRgghdSSAFbs=; b=JjkJ/n9S4b+2dWO8
	3OEUOytYqVn6k4LaJuVP1dfjfg3FjyONoNJ+qvtms4Mp5zYx77jO3bjtLeUs4iOK
	tEzbez+hDvSTaLg8fvmdd70ITrC3tykkCrFwHqV0hXYJdoNv4jhszWZlj6zaFfqU
	DqMFh3CN1pYx8qk6+Udg2tcmL+t9DmgKSHoA3HlHCpvyZCyiHfVzvBsCIPQIWqZy
	Erf+CFrORuyIkmfo81BR6wn2BaHuzBmLWMN2k/2eqLBcn6aOLHs+Okqjwtwt+hIv
	FQdkQgB++VODJjToxSQ1fPmk58fkbPlIfirfFFfchTpjNzE0jqx3X9zx1bNIut/g
	WBhOKw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f502utkgc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 19:08:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so862602a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 12:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782932916; x=1783537716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jlmev16MCLxmtjyWUwIYdrZl69vYkO/mRgghdSSAFbs=;
        b=hxWi2yqAdEb/XDmeGqndVIslFraCIyiuOq8Or8o0qoS71rieh44TIaUXQnXkn1hVHd
         idtCNAHKgBL+KeSVfexrBJfY83D2JkVI3UeaEvSXTA98Kfnr5PRg5UkWQyfsXc8M1vaS
         iGudOmU85s8OVNTR9Yzvomcgz1FN4LhM8z0AHqZYnmMWxCk/WWt3MgXFjKRTFanwBgAK
         b1ZLuPS5IaDlX6/qG9K8PiaVOFmbDEEQeKMN6FQiYQzzW2meLDr8L7FPR4oqvPdLsJVn
         p0dn+5FGKORP3Wh9BwLlhK8T7LjMzqIVDBqBQkfy6fi3odkQgledgm+PPuxLZ1R3jqdD
         95vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782932916; x=1783537716;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jlmev16MCLxmtjyWUwIYdrZl69vYkO/mRgghdSSAFbs=;
        b=NGARBVdobt0HNcE9TlPITXNm2nmBq75/Zfuewdvvxm6PF76S8YpgZ55B5ShW00iRfx
         /sQgbb5RFvk7ioQ1oQToRE0+472L6mw/aqThsTWst+CekhpYYdVRJsZf/j7wxAyCE3Em
         lJdFioHAPt0WVTeAsh62U7aGf+BXCU4mY3d+3rZtYEHlNqlu0RJePjvL8eJUtnG37WoZ
         YETY1Pd/6Ncdbip0XGTJQzwiV213LeoONxbGkQLwgvIHHAboyBZDlRhws6bsyCj+G2FH
         SGw6cHhi/bbaAd9+BAWhOXPFcWxfLvDgcCqC+Jg+bJN9rmpqbj6pDEeSxCh5Uiq7rTp9
         0BIQ==
X-Gm-Message-State: AOJu0Yw5UfHMFyHCgpUcCI2eJ1g1sIxk7gZy1Pg+A9a+rdA++WtLylxf
	Axj6bVJWICtbV21vDp9VtpXhMdjsxFUBsjAxDrN+8whK60imTHLd99YlWj2id0q1W1H/oO05/PF
	opcYg4LN0ATGFtYAPnF2wXgYpLHdbjGo7Lo4o7ZZPpCWntgbQo91UD8w6bUtW/urrnZhE/M1ftw
	GYqA==
X-Gm-Gg: AfdE7cktkU0SLP7Q9dAXn2GvfLNQ8fWxGhlnQXI+fV6bpGbhUmNw/Ump7Hmrx185x5U
	XMF8/sCIctXTlEyBJwvO8ieLudyc8cPBJg6exuoV+JEbTqSuirV8hNKwp7foy7lXb8G4PHPQlSd
	FREtCpzGWyUzwTO9FM5YRDPVrQOcUgbCjUqlQEOxahfww3Uez9rfWUECl9nhXFtZt4tQyNR7/sS
	ZO+yBo8LuIgvlnqVP+J1B4KzM//vzD+8zrUHPArbRuwm1z98zUbMVF5xqu85Ix0PcoojFyEJhhO
	EOGyPqtA5inJhg9ZBscfbPdz06mvLZdoJFoc700bu+GjpHzAiEhJ9rJTgDO6VQ/sYXzApPWCBrv
	OoLX4wedv9wb4M9LVKiw1ao23aPoJesXqLd8KvYc10XFf+ZfBhBsgQu0NdKRmbS5psbGW1wo=
X-Received: by 2002:a17:90b:1dc8:b0:37f:9ce1:735f with SMTP id 98e67ed59e1d1-380ba94a632mr2036071a91.32.1782932916302;
        Wed, 01 Jul 2026 12:08:36 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc8:b0:37f:9ce1:735f with SMTP id 98e67ed59e1d1-380ba94a632mr2036036a91.32.1782932915853;
        Wed, 01 Jul 2026 12:08:35 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm535918eec.20.2026.07.01.12.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 12:08:35 -0700 (PDT)
Message-ID: <079f2b0f-87f5-40bf-b36e-3ed01592e937@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 12:08:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath: avoid repeated divisions in DFS PRI detector
To: frank0988 <frank0988855428@gmail.com>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260701170424.380202-1-frank0988855428@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260701170424.380202-1-frank0988855428@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIwNSBTYWx0ZWRfXxlPxto3EwUNu
 oqLt8HZRV2SijlcPMShPyPm1QftrCui3XgeK/1lf1Vvs/GviJYnC2ySsrL8762uUEmIgOp9Lyb3
 GAeMqnQw8Np3vhwrIEExpRwlj93XyxA=
X-Proofpoint-GUID: nIjRdUBHQCzYhomWCzAa4Pcm-s0xWmBK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIwNSBTYWx0ZWRfX7RTUDBbRBxlm
 XpD8ppba8NV50KsJFl9Ry7MQu5wbgRzPELeCy8DM4zHifO7QbS2qn/0mqKjEo4vyVDTMsK/rwcO
 vOYA03VoKlTZOI5BT87o4U3uSgVfjDT4Py0sCBWHC8lbsMu39pXMYWBf68RmNBOIhwDWwe6jHuj
 PkPr8Xq8x4EbETdAC/2VE5U+2e1a3YXAQuIxsBZmGcJPRxccDXtzA5QOXn24JKHUNcOv/umZfBy
 eYu5MZ8Gd9QaMAvcUExU39dgFvY9/7QmZs3rIbG6tRbwQC51U6zgiY0fFoztqNoUH80UP5WfjEB
 GwR7/OOKd4tpY0L4DR6op2WsUCl2z4/289Wn+f40gIQ8/V4urgEOz2mD/OK8V2yArNRQf6suX5h
 +Q1j7jOLjjT1wDHaxOIj4eEDlODOQHc+fWtBqxnPXVB+W1LBP6AAS8tezOc1K7g1lJPNvgGmzXI
 084S2nb597SDNeaUSVA==
X-Proofpoint-ORIG-GUID: nIjRdUBHQCzYhomWCzAa4Pcm-s0xWmBK
X-Authority-Analysis: v=2.4 cv=PbLPQChd c=1 sm=1 tr=0 ts=6a4565b5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ba6CMTNMOfQxLYHywM4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010205
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38481-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:frank0988855428@gmail.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CC0A6F0C63

On 7/1/2026 10:04 AM, frank0988 wrote:
> pde_get_multiple() is called repeatedly with the same PRI (Pulse
> Repetition Interval) value while validating candidate and existing PRI
> sequences.
> 
> Cache the reciprocal value for each sequence structure and leverage
> reciprocal_divide() in the hot path. This keeps the existing matching
> logic and tolerance checks intact while replacing expensive hardware
> integer divisions with low-cost multiply-and-shift operations.
> 
> Testing with a userspace model of the same detector logic demonstrated
> identical detector states and outputs across 100 verification traces.
> To eliminate memory allocator noise, an isolated micro-benchmark using
> a static object pool showed that the reciprocal variant reduces CPU
> cycles by approximately 3.4%.
> 
> Signed-off-by: frank0988 <frank0988855428@gmail.com>

You must sign off with a "known identity"

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

