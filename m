Return-Path: <linux-wireless+bounces-38939-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tDmPHRSHVGq6mwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38939-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 08:35:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 119A07478CC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 08:35:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=AwrQ7qKG;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MyBkiUQj;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38939-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38939-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AAA5300E2AA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 06:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D33A381EA1;
	Mon, 13 Jul 2026 06:34:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE7383304
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 06:34:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924479; cv=none; b=G0s9hGSS+vUX/HsR2weyfwFhrvKrWpZ/X2ZGucqcFmYvIGEDYq3JfB5F8VFIx/LAXLdUJZoBiexsu+iCCgRNzF/mbVKqqE8JXS+XF7FIpR8MBe8pJsiVHBnDFphTaK6ntsdkRPlBjk/op/WKZNT/vQon3LzLMfuO8VP3ig8wwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924479; c=relaxed/simple;
	bh=RCC1i1w5hKnmgvGNdaWYVB5OY0rQhojrVWGtYu2he9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTp3ULXtf1irJjwqW8yBuDutIkmxkrZ88+6ZlC5cwxq3wigCuuEA9dI11QwERhErbgKgHblCxWkOwz4VdQSn5Cpmn1YBmlBDDEh9njbbAfLvEAqhe8OVgQCbd1cLVpGt2wnOHgrArDzs6CVLT13G2JJ/SWeC2SCbwtQ5BReCSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AwrQ7qKG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MyBkiUQj; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Num8568057
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 06:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ChiOh6qfWaDIjMx1iTUYbdtHExFAEp/rtOjD+L5GuY4=; b=AwrQ7qKGBX07KHVc
	/lW4g05RZEaXfLagvFtJEsel5h1zFndas64Y0b+pg55CNP1iAgha3cKgqV0Vzhuo
	h7v9Gr8KdhuUf9VM+wDVbrRBAyGD30r17nt9Hyybve7SAxq2aB62UVGqRi1qde2h
	TA8a8EVY7ki9uotYCLDWmXCoznsCMcfqZV9HedH811xZy4LJOCs37sqhqS7xppPF
	myage1tdO7iX6fUAb5qdW+ylx17i78blSUx7+1zyexwMiDgIJIryaMXFrN0cuHcN
	vkyBGDK1EmjG62/Pe+MjfoXbo7CEcz3njK+kCfAvTtv+uLoW2xy0MOrmL4RX5/Ph
	NCBdBQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe914qg4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 06:34:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37e24235ce1so4950223a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 23:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783924407; x=1784529207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ChiOh6qfWaDIjMx1iTUYbdtHExFAEp/rtOjD+L5GuY4=;
        b=MyBkiUQj1C2X0r3CANn36s0S6OeFbe3EwJEPIYT3GOZH1a3lvmxi1t5yPE1KjVC/MJ
         T+YIA4kI0cAOyqv4H13onJUSqvs9SrfYSQouoz5VQXAykGT7RVOz72TkUtBNb77YXMT/
         hdjqfHKlmCyBKQ2F7wHtIWYPW1EMGSItpE8ZATjny8du1V80FcecGO1c1ZHmaev/z9bi
         qKoaQYz8L9cYbGmHqzK6XzWcP52KqxEuHfC8KFnbttipIvXZQO7Ij3KR6ketyHAE9jeO
         jOB40lesmkWCgsu9GHxc8CpwPmzoMCzL1uzHn+1ukiGluqlZdR343mV8u60L+p+FTHm0
         x4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783924407; x=1784529207;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ChiOh6qfWaDIjMx1iTUYbdtHExFAEp/rtOjD+L5GuY4=;
        b=aBNDx+k/BVs6KzJ88M5k9NOlHFi8gTtTUN3UdwrB4Jn0EXRWkCu5oDVH4wv/XgQ7wL
         rCwO/9bJ535vTht/+VCkeojv/Cdh8Lik9tOiCNqW0kOP1IhbFhC/KpRdT0GmezjJ+mvI
         OQfopi3cWsYQzxYRet3fj60lapoXJbOnhOD+nxpMrMRpgRlXoAXfdWUr82hQpPZ93yCl
         xvzG22dIlCX24W5pytKloqhxvy9W6GXlcXCM4bXUd8hV6FAn/X9mXoVlm8BZan92uKXn
         Bt6I2HrMhPql9Mf0gD+6yoYJchbzP4CluLtJ8LhaGPyV7e+Y/S9PzKgq70KePEK/lEtz
         /e8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp8sn5XtzDaCkWXhsGxVdWAoPANC7dNe3B+ZDOYpnSSVXKySv/OOb4oQxm3T1Z+p2+iu3HMfwS9f83/jPVMfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNuLAj61Q1pz0OkRa40un1SFhdUWByN40szYCqyfjbJ26VYb8S
	wyz5oMrPPK8rjVxrAgy5DklY5grh1uHrVPSCEOceJ6qi+2Uz8bvJawbHRgI7NolnKu3FGGLplRP
	9ATSoO/qnzBElr1qauWjGFxhdbcXs/mn9iUsmI2cZ35IcqZNZ5sgpsx4xFOZf/yeuwjmAWwo1VS
	JH3EWg
X-Gm-Gg: AfdE7cn8hjAdvJSi4hC69A7cFMgB9lvspdyrulAI9FIpoN4fcww9tnJKMIaMWJuviBs
	MReD33Hqz9cSGm3hKJ9waNWT3LMv9nLcGZZzmBv7js9P+5yKPW55LIMciPKO3fekeMe4nvqRl29
	oT5ZrGWLh8ivbPmtPGXMiTaqORFT6efToan+b4AOLBmIo8vCmEF2TK2S+72by6r8aV/1uoT59vF
	L5LtKW9g7ZlVRwh0F5oKN0a/OUhn4ZAkZIKti7dlD26gpNAa2/6ux+Bwns503CKMlTY51KsYbM+
	D8yuHze0W4qADy2s4NN7RFw/jNPISfhKm24K78iCT8oHisr1KmLT1ZRcp+iDn27XPjUfp02L4Bw
	tdvblEb8img9qQWIeockGiMcNh0FPOGyOauoQzpNb7L5TT95w+a9Fg8Dh+hlM6iUhTTLIkwDnnH
	3yEfDJILA=
X-Received: by 2002:a17:90b:4ac1:b0:38d:e0c4:c955 with SMTP id 98e67ed59e1d1-38de0c4ca49mr4888186a91.15.1783924406811;
        Sun, 12 Jul 2026 23:33:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac1:b0:38d:e0c4:c955 with SMTP id 98e67ed59e1d1-38de0c4ca49mr4888155a91.15.1783924406362;
        Sun, 12 Jul 2026 23:33:26 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38decd9a90esm1533042a91.4.2026.07.12.23.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 23:33:26 -0700 (PDT)
Message-ID: <83b4707f-a213-443e-9642-116d292293ee@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:33:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath11k: add purwa-iot-evk and
 qcs6490-rb3gen2 to usecase firmware table
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260713020359.3618193-1-miaoqing.pan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260713020359.3618193-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a5486fc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=DrgTWcDhasnuVJzv9R0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA2NiBTYWx0ZWRfX++KBVkbtNlM2
 pXid4wnCGHcMgqzBSaON1Z0PhBPu1eM6phYVBHQG2JpRviiuygJLByMbvxsd80qH4UT/bgWTrGl
 MaqyDurbypQLSYt7jHaRnal9BTimbNw=
X-Proofpoint-GUID: CLR-KO-V3tDOi0K8dX09Rw1lSM-Ij91X
X-Proofpoint-ORIG-GUID: CLR-KO-V3tDOi0K8dX09Rw1lSM-Ij91X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA2NiBTYWx0ZWRfX1R/RvQe3u9sU
 h5o8hXs5B7DxXD2Jjot1RDwzuF5PJAPLUkbQW1TbyMH0vD8ERiGFykMX/to23tgTyktynLptRs/
 oTexa88pZQ1h+Tpmr+6urNjqpiRq6/Ht+AIRo7KTxvfTHtzAg+cMytg1hwzMjiFRftTCDaqYaG1
 j6e2QS7DMOea+yV2doj9+5kYtIPQBnZ/HGQcElB4BUASOSy6g1ulYOeMDXgEQ9ukw8kZ551DtIM
 kkg/wUt9NIjTd6CTQGzC7X/gmwHf23AiwH4oN98r7QRLI4wbdlUUiclyimHPZOMFbcWnbmtBwjA
 hMLItlvo4PeYuPfscP+hAg2Mn2tm7an7JZQ68FbLBayF3qK7X4yKbPqF4oR+J5St0QltWZD42g+
 8WuWjJJyaMDNp4QK1TIJTYB+roU4e98XkWBQWAuODXHQPHonzobo7og/4UNFgQtHWsmbBCTbRZa
 gA5I+9Kg/JWPVabC2KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38939-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miaoqing.pan@oss.qualcomm.com,m:jjohnson@kernel.org,m:ath11k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 119A07478CC



On 7/13/2026 10:03 AM, Miaoqing Pan wrote:
> Add purwa-iot-evk and qcs6490-rb3gen2 platform support to the
> usecase firmware lookup table for WCN6855 hw2.1.
> 
> These platforms use the nfa765 firmware path for usecase-based
> firmware selection.
> 
> Also reorder the table entries by compatible string.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

