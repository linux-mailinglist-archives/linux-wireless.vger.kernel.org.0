Return-Path: <linux-wireless+bounces-38236-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kKCeJjDUQWp9uwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38236-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:10:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CD66D5793
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:10:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Qzr4CBKh;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jFQ9PkhJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38236-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38236-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0278300A3BF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 02:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33C2D3A7C;
	Mon, 29 Jun 2026 02:10:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B5175A94
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:10:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699054; cv=none; b=QcrHUsRloGrnqfjqtFQz+68uKgxCNZ8CY/fvXo6R/V9b2EW+Y0JVglwBotLLImuVhOrIXMM5PUrXRSoj5dzbs1omRWNSzUqtvTyssOrPUIBBRK3i6fbgY9slrPTwtXX5x9m6pUwuv+pPCc95lrqwVj6gJjcBcXyDry6Rio1/Rto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699054; c=relaxed/simple;
	bh=AZ53OgygDLIniErDDhteu3GmJt/DAeZHCqhO5AEj8NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCz1R94X71mAQ2CQYeRt2sR3lmkKqb+y/JvRWWX8hZCo6BxUhEZ7h+GUnYhV/cSH/mKnwWTWzVsYP+URsWpFU8/2h0SU6eKZa17exLya3IKYkLqBY4k/MxNOwAx8eRUr02zzhaDcRRk6h+CDHRy5UVGKfm/FZqvlW+WPAgpuIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qzr4CBKh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jFQ9PkhJ; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SM9vkm977587
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BvWJtJIO5wlFhcTu3sRJPTIcMyMoyT39MwDwH6X3WmM=; b=Qzr4CBKhn9ap3pjw
	yNi4qCi8RJecwv/k/PWf30dSAobY2l40oVI50ZlQONU4XC8KrqafbKazFnKBeUG1
	QNfPad0AhunP/lPa1uDaRNKqtLD7gAVdjYuXrpJXVWbAuc6o79mS7bpnxUKPv1dR
	sfstaYrStjpYE2ylP30aePQsLG4nV+lBx9r82vC99xvs7EognEZDhbJvsMI6LNes
	91iyQMSJsGNRmmP+LgZo1fP4FG/GN5nsasYHSQYMTvE0JVtes52VJoKeUWx7qZjn
	Kx6PAziGUKzt0earV1STLHAetc3MLfgERrZVGktNyj1fT9CbyOCn0Nw4/BvrSTPe
	q9YRlg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f270a440m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:10:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84531eaf8a8so4100575b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 19:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782699051; x=1783303851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvWJtJIO5wlFhcTu3sRJPTIcMyMoyT39MwDwH6X3WmM=;
        b=jFQ9PkhJVLxXAZ14aPnPvLeLcPMmdbucgE4u83hDZr3kFyVuADhkKYKzvyCGvoC65H
         g7Mal9Et4h9tFhHMDqUEgzEzRcdnyUI/44w4xRCTMfHdMpMtuMgoSItnQs7WTWvZ/hhb
         B+QP8zGMhpcYkwqLT+8uD/ZJlVX3efK9a6y+87n8SHdQGDu/27MD9O63MyFhdMyiYFH1
         g4W1BustKmp+6Gh24Spmjr3g4xeBLeoCGdc5WjPDHlHiBpJRm7OsP2acqahcvo9beOs7
         Z8GkqNAfSMYvDqPIwHqeyOlMAIe3rXZ5iBPl9iBkIBmCl5ewUJ9+Fk0u+lDZP2OCFdUg
         D4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782699051; x=1783303851;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvWJtJIO5wlFhcTu3sRJPTIcMyMoyT39MwDwH6X3WmM=;
        b=Sv660maAgMuvAv3V3bjqF1EQbaJ7JvfFz0LwcPvNPIqCnET1OVzG7uhUk6SYQN444P
         E0vmahRkPQXVTpBFW6nHDS8xqxpe2DasYG/B9MZEZETyrgaxXxpfLWnPUaei9wWljPyl
         I7gLTUI8BEaGvxx+CBCriLl8C3L2BS+zp9UqMhKCo5JNk7+CiVQ5CwiaxDppbSq2Y0Li
         E+ZgMKcoHnghoOGvcl7uj4J9WZTcPuV4b64a/l5Cd67SDKPQorrDa4IhjbNCfiBbhato
         +4pSlpWBkbbeVL18vpuMiBg4rzAG6jdhVAvrlL/Ex+gQxqw7SIKx7z7ap3ysKmFut/Os
         VuqQ==
X-Gm-Message-State: AOJu0Yx7q4p5PBLzn4lfW4iDR00jrsfo0+WmfBfXUGMvdCVSjKoQ2d+l
	qk8VLk+KxLhTxRgFqIkyLQedHyUCgcg9aGXVcjcISHX1kEjfxVzFtea3XtUpI8xg2PSDvQpHT7G
	FqNkNYMmmkj/nMaAH98vb51hBTRZUhBEk+ODk+wP92iYSN/VqNzKET9Qq1LBYefMPR/ZclXM0F/
	Tk3Ing
X-Gm-Gg: AfdE7ckyU3Qim5KjUqta6TXHubyVtQobj8ZOWZv9NGfcGGEnbl9l4iwbfUMqZXIVA8e
	yPgYIZP2lChIhRW5OL3/XVdJTkGUduDlUIubjmTdC3ucCC2spOsvwxP2+/8l/HnkjiKRtO0JsUr
	wsWZ+hnBOrRZCS9YMbCbpRjTeDkh05Q0mhv8rlRhDqUEASthHn34mq06wLJxMcYZAH92/bbD9tu
	GTOVKv8f3NLj5M7Y4nreNOtexSfBRF7l3fZ1h1powZPU7S1SiL0wFOdc6z6z6+eAiCiDuya3QFZ
	CCTuR54bevH6UE9vQ2r5p414gqHmZougdmrn5xVuwZ2wXySsMIfgPLTA2GBgDciiRXAVAngjzyf
	z6pBB87/k3F/Q4DIEP7kJOgMtCVRJbm4JLr7Gu+72DK7d73MAP/SRy/DldAijncfMW+wWGjM8aQ
	L2FUomTA==
X-Received: by 2002:a05:6a00:cd2:b0:845:d286:1fa8 with SMTP id d2e1a72fcca58-845d28632aemr8102436b3a.55.1782699051101;
        Sun, 28 Jun 2026 19:10:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:cd2:b0:845:d286:1fa8 with SMTP id d2e1a72fcca58-845d28632aemr8102415b3a.55.1782699050608;
        Sun, 28 Jun 2026 19:10:50 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d23ccsm11368101b3a.36.2026.06.28.19.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 19:10:50 -0700 (PDT)
Message-ID: <75fd4d07-4f96-4ff5-89e1-44abdeb1ebe0@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:10:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] Revert "wifi: ath12k: add panic handler"
To: Yingying Tang <yingying.tang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
References: <20260612032332.2278338-1-yingying.tang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260612032332.2278338-1-yingying.tang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAxNiBTYWx0ZWRfX1MC60ruluyVa
 TgvGeFwcHfb8uXWb9qwW0wYOmNcubfdQ7padQWP/2dPXAz7rWnBw1DA9FricqX8KWM9Eq9wkBJ3
 1IVqeFKUyvUjDM6syenLOO7jMuwfMVXhSilM9J+YImbWEtVaXkNHV5pflUqoVbbBx8NyxbfXsq3
 2A1hnffeOGMnQjtgMkX0OGHJIx3FiKsZ7Hb3IaBiJbrxxEZCoiTz4H3mYxBrsbRb9BhBmcM1UX1
 SAPpRjX8EZX6RqZEnjVIS/UJHMhqytiKhZFXqhpjnzhmlHpMLJsrs0K4jfR/fBJMG13KC0NS6Ay
 BAQ4YfN4O8ost/zbfBkQeTrGA6oSru+9t5FnhpP5FmtAMiqd6v9Iz6INtED4MeTy++2OwZCAhqD
 hk5ED8wKgddVNDuLzgsKmikx5fK3whUz/y51SrPK5uXSLJVOAvpv/+TVPbLvM0bx05H6Ft1dqLB
 wBbkTs3fNDMUmM7WqfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAxNiBTYWx0ZWRfX4vQAsW7zJh8Z
 6Cd+ZLPyQeeeH2F7baoFxSs3h/cIJrsLL6pkHetsIucIdqh0uxY7viN+lE9ZRymB5JAIZOVD/0m
 CCV9v3hCZZp+CYpUnVYCuXEUvMjQBis=
X-Proofpoint-GUID: ejPCOgu89C1L8Q-P1c9ZWmmRCBEADGh1
X-Proofpoint-ORIG-GUID: ejPCOgu89C1L8Q-P1c9ZWmmRCBEADGh1
X-Authority-Analysis: v=2.4 cv=Fe4HAp+6 c=1 sm=1 tr=0 ts=6a41d42b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=iKBbR0_8DyDqkRAYhu8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290016
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38236-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yingying.tang@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:yintang@qti.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7CD66D5793



On 6/12/2026 11:23 AM, Yingying Tang wrote:
> This reverts commit 809055628bce824b7fe18331abb65e44d02b0ecf.
> 
> Call trace:
> rcu_note_context_switch+0x4c4/0x508 (P)
> __schedule+0xbc/0x1204
> schedule+0x34/0x110
> schedule_timeout+0x84/0x11c
> __mhi_device_get_sync+0x164/0x228 [mhi]
> mhi_device_get_sync+0x1c/0x3c [mhi]
> ath12k_wifi7_pci_bus_wake_up+0x20/0x2c [ath12k_wifi7]
> ath12k_pci_read32+0x58/0x350 [ath12k]
> ath12k_pci_clear_dbg_registers+0x28/0xb8 [ath12k]
> ath12k_pci_panic_handler+0x20/0x44 [ath12k] ath12k_core_panic_handler+0x28/0x3c [ath12k]
> notifier_call_chain+0x78/0x1c0
> atomic_notifier_call_chain+0x3c/0x5c
> 
> ath12k_core_panic_handler() is invoked via atomic_notifier_call_chain(),
> which runs inside an RCU read-side critical section. The current code calls
> ath12k_pci_sw_reset() synchronously from this context, which eventually
> reaches mhi_device_get_sync() and schedule_timeout(), triggering a voluntary
> context switch within RCU.
> 
> Revert change "wifi: ath12k: add panic handler" to avoid this issue.
> 
> Tested-on: WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3

incorrect Tested-on: tag format

> 

Fixes: ?

> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 33 +-------------------------
>  drivers/net/wireless/ath/ath12k/core.h |  3 ---
>  drivers/net/wireless/ath/ath12k/hif.h  |  9 -------
>  drivers/net/wireless/ath/ath12k/pci.c  |  8 -------
>  4 files changed, 1 insertion(+), 52 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 1a9866061f82..6705a8a73de1 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1793,29 +1793,6 @@ int ath12k_core_pre_init(struct ath12k_base *ab)
>  	return 0;
>  }
>  
> -static int ath12k_core_panic_handler(struct notifier_block *nb,
> -				     unsigned long action, void *data)
> -{
> -	struct ath12k_base *ab = container_of(nb, struct ath12k_base,
> -					      panic_nb);
> -
> -	return ath12k_hif_panic_handler(ab);
> -}
> -
> -static int ath12k_core_panic_notifier_register(struct ath12k_base *ab)
> -{
> -	ab->panic_nb.notifier_call = ath12k_core_panic_handler;
> -
> -	return atomic_notifier_chain_register(&panic_notifier_list,
> -					      &ab->panic_nb);
> -}
> -
> -static void ath12k_core_panic_notifier_unregister(struct ath12k_base *ab)
> -{
> -	atomic_notifier_chain_unregister(&panic_notifier_list,
> -					 &ab->panic_nb);
> -}
> -
>  static inline
>  bool ath12k_core_hw_group_create_ready(struct ath12k_hw_group *ag)
>  {
> @@ -2212,18 +2189,13 @@ int ath12k_core_init(struct ath12k_base *ab)
>  	struct ath12k_hw_group *ag;
>  	int ret;
>  
> -	ret = ath12k_core_panic_notifier_register(ab);
> -	if (ret)
> -		ath12k_warn(ab, "failed to register panic handler: %d\n", ret);
> -
>  	mutex_lock(&ath12k_hw_group_mutex);
>  
>  	ag = ath12k_core_hw_group_assign(ab);
>  	if (!ag) {
>  		mutex_unlock(&ath12k_hw_group_mutex);
>  		ath12k_warn(ab, "unable to get hw group\n");
> -		ret = -ENODEV;
> -		goto err_unregister_notifier;
> +		return -ENODEV;
>  	}
>  
>  	mutex_unlock(&ath12k_hw_group_mutex);
> @@ -2248,8 +2220,6 @@ int ath12k_core_init(struct ath12k_base *ab)
>  
>  err_unassign_hw_group:
>  	ath12k_core_hw_group_unassign(ab);
> -err_unregister_notifier:
> -	ath12k_core_panic_notifier_unregister(ab);
>  
>  	return ret;
>  }
> @@ -2258,7 +2228,6 @@ void ath12k_core_deinit(struct ath12k_base *ab)
>  {
>  	ath12k_core_hw_group_destroy(ab->ag);
>  	ath12k_core_hw_group_unassign(ab);
> -	ath12k_core_panic_notifier_unregister(ab);
>  }
>  
>  void ath12k_core_free(struct ath12k_base *ab)
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 4edc8f4e0cb5..a81cb3032145 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -15,7 +15,6 @@
>  #include <linux/ctype.h>
>  #include <linux/firmware.h>
>  #include <linux/of_reserved_mem.h>
> -#include <linux/panic_notifier.h>
>  #include <linux/average.h>
>  #include <linux/of.h>
>  #include <linux/rhashtable.h>
> @@ -1121,8 +1120,6 @@ struct ath12k_base {
>  
>  #endif /* CONFIG_ACPI */
>  
> -	struct notifier_block panic_nb;
> -
>  	struct ath12k_hw_group *ag;
>  	struct ath12k_wsi_info wsi_info;
>  	enum ath12k_firmware_mode fw_mode;
> diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
> index e8840fab6061..42bb00c13ef3 100644
> --- a/drivers/net/wireless/ath/ath12k/hif.h
> +++ b/drivers/net/wireless/ath/ath12k/hif.h
> @@ -30,7 +30,6 @@ struct ath12k_hif_ops {
>  	void (*ce_irq_enable)(struct ath12k_base *ab);
>  	void (*ce_irq_disable)(struct ath12k_base *ab);
>  	void (*get_ce_msi_idx)(struct ath12k_base *ab, u32 ce_id, u32 *msi_idx);
> -	int (*panic_handler)(struct ath12k_base *ab);
>  	void (*coredump_download)(struct ath12k_base *ab);
>  };
>  
> @@ -149,14 +148,6 @@ static inline void ath12k_hif_power_down(struct ath12k_base *ab, bool is_suspend
>  	ab->hif.ops->power_down(ab, is_suspend);
>  }
>  
> -static inline int ath12k_hif_panic_handler(struct ath12k_base *ab)
> -{
> -	if (!ab->hif.ops->panic_handler)
> -		return NOTIFY_DONE;
> -
> -	return ab->hif.ops->panic_handler(ab);
> -}
> -
>  static inline void ath12k_hif_coredump_download(struct ath12k_base *ab)
>  {
>  	if (ab->hif.ops->coredump_download)
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 375277ca2b89..65a780e74d01 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -1469,13 +1469,6 @@ void ath12k_pci_power_down(struct ath12k_base *ab, bool is_suspend)
>  	ath12k_pci_sw_reset(ab_pci->ab, false);
>  }
>  
> -static int ath12k_pci_panic_handler(struct ath12k_base *ab)
> -{
> -	ath12k_pci_sw_reset(ab, false);
> -
> -	return NOTIFY_OK;
> -}
> -
>  static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
>  	.start = ath12k_pci_start,
>  	.stop = ath12k_pci_stop,
> @@ -1493,7 +1486,6 @@ static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
>  	.ce_irq_enable = ath12k_pci_hif_ce_irq_enable,
>  	.ce_irq_disable = ath12k_pci_hif_ce_irq_disable,
>  	.get_ce_msi_idx = ath12k_pci_get_ce_msi_idx,
> -	.panic_handler = ath12k_pci_panic_handler,
>  #ifdef CONFIG_ATH12K_COREDUMP
>  	.coredump_download = ath12k_pci_coredump_download,
>  #endif


