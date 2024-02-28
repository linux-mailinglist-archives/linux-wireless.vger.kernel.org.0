Return-Path: <linux-wireless+bounces-4206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BDE86B3D8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 16:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9ECC1F2D735
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2626915CD5D;
	Wed, 28 Feb 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jojpmHSA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64E15B99E
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135671; cv=none; b=uH0WqSKMtsYJ0xSvOPtChDj14tNMPq4kOcPXufCk4OARRpdMO9mcavm9uFZ+bwyPlGSvjIW6mCml3DMfc9UYG7gVHPAG7PBRmlg3ojlS/pAv8zEfybQMkgjulrhQ+j0pck/NXtz8XAvX1t9WH+bUbpNXt+rhAesB4yvIvrLktqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135671; c=relaxed/simple;
	bh=iwRJRIuIobmNV7gqABwlstN+7p4wjpQObuLK77wgugY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PIEVKPPff66BN39Enhyxghad1AnXr3OPVCpzQAepXAcrUuZIwsxXd3xjtisrLiEtL/9S4tD00ydLJasxN1UJPfVgWkPPjn13EhWZxuTRl3YhZQtLC9KU8a3r282iRyY7Yzx5DJOjC/NSukkZ01i4UYHFlnyI7Al3vJI1TyLuRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jojpmHSA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SBMC7t003720;
	Wed, 28 Feb 2024 15:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jCMY1kRheSJ8wXd9sCi/k84OcVHKtwMU9rrcefoFk5M=; b=jo
	jpmHSA1tAdDwsgO9uFZ6Nq+Gsodo3itY/SyrMKpbjc7Ni8p+PMt33Nq7PBUJ7h3q
	DKBxmAiyjaEzYTv3ABhDy+DzfsuBkFvFwGM8LY5ftK4Ka+IRKMclgnTfkcHCTlOc
	J8ZXrJyjGEPPGERzZfzSdIY/xTufx1oyfMxH2uyLQFfax44g0xgzHK/CsXQnhJ2F
	QfoBxRLGZ8hGD3eZXprAA+Nbi+amHArUOlvH7+Aa6sM/b2JIFk9gmzA6EuCK3coH
	ieLVuUEmQwYbmzQ9lLPHfILVPcOhEZ/9m5MwaoivT9tmqBXuz5o54AlhfQABAsEk
	6mdOpY53G7e05RPdc6kQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whw3f1kav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:54:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SFsL12006854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:54:21 GMT
Received: from [10.110.113.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 07:54:21 -0800
Message-ID: <788f1df8-64e1-4b3c-ae8e-00c67be1c3de@quicinc.com>
Date: Wed, 28 Feb 2024 07:54:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix few -Wmaybe-uninitialized warnings
Content-Language: en-US
To: Dmitry Antipov <dmantipov@yandex.ru>,
        Baochen Qiang
	<quic_bqiang@quicinc.com>
CC: Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240228131406.165786-1-dmantipov@yandex.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240228131406.165786-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Sjc8y0hYHA6-Wk1R-a3eP3B5wfCO3e3l
X-Proofpoint-GUID: Sjc8y0hYHA6-Wk1R-a3eP3B5wfCO3e3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 clxscore=1011 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280124

On 2/28/2024 5:14 AM, Dmitry Antipov wrote:
> When compiling with gcc version 14.0.1 20240226 (experimental) and
> W=12, I've noticed the following warnings:
> 
> drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_mac_op_remain_on_channel':
> drivers/net/wireless/ath/ath11k/mac.c:9230:12: warning: 'ret' may be used uninitialized
> [-Wmaybe-uninitialized]
>  9230 |         if (ret)
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
> And a bunch of them traced to uninitialized fields of the same
> variable, e.g.:
> 
> drivers/net/wireless/ath/ath11k/spectral.c: In function 'ath11k_spectral_process_data':
> drivers/net/wireless/ath/ath11k/spectral.c:700:47: warning: 'summ_rpt.meta.freq1' may
> be used uninitialized [-Wmaybe-uninitialized]
>   700 |         struct ath11k_spectral_summary_report summ_rpt;
> 
> Fix all of the above by using 0 and NULL initializers where appropriate.
> Note there are few more (less obvious) -Wmaybe-uninitialized warnings
> still remains, but they're hardly possible to fix without running on
> a physical hardware. Compile tested oly.
> 
> Also noticed by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c      | 2 +-
>  drivers/net/wireless/ath/ath11k/qmi.c      | 4 ++--
>  drivers/net/wireless/ath/ath11k/spectral.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index a6a37d67a50a..b89bc7ceaaa7 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -9201,7 +9201,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>  	struct ath11k *ar = hw->priv;
>  	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
>  	struct scan_req_params *arg;
> -	int ret;
> +	int ret = 0;

NAK
the only time ret would be uninitialized is if the initial switch()
processed an unknown state, in which case we should stop processing, not
process as successful.

the correct fix for this is to add a default: to the switch() which
warns and sets ret to an appropriate errno

Please submit as a separate patch

>  	u32 scan_time_msec;
>  
>  	mutex_lock(&ar->conf_mutex);
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

I hate this since the only time ret would be uninitialized is if len is
0 (and hence we never execute the while(remaining) loop), but nothing
ever calls this static function with len == 0

but the alternative to this is to add a guard check and that seems like
overkill, so this one is ok

>  	u32 remaining = len;
>  
>  	req = kzalloc(sizeof(*req), GFP_KERNEL);
> @@ -2406,7 +2406,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab,
>  {
>  	struct device *dev = ab->dev;
>  	char filename[ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE];
> -	const struct firmware *fw_entry;
> +	const struct firmware *fw_entry = NULL;
>  	struct ath11k_board_data bd;
>  	u32 fw_size, file_type;
>  	int ret = 0, bdf_type;
> diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
> index 79e091134515..4c826b539404 100644
> --- a/drivers/net/wireless/ath/ath11k/spectral.c
> +++ b/drivers/net/wireless/ath/ath11k/spectral.c
> @@ -697,7 +697,7 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
>  	struct ath11k_base *ab = ar->ab;
>  	struct spectral_tlv *tlv;
>  	struct spectral_summary_fft_report *summary = NULL;
> -	struct ath11k_spectral_summary_report summ_rpt;
> +	struct ath11k_spectral_summary_report summ_rpt = { 0 };

prefer just {} since that works correctly if we ever want to add a
non-scalar as the first member

>  	struct fft_sample_ath11k *fft_sample = NULL;
>  	u8 *data;
>  	u32 data_len, i;


