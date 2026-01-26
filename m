Return-Path: <linux-wireless+bounces-31155-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K5RMnzOdmktWwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31155-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 03:16:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E104837A5
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 03:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA45130038F0
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 02:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4F145B3F;
	Mon, 26 Jan 2026 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R72ArKrG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JoyJwH9K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C71DED57
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393786; cv=none; b=epTNtLHlWAqzyol1pvJe2TfIwVhjGH0omkXy5z8v71/iqn/MIdpumrSJO6IIgEKjOIGpv7Gzi/GSTanWTfvGdWqEp2qgrw6qTUQUSDhQ+uqB75hZ5gdkzqga1EUw4IoBjeI4uB0CABWJFx3EFrHYtyQAcPVu5Ojo3+EicvCmAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393786; c=relaxed/simple;
	bh=N06AZenvQYa3TAQU2wcbc/ymkunpoUbCuA7YNbkFc9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOwBBWGozZAuSBPxpCT7y39P7PxjTctZ3DmWz3CmX9UBTC09N+r4HtX8MRRr67ibcKJZ2LQX5qtZbVU5gIlsgyNlVnwLF8QP/nO0ubknq6dca49CQlPT+Rpjc/vwFitN7eobdyPo9rQCkPI07FI4j/rzmrdvl1sYUXfkillZvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R72ArKrG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JoyJwH9K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60P7Cojc3596623
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 02:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iy/DdxqOHIDPsTQIWdLrhaiBD7ZBiKQeA1fJYxO8FOU=; b=R72ArKrGv4UaF+fY
	0euuCov1cE56U24RcSo9nwNTs+Ywo1zRdQVTnUkUixoO243R0fAEA7BLu3kVVszY
	spJ1kLWkIpYQIGQRiNxhDznuCYQ0oQA404SgCQXDfzhlUqDC89E2on2Nh5DwuvJF
	/hPBbd2ZLiOg1AVV4JI3kSTG5FPm9QdcihUCR8P8s/oQJe52j4vassmgdsHcHoRH
	mU45U8SDZi9E4hyWhkPh+BmpncLarVl+/xvfNAp5dOL9RD5SS8mESTq/5tn7YY6k
	KauekLzF3FV/I3Dp7XMSDbChqPoK0TDPyytJMHXCWD1hrPX/ANpqXT/eP5H20/qK
	nusz/A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq3hb4dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 02:16:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0f0c7a06eso29773385ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 18:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769393782; x=1769998582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iy/DdxqOHIDPsTQIWdLrhaiBD7ZBiKQeA1fJYxO8FOU=;
        b=JoyJwH9KdvPSaP+wX3JB8FJ2f41J3suFM36M+YRjS/VTfR0O/czGeM+7NkHY0AJZST
         BeoOSYPWuUJCkpMClhKZr2gaOcUJLSUApFWqBuekHPyWxKsl7hBtu8Ado1s9Y6v0Ym4f
         27Hj91mG6ybgDJqqNh5uSApGycAP7LKLV1WilsHkCRWFgp6ZsBU3Ke0BmWNREoTCXgNz
         ZYDfUyTLxThdFkwGVZiMnEz22TF8Mfe34BHlXAyHuLNj0/9osr2PgLCL1NV0O00JS32J
         EheYF4rD0QD5IxYYQt6Bg7tTgpNy7LM4jHnQEZ1epjh1r4Y4ef6lpCNeNEBIHoBsXqNb
         2F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769393782; x=1769998582;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iy/DdxqOHIDPsTQIWdLrhaiBD7ZBiKQeA1fJYxO8FOU=;
        b=WbjZKueFFxZNSk/Zq6OCdRFKMVWcA3OglPwaYG1X/SzlU2ux/PJtPxW3aY4I5Rj0kl
         NGo/QRgUpCHe7zvC9qxXGHKm7trbfSlG1eqGo8IgABjUQLCZp+AkXD8QXoiPcsKQFehz
         lmVh466EqK4v9l7PCo9/XByFMeEKXJDc7093PhresiKbvWII/9M66zF6Wxhftb4WKYHj
         UQ5ECD4+IGx/2pgtKo7ZC9S0WFJ84bJgDLQmCaFf+dx4v32a9Lg851bhd7shHKMGC/E1
         ShPCbzC4oc3IcspRSW4ftiGdzGSdDgR8W709gII0/AUrdm8L8mdXXiipa69Vd3SoW4nx
         ecpQ==
X-Gm-Message-State: AOJu0YzkAsKb9Re5ZZPLtZ6pqnGvtjiFhcFuAVYZI0agZ1R7J5cJnbMt
	5mSeOEzEQyqJEh0L5Ej7dZ2AplFhnoScqDWCVeUu0JQ9iWkWBkQNxavx4YIvz4L8mLc+PLyCwyj
	Y63z5etbgT6IK+z5wqtzvUPyNyxUAKBvER6+rlh6tlXiwygx5ErFAzEc6vARNjvOLjiG3bg==
X-Gm-Gg: AZuq6aKA8yyN5wtcEBM/D/jkoGmRT3pm6SbUDY58MFj3+qBML+PwVUHXMGqIMt5xLFI
	Yem3X3Xq7VGBM6YZzRM8mRINpxFD2WiGBf0KSjIC2FziONJwjKCpNQJyB7iNMIL6qwCjmDbpCnE
	FBbc6pqrA9IPCvttw5nMsi29l5nMXi78XUpJJZ+nj/M7fik+DDVcHlADZZMvQsOG7lega/6s2Ty
	NUURAWow+4KKEljNzI+k8FnM/1pAoDlDwVr7YmZWm6VEGZo24nIYOrVRDoNE2XnW0o/qai7qvbE
	AWpCE3up7zB7e8RCyoL8UvhXA+mN+QZv7NMoSrq1uEY+a39yzr6094Q53Jz40Yj+ZJIHes0rfTq
	i1timuTkCT5sP+i1tRq7mouSTTHz3v8p6jVCPxFt5MPc1mvWPM/Y/7c+SYuZFFH/Q2KAAbrOHo3
	3dT1u42Jo=
X-Received: by 2002:a17:903:32ca:b0:2a7:5a8b:fa53 with SMTP id d9443c01a7336-2a8452f0aaamr26325735ad.50.1769393782491;
        Sun, 25 Jan 2026 18:16:22 -0800 (PST)
X-Received: by 2002:a17:903:32ca:b0:2a7:5a8b:fa53 with SMTP id d9443c01a7336-2a8452f0aaamr26325515ad.50.1769393781986;
        Sun, 25 Jan 2026 18:16:21 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fdd123sm75883185ad.96.2026.01.25.18.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 18:16:21 -0800 (PST)
Message-ID: <b28dd974-829f-4bfb-8111-f1c676b7c840@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 10:16:19 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: sdio: add missing lock protection in
 ath10k_sdio_fw_crashed_dump()
To: Ziyi Guo <n7l8m4@u.northwestern.edu>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260123045822.2221549-1-n7l8m4@u.northwestern.edu>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260123045822.2221549-1-n7l8m4@u.northwestern.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDAxNyBTYWx0ZWRfX2dP00Apix7Nc
 3ZMV79Pq9V9y2ZXjZ+Xo3twSqCR1AjNfALHP5G9Kn5LFgGcGFUCiiREM52/7auU8+9Da9Mg7ZOy
 s+6ccFxQl7+5zNEYS4M3byLU97B3rraI+4N2CkMd4E1xuT7BDux2PkS+6VLXNJhQtDnShPCNJyQ
 8q+8ZnxQbACaRL1gSkGesgp92KHkbnB9NtE5+6JaLkFL9Tl/rZAAmJWw7xDsFAnxdni6jcCaor/
 CSRevKrnAhkbb/xezgqEG9Nt+y6+S3ObAutzXhnes8CWrv11VuXyBTbXNLoQScEkY3nDaTFNRJq
 7dG1TPP2bl5vKjcIMe4kVIqgZMGJPHeURddQhMTqt7u9/J1DQFVGbM4j6j7rPYY4T++yXSBDv8b
 QzmEiXRjWk9vZ92X9cOMWFRUaOpgsQQUIYRpNSEILDesx38yS93zWUzJ/EuTZo4peLgzhBDF7+A
 e0wYZTT1GfA2s+olPgA==
X-Proofpoint-ORIG-GUID: XsmYbw2TBBafwLj8L_bF2GIxp-OaQEKm
X-Proofpoint-GUID: XsmYbw2TBBafwLj8L_bF2GIxp-OaQEKm
X-Authority-Analysis: v=2.4 cv=c/imgB9l c=1 sm=1 tr=0 ts=6976ce77 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=e9pQcI1gHFx6xeePYlQA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260017
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
	TAGGED_FROM(0.00)[bounces-31155-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,northwestern.edu:email,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E104837A5
X-Rspamd-Action: no action



On 1/23/2026 12:58 PM, Ziyi Guo wrote:
> ath10k_sdio_fw_crashed_dump() calls ath10k_coredump_new() which requires
> ar->dump_mutex to be held, as indicated by lockdep_assert_held() in that
> function. However, the SDIO implementation does not acquire this lock,
> unlike the PCI and SNOC implementations which properly hold the mutex.
> 
> Additionally, ar->stats.fw_crash_counter is documented as protected by
> ar->data_lock in core.h, but the SDIO implementation modifies it without
> holding this spinlock.
> 
> Add the missing mutex_lock()/mutex_unlock() around the coredump
> operations, and add spin_lock_bh()/spin_unlock_bh() around the
> fw_crash_counter increment, following the pattern used in
> ath10k_pci_fw_dump_work() and ath10k_snoc_fw_crashed_dump().
> 
> Fixes: 3c45f21af84e ("ath10k: sdio: add firmware coredump support")
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
>  drivers/net/wireless/ath/ath10k/sdio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index c06d50db40b8..00d0556dafef 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -2487,7 +2487,11 @@ void ath10k_sdio_fw_crashed_dump(struct ath10k *ar)
>  	if (fast_dump)
>  		ath10k_bmi_start(ar);
>  
> +	mutex_lock(&ar->dump_mutex);
> +
> +	spin_lock_bh(&ar->data_lock);
>  	ar->stats.fw_crash_counter++;
> +	spin_unlock_bh(&ar->data_lock);
>  
>  	ath10k_sdio_disable_intrs(ar);
>  
> @@ -2505,6 +2509,8 @@ void ath10k_sdio_fw_crashed_dump(struct ath10k *ar)
>  
>  	ath10k_sdio_enable_intrs(ar);
>  
> +	mutex_unlock(&ar->dump_mutex);
> +
>  	ath10k_core_start_recovery(ar);
>  }
>  

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


