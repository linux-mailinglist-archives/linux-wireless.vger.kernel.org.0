Return-Path: <linux-wireless+bounces-38045-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fygyLm+WO2o/aAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38045-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 10:33:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C966BC96F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 10:33:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=OHrfbIAj;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Ftc5y3iR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38045-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38045-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82BDC3079FF0
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 08:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7C3806B4;
	Wed, 24 Jun 2026 08:33:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19283388382
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 08:33:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290008; cv=none; b=Npe89fnQv7MUDnLcMEFKDw4n9SdTXEUtzjz4EB3IgcPy02sLdpOaGRe38DrfQB8kccDcsfVDWBV/LqMh/HDNKIIUOQQ0hPTy5DCXWLgbinxe4cWGUh+0lK/ElVu0uEeYIz3OrRnlWx5L3xnpoiFwvqYJ38uV+pDlJOab7SY1hHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290008; c=relaxed/simple;
	bh=BR2OXalzh0Di7uLslOZDITGTZsESQpM6moTCztzlMHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnlxe1pgT8epBCgDjRzmrvFTkBNecqWGqQwWLAYTPzdgwQPLJ/xkxIh1sPuqtiCXzFZhvzCpy2HC/qhCqvlS/U18/kRQLGeGaj65/m3A4KwF63f4Cdjf9i1rMIhiJkMxpzFYnFZ2NGytYmW51lb/rs+Od47+U0GSgbYkUPME8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OHrfbIAj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ftc5y3iR; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5txW11892330
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 08:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r6YjZTAkz39e4oM5Dzx6I/b4gSdwG3hszZGxP8QBONc=; b=OHrfbIAjZis+NOpc
	cIJGBoUUmUTti+/3dMthJMg4N57NXnFOxvBTHRruHsgJlJH+oEpV68yJ7V2QjV1/
	tsdmStuRxW6XCVw0g4KoYlUXpVXVgtIVtTmIxHWc8mudU+8jrx4nwQG0yNWeDgU/
	LNSdf+erMORjMjf/UHyyWbyQmYb9W43XtJIw5fuyi3G5UoSK7mSLoWQlGKMD7MoZ
	QCbK6PcVCKaFWiyhU1xqo8Q2VK18lOFg7YKe1IlzAIk7G16rGJOcc/n1yQ3bRH/T
	btNPpPpR1o890uPr23G1n2zmEbjGgieyvKn/pFVaNXMqgR4lHth/0sDMIW1g9ns3
	wqIWgw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05bf99rq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 08:33:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c7edb8505dso1023915ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782290006; x=1782894806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6YjZTAkz39e4oM5Dzx6I/b4gSdwG3hszZGxP8QBONc=;
        b=Ftc5y3iRyp3MG5fKlPNpduE/76PoiqDbGbSJNzasF1+fErcYK8Y0oXRJQtkWUZy2Vu
         98kStXJIb5xTyzx0ZzM/2VE8ggolwjb9IxDYMSx0eJrNNZRxRJMIIBRiQrD8VlaxLETM
         Hq2Do6bfX7QQTgvFq1bSGBFKOUsQTOXQVTtdUgRa8iX+C/0qstNy7DljYqoEpOsgIiVN
         Vat9dyTfKeUuAfUDacR0Vr+AorsR9sXGZC9zc4gzCsmbkQw1rlA37jyU6lcTK1BBox5I
         Z3ySb4QWgXWcDdrUzZ9Pd9WogFXXgqM+yJvnzL6Z7c0S62qvPefrVqIXOL+4pxSFIFgR
         kxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290006; x=1782894806;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6YjZTAkz39e4oM5Dzx6I/b4gSdwG3hszZGxP8QBONc=;
        b=FJw5b+ROTJVJqIRAKk9Tk9bMySy5PrNYkVicMzjY1xkOkW/9M65/TYJfEfOsqBOrP9
         Ni6Br7XsOWrOeUyWuiOk2INspCrN8e8YZl/CqQG3eyx7dojbN7YFRegnMosj0k/l00Xw
         Bv7nSWFqKMcweAiQYcFscgO85F1XCxr8ZFBJxb520WYePtKyHqtAJ9bGOnacmr201hfi
         qFoDt9u6GRGqeUwtsPk/7Rl0PtEjtMwnwI+9Uzz9MHcp/uge86WKpDuIkbJ+tyaO5qsH
         hXS/uuTHyDDRJb6C1nr/elgrZMuxFDvIv1hgo9aVwuW0r6Q7ax+ZGr4ZDvlUhdc5jsbo
         rZzA==
X-Gm-Message-State: AOJu0YzvpcG/RTIGY64cbnBYsz+CDl/LRq1oVpnHcq6rg/bieI3+Sr7E
	uTzKIP+9OoXcZoNz72rjdvx41oU59zzSVlmMB8GiE58EUHsYD3vXryqsYUfsQgZYXgdjS9boH80
	euQWW9Guhgk4YGpSHkFAgZ9xPKpN7kGvxfYHH6cXsrUiQ1UrcwubxjHWk4vBzgVXG3GhH4w==
X-Gm-Gg: AfdE7clelDjyR86oHnTpmbRWoXASXhq28pYx2TsIA1sX2SXxeDVbFUBTxhsXuOKtjUQ
	w0tVTDUi24/8lOzxyL8J/cNFSbrq/Y86fMvvGDxtL0Y45ogaEfWc2fxfivWJUcx7Y3U7xRTBWrj
	J14C1Irrv84PAG7MCkEs0J+BPCiCtKMI8GEypp8OPe20cYiIM4GuB5AYK1ztaLEQlYwEWRvjXc0
	1vmyQ56qMIYOttYlGdx0/OYeZhfQVjerMOA/YaIsIIHxTErJgb36RouX45dfGL9d3vZdZo8w9Ni
	ebb/bug0beD8W/OGCuegbUn+4rf7gmf/vZYmbejEJj9/GlLmZbj5L6JsLqBmt3L5IjHN6qfSAEU
	zqO8mhXRUUwJPb+dt+akjKtYqieOx/w/ABpruvdkZj2to4ammeLn55ihU2b81hDY=
X-Received: by 2002:a17:903:4b08:b0:2c7:ebfb:6176 with SMTP id d9443c01a7336-2c7ebfb6545mr5504775ad.16.1782290005699;
        Wed, 24 Jun 2026 01:33:25 -0700 (PDT)
X-Received: by 2002:a17:903:4b08:b0:2c7:ebfb:6176 with SMTP id d9443c01a7336-2c7ebfb6545mr5504305ad.16.1782290004930;
        Wed, 24 Jun 2026 01:33:24 -0700 (PDT)
Received: from [192.168.106.30] ([157.50.13.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7c1ac80b1sm46483995ad.73.2026.06.24.01.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:33:24 -0700 (PDT)
Message-ID: <18d19f3f-f6b3-4dec-bff9-ae3dbb8dff07@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 14:03:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: use %u for unsigned variables in
 QMI debug logs
To: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623-qmi-debug-log-v1-1-79471aa8b898@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623-qmi-debug-log-v1-1-79471aa8b898@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X8Bi7mTe c=1 sm=1 tr=0 ts=6a3b9656 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=DysFi5wBN3dAxe50r5uYmQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=tGGASSKubhSInVnLuO8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: r-NmQRGK7EW-naeEcws6HP-1Yy5MDt-d
X-Proofpoint-ORIG-GUID: r-NmQRGK7EW-naeEcws6HP-1Yy5MDt-d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA3MCBTYWx0ZWRfX1g5DTeOKmQe+
 CfGir8Bw1wiHnIV6hxVPYq390+E7Va5upW78SX6iLlGDBwFRBm5HZsBRfr1RHesVQIhZhxra8rx
 CWJeLfpvNavYMMMryHXMRRUukAz0ey4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA3MCBTYWx0ZWRfX+guOaRkLIQOC
 JafaSUeumwoThy7hoYc5RXkuK7qPPb8swyFHqdBW7uziPhA0qF4qFPkBprzv6LbJtjp8nWbxaWl
 1XV2yuHM2Lzbw03osKcLQiTwz7nIP9O747OPeMIN00NJDHY/KiiiIpn1xJCEHkA+mhf6j1CWQ6N
 CGyffrxfGhOEgZ3XDYDpUNf+tHmMFkRDtXUJdMUd7Vn3xPRF6cy7QBJOLfA+BVX6wRjh3FqE4Gs
 ilWvgjW9rmmuq54aMAQ91y1G0dGAQ5TSague/6U6poPi7xBPR9xJ0wsPLw6ZTjkhRT7VTrk5Se2
 gwNahI/a5NcuSHk+Dbqj58cnwgcGFT3XLzsj6okCaCmDNyKPucAiEIvMjk8qOnCqj+FpiiqspcR
 /WYEj9kV4Uhig3363wkXvrw8YVG0aZcpk7LEiAsURJHRtwh3HrWyip3of+IkEAS7z948pYIxcsm
 og3Bvxr3h1bXXxX2GGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240070
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38045-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:raj.bhagat@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
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
X-Rspamd-Queue-Id: 14C966BC96F

On 6/23/2026 9:34 AM, Raj Kumar Bhagat wrote:
> Replace incorrect %d format specifiers with %u for unsigned variables
> in qmi.c debug messages. Also add missing trailing '\n' in log messages
> to ensure proper termination. No functional change intended.
> 
> Tested-on: Compile tested only.
> 
> Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

