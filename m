Return-Path: <linux-wireless+bounces-37999-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H89AC5IxOmoa3wcAu9opvQ
	(envelope-from <linux-wireless+bounces-37999-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 09:11:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD606B4BAA
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 09:11:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HwoOuOch;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="c0A0v/J8";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37999-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37999-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E2E43009E29
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 07:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0603B3BEF;
	Tue, 23 Jun 2026 07:11:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55B3B3BE2
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 07:11:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198666; cv=none; b=pKF9g3r+zt6Jj9q/caJtqr5+nBYUCqGn3+3x1WIU7XmXkyPYnDLosaH26uGnyg3HeXRL+JzGLclfnhlZWf+EaX4lArmnZdaxRz6K3BkmOVbSzAlHghd1PFoGlbtqtwcbj15HIz2vh0rtvMqevev2UqdeXWJ8do5Q8sXreNCoQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198666; c=relaxed/simple;
	bh=ENKNN70K35I+XiGk5B0w6h1fPi/USSd++hCbSNKdKt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilvqOrrS4CONhKZZNW23dej7NyfyQObb76eqVtr+uN54fSxsf5Zt47vURY+kx7OKvZDZGO9H0fMBJgUMv5OC8EAw0ssSZxkMvS4viqF4HQYnmKq80IkoDL4oboQ1XJk+XTbHZNs05X9d4+sDoe+OMNDkzOqUddyOLTH7a9bFWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HwoOuOch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c0A0v/J8; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6crVn3547402
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 07:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tqQEqsHHunLFUCM1PpOOmueTw23PhpFJabrs7PJLUH4=; b=HwoOuOch+wLomMqZ
	L8Pz2jDwxGUdAkY5wLbwXjsMIfrwM3W7Yda5ABfYroE2J9W84aoHTzjLQNbE0B1h
	8L9vj9ND5zhO/jcDuzgo6rtwub9J2lx8KJtsllcM2Vf72UtZ0pMs7VfWSS/Nqz7v
	MOyY81aWQgs1Gc241mdHR9EK1IHO+yZIJ8ZKnk6KPSYsHd1GHkXsxWQCnOv2C+sY
	+3xgHcm9xBX69V/7PfFe1ENJ1hWb6oIGJ6bQi/8OybxMMVkS2+W8TKlavEyJ1PJ2
	Czj0F2vulZ34xzALqazvABFxA9exL4xgD5ad7HCRsmHq+Yg7mGUlPZp8hhh6Agq0
	q8eF0A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3ebbx89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 07:11:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c6c431a04fso52929005ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782198664; x=1782803464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqQEqsHHunLFUCM1PpOOmueTw23PhpFJabrs7PJLUH4=;
        b=c0A0v/J8GopIjc8s2Tuq+e1vfo6fzrtb6FSunZ43CCY9GxlFTxrLK2R78Fz8+rq2Mc
         US3fgAdxvQIxns7DzNiVQPCpWcER9lrO7098378JbbV61qOqIgXweVaXpqH/iThvcdz3
         u1v/QnH3UpoboVaPOCh7zgYhHxupQz0/1Zi7oJMLyvWfkjeSZy52wyDtW8Fdpbe6cAcK
         6q9Xce43FNPjChogFoeox1x4T/JgQ+tEiWyKnOEw7YOri7ivuG3qjceAgYFsBRp51rbk
         Q8VAZ9PHA/7pkpQMYx7N48ntECK4v7kHg4V/mrpcdRvC6WxDiiCO88tvZiSBuHnBnq7O
         +yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782198664; x=1782803464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqQEqsHHunLFUCM1PpOOmueTw23PhpFJabrs7PJLUH4=;
        b=plc+MMGZo7T2tNif+7Adq9LUaIw2aO2xeuqaXX2UNQ0c94lJhICbJqliktSPHm09Cj
         4w0Z4k/2FYo9yyc9ATQPUDwi/5tPw8CksqXY5r6Nqw+oMvvvemAZX/+t1piMSYzFcFuI
         6LnxRGlzQjum1ySSQkC5KPi2hbMzD+ukRNRv8LOZH04ZfKzdarDL/ecLJ0irrNa/19Gg
         Xi8wjJn/A+Lz2ncoKFana8J10oeCiA3VuPqb5GE6aV1n2lpEGc225Czb/p8mQxQf+Orv
         i+tQveeWy6JSwSjliOQGtfJBsup3OSa31itquxTnzZ1WN1tik458WuRfXsibaMk4EPu/
         h0+g==
X-Gm-Message-State: AOJu0Yx7Q14ynPFg3S+TMSFQ+5DhoeRMmnTLR/2y6VGWN4Hnp3fXPeZ9
	9XhwwuaVHaIU6D8E82hw65O+8MJ9Pt9vUS/KMs0s3CfXoVc/MqH8I/Frl+xPScLIO6SZl+ZvBWE
	taNb0oF0MJprSXU2OKvpz1Zv+4X4G5C1ve0dJmOLXvvB/3IeLNRYunhWsiM30+ypIaxJQxQ==
X-Gm-Gg: AfdE7cl42tgHUHfw32lgAtFsPa6HrnfWgmpmFb7mgzLXMa0hLvVYRdPZyvbA7d4bD02
	Ch2VwNxIfHhYP8+uHC5xC/OFNSA8g5KV6qrRpJao68m9KS2V5W1ijGmZQ43e3E+r7QsDxPmVIfw
	0uKneU2XKWqqDU+ola1cklxJLeBJrjKhZI/w5y1sLRF64uY3AicUSuUnNep0VjU4kSeFfLZAN9L
	oh6xT9kqrWkDk054NHkbLZb8ifv5wBioByJKtNpPrxO2ap/Z7YnFnq2w54W9QTpZb8YubLUFgp/
	b1VnqHnMKscIBp5Ip3Tlq7ZSXrcfroCOCyFM0xpFfiwTI7hWriHk66apsSbq74aeKuuzxFmmmNk
	E1qyB1LyMuDznv7piW4aOwd74pRWfRFr3RR7MFQHSE64Av7JLSeYYSnWv/fat
X-Received: by 2002:a17:902:fc46:b0:2c6:b768:a7de with SMTP id d9443c01a7336-2c7422c36f0mr145281515ad.8.1782198663625;
        Tue, 23 Jun 2026 00:11:03 -0700 (PDT)
X-Received: by 2002:a17:902:fc46:b0:2c6:b768:a7de with SMTP id d9443c01a7336-2c7422c36f0mr145281215ad.8.1782198663195;
        Tue, 23 Jun 2026 00:11:03 -0700 (PDT)
Received: from [10.137.71.130] ([106.198.36.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm98079155ad.70.2026.06.23.00.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 00:11:02 -0700 (PDT)
Message-ID: <08b24438-9d5e-4418-8297-8e7f573349f4@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:40:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] wifi: ath6kl: fix OOB access from firmware ADDBA
 window size
To: Tristan Madani <tristmd@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
References: <20260421135009.348084-1-tristmd@gmail.com>
 <20260421135009.348084-2-tristmd@gmail.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260421135009.348084-2-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1NSBTYWx0ZWRfX+B5C5W9rbi8F
 pqsxheNMp6y82l7fFVt+4Gu4Iq+NC43Dj15pED2zxFl7gVZIRc+RB0GmGLPqOgtkDQ0Nhqa6pPE
 je3iKFLh8xlrt6pkWcP3m1nekCADlwI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1NSBTYWx0ZWRfX5yEQk++6Tn4L
 LbHjgpMIybFQTJdj1X0HyOBajJQNuQoqzWA2IN1HDWHlZGszfsbliT/3mxPI+Qmoe1fVjG7b5a0
 CoWI6PBq4By2AGyEgRVWHT+xoQw/bGt35nwfDAJMAdZuwTy/CEUOaHuXnSK0DKYrF8MUOL1p2uC
 +USuE1ln5cOwPoCMeSCZOUMxvg3wxNaKaQlei5nSDWLmgT8EoT5ZyeXXLXrhlR9SUMrHh1oip9m
 GhTigblkCPap4wletjnYewNwXNO18Qt0boIju2oq6TXjw6t9/VPoi/upqvlRNq/8hzkTfrmGcfd
 ZXjOOTSfz2jz5TvF1QKYirybo//9DUThlzH9nqkmzYOtX7P6ET2laNLV39QE5qr+Rw6Kzsf6xnz
 /h1R7axjK113tT1cYpnegk+ESXvl2Cw6Gdjp+BivT08PmjTqP891MjrXXrjLi3WmxgaZ46faq5g
 0gEiGDXn2WZtyZpz5gw==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a3a3188 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6/2MXK9rXRWb21GBy9lArw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=J_-Nd1mkAAAA:8 a=6hp2VIgpqHygfFtxsjAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: SA-j_bz2F2ILSGvagVasHhYnsJ0R5txm
X-Proofpoint-ORIG-GUID: SA-j_bz2F2ILSGvagVasHhYnsJ0R5txm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37999-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,talencesecurity.com:email,vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAD606B4BAA



On 4/21/2026 7:20 PM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> aggr_recv_addba_req_evt() logs a debug message when the firmware-supplied
> win_sz is outside [AGGR_WIN_SZ_MIN, AGGR_WIN_SZ_MAX] but does not
> return. The out-of-range win_sz is then used in TID_WINDOW_SZ() to
> compute a kzalloc size and stored in rxtid->hold_q_sz, leading to
> zero-size or overflowed allocations and subsequent OOB access.
> 
> Return early when win_sz is out of the valid range.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v3:
>    - Regenerated from wireless-next with proper git format-patch to
>      produce valid index hashes (v2 had post-processed index lines).
> 
> Changes in v2:
>    - No code changes from v1.
> 
>   drivers/net/wireless/ath/ath6kl/txrx.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
> index 97fdac7237e26..5575b535f94cd 100644
> --- a/drivers/net/wireless/ath/ath6kl/txrx.c
> +++ b/drivers/net/wireless/ath/ath6kl/txrx.c
> @@ -1723,9 +1723,11 @@ void aggr_recv_addba_req_evt(struct ath6kl_vif *vif, u8 tid_mux, u16 seq_no,
>   
>   	rxtid = &aggr_conn->rx_tid[tid];
>   
> -	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX)
> +	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX) {
>   		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
>   			   __func__, win_sz, tid);
> +		return;
> +	}

I think, before returning, it makes sense to clean up the previously active session also 
upon an event with unexpected aggregation window size for the tid.

Vasanth

