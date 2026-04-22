Return-Path: <linux-wireless+bounces-35216-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMhqEt3I6GklQQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35216-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 15:10:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF16F446864
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 15:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3677E302BDEA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9F13264F1;
	Wed, 22 Apr 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="msGHaOm7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TyaQIF7E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB393D1CC6
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863186; cv=none; b=dnSM5hHebfiLweGUhQdL1ML22Un8rb8zpWy2EXAWqsNGHwQPKmmudweYL7m68zAXkiG/L+TQsU5/ogQ/X/fiB4zT7awf9u7urjJeJwq3UjTE53Y/IxV1UQ3uLqVoprq+mLynIAMwhZm/BIwgK5GcsQCyri07dbDPQyuL6eUnoVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863186; c=relaxed/simple;
	bh=QtEsGA/HzLma92O24IsY9KnccKqQZr4KoQf85Grxfbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7G3otB2Q+NSd8jR4lwSUlova771oql4LvXX04WpeUYnRdtA1gBJbL4uw3Sa7ZifDFo4aV+P+0i/uvR8GEpUiJsgPeik/g5ajH/ov0yNmIIgBfKhnudvHx3zobKJvW0HPuTvoT8ruj0MmLQ0xkoO0QKpYXnAC9CKxzaog8oIte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=msGHaOm7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TyaQIF7E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M99DpE647345
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 13:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mC1j34T7H8QnV+yrQN6L/rJyl0oDqhmpMij72LcTN0Y=; b=msGHaOm7bN+xIxnL
	NBsQjZmlXu/BWDCh+Jji3z8FcbvgwJxrfYrq8G0CI3mJaFiKkB4qhuKaTbcQGLDp
	xqP0LwOfQS/eDQyBsDQUsMTu2786vQQsgCiECDMHV/a7AykCWXhDUpXF7I+qx2IK
	Hvg8WQ+XKOzh6HoY+YxmyJmxLB2v5hdH1vbga668JJ37Nu1odlUsxAlfrPla3HBj
	JFJvrJIryxt99PRSsd+iQGtPO/3/LOJks0X/5VtL4FhJDH/vaCy8gZ1ZZCWcxUtx
	rN2OG+yzjLBCXspw8WHigd8iX00rSgNSjC99xE/MFI7TiGxp4q/Izc1oX6v0Vj2E
	ybU/5w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenkbdcn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 13:06:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f71437218so3472006b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776863183; x=1777467983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mC1j34T7H8QnV+yrQN6L/rJyl0oDqhmpMij72LcTN0Y=;
        b=TyaQIF7EphISwtTbxOvFthfxO7DIay97l2v+kQ2q9K+hROL/XIKb8rhaVyOSuS0T0q
         9E0laTi2J5k50JAfONnGBBvt25le8sc3/FvLMzOwRQ2drpCBuFNB4+pgFi2OsDoIPT6U
         QqKQj5od+EZ1QlfZj+9QvoCeDD7jyn6b9W34ivI/xObswH1FvmMUi0uCtYX6nSYCWKrz
         /W5xoxiQ63IrYF8bl5DCxosxLFa2QBpfGZktmcOLVFan5YAW5kOK7pJVjZgZIdxcFoxl
         v9fl0l+/OmS3z7xa0k6mxF4KC3He/x+O6epJjr8dCw3OHJbXjdqe7gO11zytBuBc2tBy
         VCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863183; x=1777467983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mC1j34T7H8QnV+yrQN6L/rJyl0oDqhmpMij72LcTN0Y=;
        b=hFRTNRtJ7idtwrsl7ZW76VNHAO2OOfFbBoQPHDTvg2j1KahwGqDoaP9913oFKOyH9A
         v/2qyRI5C3emtMFSu3wLFC+w8DGTDhQY/kiAapAsv1XIgpla3wDidCJIMs0NW4l7SYq0
         KrEmVLU0GH5T94ASQWVyEklaYnoJaBtVNzZx26vjc7kuz3nheAhEWMVIk4bBK7ObtSDn
         0gj8AhEKumWjNHnvGIAl3yJiEeaHJRt3i9nHuGeXM5Rht6AkoCP/BZ+8ZPSbGOi3ltAh
         UNu/+BLcqKHRVvuwXTQGM0FCL+oWtHOssFd/n5d3rBFENy2x2f/Kjt4EX4JeRhCSXabK
         mgIw==
X-Gm-Message-State: AOJu0YzH6pn3ps8jPdB0toX1duQaxSRxZm+7y3ucQVl/i1A1b9S0rcjU
	8BlBftcnNL+J15LQ4hX4m2sFd5n60chJD0toYkDHcUztFZw/ovUz2t2ziunRIZ/gi3tm6yzdwc9
	jwqAHSRMKrnYlEkDc6aUXMM3kscAe333Hb6bfEC7tcsiAAWhoibjw0ujC2P36My0XSnvOB62R8E
	IUxRuR
X-Gm-Gg: AeBDievCpEXcHFfrtzRCOkrfbo5yXyqEy1SB/yIKMvbxN/f4CdEztRdKstFxc9TePqF
	FsKcSE6+yvK5aQU3M+uOHokYJ3NP9B6iLUNK+8SPUU4IWUwTsYommi4UutDafn/6JV3VtBXDOEn
	9UJo81OVdwDmNwMPHucO5i30run3p6dcJLAziYRybm+ZQPDs72t09J9Q/eigS/mVyGeaZ8/DT3m
	ML205Od9/m5gNsB6a2/Q6vt8EY6FmQCtr8qyBnt4EjR8q4qzj8bvXvGQZeFzNkDpsj3LOZaNwB+
	ayn8iAt70vYIute8u17HYj0Dp8uXEBqov7oFX4+I6yDlaxFqM/Aaxsadnd3t9sFTcv8vHsr2bD+
	YIxmy5/35kqNBKtalbJErc4qqsIwsVJHzbvhpHoRkT9EJJ0uNl7LafiVkLcwVGk45NKt00+zjNV
	L6
X-Received: by 2002:a05:6a00:2288:b0:82c:e76b:c68c with SMTP id d2e1a72fcca58-82f8c3f2b00mr22912341b3a.0.1776863182964;
        Wed, 22 Apr 2026 06:06:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:2288:b0:82c:e76b:c68c with SMTP id d2e1a72fcca58-82f8c3f2b00mr22912289b3a.0.1776863182301;
        Wed, 22 Apr 2026 06:06:22 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb33fcsm16417095b3a.33.2026.04.22.06.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:06:21 -0700 (PDT)
Message-ID: <3e83cdf3-4aa4-44ba-a0d1-c54600552186@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 18:36:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 0/5] wifi: ath12k: thermal throttling and
 cooling device support
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NVscdllkeCAUZ3a_tIBVYqxh_s9bMTzl
X-Authority-Analysis: v=2.4 cv=SONykuvH c=1 sm=1 tr=0 ts=69e8c7d0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=H-Wgj3y7uwXhWPCsC4wA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: NVscdllkeCAUZ3a_tIBVYqxh_s9bMTzl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyNiBTYWx0ZWRfXzocuIvePzuvN
 EyzhuAVBZD7dWgQy8wVdZVuDTmFGU0HTKGGdlze1CDqQJegQSpZapkn1qZsfTREpWpYIneW8UZQ
 Gd1Xwq933K27w+VUA1j6j0BXHV5TOV0GqrU8cBvKEo+Cd3FSCFlmlxvnma1RrTwT6YNTmBzXZ80
 eS0ov4lb6605xQIaTM2QszHbCJDvxXLE0vnH38SZSG8JCv7fpE1hKDagZUtrmz514s7m6mdn2KH
 C0l965dmdRY8QJbmy/2m4mWrPraOUVYXGIn0q6tFQGuCx2Ces23cFeqMv1Wmvuw3sFU61tvYKx8
 jLBQN66hkdJBlX6Mn0/W+6B+RKcEpXN6PIxkXNL7kpCjdjAQrQx69bNT9y77FiyQqQ6n7YxlMs4
 tkpf7lspZ1nlFqkjORQPXH9LODR/x1Hwyg7Th/E2ah/YxlA4kLlE3RmysaNp5WAVRCQZCqz/1KP
 FvJR6P9C9WBXZt1Uz3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220126
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35216-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AF16F446864
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/2026 9:08 PM, Maharaja Kennadyrajan wrote:
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
> v2: Addressed Jeff's comment by rebased on latest TOT with wmi tb - alloc and free
>      interface change.
> 
> Maharaja Kennadyrajan (5):
>    wifi: ath12k: handle thermal throttle stats WMI event
>    wifi: ath12k: configure firmware thermal throttling via WMI
>    wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
>    wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
>    wifi: ath12k: add thermal cooling device support
> 
>   drivers/net/wireless/ath/ath12k/core.c    |  50 +++--
>   drivers/net/wireless/ath/ath12k/mac.c     |   9 +
>   drivers/net/wireless/ath/ath12k/thermal.c | 252 ++++++++++++++++++----
>   drivers/net/wireless/ath/ath12k/thermal.h |  35 +++
>   drivers/net/wireless/ath/ath12k/wmi.c     | 108 ++++++++++
>   drivers/net/wireless/ath/ath12k/wmi.h     |  50 +++++
>   6 files changed, 447 insertions(+), 57 deletions(-)
> 
> 
> base-commit: 9a4f673eb08d2a7713b258d671b4a45f2a6e68b7

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

