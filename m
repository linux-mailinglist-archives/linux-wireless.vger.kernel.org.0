Return-Path: <linux-wireless+bounces-31180-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL0iHUakd2k9jwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31180-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:28:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D68B77F
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B649B3014130
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611434B43D;
	Mon, 26 Jan 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a88pbGcf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L17peyFP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DE22425B
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448511; cv=none; b=VDVvRm6MWlyiqEVfIx+SSsk8t5nVdHiXDmvvnGFVKB/ZkxmWnV9rErmD+6M7oqynk0E1oJ/aw0II5CUK0cH/E4S5wIKHzPcGHsx+5pgOagYuw+aEYEOcSg/XEicO9oC0piMGdIpdPROTaYzAb1cztfZwtd0wTHbpg14d6nD5xOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448511; c=relaxed/simple;
	bh=GQ58ewguXy06bZfE9XHAQ4eNqw56sLAsdbCkDLjHk4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hX9iTeBdF2wvSOvSsuAC46WSdpPUgQiE9uY1Y7kSmgYaNCjmX4U701ppVoTil1vGfgpm43nDnP1xlFKDCrfGkkv8u2/HMXjVF6rOcDDgws5FMnlBbseLIfkTSF00kpxn35vvPWkd9xr8uJiWvL8wl8GxCExbhY2eCvkNRcZN4cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a88pbGcf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L17peyFP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QErWYf171886
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 17:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AKbQFfUG/A89GVo9hdrMRrrtAKp7iLQnhsUaVv29b70=; b=a88pbGcfC7JRp0Cn
	5jVS/Nvcrc/jYLoXuMoHw+eVNoepZNaxxV1M7S2AB0PuN99oEKn5slQABmv5hQ8/
	V5aHom/B/z1ZgAhHPs+mqUuLIksh5Z2kuy0Jeyd1s125lL749OgRAkvq0g0oKi9g
	e1tfDoW/9Z/nuXfUPnaIs4vKBQc/E7fzG8p2ACPXac0jJMzFDfP36UAVzP9npKsx
	4XQZlzIyiN+A2FyU+5e7EV/aUO59ZFKwdGvNMr0JK7j3+bqNbhQBIC6bnXX87pwK
	mm4Si4c283jK53JaXQao1LZSutUOU9GrnuMhuphBfSvkT51ovd4lxwLDeihcsSIe
	yXtUHA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxadprfcu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 17:28:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b713fa927dso3195567eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 09:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769448508; x=1770053308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKbQFfUG/A89GVo9hdrMRrrtAKp7iLQnhsUaVv29b70=;
        b=L17peyFPfyElMEdcH2gfXirbPjyb76e12K9s74bkzw3obbrUd3tXPUadfMxRhPYCbF
         LsAbjdfHxl412sM9S0y1rsKJPWF08pSMK3/Q0iQEY9tfd+mR4fwonYrkZlA9aK8YiWz5
         AhspEy69avyA/aRHOy8nXsfVs5fxQ6YGcSoWiykBXRxjEbFDw8T3awXmKDka/djvxf44
         5602bnoSauIOlSpWd6duYPiYgEixPZ7Eu6XpwM5cacU5jj/7b45nFxpHnnxiE/hPCTHt
         sGycaRNmQJf2c7xCEn5GcsIdnGI8r48JqQjYBS08spleWETSrL/R8hV/kfiv0QULTSOZ
         bQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448508; x=1770053308;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKbQFfUG/A89GVo9hdrMRrrtAKp7iLQnhsUaVv29b70=;
        b=luOweE7DkeysZ/WxLh+M0YrknPHpTSyiw27DZoH6JNEh61PWJGyuUhM0mUiD7FUF33
         gsKMEVSOyMYzg3Pv1AZp+K5ePEXawIAzaybXTgtb1X79u2UIOVNJNqLyPrzzcSXnrDJ1
         cC99g+bSEGilR/ZaHZE/Go8pqLjh08CshUnPCjLDvOHRD5IKVSmZMQaIYucwbGxEmPzy
         XqggIQHlsynzhfAnY1IZshmsEcXCPMUJJqL27kuZpl1IbCupOpDBrRnRlj/8VOzzr5vZ
         quwj2ieihq3QZhKwyXlbD7DBneKXOx3MJIzzXizElX7GzyvOYL/jH4NqdnAzQ84vzBX9
         0nog==
X-Gm-Message-State: AOJu0YyC9nzIuNCNwNUzq+Ja6h3xxZCFQLAx7qHzimm7NLpNVdg1pUvW
	96XygHgmtyE6YBAJKiJla8LNMvmvsaMeOMk5Q68xFzfAFAPe1nQ9GalFZQ3biKLCJKeuJreWluu
	w1WNeMZLK6RqMoMO5Eo7Z/7K3M7WP+fHb/2sfcr/t8EN0y4DzxIrCNetndpuK7Nuw73YV7Q==
X-Gm-Gg: AZuq6aJKoydXXnYPQa+jLKQgFR+THx5aUzObDl0JHx1692QWphG3O6RcrulwGruMrna
	+cQuU27Uw2Dcaa08r27MYDpi6GRBcAglGNwJ/3X5/5I86eVY26O+T5aMMDiSV+Wk2OMJLxjEg8e
	nNpkpajog3aqYe8QxobkTfMdb0/YDiwYhszlCOzGNT8Pt4FnHGi7kZeVx8Yw1cWH2C9q7i7aQU/
	Z4Y2IHqju/tOdQLwNBwRNSDC/B6VWfJ/437uFb6kuLyVG4dcWuvETT+axDMerkOhAyx5P+y+Oe/
	o2dLErHT67HJ0aVNgAakDLFa2BCWO4ZoJIwbPinGaO8G7+3ue79Wc9cc15MtQ6zl0Da6ExmDlCx
	/HniWGQSE0CnW69c/n3IdiwrNc7ZOWgJ6Zb+v0SiKFggmktzsQS8pUXMgJJRsGvafI7HXKzCzUf
	Ha
X-Received: by 2002:a05:7300:cd44:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2b7639848c5mr1954260eec.14.1769448508080;
        Mon, 26 Jan 2026 09:28:28 -0800 (PST)
X-Received: by 2002:a05:7300:cd44:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2b7639848c5mr1954246eec.14.1769448507472;
        Mon, 26 Jan 2026 09:28:27 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6f5d2asm14038328eec.14.2026.01.26.09.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 09:28:27 -0800 (PST)
Message-ID: <9c6369f4-c80c-4a59-a17a-7b4ed0d8a032@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 09:28:26 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix wrong TID passed when
 stopping AMPDU session
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <2633095a-9555-45bf-b143-ad2bdaa1ab01@freebox.fr>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2633095a-9555-45bf-b143-ad2bdaa1ab01@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: V8LK5i5AKYs799y6n5Km1aCm5mmGbwhh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE0OSBTYWx0ZWRfX52W29PDIWuSM
 MWvMMmhIU4PKq2nGGqaqwDhGZ3new7IStxfxu5n+HjmSZcwIgBxB5WGiTezmROGwaxwU1GusYp7
 OlaQTg8/yTd7PFYs5HgOWM+X9dwOhfu77GoENOOVfOkK9nFgz1BZRTD27E2yAORHAY8JIRhwuqM
 u+jFaZpOsquZ5H4sywaM/DzlZCUvDzxiC0Cc5IGUhOXF6cKUW1k2aosR568Bu3S5BeF8Cjusg/O
 VqlAkL6JEfYPZRgPIDiUSjwSF+7CUnn3WjtkzApYr94xxR2YMuTLtXo6ykrZVIMFSW3n5BumUTv
 3SfoLonm18d+EE015EIUTSNH6xjwmJ+2kL5JwnWLhFElQ2dWR2CdKg0ATmNOtxgAdnMHoAEdf43
 NeNsG/nO+wKuIwgdAyvHGQlC4/AxgTIt8w57Q1k/mZ5Q7lOQxwz/0M0QH+r8pBwKbdFltNH80K1
 6F6lWHmX/iY19tXNodw==
X-Authority-Analysis: v=2.4 cv=GvdPO01C c=1 sm=1 tr=0 ts=6977a43c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=SzpFk2VB_PeOq39dtucA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cWrrghZYQEAA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: V8LK5i5AKYs799y6n5Km1aCm5mmGbwhh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,freebox.fr:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31180-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SURBL_MULTI_FAIL(0.00)[oss.qualcomm.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 141D68B77F
X-Rspamd-Action: no action

On 1/26/2026 3:35 AM, Pablo MARTIN-GOMEZ wrote:
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
>    &peer->rx_tid[params->tid]
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
> ---
>   drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c 
> b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index d28d8ffec0f8..f2327c82953b 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1289,7 +1289,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
>           return 0;
>       }
> 
> -    ret = ath12k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, 
> false);
> +    ret = ath12k_peer_rx_tid_reo_update(ar, peer, 
> &peer->rx_tid[params->tid], 1, 0, false);

FYI your e-mail client is munging your patch, adding a line break.
And using "view source" it looks like other artifacts are being added.
My tooling (using 'b4') cannot process your patch...

Applying: wifi: ath12k: fix wrong TID passed when stopping AMPDU session
error: git diff header lacks filename information when removing 1 leading pathname component (line 6)

Suggest using https://b4.docs.kernel.org/en/latest/contributor/overview.html

>       spin_unlock_bh(&ab->base_lock);
>       if (ret) {
>           ath12k_warn(ab, "failed to update reo for rx tid %d: %d\n",


