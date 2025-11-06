Return-Path: <linux-wireless+bounces-28662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D471DC39A58
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 09:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC5CA4E8B0E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3841D2FB616;
	Thu,  6 Nov 2025 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4jEMhK0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aFiqkJ36"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AE4305044
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419039; cv=none; b=CJUGGznfmLIcgvyQNxUnyAgMIPY0Cocett2d2AQw0GyT2rKWNqEA5fFE7aL+nXYm9QYv5GzwxeNWw1K6MCfpWnzT20unsJ9viHHFpni4dnTQC5wdwKvmHXOi2OYCCpHwoNAGaC+NBk9q9yaKaS5dLop3DmqjyEW5m3u3bGfSsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419039; c=relaxed/simple;
	bh=WVvDeGr64D4pcQGgTdXKzhsbEzPiYrr/sAxjT7B5tN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnwuEBnQhYMc8bUTP9pxsqTDQ400v6BwVtzYlm3Nd5jpYMTAon9RmI7Vx+/P7NO4DCSPOhrSWjG8M/utyILDedP9t8f7nYT1EtjpmNKO6MQQsoymZQoWV7MSTUAVuPEphNlX9+G0QB/EYtksQD/E3Nd3bRkSYuwuW3ZLQ8/srLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4jEMhK0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aFiqkJ36; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68kKQ62326595
	for <linux-wireless@vger.kernel.org>; Thu, 6 Nov 2025 08:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jzv1yTzt2RufxPXCysYd/nddVUqtY3l4eZc0BE4yJU0=; b=K4jEMhK0ebWBshQy
	pZBFpZDAIk/RKKd33BpRIi6ZgkStwJMuCJtG7GnCss++wpf/ac6bEIu88OVWZdTI
	3IhgyrjFU288bKdeE7S/wE9FyZR8xAEBGCJ6hdXTsyT0DSxC1XOvQGpjOACAcezs
	+EE0o1jQj8u47jlgPERUqaGnoEn8jCuj27tXytJCg0yWx7oFRE1tBpN+xoK9/S9G
	W5wbtReFqiuaqRjiDQU6Q//Dpu5WvEJih3CGa8FXSB+j83gwTgZ2ed4DRRxccCaS
	ikZjxKM//XV4tNqHpXh9dIGKu5fW38LSydKIOCAwqFZVFlYdaW12S47zd1GKIJFs
	aoBLtA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h0v18yk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Nov 2025 08:50:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so700541a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 06 Nov 2025 00:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762419035; x=1763023835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzv1yTzt2RufxPXCysYd/nddVUqtY3l4eZc0BE4yJU0=;
        b=aFiqkJ36N+7pY/aLdfLsuZcO942DgAljNMvdt9SawAFinvlSJrY10TV/g1PdMT5Su4
         I8oY0feNEc17H+y90mGlxidWF72jw3ubyrn662FEBiTivtL9xfZcFWue4XGOdmJKlheD
         FGV6UZZM7zdRc2ZvwrrfIUwcu545avAJjgCn/cos5t0dmkdEIS3bi3+cAututWzd83Vl
         D2r27CPjwie8iFaEEhNvYeh2yhU02gd47EpKF/Uoqg6W9HzHRDg9+YHo9awcnoNBAfiF
         a/0keWWdL6ai1UubFJCM90wlUkdahFzMH2xFYZvpF1+i/jKzqtPCnBy9WMWyvsIWyT9C
         wfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419035; x=1763023835;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzv1yTzt2RufxPXCysYd/nddVUqtY3l4eZc0BE4yJU0=;
        b=ZG1ejrnZxY1pbJV0B+C0DHbL8MImmy4KgbG802exAnaHPk/gq3M2A5Nv5Pq2Gl39gv
         77G3WfPRUj24SfyfRT1SlOIlMkGhy90x+RpWKwaLHvY6gPXPxiDtHWwBV3E0LHc187Mc
         Ez+sqVnqFOSgK6ktPjatcVyQVKiE03HLKahsm+927B+nXjQbrf3H/qCIfmkIgZcmDYho
         DiJe91GAGQpBoFg2MqvmhBQbA7bXOTzOq3OXdr9s++fUppsyboPmbVfBsE45rR4ZtMUy
         qWAfjnep3b7tEfjZWMgM/1G1n1Wuy+7tybSvJdQAmEG0sXwJhg+8WMnVPyf0U3XC+9DP
         wFyw==
X-Forwarded-Encrypted: i=1; AJvYcCXcUZABGM603fMOFdWQ3I/ojFaE1+Ndk4HIxF9L632Nj34/rCqakSpmxTSRtYLQ+KHWlcqgegVj+oI8L5XNqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/wy5ijUMw3m2nhA6SXzqV6jHNyItyxD8VSPyD3KhkBxmJdJe1
	SSPcDqHKodP7A0Z6BFVhcI0hpV4GjNc9Xl8VTZomZ6q8UzhC1PFBD32M+ZfNzwpoOzWQouYq5jy
	AOWuOYSmGX1mGSl/qomeLFwiNJ18CuD9Bq7eczcKtJ+T0jp0Gb52ASi9WRTzF8HcB7jA0sg==
X-Gm-Gg: ASbGncsi2aykn9DMdbN3U3mcBcGwtPy347DOfu3KrR9wVST2ahi2TjbZeY8AuUYwZwv
	zdTM72M7sufr+O86KGpOKeGzXJ5uldY9Enr2gIFs4lt9g/OydHcOVI7jvMS8e85mPHE22jYnkSL
	k2CennjC7n2BKHxHJlJWMlNLZECNWnYEbJXMSYHok9iyZtDHDdktQyR0vP4JyG0k17pg0KGizss
	qTELTTQGH+ZQhI1avOYvtJ6kU4dr1qcgIQ0VY9uUSklYGgMCe0ymZL67cAKXYybEvTC69bGlpjU
	tCnwJ2gcE4oH9I4QVDoCcIk1dfHD8nbSEDSC/8sJZ11vcFQ1am5UVyz2RSCUm9hpL3QbakpULA3
	l66+a0qaHvaUl/cAm1HVZj+mT2+b5/5P24Pu6Hyup+Cw0DCmWNMA0DhFUQmyGDcx5HvC2f4N8
X-Received: by 2002:a05:6a20:2589:b0:340:c6cd:545b with SMTP id adf61e73a8af0-34f8601d2dbmr8310900637.44.1762419035261;
        Thu, 06 Nov 2025 00:50:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9WA8Q9OBOvy+W03mWMWpuJqtsAQ6hbgML/ovXeLVnmjdSHkr68hNbqJUMCMAf7GNeaTowtg==
X-Received: by 2002:a05:6a20:2589:b0:340:c6cd:545b with SMTP id adf61e73a8af0-34f8601d2dbmr8310866637.44.1762419034647;
        Thu, 06 Nov 2025 00:50:34 -0800 (PST)
Received: from [10.133.33.172] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ed21desm1841412a12.11.2025.11.06.00.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 00:50:34 -0800 (PST)
Message-ID: <2cc29c2e-a066-4c49-99dd-872cc2f5f326@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 16:50:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3 0/6] wifi: ath11k: Add single shot/periodic
 CFR capture support
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251105172226.3182968-1-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251105172226.3182968-1-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bVbsZKAyERioKoc96b47Bkr5k2cAzNJh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3MCBTYWx0ZWRfX+MaV0Z4b8Zt+
 042atYSV7IBtUtT/Gq2PrHY8g45HFA+fzGnSyNcnjQbce9epxcpeF3H8ZDdNi93AYgy/HaAwKzQ
 rvmKk5YswvLO/AoFhBndVloVy7999sy3tLDpAhfoj5y2V1lMFFalaVdrEttKWiQmCDWCv0o1Tqt
 l6vXj28WewxgGx5gPDQ2yM/QMNbwUG8Z77hS0mnA8A86wOWS8bSBs0n1HncFnOzu8M+UtJTH8s5
 vmFoi6l0ay4LkV2YW9sfPS5PhnVRtrbAUKkVfSk+fpPvNo+HpcAknPPhP4XHxm0bsqPrv0RoQUW
 COtKggSV91KsUoXdjbh4A/IYVswB+0vL6HyzPhOUTS1Xj5gmoHvQrE7HtxVw9lIzNjTVVXk1kAW
 scpy2zCqvvwqUjbbomlacamdSZWSJg==
X-Proofpoint-GUID: bVbsZKAyERioKoc96b47Bkr5k2cAzNJh
X-Authority-Analysis: v=2.4 cv=PoyergM3 c=1 sm=1 tr=0 ts=690c615c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=W4cqpq0YkI6qXs7jkP8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060070



On 11/6/2025 1:22 AM, Yu Zhang(Yuriy) wrote:
> To enable/disable cfr feature use command,
> 
> echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr
> 
> where, val: 0 to disable CFR and 1 to enable CFR.
> 
> To enable CFR capture for associated peers,
> 
> echo "<val> <bw> <periodicity> <method>"
>  >
> /sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture
> 
> val: 0 - stop CFR capture
>      1 - start CFR capture
> bw: CFR capture bandwidth
>      0 - 20MHZ
>      1 - 40MHZ
>      2 - 80MHZ
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>      0 - single shot capture.
>      non zero - for Periodic captures (value should be multiple of 10
> ms)
> method: Method used by hardware to collect the CFR dump.
>      0 - from the ACKs of QOS NULL packets.
> 
> To enable CFR capture for unassociated clients,
> 
> echo “<mac address> <val> <periodicity>”
>  > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc
> 
> Mac address: mac address of the client.
> Val: 0 - start CFR capture
>      1 – stop CFR capture
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>      0 - single shot capture.
>      non zero - for Periodic captures (value should be multiple of 10
> ms)
> 
> To collect the cfr dump,
> cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin
> 
> Previous link:
> https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/
> 
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> 
> ---
> Changes in v3:
>  - Update related comments. 
> Changes in v2:
>  - Update related comments. 
> ---
> 
> Venkateswara Naralasetty (6):
>   wifi: ath11k: Add initialization and deinitialization sequence for CFR
>     module
>   wifi: ath11k: Register debugfs for CFR configuration
>   wifi: ath11k: Add support unassociated client CFR
>   wifi: ath11k: Register relayfs entries for CFR dump
>   wifi: ath11k: Register DBR event handler for CFR data
>   wifi: ath11k: Register handler for CFR capture event
> 
>  drivers/net/wireless/ath/ath11k/Kconfig       |   11 +
>  drivers/net/wireless/ath/ath11k/Makefile      |    1 +
>  drivers/net/wireless/ath/ath11k/cfr.c         | 1007 +++++++++++++++++
>  drivers/net/wireless/ath/ath11k/cfr.h         |  302 +++++
>  drivers/net/wireless/ath/ath11k/core.c        |   41 +-
>  drivers/net/wireless/ath/ath11k/core.h        |   19 +-
>  drivers/net/wireless/ath/ath11k/dbring.c      |   50 +-
>  drivers/net/wireless/ath/ath11k/dbring.h      |    8 +-
>  drivers/net/wireless/ath/ath11k/debug.h       |    8 +-
>  drivers/net/wireless/ath/ath11k/debugfs_sta.c |  143 ++-
>  drivers/net/wireless/ath/ath11k/hal.c         |    3 +-
>  drivers/net/wireless/ath/ath11k/hw.h          |    5 +-
>  drivers/net/wireless/ath/ath11k/mac.c         |   17 +-
>  drivers/net/wireless/ath/ath11k/wmi.c         |  147 ++-
>  drivers/net/wireless/ath/ath11k/wmi.h         |   97 +-
>  15 files changed, 1833 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
>  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
> 
> 
> base-commit: 059ca8fd692b67a77fb89e9d4e8f57cf08e32b08

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


