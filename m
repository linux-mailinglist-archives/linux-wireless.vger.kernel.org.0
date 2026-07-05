Return-Path: <linux-wireless+bounces-38635-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iUabNk2TSmoyEwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38635-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 19:24:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91570AAC3
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 19:24:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=RvKlWPkC;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="Gz/DFcGg";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38635-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38635-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73FD83020FF8
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jul 2026 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAFC2F7EE5;
	Sun,  5 Jul 2026 17:24:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACAF3033DF
	for <linux-wireless@vger.kernel.org>; Sun,  5 Jul 2026 17:24:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272248; cv=none; b=TGxCZ7nIIcQL+cGmotdjDCrCjdqPtxaxadXuiw65/RXtTt1G1dDU3uA0CRcN8Rm6BSsD/PvALGuLYVEFSO+nKjntWL3tvduoBYbYb0JtOAruo0tFk91zQgcz9DWpj/J/q3tUPK2dA0+AhDvyWOIHXxGp/SbW4Z4rHYCFjbvcC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272248; c=relaxed/simple;
	bh=miuzIlBKZC7q5ljCHAuwY6y4LMRZb++BZNwEP84VH3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuQoR42pn1LyWkgQESQndHANELLoOiUU1hsxWhDi83LECOGl5xzhXjgt+r2xjtHsGhrT93gQ2CkGY3tIsVZybCBKkZe5TqPHE4dxTrZH8/8jupiqJ/6DGlULIDVpb6IHXy4WvHcNe7wc9uqId1FceEgFydywzbz75PjmzHq7RD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvKlWPkC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gz/DFcGg; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6651sjqV255002
	for <linux-wireless@vger.kernel.org>; Sun, 5 Jul 2026 17:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hmVsegBX3hn4vmev5uYRfwriKhQ3FPobjXZ+2MuSx6U=; b=RvKlWPkCBHO5YCxM
	+8urm19XschTQ/RZxtB74iGGOOvkoa+3D3ar3bZ76oCrF9iilIIWNbMxkoP9P3Ea
	dd4hWeT+vtewyUCUe+z2lDEGpnBUScIbzg8053RqDKSfwaXJmS1n+Y+182kf7fEu
	0ra7pH0V4pXcMC5pcZlaIX3j0ThLbjtt5HGIhYPif/dEpwv3vRyeBl9lYV0tZ1ps
	8Mje87IVbl+iUSyVUeL3uszhNKVj+NRSrDlJLgzqA7JJP9giIQeQ/yGJumEdF9Dt
	dtRECmyopQ7qnb9MM2m/YCj6Oi+GKAKp9lLJSyZKjx969aCQhdxGGoW/hTdpROTX
	Up/dSg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8k1mm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 17:24:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c889d1eebafso5346425a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783272245; x=1783877045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmVsegBX3hn4vmev5uYRfwriKhQ3FPobjXZ+2MuSx6U=;
        b=Gz/DFcGgv0gBHzEWSkYY4zd5iaWUHdhsKzHSmwSegbsHcQWEyJpm4D+dUFuuND+gwZ
         ZH/LfPFktPXW0jWNt7PD5wI9LLqxSmT+IDnOk48j5brdzQsHZhe04ugJQ0Y6mXYV9T8z
         ruUpz+d/P7Nwbbd/4gJj/GiQlUN58QKt4qkSL2UvF6kbZJYOxtL9JDcghhwZpH/ID+dQ
         1qbTcPvN6Lyw00Uxuv2+qxltbweUNj1FtHwjzHCBauMULJXcxiWlcyibvSDsCfvf8WEX
         wHr074HJrE2Hc7puhgCzuakM6Az0FXD2+f4w7IAXLVtBkfEelpTZVoMCa70PIwL/VvVs
         aTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272245; x=1783877045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmVsegBX3hn4vmev5uYRfwriKhQ3FPobjXZ+2MuSx6U=;
        b=aazvOXrPz/vGjOGzHpZMguxzeASQMOEvBgBKxRxl5AIoPqBUcXH4MnvxHKprhdXDDd
         yeHkjwV/lIG0SsNbwiHzH1dLCQ0kzasbwA1FZ5DODwF0/PptGh//mVgkbP8uDgYjTLna
         BHbez0YEIsvaS9+W1x1/opWowDotrD6YKFf+no8lQjFLdMZu+vUyX0iuY5s8wspdxWzf
         9XNHMlZvKKgCietH1MatC4MWWmgwm5cpkQlJ0yN0j86MG1zZSTJCNv0uMTXy7Z9vmkyf
         J4MlfFRi6Y+kS24FA+Oz+K57Hc1L2RC8X6LYjAowFIMGkxDayqh3PHQGmiqVYJ2EkMaD
         hvbQ==
X-Gm-Message-State: AOJu0YxqCc36PbpHoJkNe8md0iTI2jhgREnFBDxGZ+8oeRQ8xXe9PdM5
	iD3wGjgvUIbEWBJpBbX5tbmAv8X4LvUSoxS4joV5ryySwPP//Ui4PDDL8CWtfv0F2cc6hp8e5o2
	y2h8IxjFMZtkayh1i8dzRCgs7NRHqPO6DApmcjGU4v06JUfZV215WdYnwa1wueioEkv+gmg==
X-Gm-Gg: AfdE7ckCB9yYLJHouVixf2slqhjQ+cjyYgwYwyTmj0r0x4Cgi8ma0cZ+EOE0x2MQBdh
	oguURHS/CJHdoeAsnh45JqbXvS3LkNyMO2gcQAs+wj+4YbTaxAkDPElFJZ0P4MhZEv9dkSJD5yv
	zhZUDcwibrqoOvyrpvcd0qD5aGWUx6aYhV6ElqjRXPEEGldh235kzVJSfV0iMm0mfnGu7PD6G5u
	FJZqllsd+fWY9WdI3qPYbI+MJ97L5WA+5r6VbqlWsc+qRfJj5AfaY+AJmYiWxeXdZkkkLsao/ou
	Dc6xaC+LjIsPo3cCFP7VS7pAjlRzRz6/t1WSDf4N6O9sKIBBm12kaHyx0rGvC2E4VSy1GqgIX+Q
	+aWnw/uFD16l4nOB8M9/uXw8JzVck9x48Zz/nuQYWLX0SAD3uCnSreFOr/dW4nQ==
X-Received: by 2002:a05:6a20:6a0f:b0:3bf:7081:934b with SMTP id adf61e73a8af0-3c03e2a3e2fmr7129606637.26.1783272245150;
        Sun, 05 Jul 2026 10:24:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0f:b0:3bf:7081:934b with SMTP id adf61e73a8af0-3c03e2a3e2fmr7129585637.26.1783272244703;
        Sun, 05 Jul 2026 10:24:04 -0700 (PDT)
Received: from [10.168.91.130] ([223.185.219.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f39e07e0bsm26472855eec.30.2026.07.05.10.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 10:24:04 -0700 (PDT)
Message-ID: <d0fd509f-760f-4632-b116-0b6494466f22@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 22:53:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table
 destroy
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260615112103.601982-1-jtornosm@redhat.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260615112103.601982-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfX35rNAE+X4b53
 96ihUepuNTD9S/UYi8VkXPe24VECeUHHmQzXYrNYlOETL8/d6wMpy09c7vfI7BhTCgoBQrBCJcr
 8oNdCWWtdeD6e7J2J5l08DYaaVVHZYOg0I6gunhm/OcFITsoyV5Ed0aoEIk6LYDWrAxQe1V19bO
 lgDp4Azv41rsS0kVfqJWnU+3x4GGUM97h62kKuXQpS5yTBJkUvZjcIj4HHuUXNErdz0C0pSSFTU
 6EYd6m/6qmJd4HMq8ynw65ReKK/dPqwFSrAf/Xk9uIMh6XCCNfOa+cHk8BFy9/um3pjfLMmhg+y
 pgX5/UgSbkFADIVBHcB5g/vq38g0VFKZ/g5MkHqhS7+EoybRtEZAeu525du9TrkiMrCMXMjCYTG
 qnIrF19XxX5Crqp6i/Ir4Bru3NybXw0+QwBPfAOKDNheEtammVWecjaMqtfwsjuMKEvf8r6DMKg
 VIZweJBdGvXiX5ppT3Q==
X-Proofpoint-ORIG-GUID: 2LVZ3FSfQmwTsDHjmqiFsqapAuq0Ty-4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfXyLkf5yIZhAGH
 PhTp2oqxIrENGQOvul2IXJrbXGvthuXU+kO/Ut903QEGKWo3S7hodE9Cy+it96IvXSRVJGbRtC9
 V9e+KBLMqr1oeJS//tXnm13D1vinng0=
X-Proofpoint-GUID: 2LVZ3FSfQmwTsDHjmqiFsqapAuq0Ty-4
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4a9336 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ziM92C7oNnnlFgKtw0sKeA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=aXf5c7XquDVv4hRH_ogA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050187
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38635-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E91570AAC3



On 6/15/2026 4:51 PM, Jose Ignacio Tornos Martinez wrote:
> When unbinding the ath12k driver, kernel NULL pointer dereferences
> occur in irq_work_sync() called from rhashtable_destroy().
> 
> Two hash tables are affected:
> 1. ath12k_link_sta hash table in ath12k_base
> 2. ath12k_dp_link_peer hash table in ath12k_dp
> 
> The issue happens because the destroy functions are called unconditionally
> in cleanup paths, but the hash tables are only initialized late in their
> respective init functions. If the device was never fully started or if the
> init functions failed before initializing the hash tables, the pointers
> will be NULL. The issues are always reproducible from a VM because the MSI
> addressing initialization is failing.
> 
> Call trace for ath12k_link_sta_rhash_tbl_destroy:
>   RIP: irq_work_sync+0x1e/0x70
>   rhashtable_destroy+0x12/0x60
>   ath12k_link_sta_rhash_tbl_destroy+0x19/0x40 [ath12k]
>   ath12k_core_stop+0xe/0x80 [ath12k]
>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>   ath12k_pci_remove+0x60/0x110 [ath12k]
> 
> Call trace for ath12k_dp_link_peer_rhash_tbl_destroy:
>   RIP: irq_work_sync+0x1e/0x70
>   rhashtable_destroy+0x12/0x60
>   ath12k_dp_link_peer_rhash_tbl_destroy+0x29/0x50 [ath12k]
>   ath12k_dp_cmn_device_deinit+0x21/0x140 [ath12k]
>   ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
>   ath12k_pci_remove+0x60/0x110 [ath12k]
> 
> Fix this by adding NULL checks before calling rhashtable_destroy() in
> both destroy functions.
> 
> The NULL check approach was chosen because the rhashtable pointer
> serves as the initialization state indicator. The init can fail at
> various points, leaving some components uninitialized. Checking the
> pointer directly is simpler than adding separate state flags that
> would need synchronization.
> 
> Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
> Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

