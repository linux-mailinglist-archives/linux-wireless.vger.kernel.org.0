Return-Path: <linux-wireless+bounces-39000-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NrvHBlxnVWqtnwAAu9opvQ
	(envelope-from <linux-wireless+bounces-39000-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 00:31:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A474F822
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 00:31:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="UHY/zVrA";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=G266zFZy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39000-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39000-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C496301D777
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 22:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349FC39A7F2;
	Mon, 13 Jul 2026 22:31:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9F35C193
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 22:31:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981895; cv=none; b=DnDbisUjcBN6wUOV+om3jUjl3mAd5Vdii7guNtKigveKnkbNwlEZL1Ohz1k7DZa+Y6TAeEZbIu1Wm1Rv326kvMry6rOzP7WG1h0vSeqtA6GnP069d/pORVjgbu9hF+TEXZDFQrPAwhkQ/dAjRz5fH6sdTisFo9XB56cmvgFLfgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981895; c=relaxed/simple;
	bh=ftUPdaya68tMq6KUWjSyRrnGxWh+B3jwiwHzbCxq/AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L1B0bMaXkDNZFiNoTmV6XZTliS4snvJJsOpVBA4ZHRx+tW2BRRKkuIcm008cYgUody8TWA5bnuDBUzGYW4xTie+GQrOgKede2zLyCkEmIkLl/yPVZfu5YlWY1K8FCXWdaaY3HVP6Mm/rZeHnVM+gRS9uSBI8ypa9Nl3XJVrOt5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UHY/zVrA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G266zFZy; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9AZl2519318
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 22:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MhhC8Ik1LMusQWl25vHsIQ4emkebV3U5uc/+RQHheHg=; b=UHY/zVrAQTfsR5Fi
	kBU0Pr8G5a5l+jtlUu/lhMxh+Mx/SLjhyxzlngMmuT0VJATMVznUbMiGrnIv822r
	kyyg00J/WkoPpNXpG8+2ff7WXu1znmzWhGKhuGqPHv+ulqBBMmQS0hyNMmblGp+B
	XtiU/yt6gjdavNdqtSAYLX+vpiD5fTZzBcuFsOpLonbthmHMTTDb1Bs3NnlQ5wof
	kb5rbdCY13o5fHd+u05VoUE4e1bCHRSqodvdgPUi9fM0tfPUKFUbhi0SOKXN7gg4
	l7KjFkd1GVGlYi6LYfwvJT22u/ZP9Z7O8QaDbpoG/d24LLOWzsbdSGZUZO8EkLdh
	YsG0XQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44cs0bq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 22:31:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so5340537a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 15:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783981890; x=1784586690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MhhC8Ik1LMusQWl25vHsIQ4emkebV3U5uc/+RQHheHg=;
        b=G266zFZyHLswBn3mVHvb6l5yiTRSOdqH6CvzPLLu5i8vjS9RtVPBx7saQ+ByjBvoIE
         r+AfFwefr+1Qw0zFt8ZNXOs4hLvysbuQcHHPHddMTRngUa/jHJ881qVItxsHovj0JjCq
         t1S3ThA4/qrvUXHYqXIGZKGPTbBQyP1ByFAZzfu7CRhesUp1yQ/kSDUDpZM6ynKW9qG6
         uP35tDj45usPzZpR5gJkTbr2MaAh6ZpslAePJyHhIpMMtuHBitlACui0xm5hMXwPsPTN
         2PDaAf6ECHbFJbOngLvaBm1ADyNd61+xc3ffwUAIr4HkP6rM+UjH4aINZ5Id9f0BtZPx
         AMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783981890; x=1784586690;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MhhC8Ik1LMusQWl25vHsIQ4emkebV3U5uc/+RQHheHg=;
        b=kCDZA4hGUoYH3hc7V2xzq4UOSoAeLh9psGtv+oElmTyu37c/7oVcxafwQdXmkh0W0g
         PKEdowxiWe5ZVqEaULy6EFVcliJHCACGyG1EMeIgJuE+H69F5VSQmvRfu+s/JP46S484
         nWcIjycrJ0NVm+mmwziDnz0gsQWjSZzFSL4syp4II4oeS28NxZtR1ppAdD7ldDSMvpqR
         VTZgMhHQ3eiUZbxJCObGe+Uh7kz1AanvemqFzD9XAPPLfZVn8SY7dfFx8gwlXwvMkKYk
         /6BOpkAF6+eCMBluSsIUe4M/l1Tj1xuGKV9eHqraspxtnbk3qGcwfyCLb9FLZir/8eiS
         GS+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq884ZQLfRZe6TtMH9hE/cew6b2gahcWr1XxS4vU3Dw9ZzrpHu1nLuOcesjDo/miS8oAZrWxDgUXh3NYd4lbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUTb3Kjbh11DwqHQdq/oc9MNzBdWwKTJr5YxkxeuG8jLg9v9j
	mNVZ5kX1VHH6X4znOK5RmVH8KzQqT5QKs1GVgD+UnLN+1czlj8jiSHS892+BX2R8hp/2Ow95Ajj
	o2vawlSiL9WG5aOG718DmrHLK3SP7A1IhYm84gK7hfmM+geJMh2hNbXLuH0Ih6k85dwDiAw==
X-Gm-Gg: AfdE7cl62nfgC1vvUXc9NnGlrXbz1Vtcgu096fReYQfxHWLpQABCdqqKXFvpcbVTPqx
	vFjOy55Rwp2uuX/36BAI7N8040MlzVlvRVaOjKEOrnP7k8Z+TSD3wVVc+/D2XJ+pkeY0uOZr8rD
	jUPvKnM7DYFyf8BMGBoJJ9JOIv42MrqFjRwGLjzZgOBv4Ygm2KH7RTnFCDXvpIV3bbetBDlwn+Z
	c4t5xJxpAEgru4LD0INCsCokNdvB0aEgKwnpRPrfwzGDw0iv6KH2h8op1hAVmomKbGALTvgIqwY
	GIFVgkhUb/yNKNFC7/kMgoW63sa/+E++tqOxkY3Coe0Mm3sdiQ9Nj8c0LA7nX38anko2J7LHXih
	B5y0XZUka15knwaqz7EzoxDSCGHLgnEcopMmOWzb+57WC79tSqQ8F/CSBn+ZaLklIDIHe
X-Received: by 2002:a05:6a00:3404:b0:847:9151:3409 with SMTP id d2e1a72fcca58-84889797ad5mr9927364b3a.55.1783981890153;
        Mon, 13 Jul 2026 15:31:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:3404:b0:847:9151:3409 with SMTP id d2e1a72fcca58-84889797ad5mr9927341b3a.55.1783981889691;
        Mon, 13 Jul 2026 15:31:29 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f270895sm453108b3a.16.2026.07.13.15.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 15:31:28 -0700 (PDT)
Message-ID: <75ef4371-b66a-486a-8555-e3a3f6ee5d88@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:31:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: Drop redundant NULL check on devm_clk_get()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260705172405.119084-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260705172405.119084-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KQnJjVKmZnfM-ej2ud1fsCPcyxG3hLKH
X-Proofpoint-ORIG-GUID: KQnJjVKmZnfM-ej2ud1fsCPcyxG3hLKH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIzMSBTYWx0ZWRfXwpU9kgduun9K
 IYQ2Hbqkr8QJKIMvI9fv2kFDZ3usFtgjTK/fnbDcBWmmNPPTzvQ8tqFTUt6ZkzTcGyCjfMCZ5Tc
 YXUjW4gAq995jowgLwwBERUypfCD/cQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIzMSBTYWx0ZWRfX4u6s6939v9m8
 043XA7y7VgnIA+NTRkHPlj6Q69/PLrur23rX6IxraNQtCgMlgOuvKHoo71HoqmWavuEECIRIdzJ
 RNXlmXVTrpGmIwtokTD438kL98WlaVnhVlR0XPknXLgcNmy2u3TlRy+tmVWN/j7o7/aBc/LLjN1
 x29XxYdbXt72AujgJOgj9MIzJitfshrC3v1Pu4+GTfg4Bl3DGanhp1HRUTef7mGrBsk+0UmQohI
 dxG65TxPmpHq0rO+zSOo/ZQ8ti0tBgdlL7UsPj9oJcjAPF7lFMklud6h9yW5EN333Zq8/nnQhFs
 Hd5hqotpcaaexRWll3+60N/hlwheM74aMIBza+hUrUq9cQ+BJbLKYC5y61GCi3NM4LP+S/uEeQ8
 olY6akPNpACYc0g2rm60VjKaqnUnLs20KlTNTAo+Xw50XvhBqT7bnq/kxLHOwmZLnZs7rtbMMrs
 J6Jdq/8a53Dt6kGn93Q==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a556742 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=61LRw64o9f_II5JmnVkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130231
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39000-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:krzysztof.kozlowski@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A40A474F822

On 7/5/2026 10:24 AM, Krzysztof Kozlowski wrote:
> devm_clk_get() does not return NULL (only valid clock or ERR pointer),
> so simplify the code to drop redundant IS_ERR_OR_NULL().

FWIW my AI review agent says:
Under !CONFIG_HAVE_CLK (x86 COMPILE_TEST), devm_clk_get() returns NULL;
IS_ERR(NULL) is false so clock_init() returns 0 with NULL clocks stored

Perhaps the stub function in include/linux/clk.h should be updated to return
an ERR_PTR() instead of NULL?

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath10k/ahb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
> index eb8b35b6224d..7456f885d2b5 100644
> --- a/drivers/net/wireless/ath/ath10k/ahb.c
> +++ b/drivers/net/wireless/ath/ath10k/ahb.c
> @@ -87,24 +87,24 @@ static int ath10k_ahb_clock_init(struct ath10k *ar)
>  	dev = &ar_ahb->pdev->dev;
>  
>  	ar_ahb->cmd_clk = devm_clk_get(dev, "wifi_wcss_cmd");
> -	if (IS_ERR_OR_NULL(ar_ahb->cmd_clk)) {
> +	if (IS_ERR(ar_ahb->cmd_clk)) {
>  		ath10k_err(ar, "failed to get cmd clk: %ld\n",
>  			   PTR_ERR(ar_ahb->cmd_clk));
> -		return ar_ahb->cmd_clk ? PTR_ERR(ar_ahb->cmd_clk) : -ENODEV;
> +		return PTR_ERR(ar_ahb->cmd_clk);
>  	}
>  
>  	ar_ahb->ref_clk = devm_clk_get(dev, "wifi_wcss_ref");
> -	if (IS_ERR_OR_NULL(ar_ahb->ref_clk)) {
> +	if (IS_ERR(ar_ahb->ref_clk)) {
>  		ath10k_err(ar, "failed to get ref clk: %ld\n",
>  			   PTR_ERR(ar_ahb->ref_clk));
> -		return ar_ahb->ref_clk ? PTR_ERR(ar_ahb->ref_clk) : -ENODEV;
> +		return PTR_ERR(ar_ahb->ref_clk);
>  	}
>  
>  	ar_ahb->rtc_clk = devm_clk_get(dev, "wifi_wcss_rtc");
> -	if (IS_ERR_OR_NULL(ar_ahb->rtc_clk)) {
> +	if (IS_ERR(ar_ahb->rtc_clk)) {
>  		ath10k_err(ar, "failed to get rtc clk: %ld\n",
>  			   PTR_ERR(ar_ahb->rtc_clk));
> -		return ar_ahb->rtc_clk ? PTR_ERR(ar_ahb->rtc_clk) : -ENODEV;
> +		return PTR_ERR(ar_ahb->rtc_clk);
>  	}
>  
>  	return 0;


