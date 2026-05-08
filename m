Return-Path: <linux-wireless+bounces-36113-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBvsOrS4/WkSiAAAu9opvQ
	(envelope-from <linux-wireless+bounces-36113-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 12:19:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FCC4F4E82
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 12:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B04653020D6A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF1B3CB2FD;
	Fri,  8 May 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gikB54Xq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eRRPOQ0w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6F35F5E5
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235453; cv=none; b=ifFLy9xjpVj3kcPULhAI5JUSkaNSCj+G0mREa3wVmlQr4RBhxGA6Hchgdf+vcOUbsX2aE3w4uqcs0ld7TTKXR+0G9dqEOs0778FZA1yAcUTa+YO7fOeZYOt1I3XDisllwU0QCe1M7IMPR7yLM3lzTgEsdn7NHQIa+6iAD8f72q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235453; c=relaxed/simple;
	bh=7l7cGhpNbdr5NgHLKtvAAXWC1iBX2YGjybOk71zucpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQ+mgg7uBKU3Je1wn4Nd9LCBXcFOLskEcp2TqV7ZxOzmjXQZBiHGvd4Mlb9UiLzKUUKTpu/r9FNOjM9pmV2LzKRBTGxDvxBhCWYQDqbDK5xqMLaX/kUteHbLuybhFBtPfzuaGlTOliM72+eZb4zYKH6sGWmd85D+y/X/XerYq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gikB54Xq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eRRPOQ0w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6489luUH2770845
	for <linux-wireless@vger.kernel.org>; Fri, 8 May 2026 10:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tNZcgmPe7g/gugoXZYXQBUDZ5/5M8HR0b31ktIIL+Mc=; b=gikB54XqvkG0xuS7
	dZHNuMztip0HvVoGq+Nls9Su6YfPfstBxP9BafYf/gWGuv1qyl5xyxLr/rUsYg6Y
	oIoLOTipJ/DOo7Q16+w/5g4R74n0/l6RGSehLdHpkBhVTUrPjUthTMC7TU92FzG3
	FNLvk1XsFdgqHLROZvRamgIR2h62bsU6bj5547g8pd72DCFrHBc7h07x9e7+etjl
	Z+VCwTxLMmH+9n+/9Q1Ipekl0YLCL1H43sXdhzCBKwwHFt1Tvt/xEl2mgJQWHPHp
	B+kI8XwS+QjDnTl0/w6iiDkU7PBBK5qsZTwv/u0g3Fqq0yup6CST6Raik4x84TQi
	Md/jgw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0yt5k6xe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 10:17:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3663cbff31cso2106908a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778235450; x=1778840250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNZcgmPe7g/gugoXZYXQBUDZ5/5M8HR0b31ktIIL+Mc=;
        b=eRRPOQ0wPPOaP0OdcUNJo0OgDwY5f5KaWb4H3xA8EZUZgBtQreV/PT+bi/0lU9o+nK
         HpPbdsK7QNBQ1NsX49tJFdT8kn/tBQJkenboxHtjMikvmzKE96gGQPndUSYxE1VidT0a
         cTU+krZZF4xRuGxTmBcZcdWyWNW74ZeBGyMvgWpeiLCgoDDnu18f3AksvXbUliZSwnbS
         HAOxQwEcmdaGlkvbq85gJmTlO9gj2F26gBcetjKZknphEFYfFgIN9w3Mej5Hwt/ySW3R
         L9Z0Mwia3N0tpOJP0B5L4jOlBF2Joku7rUGN4xQuZnQCTkBLUDPMWhFWjO9RkWGZ+1Nf
         ZdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235450; x=1778840250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNZcgmPe7g/gugoXZYXQBUDZ5/5M8HR0b31ktIIL+Mc=;
        b=cbplUCYf3rvI7oTBjSWCJM/EZU3ZrWI+O43ykLQ765aSYw9yvz7VCEHfJomkomGy5t
         g5qD86g/zXqdaB0L1sE5pvxqfizFdHiOF8cmxereUM3qVPNCTJxigH3SSQZQPHHReLv0
         ByM9HqmWBvKSFaPkcrymRInpIba9NnfpWJimI2CV52+qwDe7BX1n0yRWTIRwUCEc4cZX
         6KTCUgP6wlySb8AqxghiTjE7rR2qEIc2J4ToeSi1Md2717F5R/H5Z9H1pMnhAg2/dyL7
         E4RC5k72fggq9i6y7t0/o3dh0Dlv2RybqtUkX5YdP0ULjtyALpJoRs7QnzNNMVQo2dOG
         1k7A==
X-Forwarded-Encrypted: i=1; AFNElJ+kF3zT7YIPylk2XWsiB1ZHwgxYSoTPuD1Kfs/GEFsvmClY1ez2N422Nk6DFCCJUeE5jcEFl2Of+qyscAF2pQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYkuSPfaNyyMn8Xz+Yi/9nSF1ZH7ZD4hg1sSxyzBI3OJIMY4K
	KpP4R4rhlBuWrti6KdPJLPrbzYJcwFYbB2q1dK2/hTlS3H3IhTFfdl8HswL/L9yegC8cguF0C0/
	r17U6mS3I/uXdQGwtnpOrtgVYJIBItRcT4NJed5+h5WXR4/1izfjPZjgk7XvQ/3OFobgEXA==
X-Gm-Gg: Acq92OH2jUmsgO6i0Wtz3cqqv9gwCc897xrFplZXet9/9y/QzPfK/M0S31XFuHSK3xz
	wJpmu379ak+NvKcQ+SWcMBjZynLm/PThMPt06zAHasImKl2S5GgjYZ2feY8q61IY7jj5JFk/DSS
	CApsfYoWYL1rJkbsUKi7yGDc6AB1MZV82i3mDOqNWsII5A3v4Kc+C83aKLF6bvFINHFwXvlNmr5
	6WtqkscpvPdjtV0Wog2sSH2H5EzdJIyKIZXNyJ8TJsBviCMzUsPPDfgpstdmdKoT+USzOQWBxMw
	fr+NlEUegR1XNOpb0D52jQKr+RRG1M6tMjy5TbMCWBJW0btcxOe0UTTODOi2ieD336MnVe3+jP+
	T5JOIl6gdXMV9sxtGry98R2qsH3201hXy02cSSo4d17Y6OQHVrQ8P6Qnc1TotDg==
X-Received: by 2002:a17:90b:1e0c:b0:35f:b75e:fff5 with SMTP id 98e67ed59e1d1-365ac4786f3mr11550135a91.22.1778235450416;
        Fri, 08 May 2026 03:17:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1e0c:b0:35f:b75e:fff5 with SMTP id 98e67ed59e1d1-365ac4786f3mr11550110a91.22.1778235449882;
        Fri, 08 May 2026 03:17:29 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-366495998d0sm951408a91.5.2026.05.08.03.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 03:17:29 -0700 (PDT)
Message-ID: <336655c6-4dac-46e9-a783-549f0a9cccea@oss.qualcomm.com>
Date: Fri, 8 May 2026 15:47:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
References: <005af843-da19-4df9-af67-2cd148b24d62@oss.qualcomm.com>
 <20260507070808.367442-1-jtornosm@redhat.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260507070808.367442-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Dc0nbPtW c=1 sm=1 tr=0 ts=69fdb83b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=zWE2KlgL49PTva82SeMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: a8V216cUJREf_i-3Wi5YtbWymn0BXaBY
X-Proofpoint-ORIG-GUID: a8V216cUJREf_i-3Wi5YtbWymn0BXaBY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNiBTYWx0ZWRfX4Rq6k+XdklKn
 s3Pt+GomSh/DZgnXq5BRss3owzNU3nQwSV8KfWyJ4ezz01DT0bWwBRBlcaZ4zgxJf8y0iDGuln7
 Ta0SX4uerlMUwwafFF4XtrM3oWfbdMlRNcTr2kIlAAThv1EPZbGeeQKugt7al/F0AEaXRqg/U/u
 kFh4dZL+spNaoYqNkeFP4TgbEM/p7i70YJOdLObQOKd1zTlPTDyeyk7Ie7q+uqtOim1cdXWUxAY
 QR/5WvOXHc8xWMp3tANy9dZsFwBxlojOEJ1UGbIYj1mWOnH0fEjd/MLRehf3yHpcmju7zjAKnJJ
 ClPODl41fEfn9vLC2d4NUq5yFoyEf2vgKczhAvXaknIeItx3v6Gj1lk+UGofCdaqG3VbFk9L1U3
 qYTMVE/yEzlMuG9nnrAvFJ6/wSg59e7GxKc91HeB8LZungzrZkjmgGUNqrivo1z6DahRzoHNlKO
 3uYLhZXm7OonNEH9r5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080106
X-Rspamd-Queue-Id: 72FCC4F4E82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36113-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/7/2026 12:38 PM, Jose Ignacio Tornos Martinez wrote:
> Hello Rameshkumar,
> 
> The hardwre that I am using is QCNFA765, but I think it is something
> related to ath11k driver and not related to some specific hardware.
> 
> I am running with the latest upstream kernel and I can reproduce it, so
> I think it is not related with the problems that you comment.
> 
> Let me repeat this to try to clarify:
> 
> The easiest way to reproduce it is to run in a VM the default upstream
> kernel (with this card using PCI passthrough), and since this is always
> failing, just unbind the device (ath11k_pci).


What is the exact failure? Do you see any driver error logs when it occurs?

> 
> The same problem was fixed by me for ath12k driver here ca68ce0d9f4b
> ("wifi: ath12k: fix warning when unbinding"), and I have seen the same
> problem is also happening for ath11k driver.
> 

Got it. I was just thinking along with the proposed fix — whether we 
might also need to handle the sequencing on QMI failure.
In other words, do you think the issue(double free) would still be 
reproducible if we include a change like below ?

index 1397756d6251..5bbb53a6b404 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3295,7 +3295,11 @@ static void ath11k_qmi_driver_event_work(struct 
work_struct *work)
                         clear_bit(ATH11K_FLAG_CRASH_FLUSH,
                                   &ab->dev_flags);
                         clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
-                       ath11k_core_qmi_firmware_ready(ab);
+                       ret = ath11k_core_qmi_firmware_ready(ab);
+                       if (ret) {
+                               set_bit(ATH11K_FLAG_QMI_FAIL, 
&ab->dev_flags);
+                               break;
+                       }
                         set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);

                         break;



--
Ramesh

