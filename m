Return-Path: <linux-wireless+bounces-31280-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO0oHwY7emlB4wEAu9opvQ
	(envelope-from <linux-wireless+bounces-31280-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 17:36:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0885A5DFC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 17:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43985300679D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93EF314A8E;
	Wed, 28 Jan 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nR4MLXs8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c8TyZsut"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390A314B9A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618176; cv=none; b=CPn4ZJ1rW0V8lidszwKWWaVyey+FCgZO9E2GfbIgs65sA92mqShlnn61PlNoXXSzSfrz1KMbAW22ZrbU9MvRX8NATElucaGiXwd9F3RkbZsaL883fu4fNB6eoZP5wxx6EhRycoegp6Kwj8mEcRiMhaDCc5Ppd245pCifyrQDJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618176; c=relaxed/simple;
	bh=8nIVMvGqv71MPrM8B1vjY5p7Dm8QTBBr6/QPYFxGtcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGX5TVweU3Olul+oyu18H459WOKr/0YceWnitxoVFtbRvpEEC+cakpKDD4A/DAz+VQAWLe6epANsY/B7aNzikuWKNtMHPp/j87u7ga0PFZ+ckDYvlMfQ9BXH3nMHZ2rA5WkDfTalhH2kzvOXKFD+vGCYTxYBOJsgajBDGTLJo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nR4MLXs8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c8TyZsut; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SFWhID3442499
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 16:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	726DQBzhA/EmumloQR+FME9Z+eEVaDFRgktcZxX0gsE=; b=nR4MLXs8PnRpPmqU
	nbYVgBIRd5rdwk47xM2Ln2D8SeCoWZIwIcQdDJ5vWtu06cB/OMNSeqO3u8GCjNsq
	g2WreKlURxjauc97Sqy5/DeSXo7Ie7+b32uQyhNuVCXmp4BwCkw1JbSvRe246nnP
	K20gpQoHHn4/OjZ6rWY472q6ajBuyMP9lDpNhhOphsE0o2+XRUUlbHn8TmHud6Y8
	Kt/81YatcCvS7Ars82nvbYGoLCH5QM0yNBpi7l6+NQqHXYGmUef/FG0NX/wg2fjy
	AYpHlGAJlkgXtUpcX3H1nyv5VHP01ZRoceaj8TEBHTdTvoBQaNSLNit9VaWPeDuc
	F6jZeQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byanajjxs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 16:36:14 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1247bb4db53so9505764c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 08:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769618174; x=1770222974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=726DQBzhA/EmumloQR+FME9Z+eEVaDFRgktcZxX0gsE=;
        b=c8TyZsutIECowB+gpIAt+2wWtilVsTAYhMW3BWT2sfG4ncxKxuL743sxrBk6TcFII8
         LnCrhHlDDgJyieuRxrSvDxZApbcfbFp60+6mKsvB0onQyydqzQ6FcsC2oqMZcdbi5LLW
         5rxFFoGaabqW0Bno30iftGC5sGMEQ6yZ+uJYsY9P7+f/my5HVUCfBoEZb3jzAP/KI+hn
         oVjCESTxfXj3STuZsnxg8MtsP5X0pTqELnXYO8+JkA56SHAkTG6Z6fJYbhuGMBfif4Dx
         y+Cw7PeHsyvgGZMITdfeXzoRIgmzHpiqszCgpGXKzvxGmBpbafY+2N1qsPa6DLZ1DFIe
         qWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769618174; x=1770222974;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=726DQBzhA/EmumloQR+FME9Z+eEVaDFRgktcZxX0gsE=;
        b=Mx3pt4pq09GrImacrzL2/daoDUmC80nWjVEU/94u8p6IwqYDj9VtLOGrDECeYxJWo6
         mlJk7yH88Pjr7UwXTwROI06rFtmliEXg43T4hlX/7J8nCWAAA7JRpoFZeMpxIVRVSyrI
         CwIUKLWcIXBg7P22RzUGyNZao99vB2N4bRFp3t/S4kU6h43/fqPadyh86mGKhlH18IOI
         pSUUZTxUbxQHdXyUkZiLf4Eb38xkyh9RAc2FQe6EdEXCyTrVwh9yyZToaCFyxtF5Pl94
         OcfwjOomS7RrzbMMA00XWNKGIeL9gjPdbDZXaJ6m0rpR3pmCm7I55dwQPf0Kwb/Z0UgU
         d7Lg==
X-Gm-Message-State: AOJu0YzBw8/UHBzz4P8em3djFPikehZagnKrwG5jBAzcfvjjnRnOiuff
	fxozNzg6R2ph4etD0aUZVNd/C72oVr9JKWz3jW6TXf9FDngrFBxyKqePOmNbcu8oZsxJ+K9wwdW
	m5tH9Sce9cREN9GzmvLzdA9GtLV8WA9nPExpXFFrok40TifvzhuJp1jW2aZYVCcQ4n/QNTQ==
X-Gm-Gg: AZuq6aI4XzVKNf/EMr0ruJkg0qiyS8VKqXgRi+btIq3QroVHy7GijQyz/jygXO5n9Zq
	8Mn7koczX7rmUGgz8HVkJGOkoXJ3JmdxJk58olC3kLHtvBlPYm4dZzSpckNbw98+vfcT3LNCvGN
	v0Co+ENy014z7i1p2hCZRth9G0NCKx2LtV8Q4TMxnA49lrEU0jaJTkBgi6TY6wDPr3r7BmLM5Q+
	EpWS3v1H2uv4U2hgFIeb+maIAWH8L+Fp3pgs06xWuMq5RHBbX6MebVo+fxzasCDwmMYbqEf8VgA
	dFhm/5yrVVuBx9ZUXEmDzeJnIZY0Y8cPZ7FlkNuofduQP1lJCVVJtsvXrY9mZxDtzA6uqfFXN04
	ADwE2PJMrg1EKdBjE3lE3i0PI2P/u77+ioPdR1THGePHGYid0gyZhjoHCOc5980RCVSP4qw==
X-Received: by 2002:a05:7022:128c:b0:123:361e:e87c with SMTP id a92af1059eb24-124a0098f90mr3452506c88.11.1769618174050;
        Wed, 28 Jan 2026 08:36:14 -0800 (PST)
X-Received: by 2002:a05:7022:128c:b0:123:361e:e87c with SMTP id a92af1059eb24-124a0098f90mr3452478c88.11.1769618173391;
        Wed, 28 Jan 2026 08:36:13 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16eab72sm3166931eec.8.2026.01.28.08.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 08:36:12 -0800 (PST)
Message-ID: <2bb1ebcf-1874-4b65-b4c6-30489747c594@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 08:36:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: fix lock protection in
 ath10k_wmi_event_peer_sta_ps_state_chg()
To: Ziyi Guo <n7l8m4@u.northwestern.edu>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260123175611.767731-1-n7l8m4@u.northwestern.edu>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260123175611.767731-1-n7l8m4@u.northwestern.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OE-ew66Cq6JbRVLIZrDNqitOqlq4ubIB
X-Proofpoint-ORIG-GUID: OE-ew66Cq6JbRVLIZrDNqitOqlq4ubIB
X-Authority-Analysis: v=2.4 cv=N58k1m9B c=1 sm=1 tr=0 ts=697a3afe cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=27jATeYspuGomxVIXMEA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEzNiBTYWx0ZWRfX9CC8Zi3ZzLpu
 GgreKGq6k1GVvu6xyc8Wx6GOHklmlD9wFFZfDU7aMw7UrTnk2ruRVEh0go7HsekBraT2sDkKw3b
 AO6Ge+JHVYyK022xOpGGfVijzxGJAx6/MT27FtTGstFj3SRs1JZfzTzhBJUlJxQJZiRXl15Wl5J
 0hwMdkLO2o8ABJy4AM9JYXfezQuzVftTlrYpiENrLR+XkGS9orQBl1w/RwF/htcy4sXw2Grz0FI
 7k9oXA0BBynnpROGvJdcmkSO6brkkXpx7VuX6HyO7w/JKXXEpak8MWrNEsS/NsfeEzvs52I5NyD
 FTiGvyFIJC7ArvAsJBwZURrlt4z4yCccgGTdnrlVZiW7JjDfqVmz2c6LUZftpqwuvfYh6AXoJ/t
 7emFav/edCeyu//Lp4sySCz/NBQYvZHRBXvJNMIg7tgxyqV6zInUpwBPUMyHwtOv7ZXkqhbvjhZ
 Sqh1GhR8l4XQMby+a7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31280-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D0885A5DFC
X-Rspamd-Action: no action

On 1/23/2026 9:56 AM, Ziyi Guo wrote:
> ath10k_wmi_event_peer_sta_ps_state_chg() uses lockdep_assert_held() to
> assert that ar->data_lock should be held by the caller, but neither
> ath10k_wmi_10_2_op_rx() nor ath10k_wmi_10_4_op_rx() acquire this lock
> before calling this function.
> 
> The field arsta->peer_ps_state is documented as protected by
> ar->data_lock in core.h, and other accessors (ath10k_peer_ps_state_disable,
> ath10k_dbg_sta_read_peer_ps_state) properly acquire this lock.
> 
> Add spin_lock_bh()/spin_unlock_bh() around the peer_ps_state update,
> and remove the lockdep_assert_held() to be aligned with new locking,
> following the pattern used by other WMI event handlers in the driver.
> 
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
> v2:
>  - Remove lockdep_assert_held() as suggested, since
>    we are now taking the lock internally.
> 
>  drivers/net/wireless/ath/ath10k/wmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index b4aad6604d6d..061a2fa8f00f 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -5289,7 +5289,6 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
>  	struct ath10k_sta *arsta;
>  	u8 peer_addr[ETH_ALEN];
>  
> -	lockdep_assert_held(&ar->data_lock);

note that removing just this line results in an ath10k-check warning:
drivers/net/wireless/ath/ath10k/wmi.c:5292: Please don't use multiple blank lines

I'll also remove one of the blank lines when I apply this patch

>  
>  	ev = (struct wmi_peer_sta_ps_state_chg_event *)skb->data;
>  	ether_addr_copy(peer_addr, ev->peer_macaddr.addr);
> @@ -5305,7 +5304,9 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
>  	}
>  
>  	arsta = (struct ath10k_sta *)sta->drv_priv;
> +	spin_lock_bh(&ar->data_lock);
>  	arsta->peer_ps_state = __le32_to_cpu(ev->peer_ps_state);
> +	spin_unlock_bh(&ar->data_lock);
>  
>  exit:
>  	rcu_read_unlock();


