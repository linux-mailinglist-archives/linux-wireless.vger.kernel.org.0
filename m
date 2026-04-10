Return-Path: <linux-wireless+bounces-34562-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yICHEV9i2GkPcwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34562-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 04:37:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B63D175A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 04:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08EC4300A30D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 02:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F1261B92;
	Fri, 10 Apr 2026 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4RB1NEM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eFS1TA5I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6311A9F9B
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788635; cv=none; b=gWbAc5/qjllhoFljBRnsZBbduB8CgYDbTDuF7giJ9PF0k8ESidSG6HvHfuSBaO8lU7o44cgBO+sX1yjFa78MAwM7Srb4FNYLyvPI3vDpGRZhK9eCa3mWaPdSbxzepW6bo4COSqO9dnrZgJTrprlrP6YEyoFGTOmotMTyUkTLpM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788635; c=relaxed/simple;
	bh=7TPw6CjtJFj0araoC3FapNXIhOEe02Fr3vTVnuv+R94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2DsbX+Nm+9K7uZ7xeBmogbZ0rqQ6YCEy90szxcSEL2EnYGhfa8Am/XwIuPNBNs27xhDl0ejbX0Ychh9nJjqGATxSboUjb/dvkjLV2jMKJu8yWsQivou4ZpmMpRz0bXRSSGbsxfeIQVSrsyShLnf3J67C6gC9hqUdhNkItUu/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4RB1NEM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eFS1TA5I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639Ir21o2866165
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 02:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8LFRB1+qa/rVpB3l/gPOxAnBKDyxBu7U/jEIYuF4X4g=; b=K4RB1NEM3qIs43CE
	bJbTuiEtTzH4utVNQhvuZPQOuuJrGdpHzfGWGvhXr0gGCYseYMDaUGpCIRh24zd+
	tSNci5emHO7OUmyUAvYFpedWuW4WMSloMVccPu8qiheuy4Hby2rK4xYpvWAN55u9
	DQDb4y93ON0c7rNBRj/ur+dZXS/mG4Pc/aPvd58tfYHn1u0jMMks5pO3MOGQrkVX
	0PU26CcUBS3emO4Gra2F4qtJhZWxh4tCmucAyjSH5RcbCExnxfX4pVNZUjIZkRw7
	PfjegpBtH6WAipUZYPLIKqCrhz1mL+kPjzLavygBTtrTcgH5KEk4LE9c699g5XGR
	CcYXOA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decayjhm0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 02:37:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c44bf176so1818495a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 19:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775788632; x=1776393432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LFRB1+qa/rVpB3l/gPOxAnBKDyxBu7U/jEIYuF4X4g=;
        b=eFS1TA5IFqhDFumKg+mw1QL2N/q5+37KfkCxpF4CSePiIamsQP7UauYT+oMzwU26BN
         4aymJVXo5Tt6YQ/07gohOdf44mMAICxyrYlfDRACRIvmbWPX2Ya0xlmKffMKj3b3PIUT
         ds+YnDxESAj78qwmmZykW9eqvMowlArU2Y2RuBsuJu87BdrOgoH0XnuFHG5T8HmKKwvz
         2JPK4R5P9R+l3xWKOL1XuMBupUs887R76DIRzaZnqIbKyuDAwe6vkHKpgGTN4gTSw3ZK
         U/OnAz1oo3NVtGvja+T1m0Swn9ssznV4gwoQqZXjfdLamHHE45e4aQ+R6lm7zfAokeg7
         TwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775788632; x=1776393432;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LFRB1+qa/rVpB3l/gPOxAnBKDyxBu7U/jEIYuF4X4g=;
        b=A9hF0Z9WFBDEst8l0Pw7iZH0p3K1CvJfalc1HQ9K8ujepO27XjV9OLP3rvr6pG+oyp
         3JXBYeMtRDHLyOw9l2+0hR9yIvzsyMSMd4zhIezS1s1XTS2fBc+ily1fQvt/LG+IRhAO
         KVZ0GjRrBmLL9WZCBsMjvwvGPRqQ6z5/lhXgTeyH38909kxJ+40/fghLP2BLGnwuf41e
         a6q3mHUdqE0JbuXf54yL74kZzOEzW1/0Qn6HkSD5YPwaHz6Zjs5inv8WoWwob1yBv10e
         1ufGTuXJlM6dxhVNnudZjyxvPl3dds4P+zRH8L196qVSyL4seL/GKrWCgVH/SgxdJWMf
         tOBg==
X-Gm-Message-State: AOJu0Yx6JjGPxuCINgDogW2fWVI/8vw8mI0HY/3qlT6QZkspw3SL+9sc
	VI6EFJBxD5gRBFS9FdmiZIzPyEqC+bCwXaa6Eei0Sl/DpdjVSTnefvLnQtwgK6ttXnetDwmQ6y+
	p58Rg5CqZM0O1IJ8Ea1Dqu4uDqgvgXKsV/C/QAl9m1gdz5e5aeatAPHqkgO54K67xcutD2tXx5O
	B7bA==
X-Gm-Gg: AeBDietrMIu2DA4y6prwiG1U5HZywY9Jr3SMWsK9p1B/su+Nogs0ljyztiB0qKIrZ6v
	mC26C0Z9NiS6o8Vm+EEvstBlHSJ4ACFb253h204/IHrPPnmpr5UdzwZakol/bOPpSSiuCUlRq4H
	lwO3hqbmK5e2jfYoRo4jlO6ADebvEbzXb5Yn800rFtbMcBHl2EFsyi3UAMAjZ86823EmrRu9E04
	YBvbh12UyBS1/mHqo0/vgmBiredtzF2NrCD1/kWAVB3HZpsCMqCy5IJ5t5c4yzcf70o8gYcC7jH
	CrolOgnSmpGIs08U9gtPAHXEU48Kb82Wl4uGR01lI8prV8Y28DiyPqU2wL0Amrw0CDPO8aqlpAF
	WSxN24/C/sp5GVRE26LIFkTthJ3m7/eGvmsuYowfHFkzrD3dPGaYaSMwFfYD71SzaYj7v+QGFr0
	pM8FOFZpQU5YRbFAZlDOg=
X-Received: by 2002:a17:90b:350b:b0:35d:a2d3:5c44 with SMTP id 98e67ed59e1d1-35e428581f9mr1352693a91.28.1775788632409;
        Thu, 09 Apr 2026 19:37:12 -0700 (PDT)
X-Received: by 2002:a17:90b:350b:b0:35d:a2d3:5c44 with SMTP id 98e67ed59e1d1-35e428581f9mr1352672a91.28.1775788631925;
        Thu, 09 Apr 2026 19:37:11 -0700 (PDT)
Received: from [10.133.33.204] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e42e0abaesm292036a91.3.2026.04.09.19.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 19:37:11 -0700 (PDT)
Message-ID: <5562f00b-8d84-4b7d-8a2a-95f805a44025@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 10:37:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/5] wifi: ath12k: thermal throttling and cooling
 device support
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=69d86259 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ZeLpQyFM_iFLYNy5nMIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDAyMiBTYWx0ZWRfXyF7WFO9mRgtP
 jgxi1gHZgtQymCqiuW6tG6Dl4iJa6XUNBkUpPbwMHRHQfFiAsBExDFdim3fZFcFaf0Iz9K24f85
 7ec7o81fKyewAeZSIm8gtracFUyOWTjLM5Kf08jAItuiHjxXkd85ZdOV/sav0yNut107M9Rd6Mf
 3rQqpS8HJUuNBrPzX9u0lf1bMHM6aHrEFvdmGOFT1SGiGni7SHi8VoZXEAaDzWj7XmyZLsydk8Z
 T8OZp2i9/NdBMKFO4Jiq49PLd7Cfjm23BSn/wRfRAhjjNBpnQmXRg4LPUMQ39sz5KeKIWCRKB6H
 AhezsmimFLScJ2DS6AcXkMAYLf2m4n6Ylj20x4O28S58d5hIPRcSLDaYLUxnNAtpqbMY8Luqnj6
 aFUBELcdVyzW0al4wbyovgBeHYmoO1JnTSVEZboZ5501EFEVG/UZdLaJk9+87OZiFQCkFa6TZPi
 1ZOWuvbfchFdk/Fuitg==
X-Proofpoint-GUID: wu9iNOfOhZOEc5xn7iJDpJ0M4P2anxok
X-Proofpoint-ORIG-GUID: wu9iNOfOhZOEc5xn7iJDpJ0M4P2anxok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100022
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
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34562-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DE1B63D175A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/2026 10:24 PM, Maharaja Kennadyrajan wrote:
> Patch 1 handles the firmware stats event so we can track the current
> temperature and throttle level per pdev without spamming logs.
> 
> Patch 2 enables thermal throttling at bring-up and programs default level
> tables to firmware via WMI_THERM_THROT_SET_CONF_CMDID; the driver picks
> IPA/XFEM defaults based on the firmware WMI service bitmap, supports 4 or 5
> levels as advertised, and only fills optional fields (pout reduction,
> tx chain mask) when the corresponding WMI service bits are present.
> 
> Patch 3 refactors per-radio thermal hwmon cleanup to reduce code duplication and
> ensure consistent cleanup across thermal register and unregister paths.
> 
> Patch 4 reorders the group teardown logic symmetric for safe thermal sysfs cleanup.
> 
> Patch 5 exposes a thermal cooling device per radio so the kernel thermal
> framework or userspace can set the TX duty-cycle off percentage; writes
> are validated against the throttling state range and host state is kept in
> sync with successful firmware updates.
> 
> Examples:
> echo 40 > /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/cur_stat
> cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/cur_state
> cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/max_state
> 
> Maharaja Kennadyrajan (5):
>   wifi: ath12k: handle thermal throttle stats WMI event
>   wifi: ath12k: configure firmware thermal throttling via WMI
>   wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
>   wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
>   wifi: ath12k: add thermal cooling device support
> 
>  drivers/net/wireless/ath/ath12k/core.c    |  50 +++--
>  drivers/net/wireless/ath/ath12k/mac.c     |   9 +
>  drivers/net/wireless/ath/ath12k/thermal.c | 252 ++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/thermal.h |  35 +++
>  drivers/net/wireless/ath/ath12k/wmi.c     | 107 +++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h     |  50 +++++
>  6 files changed, 446 insertions(+), 57 deletions(-)
> 
> 
> base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


