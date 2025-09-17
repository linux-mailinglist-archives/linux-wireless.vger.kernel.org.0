Return-Path: <linux-wireless+bounces-27415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D366DB7D480
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01814615DF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 02:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8102882AA;
	Wed, 17 Sep 2025 02:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fVmjOd1M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E771D8DE1
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077631; cv=none; b=O58SdHRf8BJqajEmwg0K4aFNllNZP65KIwZ9ewEmguqd9DvqEqcTXM5dZsSppZNPYwIpRF0yDzRCmuE/GhpzFJlLQh7VtcE6qd0ENc6vNSH3GPi+tp/xRLD8yHVUWe7zRyn8w1EVx4JNC4d8Ju+TG60rYQ+l9NRD6vzMaJNhmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077631; c=relaxed/simple;
	bh=PYaCux/XezRC08HX8y0HPhA0aHUjvzJAtkTPSH+E26U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6Y8Ri3xloIbcKPmGXsjwgJ0IfsPix7R4Ctpi9S3okTI7WJIKYnKAQFxwHnJR4dOX83HecrUG5QVDqTDCyCOil3txNHdN0UyLgPlvBYKG5uC+PBMlkEAlR4WCYxHpil/0PKj9Yegasa+rXjzE5e2qvr+awInEU+9AQfbfFPTLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fVmjOd1M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLa5Hn007462
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 02:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JVvSRJYOZy4M0EyZrfl1KA2XhA6LsoUDpQuJsCxvIzs=; b=fVmjOd1MKyQMfI1b
	QlNDV9+4OYkXc5pOWWICwcfFexPYI8VLhkm01s6R24IYIupMazgqh6CiSWFG6xxL
	k3H/QUGs43rQ8CGHKdD6DoZiKnq4G9gsbvE9xcJTEOAZidLJmbePXHWf9i14dXOo
	tVO5WRH8xUY1mWbVxn7A78uZtWm7729PVjTZA2mx4iUXJned/EmFDrsegBi0nupp
	Vr+docQHH4FirKvunRs2Uoh8VUnwnbQR7w5hBsXW5gi59RsGH9zunAViRUeATXQ9
	kmJNLz1SoJqnPRrEnJwnsSf1ns2FAxX5AMujHAQXrGJ4To0/iFqaT3uhnQ8MyXqk
	ISRezg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxrna0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 02:53:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-267ac96f558so26585645ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 19:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077628; x=1758682428;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVvSRJYOZy4M0EyZrfl1KA2XhA6LsoUDpQuJsCxvIzs=;
        b=IXcwgIi90lHHSNc3qhDNBoQSv9j6pOSjZzT2Hjcwhe6rUmBON5aMkQb+IYqmcYZyE4
         nHLEszznOsuMcFGlWroJ9ZaQP8X2Qu39TEcYR1tifAnz3g+yGvCKD5pFnEN3ocV2MqOQ
         TdT8fDfeZPBEbpx8/pxKgNj1YJJG17b/qm0m4Cd7IgsMNbVHyO+Vqyv+ySsOLmp6KQS0
         YguKnU8nCAZS+nbW+xBqPBLhY5Pb0X7wsdPslZF/o4u+JVKwjDgTfofmFNS/sHu81WSd
         uLasPqLAX3yL/7452IuQcYmTkRm8XvbdUS6MoEsgMoiNjs77ugpwxtaXvgJuGwhCQGWX
         4asw==
X-Gm-Message-State: AOJu0YyPhZK+tUlTQWUdEoCAcOrJ6DM0jbsByiOAQiXoFtsF2W4UHvrE
	aud3ihGl6HxUlJWkPRIGlxfuV+6q2QZ4PTDu5/uyqGfpExw06Hp+WP9TaFNibEp7FdYLvVKT9GZ
	HzgKqGtXCLOzR3bGRWvIC70SDQds6jMWn4SOmexZvtI3GYYgCTd2ZupVIdlEDaEKNcGlLCw==
X-Gm-Gg: ASbGncsBH5kXfI+YV6CD8aqoP0GWWGneVbkO42wXdtxW4j1fLpJjGLt76AcxrlIgYlS
	8t1H3ySULhx71JNhnrVOWkAR6+VuHOwAnERVLeHa57Kvrfgxl2yANajyFs3ZnZ6yXZhOOMVvvHy
	UR8qHu7KJiNBNWkOBCE6XlIY6LhFsAeDlQGY7i9TqGHQPeg9UiHB/RhwksyP6lq8mYoSNQQrQx0
	SREPXIf+jMzaAOHafT1LnMDljfzWsAgqCvmdeqJCbSDi1ovnKuis3KToruBw+KuhqDp0jNFH58M
	afkmwY9M7qV/ARPABb0TWtQeQhs99jpQD1cuXjIY9lBTIgXnflVUdCanBJXAQRB4+5q7B2Jo5i0
	6h+uBewoFcbq9gVWbT9450qgaVreJwNZaFYAQdA==
X-Received: by 2002:a17:903:11cc:b0:262:661d:eb1d with SMTP id d9443c01a7336-268118b9516mr6794365ad.1.1758077627953;
        Tue, 16 Sep 2025 19:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz+iCnfeGRJhrk/sCunEeIt1saebIFPgtGbAWqNh6uLgGo3jBEi/jlo5xWg6pe3y86gZRZLA==
X-Received: by 2002:a17:903:11cc:b0:262:661d:eb1d with SMTP id d9443c01a7336-268118b9516mr6794105ad.1.1758077627388;
        Tue, 16 Sep 2025 19:53:47 -0700 (PDT)
Received: from [10.133.33.224] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2653fcb5b33sm84326225ad.92.2025.09.16.19.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 19:53:47 -0700 (PDT)
Message-ID: <d1045151-ba85-4412-ac3e-84ee88ac3d91@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 10:53:42 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Add fallback for invalid channel
 number in PHY metadata
To: Aishwarya R <aishwarya.r@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>,
        Vinith Kumar R <quic_vinithku@quicinc.com>
References: <20250723190651.699828-1-aishwarya.r@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250723190651.699828-1-aishwarya.r@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX87qlg+c/8SHP
 ckrUij2AQUmO3Hr7D779tyo7+6pS8iAF/zG7ezOkd9HavfMxOkxs20IKwxh0JiLg6hHWzEVUYjH
 0zpmAacqsg1TihvjNclO/OGNTrJm55YTlgM9xNgcnzO3NkpizN6fVOw08LuImdVWcLErX77ZimN
 kXYv4dywFItymUjGdV6iBKQlPLN/zEl5c6ICPJM7oHouYWfcJsDPib/lTyh54pkmDQfKiM4jtdN
 I3pMoKuEXCVaF0tZ9Txf1x7yuMJDDSj4LMWqu4kugn4ZfombxmH6JWBDD+7stYy18k+W8LPyGPP
 cIw87eVvr7AbVFNKimWfyhXQXP8sy5RiNR66gzdYNez1fQf4A+HFLyZfgJWUPXM7UcycMin6dLa
 gcvhrTAi
X-Proofpoint-ORIG-GUID: Wvk5BnAhGrXcjOovq8ruYAFbE9ezbyN3
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68ca22bd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=FpNJ7K4awL-1w2SDpB0A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Wvk5BnAhGrXcjOovq8ruYAFbE9ezbyN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 7/24/2025 3:06 AM, Aishwarya R wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Currently, ath12k_dp_rx_h_ppdu() determines the band and frequency
> based on the channel number and center frequency from the RX descriptor's
> PHY metadata. However, in rare cases, it is observed that frequency
> retrieved from the metadata may be invalid or unexpected especially for
> 6 GHz frames.
> This can result in a NULL sband, which prevents proper frequency assignment
> in rx_status and potentially leading to incorrect RX packet classification.
> 
> To fix this potential issue, add a fallback mechanism that uses
> ar->rx_channel to populate the band and frequency when the derived
> sband is invalid or missing.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Vinith Kumar R <quic_vinithku@quicinc.com>
> Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_rx.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index 8ab91273592c..adb0cfe109e6 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -2533,6 +2533,8 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
>  	channel_num = meta_data;
>  	center_freq = meta_data >> 16;
>  
> +	rx_status->band = NUM_NL80211_BANDS;
> +
>  	if (center_freq >= ATH12K_MIN_6GHZ_FREQ &&
>  	    center_freq <= ATH12K_MAX_6GHZ_FREQ) {
>  		rx_status->band = NL80211_BAND_6GHZ;
> @@ -2541,21 +2543,33 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
>  		rx_status->band = NL80211_BAND_2GHZ;
>  	} else if (channel_num >= 36 && channel_num <= 173) {
>  		rx_status->band = NL80211_BAND_5GHZ;
> -	} else {
> +	}
> +
> +	if (unlikely(rx_status->band == NUM_NL80211_BANDS ||
> +		     !ath12k_ar_to_hw(ar)->wiphy->bands[rx_status->band])) {
> +		ath12k_warn(ar->ab, "sband is NULL for status band %d channel_num %d center_freq %d pdev_id %d\n",
> +			    rx_status->band, channel_num, center_freq, ar->pdev_idx);
> +
>  		spin_lock_bh(&ar->data_lock);
>  		channel = ar->rx_channel;
>  		if (channel) {
>  			rx_status->band = channel->band;
>  			channel_num =
>  				ieee80211_frequency_to_channel(channel->center_freq);
> +			rx_status->freq = ieee80211_channel_to_frequency(channel_num,
> +									 rx_status->band);
> +		} else {
> +			ath12k_err(ar->ab, "unable to determine channel, band for rx packet");
>  		}
>  		spin_unlock_bh(&ar->data_lock);
> +		goto h_rate;
>  	}
>  
>  	if (rx_status->band != NL80211_BAND_6GHZ)
>  		rx_status->freq = ieee80211_channel_to_frequency(channel_num,
>  								 rx_status->band);
>  
> +h_rate:
>  	ath12k_dp_rx_h_rate(ar, rx_info);
>  }
> 
> base-commit: 708243c62efde8241e2c66e9c3f377658855149d 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


