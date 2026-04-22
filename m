Return-Path: <linux-wireless+bounces-35204-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBoyBwV46GmVKgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35204-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 09:25:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 743CC442ECB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 09:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A640C3012C7F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A836C9F0;
	Wed, 22 Apr 2026 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pIltHJMd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KZiZ8YIM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8F370D43
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776842537; cv=none; b=OBhKTIOc+4H5KaBpdWdgjWjgj4q+MG4gLCUlcYK56G4UXP15lixBnYxaT59OTVwPWqvHQEP5c5IbZWFB+v6H3Uizj+h24iBWU3lIkYjhvV3j60AxjC4XLLn8RgdHP3z3O5NNhqXsqMTUtLT1hObGqs9sZTPguYuHRaufgkOH7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776842537; c=relaxed/simple;
	bh=ZXbH5y+tWJ9XW57g5zlTICCqaN8g6RgnO2K9CStQ9Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0yQyFq+gpomvH0dFcD5jomLb+qQ0opOSQWxj5jWlnvFi1NAmfm9dhg4WdTwjOaJDUe0Bg/zAWynNGG0NTesBZruasLZjFGwfIgODx+selRBbK2plXBW/HjmIFpnPf/i9oBRYrNzGC/6ajelRkXPwQrI7T4eKtvrZ3HSuMVZNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pIltHJMd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KZiZ8YIM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5YjGc164470
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 07:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OsMFhzh9B9P04QQ52S0OECWBliG0c1fRkWxIyLVs8XA=; b=pIltHJMdN3HD7r2R
	cLYp8qGwpb96c1WnPoNi1S+D7MIVT+WdXbU+U/p7zkDoIESf+uRidspEA9exmfCJ
	4D1YBXa3lQ5+fv//c338B7ox9SGDkTKoab1pnpEnXqiq9mA1n+BDvNLQBAHq20s6
	EbuzFclDYN4eWtb/ZwwC1CgD3Vzs1Ps92cD5OjaF8G8XMTh/XJfTwEr+XPt/r2lR
	qwz/9KmgtxofsTtfsiVk3qF22hT902z7vhff1555rLQaXSdU5WDxS+whx/7urkXE
	9S83QqIBBjGULOZkE7/88l8mm7FeG9wUnSHLECdC0lECX0XxIq0VrSSJajXbstmm
	j6dXkw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenhj7j0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 07:22:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2ec17dc21so58260425ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776842531; x=1777447331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsMFhzh9B9P04QQ52S0OECWBliG0c1fRkWxIyLVs8XA=;
        b=KZiZ8YIMdLc/rsFIKrcyfe5hwkCfwCtLa2tQMIRT5ralCJv5SERx85q5YclC0YbSNe
         6pkHQhYJgsXQRB5RypXatln6/5/qs5U5IO7P1i/JLTvmb5GXucuI144WTxlYwoOsB9Zy
         nGmUKZ9PDLN5BKOhrp+VC0HM0VKTnpWhaxxh1R4rn2cHrxS/EHrrTYxuh4E3M8Zs3mgD
         H42DHH8dPuhiXEtjDEDmak3Tb2Ww4/Ouk2cjn3BVtLLQoq3LuyR0QDZ4llqvH8kvhAOO
         SLtZUs+pplwn1P3Q9nv8Cwcy+lzxQ5Rh9/cInZYLf2IYzNYTd0wt6R7JupAran1dQ4CJ
         l7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776842531; x=1777447331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsMFhzh9B9P04QQ52S0OECWBliG0c1fRkWxIyLVs8XA=;
        b=OuxnifbqjAhD3qF0vaO4U8qNW1lkwZE0+AFYAWhestpRv15UVG6sUfyzmjkeRr1xWZ
         kreHZsfw7Op6t9YDNm9p+4kmmVpI+lkGTEkh8+2CX6brDLIpnYUKZD3eM9NAzyjIEEwo
         HPS8Zdn0rHHiRqOLUgq49c19nb6r3CuA2c0KfDEjEnnvlF0eYLkCVsmQ0kDnzlaiuRny
         RQLA/Ltm/aYvwEGWgYQrGpcZOiVxwKEwDuPnXksdxAXHvZrKRmn3MWYZQdo7/V+LubBm
         uqBZEsc1h/Q/LYh9bnUIa7YKia4j2YhzARBtwH4TFHbMmWPRaX80RMuc1IYLZckh5dgr
         i8aQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gNjFr6poQTCWpa22jjNA7sqPjSoMxnceMUoBQ+mMsHjyi25FHQdLfrZ+R2q5MMLN2S0rrZI6gA31GbS/jmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVQgA7EuiQRjmegB2MsxljyElhw+C24T4zCLJHLmbX+EIyZ+0
	7AOn+qFXhCsAn9+IkH1XOmteK5EdfFnlcyPESLc8hTxV04YDcsR1pRukNE0dZgAfJ01hfQl6hUC
	PSSi9DiItdhibrt1JIFgoArY5AyupBSI/s9MI3aQcde2pywKe+AVWDwwyM7hDwJeAmk3oow==
X-Gm-Gg: AeBDievJsp3IDP1egTApFI8k3sbJkJCrWS5QYgbHXQE6rIT9PLOXQZL7PcZXHScRNhX
	CDyrIH/3/eS0vs1Eo0X8TNWDE4UqyzYBelGtLGhfBHJsZiJmse/DXbn4D8FJo2UzslVgZcYM3jU
	6zpXrdWamGoaRLslyDRqQs2Ja5ws6h3Wlw8qK2bkd6E1ERQ0ILFUanU0Z3CGJWha8LjGGqq6UQG
	7q0FkX9HNVyLzABrRp5ZlXFYXCKbQ+Pdy++zz7igpDUC+WQcb/8aVhf0nUIdk3O4LD0qa3hpDoh
	fzz2Dl2Vm3ERk1yXM0Kdt6JaSFNq6MD8Sv1W693WJ4Db+YGAxh+AZn2jOeECQqGZCwfp8xnGmJc
	D1HrCmYpHLSNoF1LJAbbbISJ77YwAZrMQaR2zdOE2RWXvQn1H0BwpPfXXDA2lIfvfYAilLy36
X-Received: by 2002:a17:903:2c5:b0:2b2:4697:4370 with SMTP id d9443c01a7336-2b5f9e8cac7mr219783435ad.3.1776842528671;
        Wed, 22 Apr 2026 00:22:08 -0700 (PDT)
X-Received: by 2002:a17:903:2c5:b0:2b2:4697:4370 with SMTP id d9443c01a7336-2b5f9e8cac7mr219783075ad.3.1776842528163;
        Wed, 22 Apr 2026 00:22:08 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff409sm195396035ad.14.2026.04.22.00.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:22:07 -0700 (PDT)
Message-ID: <afa0f129-d8bc-454e-9e76-88cb097955f6@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 12:52:02 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ath11k: fix peer resolution on rx path when peer_id=0
To: Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20260417-ath11k-null-peerid-workaround-v3-1-d04302284486@collabora.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260417-ath11k-null-peerid-workaround-v3-1-d04302284486@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GPUZK8Csb03DiM0pGljjTmnObK_UQpe4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA2OCBTYWx0ZWRfX+o0x9vZc6l65
 KzwEuqQ3vnAQ043Q31jZK8g5c6YotvFQIdis4UgQzl7yzbpqfh2YrsFFh8QmRzByYRukppCTAJ3
 pr8BZDUcYnzKhtNKBHxhm+RPeJ92hNnfu+NJNP5C3Ld1CI/ZYfo//WVsMuWMD5nUhMDeNUXgxeX
 qTvdJnojNg2Iuf2Aa5ENRPekg3Vbe7pGw+rhGY8yzk1juN1Xtd5gI8IozkXC7IcLcYIBiBdABAi
 8V+8wBYWXIli/rqhUgNvrJT3taAZPSKaEvLQLc6AFAI/ZWinShFyL4k8EAHM9u3EdKxDVdn7b4F
 3CCE6dgmycF0XNpDeatKilT2wGWgtJa71KHI6ZdnwmyWu9I8L/MOA0QQOrqjqnFpikmglMY+8me
 aQOrJp4DDHr6pLiOwZ3XOGCRCHrhpXWXIbiu/PRgKatTDSDAioTAHzs/cVCK8sQHpaJKJQqqwHh
 Ac+OZneETcOC6M2ayXQ==
X-Authority-Analysis: v=2.4 cv=WKJPmHsR c=1 sm=1 tr=0 ts=69e87727 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=i3rc2wEZqLSP7JN4NF4A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: GPUZK8Csb03DiM0pGljjTmnObK_UQpe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220068
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35204-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 743CC442ECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/2026 4:37 PM, Matthew Leach wrote:
> It has been observed that on certain chipsets a peer can be assigned
> peer_id=0. For reception of non-aggregated MPDUs this is fine as
> ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
> based upon the source MAC address. On an aggregated link, the mpdu_start
> header is only populated by hardware on the first sub-MSDU. This causes
> the peer resolution to be skipped for the subsequent MSDUs and the
> encryption type of these frames to be set to an incorrect value,
> resulting in these MSDUs being dropped by ieee80211.
> 
> ath11k_pci 0000:03:00.0: data rx skb 000000002f4b704d len 1534 peer xx:xx:xx:xx:xx:xx 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 1 last_msdu 0
> ath11k_pci 0000:03:00.0: data rx skb 0000000038acd580 len 1534 peer (null) 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d00 fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 0 last_msdu 1
> 
> Remove the null peer_id checks in ath11k_dp_rx_h_find_peer() and
> ath11k_hal_rx_parse_mon_status_tlv(), allowing peers with an assigned ID
> of 0 to be resolved.
> 

Please add a Fixes: tag, since this addresses a real RX-path bug.
At least the dp_rx.c change seems to trace back to
2167fa606c0f ("ath11k: Add support for RX decapsulation offload").

Please also use the usual wireless subject prefix, e.g.
wifi: ath11k: fix peer resolution on rx path when peer_id=0

It would also be useful to add a Tested-on: tag if this was validated on
affected hardware, as suggested in the ath11k submission guidelines.




