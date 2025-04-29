Return-Path: <linux-wireless+bounces-22221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C12AA1C91
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 22:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EB298268A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 20:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0281242D80;
	Tue, 29 Apr 2025 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kv+lsr9D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5C21D3F4
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960311; cv=none; b=SqHF32jMx5rw9kl94Q+N6tttZ/CRm9ayqoxgXXOsqXODM8+1Qq29eLpaBZmswSI3urI+EaG6fqfTkAxSYxUmUH0lQpuxnSNFwpiI0Uz1hEV1ttd031WCDtTr+/Ba3WeJgxD8cDqO3fBKfHmHrlkvEswtqDJbVdUgMJ9rKxmyDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960311; c=relaxed/simple;
	bh=jfeysXA+nBPzMrXBwaT6OWXUbOfDCR9ZzlfwJxpbcjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gzzl6KypUaHnsJak+yCSWi0yo4LBIVzrPe/uDi0WS2jdQY3JCJwuCmahbLKMYlmh5hK8NJal2/OPHmQAYi2njntSZaBWY0OEDPVuTlMJDhtcyS8upxafbdrkjDkIETMCZ04kwo1Lp6gPScZZtxAPWRRbDsVVlJ2mgFDS6YuFZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kv+lsr9D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TA20nT030210
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 20:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LaXqKDf2l4Hz3ngZO8zA1vYeblK547Nj2jUlC5EGzU4=; b=kv+lsr9Dl7TUvY6s
	JI5ZY9WJP2l8IOLeRTVS6xioU8jjmWMygjKMTTRw51bcA3aLChqAgMgjo+xv6Cd3
	Y9niaEzbWaOyhWpp2Wc71NfjqCiEYuFOCMU6+qWRwKfNCRH2b0Cjf1/8H7lXVuvK
	YEJx9Dv4zotEsIC5v55jeOXwYear+rzxQ0iRP0mV3uKc0erDXnhVJk7k6Y8JZk2B
	xsw5fCpts63OYcWRuZCOl1umFSoW5qfWs1UcaAUW1vc4cIxZ5KBsA0y5kt5+Qm4T
	FRBW6B1A4C12bNBcP5n2MHONn9PBHhpb96vPYHNaY0KOz08BH45k18yrdsw5i6HA
	w9ivgg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468pevmxcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 20:58:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224347aef79so88542225ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 13:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745960308; x=1746565108;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LaXqKDf2l4Hz3ngZO8zA1vYeblK547Nj2jUlC5EGzU4=;
        b=SVSMi+jc9kApyR++UDpvJ3ZF3HVb1+N0yqTT0yp0EgUutAlT9CXw93jpBfuIobAoyi
         kLpOevxWS8p9oY8/gYngzjAw1gHZdwiVCcoD/Z58GQioewUeUHd6Ldj5mqPMYyDPXXbh
         2zQkAzgu0PwYSPrrWkKWtIz9W/mWafktUFilXJwnpOVbZObsTsf2PiaVnOqLVeYhQ13w
         U7CiqV7/naa/rkHDNB5chfBUXeyag87GhfA1Di85mh3gKRy8YOe4zafm9TM+1sfI4whk
         dXICi65uc9hAJvZ/1MxccwJvvxfQjFO4DAm3zLBsD5bfvQYwzyA2nk3ujnZiRd8dbCW1
         8a9w==
X-Gm-Message-State: AOJu0YwpTSLIQUE/aeu0FCBe+oUlQXJ2uHVaQX+XRlGpa6YLFvKPbF8F
	wCDRvnlntm/D1GPQtLnTs9pepi+VCfETq37+xIyF6Xu9Dl75zPwFuN1y5qNA9QLq+ji6gn2Ej+n
	TnhlbhTOeV1gOQMnw4UARgk2FrvTNpiixVRsvEIYoxR7gBa4h7b7ICF7qEgEiHPMwivcIKlZYUw
	==
X-Gm-Gg: ASbGncslyrlpSXUMJGb31vYjtrdVQadjZcYUQuA1H343dUZg3LKWzqKHt+zPxtXt6nB
	1kXVnmflqlGbCm2F8rdqqavhvNIyRfyKR8QbjNHFufZ0ApNt1yFCOG9VpEdFS3yL2Pv/IFBGL/B
	+6Ut4MalpVFkYbujioyPWhNU1vumRaGS1euqR8GlcqORhDNaaW0XsGZct1qsoPk0d1VONJ1lDnJ
	j7ttzp/ilb7qjiuPeML1FVOX6gyLwYpHjOzUoccDgey4qW8np3skijOUMUqyG4SKV9TShhxCLIZ
	jlJXGwOZqBBSICMGhm1Upssflzn3JCn0dETr2FFnqrsdL6gyPYTR4lLMpFdcxUWWOGYO5TnsRh5
	fyHXR
X-Received: by 2002:a17:902:db02:b0:223:5ca8:5ecb with SMTP id d9443c01a7336-22df359e637mr10772475ad.42.1745960307741;
        Tue, 29 Apr 2025 13:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrcMFHUYLjwe4y94YofcgVMPeIIvjBEjmTCTHsI7MAvhpmYPXovcWQXuXTBnVfSD4iPc8FWw==
X-Received: by 2002:a17:902:db02:b0:223:5ca8:5ecb with SMTP id d9443c01a7336-22df359e637mr10772295ad.42.1745960307374;
        Tue, 29 Apr 2025 13:58:27 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22de49dccd3sm27177585ad.123.2025.04.29.13.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 13:58:27 -0700 (PDT)
Message-ID: <6ea8710e-7171-42ad-b1b1-5fe679dd19d6@oss.qualcomm.com>
Date: Tue, 29 Apr 2025 13:58:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 0/2] wifi: cfg80211/mac80211/ath12k:
 Enable monitor creation in NO_VIRTUAL_MONITOR mode when AP is active
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250313020154.4066212-1-quic_nithp@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250313020154.4066212-1-quic_nithp@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3xnDMt7tw6KLdpLe5uCHDKlH53wLzq6w
X-Authority-Analysis: v=2.4 cv=aeBhnQot c=1 sm=1 tr=0 ts=68113d74 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=tnG_meDCn_FebXUBQTwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 3xnDMt7tw6KLdpLe5uCHDKlH53wLzq6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1NSBTYWx0ZWRfX2pPZx6YfM6Zu hAMfzcmixjJ9+yu/mHur0fA1mIYJVFF1fiz8ClJ4f16IiQV+dbK9KG8pFrUCwgRl3xwNcptHS1T 95UnMCJTM/kxDJkObHC9NDNqfM7yyfZQSAcg604jve9vfipL6Q7lrFcqM7odu+a6MIxxWcQVZC/
 OJZS2oY3k0Sxuk7avApicDG4Tl06ODaYMVz7upP3GrzV2bpMj6Q5snP5ixuLsTobkkDZAZHyZYw XEJd2jB5pAbGtha55wTzhBY03QGzOAh+Wlx53JEzeGosBvHg5mFhMmPrFxGtGMeN17y3xdAzuhm EH6jlP7+q3bUcgFUtkkFvg5Z9wudtuBddSzoKsOP3jppgWpDlOYp9jzWJ5F6+c1wcRaWAekvV3I
 b0wWtOAo7zWDgKLu+s9uDRaWvwQPD4255Kdjkf7fPGX482f07vFscbnd8bCjikvzMYTeO9fO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290155

On 3/12/2025 7:01 PM, Nithyanantham Paramasivam wrote:
> Currently, in NO_VIRTUAL_MONITOR mode, when creating an
> AP/STA + monitor, there is a restriction: if the AP/STA is running,
> setting the channel for the monitor is not allowed. For example,
> in a scenario with three supported radios where the AP uses only the
> 2 GHz and 5 GHz bands, the 6 GHz band remains available. However,
> due to the restriction that rdev->num_running_ifaces must equal
> rdev->num_running_monitor_ifaces in cfg80211_has_monitors_only(),
> we are unable to create the monitor interface.
> 
> cfg80211_set_monitor_channel -> cfg80211_has_monitors_only()
> 
> static inline bool cfg80211_has_monitors_only() {
> ...
>    return rdev->num_running_ifaces == rdev->num_running_monitor_ifaces
>         && rdev->num_running_ifaces > 0;
> }
> 
> To address this issue, bypass the cfg80211_has_monitors_only() call
> for NO_VIRTUAL_MONITOR to allow monitor creation. In the mac80211
> layer, no additional changes are required. It follows the same
> sequence as standalone monitor creation in NO_VIRTUAL_MONITOR mode.
> 
> Refer link to Felix's NO_VIRTUAL_MONITOR mode patch series.
> https://lore.kernel.org/linux-wireless/cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name/
> 
> Tested various scenarios with the cfg80211_has_monitors_only() bypass
> modification
> 
> 	standalone monitor creation case
> 	********************************
> 	1. Create multiple standalone monitor interfaces with
> 	different radios
> 	- Allowed one channel per radio but multiple interfaces
> 		can be created with the same channel/radio.
> 	
> 	AP+Monitor case
> 	***************
> 	1. Create monitor interface with same channel used by AP
> 		- allowed
> 	2. Create a monitor interface on a different channel (ch-6)
> 	on the same radio that the AP uses (ch-1) - not allowed
> 	3. If the system supports three radios (2 GHz, 5 GHz, and 6 GHz)
> 	and the AP uses 5 GHz and 6 GHz - allowed to create a monitor on
> 	the 2 GHz radio
> 
> 
> Please share your thoughts on the following query
> 
> In the virtual monitor mode design, only a single monitor interface
> per radio was supported and subsquent monitor creation shares the same
> vif. However, in NO_VIRTUAL_MONITOR mode(multi-wiphy scenario), there
> is no limitation on the number of interfaces that can be created (due
> to separate SDATA for each interface) and notified to the driver.
> For example, the ath driver can handle up to 16 interfaces per radio.
> Should we impose any limitations in cfg80211/mac80211 ?
> 
> V2:
> - Rebased patches
> - Flag renamed to WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF
> - Patch(2/2) renamed 
> - updated all the patch comments
>  
> Nithyanantham Paramasivam (2):
>   wifi: cfg80211: Allow monitor creation in NO_VIRTUAL_MONITOR mode with
>     active AP
>   wifi: mac80211: Set the WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF
>     flag
> 
>  include/net/cfg80211.h | 55 ++++++++++++++++++++++--------------------
>  net/mac80211/main.c    |  4 +++
>  net/wireless/chan.c    |  4 ++-
>  3 files changed, 36 insertions(+), 27 deletions(-)
> 
> 
> base-commit: 42aa76e608ca845c98e79f9e23af0bdb07b2eb1d

Still looking for feedback on this series...

