Return-Path: <linux-wireless+bounces-34252-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIkjKiN+zGl/TQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34252-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 04:08:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4976D373A22
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 04:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD804303611B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 02:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07832EC0A2;
	Wed,  1 Apr 2026 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SdsaoRXg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U56hsVKg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9C27FB35
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009312; cv=none; b=OlBMyL0WJTUwUljJX+psaP8KRtlIHyUSSCPZYznQ4qgOBYV6NrAF7sXZqUX+TgzFVq+A+1FfSpY+F5PTEDBZN4h4aZtJO3yxv1XxdwKMEt351/YARcWex/3sw8AFnspFkgC9xOuD9WNh9RGnDBFQBJe2Y3L3vle6WyGctZD4OJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009312; c=relaxed/simple;
	bh=JzjgiJr9bh3w7eGUdwF1di2s7JHNBbqWdZsjve6fgIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4e6lghi4GQ4PicqP3x/sOyV+uod7LivUvOS8TD6ISEEK8oSD68Mn8+fdBMBgpmUvyXgKkTx3bgowo7Q9ll04QCkcAbXPR4IzbOc5uBufLzuXpwjWD1ApXy84TeeHi78z7QcXewio1SWr5RyopyxV5shZCP2QeF2MrlDtHxeeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SdsaoRXg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U56hsVKg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VIGobg3081339
	for <linux-wireless@vger.kernel.org>; Wed, 1 Apr 2026 02:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JzyNb4USxocw8PkrF1IarRRAjVYqOgczXdpojVI5iMI=; b=SdsaoRXguAprSXDC
	9yqfibThNQiZbFtLpJLvlRbnzUlBoNti8nPp8KytZcH/7sJ6VRyHl9l0Z2dElFnJ
	xvSsBuCX+2UxFhUit/ctzMvqqkmB5hUsFrFuOXqg3K7i+nj7oAbfq6tByucuAB9d
	Xjk4yK1ogIreLKEZ3N3FH7h1MjdM99gMhCjsABL0jMLIzQrYOWSZYTZSu4AvMW4M
	d5/PDb2q9DIXOkfZ4g+HmcHGtsBVhUf1X8ZcGzQSryIvisNvWHRlMyYkVAm1h35H
	m72zq3hj3OfQp71JpQQaMjWtm80v4ZaTL+BWFKLvGsph4yierehzmjWITI0JDrbM
	z40LYA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kdksp7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 02:08:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da8eb0553so496207a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775009310; x=1775614110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzyNb4USxocw8PkrF1IarRRAjVYqOgczXdpojVI5iMI=;
        b=U56hsVKg0m+vwwOPiRPuJkwIlHMVDVArHFhXHevJ1C+7H0oTL0YsyCW2a8ROUWaPvf
         zdMf8lSvO+IvYufklFLlLq46I/IlB3bk69THqApTn7e1dnvLPXMYeZEUtlWVx3jLgwpn
         J1/dK23tE0+nLy3gdkr7HyeL3rB0wqwSRft6m+SGepR0N/2caV77tdiUcknrhx+z5ri+
         t3zLzEvglGrwESo80/iLuLsX8O8uBK3n7AIrXN+RQtBA+N09oZZjhAjSp/boeyEYtnB4
         K4OBbqA2mLVEoNzDCgVrX1lNA/a14gY1JzFNKDaKpxxLqotK0y+dfVcZHRgA/1JMAXEd
         An/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009310; x=1775614110;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzyNb4USxocw8PkrF1IarRRAjVYqOgczXdpojVI5iMI=;
        b=WbCQZ5NmEbHZqCzoXP2Rg3Jwo5J5HeieNeIVOfmS5+1yl+08j5jwEtvA4z+iJQ8oyz
         ZgZi1uBzheb6n/VMTwuDvJ2oLuJI2wJZTw4vV2jd7oMLy01DeH4mjHk5q6vk01yqSDhP
         EqrsMnFeZg7MTvwwo9e/jw/EKwAYr40470xUdPN/RlBe6ANmZF7XXEVqr4TDEz4u34Pk
         SZfSrmWatFYy2KO4Pjj+kY97KUg8XALYZYAIIxVQOZy8aisYUDi3rZCkjoFbces7tbm9
         TRcQ+n7SLuSrNDPYWb2CzjTLMwqar6sIEnmtHtBH5JH+vQjIva0LBu4HPimGr/dWFF63
         fh8A==
X-Forwarded-Encrypted: i=1; AJvYcCWYsSWwoDVhr7nwDidB3NkYSRvZxpT2EjB8tRFuJhg42u2qjil+LLEIWZz5b1jbf2G/zIAjM7u1KV2CdYo58w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KuFZpnioe3uLYklACNfUckt1UucV2Yj+FCPxc0JwX5ZoWgUy
	mew6PlN5yprXT2sfAntCEbQeb70V+MRPPV5asiJHsQrA6MKXl2lKafJDBX5WZqOJZGRNG5MUoiX
	dXKvDL1K+RKvrDNur+9uGUVoK939XFN1KvDZNAM0ZAIlSDrxKI//RzcO/oLgB+V7w7FPPoQ==
X-Gm-Gg: ATEYQzy/c9Yc0FJ6yAmPLNmiC3FsW5W/1Wqgi4zmYNvsfBuPS4NvUA1OOcCDvPC1OJA
	lZsGP3GqaPLgFp8znUkerhFV1pmekU/fXEs2PR/BJNriloO+ABkLmqM45e2MAvhSEDHL9F+n8YC
	MrafphWFdSdgSHi1bKzgHHzBwcyJny9HOAjZtlDUOlEBAlLlsnlglQFhAd7w7Qs024/Ok6+XDdp
	l9y90r5dRF6OyDJNW/Sx7OHy6s9S/jvrH8JsIAIi7iiZAQxLpHUGoehVGPt+QWdoygcAnZJmOLO
	SwVV5R5Keb4XmHywTah+XHWwMiq1t1IZOpD2EfLyJbIsnNI4Yav3yyqcR4t+RkDx/Gm7XH6FxtV
	erB2adOocGop9yw6Hnjoq521AE+7n8sQrf1IuhXd28bfAgXDhpLau6wsiXx/43eluPoD8j2u24N
	Sbbhq/N18zTmfk59FEew==
X-Received: by 2002:a17:90b:1845:b0:34a:c671:50df with SMTP id 98e67ed59e1d1-35db8f8ebffmr5487402a91.17.1775009309690;
        Tue, 31 Mar 2026 19:08:29 -0700 (PDT)
X-Received: by 2002:a17:90b:1845:b0:34a:c671:50df with SMTP id 98e67ed59e1d1-35db8f8ebffmr5487375a91.17.1775009309166;
        Tue, 31 Mar 2026 19:08:29 -0700 (PDT)
Received: from [10.133.33.81] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76b96c684csm1889708a12.0.2026.03.31.19.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 19:08:28 -0700 (PDT)
Message-ID: <082b3d13-6fb1-4041-a187-fddec3b013e4@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 10:08:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
To: kfarnung@gmail.com, Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAxMyBTYWx0ZWRfX0qAfLBn0Tiim
 w7Ip07r6y7gUS1NYiMF4tTHpo+vOsKCvYKdA7k0c2vGM2mD+0YZwcR4p6wr2OlKK/8Mzk7aiUgK
 hn5oT40KIs685rbAblXPjIe6t97HeleSNm7IjYdSMgbgOM1GWlHaaWw2Nb4X1AWfWntfowEHQMJ
 xq4G0S/445KoMJjhKMGN4pl0oa5dlKc36ujRPzNuHQQq4T4AFEPDmbEh52IQ21BuWi6pBsWvWPk
 4gg5n9ejJKX+BGgayb9pIp0ONjXi/6y4Byi3R31ChMNxjVE+yunTdd7dLpQWcrsiJh+04t3kWFK
 oqQfKFD1JXTbcFlAZFPkLDPxi8goVTx7ECrypsWUP5rSLOrVIBKU3nNm+9fCJBkvjb2VYijnnZM
 aCcTS4h77zQOx8s9w3BkR5nqsx3NhHRQtVVMjK3rNkWIUrmncOQHORBzjwbCiYV8gSpgcn8Lnqe
 XREit111ZobT3ej/tCA==
X-Proofpoint-GUID: KB4N7pFu6lpJZViXSYpQHMa3QRZyU_c4
X-Authority-Analysis: v=2.4 cv=YsQChoYX c=1 sm=1 tr=0 ts=69cc7e1e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=8k6WQxmsAAAA:8 a=pGLkceISAAAA:8 a=A18gnXuDaOBEhP_xktQA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: KB4N7pFu6lpJZViXSYpQHMa3QRZyU_c4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010013
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-34252-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,quicinc.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4976D373A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/2026 2:32 PM, Kyle Farnung via B4 Relay wrote:
> From: Kyle Farnung <kfarnung@gmail.com>
> 
> Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
> reliability issues similar to those reported in [1]. These platforms

how similar it is? can you describe the issue in details?

> were not previously included in the ath11k PM quirk table.
> 
> Add DMI matches for product IDs 21ME and 21MF to apply the existing
> ATH11K_PM_WOW override, improving suspend/resume behavior on these
> systems.
> 
> Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
> [2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/
> 
> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> ---
> Changes in v2:
> - Fix missing mailing list recipients (linux-wireless, ath11k, linux-kernel)
> - Link to v1: https://lore.kernel.org/r/20260330-p14s-pm-quirk-v1-1-cf2fa39cc2d5@gmail.com
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6cb9c93d9ef692d127fe 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
>  		},
>  	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* P14s G5 AMD #1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* P14s G5 AMD #2 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> +		},
> +	},
>  	{}
>  };
>  
> 
> ---
> base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
> change-id: 20260330-p14s-pm-quirk-0a51ba19235f
> 
> Best regards,


