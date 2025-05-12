Return-Path: <linux-wireless+bounces-22875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B284EAB4406
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 20:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008AB19E4600
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 18:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858B5296FAD;
	Mon, 12 May 2025 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W0l+3+AP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F72528F3
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075618; cv=none; b=IWzybgnfP9FhroACPMdBMSBHK2j+L6kCNQDAx9r2fzhIN1Xxcov5ONhvS433XrYTavhH3fIqfzVUFI7WnfNX6nKAbsVBymMPMI14snckh3igzBGz1KNck7aU2NvB+jQ89ZHERAKuxO8pJoQY5GnXP/lYhgqxlNPQJfZpKQqYARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075618; c=relaxed/simple;
	bh=WC0QSSHSaDJIeTky6FYZ5/aW/w4NwUet7G5HfGnRlTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Or8+y34cQdKqWXxJh7BecRIhhuB/z9Uy8i20i2Pbcju2ltIqJuGqUhA33PL0ocmS9PC5FENqwSho4sNKVOQuNyUTQdEnA1UKkCgF1I/CT94M4rDryuHdsr6G1igLX/Rrbfgccq2v6mhEsG/UNEDquCRG6AfjShLCo99XXNMCzuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W0l+3+AP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHAnbv030481
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 18:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/r5mtaG20KhfYaNuwC8Nolf7zQua6agNHT2giYdPbbo=; b=W0l+3+APuqQo0LFX
	g236I3NUxXGKMXbpA9Ke8JlmNzDqNPDyW4VzT/UwxtmB7CTbs6741vrCtp3yQhxv
	LE3WZP5kQs2r/ac/oIMXrwbK8yZqcKruQ0t5vn32fCUeGvoPyVAGhNxk0dWJJ1UU
	RWjxbP/p/7x8udGOocwqsc+TUG+5tcNpSSQJjcI/Z2mlLNLKMp+0AZ2bxsGgHCr5
	v9gT2V+ETI9JA/WGD4qw3d86DbfmQicXYFccIp/6wsOBKLbynlBxgfI2QOT7Rwz6
	x3foFKY+dql18044P/cwdSvDVc+13ffx1rPJUwChZaXZ4Iw2xmX6pFB/vfJAMgw2
	Q8wYWw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hv5qdkjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 18:46:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22aa75e6653so35057445ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 11:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747075613; x=1747680413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/r5mtaG20KhfYaNuwC8Nolf7zQua6agNHT2giYdPbbo=;
        b=bdqc2SpHqQ/pJhaIf+G7EF/H/yuqgtaScYwAkI+ZRigT5jDMfYEuqN5gXP2Lo5gj/Q
         7iNxhxzvNQE2EfcBrieydKvplui2RlG07W7RkAhzl3l5KB4tgcy6uRP7s+lVLY/Yg8YV
         Gtn+Np5DEomLz+P5DpqP97D0gkYzr4gLsW8vIH8EhR8K20cReCSzgYO86VhA7dw4b2wK
         Zd446q3XuXyE7W0vB9kIYxqdfuCSczFp0N0u8BXaAiC9hco8Xko0zdVwpaFN/iwyBPKj
         SSXsVOpX4WrZW5Otdjc6YmbS0blvlBHQddYUd8aea2P0kEPzZxghk/TkVeUms1/JdxRz
         Ftpg==
X-Forwarded-Encrypted: i=1; AJvYcCW38r3ctnhmT41tEkVlM15N6mPd5DrSCQcLo4VJsQkDMc7n6UQG6+6OPgvnjS1kvxItbf0DBCcidG/AReW2Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSdwqcVCnasxd41mQ7TZK8Y0EwlLYEn2yI5jLw+mpMxi3KvrT/
	e4JB7M0kzBq5c++nferrKIdaOuQOnp9XJ9ymcmeyDHx4oMKTb+E/Ncb5nxIcSI6F4Dr23TDStzg
	FQn+GCQjRCxyQwzEVbAKW0DBHy1QvDZarO+yH6at/053aiBQSW1UaeUEa2n7WsStDIw==
X-Gm-Gg: ASbGncvVpvrBn+oECs+hdz5KpQuOXeeNGmBOxxJnwcN3lzKC1XDULL5DOBBHDyq8+4S
	2fXGdb0j8etd0Xjg5YqCg9tW78+ZZQJwkZI804PlyC2eizPKtQr3ILYLVtdspL5RuBWgCjOr4Kk
	rSKeN7W+C6igx0J/uOo7Mzte6YgrJ0BhyCubCWxhwH3FVOE2aNVQShm4qwzXr9yrU8FOs2Z28iu
	Ug4ccg6flMBP9HBHYkEiGuH1ouNk85TISaRcdSJ6XY7SZsUbPobvT6CRLM+ZGwsY17TfP+1hWlR
	axToX/zG92oEibMirN0VmCGPmkMsZzJBB1Ixiv0tB0pD6NtqLq2nMVOZZffAZQ==
X-Received: by 2002:a17:902:ce86:b0:223:39ae:a98 with SMTP id d9443c01a7336-22fc8b56fdfmr213280545ad.22.1747075613182;
        Mon, 12 May 2025 11:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsWqOd3L30u9cjxgIPmURHi+KkJtpXwBIuouO1S+U1W3n2h4To43nTOBZ4I/fyhCvVNGYpGg==
X-Received: by 2002:a17:902:ce86:b0:223:39ae:a98 with SMTP id d9443c01a7336-22fc8b56fdfmr213280045ad.22.1747075612588;
        Mon, 12 May 2025 11:46:52 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544f5esm66669185ad.36.2025.05.12.11.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 11:46:52 -0700 (PDT)
Message-ID: <4a6b83f4-885a-46e1-ae31-21a4f3959bae@oss.qualcomm.com>
Date: Mon, 12 May 2025 12:46:49 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Youssef Samir
 <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Kunwu Chan <chentao@kylinos.cn>,
        Troy Hanson <quic_thanson@quicinc.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: kernel@collabora.com, sebastian.reichel@collabora.com,
        Carl Vanderlip <quic_carlv@quicinc.com>, Alex Elder <elder@kernel.org>,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org
References: <20250506144941.2715345-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250506144941.2715345-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DqtW+H/+ c=1 sm=1 tr=0 ts=6822421e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=mx74GWaVK5euFb1038QA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 4_LC02Wa13b-bodMc2u7lB7ETbwsD4fN
X-Proofpoint-GUID: 4_LC02Wa13b-bodMc2u7lB7ETbwsD4fN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE5MiBTYWx0ZWRfX6Dc5Q4VxOrGF
 NAy1MrMme6zB8cQxFNsJ7VOyU/K7YXLMuMR3BQaSKTTxXpUQYcPuDfm9qSYct66k1hreSOwbs6t
 69+MmLVeUABb9ROOYvJ1J7kDIw5pB02MUFOyu/fUfcCIOpx9BsKUTF93DRgId0To/HnpnqJofUc
 Ny4avDuds07CdW7Wf7Z99XpyclQsD2lD5G2TGH/+Qyek9KvL9jtERzsmaY+slq1hDWkJFl9f5Hu
 sJa9K4q4nRdmoI47JnDrO9XJCrWvM0irCWb4ZLVKPl+Fn4PnE2YDzgkvr9y/wK5RrTT02RkRgEL
 a9IP8WzDFDMadhBdgQcHA/MsqMlYUj1Rjq5uSXpekPX4OQKuvFjxwx6kFD/oedVgQSZx1IZastw
 4G21xWiQU5nNAsjPUPiYUjkJoi99SuUTq1JeFsCv0kyknr6Aqp3gCwrkegWB32jz+rq3BpjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505120192

On 5/6/2025 8:49 AM, Muhammad Usama Anjum wrote:
> Fix dma_direct_alloc() failure at resume time during bhie_table
> allocation because of memory pressure. There is a report where at
> resume time, the memory from the dma doesn't get allocated and MHI
> fails to re-initialize.
> 
> To fix it, don't free the memory at power down during suspend /
> hibernation. Instead, use the same allocated memory again after every
> resume / hibernation. This patch has been tested with resume and
> hibernation both.
> 
> The rddm is of constant size for a given hardware. While the fbc_image
> size depends on the firmware. If the firmware changes, we'll free and
> allocate new memory for it.

Why is it valid to load new firmware as a result of suspend?  I don't 
users would expect that.

> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index efa3b6dddf4d2..bc8459798bbee 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -584,10 +584,17 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	 * device transitioning into MHI READY state
>   	 */
>   	if (fw_load_type == MHI_FW_LOAD_FBC) {

Why is this FBC specific?

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
>   		}
>   
>   		/* Load the firmware into BHIE vec table */
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index e6c3ff62bab1d..107d71b4cc51a 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -1259,10 +1259,19 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
>   }
>   EXPORT_SYMBOL_GPL(mhi_power_down);
>   
> +static void __mhi_power_down_unprepare_keep_dev(struct mhi_controller *mhi_cntrl)
> +{
> +	mhi_cntrl->bhi = NULL;
> +	mhi_cntrl->bhie = NULL;

Why?

> +
> +	mhi_deinit_dev_ctxt(mhi_cntrl);
> +}

