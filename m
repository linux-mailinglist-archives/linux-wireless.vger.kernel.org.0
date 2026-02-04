Return-Path: <linux-wireless+bounces-31511-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XX3QDwG0gmnwYgMAu9opvQ
	(envelope-from <linux-wireless+bounces-31511-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 03:50:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FBCE0FDC
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 03:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71E04309FB7C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D191684BE;
	Wed,  4 Feb 2026 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hGAytLqU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NQB9t99s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AED7082D
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173438; cv=none; b=Oo94GaXRi8JrH9XIeIW0k0+nwaCLS+Lm+Vni2YjqD/1rJYWOWm4CuJXBqaPcWhQeBfaXJZol++A3OHm3hOpOglD9+t70PuoMclUEYVxhu2LNh6M9RXUxaTqXz2HkvBh9Ef596ggs4ZscvewgnbWlUnMkl7azfWzCF4Pt54+zUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173438; c=relaxed/simple;
	bh=ZsOZ2u89tCcc5P7DxHNH69kBNbhbNtyViwH8i9PPuFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFp5TkydXGwsqaZ7V7Z/mh1Nykm5O1oVIQeZGuEzrXG8u7q81a8r2bWTulYb0MnWzO8HY8hs6iHgK2z8B3jIK3AkWLMe/olqgByUTjH/f/Qek6eN23TB6BXJk/C45dPrxBzpb3JvmrxgIRqCavYtxLQLmgdwaUbNhA2yGYI3bK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hGAytLqU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NQB9t99s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613Ilg8g2962734
	for <linux-wireless@vger.kernel.org>; Wed, 4 Feb 2026 02:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tr+t5bMF3u7DM/Ka94SAerU8RPbxh/i/CHucN58wf04=; b=hGAytLqU79jfEJ0h
	KV3Ioqy+Zoui38t0DXUK04gRk+fUJoH+a0wnedq78tjKF+cpg28Owz3W/1c0w8f9
	4DOP2UlPZ5GqFgOJTdumJRGDVp+TrKftCmGDTId/8JVjepspSMqxdGxfrEGQqzvv
	34Q52M/meDtbn0nLZamiv0y2QeFMez/MgdHiV4nXi820hOvSS28NXXMtqgVFE7VE
	pCuYE+1qFnhcKgIeSCzFnVShN6YvT8pIaZrs57Qe1DUuzcQW4cfdxOvBMM4fD+us
	iz7ZQy/I0YZGVeLcuL2M6HKKmK+c4BnaMLT8fk/LshP4hmQ5SioEJobId9irM372
	Z5n90g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ne7sn7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 02:50:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f1f69eec6so70263085ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 18:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770173435; x=1770778235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tr+t5bMF3u7DM/Ka94SAerU8RPbxh/i/CHucN58wf04=;
        b=NQB9t99sSwSyWLh5qkcm9ckwZLBmPsqukFC4vq1g4BSEja4zMGk7XWgwgAutpA+SRB
         H21FU1k3Id9u3edQUQnnvYB+nuvC/I2n5ThbilLwDI1utne6T/PdOHOmvFqi35w1O+M7
         I9fLQOUQSx7maVIitO8yf9CHWnP31It+0qI4omMk7LA6vs72l0f64C3ISKGNIdzfMpdg
         Sv2wX573McfAEIA3DR301Rjoi1KhbLYcFF4FYnlElhjsV+l7WAZ/ebSULS7H4RMjpjtN
         oo9t4pSJM9OXvMmubd32kUPkPvEo57W5SDxosxGzTCHs9+ls2C3w6gCmz4wY2+00EKZ6
         Mb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770173435; x=1770778235;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tr+t5bMF3u7DM/Ka94SAerU8RPbxh/i/CHucN58wf04=;
        b=GsFgraU1EtwY7P3LOifqa3C87I6RZOLQ01IDZXQ7B2IPr+ArXGRtEIvAEC7z6xsE09
         84MtlXSOyHczxjk0FGO+bayF5sejZAn4TG/Kp5GCEvl5BPoo9oa3l9XO4n9N9DPWCotQ
         IUuMbazYpQzSlVj4pv8AOt4AyVqO8hlox4VMfck4Rr0awueWOFxui/dqkZ3aPgHJSFER
         HcvlF831AiUXHSECJatd0no46MOz7NutM7hec91k/+Yuhq09ecNAA6hutL07pLpqgbhM
         Ep7EJF4ji65AdsM2q+ggx4reb8IWeei/IVHkx5I3XqrjEEBOAKHqnxk9ri6UFIf6iHJy
         PfiQ==
X-Gm-Message-State: AOJu0Yyr1LWny6z7uZ2/xoCVlBj/+E/oprhqiDHmxgbP/CCql8vuRbgA
	Hme8T7Utb3+VqWnBz+iXJ50f44PstrN8WwalFcqEVuQhO4IQZgEmdTbmxm1g4X7pTal8mTV5z6T
	hd1/bOuPYGk9VVHoTDyBNZ3ltuOtfyIECbVxqUyvf8e+Ff6BPWLT1WhA/9nRzbZbG8DrM6EjMfn
	uPog==
X-Gm-Gg: AZuq6aJ8/3SIOYvAIDRAadroVpMMdve1gK9vUDVCtyYjPRLM8FTrOep7Lq2KnFTm4B3
	WkV2VeaMdJwOpAKfNDzioFr5nDQapeer+Oia8utnrX15JNFax8KlBaU9WCgzJfWzyTeuhPZ82ID
	oDuRtVgnKeHdFYQSAz9fGCs0IpCvJ7t8e3YVdNGwn7hY20RLZmpHr96eNPdCdrzh/Iy1yLgqwdq
	wZnp2M1v1fFnQ9HN7B2e0Rus2oflRbvfJ5CzHf1j6TVw6h14kRf4pKsGrS84cE23WrVrRdvqyoN
	LpW/cojoc7i3Yn9X67C5HkcqRdM5Qc9slbgRrPW1Rq43Cozrypnm1iVAQwO7RTTOS/INmF2N7tG
	4SvQQeIXzv3WNTftJwkm0Tteo2FIK4Ijy2CbxoEAbBKscsirArjSDEVgwsJ6BO/rE9Rede+mJgP
	OthXXm7Q==
X-Received: by 2002:a17:902:ebc4:b0:2a0:be7b:1c50 with SMTP id d9443c01a7336-2a933bb19eamr16540755ad.14.1770173435417;
        Tue, 03 Feb 2026 18:50:35 -0800 (PST)
X-Received: by 2002:a17:902:ebc4:b0:2a0:be7b:1c50 with SMTP id d9443c01a7336-2a933bb19eamr16540555ad.14.1770173434727;
        Tue, 03 Feb 2026 18:50:34 -0800 (PST)
Received: from [10.133.33.43] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338510c9sm7989535ad.12.2026.02.03.18.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 18:50:34 -0800 (PST)
Message-ID: <ca73a571-5ea1-4149-b9d6-8ad0875454eb@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 10:50:31 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential firmware selection issue with QCNFA765 on ThinkPad P14s
 Gen 5
To: Mohamed Sallam <sallamx99@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <CALOnm7APGpVWcx45O78fa4hOCUGDc0-ywGoqicr51YtpxNueLg@mail.gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CALOnm7APGpVWcx45O78fa4hOCUGDc0-ywGoqicr51YtpxNueLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BgjN72yAE9OaOSrJRbogcUtBveO4J8A-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAxOCBTYWx0ZWRfXyt+oLBXIaCbA
 8MJFBHW7n3VlBS+1w41QcFq0vWTiRo5RvT9LEHF/9WY3zHlqypbA15A9V9ajvXyDmin4N6afv7o
 uqm758Fo5H/vNfdXnhz/rGYrcuMJWJ7fkT1OYapNUDCla0DRltXWWcvva3NzStFQNl/gqDFBcET
 z3LLmACADpmKrGQ5LKXyajrto8Jo9rPmQeqJoLMtxn2jqTBYMNphECdMJ+QwBmccvVh0bu7ID0b
 z0v9b/o2/KVG5hyeNPAKt6TiU2AJ54x/AtoJFwyhH0V652JXDdXHMWldIHPaSNmFnqjhpnhIaxF
 0fK6DDmQnVjGmRvxTvhiUve5wLePLy3UStt6p2H1T/H9WObIRjwTWedKwo7omyeni5q4jTt4K5m
 X0k32UjbuoiJ0MA0k+OAsV40Y0Wj406O7aMGoExHLT8FFYF+2R//3VP9l7f/U1SieP8C1CpH/So
 JZoMy7mmAthwmJUQ2MQ==
X-Authority-Analysis: v=2.4 cv=TZmbdBQh c=1 sm=1 tr=0 ts=6982b3fc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YCX_753iAahT_6zR1PwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: BgjN72yAE9OaOSrJRbogcUtBveO4J8A-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040018
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31511-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A6FBCE0FDC
X-Rspamd-Action: no action



On 2/4/2026 2:54 AM, Mohamed Sallam wrote:
> Hi ath11k maintainers,
> 
> I'm not very experienced with Linux - I'm an end user who noticed something
> strange with my WiFi and wanted to share my findings in case it helps others.
> 
> Full disclosure: I used AI tools to help me investigate this issue and
> understand the driver behavior. If I'm misunderstanding something fundamental,
> please let me know.
> 
> WHAT I OBSERVED
> ===============
> I have a Lenovo ThinkPad P14s Gen 5 AMD with a Qualcomm QCNFA765 WiFi card
> (PCI ID 17cb:1103, subsystem 17aa:9309). I'm running Arch Linux with kernel
> 6.12.68-1-lts and firmware package linux-firmware-atheros 20260110-1.
> 
> I noticed that channels 149-165 in the 5 GHz band are marked with (no IR),
> preventing me from using them. This happens consistently on my system.
> 
> WHAT I FOUND
> ============
> While trying to understand why this happens, I discovered that the
> linux-firmware package contains two different firmware files:
> - Generic: ath11k/WCN6855/hw2.0/amss.bin
> - Card-specific: ath11k/WCN6855/hw2.0/nfa765/amss.bin
> 
> When I manually create a symlink to use the nfa765 variant instead of the
> default, the (no IR) restrictions disappear and all channels work normally.
> This suggests the driver might not be selecting the optimal firmware for
> this specific card variant.
> 
> The AI analysis suggested that:
> - The driver looks for firmware at ath11k/<chip>/<hw_rev>/<filename>
> - There's a "firmware-name" property that can override this, but it seems
> to only work on ARM platforms with device trees, not x86 laptops
> - The PCI subsystem ID (17aa:9309) might be available to the driver but
> isn't being used to pick different firmware files
> 
> I don't know if this is accurate - it's just what the AI told me based on
> looking at the driver code. The key point is that the firmware swap fixes
> the issue for me.
> 
> REPRODUCTION STEPS
> ==================
> On my system, with the default setup:
> 1. Check channel flags: iw phy | grep -E "5745|5765|5785|5805|5825"
> 2. Channels 149-165 show (no IR)
> 
> After applying the workaround (symlink nfa765 firmware):
> 1. Same check shows channels without (no IR) restrictions
> 2. WiFi works on all channels
> 
> TECHNICAL DETAILS
> =================
> Hardware: Lenovo ThinkPad P14s Gen 5 AMD (21ME001MUS)
> WiFi: Qualcomm QCNFA765 (WCN6855 hw2.1)
> PCI: 17cb:1103, subsystem 17aa:9309 (Lenovo)
> Kernel: 6.12.68-1-lts
> Firmware: linux-firmware-atheros 20260110-1
> Firmware ver: WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Logs from my system:
> $ dmesg | grep ath11k
> [    2.845632] ath11k_pci 0000:02:00.0: chip_id 0x0 chip_family 0x0
> board_id 0xff
> [    2.845778] ath11k_pci 0000:02:00.0: fw_version 0x1019B0E1
> fw_build_timestamp 2024-12-19
> [    2.845789] ath11k_pci 0000:02:00.0: fw_build_id
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> [    2.845806] ath11k_pci 0000:02:00.0: qmi failed to load bdf
> [    2.845809] ath11k_pci 0000:02:00.0: qmi failed to load cal data,
> fallback to 0xff
> 
> $ lspci -vnns 02:00.0
> 02:00.0 0280: 17cb:1103 (rev 01)
>     Subsystem: 17aa:9309
>     Kernel driver in use: ath11k_pci
> 
> With default firmware:
> $ iw phy | grep -E "5745|5765|5785|5805|5825"
> * 5745.0 MHz [149] (14.0 dBm) (no IR)
> * 5765.0 MHz [153] (14.0 dBm) (no IR)
> * 5785.0 MHz [157] (14.0 dBm) (no IR)
> * 5805.0 MHz [161] (14.0 dBm) (no IR)
> * 5825.0 MHz [165] (14.0 dBm) (no IR)
> 
> With nfa765 firmware symlinked:
> * 5745.0 MHz [149] (23.0 dBm)
> * 5765.0 MHz [153] (23.0 dBm)
> * 5785.0 MHz [157] (23.0 dBm)
> * 5805.0 MHz [161] (23.0 dBm)
> * 5825.0 MHz [165] (23.0 dBm)
> 
> MY WORKAROUND
> =============
> I'm currently using this workaround:
>   sudo ln -sf ../hw2.0/nfa765/amss.bin.zst \
>       /lib/firmware/ath11k/WCN6855/hw2.1/amss.bin.zst
> 
> This fixes the issue for me, but I understand it's a hack, not a proper
> solution.
> 
> QUESTIONS
> =========
> 1. Is the driver supposed to automatically select card-specific firmware
>    based on PCI subsystem ID, or is this working as designed?
> 2. If it's supposed to work this way, could there be a bug in the firmware
>    path selection logic?
> 3. Is there a better workaround than manually symlinking firmware files?
> 
> Thank you for your time and for maintaining this driver. I appreciate
> any guidance you can provide, even if it's just to tell me this is
> expected behavior and I'm misunderstanding something.
> 

Thanks for reporting. This seems like a known issue and I have notified the dev team to
look into this. Likely we need to upload a new firmware to fix this, but I am not totally
sure now.

> Best regards,
> Mohamed Sallam
> 


