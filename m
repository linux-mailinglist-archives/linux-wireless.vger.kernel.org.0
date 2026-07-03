Return-Path: <linux-wireless+bounces-38550-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KRECFW8xR2qKUAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38550-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 05:50:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B46FE43B
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 05:50:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=eUlNMGse;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TY6ze7PE;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38550-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38550-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B8DB303FFAB
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 03:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F530F80C;
	Fri,  3 Jul 2026 03:50:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1B314D34
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 03:49:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783050603; cv=none; b=UGa3o4ay71dWu7A2hLiDdOuZt7eUMMb51KRbV/5FdEQoCAT4jtQj0SsACFC3Tw5UwrIS81pVv18+3j6xZqZlvwJKvLw0KcOhFPVKyPsHCnALdOkwIWqWxOEXbDlpKtxp2yeRdPxwp78nAEyiBTtDR+tfedCDlrHOAWrycJ0EWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783050603; c=relaxed/simple;
	bh=EXtmd+cfILcV2K2APysW4UjvVq6hOcdyD9uif+L416Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktZmFuk91zdJv5D7B1CHaWU0d5sC3JgkGHWH5N7S5IOXj8/H9DnnxdR4cbtq0QC+PtDkbE+kshxgEd9sHujwZlqqIQMg73oZ1EAOVeVQVm7GN6e+O/LClDSEc26NKICPYwqVAnQT/7Agv0sQUQM3Mkmcu/vTlSvyMQ80JPwLeLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eUlNMGse; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TY6ze7PE; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6632rOr62645643
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 03:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Di5bK38iUyM7oXEH8y3ao0I6FWmFAVhzxIH40kS4bQQ=; b=eUlNMGseu+mwRh/w
	SSGtlBQYDitQ/80MFt5eZywkX06cEYzQwwiKXiv1uxAq2lUVumXZuruKLJeUXwkc
	eSr/EAkifNZx8Ul5o4oNlTZ+eFOAxskVl9ibc/wT3p5+jC4DDaKFNUfHHtoQL04X
	q1elBArodmkZNjhRkhAi6sEeP/rfybSdjP2n9MUKYI8d/YEopISbEkBSE0oG1my5
	9CdM9IUjAqBNAKZC/Wi0ZZh1WEmp6MRkdyYex3xgd4PvWPbBukyFx1zt1DW9VNjB
	RkHHF/sljw1hfWA75Vr2R8TzT2KKxV6DSWLovbf4Oz2J33F7h7VX+baa0SoLA2dP
	exBmhg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b587wc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 03:49:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c9b71388fbso3129005ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 20:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783050593; x=1783655393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Di5bK38iUyM7oXEH8y3ao0I6FWmFAVhzxIH40kS4bQQ=;
        b=TY6ze7PERwiV9AMnzMKtpI9i0WCoH6M5JiCQ3vfTrtXgPVg91CsVoPmuTmVY1Goz6z
         /4siDCxtE3k1CtDLn38nLCDzXXhqDqxGgdFaiWqa+of3wRQlSXbFGD/WWAoLF0Wucu+2
         B04qk/s9UyHbMxRTSKQpBELXn7aWhqOv68IrHGKcdOJfbrIrPqap2j2aVXF4irn2k3Ft
         XB4AiWfzGT8zd6nU8XFrjou632OoCBx9LFJb2USrnvFZ21qeEazOlVg7CV34TRbomPkv
         ETizIHu2MbqXKaMy1FOu6uIZwdXBTOjJd46VUmtoyG3oXShdbXgI4jTTFXVKO8ixjcOH
         L1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783050593; x=1783655393;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Di5bK38iUyM7oXEH8y3ao0I6FWmFAVhzxIH40kS4bQQ=;
        b=f8zQk1dISTZqscFwV2KKg2u89TIZb0w2LZ92ZDswCNYkVWr5irXqL5RRLHlTClxZvX
         Od72KtTgoz8x4EtXBBzWAFb1p/rxGcgpidRnfnpXT0Z/rsUGXRroeexaxK8Qsar4OzbH
         5zzFDRwsrgYJaMoBvG2Lj674/5io+53LdMOHBjthn/2xDYIPBioP/TnBZRaWvnn/90hr
         I/NdIul4BOKSpfWtZx/bX1k5FMaJdV8xD/mmM5Bjr/JuqX5TyjZHuRTZ5hNTbzFc7o7g
         WBJ3y+J5X3gzD6znqE0AR6O2W9dESPN5QWbPoxhkHb7Hau+0KiYw9eJ7PjgLw4yWuIv2
         Rg/A==
X-Gm-Message-State: AOJu0YzYv5Bx1KKJ/PgmvfG+ua5LIXrTzp4sRqlR2EUXL1o+i3fn1Zga
	Su8mZTeQPVDKcAINUYybCc2y4EzECVfD3vqW2FBuX5kvFxOWoiTLNu39YKn5jglQj915ne5x0k8
	ERQQF+oieljYDgisoe7bfjBHZ4xBbdfDpbntgJIzCWedFndFPNB0R8JhP9pDbTfDlhY/GEvqw+K
	hLbw==
X-Gm-Gg: AfdE7clsnq1pKLzqxk3wU/O2OUytel0goamXG6An65y05ZueD/hlig9OElI/Ge7s8Yd
	Du1Nc7bm3altdcw1eGvtvfqr1cSQROk4sIhrw+mwhohJiJFxEDYohz7+UoSiqzRLWA+Oh8HzOBy
	b8UY01U0hKD1Ja0DFc+0AFmWiRurqtdtajLnH98c7pNg5Rqmk4lhtjM74wuk4v/h5yBitp+OIo3
	YAsNlXFjXJr6BnkUMoPvqvzZAMpYPZSpLEALDVvUqkTiFNWlScooXgIYC6KprA2bXgEBx8G5DBo
	cNdCxOVrIUNws7laxicUXDF04W6knMF8DlSQ0JxfTGrQ7HdtpWj3+AbM8FvKHkPDBTlGdmA5Dui
	gLkGfinpcj6SX6AIIZo5wbW3H73CAn7f8Qidxds+PSdu0Ht2aDjg=
X-Received: by 2002:a17:902:fc43:b0:2ca:481:de45 with SMTP id d9443c01a7336-2ca7e67cc82mr101177175ad.6.1783050593541;
        Thu, 02 Jul 2026 20:49:53 -0700 (PDT)
X-Received: by 2002:a17:902:fc43:b0:2ca:481:de45 with SMTP id d9443c01a7336-2ca7e67cc82mr101176825ad.6.1783050593087;
        Thu, 02 Jul 2026 20:49:53 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c870effsm17429431c88.12.2026.07.02.20.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 20:49:52 -0700 (PDT)
Message-ID: <d9bf4d8e-41c4-4f4f-9e32-08bb41a7da3a@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 09:19:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath10k: fix skb leak on incomplete msdu
 during rx pop
To: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>,
        ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260623064355.1876743-1-manikanta.pubbisetty@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623064355.1876743-1-manikanta.pubbisetty@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAzMyBTYWx0ZWRfX/5wCDnuJAnCf
 UdK3yuyXRoEfAfzkBHG+3lwBzvOCQAmblwSfwQyCLj6TLHKcL2SLQmKT89baR++S+rgpjhQ/Fvu
 BHBW3S05ZPU/qXf70nCF6wRKXMlN1Go=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a473162 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=PSAErUXHYyYb-UPQJNEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: zFYSF1rrAoO0OMwFvbrq7J3cGxc6Uhma
X-Proofpoint-GUID: zFYSF1rrAoO0OMwFvbrq7J3cGxc6Uhma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAzMyBTYWx0ZWRfX2L4Ck6Py6GjT
 OeQNwhXwKgw7nL9Oc3qeLbSObVzExwX47W3dtD552GvVm+otgn5PzHKMJeEfxQkAhfS9oMBcTrG
 4xYfO70/ntVjVw1pMPtaXeXNLZbtRwjZiSa9K1f3RG0LEvjsbZL2nTTrsN//nClWTfN1W9SsvjI
 DXJQu/uT17e4AmEtae/NmzJo9bYF8vPQFxnpTArOS4eSelurlj34OWkzyHQsgA8AEEgnU8QO/em
 Hf3UJMfmmokcRTrM491+ZpYswfTMVp4dC+rY5lMWzPAXNwgh8BLMZwwWaJL8vyzPdOgCyZfan0F
 JA55P86JZuH45FIK+KJeXpj9+Bz2u9zmaSm0RRuE3iUE8KeldYNZXXh/9ulwTkhIyRI3ph2N1wL
 V6YR2zIMzqPHIasKFZ56yu7C1sIx2E6QaFVEQAI7xgN2W94H0MgkcYSJ6bY5vyrPDx+wZwvMpdw
 ebQhy3IwgGPLQXtOnsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030033
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38550-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manikanta.pubbisetty@oss.qualcomm.com,m:ath10k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A16B46FE43B

On 6/23/2026 12:13 PM, Manikanta Pubbisetty wrote:
> When ath10k_htt_rx_pop_paddr32_list() or
> ath10k_htt_rx_pop_paddr64_list() encounters an incomplete frame
> (RX_ATTENTION_FLAGS_MSDU_DONE not set), it returns -EIO without
> purging the skb list built up so far, leaking any skbs already
> queued in the list.
> 
> Other early-exit paths within these same functions already call
> __skb_queue_purge() before returning an error. Add it before the
> -EIO return as well to be consistent and prevent the leak.
> 
> Tested-on: WCN3990 hw1.0 WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
> 
> Fixes: c545070e404b ("ath10k: implement rx reorder support")
> Fixes: 3b0b55b19d1d ("ath10k: Add support for 64 bit HTT in-order indication msg")
> Signed-off-by: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

