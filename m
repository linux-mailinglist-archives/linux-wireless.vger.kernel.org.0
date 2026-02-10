Return-Path: <linux-wireless+bounces-31706-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOOmEn1mi2kMUQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31706-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 18:10:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D19B11DA2E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14877300C7EA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA0630F541;
	Tue, 10 Feb 2026 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7U7wFd+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SL6uJdVa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B351329E40
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743404; cv=none; b=SIhhcjylSQFJv83W6WL+y0OV6fiu7EI7FxKJl5YdVaEEH5Kosxw9PCoHqMS33VIGwzHQXHx/h401z1ciAtOAc0q0JpQmCoJGbvxFyiruub2QOEtN1hdaGKG6SUVrDN6w8xw77L3BzJH2saPdvaPQp+F/vFAKUtxcZ9nzD4/zqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743404; c=relaxed/simple;
	bh=9Pd4T+VweV27D7aYUmgg+TdW+3v1R8Uw5DX2pJ/2TCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yv0m2EPGMn1MlUzKXomE6Jd6aIUIAM4551E7JFOd/mrOanomO5OummY0S7/EIPFVpiRni0gCzVQ9/FoLeSXQEFzBa0pF/bCfnSeRro7rDe4H/0nXVbyUwrH8mkav4kzD7Yy2AJSZBGrd7WWnR+NOz9Rf8wOJYNRmDZKvCSt4FXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7U7wFd+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SL6uJdVa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AEuaNF2170353
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 17:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QA9pHi2J3cx2uUp8Toi2s81kS4xpkoxIS2NhUlEh+B4=; b=d7U7wFd+9jhDN5ft
	aLJnsazJfr5fDzHOKmM70AgrQ+SNM7u60WSrAJ2f2oT6+MIW89VgyiHHoh5ezuLk
	fasEjj2zBiOkZMWIkl9zfdTMJrBpa998pGPGMYqwg7sVMzmcOwQNIHm9xQKNJz7o
	daSiGdFyroOd5v82v0FL8Bqb2wOMmrUs/GtA7JcgLkouGku5jk0Hu55Oh4fdQuAw
	sRJr1/0bjX+GBqf/uOr/9JcjmxxzJokuOen4p7TZsl8f3hiEdmGH9GIFUKTkTP0D
	dGB2/8I3Pl/RVxewNrUJXcqv69kZGYNyL4s5FhM5P1elI6K+wRIy0a340Dg74CdQ
	6CUj+Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c80drsu9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 17:10:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aaf0dbd073so25736905ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770743401; x=1771348201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QA9pHi2J3cx2uUp8Toi2s81kS4xpkoxIS2NhUlEh+B4=;
        b=SL6uJdVaC5Vj2iUh4d8Esh33fE1jvqKFL3S8mFo1gfij4sBIDPfRNFkpZ5FZetxAbH
         g4POnUnR9F51I8F4vrZR+gjR0sZM3J5u2qWIwjzBTbR0CKAlmnu+9DcrlRmkmlZ3nO+G
         M/dOtbjzw7aK118MD/3+NTR/VSaxLuUYPt73NJ96xD7HyGRLszqqTJI0lnbLZIhGdqpI
         INBKlL18Y1z2bNgl4kD3tWDrwSXMlJ1y6cErjPCwCzQk33ppdEkC0F4WmCmU9lwluZMt
         xiPeSxXj3tEwLjhDfvn1Il54WTRYY32Vc2snPu+kuD8pOAevbLC7S0koXsjLo+zik/rR
         DTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743401; x=1771348201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA9pHi2J3cx2uUp8Toi2s81kS4xpkoxIS2NhUlEh+B4=;
        b=aB5AwoKOKmHp8M0WWgT0U21PX2x1K+Xmy81gwTwPolarjp8FF8bojIHVtxiGudKQyS
         w9iV0IgLvM7i2dcQaoiO6YA/iyiq735iseQyZY6ioorJjnlvuqBeV9ePNouvGpfuDB5p
         g/n3Ho9qMXlOeyJmUO1YIGSrez/G52RHvhs8TWVXXEN74HnVEBw1UsLXQPoTbiCRkNEw
         4GT+feHGYCP+TByROPgGBWxCuDN6oXgjW4NceVzTppei1ygUnhDlmyAhB3bvq/VBpsIX
         R7kt6GIk06OUMAEcufs38TBB5SU1jkK7+Vmw454DfpPjov8fAslm4Zce7I2Jke86L0JJ
         da9A==
X-Gm-Message-State: AOJu0YyEAi7P9UMe7KHNlK8x/nPxnbMZ6iVt/2bU/zpMOOkfISyyY4ZZ
	KPjh9yApD8jR4XPPZopLWrSaPq9aYooUNf6YT/XsFsx/TStldYi8yWuPPamTwVyDInuYH6UzxzX
	6ZBOulPDmrBSD3bnntwVCcVmLgLDX/RYLuRa7vzJXUPYSaxFIB3ZhHdWiV/BcgYSuB2HQINLtDE
	vlJA==
X-Gm-Gg: AZuq6aIvqxd4pbeMV7mq+PnmFhct21EC3fsrdi/sekuUtyBDGia+elVLWB8OeYk93aM
	I3FhwXsui/tfv51YuJBQXhZ1TA/wTyRihqRjgGYwi10cfVpwQfc4+QDlX2MNZxVINLc/NgMIbhT
	jSrCFr7tXfB/GXKMAq1Vo4aF0IiDgL3S/JZigUxLXd3HUzVb3bAhEkVmGnyd/iEgGjLi/Fqc5jL
	ye8a8fqRQQCqWrQIWQ6NzM3JrsAbwBYqKKeaKS5RWfkB1WrzwdDYqQEPY8HtDhcV1d39Ah3w4Ea
	66q8uluY0naq4PTxO7jL4aPJUlI6kgh/NyMuGCJyPNLfZsUQ+ikfNyhuth3q4OOuxxoB1F+i0Yq
	T7lWjy4rp8TZbMRtBH0wGeq6jaainrbJ6p8c5dNIcUS4/hkjEaeEDG+BtjEm6ul5s7AE1P+Pv
X-Received: by 2002:a17:902:ea0e:b0:2aa:f9d7:68aa with SMTP id d9443c01a7336-2ab1033cafemr34211185ad.21.1770743401215;
        Tue, 10 Feb 2026 09:10:01 -0800 (PST)
X-Received: by 2002:a17:902:ea0e:b0:2aa:f9d7:68aa with SMTP id d9443c01a7336-2ab1033cafemr34210875ad.21.1770743400628;
        Tue, 10 Feb 2026 09:10:00 -0800 (PST)
Received: from [192.168.225.142] ([157.49.96.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aad5fd6ae3sm99148505ad.6.2026.02.10.09.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:10:00 -0800 (PST)
Message-ID: <88fbbb46-0f2a-459e-8dff-2a7679e1ffd4@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 22:39:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ath11k: add ath11k_mac_op_flush_sta to properly flush
 pending packets
To: Florian Maurer <f.maurer@outlook.de>, Jeff Johnson <jjohnson@kernel.org>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <GV1P250MB14333A5BF24623C4753A10E1E8E0A@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <GV1P250MB14333A5BF24623C4753A10E1E8E0A@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE0MCBTYWx0ZWRfXw5xlB2Kti4cZ
 R8o+tKNHiSOsPemaikp1j8tdw1syFIH68+e5n2AAkRu+DcKp+gMcTZ8BQGBq3WE9t8mVsriLNdW
 4wZIO4KYPdeac5AN0JiKvszu8Ykbimx+3588SUjEdRfkFEBN0ZNvSREk1TgEvZqv37aAT192PWw
 SsIRjbM546gaqztE4LgSbfjqX7/c+NkKH/kdMQJL4V5gwjt0t2bHKtOQDnJvLKXtnqCee2ew9+A
 t1Ibtkjxslz9ALtMk9k28L5A0B3iCJshT5z5mt8a4wZQlMqfla+RB+SZj2OQQ4dUYXD9prQNs3w
 ii2LHLgoBqB+5K8IbxJV5FY+9XzL86dBQc2o3tbLRY9qOwzMcnomDhvcs5hIz/GyOn48I8jmprw
 GRsPV54PR1zXqC41V1S7C+1k424KVbsVu52aOsDhRloSRjVN8Qmw/41xmV3pTgm4B6FPsc9bSey
 XrwRJM/P/mL0YtsobtQ==
X-Authority-Analysis: v=2.4 cv=fd+gCkQF c=1 sm=1 tr=0 ts=698b666a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=B/w2FSjaSvn+sk5eEndylg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8 a=brv3kHFulVQmvlGtmkoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-ORIG-GUID: JHAXqCeLVREBTnOHwubgv2fMSk3CIuUH
X-Proofpoint-GUID: JHAXqCeLVREBTnOHwubgv2fMSk3CIuUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100140
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31706-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.de:email,sipsolutions.net:email,qualcomm.com:dkim,flole.de:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[outlook.de,kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4D19B11DA2E
X-Rspamd-Action: no action



On 10/7/2025 1:41 PM, Florian Maurer wrote:
> When a STA is marked as no longer authorized, if the driver doesn't
> implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
> flush hardware queues to avoid sending unencrypted frames.
> 
> This has became a problem for ath11k because ieee80211_flush_queues()
> will stop all traffic and call ath11k_flush, which waits until the
> whole HW queue is empty. In a busy environment this will trigger a
> timeout warning and stalls other STAs.
> 
> Fix this by implementing flush_sta method using WMI command to flush
> frames of a specific STA.
> Flushed frames will be marked as discard in tx complete indication.
> 
> warning print "ath11k c000000.wifi: failed to flush transmit queue 0"
> was observed on various openwrt devices, and is fixed through this patch.
> 
> Signed-off-by: Florian Maurer <f.maurer@outlook.de>
> Tested-by: Florian Maurer  <f.maurer@outlook.de>
> Co-authored-by: Benjamin Berg <benjamin@sipsolutions.net>
> Tested-by: Flole <flole@flole.de>
> ---
> We tested this patch and it solved the problem of flushing the transmit
> queues taking too long when the AP is busy.
> We did not confirm if this flush is implemented to guarantee that no
> unencrypted frames are sent out on station removal.
> Could someone with more knowledge about the firmware behavior check
> wether this approach is feasible or if a different approach should be
> taken.
> It is not clear to me if the approach taken in "wifi: ath10k: Flush
> only requested txq in ath10k_flush()" might be better.
> https://lore.kernel.org/linux-wireless/01d859e8e574a1f5d0b916333fe0b5cda859af9b.1732293922.git.repk@triplefau.lt/
> 
> Regards
> Florian
> 
>   drivers/net/wireless/ath/ath11k/mac.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 106e2530b64e..a94649edd4ed 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -8330,6 +8330,24 @@ static void ath11k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
>   	ath11k_mac_flush_tx_complete(ar);
>   }
>   
> +static void ath11k_mac_op_flush_sta(struct ieee80211_hw *hw,
> +							struct ieee80211_vif *vif,
> +			    			struct ieee80211_sta *sta)
> +{
> +	struct ath11k_vif *arvif = (void *)vif->drv_priv;
> +	struct ath11k *ar = hw->priv;
> +	struct peer_flush_params params = {
> +		.peer_tid_bitmap = 0xFF,

The recommendation from the firmware developers is that all 32-bit has to be sent
in WMI_PEER_FLUSH_TIDS_CMDID for both AP and STA mode, otherwise some of the tid
queues may still have pending packets. Firmware does the intersection and gracefully
ignores the inactive tid queues when all the bits are set. We may need to check the
firmware crash dump to understand the issue with 0xffffffff bitmap.

Vasanth

