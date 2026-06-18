Return-Path: <linux-wireless+bounces-37895-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dRJXI3+6M2ouFgYAu9opvQ
	(envelope-from <linux-wireless+bounces-37895-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:29:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0881769EE0A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:29:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Lc+ma48+;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Ets+mlSp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37895-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37895-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F763044838
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A813D093B;
	Thu, 18 Jun 2026 09:24:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F123C6A2B
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:24:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774648; cv=none; b=Y5K6cyM3c4/2UoBoYI9yhZV+3IhZYZVk8QNa+kaG/rxBT5jmCDcJdJEMKCKVS4a3kLwpiEzSB8BjUXWCvs69yMD/WKvDr0rnN6Qa5+pJP+Bv3DkrQHVoto2GS68/UkUh9DDqlhM9gxcimjH/AXamkrHvlM4JpbVxbduTTUsIukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774648; c=relaxed/simple;
	bh=Y2kD1UlVgMc2u6ejvES2VYLPm85o/rAmFXvvwUfq8RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN6ZqBwPw+DrI3IcLroppmYkosiKTNQcHwLovbLjHIYyPK8keCD3Xo+wyIJORn0RFeg/2XsJz52onIoY1m14teVIxAI7+dCr7PoUDAI07xCxxYhxnCnXYq6+swPD9wsObz5hH5lceoNvtp7+kUnlnE4kzsJfkbTGtfULAOaTvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lc+ma48+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ets+mlSp; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8FuUU1252625
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V5TBI6ak+oywb6BiRNHaDdbfK/WnYTojRZjnp2HlJgM=; b=Lc+ma48+uSJn5W5P
	cu6c6JNW9PH+hwFz1tM9byXBKkY6Y+qInaA6FP7b5xzOos+5NDWKyfJ+/HNdG5TQ
	5VS20nVTM87HFhwj3j03EOWt3XIFYEUlzyVr4ddAM4NaJtx/HEsawk+GLer+rXuE
	iV+LalvCWAI686otTiS7PKf2C896IeIkRZ7cvKcNkKtLC+4w/JTYmrqwd7CcoNx6
	wv9GV1n5SOY7Wgik+zOUauaI3IE0ctS995Yg42MaoZ+0Hv/rjwP4XTDkA9zSm6Yc
	sqR+PYba4JBvrG8bk3hEOD+UfAzSyV6ypp4pU/b5Xlhhcw+KAkBhVpy+DwTdgG2m
	pK7xIQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7jyyr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:24:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8952346bb9so472524a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781774643; x=1782379443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5TBI6ak+oywb6BiRNHaDdbfK/WnYTojRZjnp2HlJgM=;
        b=Ets+mlSpnln8O6rvkL6yLc77mlFSg5WR+bhH0tLcZUPLbtR7vRvEIPZRAM9Srtd+Mm
         GiBGzGet1DlevVV04xIRSW+Tw939Pl7lzqQIR0sUwpuSat3DG4rIugQOcX+T5PVSC1/T
         yXPvCAzSgw5d+ifYzpoNXj1v77+AMB6zFW/Rsiu3ToQqWZLR/qw/wyQ74duEWwDgcl/o
         qViwTr6ybteOfsW1ZIkurEMhpTJ9fn3TEapjuoC3xHq56NUoxBXd1rifPWwRzs/gmqPv
         yyXciWbFZlUNrpHqoc13+EXXNbClLU0Zo5/oK/+NXYWDfIfqPRP/eVI4LOZVYUNPvGGn
         Fijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781774643; x=1782379443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5TBI6ak+oywb6BiRNHaDdbfK/WnYTojRZjnp2HlJgM=;
        b=pF811rUPJbLgxrUwLs861SvjDazkChcyElANG2cqfZYRnMXWDJvN7vD+PBs9kkgCbl
         HfJopctcCBxHtro4gh8U54c7gVrdoT9mWGhKo8EMZ/B0HKODEkDyODULFxUyrl78oqne
         iZK1s3+SKm7OKMxBs9u+FhDI8e+Co9fUgcN5usmIRsy9hurs5yZD34fGWTwBFm2NeMjd
         sBflqlkbd+jyyb+Zsz98EYKybEoGGwIGb5siPQd4W5fPxFV8liFfJQPGC8qO6iq5/IT+
         czrND1G4UZVV1+G10xFtT4Iqv9TCAZi/EhGnN1PsClSav1yryxTdwMmidtT4Fp3Q+/M+
         nXWg==
X-Forwarded-Encrypted: i=1; AFNElJ9vMsyJCMFhdrRbpUWVS1bNkkt4QWvd6VWWACoJLI3ZrWdDe1ajq48fk72syk5qNMLgdp9en6NJOqh5HrwpUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYU0So74wDssy0Xe2N2Ngo3c+5gBdnq/ps7Z2FTxmcR+5/iBc
	jZirftL1G7qBFtrRkErKQEXoDfmA6mHN2SuVzixkXp+NSEeCGBqf3I0nIm5/WOvPMzWCZxi6eUD
	uCQfG2rO2r2/AchRhyKwjcbBYZVY04WHs6Vgw2IsIMhdkkUJ3ttIu6fcnZwLGGd85m+SfKobbTA
	GV8A==
X-Gm-Gg: Acq92OFDs9XW912azr/jHcgOdO1sH8s/KHxkPid/wHDu89FkwYHMA1QT120TwadcH1J
	K/uvjCzxyiP6Rft6qyo6lD2dMfJPVR0j0NNCiWgzTRmGNXzgWfbbNfjWgEg+b1peHIKa99ulEWa
	jjHqLab27cqKfWbW9Trzob2joqNLFDNAJSUByMXUPory+0uMLZFG9JpWkNJtSjVs3R/IfvWs/TJ
	qK3m444DsLZp+o56K5rcuVcIzzuZr2AGLGKH88KfXuLUlczaGhPDP2BkgGAZXyL/JWjWBO+pHb7
	inzDAUQofbiPtfXwA9/8ln1cCbCnx/EqkZsZ7joEL3r0ySe1n6+7SByUHjq2Iwm/XPfEePn/ORN
	uBZtTnnu7bQPCt2pWMtRnNJQbQSg0sIa/RyULs7h1HQnYUGyyaPkgEbfi8gg=
X-Received: by 2002:a05:6a20:1581:b0:3b4:6dee:a427 with SMTP id adf61e73a8af0-3b9e8965e90mr3929885637.44.1781774643157;
        Thu, 18 Jun 2026 02:24:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:1581:b0:3b4:6dee:a427 with SMTP id adf61e73a8af0-3b9e8965e90mr3929849637.44.1781774642710;
        Thu, 18 Jun 2026 02:24:02 -0700 (PDT)
Received: from [10.137.71.130] ([106.197.93.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86651adc16sm15446851a12.31.2026.06.18.02.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:24:02 -0700 (PDT)
Message-ID: <c6f69f67-5dd8-43be-8419-50d69b12a80b@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 14:53:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/5] wifi: ath12k: fix dp_mon RX parsing for
 32-bit TLV
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4NiBTYWx0ZWRfX0dmG3i/0/WGr
 4gk+S9Rc2XEuIgBs09EsZ45o6Axw5r+gZ8FD0Oxf5v5nTAVstKlHih8T/ehNH92TPfJAm8oqFCF
 1clcwp04fyk0yXZ0xXYGuUsAdfluTnqci2J1yL2vZCh4irOJW6BDe+K5/lMV5UqJMhA+dx6ZYrE
 YDf2UPzthtJTciC/DqgDZWtwmSXMzxIi6Yvpi/1VkvfZ4LGi8hSntYZMQnNq5zLh5CL2y/fOn8N
 nEbzPPhJUJG5ffFvywzSRJM1baR1D6sws38KevRbfyaukYvO9BaE3RI/ZUV1BT0YEuteR669mRc
 pTwabQQVq3piST9PwPa5YOzzoXce6Uwmix7XPXY1uWflkK+ZnNM0IIfOYAVoFZhCLg4f47+ZbET
 yM2QCCsUX2Ebfb6XOKMuwGTXJDUisPqYKaoROBvM8c4LcbR0Ill9/0AUhElkX8wUyxZu19lJsHw
 vJu/EyayOryVlwORbcg==
X-Proofpoint-GUID: nxqsNblDiZ0CbzEeFabQU_FlIW3uWdF6
X-Proofpoint-ORIG-GUID: nxqsNblDiZ0CbzEeFabQU_FlIW3uWdF6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4NiBTYWx0ZWRfX1uE7qW4aTVsf
 y+HQoaSBiE4YMcu2bhs5jSxzpSYnPDXVifoGYrVpwoALqMj+V0VZ+V8v9aK17Fq3NA7SczWwikx
 5RNRCnMj3d983pqCaGnAkin2IPD+B/s=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33b934 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=wlpA7Av3g41Jdys7FXR3eg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=lYQuDnyKufBgxpUz7bMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180086
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37895-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miaoqing.pan@oss.qualcomm.com,m:jjohnson@kernel.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0881769EE0A



On 5/9/2026 8:28 AM, Miaoqing Pan wrote:
> This series fixes RX monitor status parsing issues on platforms using
> 32-bit TLV headers (e.g. QCC2072), and tightens TLV decoding robustness
> in ath12k datapath monitor handling.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
> 
> Miaoqing Pan (5):
>    wifi: ath12k: fix TLV32 length mask
>    wifi: ath12k: refactor HAL TLV32/64 decode helpers
>    wifi: ath12k: add HAL ops for monitor TLV header decode and alignment
>    wifi: ath12k: add dp_mon support 32-bit TLV headers
>    wifi: ath12k: tighten RX monitor TLV bounds check
> 
>   drivers/net/wireless/ath/ath12k/hal.c         | 42 +++++++++----
>   drivers/net/wireless/ath/ath12k/hal.h         | 13 ++--
>   .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 59 ++++++++++---------
>   .../wireless/ath/ath12k/wifi7/hal_qcc2072.c   |  4 +-
>   .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   | 13 +++-
>   .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   | 13 +++-
>   6 files changed, 94 insertions(+), 50 deletions(-)
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

