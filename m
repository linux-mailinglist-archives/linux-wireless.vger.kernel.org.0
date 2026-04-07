Return-Path: <linux-wireless+bounces-34416-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE8JLgF71GmxuQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34416-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:33:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D633A96D8
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6B5730182BB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 03:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41E230E0ED;
	Tue,  7 Apr 2026 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="akweNyYo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IjSb0umM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928751E505
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532798; cv=none; b=O1JJxCRnEapod0P3Ep3a1aIcr5qQRtm3WhW2/TZe/QiQnX5o04tHq0mK4rgkjIJjzMIcu1LlAa+BOq9Ar3pNVns4OAcgugvH8/y1j4qzVrmyxuEAGtA4yhQWqpnyILKfI2rGzSHs/yidt1lLMhR8nkbdfF261ElmwSmuPjVR7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532798; c=relaxed/simple;
	bh=cfF1MfiBQ5BhEDiQRyKTrtbIbdAWX/a9Rao8e1m4MP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6S0kladgBNsM94HzYvZrxHwrqBdE+zUc7B1x//IEW0fb8HbS5meJVMNR1oqd3ecOCVjQ1W/y7K8b1iBCTdcziqn7Ccg3EEc1plb4M9fBvHioxiKEzFBDqY8tkmpqTNAUsR5O+HaLYXRdWF2/r9Uk5k4UnsKTW7TjOnbV0uazro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=akweNyYo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IjSb0umM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQrJU3402637
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 03:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f4mW63mk7YjycAnV8m19XiyzmNcB7vNqWdU77uD79T4=; b=akweNyYoOvyz6F55
	M7f6YTOD1uXARJUfibItyciuOjRed+W4EZKg1+K1li3vcIq9FwH5EljjH6nRjMk5
	FzAU471a1xSIpKs79GagvxesEHLrFiLeNlwkGPD/xs7H71+7p1z07cz5aVTTgyHu
	xdIU/0qtqITLPB7E3WdjU1333jzC0jkd7M216lRioJJreKKNutnJ4g2OdL8+9010
	3GPmJQQMIS/mpXzr5xBJOfCAOnWwI1IJ6A9TxQ5bNXG6LxGC1Po2KD0y5D1o35N1
	h3wvi5KvpYEeIHLVaIZsl/Q1ARJDh2P5AB25U9sxjDBDrfB05hL+2pxKDemHyORG
	Uz55yg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhru79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 03:33:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c76b15a3ccfso2298766a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 20:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775532795; x=1776137595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4mW63mk7YjycAnV8m19XiyzmNcB7vNqWdU77uD79T4=;
        b=IjSb0umMJ9lcNT49ztPtS642Gv5q3Vvw2D9Z1PnikYNra5vhlH8qKZom9sxxxqpuAL
         hFgueVBhbrlydunDFpO6BbKcs9sYRipDbc0DKqArylWSo8tijUdrWri2nr3hx9RF7KmA
         Mqgl4ZQfTpIH1DtHCFAst95b4xflPlihJ3M3NT4ZpvJEwFjeeo7gUsoJLbNMINQwLa2f
         MpBzjlk3HQ+4cBsm3mCB/eaaSkfhwP5PVzm7Xj/Ipjwtbd2hsMNmQhTHL6xUQwxIn5la
         3gW6Yah83krxevOTkv+Ga+hT5a8+OzzCTXZNEGR9hPibtvntKsgvWKZVhkMnENwOfJms
         86HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775532795; x=1776137595;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4mW63mk7YjycAnV8m19XiyzmNcB7vNqWdU77uD79T4=;
        b=e9B7tfXi9LGvcaWJHdgooAEqNE434e9fxJEeT5IEgIXV7MBKr8oAxYAkWZDVvCpRQr
         YJWwB8kORgogzoKj59I2oD4Q/oNU12deALZmG02tYWdyTGh4MepgeIm9TN6WBX+/MQaX
         6/6YQoIrkAV6caki4un9GAiD10rc0sYiid/O2pJjhFAhXc5RoGEJ8Z3AMmlX1yvp1zAZ
         59XHYz80unO0Kvwqm4QT5dV1BIZrVZ056IJbImTtWm3ZfQIqtVMzOK/CMzVNPC3ynUCt
         dgK+TtlPY4wwTjk/wNm7z4s8QT0OWhQ84z3x0GfK3mSC1HzfXymW62hteX/WPZHkcj5G
         wQkQ==
X-Gm-Message-State: AOJu0Yz1apa8mJ7gD4yOG5ZZXUZqErYa5UKsa1+EHLeLPyOqlttlVQDc
	DQHu+GCTmqwcIyo1zv5mxvEo/7Os648qFeCYo+KR6984V56AJN2YAEjWIbjwqUgUz3NugkT7ZMp
	wWsHGs42viMWO2S4eJtGC7QaE9HVstnQgHj8srvcl1+GKoGfcRf8r/3ihtuoB0tL0qjYlnLL9ju
	vFfyVI
X-Gm-Gg: AeBDiet+BmclggeElwHtzKsWcllhtyHWNDaUeKgnx074CjJ2Nqfsw9DH78zAtL1eu1U
	7v4lh1T/Q8z9F3wWliy3C4Ax2+syuDyqxPs/Co4aIE9JQ3uExAv712wp0tRhXWC+9gv7huzQTA5
	XOOeRed/Z/++lELa6LQYRj1F2cVEKxNKyeHdcbJfa3q9STuKCybNw26Mz76511AUOnMndkX2Tea
	R0FCy95y9t3qE3tFVgmXul2e2kaLn4SjyBGEDPKCJ29O/Vyy/Q2YMeZpINE1VyK6XKUxuLmpq/u
	EUB84BKoNxFuN6uAQ5sqUHXehaFTELUoYAS7fOb98YUt9vxbnORzprUe/5831uBnWpnE1JIjdYV
	y1JhTZxYKETjzgrwKJuFmmz+gmHYEqb2HMsvIHvHovRd8Cxx9yCjJcuSYOJAy1neVUBz5pcBXbQ
	WooiltvjGIEtGue3i3nss=
X-Received: by 2002:a05:6a00:9513:b0:827:3e19:574b with SMTP id d2e1a72fcca58-82d0dbb65eemr15287624b3a.43.1775532795150;
        Mon, 06 Apr 2026 20:33:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:9513:b0:827:3e19:574b with SMTP id d2e1a72fcca58-82d0dbb65eemr15287540b3a.43.1775532793222;
        Mon, 06 Apr 2026 20:33:13 -0700 (PDT)
Received: from [10.133.33.204] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b5fb22sm19700159b3a.26.2026.04.06.20.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 20:33:12 -0700 (PDT)
Message-ID: <4fdf1499-4f75-4372-8bfa-2a9aac039d64@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 11:33:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Rename hw_link_id to radio_idx in
 ath12k_ah_to_ar()
To: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260331045834.1181924-1-roopni.devanathan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260331045834.1181924-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAzMCBTYWx0ZWRfX7McSHNq/ufyH
 vNsYImnKjuK6WIkIzWvMaQ27d9tmb36lqsmabx3Qsf+6zTclgHaByxTOr/6MygCY+zW56YpOmNd
 1rVfgo0KFOnATLzwkUkJ9Gkjr1ZKu/VbsZXwVTSwEK/JctrM85xPv73uD6Eoul7rQcoldMZsw9F
 7+y2aJT5YYdGR3/q/pJusxnAN57W8fGjkSWg1FXYBUubzoHQ/oHHvMPIURbFGWKZaf208AnlVha
 Ql8b4k9YInfq6XsNFxjlLYAPier0VK1EMPLgfv5TtOfHOWwPg87DVgwtCj2qVWt+RCWkAUY94vp
 KEIAl8t2TxaI4DOiobfXTQv5wFKgGEmQvcYwuxVStoSRhgO+QnxXmyUA8tXuS+kiFknUVlcvFrA
 7nI/EfytgQcY5OPAOQgnZ2v9E5i/JsqPLR0pl96/j668s67jP+zhYBkM+AeIdoUHYUyXb1oJViQ
 88gpz+Az46iIr4VI4Tg==
X-Proofpoint-GUID: MPAryfcsLh7qm2EGQeKBpNZx42-YxuzO
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d47afc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=qJTBxiSCcKiInWsf5WMA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: MPAryfcsLh7qm2EGQeKBpNZx42-YxuzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070030
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34416-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 30D633A96D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/2026 12:58 PM, Roopni Devanathan wrote:
> ath12k_ah_to_ar() is returning radio from the given hardware based on the
> radio index passed. But, the variable that radio index is received at is
> wrongly named 'hw_link_id', which points to the hardware link index that
> comes from the firmware. This affects readability.
> 
> Resolve this by renaming 'hw_link_id' to 'radio_idx'.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 59c193b24764..5eff86827e9c 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -1366,13 +1366,13 @@ static inline struct ath12k_hw *ath12k_hw_to_ah(struct ieee80211_hw  *hw)
>  	return hw->priv;
>  }
>  
> -static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah, u8 hw_link_id)
> +static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah, u8 radio_idx)
>  {
> -	if (WARN(hw_link_id >= ah->num_radio,
> -		 "bad hw link id %d, so switch to default link\n", hw_link_id))
> -		hw_link_id = 0;
> +	if (WARN(radio_idx >= ah->num_radio,
> +		 "bad radio index %d, use default radio\n", radio_idx))
> +		radio_idx = 0;
>  
> -	return &ah->radio[hw_link_id];
> +	return &ah->radio[radio_idx];
>  }
>  
>  static inline struct ath12k_hw *ath12k_ar_to_ah(struct ath12k *ar)
> 
> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


