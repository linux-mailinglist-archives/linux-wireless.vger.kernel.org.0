Return-Path: <linux-wireless+bounces-34374-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AGzDJvY02nUnAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34374-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 18:00:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E63A5072
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0C8F30160D3
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B19833554B;
	Mon,  6 Apr 2026 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZwGuYaUH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R7HN2r9v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB7933BBCB
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491193; cv=none; b=jAfoe+mhzzqMqoCcMV2Io0WBnRKvBtwd91ZUTlP1Tx6lEdWiKiT3JAvz+EywXv9JfrcZYUv6IpCy8uq3OidiQH3xOxJILdzcZv+3/slCXB5VCAGfK7WfTi/95RTACZVZfZshQDqPq6N2jS6m6Z6ta7yLsuSUj0zUnfRElbqHKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491193; c=relaxed/simple;
	bh=Fs64JQKrSxYOf6f114JYVTywtVIpHrSO1lQ7xnNQ2w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE54Sk6xJz1xWbLrFE0tqYanRoyw2InrfOiaKximX5L07nb58t0kdWyVmEoTeOoahKxBuyh33PCd83PNZ6vtHvI9QuVN7MVLm1FHxsU3fyKHhlHeyu/8i19PxF0A/mZpCNjlNcnBJEHiqgnx4HpN5Bf00Ex2P15y1xQKj5plkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZwGuYaUH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R7HN2r9v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636EqsIA741891
	for <linux-wireless@vger.kernel.org>; Mon, 6 Apr 2026 15:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjVuAZvqgjuFQQpcpQvR35Vtw2UNUGrsrSTa0onc9VM=; b=ZwGuYaUHr5jsCHcC
	Ux4Z/XgaY3NzNMIrlLM4wgiguoPxo0l7w7xWcnr20EGK6cvRCbbX1t63/JPKFGeY
	9XQvNe2bAViUOEVz3JCFEFdZmtf64Z8+8EeH2vAeIH8Siux8x17NtMBMOZP41kSr
	oQQNRWs6iKzXTGWkDEsBthkb4NC6UfwWiDBWvuxXVDB2yVkUxvs/g6H9zuSZy8gj
	VrL+AAh34F6nRF8jhSLQeYvU4DXXOclwlP0fYezg7hhzPp42kFhCrg2p7yagYN0F
	3ut2Kumj1KLu9IFM5iW4qixW4nvMKdykw0hcqrqbHq7/b0M4OyOOuYlEe9hS5Y2Q
	jIhUAw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dceyxg6xc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 15:59:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2cc9118dc2eso11294301eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775491186; x=1776095986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjVuAZvqgjuFQQpcpQvR35Vtw2UNUGrsrSTa0onc9VM=;
        b=R7HN2r9v2v/HLeQfeCVE5Se708jKYIU+JlWXJKF66W6U4lvvC/pWDKSf1cdK66IyBb
         d/CeGp/udqz4PnkujjeVQOZxxzKKk63G/B3Eyy/a8FnpPHK9naFwuaj2RCxjG0C8sF0K
         lpW6yuR5KTwNZ1FXKJGJzr112GsOGTC2AQ6Mhm8vRkKTB/Y3RnXvPjBcxtSI9mDiEKaX
         AB3N04bXHlMkHWxiObk6OLlX7xxuDGLqsrgS27OeaToVSKwvAqOCZvEKU1zj2s7OOK87
         ojj2+6zRxaSZKoAeLVrD0Mri2fAFlxPSo4GkTSWwr3ntoVDisAtMj4V8AfDcnNwXxpIm
         CCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491186; x=1776095986;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjVuAZvqgjuFQQpcpQvR35Vtw2UNUGrsrSTa0onc9VM=;
        b=EQ1M5Pqd8Gkq0GXGBM6Wf1bGdRIF6mco80f/PQUTVUWhNPu2mChdO875zgRRAvZRAj
         FlqnLQPQIRjg2PsDxID9bHiQko5XD3QamRNpg5HJOryUk4tzEmsF6u2djXXzEFHmhkQb
         1anmRC6ZoQGWsquMt1IuADBXxkQO5y0AdMvKeehLAXwjEWKgYdurGDKtALPg1vwPIQlY
         3ITWipxBwJg7MGJFagG7mN4iL9Uv8Mr3fXG4RgCDt/sbOCAxUeb6BOm+wKopIZft1lAU
         gAo2rJF0djxU7PCP1FcstUh9QHIOkjZrjDQdl2vKkiXDCbAuFFnNlZsp1wzh+1GbSSG6
         gMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR2Ospl/Ib++e82rmjjErcya/gy2sT8aJEGGuq4zifxA+Kj5qGiUFhKMNPO9EcnbLnetfOoKScyaTmhqmE7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pacuclImF6d1JAhUUMktoG9j94KI7unsS+GShqUm7xQCGVVZ
	mXHEpSbWcyLmZzpZRmrrlIoBia1vABix9UasZBJxIoQvhky6yPAwHayCrjZ61dRLipqrsaCrM0E
	c1CMnUkjXCQX9gjgrOmsv+COspLrfRo+LphS8vS7Lr5k58LMozcEALyQWJHUzobPwGMWRhQ==
X-Gm-Gg: AeBDievYlV/msegAJ4X/UNOJT0LF9GaTVABWdbSNFwzsNHCJiR/Zfl3ap7VvsPP+7Oy
	H+iIcHc39Y/zTDfX+25GN/4kXJ0xHRrygUO/J/mT/YewMfObLhcbalLFow9YCOv6dIf/83up616
	eZUlg+XwR79mUE8q/MPea/bJf3tDBX1Qy5WsqsIA3W8HsqJVbXoPrKYwof/PGCjNKcVtgiUr8oW
	7TOK1NMgA7tem/hdljbnhV2/hpl1jim/jpPKBQi7hQE+rlSurHjxHHoVIUtlXpyC8TcoujPYoex
	0PBdgfvSD4FcmfeH9DZZ7jVkHr4ItVJz6QcfH7YeGxXRoCarGWP9cMEx0QGBCl6NSPhZtiDGHJB
	lGlO+Sg7qbH0203UrInhULf3MbjG+8o1VKlUd/OffncEK8w4NavHruFbSKScIPukBtICjCgipFk
	SinO3rcFU1RSiG1w==
X-Received: by 2002:a05:7300:6c1f:b0:2ca:e4f2:31de with SMTP id 5a478bee46e88-2cbf99ecc03mr7572733eec.4.1775491185382;
        Mon, 06 Apr 2026 08:59:45 -0700 (PDT)
X-Received: by 2002:a05:7300:6c1f:b0:2ca:e4f2:31de with SMTP id 5a478bee46e88-2cbf99ecc03mr7572708eec.4.1775491184636;
        Mon, 06 Apr 2026 08:59:44 -0700 (PDT)
Received: from [192.168.1.44] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca792f3f54sm12750506eec.7.2026.04.06.08.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 08:59:44 -0700 (PDT)
Message-ID: <01c3a67a-abd2-4eb3-b6dd-f87a4b33065b@oss.qualcomm.com>
Date: Mon, 6 Apr 2026 08:59:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 0/6] Consolidate Michael MIC code into
 mac80211
To: Eric Biggers <ebiggers@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <20260405052734.130368-1-ebiggers@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260405052734.130368-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2anazjTWUfIE35XYUJ7-4wxxn1gf6CSa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE1NyBTYWx0ZWRfX3s7944ekQFpC
 OGfJKrNrmFEM1uYvnsCrvwJksc46mhpD49wfsuudv2sHL5bEW2gV9lI9KU7K1fbJP1H86T3J11H
 fw4Y2DK+k+f8JQfD9W8b/Iz7+1suib5ukdpbfCBRQD2hcCAjMyNpjH7EFSQ4wCVJWKWTZ8nnUYY
 lhVxCPZTBasroCuHCO/w7oH+BkgxSgQVu2JIJnKFvIxHD/o2kQdHygvV7KSa0OZcpzXPlkZSfkS
 6VYQ4dqCJVG21v9ouJd2PfqlY922s/sfPrXtgidqAFP7Jt2gn+yyr5a+WiPkfdnjW3kD9aH2Jvf
 vVkD5lWjj7J2dnEvzx77MEMouXu0mBun3c6FUev5mZWOQCqQwRTVGrD9g7BJGFlQMkFri7B5Htj
 J60pliJvG58EzGtIdnvOPm2Cs/0S1nw/FhPJVAENoZDz5zgSeZtqw+7UrOKYp/2QNsH7joQSFfP
 W/xscX4GzhcaagR690A==
X-Authority-Analysis: v=2.4 cv=PNsCOPqC c=1 sm=1 tr=0 ts=69d3d872 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=9DdjR0jtjGRORKJrtHgA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 2anazjTWUfIE35XYUJ7-4wxxn1gf6CSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060157
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34374-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9C7E63A5072
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/4/2026 10:27 PM, Eric Biggers wrote:
> Michael MIC is an inherently weak algorithm that is specific to WPA
> TKIP, which itself was an interim security solution to replace the
> broken WEP standard.
> 
> Currently, the primary implementation of Michael MIC in the kernel is
> the one in the mac80211 module.  But there's also a duplicate
> implementation in crypto/michael_mic.c which is exposed via the
> crypto_shash API.  It's used only by a few wireless drivers.
> 
> Seeing as Michael MIC is specific to WPA TKIP and should never be used
> elsewhere, this series migrates those few drivers to the mac80211
> implementation of Michael MIC, then removes the crypto implementation of
> Michael MIC.  This consolidates duplicate code and prevents other kernel
> subsystems from accidentally using this insecure algorithm.
> 
> This series is targeting wireless-next.
> 
> Eric Biggers (6):
>   wifi: mac80211: Export michael_mic()
>   wifi: ath11k: Use michael_mic() from mac80211
>   wifi: ath12k: Use michael_mic() from mac80211
>   wifi: ipw2x00: Depend on MAC80211
>   wifi: ipw2x00: Use michael_mic() from mac80211
>   crypto: Remove michael_mic from crypto_shash API
> 
>  arch/arm/configs/omap2plus_defconfig          |   1 -
>  arch/arm/configs/spitz_defconfig              |   1 -
>  arch/arm64/configs/defconfig                  |   1 -
>  arch/m68k/configs/amiga_defconfig             |   1 -
>  arch/m68k/configs/apollo_defconfig            |   1 -
>  arch/m68k/configs/atari_defconfig             |   1 -
>  arch/m68k/configs/bvme6000_defconfig          |   1 -
>  arch/m68k/configs/hp300_defconfig             |   1 -
>  arch/m68k/configs/mac_defconfig               |   1 -
>  arch/m68k/configs/multi_defconfig             |   1 -
>  arch/m68k/configs/mvme147_defconfig           |   1 -
>  arch/m68k/configs/mvme16x_defconfig           |   1 -
>  arch/m68k/configs/q40_defconfig               |   1 -
>  arch/m68k/configs/sun3_defconfig              |   1 -
>  arch/m68k/configs/sun3x_defconfig             |   1 -
>  arch/mips/configs/bigsur_defconfig            |   1 -
>  arch/mips/configs/decstation_64_defconfig     |   1 -
>  arch/mips/configs/decstation_defconfig        |   1 -
>  arch/mips/configs/decstation_r4k_defconfig    |   1 -
>  arch/mips/configs/gpr_defconfig               |   1 -
>  arch/mips/configs/ip32_defconfig              |   1 -
>  arch/mips/configs/lemote2f_defconfig          |   1 -
>  arch/mips/configs/malta_qemu_32r6_defconfig   |   1 -
>  arch/mips/configs/maltaaprp_defconfig         |   1 -
>  arch/mips/configs/maltasmvp_defconfig         |   1 -
>  arch/mips/configs/maltasmvp_eva_defconfig     |   1 -
>  arch/mips/configs/maltaup_defconfig           |   1 -
>  arch/mips/configs/mtx1_defconfig              |   1 -
>  arch/mips/configs/rm200_defconfig             |   1 -
>  arch/mips/configs/sb1250_swarm_defconfig      |   1 -
>  arch/parisc/configs/generic-32bit_defconfig   |   1 -
>  arch/parisc/configs/generic-64bit_defconfig   |   1 -
>  arch/powerpc/configs/g5_defconfig             |   1 -
>  arch/powerpc/configs/linkstation_defconfig    |   1 -
>  arch/powerpc/configs/mvme5100_defconfig       |   1 -
>  arch/powerpc/configs/powernv_defconfig        |   1 -
>  arch/powerpc/configs/ppc64_defconfig          |   1 -
>  arch/powerpc/configs/ppc64e_defconfig         |   1 -
>  arch/powerpc/configs/ppc6xx_defconfig         |   1 -
>  arch/powerpc/configs/ps3_defconfig            |   1 -
>  arch/s390/configs/debug_defconfig             |   1 -
>  arch/s390/configs/defconfig                   |   1 -
>  arch/sh/configs/sh2007_defconfig              |   1 -
>  arch/sh/configs/titan_defconfig               |   1 -
>  arch/sh/configs/ul2_defconfig                 |   1 -
>  arch/sparc/configs/sparc32_defconfig          |   1 -
>  arch/sparc/configs/sparc64_defconfig          |   1 -
>  crypto/Kconfig                                |  12 --
>  crypto/Makefile                               |   1 -
>  crypto/michael_mic.c                          | 176 ------------------
>  crypto/tcrypt.c                               |   4 -
>  crypto/testmgr.c                              |   6 -
>  crypto/testmgr.h                              |  50 -----
>  drivers/net/wireless/ath/ath11k/Kconfig       |   1 -
>  drivers/net/wireless/ath/ath11k/dp.c          |   2 -
>  drivers/net/wireless/ath/ath11k/dp_rx.c       |  60 +-----
>  drivers/net/wireless/ath/ath11k/peer.h        |   1 -
>  drivers/net/wireless/ath/ath12k/Kconfig       |   1 -
>  drivers/net/wireless/ath/ath12k/dp.c          |   2 -
>  drivers/net/wireless/ath/ath12k/dp_peer.h     |   1 -
>  drivers/net/wireless/ath/ath12k/dp_rx.c       |  55 +-----
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 -
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |   7 +-
>  drivers/net/wireless/intel/ipw2x00/Kconfig    |   7 +-
>  .../intel/ipw2x00/libipw_crypto_tkip.c        | 120 +-----------
>  include/linux/ieee80211.h                     |   5 +
>  net/mac80211/michael.c                        |   5 +-
>  net/mac80211/michael.h                        |  22 ---
>  net/mac80211/wpa.c                            |   1 -
>  69 files changed, 32 insertions(+), 558 deletions(-)
>  delete mode 100644 crypto/michael_mic.c
>  delete mode 100644 net/mac80211/michael.h
> 
> 
> base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce

Note this series does not bisect cleanly since the introduction of the export
in 1/6 causes build failures:

../drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c:467:12: error: conflicting types for 'michael_mic'; have 'int(struct crypto_shash *, u8 *, u8 *, u8 *, size_t,  u8 *)' {aka 'int(struct crypto_shash *, unsigned char *, unsigned char *, unsigned char *, long unsigned int,  unsigned char *)'}
  467 | static int michael_mic(struct crypto_shash *tfm_michael, u8 *key, u8 *hdr,
      |            ^~~~~~~~~~~
In file included from ../drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c:25:
../include/linux/ieee80211.h:1926:6: note: previous declaration of 'michael_mic' with type 'void(const u8 *, struct ieee80211_hdr *, const u8 *, size_t,  u8 *)' {aka 'void(const unsigned char *, struct ieee80211_hdr *, const unsigned char *, long unsigned int,  unsigned char *)'}
 1926 | void michael_mic(const u8 *key, struct ieee80211_hdr *hdr,
      |      ^~~~~~~~~~~


