Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D08787743
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbjHXRrB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 13:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbjHXRqr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 13:46:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6CC1BE3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 10:46:41 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEZ4I4013541;
        Thu, 24 Aug 2023 17:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JHl0ViCN2wARh66NKPDZ6jzV6YKPe00MnA5YHD6nKlU=;
 b=MUTWKI7QjMTfcXe+GlrVa8BsANX7tpKZ0V4/A9ZeRw262WnMUl1tL5dUq4XONL3iO0tp
 uCX2yfJZQ3NXrXcihT4RqzE4stejYTjTYublMhFYcWtTRqx2jS28C7IrTnQu2ihy87Yv
 wlKkoaYvDfZHMPTDKk12qPUDhlamXQv7TZX6tdMNPqcEY8QVGkb1v1l0CYjpRlaNlJcC
 4YIl/5h0TjOG5VcBqsDR+yLA60UV0nmc0HTs53hVTBu/KBwltRK3m75jVNeFP+3CF7Xa
 6ZRfM5v9QDUns1h4+d2etBLhhKfFVvMbDE9xwLPlGp79OcTap1Y3vfCDilFXIRZVXi51 Pg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snt61adwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 17:46:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OHk7IT029922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 17:46:07 GMT
Received: from [10.48.247.99] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 10:46:07 -0700
Message-ID: <10733baf-fa3d-452d-a6da-f40a416658a1@quicinc.com>
Date:   Thu, 24 Aug 2023 10:46:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] wifi: ath11k: use kstrtoul_from_user() where
 appropriate
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, Tom Rix <trix@redhat.com>,
        <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>,
        <ath11k@lists.infradead.org>
References: <20230824075121.121144-1-dmantipov@yandex.ru>
 <20230824075121.121144-4-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230824075121.121144-4-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uT0V3VmodbrO68SAphXW5NNsICnZt-n4
X-Proofpoint-GUID: uT0V3VmodbrO68SAphXW5NNsICnZt-n4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_14,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=607 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308240152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/24/2023 12:50 AM, Dmitry Antipov wrote:
> Use 'kstrtoul_from_user()' in 'ath11k_write_file_spectral_count()'
> and 'ath11k_write_file_spectral_bins()'
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath11k/spectral.c | 26 +++++++---------------
>   1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
> index 97eb2a457685..b5530e484507 100644
> --- a/drivers/net/wireless/ath/ath11k/spectral.c
> +++ b/drivers/net/wireless/ath/ath11k/spectral.c
> @@ -382,16 +382,11 @@ static ssize_t ath11k_write_file_spectral_count(struct file *file,
>   {
>   	struct ath11k *ar = file->private_data;
>   	unsigned long val;
> -	char buf[32];
> -	ssize_t len;
> -
> -	len = min(count, sizeof(buf) - 1);
> -	if (copy_from_user(buf, user_buf, len))
> -		return -EFAULT;
> +	ssize_t ret;
>   
> -	buf[len] = '\0';
> -	if (kstrtoul(buf, 0, &val))
> -		return -EINVAL;
> +	ret = kstrtoul_from_user(user_buf, count, 0, &val);
> +	if (ret)
> +		return ret;
>   
>   	if (val > ATH11K_SPECTRAL_SCAN_COUNT_MAX)
>   		return -EINVAL;
> @@ -437,16 +432,11 @@ static ssize_t ath11k_write_file_spectral_bins(struct file *file,
>   {
>   	struct ath11k *ar = file->private_data;
>   	unsigned long val;
> -	char buf[32];
> -	ssize_t len;
> -
> -	len = min(count, sizeof(buf) - 1);
> -	if (copy_from_user(buf, user_buf, len))
> -		return -EFAULT;
> +	ssize_t ret;
>   
> -	buf[len] = '\0';
> -	if (kstrtoul(buf, 0, &val))
> -		return -EINVAL;
> +	ret = kstrtoul_from_user(user_buf, count, 0, &val);
> +	if (ret)
> +		return ret;
>   
>   	if (val < ATH11K_SPECTRAL_MIN_BINS ||
>   	    val > ar->ab->hw_params.spectral.max_fft_bins)

