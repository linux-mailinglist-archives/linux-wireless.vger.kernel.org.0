Return-Path: <linux-wireless+bounces-31251-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDqBAJ1ueWkHxAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31251-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 03:04:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C299C20F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 03:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E85A63010D87
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 02:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72460280331;
	Wed, 28 Jan 2026 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hD32uCzE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M1YandGU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B7283CA3
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769565850; cv=none; b=g+VAhkGCW0YiEMF5+IYv7LHWHrTkt96KpnvUiTTyKYlAX6VZezeFeFU9zQKuTwqVwTjoZFna30CA+ymUCZJvQ4I6PcLudzn/vnEowujWQG+tYaT3YNNPh4VQszJBeWvQILpWcloq6/vU2vN4BaNcnJm++pmOmzAT1XnWnx6DreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769565850; c=relaxed/simple;
	bh=jgCmHnModQky0MveucprFto2JDEIRTl7hwi5EVSGlc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcSp9+02rZA5xAtMV8+ACTZsVQmk1EsaCIaCvzbwJWb+6P6eRT+QoF8zYI38oRtz2O8eN60DuIt9bClunsMBKU5QolB+TIxrNlJ1MeQ3dIhNhMf8Zpg1GJMjCvysDnzbZuszw/sG5TtNTMHNqUjVqlerh88LPBYjCwr2yebmJEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hD32uCzE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M1YandGU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S1mN7L1714795
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 02:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	myB7M/GUr59OzzN5PhoOQVsgmBT13emqVNz1IOIRUJY=; b=hD32uCzE6+4vA+F8
	piW6ObzSYkDftoRQyXA4c+NMRnzfcT4in+wBQkPIe9x3qPt2nVKKxAdhBFACboND
	kmtLMZniC6vJsnSKvj1XX4k2E6HPOsUO64309IE4/lEv14yA5BtLQk+NObaAK4eK
	YhGjV8tbiLft+Ur9JGIAixdz1Y3ka+YafZ204/XY7Ivq1IWI1JbYlBps/Q7NtTvL
	EPJHfQm8yBOyDS45F9syJuNhwJav1vgxQ/Vej//QNyet+faWiGJcwjGkiJMyNcZv
	fiK+ICzzTDbdPjEqtq1JbNfZ16N4PtXnjchRtKU05hDBQ8h3OeK0kBPpxyNcDQ3d
	HhpISw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by0g09ur2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 02:04:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81e7fd70908so11601704b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769565846; x=1770170646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myB7M/GUr59OzzN5PhoOQVsgmBT13emqVNz1IOIRUJY=;
        b=M1YandGUd82mo9ZN/uasndIhjC4vIpuvdl8zM0NnC55zx4sfBCtdTJWCuonH+YhI+J
         UvqOZaVF6qwa7IYA1Jf0O7l209UaTW7nrqs7vYuMLyyAP32NdCrXHLkYGVHB8rMR6cYV
         s6t251BPzbnkN+KU0BV/dGqUcOG5zlBqblQccMGKOf8hCPZZ2SmRPQ/wxBr6fjwTDHxC
         Txf9WCKDHdi1WWYh/LtL3nk2QhJk5QbBOTcs2zK/A+EtiaxYZVRdxVxmQYRyKYtAQfe6
         E5yvMisdod1PeWO12fTlpc6dpxj8CisFGI4FBQYGEB5+sIlxhOFgHwycnpMtMggi94UA
         BW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769565846; x=1770170646;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myB7M/GUr59OzzN5PhoOQVsgmBT13emqVNz1IOIRUJY=;
        b=Qb5UwajkKz6yynkrT4RMcMhGhvDSXL0PIX4So40zEAEnPBnfhKv39Z7mkb5eGipuHN
         gxcd5vRZWfX6O3oFc6l01VAMcuEvz4CvkPDBz2O2oQDyDbp7BLc6jtzap4jUyOcWOXho
         rGoXd9NmH3T2eIBrx4Po/V4Hg6CkbAVdfpWHcff7m/y20/zP2c+MY4Mr41ZXj1OMK4WW
         9tpahJ7lNU68alRSQ4DE0xU+7ghWOGLsJmRL/60nAqI68Qo+gDA3/QlL0EY+bUFpUD8s
         1X+myUWuf0RCBF9RmeZbz4SZoj3yXVewJbIpWuES3puNmAqmDQznXVPbFtT20T9x3blc
         11LQ==
X-Gm-Message-State: AOJu0YxK5mNJd/ko9Edw6tJjeJm8zeYMF9aFZxxu1zw3ug8V7h7QYOvz
	yw6Me9Yxit+XWcIUrZdsn1t1hzGfSiEozGW9jadhbEZyWnhqx/32/wjcLxGyl8V8hrYWmKJ6jWq
	ma/7/ohA/p1lUJMT8revljIQ6YOuajokW8UTV78VKJ/C65dKz1tcFVuaWx2YSc33kzmkahS2hKx
	r8raYT
X-Gm-Gg: AZuq6aJ1hfpJAxjI3HWpLAdCx94NS6dfAamaLHfPODGycDkDObgOdE3w66k71ZX/8RP
	wNLW70sn+4tJTiP7q2RvQrGvil/OsCBzTLUGhzfg1Drg0EsMvySqF8Y+FD8vIaFKBlIWuH4yPQa
	BpyN/LMzRb0LQRu279x8gUOGhWiqUTmpUC5nLXlsBGokWBCb8LIw62RrbEgqX1ttl303kMA/oBq
	pbQJpQL2OFAmsqEXGY9+F6SlIdQuzWEN/aAeMXGf13Kdxrukgu+4oWIJmQ3FZeeNqiOYdW+b+Ml
	0AiGPLfaoDgxk9m40j6sy4mS+1DweUndwLloM77+uXnCFSIUJNICz8zjC5j3ETVKF24hi+FiO60
	W6Dd8zuJDIDLMo5G+Yuzgn5BZ8sssYLYLBlCX1OlOyBGO2bq6mXijVqGvdkQUlVuXY1q8pdA=
X-Received: by 2002:a05:6a00:b95:b0:81f:3fd5:985e with SMTP id d2e1a72fcca58-823692a369dmr3696309b3a.32.1769565846268;
        Tue, 27 Jan 2026 18:04:06 -0800 (PST)
X-Received: by 2002:a05:6a00:b95:b0:81f:3fd5:985e with SMTP id d2e1a72fcca58-823692a369dmr3696281b3a.32.1769565845723;
        Tue, 27 Jan 2026 18:04:05 -0800 (PST)
Received: from [10.133.33.215] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc68sm827151b3a.2.2026.01.27.18.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 18:04:05 -0800 (PST)
Message-ID: <dc806193-c619-49bb-b054-565c4da53955@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 10:04:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current v2] wifi: ath11k: fix wrong TID passed when
 stopping AMPDU session
To: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>, ath11k@lists.infradead.org,
        jeff.johnson@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
References: <20260126174049.1370659-1-pmartin-gomez@freebox.fr>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260126174049.1370659-1-pmartin-gomez@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hIENn5n62_V--vEqzcrpHrYOJF5q4jqA
X-Proofpoint-GUID: hIENn5n62_V--vEqzcrpHrYOJF5q4jqA
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=69796e97 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=4MSwVuzKff4lAtYpjw4A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAxMyBTYWx0ZWRfXwcUaTu4vajme
 L8QZWyn9UuIsAIEKe3rAJetOYJSuH0EP3VQFsApxkwKT4rNV+8rol4TIJYA6NLm9tPp06MZlheE
 TZhZuZsMOQiUTA0f9CQRvMRZ0+UI9VwtM5pzN7zZmBwm33w5q8lowVY1vYaVSWF8mhlvL/b5qdM
 m5gmZEUAfCahsEdey+Mc1l4muz2OhFaoPKGYyX1OMzEgRdSnXI9vv32OZP8gs3hBRzRUCgC+2k8
 DzrALP6vr+BW8019mTWUwu2Ghtdcm1T0PxUcRk+hj2SPJNxFXRWR47qA2uGN2k9kpt0nz90Q1tH
 MzULt2iROuGOL73jOPAmzc5LSUDiJVZULzWQPMumq0gdm7UJoqMO/kT81UHX+S/6M0ve6560HsL
 sf/Kil4rttD9yf8QHhgjdDjispxJVDFhvtBttupPsC5+y5Sou3EmsJEdwkSmMsWz1mpRK+nWakO
 8vqjJ/GQO8+zxCj8r2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280013
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31251-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 44C299C20F
X-Rspamd-Action: no action



On 1/27/2026 1:40 AM, Pablo Martin-Gomez wrote:
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
>  	spin_unlock_bh(&ab->base_lock);
>  	if (ret) {
>  		ath11k_warn(ab, "failed to update reo for rx tid %d: %d\n",

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


