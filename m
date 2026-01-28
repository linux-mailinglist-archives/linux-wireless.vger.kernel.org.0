Return-Path: <linux-wireless+bounces-31258-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJCmM9CTeWmOxgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31258-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 05:42:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB999D0BC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 05:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EE9C3004439
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 04:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D62301474;
	Wed, 28 Jan 2026 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YhJLf1MD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PX8yiONB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A7C8CE
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575373; cv=none; b=R9x1P8TPQH4cW+Y/j1OQFtLCiN7oLGE0/LZEbvHqJ+xK4iAi5oNIsNdVEvaYLdCRwJtCcBmc+u9lT5GfOkgWFx39GTRGZ0Ft86q6ZBTBm64vA0l8TMIro6fFfALl8v1zVi3xxwZnvOYADfpuogQPLLWCHJoSBz32OYWNr9YAEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575373; c=relaxed/simple;
	bh=3sEM0WOZMV7Oe3pMvZjimYrUmrH1BiaYzDj9qFFtfhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAzxCyvrYDamkXmyxAutxmmUDoqlNjiw58MZmLw8GPnmmIXI9iiDWsq38xnp03EPfXnNi4fWVoT0tFNjdrA2QqFnHGVVdnFtp+2WMMlaUh5ICTNAKmkwgB8es1AOGqAC0nmZkU2sum37L2WpquRuQK0nVxGDtzW2BAp6A0Nmwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YhJLf1MD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PX8yiONB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RJ0gKV2436397
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 04:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	01WPymxPr6dFESr5iulugWLpSo/Ze9nDOyQFXTGnaR4=; b=YhJLf1MDT31LW7K7
	hV+GrsI6jiQENFBrJKTaHhcCfYrcd2zphxrwVf+ClMp3GkE0roL7pT3jdElH/Pot
	TcmoGE5IzML3BP7C6kE9QDKbixBJN758000AgS37+dV/2cjs+nJK5U/WS6OTdgbH
	KfWlKN3Ih0TGTXLq6rLhXvZAj5HwpUlSNT+6uYIN9ULqBWW8V9+nFw47Pa2sZe77
	zK2rLOB76Np93rEajMXM8UXaW22cUepexIcUpQ2NKL3HO7y+Slnzndg0jMtg9W0D
	GNKYOIY8fyzfnRPXSpB9wLQyFD6W9hah7LyiuZoArdfzgwKEXn/PnCeOmT77U6Gx
	KP31Zg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by355sj44-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 04:42:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8230d2a470eso2808454b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 20:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769575370; x=1770180170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01WPymxPr6dFESr5iulugWLpSo/Ze9nDOyQFXTGnaR4=;
        b=PX8yiONB6cbxcE5pBIddcrqYX1/C4ik1bt9COwIP+uXkRAtbHBmnnyIf+5jd0TVKa1
         sOAVPeOpXQdlPB34KfoRuMhVYC2AXyvKcaoEXZKLk7vJAFyQ6FwLdK1oJhIMQxuU5+16
         n+O3v7o/k8la32eIucXKXb7WOgA4OAFIcNupkILU52l/SaNWBdPKZPwKdGq6aDs8pCYT
         lWI3tYqyxZ4KN1HpwwGf2GD7Q+7rqv6+bk6XhSHAA8HQ3ZbX4/oRFF2pNsZcqFVbS7GR
         3Uqwr+quzlqfSlvh24rCFRoShbvrw/IXAMOVBXSVyDhF7l4mCQhR3MxcKZrLgzVyFAVB
         +aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769575370; x=1770180170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01WPymxPr6dFESr5iulugWLpSo/Ze9nDOyQFXTGnaR4=;
        b=inoWYFkEI1N+RI29Fv6uhtoBn2iVR3WDyGrNoZSEVglxFrno6R1FwbQEOML6Lfhvc2
         GmanCT4l0P8nQO0ct/ceOUF6jcF16qSfDxqed+K1wJYBPWgWjyT7B31xuD7ZvJHgDFUv
         UYPkVTqmLXDAorBkZPZ8w64cOWMZo5HhbRH7MCLfdq8veNnWHmqQT+1XPDO0lQ+KTaDy
         eeJBk4QfzrbsQA76fAnxAqHHHxAUINuH6yQn1myH/taOzJireJp35fCmPDLf4S2qNGyo
         imNQjgoepID3bMlF8tAlfqZgGFq/F9ntV8wgPtvtuuvqLFYdYztgfFBkRKXLkhukbVJa
         WTJA==
X-Gm-Message-State: AOJu0YyeBcedZn9hmG4KCJmTMoiZJROn7ubZzjAuyXse472tTRcXivQg
	N12WoX7xmCvDeFcVkRGnL6FxthIVS+nQHJYD5FY+nKyffd55DZTIYEpipTeFjmodrAat+dXBysN
	XGBFF8unR2EhKn4fHD1KHvkYjBwxdzGl4dxlQm11krRzFn+lJcHPGYVGHHMebgOTuLU4MeuabVS
	Zjuw==
X-Gm-Gg: AZuq6aK61pZ3h5w4C09KwW9VKMyI15yH3GfSDshDpGDW4UqXe/k7yff2SvBcpa9Qz4r
	t2Dj8ymR9K3mKxiHG+TWeiVV262XnicC3jJ1wMAjsK/5wMUFu11BacqyzRxZDmQYiK1V14l7jRK
	7faM/sE6SAJ957Qwx2TZLFZdgZHL8wUuyVLStBVW5fNxoJ+QQo0HvFmHoo7katVp8hhymKMp6xN
	CxZj2jiOcmwddqkFBODWNkj3eLGH52HwsT/kkz+zN+w1wMOBUFuKuOqXgs4BJp60D+qmu6dQX4c
	T6dVs0OMTrggsmasoJcX6PCC2pV+8y7bMni1rLaVv85L7vexBIgf8aiAUqEnuL2hprI64Uhri0E
	QmJQZgMIQQdPpeiCOnR/LFT759MLDigb88ivUC4f1gy/nTNevngJyO8I=
X-Received: by 2002:a05:6a00:ad02:b0:81f:2b25:ca73 with SMTP id d2e1a72fcca58-8236927f93emr4084126b3a.38.1769575370100;
        Tue, 27 Jan 2026 20:42:50 -0800 (PST)
X-Received: by 2002:a05:6a00:ad02:b0:81f:2b25:ca73 with SMTP id d2e1a72fcca58-8236927f93emr4084113b3a.38.1769575369630;
        Tue, 27 Jan 2026 20:42:49 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfd729sm1059822b3a.44.2026.01.27.20.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 20:42:49 -0800 (PST)
Message-ID: <a1df48e2-bd02-4d13-817a-4f27e449f93f@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 10:12:46 +0530
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
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260126174049.1370659-1-pmartin-gomez@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YNWSCBGx c=1 sm=1 tr=0 ts=697993cb cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=4MSwVuzKff4lAtYpjw4A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 8m2uSJ242X-wVKDkUR68ETDElQvYoNLE
X-Proofpoint-GUID: 8m2uSJ242X-wVKDkUR68ETDElQvYoNLE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAzNSBTYWx0ZWRfX9YMy7K26CbYG
 nkl6j0v2KhnPA26a3v8nwAfRVS6gyJsdT1NqlDaM2NtHvdKHHybtNeJrL+ONhPONoUSPhG9HuSn
 xRFWLP7EG0UqDe/kqROba8EzmLM4ZVp26sPM5j6Oil6PACWV0m5ZNHq/+7Yw8dEsw4xsSLDTqxF
 JrzFSTQouYlNmyjFOyCJqPai/k+8SxoJ+E+q6rYwFFroZ8Z+gqT6C3i/iAhOy6zXODgiSK9StCF
 7eK0td9/xjaRmAPVsd8MGUm6VClI7rZpwCpu4q8c3se8vsg+G9g4bWYpn2cFMNoU7MnFv/W5VxD
 E03HMyUBAtopH77Vt1DYeWW1PgzJNOPeS2pJNyUGDV3NRE+okHJ3vj17pRPkkqjjKHYOlfbjWaF
 G5GKtNdkrdbcYgAd/p1qCl0KNI4mTEkBTLoqS6DbT37qZOrcR+/HoZhK37jBV/UhLPkIovXFt23
 9tG8kGL9GWfN2wSMCqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280035
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31258-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,freebox.fr:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2EB999D0BC
X-Rspamd-Action: no action



On 1/26/2026 11:10 PM, Pablo Martin-Gomez wrote:
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
>    &peer->rx_tid[params->tid]
> 
> Fixes: fe201947f8bd ("ath11k: update bawindow size in delba process")
> Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

