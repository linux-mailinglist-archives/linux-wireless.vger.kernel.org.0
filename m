Return-Path: <linux-wireless+bounces-30716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B98D162D7
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 02:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 086AB3015E09
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CAF1DF73C;
	Tue, 13 Jan 2026 01:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XLb1uq7O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uhl6fmZ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80368A945
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268072; cv=none; b=C6fvVrIfFnZMf3/bK4wo+HgXRRr/rZ61CgL8DrpryWC8Mw2eEPEa0Zw8+9fkQMdZFTELm744YAjzvqVnGla8RBT3IKkkiSeYVYTAUrF+w+OP0gJ3PxlAG4p+6ZCBIKcsH3pzEtDUx/e/YiISNAkjMJWZcEMoP20maStMKbnejDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268072; c=relaxed/simple;
	bh=zdVm2Sctpg6DenLJfv5e7C0KE6IiKh63mxgtbiHwNrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMfZRuRu/BohWp7e+mPNBdDh409zMvGXOQbStbwz6JJCkijrWDyn2/9kYbeN7aKMP0EJIkfNxVmd+e73grF3RZ5fbMuq2koPT/BRYWQ+Kb7MTQyA1sujLxo0Xjb7A77us3WzNvrtNW+A9AurXeyAuZczS6aGhglOEDAKC0MlCiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XLb1uq7O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uhl6fmZ/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN6Ocl2607176
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 01:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q9HRL8DYnJZ0Vdy3N+epIachOpN2+uBmJ67ZbFp+eyQ=; b=XLb1uq7OQJ0PmKU7
	oFZv8c2KfHFCX/tcweA92o0VUJk2Mo8D+denqLf9p/ZqnOWaeas3p3g8Ag3sbnXK
	epT1v8WvJ2PG/OS7jT2Bv8y3P/BBn8nUEnAmCbU1yzGYCYkp953iU4RlRWbCbZgi
	6v5F9ateTGddivh3EETVmxrfdDVjcxitBcdybseZo8TBI3xJaXCfvJDqOCB00TTg
	6GBIUXwIQwQsoYffUt4AHkMgwXihnztZDXJu4/P5m//guclMo0QyofwUJe+TU4h3
	ZFTwPAPqzdZnfJTzAe1zbf+DchHNPZyZDio20YAQ+mx0RmMl2ddOU1dz3y5pNPg2
	Aylo1Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn7uyrqym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 01:34:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34ab459c051so3581795a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 17:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768268070; x=1768872870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q9HRL8DYnJZ0Vdy3N+epIachOpN2+uBmJ67ZbFp+eyQ=;
        b=Uhl6fmZ/JicRgjT90MAv279lMm2tUCg4pbvMmZaMhrpCLyhUBwoMcOq7HkpDA3tVzy
         9vjBFQWVa3U8H4F/oY9ruclPdHUrao7WwejI1oejmBGzVOQhT9efY/0DJ/8oSUzsHCUK
         V6YU8oMCkJcW9OZ5SKo0L0uAn55jG7116rcZ2KzAV/oqgIpRWJba0+QB28dc7gLOOqTc
         CBuBmZtlN7q5xzKzTrc2d0SbaPqInsIz3f1EZ7HQ25lWID9vqWF8+24yxiQzIYcr7qlw
         jv7Enrsv39ExO0dw8lMvsPjy6MC6wNi+9BK5s22XrKM6MjTOLvzF4Q7hcSGxe1nY8rEf
         zGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768268070; x=1768872870;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9HRL8DYnJZ0Vdy3N+epIachOpN2+uBmJ67ZbFp+eyQ=;
        b=CDIPLSsVrO3/RJuKStsW6zxZ0KpznZJVIBCguP5xhFInpmvdfdxLP90O9BkZNMOro4
         dWkBJlfgu06cEvB4WtuD1bkqnyMOBBUgdlIv4xZUODOZtH5lM3dElIxsRkIHr5VvF2Y7
         k8CZeajbejTtg3cxdRzQ5+yPIpt7vT1gL9GkcG3g7+NO9a08VgckBSLGOK0KxxKqPB6u
         39zwvBWW52Iy8DPmMPPTQzlZ/fLkkEwsc1saVr1cWIUZ3x1myLRh/dzFX0aIAX6mJYJP
         DNTVurTb2P2QrXZUfU+u6YKqZ8dDxjUMFvLZq8HTrSMrPq5m2SZ0lmWjzPu12QrUENJA
         KOrg==
X-Gm-Message-State: AOJu0YxqTH7R0RDtsR1e8Zr+0NcZEjvoDMWV4htGGjfPD2kCQ3y+AUpM
	YYCVH/7VYFK+b76o0Mm7szaXfyrfExDJlu25bNC1jsyM2jPb+1kfhB5l4z5F3f4PUwLXyy45S6x
	Endr8R4CBty2tGh/f6i/ZGvCppmuDLnZI33WaK5lAue2VmJLcgQFYNTKx6S8EPwIvwZpCFLrzJ2
	yCXQ==
X-Gm-Gg: AY/fxX6DrqHO1Vmm6+o/5LWdyv2EkZihL1lZcVaOOt+O10eU9bCB1Y9prEiu3lpW/SH
	eLJnnImhbOlsmIWORkUuUO+5ZkT/1Iwva1gml0+mflPBEI5dvBzWjwDoqZoKUlqkRJ18wxihDUD
	WAd/v37RRw/XeVL+KiXFbb3xYMSs4FCLdpAMPBWoARLj8iQ5CaKnibLr791iXtX0QectDLxWpJW
	emfBvoAK+JqlIq7YDiFO5iuVFDFtbje12xuPamcv1prsReo6dMsx2mVk8sBfgLD5C8W58Q33uYI
	lWFVEVYoZoRA3dKn7sfsfMMdtWk8/jnG5D7oAtDW1gZAaPo+R8MiwpAC9iGeFH8R5MRs6WuRq2n
	60wAEuvYtE0c21JtCnBRT5hiklchgRi7+6pPDogTWPobmyDqaivzzDRBOC06wVpxfkxpVt3AY5C
	hnQN4v+Ws=
X-Received: by 2002:a05:6a20:7353:b0:35f:5fc4:d885 with SMTP id adf61e73a8af0-3898f8cadb4mr16290157637.9.1768268069905;
        Mon, 12 Jan 2026 17:34:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH5Md5MJJ8H47dOGI1ykwikUJ0+mF9/NRK3jmEyXA7H7rvx5qRlPHZReOZh3wtrbD4D+yr8Q==
X-Received: by 2002:a05:6a20:7353:b0:35f:5fc4:d885 with SMTP id adf61e73a8af0-3898f8cadb4mr16290138637.9.1768268069389;
        Mon, 12 Jan 2026 17:34:29 -0800 (PST)
Received: from [10.133.33.243] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c50347bc321sm16124280a12.18.2026.01.12.17.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 17:34:29 -0800 (PST)
Message-ID: <3ac48d30-1ea9-4019-b95d-8e84fa928ae7@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 09:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix scan state stuck in
 ABORTING after cancel_remain_on_channel
To: Yingying Tang <yingying.tang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
References: <20260112115516.2144219-1-yingying.tang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260112115516.2144219-1-yingying.tang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: furv5l0yfkSjyRyb6oeMGJDwWxZZC2nT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAxMSBTYWx0ZWRfX1gyVaHgRE1eG
 +HtdQ3YYmlviVlDcm53SUQd7DdJcP/SDtm4sdq8bTLfGCoX99AFRcgcTcYC80p8aoj3tIXonvGm
 P8GaKcD8vbmi/S3Pu5zrKwAB6lX9CGj5ylazCsWRWhnxPdZxwbqUlnGLw/2Fq5UXTGECXtFoQ66
 R66woQvB+d7k4t5faGIREiCKKdCV3oJvj8RuCbp9d7ebdIq4fLubne7ZQbhJhniCg00C2Yg2kan
 uH24d+pKs982P3eqZNZlq5d3WDDk4vKsOT9LEA4A6pIIWe/r8lNJAmeOAjPMke7q2x8C2fSqsUC
 Op3uWjkUeLX/WLdFOrGfME3ryOfEz2nAz0ZhhzcHl/DLdimVWIl3DGJz1DYPAHarrm1eiQN6fpL
 gf9oycj6Kn+b1A9qoQrUkjsq1YdkrKSQJoEU4i61iQ5LzbwAGvrIGiSwkJGvvzvnSeFv6KZbHG5
 j/HSsitcRatSgaTS3AA==
X-Authority-Analysis: v=2.4 cv=bpdBxUai c=1 sm=1 tr=0 ts=6965a126 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-X8cQwupIys0bDsp_XkA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: furv5l0yfkSjyRyb6oeMGJDwWxZZC2nT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130011



On 1/12/2026 7:55 PM, Yingying Tang wrote:
> Scan finish workqueue was introduced in __ath12k_mac_scan_finish() by [1].
> 
> During ath12k_mac_op_cancel_remain_on_channel(), scan state is set to
> ABORTING and should be reset to IDLE in the queued work. However,
> wiphy_work_cancel() is called before exiting
> ath12k_mac_op_cancel_remain_on_channel(), which prevents the work
> from running and leaves the state in ABORTING. This blocks all
> subsequent scan requests.
> 
> Replace wiphy_work_cancel() with wiphy_work_flush() to ensure the
> queued work runs and scan state is reset to IDLE.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 3863f014ad23 ("wifi: ath12k: symmetrize scan vdev creation and deletion during HW scan") # [1]
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 2f4daee9e2f0..7b72db3193d6 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -13448,7 +13448,7 @@ int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
>  	ath12k_scan_abort(ar);
>  
>  	cancel_delayed_work_sync(&ar->scan.timeout);
> -	wiphy_work_cancel(hw->wiphy, &ar->scan.vdev_clean_wk);
> +	wiphy_work_flush(hw->wiphy, &ar->scan.vdev_clean_wk);
>  
>  	return 0;
>  }
> --
> base-commit: d0309c054362a235077327b46f727bc48878a3bc
> 
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


