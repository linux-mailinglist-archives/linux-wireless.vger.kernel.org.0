Return-Path: <linux-wireless+bounces-35186-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEuTBMbr52ljCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35186-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:27:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3EC43FBCB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 519FA3015806
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 21:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ACF359A90;
	Tue, 21 Apr 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ktlLc7Xc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H9400GKB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB41372B3C
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776806847; cv=none; b=lNwcJbyDXgEU1/Xd5bG66d+OjT6b1I88GzupM3+Ozfx1TNzzr5nyTchGMyITKMgeCedRsCsy4yVVhvXVoZohzlPD+5w9FvTD+KpRuONP4TZQ3XZ9ObwelJeZMNw0x5EPoOid3R5F1hGmF9+fo5JB9ieegZYIQ/hhi4AxixzksFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776806847; c=relaxed/simple;
	bh=8Gl08ANzTWsL2G8lC9gTgFCAxl1aQw8Mj3W3CZIfLvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qU7SwkuFc8Npw9VHpOnBfKiIBFQ8pqs+7UvveiQ7IWL6QWyN27dyQdybw7tYfvQAVLYUPixBqs9yGbk99Iw9l2o39HOb0VsDRTjzhFCkDduSfojKouVyAorhVLrKPoFzV1yRlxSLuDuIjoc4ixkIF2crkYHSvjZWXbx0BBwG1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ktlLc7Xc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H9400GKB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZtrM3377612
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 21:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c8pp1RE019uS7wcr5tEGYa5lrrV0sEz4reE3w0DGdmA=; b=ktlLc7Xc+EABsnHD
	qhIh+BNaS0XkZTsMS+D99+jghplovGzFe1cAlk+igFFv9yU3tjOj35xZxp4pc3rc
	8o32ywNHdW0nAfcUDa/8jZw83OJWc4el+ehte5nwqEZgkZEk0xbtZjDTlu4eROoW
	il5tMi4cbbEB2pexVgCbryPPZr/Kmccely7f/TFqlB6INkhXnHinQCxir+hhlZ0t
	QW7PgyfqxfGv6z2RizFZuV8s6OK18CxLq1NRXlG/mL7zAcgh+s4U+XQ3CBiZvlAj
	S8M9JVrqWU/JlSUW9OdlXmN4vKSsGSeM0pLZT4vUj/FLxdegzys6Nm5V3rYjFYCO
	vO7rEw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng0gbg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 21:27:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12db218e265so6784911c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776806844; x=1777411644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8pp1RE019uS7wcr5tEGYa5lrrV0sEz4reE3w0DGdmA=;
        b=H9400GKBxPoXVOCDdSTtW57xHYSm9zptUG86BmcuK24owYDZuFS3s4NUKBuywotpmT
         9Uzqyx0Ui9UHbNFZjF2KuwQwmh6LCgQ++cX8kWZEsCJWopY22ASBIr2bQtwHwXddyx7K
         pvMZLSy2zdIY5Ii9aAaf0Yo7L8a0k6/JTsxSwafufko+8mQtPfWmI+IoysWXlApGzp/2
         DKqMwmmsw3av5b/s6q325mgM+1KpYbeIRZ3n7EWj+nD6+nu/UX4fa9/s8kdWG9bFxM2Z
         Kfdasnx5Qq2zQxvX7/eZobRRF9f+g3G5+KfYKn7NDlx/EdFCySCUjBxmG7Te668r1dr9
         r9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776806844; x=1777411644;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8pp1RE019uS7wcr5tEGYa5lrrV0sEz4reE3w0DGdmA=;
        b=BEi4y4RqO5N1UuYp+r9p0ogj0WzRWpdTeNGsZy0sGG+yvQHRF/VdCJl/HynVhQYgWz
         eAL+pWJUxBM38qXhrEBY9ooqfnyUaNhM+iZShco7nXrttIy57ofYlnjB4AyA49I6UrFj
         OtLwygkE0wUumXhPbd25Zop4bCQtm2hoi2Mc3Usv3ssAzN/il4zrUiDVT+fB1pMhCSe2
         aKl3d1JXmy5FpE837+KLx0GjC63Z3Q0yOFgA0F2RuI5z1w3zOxHH2ixQAjG1k+vk7kUW
         hgKmSPzw821cZkL48hXCkKBP2W6AAvIe/UAYiXoS817ws1oQL5qDq/FAbLhqugzjqLG6
         1Qzg==
X-Forwarded-Encrypted: i=1; AFNElJ+pQkwWPhygpKa0mkB3vq61IxNQp2/Z+6Y2kBxiTZOLfnoz1lqcHA9we138sMYOVNZCS057IqpLVr3j2I2P0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0aC/8eAglxB2d4Za5WQpFREHnCZD8OoG1NAG0hUPPLM+EZ0G
	E8NAawYWvE4cZkKryGbwqtWP+f0JIppevi6J/RyCNhN9qd3yyGRgUm3WISE0/q7tQ87uTp/hRqU
	bJViUZ8MwdZR/AAXZ8wgYQwbsdwu3dy6WdvoErizRDLiq1GfBs5LZI1Tf3ftdE/VmgvouDw==
X-Gm-Gg: AeBDievdddGOdS2Hhqo24vSddYxwoeU35ok57vQ1QAdf/+DJ+YbFQiDaACdLlheOubD
	30v76cQ4F+UNOnNRWivJXymga1GUkoLnQQLf5buwR7RGgZuIdqFHCTC+y7Dx8hzqSS+fMRO6sbW
	p2R5nw63eI2LFCRtXEXfwhrmMxc38GmMeTy+hSpMAZfjlPb2QOshyxIQjRNJbXiGCXWNHh9jp1o
	57XDwM+Eugnz3pSzqhcJSf8Y5EZ1vALPl3ySPcvyfBEwkJ1ZTvpYxUAX1gqdplRDBqG9BWAtDg1
	XlhTM9DsAxBl8MoIt2y4vixvW6IAnpxMzherWu97byKZP6yVn4UH0rvtXAitLKL+uYERBjtT6AM
	OX0lnnSYCLk5a2ipS2kedtDIQ4i6GdPsBNA9F7Y0kli4fK2SIFHGo1RABmYFmXZPnkxNabECT5Y
	W74/Pps7kXyhWLJMxfrhgJh5lW
X-Received: by 2002:a05:7022:502:b0:12a:713b:896a with SMTP id a92af1059eb24-12c73f92f99mr12165250c88.17.1776806843629;
        Tue, 21 Apr 2026 14:27:23 -0700 (PDT)
X-Received: by 2002:a05:7022:502:b0:12a:713b:896a with SMTP id a92af1059eb24-12c73f92f99mr12165212c88.17.1776806842907;
        Tue, 21 Apr 2026 14:27:22 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm11400458c88.1.2026.04.21.14.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 14:27:22 -0700 (PDT)
Message-ID: <a396cf77-81ff-45a7-ae62-fb4e22c18497@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 14:27:20 -0700
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
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
 <20260421172500.1050754-1-asas1asas200@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421172500.1050754-1-asas1asas200@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e7ebbc cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=b7LFBttVh2RoOqfkFZAA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: deo9N1OPX30sBniTbutOWskQKxKb2zhb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIxMyBTYWx0ZWRfX/BkywCeEJn/Y
 I4hWRqQDfa0gTusbTU/R2krlDmPQYXXs0i6AovLrA6iNzTlGaOaOpxT0vc5vgWpyD4sgLX8lND7
 qQmutnmQHRcNaPbrnnOKT4HFuI8NiZS74q3lm6KaTeOswyaitOr2ZFkG3079SSvmI731kVHxk8d
 2S1I1Sre1jpOo3YevDlYaE1NhB/nhjhd6wCRjpsWXx3RpEFWI6O1gfpxaR7eeoLSBxmwW03Sz5h
 9VjF3VwZcedhtkaqjlptpiMm3R7nvvvxhwMReka1VAXg7G73Iu9u0sNu/+O+/x7VySJ+HrasOaZ
 pCgB1236DPaO8l3V8ytQze2k31n+kGinrHF5incTvRF2+EKLKQcz+w6ZM+RkKtoVXxGFye5tkN0
 9jbi1eIUHizAaLdVkAK0TOhbtjiwkmva+x6zpsHhZ+FTV8NAyJClIIq8xUt42/X+Gj3pqltIsR5
 fm63bn6n0Uv8Iqfk05g==
X-Proofpoint-ORIG-GUID: deo9N1OPX30sBniTbutOWskQKxKb2zhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604210213
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35186-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arvif_iter.ar:url,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1A3EC43FBCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/2026 10:25 AM, Yu-Hsiang Tseng wrote:
> Two functions in ath12k assert that the caller holds an RCU read lock:
> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:
> 
>     WARN_ON(!rcu_read_lock_any_held());
> 
> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
> false positive splat whenever these functions are invoked from paths
> that do hold the RCU read lock (e.g. firmware stats processing or
> mac80211 interface iteration).
> 
> Root cause:
> 
>   - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
>     returns !preemptible() as a proxy for "in an RCU read section".
> 
>   - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
>     task can therefore be preemptible while legitimately holding an
>     RCU read lock.
> 
>   - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)())
>     and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
>     read lock, so these warnings are incorrect.
> 
> Typical splat seen on a WCN7850 station with periodic fw stats
> processing:
> 
>   WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
>     ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
>   Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
>   Call Trace:
>    ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
>    ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
>    ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
>    ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
>    ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
>    ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
>    ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]
> 
> Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
> debug_lockdep_rcu_enabled() and therefore compiles out entirely
> when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
> full lockdep-based check.
> 
> Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO handling")
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Note that Tested-on: is not a official upstream tag, it is an ath-specific
tag. Since it is not an official tag, it should be specified separately from
the official tags:

<commit text>
<blank line>
Tested-on: ...
<blank line>
<official upstream tags>
Signed-off-by: ...

Unless there are are other review comments there is no need to send a v3 to
address this -- I can make this change when I pick up the patch.

> Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
> ---
> Changes in v2:
>   - Also fix the same WARN_ON() in ath12k_p2p_noa_update_vdev_iter()
>     (suggested by Baochen Qiang)
>   - Update commit message to cover both call sites

Note that you made v2 In-reply-to the v1 patch. In kernel.org code review that
is NOT preferred. In kernel.org it is preferred that each version of a patch
be a separate thread.

> 
> Link to v1: https://lore.kernel.org/ath12k/20260420161049.695518-1-asas1asas200@gmail.com/
> 
>  drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
>  drivers/net/wireless/ath/ath12k/p2p.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index fbdfe6424fd7..a772a5b6adc9 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -788,7 +788,8 @@ struct ath12k_link_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
>  
>  	/* To use the arvif returned, caller must have held rcu read lock.
>  	 */
> -	WARN_ON(!rcu_read_lock_any_held());
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
> +			 "RCU read lock not held");
>  	arvif_iter.vdev_id = vdev_id;
>  	arvif_iter.ar = ar;
>  
> diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
> index 59589748f1a8..caa92612372b 100644
> --- a/drivers/net/wireless/ath/ath12k/p2p.c
> +++ b/drivers/net/wireless/ath/ath12k/p2p.c
> @@ -123,7 +123,8 @@ static void ath12k_p2p_noa_update_vdev_iter(void *data, u8 *mac,
>  	struct ath12k_p2p_noa_arg *arg = data;
>  	struct ath12k_link_vif *arvif;
>  
> -	WARN_ON(!rcu_read_lock_any_held());
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
> +			 "RCU read lock not held");
>  	arvif = &ahvif->deflink;
>  	if (!arvif->is_created || arvif->ar != arg->ar || arvif->vdev_id != arg->vdev_id)
>  		return;


