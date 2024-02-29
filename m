Return-Path: <linux-wireless+bounces-4268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C05C86D5D3
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 22:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245E21C22496
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 21:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27C13F01E;
	Thu, 29 Feb 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a0CB9qrm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B42145660
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240424; cv=none; b=BRaDGes0e4GbqytrJco9wpJbsAFIeOWplwi0u5iOBv3y7YcD0eDsxvQLQguMzbts929L866RI1bYC2nZfAaLVX5Wj+MAsZBRChneAR+yZwtb7Y2HDGyubI6N31k3XsQTOczkwP7eJn7gmuJspO1eQC4DhcpjHvahFQezLixdfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240424; c=relaxed/simple;
	bh=slE1wQkH0bkG2PjgRkEYf9rH7TKsyVssRGzsTNIrdSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NJOKl9B4o/28Vu+ns+D080xipwi4B+ojFcs9ZFveLyBORli2qngtuppkw9UDJlfV3hmZm5A0XXYdGIZSvHEsBgIfbFgTPsjE4j30nciFDuHqs68zsuFJ0AO4FApooWgZaE+bRjDYLBEr9BhQD4Q9tLFYDGgg07fOzvzbRFwQ5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a0CB9qrm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T4v70L012347;
	Thu, 29 Feb 2024 21:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ApQRCiX+pUSEZ322c1brt4n1jWIQjUilSvI/o652IsU=; b=a0
	CB9qrmu1wKAMmJ3eDlveJ5bAipfMLri9d4WWXu2iFLkmentE2IwWnbVgW8Hqawnv
	hhomp1lDUrNL0hK3X6IaLB8wXnOwN8f3bWqdKt3d+XfE1h+bDYWV+iFXdx6bDFS1
	dJqnq1Zg2U2KfRzzhuofJcLE87w/1Qqr5T/o+k9d9FE2VT5K/ake73ddal1UQtFk
	s/GlUPbYagNzizr0DtcrEfiNQqQQ7Yi0DLYpwooVGDzKnxspRlJLn9DlNdDqvxDo
	DEtxz0hlQlG63uAEX6GvGJMOwhHkeXol77NebeJ+zsM8ngLZaIeyuufooHP7M38p
	GFchlUe0fZlXx6/wpGiQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjexhk64b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 21:00:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41TL0Fsc028961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 21:00:15 GMT
Received: from [10.110.42.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 13:00:14 -0800
Message-ID: <8d0fd9bc-6da1-4d72-962a-60074940e1bb@quicinc.com>
Date: Thu, 29 Feb 2024 13:00:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] [v2] wifi: ath11k: fix few -Wmaybe-uninitialized
 warnings
Content-Language: en-US
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Baochen Qiang <quic_bqiang@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <788f1df8-64e1-4b3c-ae8e-00c67be1c3de@quicinc.com>
 <20240229084031.51957-1-dmantipov@yandex.ru>
 <20240229084031.51957-3-dmantipov@yandex.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240229084031.51957-3-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9bkxZD2-yygKe2qHBKYAqvK-vlsDrCb9
X-Proofpoint-GUID: 9bkxZD2-yygKe2qHBKYAqvK-vlsDrCb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402290163

On 2/29/2024 12:40 AM, Dmitry Antipov wrote:
> When compiling with gcc version 14.0.1 20240226 (experimental) and
> W=12, I've noticed the following warnings:
> 
> drivers/net/wireless/ath/ath11k/qmi.c: In function 'ath11k_qmi_load_file_target_mem':
> drivers/net/wireless/ath/ath11k/qmi.c:2401:16: warning: 'ret' may be used uninitialized
> [-Wmaybe-uninitialized]
>  2401 |         return ret;
> 
> drivers/net/wireless/ath/ath11k/qmi.c: In function 'ath11k_qmi_load_bdf_qmi':
> drivers/net/wireless/ath/ath11k/qmi.c:2494:17: warning: 'fw_entry' may be used uninitialized
> [-Wmaybe-uninitialized]
>  2494 |                 release_firmware(fw_entry);
> 
> And a bunch of them traced to an uninitialized fields of the same
> variable, e.g.:
> 
> drivers/net/wireless/ath/ath11k/spectral.c: In function 'ath11k_spectral_process_data':
> drivers/net/wireless/ath/ath11k/spectral.c:700:47: warning: 'summ_rpt.meta.freq1' may
> be used uninitialized [-Wmaybe-uninitialized]

looks like a false positive since ath11k_spectral_pull_summary() always
sets the entire meta struct:
	memcpy(&report->meta, meta, sizeof(*meta));

>   700 |         struct ath11k_spectral_summary_report summ_rpt;
> 
> Fix all of the above by using 0, NULL, and {} initializers, respectively.
> Note there are few more (less obvious) -Wmaybe-uninitialized warnings
> still remains, but they're hardly possible to fix without running on
> a physical hardware. Compile tested only.
> 
> Also noticed by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: use {} initializer (Jeff Johnson) and aggregate to the series
> ---
>  drivers/net/wireless/ath/ath11k/qmi.c      | 4 ++--
>  drivers/net/wireless/ath/ath11k/spectral.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index 5006f81f779b..4477f652e068 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2293,7 +2293,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
>  	struct qmi_txn txn;
>  	const u8 *temp = data;
>  	void __iomem *bdf_addr = NULL;
> -	int ret;
> +	int ret = 0;

as previously discussed this one I'll begrudgingly take.
please submit as a stand-alone patch

>  	u32 remaining = len;
>  
>  	req = kzalloc(sizeof(*req), GFP_KERNEL);
> @@ -2406,7 +2406,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab,
>  {
>  	struct device *dev = ab->dev;
>  	char filename[ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE];
> -	const struct firmware *fw_entry;
> +	const struct firmware *fw_entry = NULL;

note that this also seems to be fixing a false positive.

the "maybe uninitialized" reference is:

out_qmi_cal:
	if (!ab->qmi.target.eeprom_caldata)
		release_firmware(fw_entry);

fw_entry is currently assigned:
	if (ab->qmi.target.eeprom_caldata) {
		...
	} else {
		snprintf(filename, sizeof(filename), "cal-%s-%s.bin",
			 ath11k_bus_str(ab->hif.bus), dev_name(dev));
		fw_entry = ath11k_core_firmware_request(ab, filename);
	}

So unless I'm missing something it is always the case that fw_entry will
be initialized when ab->qmi.target.eeprom_caldata is not set.

>  	struct ath11k_board_data bd;
>  	u32 fw_size, file_type;
>  	int ret = 0, bdf_type;
> diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
> index 79e091134515..9834e7dc5120 100644
> --- a/drivers/net/wireless/ath/ath11k/spectral.c
> +++ b/drivers/net/wireless/ath/ath11k/spectral.c
> @@ -697,7 +697,7 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
>  	struct ath11k_base *ab = ar->ab;
>  	struct spectral_tlv *tlv;
>  	struct spectral_summary_fft_report *summary = NULL;
> -	struct ath11k_spectral_summary_report summ_rpt;
> +	struct ath11k_spectral_summary_report summ_rpt = {};
>  	struct fft_sample_ath11k *fft_sample = NULL;
>  	u8 *data;
>  	u32 data_len, i;

so NAK on changes which "fix" false positives.


