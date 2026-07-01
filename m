Return-Path: <linux-wireless+bounces-38479-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RxAQEmRdRWoW/AoAu9opvQ
	(envelope-from <linux-wireless+bounces-38479-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 20:33:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDDA6F0A09
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 20:33:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=QK9FE0NO;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=heCoqK1n;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38479-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38479-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D860301739D
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF11733ADB2;
	Wed,  1 Jul 2026 18:32:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F4352022
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 18:32:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930775; cv=none; b=uCzwgDLy7wqR75VJf5Iz5XkpP2QP3YRtvIC9ORL+Z3bvHc47mjrRfGPME28v2l/XhGO337uAMeBI3SiUP2c/7KjMLHRZ95go1tSr/cDEH5X5Q/G0RBaTAefg9jrzbto4P3EQ+WEHMS76Xiex77N+WSoZzBI0MkhLGmzQSrzvBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930775; c=relaxed/simple;
	bh=OBzuYLN6vhVIrxWkGb5vsdXFbSF7PtehuCVIUKaFcQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyThPE3fZCOYmS4bdd/hv+0Fjf6GsszeakGGyDaluku/6jOOpxWQuuA0xSBhl6ai5gChs5NJpznoWMVH3kqd4czyLq6AiTQuKF2HcX4fDDl3G1MrGdWSAMOu65HW1i4o/3KmabiUIFBOcwJj39FPiUwYDhujKC28DPetbUjHyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QK9FE0NO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=heCoqK1n; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GnHQY1709733
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 18:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ga0nOypE+AmSwnDk0QkoIAUCRNWqmLFXP+nFt7njQzA=; b=QK9FE0NOocMaTgn+
	JNxvdDEkKUIFibdkaKl+Y5qExEE1q4ZstBMUXYt2wuNfBsJoXe5TW9U/oqCgZK77
	K2jV3ZxhzU5n86G0HHnkA+SdHHo9EKzhiT1eKNB7G5BSQ0eSlG/eynwOsVxvFsLy
	+Mr2iXZgfqvoBrc8aWcVi330gLNqRFmLjfHtYKn4dVMylJhU98+rzYsOL6ql9sB0
	lD0utDh2CJEJe68aSPciJtgYA18T57BvNGTGy7UnQYZCP0nUNejL5P62KyS8nI2N
	pa/ezrFp3OfSijQ+japedljh4xujryXeYDuYu2B2Y+C1O0XVai71ytIpdnXa6vOd
	+qlH8Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqt9at-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 18:32:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37ca4367860so1715141a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782930772; x=1783535572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ga0nOypE+AmSwnDk0QkoIAUCRNWqmLFXP+nFt7njQzA=;
        b=heCoqK1nabs86Nr4mAEX6enFB2cx1pWGJIG6plsZRTosxYDffJb6ibVvkTe1ytAug8
         8upC4IfBO425XI+L3uGwkev82ZnyY1MtrwtWcheLuoj4YX+pc3KCGcOUC2wTw2V0Z9zf
         5qPDHfqom7UKfmkf/uSNdALCMBD7r3sYXvKQ9bQrb4zeFxTdiemCRJLluUrFufCurP0e
         AwTIGe46zhFB7UzI/qbhKWD5AO5gAcpCE1PlGvZFqoxDXHhsfVwaitSmPWiRKRpV99OZ
         d3zrIRp+S8EwvHalT/VRa21T7rEiPXS6ofPtVl7EyrzvQlT1zcmCNptjfceydIhlANds
         g6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782930772; x=1783535572;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ga0nOypE+AmSwnDk0QkoIAUCRNWqmLFXP+nFt7njQzA=;
        b=Q0W2qgSgnTZmuY687quop8FsLaEYoJQJjqhNphnsNMvlKEqC5V0Csb3OkmxN6wFy45
         QcC52S+qTXBZJbA1kvunoivp2s/hLeyjC0Tgjd0w/bJMLecuhlfvzMEltSSJuw9fuFi3
         3i4Bo1cmUkfsmgg3O+ZidFTUpvPmGscmyQ14SCm4kM8J4TSv54cIJgFem7LnAdPpkkxd
         wLFlQ3EcLM/PmWGEHqv10rI6PYTJnGCq0NwWq7XVa2Nnh5EGiry1vUXj1DOvRyK374h2
         mtB/oOfPXYLlhp96MgUCysSVfhVaIlDq2yX/t0IbjqxToSFSWGgGnkpWnJIV3ZwoeBnV
         xlyA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2jvax9yAbf+H1f4X0x8rpkzVTWMFvIpgx24rW4ySFOlxiebZNkd3HzoS2rOTmIyEnYEp74iEXgCb3KLKFGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNl7nNmUokNPdIkI/gnMemXNw/vOO0ukctQVrlerceBkcE2CQ
	BlVPHCj0KB1DdtHr22rR4yzW51A7StuxiwMbctm8RYJAz1InNoHtLIT4qQIlYGNQ7o6YtYVBF8B
	uCaf+DTlJQJDlwr5Io7VtGbaAIUdKf0seUxCiHSFz2W2HAmYQ2VmXXTYwodL0pFzNJpo0wA==
X-Gm-Gg: AfdE7cmofulpZvnp/lJphilmREwq5O6xAZlAOTX6tVCpVmPTAhSe7xPrw6N6H/5DZYe
	nolexzKE5SdDR8sA+NRJd3v7EhbA8Xaa7WDfQSyahLNJXRlWmRSa1QWhRkoPaqH9sv7fpkLkt7A
	ucDwWg26XFAU+S8yLsYBgLJ1fzL0JygYKp7D58nAOA8Cx47FtId7lzuqgOcs6ldgAzzTadM7WtG
	LP8YkBTpPmlsrhU5MFMuNd6GQFTlEvDYaHRehoGlrXieu6sW9uwtUBvP1sqozjPwnFrlvbJ47QL
	kdtBTqMb/SnUcQpRCEdtX26002Baj4iseD3bzpc2A9K1SQPrKXX+xeBEWfwq2pqOMjVdWzbxx3m
	SjYrbenEqImyP6WO8capkPcvDafVjYUuhBXF/2FsUnyWO0TkR5Oif6wRNMrO2MapR2rE8/ZQ=
X-Received: by 2002:a17:90b:2c86:b0:37f:ef1f:5977 with SMTP id 98e67ed59e1d1-38069c56fb4mr6136233a91.14.1782930772272;
        Wed, 01 Jul 2026 11:32:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2c86:b0:37f:ef1f:5977 with SMTP id 98e67ed59e1d1-38069c56fb4mr6136195a91.14.1782930771779;
        Wed, 01 Jul 2026 11:32:51 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84405sm426784eec.17.2026.07.01.11.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:32:51 -0700 (PDT)
Message-ID: <6ead2507-2306-452c-b08a-96b13b075e14@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 11:32:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] wifi: carl9170: fix buffer overflow in rx_stream
 failover path
To: Tristan Madani <tristmd@gmail.com>,
        Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
References: <20260421134929.325662-1-tristmd@gmail.com>
 <20260421134929.325662-4-tristmd@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421134929.325662-4-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9yz63eavIbH1ipWHBusxNHFT793GepLg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5NyBTYWx0ZWRfX+i0vBfp6sSSr
 XhFrqYtypyEaeF1U9Uxe2v+oyzrPvbL6xzV+d6f5K2CtpoRf6iuuwlLz0j05W5abb1ktok+Ee2b
 3i44rwaQQZv4o0RDYiZZAGZdxC9gAFQ=
X-Proofpoint-ORIG-GUID: 9yz63eavIbH1ipWHBusxNHFT793GepLg
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a455d55 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=J_-Nd1mkAAAA:8 a=4kDpEtFwccDkzV5kScQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5NyBTYWx0ZWRfX/kxJxeOeA2Ld
 JAdmPH2ORwmUk1GTwG7TM/l/LzlVRrsYf/QFs3rWUZxpH5Qw+wbFduWZNjQ9OmZ96eZG0dJELUe
 Vhpg5ay3ailzvJ+uMuRM8OC5fk4gP1knYVqHSJ/KFxRHUEGq87CzCIBB/SB33KDjFKUb5ma4bd7
 IHNVrs8FR3RHISSIbHcOUBPQ/eBmtSj1JpwPB63S1/qHKzfh/UujlJbrRvvtmT4M2xnZD2uae/M
 M/n7SSzld+nbcJ4WASfa28TDpcibFiw9hxuCN2q8ENcu6oygxBXmNjauvjigILmfOab5tFlbO1a
 QTwzdLKFMo1eYlD23MMtL6he/tv+h2hQDPXt74RWPxRsDabo4NcSJSTVwu2XiQzLp46mi56qVOH
 X13Q7rB8DG+5v77yXTDDov5XlMg/GLp6kP0BrHeiAq6apB4rycVGP4z/At0qN7Mtgj3NyOPh2fw
 7zNNhQJLhf0UHnG3kRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010197
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38479-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,googlemail.com];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:chunkeey@googlemail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,m:chunkeey@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,vger.kernel.org:from_smtp,talencesecurity.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDDDA6F0A09

On 4/21/2026 6:49 AM, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The failover continuation in carl9170_rx_stream() copies the full tlen
> from the second USB transfer instead of capping at rx_failover_missing
> bytes. When both transfers are near maximum size, the total exceeds the
> 65535-byte failover SKB, triggering skb_over_panic.
> 
> Limit the copy size to the missing byte count.
> 
> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch.
> 
> Changes in v2:
>   - Use min_t() instead of separate if-check, per Christian Lamparter.
> 
>  drivers/net/wireless/ath/carl9170/rx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index f6855efc05c0f..ccadc46385240 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -918,7 +918,9 @@ static void carl9170_rx_stream(struct ar9170 *ar, void *buf, unsigned int len)
>  				}
>  			}
>  
> -			skb_put_data(ar->rx_failover, tbuf, tlen);
> +			skb_put_data(ar->rx_failover, tbuf,
> +			     min_t(unsigned int, tlen,

checkpatch complains:
CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis

no need to repost for this, I can fix when applying

> +				   ar->rx_failover_missing));
>  			ar->rx_failover_missing -= tlen;
>  
>  			if (ar->rx_failover_missing <= 0) {


