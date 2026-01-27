Return-Path: <linux-wireless+bounces-31247-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL2oGbNMeWmzwQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31247-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 00:39:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BCB9B721
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 00:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2A56300749A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 23:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09CE20C023;
	Tue, 27 Jan 2026 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iynGJEFQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EzdzNxje"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2FA21CC44
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557167; cv=none; b=VirkEiNlBqfoJstSmUXBFn38KA6fgjqGzORHXTBX9CSRqIdq/JztQ+wKuC4JkwSh/fsARPbDLUVRLhpmG6fM4LmL7MlSoGf8IUE4hf229wghUaqkLN+pgPQDwQpEgYiL5vik1LmYrWU3qoohk7t+cSH3glilfR2hP+yF9DTrDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557167; c=relaxed/simple;
	bh=1i1SS736SCY6kLatwqQvpicgO+/Tk0O0xOAVFQyZwB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jg5123KrjHeCJ5Sc0yeJYzBVmtAJMkum2acTHTQ+aaL3OFR6dpj0LsmofReUWRQdgr6tRPRSahcIv/miQ/9ptenafheChkQLyEgnp2+e3KQ5/oz2fAz0DL5GrZg+jGWy3MlvXcNFmKX6XE2kuAcshoLwR6NPDkSakxTzqzAV8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iynGJEFQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EzdzNxje; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RH1se31334229
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 23:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OkKayYeAIHfTi6mn5hK3Ts5esZgpQ3N3uo9X9SbN9I4=; b=iynGJEFQ2+Pl/WJH
	9dSIi7CHzM4/vs/iq2FjiIVpdzdbBtzFRAEGP+DC2g9S+HGIq/lbP1Y27TnYaI7z
	w4OTxLHmcGm9MTMyCSRVIWx7zMvNVcMA2RNo++epUM7HvDxzwUaBXt+La5T3JMXH
	GTBmszYztNWH9TPJ4VnHlnNVEcZHyZTPaug22zWeENlxOulF+U0HK1dEoO5B8EZA
	fMs5ZWYqThejMbcZQYDz4pvGtl0u1a9OUck1ztLGnn0EQRwNHcn0MPLz3LiPFw/6
	KeJ4EVBb4koxLD7Vv7u0tbhQIET2vXFUrlLH+ibDsTeFRCHouIYg1/NspkuKtGOn
	ghKNEg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by1dfs4dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 23:39:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34e5a9f0d6aso524428a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 15:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769557164; x=1770161964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkKayYeAIHfTi6mn5hK3Ts5esZgpQ3N3uo9X9SbN9I4=;
        b=EzdzNxjemCughUUJGbnus0SSYrxYupYyGBbiwigFejxm0xocGNaIoRP6RCeEhRYGTa
         QSxLxAg0y6QU9m/0rUrzRcHMK7HOARmA0b+TIXjKxz//6AWnV/OJ6s/hssIhDbDQEwuN
         tgAnD5XKk/3hXUuZyM3BXbMrLLEoiRibXEp720ng9aUZUUqdkQddWCiC5cM0mlyt1Ltb
         Olz1FXuIlvfwN3XFzISWDIQJIP1aZybqlJ4Zl29Bh/Zjkzh5gy9TXdp+CT2n2IV9tZMp
         vAfrLNoQB7jlW3+vHhI2sYYolKq+uuVgKS5LrZcvIiJKRe1aTjMMlLB6/H6cO7BKfpX6
         OnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769557164; x=1770161964;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkKayYeAIHfTi6mn5hK3Ts5esZgpQ3N3uo9X9SbN9I4=;
        b=u2yS5HLir3c/wAojvi5Pr5EVxhMuXnC/HrDDza60cRFQMCb51Ywz0LhAg2bRWKwV/D
         47k4rQpoV3I3qQ9rBBpHPuoYpCg/s6dEbNolnyPMlwPZn5vKamjygjk4msHWCyAVKlpR
         AglfnAQxNTyO6Mga7w0t+NMJyFujGBNI3dlWhCjURavJUOcpSRIuAqW74HDtdQrknAff
         Oxah5Zzp0dwbOCGPlm44/sAdsaM4gpZC47dTEDk47BtcB86xzJWePlCzZfNBmUXhWC9G
         RSJvZ/zrQsKu6NguA0VnoUnsilu5ONlEdP3gFTq0DtWai3KszKBodxucakfRlKUsUdNU
         qLCA==
X-Gm-Message-State: AOJu0YyMeDKMyYFgzv9pDIH1miRMoZyJygZ9dbmekyK+k6MMoJu/kZuZ
	tK0O+whV698OhuC3omtB2aTTdE5U2ilYMJun41+swKecq9/01IBtm8RQ+qpq383gmELPIdE0Wk6
	HFUCwaHMat/0i1Sr7Bd4/PSfrVw1f4bPyft+vqxce72W5EP/716u9tQy83RMR1CIAQucMMA==
X-Gm-Gg: AZuq6aJ6z1f1pRMwDV+QXG49XLK8rY1B2rOKVRux66Lq+rf0fx1zbF0n7d6tE/wHDaC
	vGWTo1HZ2tPUuVa6XzkeaLkH778485KMyz7B1sqxsrd5mop9byZcYef0lYBD/2Kd+jsn+3JNcfz
	I1Pf7VXrIELkdLkvfNsl7dHPrRgEO3zQbMjJ8VUyOzsWInd/mzJgvPenuEMuhikKU4jNA7OaciA
	HDe/29Q6ZaA9K6pqxosee18KH7xk/WuoZzKJkq+z88LV+Uj2IXCyg+4YlRdtmq9h3f4wzNytfdN
	gS94HLkzmbPSIPe+TcyeDUmiiaGgY01lnO7Ml5Jiux8ttsuxl7pmSUxxUCasee0EZprhFi169/4
	s19l13RfB524/Mx91fF2eZQ0lBs8oAu4Dva/+8my+Hi0m9MK9gCT5N1U1XoomYOj/38PqQD3OBr
	mb
X-Received: by 2002:a17:90b:2dc8:b0:343:cfa1:c458 with SMTP id 98e67ed59e1d1-353ffb69d64mr2872741a91.18.1769557163986;
        Tue, 27 Jan 2026 15:39:23 -0800 (PST)
X-Received: by 2002:a17:90b:2dc8:b0:343:cfa1:c458 with SMTP id 98e67ed59e1d1-353ffb69d64mr2872728a91.18.1769557163507;
        Tue, 27 Jan 2026 15:39:23 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f3ed0dasm461453a91.14.2026.01.27.15.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 15:39:23 -0800 (PST)
Message-ID: <9c418260-b67a-48aa-80c6-6a03c91e4ba3@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 15:39:21 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current v2] wifi: ath12k: fix wrong TID passed when
 stopping AMPDU session
To: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260126173655.1369715-1-pmartin-gomez@freebox.fr>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260126173655.1369715-1-pmartin-gomez@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE5MyBTYWx0ZWRfX5sQww/4wONgx
 Gsvof/miXs+6oQdg3BgXlYEdp2mQcv9cqijQaUs+Xx4jsoyR19CLoAxUdtrMgkx7YpzC/UEZvwz
 zjVeDCCXx+62TZEc29i0WZ8wEyHon1hEWlE732xvmf/5gJNMvWcrZrLhNCuUNpIyWmIFj9oDxY9
 wwzW4JoMrgcQLXoghWxNcf9/9ExKmsRSp292g86wab3RzcfSwnq7tpnXZR+dZiCYlHgvQ6Zpp+a
 3umlRpgM0PJ19W0lGaXBOLy4NjtPOSZFXVtlvLBih66/bNbDzOkG7aAiUODSSs4Dd83dUH+4gkq
 +G/Rx5+NUGx35XfCQViYs1KU2IhX98EfHuOhgCyqEFESCtv+C3y89AO+P5lRXg0Kk1U36QvfhKD
 1PElZHJZxJ/dKmSaq68ERvlq8W+8cNecqS97z9ndj6d2tZWTdSyKaPHfP6XMUKHId6UcbG5jiqy
 GTXB1ijfltqHzh3fFJA==
X-Proofpoint-GUID: guKSPj8qIja3twQX5fnz-MDAGmCNNHaw
X-Proofpoint-ORIG-GUID: guKSPj8qIja3twQX5fnz-MDAGmCNNHaw
X-Authority-Analysis: v=2.4 cv=YeuwJgRf c=1 sm=1 tr=0 ts=69794cad cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=cpEFyqQddUqqWSyafJUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270193
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31247-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,freebox.fr:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E4BCB9B721
X-Rspamd-Action: no action

On 1/26/2026 9:36 AM, Pablo Martin-Gomez wrote:
> When handling a DELBA request, ath12k_dp_rx_ampdu_stop() calls
> ath12k_peer_rx_tid_reo_update() to tear down the BA session for the
> specified TID. However, it currently passes peer->rx_tid instead of the
> entry corresponding to params->tid.
> 
> Since peer->rx_tid is an array, this decays to a pointer to the first
> element, effectively operating on TID 0 regardless of the TID in the
> DELBA request. As a result, the BA session for TID 0 is stopped while
> the intended TID remains active.
> 
> This leads to incorrect BA session state and may significantly reduce
> RX throughput, as traffic that should use aggregation falls back to a
> BA window size of 1 on TID 0.
> 
> Fix this by passing the correct TID entry:
>   &peer->rx_tid[params->tid]
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
> ---
>  drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index d28d8ffec0f8..f2327c82953b 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1289,7 +1289,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
>  		return 0;
>  	}
>  
> -	ret = ath12k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
> +	ret = ath12k_peer_rx_tid_reo_update(ar, peer, &peer->rx_tid[params->tid], 1, 0, false);

like the ath11k change, this also triggers ath12k-check:
drivers/net/wireless/ath/ath12k/dp_rx.c:1292: line length of 95 exceeds 90 columns

I'll break this line when I process the patch

>  	spin_unlock_bh(&ab->base_lock);
>  	if (ret) {
>  		ath12k_warn(ab, "failed to update reo for rx tid %d: %d\n",


