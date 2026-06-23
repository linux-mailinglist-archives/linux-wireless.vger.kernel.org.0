Return-Path: <linux-wireless+bounces-38000-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ErVMMpg5OmoR4QcAu9opvQ
	(envelope-from <linux-wireless+bounces-38000-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 09:45:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B56BF6B4EDB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 09:45:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Um/hpA2X";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hXyO4hVK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38000-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38000-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D0B730055F9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E783C5DDB;
	Tue, 23 Jun 2026 07:45:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F73C584B
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 07:45:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200723; cv=none; b=Ticu9o4sUOxByKHJbqQ3ip16oBARqNpdcFYdB5VVN4XPHV2NMxx8Z1mDJOyjglMitbyFYlReCRvE1/YHxCIWW1FmlJ/VDSWfmIiSjwRyl64wNAIpi859tYh3r6VODiGy5gdXTl0G2MJbV78Jq0DLJb4jAKhF9bHfdqlZNwpbVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200723; c=relaxed/simple;
	bh=GRvgWLUvKNb4PI05oas0E7Wn4/28eX745Ht+uASHoXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giLCOSa28n6vxgM7kHNNqDv5ZP2oCjiR2HmSaAyEsxAXSU8cPlp2rdLu4SCIjujvRObVJ+EvdpVH2+OI3zRhp3HljC91ZCxcV7ha0BB75F9eXaEZpUqG15wXrJ/izHlOl3ryJctwGYm+XcUM6eTxHu9ne4vgMB66UNav0suhHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Um/hpA2X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hXyO4hVK; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cWrX3338321
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 07:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5k2CxQc0cgPN+CzLjN80nwmryJtF+WIcCnZt3WnvCqg=; b=Um/hpA2XAdXEaWsB
	aFulvItPCySl36Iiidtab+5aQkeaNu0koLW69vOtGdIdTj2sJZftB+OpmwXKNLhA
	3edG2BJRPj/uxU8K51TAh+eMbIVnXZvi97psQwRZXqIaDhMr/VNCMbDKfnAjEkGx
	yrtKHxfawhkGeEDItEmw1VP8QPzaMRJyEM1LrboMWog3k8D6kHZxg9a1v5yFjhtm
	W4cGH8AutUmnW7C+1aOjIdUgclv5fgy+xqqbvNdqieOhIsYQnTv9Kwq2U6lygP8g
	i5qggdRcaUEWdUeLbLTYy1nonkJWGHFyHMJ7Vl/7RmbtH94uMmOG5bQyYIicHWHR
	viI55A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjh5db-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 07:45:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36b982ec338so5880786a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782200720; x=1782805520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5k2CxQc0cgPN+CzLjN80nwmryJtF+WIcCnZt3WnvCqg=;
        b=hXyO4hVKPI8Wihk9A5vPHmOldV0BsmtvGOcXHzYDDvmKJX4EsE+RdZy+3MXH2p3wDH
         mkEvghrv5DDX4bgbFdQX04rYSCQwyEARZfzbblTWRY7WxbA8wsdPKO8JypFe6gbovmtl
         4W+vEmiU4W6URRXG/JoZVM3AI8LYL16g5hFcft7v+6kORbVDmG4nXsoM4onb6v7bHiI4
         TqW+UhO5T2su8j1hgUpgI4PoQDtFBLyp2YBskUU98FI9f99RvIBJWy21kY47wAouTpcy
         P/yQuUmtnfu/y6r51iZqefoFx+4sbWzn2zWG+O77hHVDFRg/nWcXTOKFJJSs/KN1lR0X
         OXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782200720; x=1782805520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k2CxQc0cgPN+CzLjN80nwmryJtF+WIcCnZt3WnvCqg=;
        b=RSZtrTHb+hSOjx5kV73iSiYyYtGZRx1iQAWrSqCm0YyBsKntZCF+MkBScplLEjfnuc
         Pufu1jX3gWARH3XYjvLlTmiZDstePfjKZRCtL+wfq0gzgTcsV23L0PGgZ/vUWzEQ4WJ6
         brUEKvH/DakkW10bNMVkPgekZj9Fm4fxl5LDS8nbX+cni9gch2nUt0IhtGwuOOsyDnzB
         VXu18hdXuVE5AdnVeu86XaTX69yL2heR+Jhd1zcU7y28yzu4pt6qpEgmBHsqV5DyigRO
         evfRVCeJnk8KoO8YuXJSH889zL2Xo8LdK/YNCw0Pqh8zV6vigj8ap1z0PjChxXBPTeOg
         NVhQ==
X-Gm-Message-State: AOJu0YxBPegQA44wD8IXsLRYFwVeyGr8NBhYQv5UGPwoPExwd9o93F2p
	pP02U85pi9USVyr2rbH0E8/TIAn4jnfRwPIzlsuR/tUrZbLuMKwd2tVXhElBE6Bp5az1yrVhPSK
	EGDrcsHFrdlhBAHQX584y02uSwg+jsUyRSIJhVObmYYHXFxHL8z9rY0F/Zlj5XSUQtIENsITm/k
	38kg==
X-Gm-Gg: AfdE7ckOPkwpmw31ijmbyLd14wgCHRZcYf7qc2xovVx92Wq3eLyLmQrCZSLaMNvEow/
	uQDU4PTEi4VxlVhiDyaLr/L1OgcBjeMNdlx8MPDGSMijdVujFG86YWmEn1LwTSuJcmF9DTwsnLt
	ZotxsUb+cMHPqeK5DHRBGxMaVmmFZJNMnGXzGZe77tMdn1IMa6CGQ4dnzqdth7Wq7t3KCqHvlBA
	feYy9BlrsdyCzUtVGO/Zlw3Gc76ZgCWGntKF30R3HIvVJeBDBiApylK7IHseP/BdOE0rd1WiWWl
	RJh3zdd5NpvNWGpp0XWOXzEyFLRHfDYjXoLCiegjw1EHelR3lI9dIyC1N8mSFcmT6ugs0Q9XoB1
	/69b9vhMTnRvDKvoSSxwQ4tfaZ386rS5DAXtVBDxLSFWU1CaPKu1JvLSZOdFQ
X-Received: by 2002:a17:903:1d2:b0:2c0:d2a1:70b9 with SMTP id d9443c01a7336-2c7186010fbmr197447015ad.0.1782200720550;
        Tue, 23 Jun 2026 00:45:20 -0700 (PDT)
X-Received: by 2002:a17:903:1d2:b0:2c0:d2a1:70b9 with SMTP id d9443c01a7336-2c7186010fbmr197446765ad.0.1782200719984;
        Tue, 23 Jun 2026 00:45:19 -0700 (PDT)
Received: from [10.137.71.130] ([106.198.36.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436ff46asm102538555ad.35.2026.06.23.00.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 00:45:19 -0700 (PDT)
Message-ID: <be9cba58-e23d-4e39-94bb-343f22cee6a3@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 13:15:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] wifi: ath6kl: fix OOB read from firmware IE
 lengths in connect event
To: Tristan Madani <tristmd@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
References: <20260421135009.348084-1-tristmd@gmail.com>
 <20260421135009.348084-3-tristmd@gmail.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260421135009.348084-3-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA2MSBTYWx0ZWRfX8N+tsfT9rh5Q
 Eh4TC2nRzZjlw34F0ITNU5nAUyd8W2+Sz37cdU51f43tMqjv14cZmP8vRWfCBiYBs0i7r1oHfX3
 oUWKRDsV9KuuEnkEPpFtsO/PHf1rVRs+UYGZjTQBJvtqfKcNWYUkAMx3HBqYL039kEE/6rHfX/z
 tPFrM6V/g64o1Eyu6fWUQ0HGdMOTZvteR3FmgDg7YATkKFYWnRfLsJTevhSg70i1zRR99IlpDbK
 /I0bnpi0/jZajgr59mmv/CSTQel1985oEtvwoNn/UUmVU0ud34DDe/rn6sLxX11hBj+sv2UwOoI
 Lce/LPHeA4FSefi4RBKRxl6te3oEaKJTFmR8NkMrwI482ZBDSetXZHAX4a3cASqsSM8jWBU99fd
 HY9nRFphwFakygd0Z1AxIGcqWj5ydmAt+0UPp/bB+b4y6spaiqCNwzjd9hx0c8OV+TyqmNTxUE3
 wi5EztPJrVRgy+f8U1A==
X-Proofpoint-GUID: WpTvJFrdEgsR_e2k5tByq-SSDu4XcmTl
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3a3991 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6/2MXK9rXRWb21GBy9lArw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=J_-Nd1mkAAAA:8 a=EUspDBNiAAAA:8 a=rS5lWQ6Nk58PToP3HakA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA2MSBTYWx0ZWRfXxYVnWgYOswaO
 qAA0Pb9K86P219PAt+Dbz/caOJect1jevszPfeQen604cN0HZ9y2UgIJ8F96U/9frk2T3pez98K
 upGC3JgUzYNqOVk8gifGNzl9WLLLLK8=
X-Proofpoint-ORIG-GUID: WpTvJFrdEgsR_e2k5tByq-SSDu4XcmTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38000-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,talencesecurity.com:email,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: B56BF6B4EDB



On 4/21/2026 7:20 PM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The firmware-controlled beacon_ie_len, assoc_req_len, and assoc_resp_len
> fields in ath6kl_wmi_connect_event_rx() are not validated against the
> buffer length. Their sum (up to 765) can exceed the actual WMI event
> data, causing out-of-bounds reads during IE parsing and state corruption
> of wmi->is_wmm_enabled.
> 
> Add a check that the total IE length fits within the buffer.
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
>   drivers/net/wireless/ath/ath6kl/wmi.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
> index 72611a2ceb9d8..1cafbac2938fe 100644
> --- a/drivers/net/wireless/ath/ath6kl/wmi.c
> +++ b/drivers/net/wireless/ath/ath6kl/wmi.c
> @@ -862,6 +862,14 @@ static int ath6kl_wmi_connect_event_rx(struct wmi *wmi, u8 *datap, int len,
>   
>   	ev = (struct wmi_connect_event *) datap;
>   
> +	if (len < sizeof(*ev) + ev->beacon_ie_len +
> +	    ev->assoc_req_len + ev->assoc_resp_len) {
> +		ath6kl_dbg(ATH6KL_DBG_WMI,
> +			   "connect event: IE lengths %u+%u+%u exceed buffer %d\n",
> +			   ev->beacon_ie_len, ev->assoc_req_len,
> +			   ev->assoc_resp_len, len);
> +		return -EINVAL;
> +	}
>   	if (vif->nw_type == AP_NETWORK) {
>   		/* AP mode start/STA connected event */
>   		struct net_device *dev = vif->ndev;


Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

