Return-Path: <linux-wireless+bounces-31157-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBtsG9bhdmlVYQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31157-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 04:39:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD6683B58
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 04:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08FE830038CD
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 03:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6B5128816;
	Mon, 26 Jan 2026 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dol5k7We";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LObDqfiS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736C7DA66
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769398738; cv=none; b=iHJ1V6nGDpaepB/2aPfQQcVw2Ma+plCse7QYu4ctHG/wWpzxRgGYZeVoiTLxxHvEKu0CyCBtZozgxcjx2XCnI3pnOuGfiQ3kwdPbUxka27o+XHGcxuisYLpWP6tjmV1HpiVRwKaTNnlPl0EIfNQ9t5lUpvD6lMRHPfhV2gmAia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769398738; c=relaxed/simple;
	bh=TqlATIPa4XRc3z/Wv34zDWtEE8oBMaUYifKscoYeN2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeTjdSz1le3v3zbBo4ARAM+1IYCCYL7D0ukw56pn3+SlEEHlh5SuLK8/tnkRyNAibHDgnQZg4tGTanfUAkPdwIA/ZvJgaB3Wo5s4ZezRzSaWlJ+OcqDI06HsKCs21u+0DC/Ts+EzZFHZrURWhPUbyC4mUM3xe0DtS3vL34qnvRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dol5k7We; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LObDqfiS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q3N4p03575046
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 03:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gs2bMOBg33skx8G/omcMjpU/uFdHwlt6fJoehkBMeCM=; b=dol5k7WeOvSttY+9
	pe4ZdYdESuAuWGgy9W25sVSEAfMJ4mfLXllJ4qZXqalaawU3BLUxB9E4WJVHd81s
	zl0QbgWZQdkfdS6LjI4imQoDnL/gm8xrnpRMYGuVj3coi3cD9gxKJ5ZAHUdRCfDO
	oNNOY4tB4i1SeRj8drDOvpZIyoBMQ5xzGHU/bUm25M1piuMm2D1pQTSCnxnBoKBi
	J5xVXhz1qKBIApbB5rMpluHeDHgl0ioOr9wnal5F7t+yJseJGTqpIOo0dR2tdQUf
	Nmb+u6w/9jzaBBO584RmxIo0ITGbpmeMLn5HJ0FvDY6qfiFfFSee2paIrA78JivW
	TGDMXA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvwtyashc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 03:38:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso11701160a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 19:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769398735; x=1770003535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gs2bMOBg33skx8G/omcMjpU/uFdHwlt6fJoehkBMeCM=;
        b=LObDqfiS4TYkKHmjAul/7KOhHeV0yYgTCXltTHdBHokFdAXHHZvdhGurJ6EJuUbH0z
         DNWaXCaBfxa+V1w1rx3SADfkvoqE/4tmzzy17rc9c4YxSb6rQqZVDly8T8atSjDcUWWV
         gtaSDciyAoVVtqBouYf09y6oprnBEVRXIeajA9lCFmSWizpnuKL36wjLCilJaxtBwMI5
         nHns5oCANbWOedVRaFZQ5VW/FSPcHTBZdLVJsjLqLQPGVrEQU3zcpqUhSBe2f1LcewUK
         DzJNWyonn/sjBSNWrUDhHYI9iH4BxMT46Sezye+hwsBqH1+hMv3VltujbDWDZBXFtHXq
         7xwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769398735; x=1770003535;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gs2bMOBg33skx8G/omcMjpU/uFdHwlt6fJoehkBMeCM=;
        b=aNCxkGwTVYuQkKx20fDkDH0XHvdKiDfd0dHySZIkZcFwhX1tNPAn0Lhlex9ENIn0Ly
         ZPgX2XIdkomYKgmfNsPywH8iN4lqF+h0qEE9O7CVxX1sSrkDX2T0ffyQZc9xH/eJs3m5
         hE1uuOCcRWL0Sqb3O0UVeUoG/IQ0lqE/bitM9UmtTPYWWrfDThvTwZ2WU1PRZ6X3hMg9
         +h3Mo/xQvKInqdzWqZU73gY3jzvuKaEZDnIaBiHZdMYQPb9dLTfRxOxgnc1+SYLiYxIC
         RQnY2UPdcC7SlYEPMRmXG9g9tJRrO8CCJ2MqXtngurV4amR1qjuiAb26TCzn+VKjBgqL
         7H/Q==
X-Gm-Message-State: AOJu0YyAvsvgZv/7MC7D3SMEpFDD1xL1uXn1AYmRO1QD4cwdxhJQJR6W
	25GMp28blv5hukBT7yIuVzPLXb7TGa7F9swIweqChLZXaLbCXUrnNff245RwUn9fS0US7E1td9Y
	uKVyYXmwBpUV3JkTpU9N7IZhy3ivfYmyC6kammN5G6vR8W1f4escJpSL45m0qvGWaT/oHVCgLxj
	8bGw==
X-Gm-Gg: AZuq6aIbjtw5VIo1y/KZOwQRmv7OhIid5rRhpqev1kEppA8iKVoecpF1zd8rz+0lPTI
	kH7oaJ/9qH1iAUnZTxwuF5fsC8OFE5h4mvQy0Qrcaj/US3EyS+eC1Qn3/JggYXdu8njszEgYBI1
	gfOzXwAoXyVP5XKlQwqx9AB+zvimFOhf+hMgJNDYo2Ndqg7hBsWZ5qKOnREk8dIXNJ9tbD800E8
	+nSL9oOwKMCW34OAXFkDYp0mjLiAlzM13VAexL5hMFnM55RSf8pqQrMtAFTxj/TMcyCmcY3dOX0
	2U7tzYGX5N+4Bm2kPBl+gn+Ppc0nu90zLzfNM+nhnTB7dc9llUhsqX94yojOU9cHV1VXhtPA4Oc
	kCiikjkcOHHVMJzMWxQUDgtMASVZYSahe7bVE1gHNps7DKcTKuMh6lzQG49dvIpELYwJCXwN9/L
	iXzRncSYQ=
X-Received: by 2002:a05:6a21:9082:b0:366:14ac:e1fc with SMTP id adf61e73a8af0-38e9f30bf00mr3173749637.78.1769398735316;
        Sun, 25 Jan 2026 19:38:55 -0800 (PST)
X-Received: by 2002:a05:6a21:9082:b0:366:14ac:e1fc with SMTP id adf61e73a8af0-38e9f30bf00mr3173731637.78.1769398734862;
        Sun, 25 Jan 2026 19:38:54 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536d88bd00sm7449444a91.2.2026.01.25.19.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 19:38:54 -0800 (PST)
Message-ID: <23eef2f9-51da-4136-af54-d48e0d652c2e@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 11:38:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix invalid frequency error in freq_to_idx
To: Saikiran <bjsaikiran@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
References: <20260123155750.6007-1-bjsaikiran@gmail.com>
 <20260123155750.6007-6-bjsaikiran@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260123155750.6007-6-bjsaikiran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: V1D2M0Z3_LGmOTDxzTaOICsRHkQ2nTcO
X-Authority-Analysis: v=2.4 cv=BteQAIX5 c=1 sm=1 tr=0 ts=6976e1d0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=_REAg2KUEwIIqUTL4GEA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: V1D2M0Z3_LGmOTDxzTaOICsRHkQ2nTcO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDAyOSBTYWx0ZWRfX15R6ECPnmO2W
 ogGC+LsRfqPbbjdcfUCz5SFwIb33SqHtcb7NyODDITcDAIr1d2TLFFDx7kHJvQypHliAhy52vBZ
 nRYKzLyHS02CQ8JV29rCClBf3mGyOJQ8kR/Fy3MO+tBmHGG+B9Zy4abkLhmESb/IhC6bs7fe4zG
 fyQ7A0LfxTvUR04vF+wm1OgZ4wyYtZ2CReCVZJ8AVU1h9daZuVvV5HG0BH6P8WJmhs49ylw/Qyr
 rUMOZvgp0muPZE9RSzD31u1KB+kRAnxs1xPyQlbMnEKgg5QmNOqfU1yZRQ4sMJ8MvehG9EN8ezB
 /Lnh31qIZ7irqxCDRhlh7+OBSb3mlknZof+g8hYma13kQQvrWd1PI1Mqn4Le3T/EUvX/4lvBrBD
 2X6/9kaiZ1fmWmPpBYuASK44PCRRjFsYqjkq6J4FKfE3dmRj9x6m6I8ND8cAw29Ld3txs/CgqOw
 8vXg0+PDYfNkY/nuQrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260029
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31157-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: 3AD6683B58
X-Rspamd-Action: no action



On 1/23/2026 11:57 PM, Saikiran wrote:
> During suspend/resume, the following error is observed in dmesg:
>   ath12k_pci 0004:01:00.0: chan info: invalid frequency <freq> (idx 101 out of bounds)
> 
> This occurs because freq_to_idx() incorrectly filters channels based on
> ar->freq_range.start_freq and ar->freq_range.end_freq. These values can be
> temporarily zeroed out (e.g., during regulatory updates or suspend/resume
> sequences) while the hardware is still operational or reporting status.
> 
> When these values are zero, the filter skips all valid channels, causing
> the function to return the total channel count (e.g. 101) instead of the
> actual index, triggering the out-of-bounds warning.
> 
> Remove the broken frequency range filtering from freq_to_idx(). Channel
> mapping should depend only on the hardware band definition, not on the
> transient regulatory frequency range. This mirrors the fix recently applied
> to ath12k_reg_update_chan_list().
> 
> Tested-on: Lenovo Yoga Slim 7x
> 
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index be8b2943094f..bef1b324b62c 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -6576,11 +6576,7 @@ static int freq_to_idx(struct ath12k *ar, int freq)
>  			continue;
>  
>  		for (ch = 0; ch < sband->n_channels; ch++, idx++) {
> -			if (sband->channels[ch].center_freq <
> -			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> -			    sband->channels[ch].center_freq >
> -			    KHZ_TO_MHZ(ar->freq_range.end_freq))
> -				continue;
> +
>  
>  			if (sband->channels[ch].center_freq == freq)
>  				goto exit;


this has been fixed upstream, though for a different issue.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1fed08c5519d2f929457f354d3c06c6a8c33829c

