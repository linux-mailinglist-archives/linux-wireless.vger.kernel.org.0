Return-Path: <linux-wireless+bounces-21450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D703A862EC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 18:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1294E3AE6E2
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47C219A80;
	Fri, 11 Apr 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V7MoOUKZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2691214A97
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387814; cv=none; b=NZzMQdbUZekHr3q5AbyE5VM/SMqdIuCgAmy0dSpX+EPhqKYJ6bPU1LiEXSXA4Lci3tqNLUM1gZkuR+Ei9ExZizdHCc22r2OPk/qLEP6GxlG/CNvvhVYSMWMucd7gb2guUwjPh6vylQXUhi5Cu0A/141o/xPH6b4JbUbiNTCMEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387814; c=relaxed/simple;
	bh=qrCP2BujL6HWxpDYmtzJxPSHI073Ts2D+gTXSIcARQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MESUSvD85SHN7MpyOWTDJ0Pyd/E1XaJCPiX8cwaOsdxJ0lNSEZNPg/VxbzdzxvzsKqgSaE5CPVInoSvZLo2hUpSJqFhmI4I2Xxs7n3lw9kJVIIRG4njXaqNzezMr7nSQPznkVcZy+/cUZ2Biwds9OmavzeXGLMmk76sYPt9P+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V7MoOUKZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BB5dn0022544
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 16:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e5rpuA8qxGMaIOxTbCdg2rfqyx4ShOI4xfCipIIYeHA=; b=V7MoOUKZ/1yBAGRa
	mY5pOkDvLuh2dKHhYm8xU2J/WKuMbwKqI8vr/udNWYm4W89Wb3G1+xy7CnB9RFyn
	3Qc7lLsMf/PrMC8L481qdhe+ifEGzkrqxkaUA+JQG7ROBirGYhU+SqA3Vwdro9j5
	yqpWYcYuQL26a+14DDQj7a9aClpzZ0TZRgC3wog/d5lCqw02swAeyZ1Er4e/ZuLX
	C/XBI1SGNO+e9RoHbdy1xBEgX4ab5p5W2xm0aoqSm4/vQHigO1xDitA7SYUSReoG
	oep39SIiJ4EMGVCNR/45DnxO88/vLu36T4YMZpz6Img12zhIOAOK/aUVgRFid4aA
	zSD7WQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcru304-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 16:10:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-306b590faaeso1872114a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 09:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744387810; x=1744992610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5rpuA8qxGMaIOxTbCdg2rfqyx4ShOI4xfCipIIYeHA=;
        b=RSAmHfy9BtxgWR0fjM+fR+lW8HQ0IiCGlrfN/E9tS3FIaod5BM3wi2RBA/pqPAy3wf
         RbLUHkhcTsyUvRdu59kcXfG23MWP/1jYmFVV5vR7PGeCYqnfwAj0UeWzIZAmK23iZE6Z
         wDG7Max/O5m2ztfvPP8rpkzj2Wvpv4YjFtipoX2lBw+diyODnjoOY8iCjemztzJBwDrC
         mHtAwzEPYGz/h1NLh2gKk/AOCj9nXI2ZoL9FVknzdyBQovmwH9+iHNHoVszZ4sIN4Y/g
         iqL9rXZzNl9PLlbV2M8K8ZK1StKgPWnMw/1mpyr/C3plPPoApEsPOVKaocSuY4HcqiPg
         dg0w==
X-Forwarded-Encrypted: i=1; AJvYcCW8GHsLNm+LBuyh5xReUW9e9ZqjpsXEs7QaPzMp+GG0xBoTxtAI4fgu2xL67Ym8GX6R+8niXP/Wgn3UZvPLLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMquGNMHNZrdhpBTsueyFSySRg3Fgn7+MinwEHlK2TORjB7otY
	S5vvjQWMQ+N36etqMZHYKPJq8B3qJQosz3ieYjzv+TEUcKMiEgEftbe+m5XDQEKK3BQErxIGros
	KRdo7+PaCZCct6lPSRPVx/GFwNeObwx5aFLmx3Fo7OvD7CmhvltG1tWKhnTffmtbFcw==
X-Gm-Gg: ASbGncv4nvJl+qq8D7xfu2hBdv71dyemC/phRqTGx9P99paZslu72rRVp/+2T+fjIMp
	rfhhAxTKy2karfdKGaLW7JeEA7jwcrEazrMKhR06WV8uXkk7uFjB7g6hEirlGhgcMvSg2WCSX5g
	K8qOxdatuy3uq4x0LvRg7tl0h0koOL7B4fqDnpLStNOhc/w3GNnAp2xrihoe1ADAvDa4e31iB3N
	GvgovGKTAcrfmUAjPNAkmFiIhKeuiVAMjakeHyTz9JE8oU9/3A4Y+WKYR206R1lWena1d3AYGa9
	w4rE8uzdyMHC7XOk52zf39AHAGWxMEtk2o1qJUuwuvhHnhaEkYtg9kZ6nY0+JA==
X-Received: by 2002:a17:90b:5190:b0:2ff:4bac:6fba with SMTP id 98e67ed59e1d1-3082367ccebmr5671769a91.24.1744387809741;
        Fri, 11 Apr 2025 09:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjZpokDSvkhfn81duM4VOLav5f2ONQTT0XHhAhCsXbdnQYgeEgXsPcTARrKTVnEFzPynw94A==
X-Received: by 2002:a17:90b:5190:b0:2ff:4bac:6fba with SMTP id 98e67ed59e1d1-3082367ccebmr5671721a91.24.1744387809277;
        Fri, 11 Apr 2025 09:10:09 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df4011f1sm6356192a91.41.2025.04.11.09.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 09:10:08 -0700 (PDT)
Message-ID: <37ea52d5-11de-49c7-a676-ec47cca7f91b@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 10:10:06 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>, Yan Zhen <yanzhen@vivo.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Qiang Yu
 <quic_qianyu@quicinc.com>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kunwu Chan <chentao@kylinos.cn>
Cc: kernel@collabora.com, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20250410145704.207969-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250410145704.207969-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Lu44yzMp9n-4MUf_EQmHF67MZspB_ynF
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f93ee3 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QX4gbG5DAAAA:8 a=IgFyvoMS5YvtXyuxQG8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: Lu44yzMp9n-4MUf_EQmHF67MZspB_ynF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1011 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110101

On 4/10/2025 8:56 AM, Muhammad Usama Anjum wrote:
> Fix dma_direct_alloc() failure at resume time during bhie_table
> allocation. There is a crash report where at resume time, the memory
> from the dma doesn't get allocated and MHI fails to re-initialize.
> There may be fragmentation of some kind which fails the allocation
> call.
> 
> To fix it, don't free the memory at power down during suspend /
> hibernation. Instead, use the same allocated memory again after every
> resume / hibernation. This patch has been tested with resume and
> hibernation both.
> 
> The rddm is of constant size for a given hardware. While the fbc_image
> size depends on the firmware. If the firmware changes, we'll free and
> allocate new memory for it.
> 
> Here are the crash logs:
> 
> [ 3029.338587] mhi mhi0: Requested to power ON
> [ 3029.338621] mhi mhi0: Power on setup success
> [ 3029.668654] kworker/u33:8: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
> [ 3029.668682] CPU: 4 UID: 0 PID: 2744 Comm: kworker/u33:8 Not tainted 6.11.11-valve10-1-neptune-611-gb69e902b4338 #1ed779c892334112fb968aaa3facf9686b5ff0bd7
> [ 3029.668690] Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
> [ 3029.668694] Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
> [ 3029.668717] Call Trace:
> [ 3029.668722]  <TASK>
> [ 3029.668728]  dump_stack_lvl+0x4e/0x70
> [ 3029.668738]  warn_alloc+0x164/0x190
> [ 3029.668747]  ? srso_return_thunk+0x5/0x5f
> [ 3029.668754]  ? __alloc_pages_direct_compact+0xaf/0x360
> [ 3029.668761]  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
> [ 3029.668774]  __alloc_pages_noprof+0x321/0x350
> [ 3029.668782]  __dma_direct_alloc_pages.isra.0+0x14a/0x290
> [ 3029.668790]  dma_direct_alloc+0x70/0x270
> [ 3029.668796]  mhi_alloc_bhie_table+0xe8/0x190 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
> [ 3029.668814]  mhi_fw_load_handler+0x1bc/0x310 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
> [ 3029.668830]  mhi_pm_st_worker+0x5c8/0xaa0 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
> [ 3029.668844]  ? srso_return_thunk+0x5/0x5f
> [ 3029.668853]  process_one_work+0x17e/0x330
> [ 3029.668861]  worker_thread+0x2ce/0x3f0
> [ 3029.668868]  ? __pfx_worker_thread+0x10/0x10
> [ 3029.668873]  kthread+0xd2/0x100
> [ 3029.668879]  ? __pfx_kthread+0x10/0x10
> [ 3029.668885]  ret_from_fork+0x34/0x50
> [ 3029.668892]  ? __pfx_kthread+0x10/0x10
> [ 3029.668898]  ret_from_fork_asm+0x1a/0x30
> [ 3029.668910]  </TASK>
> 
> Tested-on: QCNFA765 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes sice v1:
> - Don't free bhie tables during suspend/hibernation only
> - Handle fbc_image changed size correctly
> - Remove fbc_image getting set to NULL in *free_bhie_table()
> ---
>   drivers/bus/mhi/host/boot.c           | 15 +++++++++++----
>   drivers/bus/mhi/host/init.c           | 13 ++++++++++---
>   drivers/net/wireless/ath/ath11k/mhi.c |  9 +++++----
>   include/linux/mhi.h                   |  7 +++++++
>   4 files changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index 9dcc7184817d5..0df26100c8f9c 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -487,10 +487,17 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	 * device transitioning into MHI READY state
>   	 */
>   	if (mhi_cntrl->fbc_download) {
> -		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
> -		if (ret) {
> -			release_firmware(firmware);
> -			goto error_fw_load;
> +		if (mhi_cntrl->fbc_image && fw_sz != mhi_cntrl->prev_fw_sz) {
> +			mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
> +			mhi_cntrl->fbc_image = NULL;
> +		}
> +		if (!mhi_cntrl->fbc_image) {
> +			ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
> +			if (ret) {
> +				release_firmware(firmware);
> +				goto error_fw_load;
> +			}
> +			mhi_cntrl->prev_fw_sz = fw_sz;

This seems confusing.  Why do we care about the previous fw size when we 
care about the allocated bhie table size?  Also, if the fw size is 
smaller than the allocated table size it looks like we'll do a 
free/alloc, when it seems like we could jsut use the memory we already have.

>   		}
>   
>   		/* Load the firmware into BHIE vec table */
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 059dc94d20bb6..65a47c712b3a0 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -382,6 +382,7 @@ struct mhi_controller {
>   	const char *fw_image;
>   	const u8 *fw_data;
>   	size_t fw_sz;
> +	size_t prev_fw_sz;

No documentation?

>   	const char *edl_image;
>   	size_t rddm_size;
>   	size_t sbl_size;
> @@ -662,6 +663,12 @@ void mhi_power_down_keep_dev(struct mhi_controller *mhi_cntrl, bool graceful);
>    */
>   void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl);
>   
> +/**
> + * mhi_partial_unprepare_after_power_down - Free any allocated memory after power down partially

This looks like it exceeds 80 char.
Also what is a "power down partially"?



