Return-Path: <linux-wireless+bounces-36659-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIH5OTR0DGqihwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36659-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 16:31:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E895C5808EF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 16:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7F103010F0A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6803ED3D7;
	Tue, 19 May 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mw0ywfGp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UTeH7vpR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3613403E9
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200480; cv=none; b=WtdshfDD1oxJMvDr9Ed5CVa6OkcUy5ZfmKoq6bp5A5p8HdWuOC3kxUx9Sk6RPj4NTPp+Ir5fANePCNhR4np+rcvqTM0pbGBGTRd8TtkwT6SsEpysozis1Ahs9JmtX6WUaUSVGXAAvME5q6petj3DWzbO0lY9k9ZnQqosUHouBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200480; c=relaxed/simple;
	bh=+sY/Rs87S9dXr7yYYtmycLqkHQDNzQ/BDwMqF/18REE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGR4TBMtf62PW7dgWeWCvqQRfXc9KvqMcR6/wuJw0rBGRVXzJj76MlCUgURL9QKmpjIU8mprhYdh0fULoC5avi+ZKOGCJT725XsUeN1AUREEEZtJdtPWCI5U5fd0smsNiZTl8cBht12nkAPCy5ZjlBMKQeXswRoW+Yn11qiTOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mw0ywfGp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UTeH7vpR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JA2xZ11392845
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 14:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yLCy6IjwNHKRdHvEh3dMPg3Yp+4phzm9ObBjZk3Z9yI=; b=Mw0ywfGpQCxFnMzB
	Lgb2Pyf5qoETlLQj8H0qchevDZ6GmrMFT3eH+zU2iyMjd0OOky8j3YJZH0mo2x16
	1d6kAi2HdtVIs78TMi/4WtQV9qUd/AZqpyNxz1BG268WIlHVxQ5meJVkptNtcaMg
	Rm1hiY0gwCfd8i3AlWq7xXJYBcS7ToMAxgwXS7AyKAs5f7dT0mW5h/8BvEvYX1o+
	U97j6Intj/8g4KC3IxsV4BxzdwXF65zGi71xcF8lPSVi1hOBRCAlKekbXmpU7DyR
	nt0qeWDYtnzGDw2Dgy4m0jRvrjRh/xo/MjroXB1JBgHNpkb+03sJCdsyDZpnDfdt
	aKMkuA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ns490v6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 14:21:17 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-135f774f5e6so67671c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779200476; x=1779805276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLCy6IjwNHKRdHvEh3dMPg3Yp+4phzm9ObBjZk3Z9yI=;
        b=UTeH7vpR2Q4pQYhvbotdZObBsXekHQuLmwHz3uZdFyq8Tr2lOgU4iCYzSa8f7lQu7b
         ZpJ6Ssc0x1sPQ1ffmt3ZWwDYPuEKPFvoqANev04SHzBtoU7I9qTg1YMmUKe5iW3IGAG8
         jzyJrG1Qs4pxfttCDsD5ZfpmZZQljali+VnR6jSjmy9pMnpuajo7Lfjjn1tQbHh13rWz
         XC9+Ku05v6HtFCjv4AXOBlyZ4uPs00CwBajgIkIN8ngCrUPZ0uodeNGrct26YKQEZwsr
         BJ4UawwzLoHMRXGPIPTWNmhUdjLh9vovj5AJTAR33Qvz0aGe8o4kzeKj7nLKLBjEuZt0
         ngUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200476; x=1779805276;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLCy6IjwNHKRdHvEh3dMPg3Yp+4phzm9ObBjZk3Z9yI=;
        b=r6xNUUySOWrfdO19sfVSWpZj9qk6sORu9/2vQ2udkJVJKaEraXsSyYlctB1tkPFRGM
         eb0XmgxYmKEu/wiBS8OrUf62tMqDIkckFESDZRMVU3HGcTqFVxJLyAf/8KVTQbPDjLeU
         7rqtf5NU8OANy6GYmX0I/9upRXyn4L+avJDwiMeVDt9+z7erxsE0p5GG36Iz9ouyePJa
         zQ444XACtq5gpmYeeDC4wjLZLTgbRu2pJYZPQbVl6ID4tfgWYmr+gUniayYou/ukLDWm
         64LhX7Vew+y0xdwiya7/h5buOFTCwrvwHKUSmPbFxyAqMTqFEL2fR7JkIYuNODl25nnE
         kxpQ==
X-Gm-Message-State: AOJu0YzFJrA6Xf3Y51iQwvOZwXgvIKFGWnmTEBXjj+84f5srFyI/cFPy
	tvyCvPCbLkV8sD15ZXJ/OQ7HnZsv7qy3a/SxYaUwrKbumG0Ys4mnMun0TT1Z3ZNzfAEyz5NflZt
	G0SZoA3t6PMtIGbDA1djOPW8Kog0e4r4X+imWWNEae3Qw/XVHQ2Dhj/3MCBQr6tr+QrBEcRQwwz
	KIqw==
X-Gm-Gg: Acq92OGWVM0xRt90P1cEly1XYw7KG/xClyRnBLeyr95N6TJmPJrkjNQGfHq7ufFi8gs
	bjBEpLJWudWvr0phXDnUqnrKwFklpLQsQiAOWvcuzpcoKrf3Pjc2Ycthc0bmo0FwSp1S3spGD8G
	clkjpx3xX0JYeyZfMDBpDpTQ61Hswonvzmqgyd15k3oO90jcXRl8ZamDUgnPkfVdG/KLCQPrwKv
	aL1R2psKcZ3yLl1eIl6GWgofIiYyCjD3+QbKxILGVxgIFbyetEhoG2F++mDTvIH6z/a+wxKKqsU
	qy4lu6maMlrF5mLmnof4SWm8aqzZ7Na4aLr2FM8XVHLJ5FcX+nS4G5z6JNFKMiuBUaUe5BpZiRw
	zqVv7o3wvBNh78wmbfpMZgj9j0ubI8d7alZPH8NFXMMXXCSsNdSf++j0WglkfY1dGCVbnEJKlIk
	V5zjO/5IyX7fVAkijM7a+3RBu1
X-Received: by 2002:a05:7022:eacd:b0:12a:8ea4:252 with SMTP id a92af1059eb24-1350430f730mr8792892c88.4.1779200476595;
        Tue, 19 May 2026 07:21:16 -0700 (PDT)
X-Received: by 2002:a05:7022:eacd:b0:12a:8ea4:252 with SMTP id a92af1059eb24-1350430f730mr8792864c88.4.1779200476006;
        Tue, 19 May 2026 07:21:16 -0700 (PDT)
Received: from [192.168.1.38] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm19895516c88.15.2026.05.19.07.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:21:15 -0700 (PDT)
Message-ID: <d88a1d9b-853b-476c-8f01-22fe24590892@oss.qualcomm.com>
Date: Tue, 19 May 2026 07:21:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ath-current-20260512
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
References: <8756e3ff-52bc-4003-99ed-cda3170f118c@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8756e3ff-52bc-4003-99ed-cda3170f118c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MiBTYWx0ZWRfX2UWE5F6zdM+o
 O45eZSXlpcQZpjc1RCT5R4wL9V0owWI9LP/osdt+xyIhfyXcCbNRy1ZA1nSq4x97l+ShzVeIB4b
 uGLf06g+GZ8JyB7OfdJliWT3cVx5tyQA8Pewa/nJVcydmYSaRdIFc/AhoJD9YoNDQe4YZjyrCdU
 VL+Tkms+cd85JFQSMedq43IckbPYea+O8NOMm8/030PFZHzeIi+fhHbHyF1X3uoxZ2QZfWofT7K
 YfTo/p3R9ya4YQssAfx82XIsUqW3jO+EvqqJiQhUWjDwlspY97Tf2xoROF2rhzl0FbtqQt4OVRU
 vcSeZ1vnfnw9nRnw8LBI98tCJXsCcBdA/YXWOQLkM08oDRiIjt9ngSLQ0STKI6hQZkUfIntqdql
 mecB/A/8FiK0SiOybpNipG2DYzjn1CzN8Ptb2OIy2N+VbSDLHnxJPZ3QZDJPM6jsDN8spgBfVH0
 IY/ug0/o2v8WKMUi23g==
X-Authority-Analysis: v=2.4 cv=F6dnsKhN c=1 sm=1 tr=0 ts=6a0c71dd cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=qdzAxcUfUuEVABHHB2UA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: hjPPzzZuaHNXuM3dbBcRH54UVEbtQUow
X-Proofpoint-ORIG-GUID: hjPPzzZuaHNXuM3dbBcRH54UVEbtQUow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190142
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36659-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E895C5808EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/12/2026 7:28 AM, Jeff Johnson wrote:
> The following changes since commit 7666dbb1bacc4ba522b96740cba7283d243d16e1:
> 
>   wifi: cfg80211: advance loop vars in cfg80211_merge_profile() (2026-05-08 09:20:03 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20260512
> 
> for you to fetch changes up to 54a5b38e4396530e5b2f12b54d3844e860ab6784:
> 
>   wifi: ath10k: skip WMI and beacon transmission when device is wedged (2026-05-12 07:00:00 -0700)
> 
> ----------------------------------------------------------------
> ath.git update for v7.1-rc5
> 
> In ath10k, avoid sending any commands to firmware when it is wedged.
> In ath11k, fix WMI buffer leaks on error conditions.
> 
> ----------------------------------------------------------------
> Kang Yang (1):
>       wifi: ath10k: skip WMI and beacon transmission when device is wedged
> 
> Nicolas Escande (3):
>       wifi: ath11k: fix error path leaks in some WMI WOW calls
>       wifi: ath11k: fix error path leaks in some WMI calls
>       wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()
> 
>  drivers/net/wireless/ath/ath10k/wmi.c      |  15 ++--
>  drivers/net/wireless/ath/ath11k/testmode.c |   1 +
>  drivers/net/wireless/ath/ath11k/wmi.c      | 131 ++++++++++++++++++++++++-----
>  3 files changed, 120 insertions(+), 27 deletions(-)

Johannes, since this hasn't been processed, please drop it.
I have some additional patches in ath-current and I'll send an updated PR.

/jeff

