Return-Path: <linux-wireless+bounces-35918-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBW6BNgI+mlsIgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35918-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 17:12:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9751E4D006B
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3264C300898F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 15:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C996B481649;
	Tue,  5 May 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j8lbWzm0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d2hY5fdi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C848164F
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993734; cv=none; b=lwtNCJmEw3vxJjPs8YFI8cROldMPzeqIOg2lbhSMrp2yNwR6xJ8gv0Afkd23QO+saEPrZv6f/O3vZCp+vZMOnXIIB0vstjKF5pTAryLdLww4ilxaA2NyPrU1jifpTlpY5mX89IvLysxGK5ana+yPrxhhjhc9+RUs9nmdfKQwP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993734; c=relaxed/simple;
	bh=RZBMPx9sm8uLD8Icyhl/8oUdwgYcuUEhGKhgjs2yI4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLjGjMvH1UAdZyYc64310w9OYXFXRP1WToPAQhh7L/bFKXwz8GLWGWLYpckTSrh45eqFwcrWp3vxI56pKaA6tWJo9Yjqi9cAUcDO0DKlh3Di/loLAqOBxNKM9mVo21IFxz1wlQETkHsmFIlDnRs+1czFzZP5k+0EgLooO7LVMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j8lbWzm0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d2hY5fdi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EZhX34028315
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 15:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UUDqieE/IWdoODK+rFR0jqaUdzYrej+t909RYtpowfM=; b=j8lbWzm00pGoSj+K
	CQa5wI8Ml3iKlftxUDJxFpSRmDLKctv0RzBaRYydW+QM5UQ47E8PqAB8KDk2t9xk
	P9NBvp4jNvsAh8jfskdZTeAMz1w0KTl8dkHILP9oOusY/jlXgVDS50NDO3WEZwfU
	CNEig4oHWNwVD7wpLXJ9j5fM5GULQ+NzVDZvguQlf3XuuMyX7dVW3cpPyZuTRWOu
	wEbuWXM4Z17XjZJ4AbShkKChcy02Z4Fkd2wDg/boQPPo62vApNLmANQ+6a2IqrLB
	4GMs5vRkmvNRa7g2IDY7SNhMxl3wEZl/8BMw17iWPfJo2Kd3++J6kZN4h0tp5kHi
	alYsRg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dydm6sehc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 15:08:52 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1270dcd11c1so10657684c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777993732; x=1778598532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUDqieE/IWdoODK+rFR0jqaUdzYrej+t909RYtpowfM=;
        b=d2hY5fdi04bkGPHD9wlokxv37BCHuwzLuw9rGzcj6IuyPY596jUai/DbYUXfbUCtCM
         alsDnXMVwGQbeco4r3oJKvm8raieqczZWsFuT8Ykr/OBoaNGJgP0mtziWN9K9SxZOVz4
         BRV2B8vO4Ba3C/zTpkSbvtOrgj/cMmxmob1hh+rt6GbiO3tufCOZP2lJSMVxAkw8SfCc
         l/wR8fpfDSiPUU8gMYbSUCHZHYTt4kvZBIL+gFG8D4/wTiakEOpXiXCwPPbWaCn4pNfs
         9/MA6TrvobIQoCHUWmi8Y3Q2ZkR6UUSOaO8xgNt2ie6uOFSmG+U+D9Xf5ncG7VQT6PJv
         Lz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777993732; x=1778598532;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUDqieE/IWdoODK+rFR0jqaUdzYrej+t909RYtpowfM=;
        b=TMKwgTmaSSsokmaeOTlCOLurhLxMX2oBLNqy6k4/cPzujFO/w2FVCeptfVbkvEcRCb
         KHzV1RLGYFPl4uPfeSD7BLOx5AIDrw8gfB+Vvrz8vb5GEgJ3pG2ymdfwNWgirxpGCV1N
         pnzi/awYV6q/ubW5/xesBMdfGiw/sdkEj4+xt1Wh/rvjU4ZwNCrh/iZUlHH3ltf1LosL
         8kP3cq9W2kFRcoG1KToL2+9zsi7AZ0YJmJ84S8b+4ynND3PwPwuTg9pBT9lEbc8QLxVA
         JSYFiP+1sIBCD9W6xBAqxji7P3omKq58re8ugecJsTAnwB059PbISPqAYdbImF5UF5Lz
         Q79Q==
X-Gm-Message-State: AOJu0YzcEIK4U4DPqYZIRjvsrBZPVaDeh6tb6mk8sAnOX2ennzOD8TMC
	fB7/tDtSj0JjJshDYx1rJI9X82pdMrjdtFKiAYNU7Jt6iidibKuAPGhabgfVs1pDmMvBvo+P+Tx
	pdl97vYallZWe6Q6g5WHwOT4Q9V/RIRm1Rm2vvxRIJQBwXOyYkykhN+FCQIXw/BqqvsaBfA==
X-Gm-Gg: AeBDievTHPVjebXx/YBGhYI8Z48lUWJlRfthEv/aNmz/VZRXBZZAbUBSIvuh/bNB2BD
	6Jnygpv9K2/zlkNFtudp1IMmJHq73jQSAJGMRgFnsSBVgqx1piu3GXMm5/aTHGZTUwX/h8uueFk
	YQEMsBTeugitgQ3z5Lp3wEvid2nby6dQ5Wxgu2pjpyHyk5YVpMqLIJon9/UsPS2aFOlDaCB7EFC
	/9B0eD1WHfVTkTxHv/1XyZ2dfbwGoXU0PBiImq7CocEB02XL0UR/ee2QqG7aTrhHxtF0vYFbJ+7
	KF1mKyj4F/fQbJLchiDUto9tWceRH6k9yE9JwdvUHIaKsDJhDCTQ5HcX8oMg+fM8GmP0jh9JzHy
	QKntDg0+eIdDPZzo+KW0d4bCPAn5vWvg654y1SVBRF8s6BXjEcf9A980xmFDptZNGFWmHiQQ5to
	AwVWcEX/LZDJm6zKuS
X-Received: by 2002:a05:7022:1a85:b0:129:fe5:117e with SMTP id a92af1059eb24-12dfd81a7f9mr6952379c88.26.1777993731715;
        Tue, 05 May 2026 08:08:51 -0700 (PDT)
X-Received: by 2002:a05:7022:1a85:b0:129:fe5:117e with SMTP id a92af1059eb24-12dfd81a7f9mr6952357c88.26.1777993730933;
        Tue, 05 May 2026 08:08:50 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df828849dsm18042517c88.5.2026.05.05.08.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 08:08:49 -0700 (PDT)
Message-ID: <7d3c5eae-233a-4c31-b64e-70f0afe74da6@oss.qualcomm.com>
Date: Tue, 5 May 2026 08:08:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix use after free in
 ath11k_dp_rx_msdu_coalesce.
To: Willmar Knikker <willmar@met-dubbel-l.nl>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260505143025.234292-1-willmar@met-dubbel-l.nl>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260505143025.234292-1-willmar@met-dubbel-l.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0NSBTYWx0ZWRfX1Hn2zLsAZDq5
 FUu/DhstHJ3aS9OBZMGysBgtqEshvciWcAar/E8EMKeFKh3P6sMABQxENA/Riuh2BtAyZuMvMDJ
 uKqEQqj17eMi/y11VOPwCkObTWBYcJzSs/RxuwnlSrVCf0Zz6yMCx21xA/2xvpsERTDRCzc3NJZ
 qFoSwxu/FeQSS6MmioV0M2N4FnsjPMnRCjrvc5HuuugGNcsXvx9WZX2IEd2wmpBj02nz0GAKtXr
 xqK5DnyNOXFXlFFaTwHFF7dBLJVBYy2XHeWPjqrVm2GAe4k5AAo0w/TJpLVEfK3frWZIy8sQPlf
 IOSrSzF5Arin199nVmItE7Nm+a3c9gIF8y8jhh1trWhvTkiOTL9MiDCbExR9+IwiPyQ3lJpCAGl
 vw+vwx+uKFs9KQrmWM6eI7Sbi29DZgW5lr/D0ipLcwsbT2OwyQ0ZPkDTFTT2mViuNDAsxtFGZXq
 hl5jOvZOSJbApYsi6KQ==
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69fa0804 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=9B1uR9gGAAAA:8 a=D8R_4z2wC1Y-3Iv41OYA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=8R3p93Tjo66ouot214C2:22
X-Proofpoint-GUID: 1l-_L-EShyQj_fzKdpJRNG0e0V660X1q
X-Proofpoint-ORIG-GUID: 1l-_L-EShyQj_fzKdpJRNG0e0V660X1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050145
X-Rspamd-Queue-Id: 9751E4D006B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35918-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,met-dubbel-l.nl:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/5/2026 7:30 AM, Willmar Knikker wrote:
> In ath11k_dp_rx_msdu_coalesce the loop uses ->is_continuation after
> the dev_kfree_skb_any. This can cause a use after free kfence.
> 
> Move the use after the dev_kfree_skb_any after use of ->is_continuation
> inline with the while in the while loop above this one.
> 
> Signed-off-by: Willmar Knikker <willmar@met-dubbel-l.nl>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index fe79109adc70..02bd9787d6b4 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -1825,11 +1825,12 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
>  		skb_pull(skb, hal_rx_desc_sz);
>  		skb_copy_from_linear_data(skb, skb_put(first, buf_len),
>  					  buf_len);
> -		dev_kfree_skb_any(skb);
> -
>  		rem_len -= buf_len;
> -		if (!rxcb->is_continuation)
> +		if (!rxcb->is_continuation) {
> +			dev_kfree_skb_any(skb);
>  			break;
> +		}
> +		dev_kfree_skb_any(skb);

rather than repeating code imo it would be "better" to cache the flag before
freeing and then test the cached flag.

however as you note this proposed logic matches the logic already present in
the "Free up all buffers of the MSDU" portion of the function, so from that
perspective the proposal is consistent with that logic.

let's see if anyone else has an opinion...

/jeff

