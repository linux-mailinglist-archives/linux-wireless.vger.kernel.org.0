Return-Path: <linux-wireless+bounces-31243-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNfHLwMGeWk3ugEAu9opvQ
	(envelope-from <linux-wireless+bounces-31243-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 19:37:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D199383
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 19:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0002300AB06
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 18:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B99327BF4;
	Tue, 27 Jan 2026 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ogP9fGq3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gknjwJFw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97C327218
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539074; cv=none; b=Q1L4MhF6vx/mZhzF0wWqhH+bFhYRgnLkHAh1kRPs8lIHBIps4JhCElxW8fPjQNRSnbchuPJBBcTb9Z+1/mHw8qx+MPPtwys9YjMm9f/v7BfyD/AegiFF/+lnyVPAXwLPMm16QxWAE+1ZZiSKYfxrbZT80yBzThMUMzt5GmTggCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539074; c=relaxed/simple;
	bh=XxFsL15cYkyLIDsE4XGKFUZDvMDYK7zAnnqxnWov0Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWk3TXNJofZRmDdVKv3+JClxzyfNTpaLKjbTGu81EECv5X3o2+Wdct1dQAp6YxDHxx5g0rOUntTe08dhWBSvbuXOlA3zVWpRFjfZ+rSnCQPmnLO+OzN6/qWO6dlS6xsW9m1nCwvYQvfR/xvnEmSzcj3BmqZClIiorVTIseIZxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ogP9fGq3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gknjwJFw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RH80FN1268770
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V1vEsiFeTiiqgiMqeCXQjM3da0iXlQoIsKv9ahLtWOQ=; b=ogP9fGq3QmJ/d39K
	vAh+dcKgdP05n96pYS6rK6IljIdjLlkkScPfIThdzuQHEQIO4QDTmlQG2LH4wolu
	jU0V38Kw5cnWYtFPsTh29GR7PPqb+sgtcpOZYNqcLqILvl16LMAygE22O7yYXoLQ
	KEwlr3M91xUgOI+MoieMAj8cc7KUCsJa6HNQvI1pXrEofjo9uVLimBFolbRsjICj
	/Gd/ta6dew65Dp0wxjmHehRtsPcHH4yKisXYzGQMxCDq0FMVoBhtvpCVd9ZbXLY0
	ESiXiEzeMBEkdYqi5rNkbMZLuzwmgFomNBjv71YSZJXnEXVqcV3XuwBdfarCvY3i
	taZNig==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyatwxn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:37:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b6f0b345e3so32126734eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 10:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769539067; x=1770143867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1vEsiFeTiiqgiMqeCXQjM3da0iXlQoIsKv9ahLtWOQ=;
        b=gknjwJFwRs/IRqZ9I0Pve3hDwIv5el+bUsqPVkkWFX6Ox948JF4bDbb8nISZtdX4Nr
         dxvAezTSzUBkJ0aJc3M3YJvt9nQ6tFPA6VXgl77trkP4pLiCv9KFZuntwjINjVrsNbSJ
         6PQaF2Q8U5DSPqWD5nWso6wrSB3IRzV1ApqA5oFeDoWULZ7WM2/7pfbEkYh3ZwnlGJ1F
         EOo5r4Xm+6ye7j76bmcAiy8pYquVGZg4vFOigD28QVashd/I9mFEgqlD9+CJ/Tk8pb+0
         L9F+zVQ6qr5rrjqEGBVkxO/V656pp5blJK+b4sRzYjvm/0VtSb3WbSbh3TIXV9PWOgKE
         BNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539067; x=1770143867;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1vEsiFeTiiqgiMqeCXQjM3da0iXlQoIsKv9ahLtWOQ=;
        b=HorMKxe+MU4pxEUDv+wF43HNQ8QuAXOsAIFmt/7nFs9/luBrFZoW4Eda0eM+0ZLRnE
         vd/3I37DSSKk8wvf0qwFBcngXpHyD+bbDBxRkcYosmPOYiwJH/fNhW0ZipVk75oIeFoC
         nQlZ5esq/hSaWb2izexdAZ/mL9/gMaQ64n44MklsenvYmNxMLdjwZccg6ggxbg31d/LW
         n9s3mx6KUcHKFWDlxQmTBX1GbkB0xcaijPlEtas5rs6+Q/O024Vaa4P0ub6x8RrHyvcN
         Wop+noQSkLhVaFWBsiaFaK3A2mfa+anJ1flMqtytXWYxf2ocbdhS8nzyzpqVpkXKT40V
         kMAQ==
X-Gm-Message-State: AOJu0YxiT4yo0wQXd6UerCIPi2xe+NSO5+BBlwDGMUUTYQ+oIK2F00Qi
	N9gdlrNKlpN/tLuxnwYVU9TPpPEtPICCM1ovgLWLQ6TqAvCPY7FgxEtx51g/Lr9UjxIsC/UVpM7
	kF62ImlJG5bWGSfjK+y5qgVj3yPqDMKh4C2UChCXUNUUg+GppoT286y5I9ucyG1OyEzkVSg==
X-Gm-Gg: AZuq6aJJzp4GVW55ct9lwp92dElo21F03OGeu2yg0zP9OCLiISXnPXZaROjuKIJ6qFu
	FRHwAC0miuskC984thxNDgJS3DVLyj+i0kr3ZW7il1n2xI5XXuYzRpH9MLoHc9L7dnRWD+oO88P
	fEMTcHVCK+HTnBQfadcvS80v5+XqO7UaRgo71oPve6JPb8UrOGfafBmPpJkjc7nXJVk1c3Zv8RL
	UmrZSH0vwTWJ4F7diOad+nVUXkTIPKoLmy4Jby0VeWBnmTqCKPhpuXAHV1nD+mJmUiX+Mg3eKmM
	TTmS1EyxGhpWaQKmjI4N9YRPJpGpJXAhtV7m/BZLM38aW9V5Nx6bEk129AFRkUyGcyswIi6OKuN
	+E5ASh3rIKQJL/rQ7acrw2r4su6jjnhZ7bbmEMXw7QvnNneWPPKJ/XOfypkIyyIB4pIsDIw==
X-Received: by 2002:a05:7301:2e87:b0:2b7:2723:c227 with SMTP id 5a478bee46e88-2b78da2a6d0mr1817111eec.31.1769539067119;
        Tue, 27 Jan 2026 10:37:47 -0800 (PST)
X-Received: by 2002:a05:7301:2e87:b0:2b7:2723:c227 with SMTP id 5a478bee46e88-2b78da2a6d0mr1817089eec.31.1769539066551;
        Tue, 27 Jan 2026 10:37:46 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b79cc0df07sm397559eec.30.2026.01.27.10.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 10:37:46 -0800 (PST)
Message-ID: <a09671f5-0855-4f80-b373-d0658bdbf34b@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 10:37:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current v2] wifi: ath11k: fix wrong TID passed when
 stopping AMPDU session
To: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260126174049.1370659-1-pmartin-gomez@freebox.fr>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260126174049.1370659-1-pmartin-gomez@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XS7avgZVgLrf3PHj9ztSSkJ2KnOYgcLv
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=697905ff cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=4MSwVuzKff4lAtYpjw4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: XS7avgZVgLrf3PHj9ztSSkJ2KnOYgcLv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MiBTYWx0ZWRfX6XeP3BXBTk07
 MvGqJ2+vfDkz38EzjUMZtl8PyfJNatv6fc2QbiHrmcDuIGf8NIQ1d29uOxba6e3xJ6Vx8cZt27X
 FnscXmmEKJhp70SFkqdedDtwtKOd8IoWEU71x90xLyevOLxtxgJsk+xAs24sqlnM5DSC/X2YIlg
 tvKaQr6Bg8OSHzWhAJjgqg0Yul6aTBVXY6mCDfMBwCd/+bJEdl0r5uHBNYcGVcdK0Nb1IoGSuuf
 mn04P9zb9nAHLWMQtFCCKTSvZ8R0r4FYo9Chf5TvuzEaJ59EeN+16J75Es4lcLy8zwzJMAQkAf3
 Kxaw38McFedDEgdiFOcVP8zvuBZW+RLKaAT/stgZE5zKQsF5YeEIImw7PfgFESoTHhPmPJPX6NA
 YlSIBrTK9wOPDwXfhGuYYhDssfyzE/R/lAvV1KJ525OVTDZVCcXLDGXijuVBkDwYVNJMf5mSRdc
 siYr3MYvoaUPS3p04Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270152
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31243-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 635D199383
X-Rspamd-Action: no action

On 1/26/2026 9:40 AM, Pablo Martin-Gomez wrote:
> When handling a DELBA request, ath11k_dp_rx_ampdu_stop() calls
> ath11k_peer_rx_tid_reo_update() to tear down the BA session for the
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
> Fixes: fe201947f8bd ("ath11k: update bawindow size in delba process")
> Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index b9e976ddcbbf..8db04c38dfba 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -1132,7 +1132,7 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
>  		return 0;
>  	}
>  
> -	ret = ath11k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
> +	ret = ath11k_peer_rx_tid_reo_update(ar, peer, &peer->rx_tid[params->tid], 1, 0, false);

Our ath11k-check scrip reports:
drivers/net/wireless/ath/ath11k/dp_rx.c:1135: line length of 95 exceeds 90 columns

I can split this for you when I apply the patch

>  	spin_unlock_bh(&ab->base_lock);
>  	if (ret) {
>  		ath11k_warn(ab, "failed to update reo for rx tid %d: %d\n",


