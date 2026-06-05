Return-Path: <linux-wireless+bounces-37401-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dwi9KPgsImr1TQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37401-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 03:57:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0053E6448DA
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 03:57:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GGmV54wA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BIYR+P8P;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37401-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37401-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC32E3111E21
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 01:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C3C3C1F40;
	Fri,  5 Jun 2026 01:43:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AC3A7F5F
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 01:43:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623827; cv=none; b=VvqGLGMTZfflBqOfg2N3mqQXq/vzm3bOh685E1qe9Q6NMX/7TjSH0EJcf7+2kyi0JM4O+DKPqMN+6ZXrDt2jffHh82J7xhvPSBUDT2JrrrO77KoZQ83nZZxU3615f6oUXk71eOqLkd5f4sqfGx5BED8Kp+y9ZHG8RG8PvXfClT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623827; c=relaxed/simple;
	bh=Seas6Qx+5XcIlCTIv3I02GH0/LYEga4U9BRhZlfP4A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8+VEqleig8ZHnozyJU5ZGUUjaqMBJOKvg5GMLPqKQLkQ/m5plCbijZnNjFzXMwa7vcfvXbMWVej5dCidi+CSswNNSWv3fwU1GOoe8Av6EdT04i1vbEEzHW9Sj0tOev397y0MdVPB8Lze1XwFWDbqUlw3vqbUXXeC3AWaSdW2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GGmV54wA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BIYR+P8P; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Hmq443221049
	for <linux-wireless@vger.kernel.org>; Fri, 5 Jun 2026 01:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SORoca5ybq1ayB/DzjEmBiJC+2QDx4/4tljaa16tMcQ=; b=GGmV54wAIhX8d1Sc
	07cB32HqqgZVCZCA0pXu5sRzs/gYk8NTPpwKyKIddzAu0IDYOoozPetjS4c6IKIu
	nPFAhvZBc882CpJRCdITZPAFNWkXQvz81axVUL67xF2FMah/2YMu28+gkdv5uzzU
	SKe7vVSJqSgDi7rP8Csvem2TpGvMGSpg+Gk5UzpAtcI3yuS10JPw55g9qA57fTJa
	Za+hMhasxchqqF0heQg2TDpiOF+Hj0Fxxm/WnVAv4PqFHxB62uUF2NIqunC5Wzto
	gzPY3QF7TOFWPkIW43Y/JBFUHvF3PARhnWQVW+lL7G3Y7tjJ+sQlGjz9IYsanxYS
	J8nnkQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek95ubhb7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 05 Jun 2026 01:43:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-307625ee07fso690391eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780623816; x=1781228616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SORoca5ybq1ayB/DzjEmBiJC+2QDx4/4tljaa16tMcQ=;
        b=BIYR+P8PZuEcNjiVTbw0f4817tJ4eFaUuodPEkDCpvloPR4veeRrn8HNmuGfOhzJRD
         6KYx0TT1jlOu4A/kjTclhQslh8FukxbWF7Kvr49Zn1PVZPwHe1C1TvaYii8Id7dHZn06
         kzZLsNbZbL6KD+GvWcHxlQyT8mH/l21+MnEHJ00tArD0F93PpKe5Rr9AY48oZv1u/MhC
         dPef5VpVfLW5SrxQnTi7cfIUSdIHjIaMz+o2yRCpHoSTJyll8VljfxLXY2l83JZY73Yx
         msklQdTaUPdduMvn6CexG2770EmauoATnoa2ObdjYx9nQ0ohaMfWiRCIaR8NVuXmdtRz
         uKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780623816; x=1781228616;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SORoca5ybq1ayB/DzjEmBiJC+2QDx4/4tljaa16tMcQ=;
        b=XqbH3u6mi+oqExsJrHbvgMVZK3vM4kPNbr6ax43Z22Ayvfpi7+8019uSlPJ4G4yKve
         dIYu8RV/4bhJ1hfiqJyPQOWar3572oxi0qLdOxO+G+IpeeQGmG6tH1BU3sp2sMCBOwYh
         1lXV9BciwUPd46f+hCLz0E9r/mU8tYbC5lDkjdy2XJHOsryotY+v2QeDO9TbwwXQZevP
         BppS4TYAZM3G40qA3/9SjIhMMjknxZC82dlx5xvnhP80HbtFiKLzpXEtzWZoHnPsJYSa
         LZ0SV6EcMTSXAzMQ2lp60OsSqUX0a2pgFQrLhCJNIOQCd7ksVxCkMY9ABOzco7MvBoSO
         kVNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8M32PZLYVHX6Fmf4mVwU+3VqdsKq8CyVrYldYH5h/JUfe80eM18me8LhZl+nmUtuEc8CTUK49wMHF1Je0S6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnt8kY5x9r6nEtrorWqHcL9nyvJdyO9ttQ2FGIjwTiNrVCbqDZ
	IjGkVsJ274HkDQfCIP1AMiNXcjI8U1SPhh7StzAIQ23V1uwMjXk12ybyX45sVLk0RdmRKBVr6rh
	ZKIbDSJoNW+7E9mSzKeIIcO/ZXs9u6zo7ldBL+bcoxiMe3ImKr/6s92iFSCujbLlLDtkxNA==
X-Gm-Gg: Acq92OHlR8Kzlgb7nqHT9pcbtBls9aPLg7HFnL6i6vyXAdSP/xg/5ksqnfwVUvs8PVg
	uqfyakJpY5s2XQDg3SndVDC8v/220ppV0Ad18WK5b0Nm9z2kxIrBVaEjgwxZkfTX7kRH7BOfCCm
	Ypauc5HaRWI/5h8h/lktLK7k3AaF9UwDSFcMKW0ZCzSmIl1ZudfdMtt8/mE5ZjAS1QRIfHCpmX2
	NnSX7Ncuf7p1gshte+L+6KCyz2gnUPYRjC60Y1yeB1sXPRAjUISbc7NuAUZGEAnI4/ym/XPfxHd
	I0SlaIDpY4a0wRIqPNt8IsQCxTJx6BfHHdGsbENCleh/+VW1CKkJgN8VMwg4lRusWMSSdn0wYGl
	klRGzSEp+1uuD+mIvtmTHXUfo2Yot+s1HTbAwqvtycckreg3N/P4KBozdJS2m782KY5G8J+J1z4
	mx7NuuhkVy289JiQdlSnDDBb5Q
X-Received: by 2002:a05:7300:3250:b0:2f5:5dd3:1fd8 with SMTP id 5a478bee46e88-3077aea9ef1mr725027eec.8.1780623816510;
        Thu, 04 Jun 2026 18:43:36 -0700 (PDT)
X-Received: by 2002:a05:7300:3250:b0:2f5:5dd3:1fd8 with SMTP id 5a478bee46e88-3077aea9ef1mr725017eec.8.1780623815963;
        Thu, 04 Jun 2026 18:43:35 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df77a0asm6971250eec.27.2026.06.04.18.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 18:43:35 -0700 (PDT)
Message-ID: <7c01afaf-5530-4ca2-b2f3-dbe95ddfe6ee@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 18:43:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] wifi: wcn36xx: fix heap overflow from oversized
 firmware HAL response
To: Tristan Madani <tristmd@gmail.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
References: <20260421135018.352774-1-tristmd@gmail.com>
 <20260421135018.352774-2-tristmd@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421135018.352774-2-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=at2CzyZV c=1 sm=1 tr=0 ts=6a2229c9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=J_-Nd1mkAAAA:8 a=Tf1d1ZyckZSre_707FoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAxNCBTYWx0ZWRfX/WO3BaNBpQpn
 dPCcTwxgmIzOO+/ZIi9/nlP0jneB2FW8MHJEAd/8h5yjqmjFNXqFxbuxqJiNyw5st/B+z9snBVs
 Mo4Q9woItm9HX3+ZKLl/7s8aqwtDvf1AoHapPY9/zhDzjTczzz5/lTUONBPGHCnFe9V8cPN9W6n
 qoScbmDSJV7dpm7vuLWXFOoCMAoT5deDq6d+LRgujE89heHYzIlo7Gj1dB/Iv4s9jRQoUe5HLQO
 gE8qOmnbYuWgIE4IOP/QquFnnY5enbTjbC5OZcW3zN2QkQ60QvDWM84LSODalcjfSdIBl9fox5G
 V5YsRzylxmFd0QKjClF3PDNA0/6c1OhooCIyl+bBv4cR151pyxb9i/cwLKsHI7Q521yqpdA4tSG
 as5Z4bN0g4vyklk6PTmP5Rlmcf3+Yjdvl++L6mivDnLx7oxJKMQhV31Son8EUrayGG5D3tjXIxx
 GCeh/BCogkz6NB45H2g==
X-Proofpoint-GUID: ySlcX3st0DAkSMypcND8slhNg2M2S9-I
X-Proofpoint-ORIG-GUID: ySlcX3st0DAkSMypcND8slhNg2M2S9-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050014
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37401-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:loic.poulain@oss.qualcomm.com,m:johannes@sipsolutions.net,m:wcn36xx@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,vger.kernel.org:from_smtp,talencesecurity.com:email,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0053E6448DA

On 4/21/2026 6:50 AM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The firmware response dispatcher copies all synchronous HAL responses
> into the 4096-byte hal_buf without validating the response length. A
> response exceeding WCN36XX_HAL_BUF_SIZE causes a heap buffer overflow
> with firmware-controlled content.
> 
> Add a bounds check on the response length.
> 
> Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch to
>     produce valid index hashes (v2 had post-processed index lines).
> 
> Changes in v2:
>   - No code changes from v1.
> 
>  drivers/net/wireless/ath/wcn36xx/smd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
> index 813553edcb789..f65328329f4f0 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -3293,6 +3293,10 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
>  	case WCN36XX_HAL_EXIT_IMPS_RSP:
>  	case WCN36XX_HAL_UPDATE_CHANNEL_LIST_RSP:
>  	case WCN36XX_HAL_ADD_BCN_FILTER_RSP:
> +		if (len > WCN36XX_HAL_BUF_SIZE) {
> +			wcn36xx_warn("HAL response too large: %d\n", len);
> +			break;
> +		}
>  		memcpy(wcn->hal_buf, buf, len);
>  		wcn->hal_rsp_len = len;
>  		complete(&wcn->hal_rsp_compl);

AI review points out that this logic will bypass the complete() meaning
callers waiting for completion will be stuck (either forever or until the
specified timeout expires). It proposes setting len = 0 instead of break and
having each waiter deal with the issue that wcn->hal_rsp_len is 0.

Further probing gave the observation that there is only one waiter
wcn36xx_smd_send_and_wait() so there isn't a "wait forever" scenario.

It also confirmed that setting wcn->hal_rsp_len = 0 would subsequently be
processed by wcn36xx_smd_rsp_status_check() which would return -EIO due to len
< sizeof(header) + sizeof(status_rsp).

So setting len = 0 and still calling complete() would avoid the timeout and
would cause -EIO vs -ETIME to be propagated.

I can go either way with this since it is not expected to occur.

/jeff

