Return-Path: <linux-wireless+bounces-38988-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WEJKDUcTVWrPjgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38988-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 18:33:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446574DA34
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 18:33:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=X0KeW06R;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZBFov73v;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38988-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38988-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C1503100F91
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296C940F8ED;
	Mon, 13 Jul 2026 16:27:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924D336897
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 16:27:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960052; cv=none; b=eL7qW4E5xugH115BUyq2AGgFMO7wWTUXn75vNKBTro5ihc6H9anb38Da6IeWPFfU9mNPHMIN+TYXPe/lodXkelDovXuXdUsod8cVOMQkbQEmeDKTOn6pGEMSZhPcdijIse9WHySqCrf+NuwNINDQz/o8I5LD/XN45dUOzHaVs2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960052; c=relaxed/simple;
	bh=A1f97LTbTJPapjq0Go5CkXQGXKJe1MV3Kq+mFGjV6EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Op8lOLFeRqLlGbruVSp3mehtRQeSjZf2yjDV2klbpYJmrV1BFsqPwb2eVt1H/0jUWyCE4MyeiURw3aoF6GMhOhW1v6Cc2Dwn2/6b+T8xe/cLWjvUJdBCz7ZI5tV0Ucpi/2TYdzsfhOu87FGJMJj/XLszulNMFqbDIUapIBHUqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0KeW06R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZBFov73v; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF86Z21734676
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 16:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D5rm8mmecnWku+WMvoOW9pOIxP97XIThL4X10qRCnxE=; b=X0KeW06Rfdm3sDZY
	MbtyRXJ3yJfOdc3lYbRUbKZsLN8UiuUw65hnbBs4KB4cfvFDT87bUIRirqTFmGYr
	+eV8KMkm81I2qrBXCTpvMiu9cCR7nd4BQanq+VJXFrKbgPwCOS198Lbk7eNntURM
	9jRvmy4iu7UO9YzsA6iAos77W3ysitm14HkDMr47gt/Cc/SDGU2eLVA95uGCsPYz
	Mur3Q6lmYF3pPSoSTAEDmsoUwt0iMb7FhTNXs3RACCxzEh8mPL0b/fPMz8RPqFPU
	AyLqCVUHJoYS75cb06T+77insB9F6j6FswiLk56t+Lf6c2fu4EzYeG0saOkqpneB
	ihDjxA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8jgsv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 16:27:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9151bf6ce7so3936584a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783960049; x=1784564849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D5rm8mmecnWku+WMvoOW9pOIxP97XIThL4X10qRCnxE=;
        b=ZBFov73vh4dKDmAo0MsPku4Bm/z37CY5d6n6/JhZjCmd/AWsZMLf1lNUc3QG6dtJJ4
         k4GY+pOUNfa7LvMAli9QfpWrN5a0PUEZMPP89EzJ9tb+8BWNuv2xWyu2iVpxd60Ptj09
         DSRIs+ybS70HM6d67aHZwTpJVaiUmicU6b45lpQ8wMfqzFDtlmP2+2nyukTbTU9kdoxa
         LY7TnSYbgEZIB12bOdnscQiYAcAcEj289n5dxvavKK9v10/GpnJElyaxL4yC+zjSbwMe
         MngXft6L2JU903weUg9plxMQcjlavH/f5kFVTkZOKUo9fU/ctR8IeDyHHHXvDs6IBZEY
         tDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783960049; x=1784564849;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D5rm8mmecnWku+WMvoOW9pOIxP97XIThL4X10qRCnxE=;
        b=cHpS+1x7Rd8QmgjqdKVYzILvp77SoOSzqVKIsbGXW+/flr4t2gdqqwmtJ8y4mcAlHT
         fErNqYD/tv3Mr8ncknphyyCs2P6ZUq2GhnbJ/i644Iyu2/D+c4ucppWp0sCdkpBQuHW0
         Ch4va4XnkeftflX3wpe3aXxMZlSVq4s0QYFo/J7FnMRSaInS/WuIfFFjTDcN/z/7BClZ
         xGRHD5pqxsfZ3/B/JRMsLItxtxhiMB1Z76W2e8jygGJVM/37gENEwsBK6XfyUJpCotUb
         X+nq25DDmwSRM/5sSdPJ04nKdGDZR8tiTwkUSWi1UiU5e2x99jEmvAumDRKbDs2mqTIe
         Es7g==
X-Forwarded-Encrypted: i=1; AHgh+Rpc0rAmXNwxDstD+Bui08hiJya6M4zNdpHXpo1yGvAoU3zUF7YTSmlvhrDLy283cY6LIcpZQAjK1ipOpyTnaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD11CXPO+Ttc7eyipXIIYpQ5yV/gaHwbXHn0Xl6GjbmtaWRNq3
	aWg5BvpbJwYxm1KxOJ0lemhGT9oaJDsbUl0mPdKeQkL5KQOB1KZOXyyXG7V9+kYM5baAyDpppki
	wZrDhMq3JGhCj19ksylw26aZQSzNvQKoCc97Mo8YFAkn/KRK+KQqmnCQZXDhuNLvlqRepiw==
X-Gm-Gg: AfdE7cmxQvbJShsOJ8JARu3uyryYm4nL7ddAALuHVKchgz0dTsAM8xn3sgIuhAeHXvR
	r9XHaRbT1LKa5UAj0otrni7Yy2Epkr08ISgFG+iuBK+u++jBvurCUd36o/cngt8Tmj+Z30ztH7X
	hUgu+femw11MHvEudM0HcvUSO5XN1dJhgkZpSKpX2IxMQuoZnFOzQQJCpr4lGjtM0nrVqOGQeoq
	AS4+WZcHcAzXI48jn+knWwhJEUiRE4OoS83QKV0zvoY229Z5mtEjgi23HxuFXdKnXDdmm+x6ai7
	TyjtEOr2QN5MSzBCvt+VqLBcy9pAFIA/GLKTA9qVz2RhrgoWO+iIbEXRWftn/D7cqofb67ry9J7
	E4oqhIKmVpc/FGHaB3UqCncpUo/jTRTgMtgQ1opIdIoGgGj+lvindgPnLebS17CNwF1ON
X-Received: by 2002:a05:6a21:4593:b0:3b4:6a23:6ba with SMTP id adf61e73a8af0-3c1109e034emr11007106637.26.1783960049213;
        Mon, 13 Jul 2026 09:27:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:4593:b0:3b4:6a23:6ba with SMTP id adf61e73a8af0-3c1109e034emr11007082637.26.1783960048822;
        Mon, 13 Jul 2026 09:27:28 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313c50c70c9sm28567493eec.29.2026.07.13.09.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:27:27 -0700 (PDT)
Message-ID: <2b5dfc9a-d2fc-4396-a004-4d3dbe30b408@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 09:27:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: implement custom wake_tx_queue with
 flow control
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710155443.1761760-1-jtornosm@redhat.com>
 <20260710155443.1761760-3-jtornosm@redhat.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260710155443.1761760-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SCM6n2iSxWVWZLyst9UdRDdVcGOqcYBg
X-Proofpoint-ORIG-GUID: SCM6n2iSxWVWZLyst9UdRDdVcGOqcYBg
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a5511f2 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=pXPxGQ70wQjSudtT1GsA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3MCBTYWx0ZWRfXy76nfyBbu293
 YGXF/ykfa6OQai8mEgVvyR+ZkJkWqp6c5ahB58hhraEhDul019E1sKrgFr1bS90keOM3LDy+5NO
 PrAPvbP86JspZfCMw3bxL8AbhfJQ7Qc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3MCBTYWx0ZWRfX75YQd1NYF8Jn
 8PiLxcgqxizjruP8yOBzBjfOhMqJq33OE7U6P72WLIU3q4SeeIgVX1zda0Z5TsB74g/mUpQrkha
 W7I8zw3GlQLvt/ICNaYIgjAk/7QHqHb/MWxvBWIC3ddNs4nnEKdRi9FVIICjiko0F8b+J5R16iC
 DqAUZT107Q2xZI2sb1KEINwo/EuY3BdNRpymwSu+B0imXAJyiwUyc5hGUVoRWV9M4S4CfupeG9d
 ZEHMBwrbj5n0LwL8TGTjm/6hYgqXf2eWgAEaevox6nTRItDhZk4xGLIFg9qRfInyIKMqnEUvdzF
 sAihRXQNiAP+UF8mSgu+Ba2xqi6XSTQ0/kTNq32KX0FVCX/AVDDrOq1KCJCaZhWqZhyIPRbdQb2
 3WTDz1AsiW8GtPo8FyaaABwaG4pVdOEvrKDzmNxQ5PS2TVwwogHzLcN+a3mt0Kpheq0lLdBJD0l
 GrcY6KJkdnFSiKv78Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130170
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38988-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:jjohnson@kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7446574DA34

On 7/10/2026 8:54 AM, Jose Ignacio Tornos Martinez wrote:
> Under heavy traffic, ath12k can hang and experiences -ENOMEM errors
> ("failed to transmit frame -12") when the hardware TCL ring fills up.
> This issue is more commonly observed in VMs with PCIe passthrough but
> also occurs on bare metal systems.
> 
> Implement a custom wake_tx_queue operation that:
> 
> 1. Checks hardware ring space before dequeuing packets from mac80211
> 2. Uses per-packet locking to serialize ring access and prevent races
> 3. Syncs with hardware state to get accurate free slot count
> 4. Returns early during firmware crash in the same way as other tx paths
> 
> This approach follows the pattern used in the iwlwifi driver, adapted
> for ath12k's hardware ring architecture.
> 
> This prevents hangs, eliminates -ENOMEM errors, and improves throughput
> by optimizing resource usage and preventing unnecessary packet drops.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Just based upon the description I doubt this will be accepted. The ath12k
datapath team is striving to have a lockless fastpath, so adding new locks is
problematic. I've BCC'ed the internal developers list so that the team knows
to give more constructive feedback.

/jeff

