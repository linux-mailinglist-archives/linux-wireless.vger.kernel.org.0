Return-Path: <linux-wireless+bounces-38573-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tYp6EnqTR2rebQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38573-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 12:48:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B2770168E
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 12:48:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=EpJdPjDS;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=falUHtrx;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38573-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38573-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 796B6308E0F5
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 10:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB20A3D9DB1;
	Fri,  3 Jul 2026 10:36:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400BD3D9544
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 10:36:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074986; cv=none; b=KzIj/ZirsMy0laGBB7W+Xrm1CzHc3rTCzHZJMrNxicxWwyrIU9kcspyrBKHIDwYOUErngYJkYRXU5FGc8vdxR4tjrmtDXtsVMQ7UZFUd2w7UAUWJNBTn2LvFAJKB8mnlLjlcMJN2+jhBNURJi0QoHlhg69cVX4XEwYR9GuvwSIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074986; c=relaxed/simple;
	bh=92i8UPrYFM9G2v+lQeSO5oIi2vXqIG/djDXA+JTb+y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3Ay+jdmOswYetn0tYzgWKQtT/D4Adye/d2zt9cDAJfuyQ6uLJH9JsgyYMZxT6TKHezX3qpNZYIynAgJz+4oy/RWTT8y3lVa62y9CXsuytQbm3I3Jba93IZti/h3qRjDHXl/yucnED0mIX4SjVXIf6PanFoBBMUTYwV3EEP/gsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EpJdPjDS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=falUHtrx; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6637ZgZJ3410048
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 10:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y7nX2t7d/sMmYWGo3rIr0X5bV0IZTvF333uqoqdP2u0=; b=EpJdPjDS1nK7FVuc
	MpWYxPN1aKqTdHLS0tw5yQCXtxcMTIby4BTOJ6bwQUxcn15qaE/22tHgCbu+ZN/5
	uZdmwzjZpBnebH9i0TtMmZozqbP7VIcdjvjMtpYJqKJj7g0yr4ro6chrub1oo7k3
	od8kKowptdwNXwTW/qgPgjzzgWpeQp95Gf6GhhVI5SccldkjHR9NpmlY3ImaaMlC
	APNYEWe8YYQbApC46CZfupqD2RXJF8mAxFKYnwKXMeDpq9hbZNsV3jl0hhuuGTgZ
	7TrBHGMjC7cRFUH0BjOxgEON+AthjlkeQ5ilaq3Td+El0FiDxdFfAZQRYMox/YW2
	rEVHig==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u30nmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 10:36:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2caa9a3cf7aso17812925ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783074983; x=1783679783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7nX2t7d/sMmYWGo3rIr0X5bV0IZTvF333uqoqdP2u0=;
        b=falUHtrxMtYvThnG3YsGO53F2+emillcNsmKzKA5XMRj3qvxUCL6c+3m5epKib28wq
         Ys/OAoELVPxuE91Fw6WJykXUCG9hUpbmw78B6cnytCJQBARWTcj8JNoyEdoQIIMr66ng
         TiuBq+U9hSQfgRdb6kEGupLkK6WQOBBrKA3XWVWsPPWF2sXtpDng7hctHTsYR2ww2DJP
         LuidvbBRd7h5Ht8gNUV/zivTx0QyLNWuNr88qa/BfvPM/gzT1HM1FZpxS0VuWV8eaEIG
         ws4re8kniSEI2+j0YdkeIdPVDm/ISIetP2NMr5kziXdpiVQ+cqpDyfQm/AGo3avB7Ix3
         wFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783074983; x=1783679783;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7nX2t7d/sMmYWGo3rIr0X5bV0IZTvF333uqoqdP2u0=;
        b=DP+oAFbbScn+c/iBIOMvHlnE2ql+3DyMckaf4A7Ul3tOMFUTVA0yHU3p79Ndn4ACmH
         D+/H+nGo+4P9hNLFvsLtX/TaF1CM45o89M9bVe09zwxWa+iBKXle7FGYTBY7rOLflvCz
         loFKqxTGURc3pOjTs5VnlXh8Hj+9ToryFQt0mmaRWRhwA3kc0zItlagsSjj3+/yiXkv0
         kjgnuhU9pEeHfgTK6wgOae57pdPG5m7w2MaLD3+ksVh3zudS4LJxwlqa5Jfj+0jWIZGS
         aJWWExAsapI5JMQfESFSda95++9dYcdb0Mqe0LNwsO81g0lhX/FGKwmT4SuQtQBBdjb8
         GVeA==
X-Gm-Message-State: AOJu0Yz76E+ab8lvJV1Tsmep62JGQO71znrl52D0nquWDlhsVLiaTjye
	eUVOr8xT6LzKB6yYqw6EtVe93nS0BXyn27XK0tEJrLmA9z72BXy/rnpN068wxUt2FFYVWDWU88O
	Tqw+u+zmwYIVJTm12k53EH6lCf/1Xuvnl1gSWJ1FP3KtY6z3niPZTcltVyFqlb2F2z3qR/I1GBq
	IEKQ==
X-Gm-Gg: AfdE7cny+hznq9hRcoJx2mLyIh4kV4hjMG6lhLoqUmo7AAIcmSiQl6xZDjBXbYE0aBY
	pts/rg9DPwvNcZtDnz1kaK2OT/xcCdAHV9PPud2q8hWNCHP0MVgUw5oJxtPBZMTMboOAxWsc4Yj
	YLIawLad1JU3qNtHFdn8vH2mnSYm5hxv9hE6XcKDFSTgKZyJwc9rOxJFG1HQcUVbB50pI/+WT33
	tz8r/KkoXBHgQYyR8vDO6K4dvCz0TmzSQZQ+OhIjTsNQD/70ulEW6+h/v1MPKVyn0YSTDyPmnS3
	URn1erY516vlNWNTGldfgGIgmX4tsyZVV88bsj21oYBf448kPA0XjCDhIoG461baeQXLjYAP+Dm
	I5bTUMkZNmCqdv3ANrYMiQAj/tMu0QFJUQUNC+dCgiOT4b1v2BtE=
X-Received: by 2002:a17:903:3c6b:b0:2c9:d56d:afa3 with SMTP id d9443c01a7336-2cacb070082mr42780345ad.15.1783074982848;
        Fri, 03 Jul 2026 03:36:22 -0700 (PDT)
X-Received: by 2002:a17:903:3c6b:b0:2c9:d56d:afa3 with SMTP id d9443c01a7336-2cacb070082mr42779985ad.15.1783074982316;
        Fri, 03 Jul 2026 03:36:22 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b446a766asm13555217c88.7.2026.07.03.03.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 03:36:21 -0700 (PDT)
Message-ID: <20d52df0-a33c-48da-8f62-9adb7c77eea0@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 16:06:17 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix potential buffer underflow in
 ath11k_hal_rx_msdu_list_get()
To: Dmitry Morgun <d.morgun@ispras.ru>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20260530114252.42615-1-d.morgun@ispras.ru>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260530114252.42615-1-d.morgun@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nm8t6yJF6RwZlRqoGXPnjA97W7VREQQ-
X-Proofpoint-ORIG-GUID: nm8t6yJF6RwZlRqoGXPnjA97W7VREQQ-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwMiBTYWx0ZWRfX6AP1STcIyVLu
 xFK0WnRpM1o0JOIRS32mGTfttQzlOG47k1lCkrh2viEqasoRCemYHAc0I+bSAWBetffFqIDfynU
 5d4UsomSxLfD2FaeWBY5tqNGHp/lupY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwMiBTYWx0ZWRfX/KYQke/e4q+o
 nu2nZ77LHK7RWqeZa50Ke8FC0nbi4VlRy4VhinR6m8rqTvo02Gg1UFiOlJIzguxMnFZaMRZJXnw
 0nNtan2ptBDSddEnL/blULOBy32bKjuy42GcaDPPCXtzqvKeT0ByYLDy3tH589ox3wy4QsbO+Pu
 sdIB6i6g7ui2ZRUQE65aea5xW8klKJuVI7fakjqC7BDWraep4CVcv1dZICwj+BKjHt8P0m5EPYL
 Ma7gv95mYKw8E5O0cL8DMNbasknWbox9d6hXfPvIVn30Y3fpEkLWZ97+1AIX+8JU2bwo43lcPn/
 dHG07tI8dlW00WfR0Onn9UG8UuQRwrTW0Q+A3e2H30t2JiTwe9CnU4/wOp9D0uyfk/7E4LHI+B/
 uyyp6F6ApZJ42Uhvbe8sR2SbnJdr18s8VcGG8EYpHRsOCyJMt/axpuAAv6lBsTAJnr1dnURrP/e
 9nuvpWph9GF38L82PSw==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a4790a7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=HH5vDtPzAAAA:8 a=xjQjg--fAAAA:8 a=EUspDBNiAAAA:8 a=YRM84PAP6wGYPlwToDIA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030102
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38573-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:d.morgun@ispras.ru,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxtesting.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6B2770168E

On 5/30/2026 5:12 PM, Dmitry Morgun wrote:
> When the first entry in msdu_details has a zero buffer address,
> the code accesses msdu_details[i - 1] with i == 0, causing a
> buffer underflow.
> 
> Fix similarly to ath12k_wifi7_hal_rx_msdu_list_get() by adding
> a separate check for i == 0 before the main condition to prevent
> the out-of-bounds access.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Dmitry Morgun <d.morgun@ispras.ru>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

