Return-Path: <linux-wireless+bounces-31196-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGDTD5QweGk2owEAu9opvQ
	(envelope-from <linux-wireless+bounces-31196-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 04:27:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 989808F90B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 04:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C6FD301DEEF
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 03:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562C53090D5;
	Tue, 27 Jan 2026 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MdjZ4jMJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ShmO4hSL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08FD224B1E
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 03:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484431; cv=none; b=bpAlDaEJbRkyFu94XDZKpFXNiRkZI9uZl1g6eampEeWH1+bcyblSmGVDS8Jtdoc2wZXM6/dRkEoZWxUMHwnLH5XdgByyvq2eN5Ot5/Lyut/z61A31XSZDwtUUIRtO0xZIwhVWxQEZHj6Y6DGey2HKa1QjtTggZ/nyJmmEbmsHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484431; c=relaxed/simple;
	bh=B2BxFlD/2se/+2sY0Cp5QH0iV+Wy6FUQ0Cjd7RQYbD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6ui8Jx7Un54YrJp7zq69doUVM0vPUDHI8i0bipd5H0Bj9HwMF7d967a1bL4+9CSh9KmxQca1DoYREftlY/kyIZp8d+nVpEKrWIkrSKOJp5R2NR7jZ0DqwqPs1TUANyF3+hRTnQqUQvYxXGB8vjukk469un3T1lhpKPjD54WfRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MdjZ4jMJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ShmO4hSL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKgL8s286750
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 03:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U3RWQmQy3MrLKV+NBz3/3Jxgy577wXT2KM2YCDEX4VI=; b=MdjZ4jMJcWEb7SKo
	xcTcxRjrtrH9FI+g94Hi9mLGj1r7P8Qq043FRXUIGBHqxpResiAhyv3TguMXWvgt
	q9kAPWbLDIktj/vAS3gUpKmQp1g5CNjiCY7vc54WmDUY6q4OMQ75CwqnLapkqfg7
	A01aK9PKLyinOlghJeg1LFzbVcUP7t+dnKhSwIZyDMWwSacq3dJgSnr8snCm/uHb
	gmDWcAOwpQYUHpvjCfNLdcNRMP3VLtGCTVu8ChpgiZdT8OxOtW5kLS/vvZ/Trvxv
	TUrWTe/aJ65zuxz0Qw9G7v7lGV5WSmiv7mgiNrovyvdfXz+/Hzrt8XU9O8A3CZRI
	RC1Y3g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxdva18mk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 03:27:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0e952f153so6088075ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 19:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769484428; x=1770089228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3RWQmQy3MrLKV+NBz3/3Jxgy577wXT2KM2YCDEX4VI=;
        b=ShmO4hSLD1VtVHDGg13wr/ceb2tFq4JqDjSo+nVs+IUb4DI+4einWFGMjMG7PLQz4O
         ylyhSr9Y9g7wsfwfMIbMxx2ZKTApGLyIFNc2/2Kf8FJj2NZ8CTg6m86A5d6mm118h7MH
         gp3R7deHy2JzTbJbDUOjRUK65ecQXXv4pB6KgJjIzK/q/qlrfXYuwB1k22n+/mJ6Wbh6
         mraY++aVJDoqPUTHOCdtUjENF1Nll7bUCOI7FBtzemCCnzCSMmpka/X7R6FMxO9AH1yt
         smmXdRqH7k0Nc1PoDs+n1Po1u4OfU2XEc+5vGFt56SbrS8D8HwyV18PfgLFjfVS7lqPZ
         COfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484428; x=1770089228;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3RWQmQy3MrLKV+NBz3/3Jxgy577wXT2KM2YCDEX4VI=;
        b=dNU8Wv+BcOjZl2Eg27vP7KlwBCG0lIYPHM/WSvpiW2KuU3UWTPsdGlumqeLgRlQJFc
         EWs8YkGxkw8ANpbsVsONN5LphgJWbmP9mVu5EEdhLD9WvTLpjkZCtaFPw2nzuTjRnQ6Z
         WibgYxyS0OY9xzzV7AsAPY4XeoproGBeuqXN7/wmBEB4M88YnRo6GQA0kZf3UKvAwRAz
         c+LoSkU6SCcC/QThE/5H6LoCD/3XYEgvd5S6ZOIwsSYWa76wcYTrWM9pPAuUAGfS8Ace
         +NHxDumYyYZ6S509D1Kr+bZB4dW/Y5T4xP6KR58wOFRubj2IPPPunrtoKf1X0F1zFFaN
         QvrQ==
X-Gm-Message-State: AOJu0YxS8weyj+SlbLBAxTN/YjCe39Zl8Vv5DYKKU2wH4XirAi8sD2H1
	y/LwBzhNintrtvCS2Ekba2bQs0MG5KfXiF8XeDz2pdd7K5b0yj6G/mc/bbkYP2p4YipvVbQiQw1
	SMPpH1qpE3Uqv4z73wpTa7FSvrJNFdWGSUTkW0BOggm3c6RcM10LsCzGexgM1O8Rj15TXoQ==
X-Gm-Gg: AZuq6aJ97/aRo9FWtvX+swn8JGzm/FsOldJV4g0uk533LDs8jfedmkUgctULDt3IeRF
	P0fp8yfYfPzcHJYBVyk6ZvxyzppQ6/tcx0n0gc+ijMhyjWMg/4Gu2laRKVl7UAI8B4Bv6w8+xhB
	XRtsREaxrk1GPupaTtO0+4MffmLrjhW9muAiouwC8VqJnuVo95kPMyI6SDWkpdgOUcLKhD0pktl
	cWG1AUYpg0np8Zu+uoD0hzQKr/oZQT5jd/dt2CXhJSi4rCCfneQ/KHPOHrB8+B4JyJvm8DLaNHr
	yEfcayWLDpqIOP5aeSxknr+MNQMMdOLVmPhNvIqNeM2Rgad1Fp6+V4+N71AIDpgdMLaUIcxssZb
	57LwC5tw3y4EVdo6x+DYZ52hcE+OLigkAXv+Do/ThmZGw2KSpE79kezL8E0vfhS3HgUweH/M=
X-Received: by 2002:a17:903:1250:b0:297:e59c:63cc with SMTP id d9443c01a7336-2a870e1878amr3829415ad.35.1769484427550;
        Mon, 26 Jan 2026 19:27:07 -0800 (PST)
X-Received: by 2002:a17:903:1250:b0:297:e59c:63cc with SMTP id d9443c01a7336-2a870e1878amr3829265ad.35.1769484427085;
        Mon, 26 Jan 2026 19:27:07 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa46fsm98971695ad.21.2026.01.26.19.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 19:27:06 -0800 (PST)
Message-ID: <9ca7ceac-2799-4993-844c-8427508c7d9b@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 11:27:04 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Fix firmware stats leak when pdev
 list is empty
To: Saikiran <bjsaikiran@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
References: <20260126095244.113301-1-bjsaikiran@gmail.com>
 <20260126095244.113301-3-bjsaikiran@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260126095244.113301-3-bjsaikiran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S0aS1Dcvt-DrSTmfwXEdoeBoXTUL2JK0
X-Proofpoint-GUID: S0aS1Dcvt-DrSTmfwXEdoeBoXTUL2JK0
X-Authority-Analysis: v=2.4 cv=I+5ohdgg c=1 sm=1 tr=0 ts=6978308c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=danhDmx_AAAA:8 a=pGLkceISAAAA:8
 a=g5N87RIAiJ8VJ6EIuL0A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAyNiBTYWx0ZWRfX+cLNTUrTxUuv
 3HZyuiygt5sGGxT+A/oq5cAAh7QYR+erEG3s1E/RgNJe4pFA0060Xgv2OTgAOnqg+4tMrLlPIyR
 f6rE7yzKRvnfzeod9HyJPCK9BSwTnbhGL6FKLyLFAagfIyWbsZYH27EqgN+Rh+6RM1v54mmshB3
 lFZuF7EmHfi0x5n0ryGn592GBG5E1j5DoKYHAETECt3WHSCqc1CGbg6bgP+ZD7SEJLGW5y6dgKq
 GGtw8wwb6jXDvd0Vw/fETb/qyTooII4HsfC110ALR1ub3skfbq9Zx8ofF6qL3+pjU4otXkifix/
 VuPMsQ9/7zcBiHqI7ewzapXe3gqysT/K/J6t6Beq6m4bOBE/awyRmC3Go+NaoX9mhbQ6zEaWbuC
 yyo1zUraGqu8Z+j5bTCcNc3ez3lb/O4kR4TG1a1+cvzU454h5e1GUtUCHaVbi6ZNSX9DOWfxaaG
 ukyENmR8bA9Vb07YKwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270026
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31196-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:url,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 989808F90B
X-Rspamd-Action: no action



On 1/26/2026 5:52 PM, Saikiran wrote:
> The commits bd6ec8111e65 and 2977567b244f changed firmware stats handling
> to be caller-driven, requiring explicit ath12k_fw_stats_reset() calls
> after using ath12k_mac_get_fw_stats().
> 
> In ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats() succeeds
> but the pdev stats list is empty, the function exits without calling
> ath12k_fw_stats_reset(). Even though the pdev list is empty, the firmware
> may have populated other stats lists (vdevs, beacons, etc.) in the

'may' is not enough, we need to be 100% sure whether other stats are populated. This is
critical for us to find the root cause.

> ar->fw_stats structure.
> 
> Without resetting the stats buffer, this data accumulates across multiple
> calls, eventually causing the stats buffer to overflow and leading to
> firmware communication failures (error -71/EPROTO) during subsequent
> operations.
> 
> The issue manifests during 5GHz scanning which triggers multiple TX power
> queries. Symptoms include:
> - "failed to pull fw stats: -71" errors in dmesg

still, can you please check the logs to see at which exact place is this printed?

> - 5GHz networks not detected despite hardware support
> - 2.4GHz networks work normally
> 
> Fix by calling ath12k_fw_stats_reset() when the pdev list is empty,
> ensuring the stats buffer is properly cleaned up even when only partial
> stats data is received from firmware.
> 
> Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset caller-driven")
> Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index e0e49f782bf8..6e35c3ee9864 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5169,6 +5169,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
>  					struct ath12k_fw_stats_pdev, list);
>  	if (!pdev) {
>  		spin_unlock_bh(&ar->data_lock);
> +		ath12k_fw_stats_reset(ar);
>  		goto err_fallback;
>  	}
>  


