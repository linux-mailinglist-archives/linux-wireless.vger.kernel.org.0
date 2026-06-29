Return-Path: <linux-wireless+bounces-38245-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YYMnFg3yQWqCwgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38245-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:18:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D32176D5D12
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:18:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="l4ctPr/P";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=F0mT+21b;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38245-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38245-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D7EF30039B4
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54495218845;
	Mon, 29 Jun 2026 04:18:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2861B1C84CB
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:18:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782706697; cv=none; b=V0ODYxhfl8d+8SAfSf6jMTGOUOw8+13/DSNIjHxF99rn3jtmui4VME/zw9hPk5tZsA8ZWwGPBErWB8Y46nPt8eBw71MbdtcrlOTGeNMbUBLteL8sXf8f45d5aIr5wxw+9KQdZynIIHF9b2q4daKJ9j+n5D0lbIl88uy6AqikKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782706697; c=relaxed/simple;
	bh=PNNxMDPb47ZFZ0cX3cTcVZyPTJYhPYfKsAnzek0ySM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Or+CPocLapMX+0U5a0eeJxj9gC3TQ1vSy2Wb7FO2vJLM4EgNh1646w2q521RZ2Ryp8CVYoGJ0STwkSCKwVs1wJfxdMTdBlyGfanRlDGCooxutC0bvFmcdSnIkx/wnEwZjZ1LDFQZs1ZUQgIDZwCrzmIAwVREgAQf0BiSO/wnxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l4ctPr/P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F0mT+21b; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T2ctgd1504331
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VjJcQOjeRczqv1vibZWVoMW2p5r1ZyS91QzfI45NUJ4=; b=l4ctPr/PVGYB9SwD
	hhUOpZsAuPhwgQls4xg6pS2nlAPEShLClrcXZJEKGPRqKAxcxagBbPBr8Dxh94x/
	5EXGpFDJdguJ3ab/rpkmF9MPu4sGwhgEBVrlSYcjzfeFkFZys6yE2CbUJnPCWuxe
	f+i28rmEZ+gEdm9oiVqaaLeL9NaPkX3JFOeDcfApNf1qZ3r+CnUKrmWi5neN/A0C
	jMLnmeZDx/ySLvKBgaRvFbCxZZ39xDzx/winjue4DU+rQz0835wTyMFyoe2wkNYE
	sb2q0g3/N2Xa6GMpGHfK3PKiF3X0fiXc+ApADOWd65hIPbZFIRhvZzhYNB7B+NbS
	qH9Qdw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7v9n5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:18:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30e85f5bc9eso5299838eec.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 21:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782706694; x=1783311494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjJcQOjeRczqv1vibZWVoMW2p5r1ZyS91QzfI45NUJ4=;
        b=F0mT+21briyjoYy5ZkpElOpOsnme54NH1HARBleCvZbrrspHIjLEztWJcu2E+WU7UQ
         3RpzAuRChe6PZAnOYHVzFOprlNYiyiGM1YckoSp/MDexIaMmIqDvQqfSahYwpzFVCH8C
         k+uR94L2rWFDKOemIkpY5dyx3+npyAnMNMEV889hTKVP20+yx18I7aOBul5VXkdyRzO7
         PgHUsaEQoKRgYxpC9U7gietv5AsNIZgCz18sZfJFJC5jsSa4V2nHCbU+yEMrxSqnPq5S
         1gZINLRJ5t2N1aaZOQDs9L9BvCQUajVCmjQrzW9wxAR36d4rL1jKkrpiuYNF+nadt5vF
         rbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782706694; x=1783311494;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjJcQOjeRczqv1vibZWVoMW2p5r1ZyS91QzfI45NUJ4=;
        b=IT5cxWNvi9Q0FpIbQH+NLBWAhK45jPcLFN0b1+o9ml/wRCf2EmAlyF88pgiOdCpL2G
         gR8c05vuTnBhLNWZn235FS7Sds0G1l0z4qwaB8H/ng4dZ/HWW1i8kRHw8HlTkIMvuW+L
         2/C8+x8d3qt75P53p72XKkdxnzkTT7dZhVG/+Upczg3UbLuF4BeJmVqo1Lztah5xFs+3
         lWfsSbBDsg2oXR6LNeRCB54ZqdMUCSESOayHo0n1KPGwmZmFlo4kLg69/G4Gpw/GN95X
         kCn9lTuFdZNnQuJKIUhGlGjbV2jlmZjM/RhDyFsl3NHxFd6mANgWK+VEEw6U4Al7KQZh
         quEw==
X-Gm-Message-State: AOJu0YzPuwF3kudQ8WjJR/tiB4gfSgorP7qLFjOkjRSBxvq51WYUo9LJ
	DRJoTkJI2dc9nYU6VRg/6dy/TL4/G7dw4hGKMYUsFtou8Nw04TX9xJ/aqHi3stWr8THTaBcLT7q
	fr+PCr9uR8e7F961jrZQdkfbaLxFynvgd9BsUtlK2pcBfEdAB+f1fX3Yj7RreeI7SD+3QKPd7EP
	UAPg==
X-Gm-Gg: AfdE7clDNRk4AvLiYHXciMnnSs7ZDhIjsmvmHSymZwf+A97PKKrWzgUHV0FRKYYFYAV
	6Ln4rruFeuMk1ciqyyl/jJQB3sdL4Ry4LI+YH0TThYVnUM4HU7rav/vyH7ey0vd9mQXTsECU5l+
	KJOi3Rgp8EQk1jynqNC2Ish86eqkAAkmSeMCPZuj4u9SrBsLoM/+kmdTRCLOkKZsU6ITQBolaQI
	N229GnCo1odPgTIQkAn8947ru6nkSe994mvVy/0cNM1QyqxkxfzxS0f2RRzXCu+Uq3jCaR368Zg
	fPmBNHDpZHwDo+s8bnq6peHtbMPtHlajF3w9LTYe2rweesnvguPBya7Rc/yVWSXqchwW4Oj7vR+
	TEtJpT8ayr3bDDL6mBQLKWQwfdNEDrzXawPxY0gvsvdEvDTD4BEU=
X-Received: by 2002:a05:693c:2281:b0:30c:689b:c59d with SMTP id 5a478bee46e88-30caae2f3a6mr9483380eec.5.1782706694522;
        Sun, 28 Jun 2026 21:18:14 -0700 (PDT)
X-Received: by 2002:a05:693c:2281:b0:30c:689b:c59d with SMTP id 5a478bee46e88-30caae2f3a6mr9483351eec.5.1782706694004;
        Sun, 28 Jun 2026 21:18:14 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c664sm45388026eec.8.2026.06.28.21.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 21:18:13 -0700 (PDT)
Message-ID: <1b3608c0-9a1d-4c16-86bf-f625844c5889@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 09:48:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: correct monitor destination
 ring size
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260616062342.4079796-1-aaradhana.sahu@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260616062342.4079796-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX+PT6dMtn7wDt
 6Dg/K88CMObN7XiuItoJYf12oie2cC9f8PHNQuyMJa7hckHM79Vmv2GZqQRhaw0fuwkNe6gR6xU
 aczBAeMIsgGbc1zlJ3M/MJyqrFuiOrH2jbR02jS9WOzs4xKxNL8Ds/Amj6Bns4eHbUJyXzRecvP
 L1CPcb66ZlQwMelgMKzsYMfqFavVmmLaJYyEVAPTvMu3/lzpDXllHUGjoKWq6V5YRryrrdWkzY/
 FrFMYc74VPi9Ms5Z/6jVnAy5GWQBW/TDjH8T1hdPTjLGsgAW1MXdf8C6okdCvc7S1g+w8DVFXgI
 Wx4sn4nI+TEempJqPlNkxseuOmkp2zRICvQxQLxFSDRbcTip1s+RBcVWNf4tHAddYBC6NrDx3r0
 49TDZEusuyfT/OkcMhr439mO9/PUwPFNXR4O9HoinezlPwEJR95bIrQC/7KtbD5G5y1GQYyHa2g
 JX1+6KHZYTEbV/F/0eQ==
X-Proofpoint-GUID: uvd1Am_S265ImL6V75ne_Ryz_uAvBbm-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX1c819YFJrg5A
 aPIwoAXJPpG27MpDMtWrw4vkgKPbem5rTleZ3tX0lC8coUsJp12WeB2y+SX+NC+k7ktk7/Vw2ot
 2iWvy6B1T2AvcvoFIbAwlg+rMyf/Wbg=
X-Proofpoint-ORIG-GUID: uvd1Am_S265ImL6V75ne_Ryz_uAvBbm-
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a41f207 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Vof7ml1Sp1nGWk4UEeMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38245-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D32176D5D12

On 6/16/2026 11:53 AM, Aaradhana Sahu wrote:
> The default memory profile configures rxdma_monitor_dst_ring_size as 8092,
> which is a typo. The intended value is 8192, consistent with all other ring
> sizes in the table being powers of two.
> 
> Correct the monitor destination ring size to 8192.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Fixes: defae535dd63 ("wifi: ath12k: Add a table of parameters entries impacting memory consumption")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
> ---
> v2:
>    -Added fixes tag.
> ---
>   drivers/net/wireless/ath/ath12k/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 742d4fd1b598..b488bd8fea9a 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -49,7 +49,7 @@ ath12k_mem_profile_based_param ath12k_mem_profile_based_param[] = {
>   		.dp_params = {
>   			.tx_comp_ring_size = 32768,
>   			.rxdma_monitor_buf_ring_size = 4096,
> -			.rxdma_monitor_dst_ring_size = 8092,
> +			.rxdma_monitor_dst_ring_size = 8192,
>   			.num_pool_tx_desc = 32768,
>   			.rx_desc_count = 12288,
>   		},
> 
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

