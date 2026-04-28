Return-Path: <linux-wireless+bounces-35435-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NCVAyQh8GkSOwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35435-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:53:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 609F147CEFB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87277301B905
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84B8287E;
	Tue, 28 Apr 2026 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kiaujGcw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gX3aE2ho"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D8C38DD3
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344800; cv=none; b=j40E7LyluAPDxW+fXsy5YQx9WBGXxmj66ZOGrUOzjr9/7mp57kagyQB3EmxwRYx0djpA03B5ND0oqzuQTCBy7UBP3c9NvJo+CGWLn111lPMtjtQWpyYYNFbJoPYhjAN5HUptPZ+rnjY3Omy01B/nnEl6gmoDtvrZ2223sBtnMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344800; c=relaxed/simple;
	bh=ISReurV45dvoT/GTivhBL3Df4U97N97IeIVoG876zbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbiE5dS1QFhTszEyk0ftn0ep+nBDb7BmUV0hfT8pyhNvuiAYBq4FdiQVvVxHLU1ZlQZBIiuuBHgfIEfdWpMYpeACAMsmfQrRtOoE7tRUPjbNdMMSEdpC1YW0owKl6bVWDKKl2RfzeCLNCo/KBFFcmX3yaTjk+prcc2ewwPPPQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kiaujGcw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gX3aE2ho; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RHYpSS1237422
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BUOg+aWEwcyTOIiXkjXZQ+l8hnQCtNpHYc4x39G8OzI=; b=kiaujGcwE+rB/mpS
	+7v5WncJIhRYdYOlmnKxYXQCOlh4vobVY7HlA0W7PgcRL2VovHWgCiKLjUV+NcFi
	kvnnEVMZuX/scgUSif2027D30L1s6aQZcz1t0wbBF7Z3otXa2uMLXmDnnsIG2f4N
	Yd9JrfZTzjEC0nf9KCmMCs2lplRFl1NwO4CgxQxM7PCbiX9eWPgdT5iWmrmM6aBG
	yclHL+1P8FNgb4DyDHBAwky1nTDac4jJ74pz0G7kV2aXwO5JbDU+AYuTAd0+833d
	yag0QIvWjUOYMmNLcfpTDHywm0pdBnw+F79VWJcNc3ypfHJct8HOYVSebK6zlrtE
	wKytWQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4k7x0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:53:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a90510a6d1so89912725ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777344798; x=1777949598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUOg+aWEwcyTOIiXkjXZQ+l8hnQCtNpHYc4x39G8OzI=;
        b=gX3aE2houUhRapzy11OHppYngRhrTKmFNiv4A+2EVIqvd64EzofAbghfSFWPPLB9r2
         V0R6SvY8wa6rqrc3dpqVxI2htSExqfgx1NKnRyZ4m74LSHVUWBNvUJRNGFkrGZ/lEdEX
         s0HbOpiUsiSuaD3si6c4G+Gt4oRBdf3erdNLv83sMQXkLxnCtwFPTY4gEmA97ppdM+LJ
         S8lZfqKyoTkOTyeTUMKag6XJ9xlTfFUhEkHQhpuBfLpBEbVFnL7O+B/Gl5J9dLQQJpto
         zrZIn0UPqP20iVK1rKsGOTEj/uQwPH37bJqTNht1WgKWNJHOPJq2h7OSyFU37e2uiuke
         XQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777344798; x=1777949598;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUOg+aWEwcyTOIiXkjXZQ+l8hnQCtNpHYc4x39G8OzI=;
        b=rbcRDg9960Gqjifjm9miqFktA9EeHilkkUgYM8IK6azQPKTnFS17BrvIqUbn8EZpSL
         hUT93iRetkyzgsNwobtrGrD9f2FEM3OtRW8WYQp20KaFKceY5EdNMdmrGBw+Vrzyjvu9
         UssWGZg1wyz2ObWZt2JFi4xPPtFNEfGExf2/PdYJYUhAlSvz782+hborYBv/tDsciPFZ
         3XV5c2WiiCjnmWOFBu9Mx7I1GeiiJMqLsFSlACeAO8sNq6GDOiJa9fzUlLIvDX17MfL9
         UlBYGzb5d71NKyYuljWzbtzIyxKuUd2lbdHGKUfWUJHTqkK5Z+kafSAwKwIZLBklpnfd
         b86g==
X-Gm-Message-State: AOJu0YzrtfgxiBc+4oa9WtOI8sCwYEyocbYRwMWdqab1JrPpPJ825x6D
	x5TMCqhce9rPuUy17/3hjmrNYc8bmTutMeneDVyLM3+i30JnRYRRQoX00WoX2ke33MGq86FhB62
	jgORn466cdk8ATjDjPbiMgxDMwq3Pz6xU8Ew4QAYNSoJgfLhrVsoEfPGEoUZh44F3NPvxSA==
X-Gm-Gg: AeBDietTW1jXSr4fdmFSaDrgi37O9s3OQ0iNS8pvzkoEfS1uCL+2T41SRm1R3FyR4Rf
	J9YbHA+DFh0xrgJBvCrBqPX++KT5t4Q5nCU3z41dlcxDTHKM7xQmSPnhvrmiBJ0BYbY1r0G63zw
	DRr+eFqDfO84lr6fnhgQVy4OQ2Ba6wG0qs0w3WR+/CvU2C7dKzlaqaDDBkm1yCCBSXattxKwWFT
	fl2kmna7xTVA5+qusaT/dVNOMFFc7Z4RDEN3eBJDLzFShSbkJTTBgG6JccPvqw/hHC19E0vmBWB
	wIJyGobepWa+x4uFdBu55f/K73rOxoVgKfntqYRF9Sa83q3MFIWDx6+zboafw20CXsDjuKspnaP
	S3nNKrxvbyXzMXmb0bgQHA8PHBR0uZJcJnZnO8EVrPapjj72JKUHgu8f4343alF89XhS/Hut0kA
	d5mFOTcVZTknTJx5CjBBtmHHq3JYQDBA==
X-Received: by 2002:a17:902:7d8b:b0:2b2:4dc4:18cc with SMTP id d9443c01a7336-2b97bffed78mr7577845ad.12.1777344797695;
        Mon, 27 Apr 2026 19:53:17 -0700 (PDT)
X-Received: by 2002:a17:902:7d8b:b0:2b2:4dc4:18cc with SMTP id d9443c01a7336-2b97bffed78mr7577755ad.12.1777344797224;
        Mon, 27 Apr 2026 19:53:17 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8b38sm8594125ad.76.2026.04.27.19.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 19:53:16 -0700 (PDT)
Message-ID: <23852895-c459-4340-852c-ee7f40918d58@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:53:14 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath 0/2] fix leaks in some WMI error path
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260424144813.1708214-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424144813.1708214-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 83nK41lgBK6HQiw3UU-uoGDtsDbNteYq
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69f0211e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=FqyUr2HIOI8AG8dd71AA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 83nK41lgBK6HQiw3UU-uoGDtsDbNteYq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyNSBTYWx0ZWRfX9ojPM5ebpaDR
 Y0U3BXbn2RHAJguRfLZIss+bB3Vr2rQmRBM3wGkRaLgL53HAtBqQTVFhszRHj+aek9vx9eySC75
 4QlToL+4s2Wf+pIiSWm4gXZIk99YsC2kNJTNpHKwZpQhWoW/i1E3r+u8THV3q9C57+DUwH2Nm/O
 FkINH79cbpEw7iHxHOd3WhlcJzoFCz9lBRnxsn41eNk6QLLFT12GNnATzVh/F7t+OLCA8VfMrA9
 ++UKEcd7VjGB8mPyBEKU4/s6RuIqpEPjjoYJIq7hKoAQwAU1k4RcXbaotta/0hpmKxDoO7sz3gu
 y6xGlsnNwBKSLxeDHtaKUzZDNgV94+7GYqB2/S8i9fWlHnjY8jvvJvcu0zWlaWsl+xhsFHGd4pD
 dLbJ3oGyEiMmU2B9DhyOcok2Zw0Ck0yBqKzEbLtc8WpthPUGOOV730XT+vWCrZzNnnTkXF2gAdM
 bYMvL/BkEbHhlo/mZ5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280025
X-Rspamd-Queue-Id: 609F147CEFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35435-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/24/2026 10:48 PM, Nicolas Escande wrote:
> So this is similar work to what has been posted here [0] for ath12k.
> 
> When we use the pattern 'return ath11k_wmi_cmd_send(...)' without
> explicitly checking the return value we fail to free the allocated skb.
> 
> This has been split into 2 patches per Jeff's guidance to hopefully
> ease the backporting process.
> 
> [0] https://lore.kernel.org/linux-wireless/20260422163258.3013872-1-nico.escande@gmail.com/
> 
> Nicolas Escande (2):
>   wifi: ath11k: fix leak in error path of some WOW related WMI commands
>   wifi: ath11k: fix error path leaks in some WMI calls

these are ath11k changes and you are sending them to ath12k list.

> 
>  drivers/net/wireless/ath/ath11k/wmi.c | 131 ++++++++++++++++++++++----
>  1 file changed, 112 insertions(+), 19 deletions(-)
> 


