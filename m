Return-Path: <linux-wireless+bounces-35181-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dXTuNQ+152l8/wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35181-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 19:34:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4078B43E081
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 19:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9771E3027CEF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9EC31B80D;
	Tue, 21 Apr 2026 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QS1e8+mp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HM65o6Sf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234532BE62E
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792773; cv=none; b=dTmQKuAzpWe1Qy5Pqf1FFw9hL2l3Rs3iM5ch0evqIfAAlFubD1SIRDVE9a9QF1BaF2YDidU4+SFl70j4gMK2m2NHjZ6I5pos/DpK/cAViciCgGNAeLOdRvA4Sjku72RzOu2QIFNcN5/xQSQRQzFSdRGAkVJq1EeMz57HjO2vfsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792773; c=relaxed/simple;
	bh=/Ba3EWb30hnk7KFV4mh/GjZJGnrFEQ1WOb7ya6fOX7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEjage3UDN43SAlFhMe6AwgK0qzjv7SdJPdY3/svidw4JoVrQpnivIKm/fj7xGp7UPrBfS90tAZ9jdSJkr6icMRYyH+Oiw0gu4motRhwBiKepfGh/+8IxtkDkNnP52WcJQqsj4gNfqSdQzGjIBufefv+xDWoy/NljUzRZh94K5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QS1e8+mp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HM65o6Sf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LGTMuB046067
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 17:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	URbrxLq/NhhyYFTtqjb5hgyP/ewhb68e/QnrFe61sLQ=; b=QS1e8+mpvTYDjLbI
	xBjSEijM1o+jWC55zG9SWLVLY83eP+tP725VAEMlhVXgrcn+abz3kKFGYxGcZS2Z
	nGSkalD/gFqNdhkCNZrhy4it6WuRCW+iPpJYayUglXGT6Cbxn/kixJ5iDld5vNIs
	lIWhGLifnNHQdWbQyKJtrjSG/+3qr/XCsbfx85cOg+ZzNdkQymT0hD9CTabVefrF
	5IHeVJYJi3GJdUEAaWnZYUIY1+zZtddg0aZOAbWaFeNXNSENAl9EsH3PgMiLIN6t
	n2f8vZWfZAihWck1OOoTbAfdnCIdKr24JQpmTr+Qs524pDnDLz+D9EUnnsVRSKk2
	EJ2t2Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp0y1u43a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 17:32:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c79798cd9b9so1341350a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776792771; x=1777397571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URbrxLq/NhhyYFTtqjb5hgyP/ewhb68e/QnrFe61sLQ=;
        b=HM65o6Sfc7jzwFEWWDwl+sc4Nddj7Dlr767BVD9IwboV5BrHZYminsJtYxKGWSfQwn
         DFl7C1H2HgoJ1uWIqhgMkzlAIy0n2bIao22GEeQkbgCw7NHlmmwXwVj4YFCuIztvDfTe
         EhCP/fYUtvih/8w1xyFhZIAfouEjTPaOnWXcmaeGM58c/nAz6s31zmoI8S74Qfb0aG9D
         v/HXTzAvl5xefchn4k6aVKULtkAlMd4TWu3IkLGxNHq8UrRUz13L/kfyUsWrnSC855VK
         FbnA22FFYg/wOgRyMLhryo+2sfMvyYxc97HrtTvgKnIqcZhvp682g9Tmk0H5o7dEsldt
         hQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792771; x=1777397571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URbrxLq/NhhyYFTtqjb5hgyP/ewhb68e/QnrFe61sLQ=;
        b=YCDPUa/c4sJy/Bw4KSEtF2cdldGGHuNBSJNDRgzchlOtqOWbbtkPcT2kQdMRcoXljY
         w9bKjC7Cw+Yx8ydl1zDV7Lf3Y61VmM2buUo+t6FD5jnDcjGgoLFX2EazkZwiDdtNceWj
         n2a4cbcAXSRnG+lXAW0ucZwePvXOjHYq6dGcYnaECCue6P4dMaoS4wbMTUvjZgfj9xdU
         2G1e91OIu+WNX/wm/ylGHk0q/aX0A42ejAHRkG6FM47cqj4e1sRRee6vZNQjV+xEuvLF
         jpaOFO1JtCfYmcYBdxoSW2vQaLd7qqUdS7bOoPVheIvWfGVtOObfaQ+Y+XbbW+2ZhcWz
         GXSg==
X-Forwarded-Encrypted: i=1; AFNElJ/VIxUR/Dt1rAn0HRKvCMIiO9COUH5fqb1rOCQV+/jXD67ismsbvd8dwBiiO9ZDt2EHr0VEcw9Er5EETMkZRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaT1UaYN6EkL/HSs5OIOeu0C06Z5CpfZqfHCqNPj4Y0949whkn
	rMUVmebGF7JQ9AtVfsYVlTKMOwMzWXZwHd7epyGleIi1ZQ0VH4VB77TY6Bgg7JnUY+vUoMACUnC
	bdK2rRbUkrF5ZA3B2EfBTgAnAei6T8/6GEMGicjmnteLCE+taqBZI56CGGsh653X+Hozv8Q==
X-Gm-Gg: AeBDietqeFPPUZ9rr0krN07e64Pg82GezNPyVzgFgUZ2bO9HvrDGftnzd61wytgLHuF
	pQxCyfc2Qkg7hd9tiaBdH4BFbwHPJZRZRMGC4HdsMIq6Gm2XUCQWeXb3wSRtig11gYXmMnTnsCw
	EDcgJBU22Go3b8CHAF7vc0M12XNkFiR/Qq8Myee5bFmXprUIZclpP7p/D2cmNYj5Ilz4PC4w9jz
	jeQC1y1xvJHZ0fQzRTfp/if00qAZSwiR/SvKN9jh77aJE54VumStRy+VgRmhnV0ILr9bD2brlni
	0wIEEz6zxvJe3ucdHv3rEnOUpPgqCOR4jWC3V/syFEeGx7h1GMqSfLaR3/AH2S85iegWEPoTusX
	LCTLT8XDxBBoDQbbtT1NN8RDbMepAfinN3lHu2XQoP9tCNctOYZwygLpKqUoaI/KJkXhhqzEWXQ
	Jt
X-Received: by 2002:a05:6a20:4326:b0:39c:cf9:b8e4 with SMTP id adf61e73a8af0-3a08d8f5a50mr22898227637.42.1776792770677;
        Tue, 21 Apr 2026 10:32:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:4326:b0:39c:cf9:b8e4 with SMTP id adf61e73a8af0-3a08d8f5a50mr22898185637.42.1776792770063;
        Tue, 21 Apr 2026 10:32:50 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f3e5sm11200099a12.5.2026.04.21.10.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:32:49 -0700 (PDT)
Message-ID: <1016fbd7-be27-44b1-9eb8-6201c9495f1a@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 23:02:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on
 PREEMPT_RT
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
 <20260421172500.1050754-1-asas1asas200@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260421172500.1050754-1-asas1asas200@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=69e7b4c3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=akWcTCgZTv-KWhlo_GAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3NCBTYWx0ZWRfX84vdVXW5vrIS
 RsVAfNQujJiyD59pVMFBJJ3VdcyeLbWsGbtUuAWygB7ePwGdtuN6iH0lfHiXY3lVYjz5Sw9e7vU
 ctZTeIjqhTwgqAQiRqFRh4ngUUYHlmjxJuCZdfrXdCXp75jhxH4MJAKiFFlSJ9G4K09PCG8nmK5
 ZOfrAGsyGV1epg/XTyNUzuLqWOpVocwi61OoIeGtMkbWtjGOaYzcp7W0RD+ew2S/3FirqUhmlfz
 uevZVQpw8DF9Ro6LUgPYBwDzGSJTXyKh315oWRY5ZKfQWLH+ycYlz8AS6PNUPBB2GEaXR21OP6j
 cVp4/6c6h1Sme1Bgdlr5Pys3OgyTNxOQhIu2+SwcjIPTM2GnA92BYicUhoymr6vM0vDOuupw0HL
 p7lzd2Nquk6YM5L1q7UwBtI98hBxPVBpppfhL9Tv4uIMbHFdnhzW3DvXLQ79O0/+2gbkF3RUDtP
 mGq8r6dcWgktA1twbDw==
X-Proofpoint-ORIG-GUID: RoLd6GCWkgWNi8FFRIeYIUrijCCFbutq
X-Proofpoint-GUID: RoLd6GCWkgWNi8FFRIeYIUrijCCFbutq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210174
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35181-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4078B43E081
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/2026 10:55 PM, Yu-Hsiang Tseng wrote:
> Two functions in ath12k assert that the caller holds an RCU read lock:
> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:
> 
>      WARN_ON(!rcu_read_lock_any_held());
> 
> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
> false positive splat whenever these functions are invoked from paths
> that do hold the RCU read lock (e.g. firmware stats processing or
> mac80211 interface iteration).
> 
> Root cause:
> 
>    - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
>      returns !preemptible() as a proxy for "in an RCU read section".
> 
>    - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
>      task can therefore be preemptible while legitimately holding an
>      RCU read lock.
> 
>    - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)())
>      and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
>      read lock, so these warnings are incorrect.
> 
> Typical splat seen on a WCN7850 station with periodic fw stats
> processing:
> 
>    WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
>      ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
>    Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
>    Call Trace:
>     ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
>     ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
>     ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
>     ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
>     ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
>     ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
>     ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]
> 
> Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
> debug_lockdep_rcu_enabled() and therefore compiles out entirely
> when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
> full lockdep-based check.
> 
> Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO handling")
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

