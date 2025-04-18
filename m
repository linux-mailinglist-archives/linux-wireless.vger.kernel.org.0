Return-Path: <linux-wireless+bounces-21711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96BA930BA
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 05:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2807B5813
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 03:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75B417BCE;
	Fri, 18 Apr 2025 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="csZoymuc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B84101E6
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744946286; cv=none; b=K9Fod2a8oI+KTehgRAuvnO6cB9jkN9eyGqmnmld2RpLMXXhQZeR78uLTCwQycpafrkl8Pk6mlphhTlpFhlrezFgeGbRQ5AheLilI5U9qI17Nf0whORlKpUTMpRKgQjB07hrniYQRouIkIWCNaA+M4HFG+CmyNaV3TYz9fsI/VIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744946286; c=relaxed/simple;
	bh=yXg4f4lZgHe9tVnL0y/LiHP4iAb+wnawcjpZjo38g2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxhmkTTU0c7zsh6y7oPnW8fW5OmNqBcWyNMJMwMOxT8ySIsqQXfbKq9Cdn3VahnH5MIttWGgvL6eJA3gV/t4MkTBUKSxb1DB60B5ifi14lWJ85T+X9Xsinn1sMmOHC8ayfQst+GngQA3hneXi5Ddc3ljJVEW1i22BYFbHqCzrLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=csZoymuc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I1lLSE015328
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 03:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sjNtsLjl1MhP4VJ4DgWpdYaRCGJ6qNprYXb4Lhoqtl0=; b=csZoymucQRtxdO7W
	wocwxbUiKv0Y877RAeEPght3UU18nywM9azD6bVR93JEEhyT97VgUxoEeoe3UU6H
	yuKDG8MjumSvmZu46mHxjr8C13bKxtJwJQ1B7Q9tUPwPdaxaTMgNoSoAbS5wb9Ry
	fbV+Rm9ccz/cQ/9AMBaPe+MCocptMu4rlp75u+pHMWcbMHzRh6KnbJHfbW3ICbdu
	Rs7cpJvova1sj/GeClJYCvZhXxIAdzGwyqdYEtkAU4Vf2RU755RiA3N1L1KU93MO
	CEZB4Ske+sboL15gA1GWu6pVrlPXKgOjXuw9oV7xEuUBdF5Oih0j0SNJYBhsDF/w
	ozOwnA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6ry23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 03:18:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af423fb4f0eso887243a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 20:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744946283; x=1745551083;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjNtsLjl1MhP4VJ4DgWpdYaRCGJ6qNprYXb4Lhoqtl0=;
        b=fzTz/gGT4cEAKh9ZvAN+xT56DS3YUxA/1O3uwKla4Pt4tBl76YNolxyqCt8Ew7z+1g
         rVyz5016dg+y6Z/A+z4/kq4BNoHY7gtkBs9HZm3aTD8oDU0bXm2H1kOslEWF/95F9xxN
         wFw5NdiGqkg/UB0Yn6JiepGJvEHEa8K/EadDjeyjRwZ8R8DAyIE8VCDA1pEcjuiK9JHX
         QpNI6W6LpO2rwDdYmU49/agttkdyKEutWWm6qtD6dj4pxg/skid2PNkoZz0z36iw9hz4
         ugoknm5LX6nD79OIMVkKYXHakkT+0jQqdR3l9Q4ivXTT4+Ds7CQNvvTGvTa2uftSflKf
         ZzGw==
X-Gm-Message-State: AOJu0YyXxbhp0kMu+nf3UVY6K9qQJmMJiodBuH3PATps6AHvZQ5PqIbQ
	m5hilOwFFM8iJ2mZlSfjQ6Dvpofjkua7GgiAoYj6gB4Bt8aQgc8yyC/5/QbZQcryA2kTLdcVl1w
	jNuSJ5ZJyI9+5uk2tDaRenNUF7f8RjtlYZUKUxmvx386njppXFW1aGpsLMWF8VwXrHw==
X-Gm-Gg: ASbGncsX16gPw7ObowQsJUaqy+YddOkcM7bps0/+MBY3QcjL5VghhnSwTvAEntvLrpF
	8l4A5G1QZFyKRZmd664j3dhNwFKdANQ65hbxm63mLglMteNxO/AG2c3zZ/9o1YKigZoROGj8cfX
	E2erijOFPXFL3yFMwD3F9f52NW3U5ZY4ZBdRZo2RvYj/AKdN7Q0GczwnUo/bxd3C8OHkjCargrU
	6cK12d1PNpGcjsduv52RDzEW0MlFSgiuyp5B5IBYoz23DJxYkVENVGs9pRbw7LjbXJ5OEEoFk21
	4JtbdBkiwL1A7BiC6vSYp+0rw7xdlPWZDFqOUPgXIK0AyWZaqScfFyiM3B0Iy97lv4vssV0tuJq
	W/j6t
X-Received: by 2002:a17:902:f706:b0:224:1c41:a4cd with SMTP id d9443c01a7336-22c5356dfbbmr17162915ad.3.1744946282934;
        Thu, 17 Apr 2025 20:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3PYD+Pg4UGB6Ij/R2YPtoD3eHZJXj0rk7RfPp1Oe6quZyohjPzMA5w0TZdD794X1F60+Wrw==
X-Received: by 2002:a17:902:f706:b0:224:1c41:a4cd with SMTP id d9443c01a7336-22c5356dfbbmr17162555ad.3.1744946282334;
        Thu, 17 Apr 2025 20:18:02 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaacf3dsm677237b3a.134.2025.04.17.20.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 20:18:02 -0700 (PDT)
Message-ID: <83e417e5-31d8-4fe5-9774-fd97fb51f663@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 20:18:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5] wifi: ath12k: read country code from SMBIOS
 for WCN7850
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>
References: <20250417024227.1712-1-kang.yang@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250417024227.1712-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yrJ93Mz2L7hSzRsVDl5LrxlDcOelSOI9
X-Proofpoint-GUID: yrJ93Mz2L7hSzRsVDl5LrxlDcOelSOI9
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=6801c46b cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=0wfVUD6UvdP1dahPgv4A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180022

On 4/16/2025 7:42 PM, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Read the country code from SMBIOS and send it to the firmware. The
> firmware will then indicate the regulatory domain information for
> the country code, which ath12k will use.
> 
> dmesg:
> [ 1242.637253] ath12k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
> [ 1242.637259] ath12k_pci 0000:02:00.0: bdf variant name not found.
> [ 1242.637261] ath12k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
> [ 1242.927543] ath12k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-02582-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
> ---
> 
> Note: This patch is an old patch in public review written by
> Wen Gong. Just resend it for him.
> Link: https://lore.kernel.org/linux-wireless/20230913105156.17618-1-quic_wgong@quicinc.com/
> 
> v5:
>     1. fix "From" header.
>     2. rebase on tag: ath/main(ath-202504141512).
>     3. change quic email to oss email.
> v4:
>     1. fix assignment error for case ATH12K_SMBIOS_CC_ISO.
>     2. rebase on tag: ath/main(ath-202503251458).
> v3:
>     1. rebase on tag: ath-202503172347.
>     2. add branch tag.
>     3. add descripition for Wen Gong.
> v2:
>     1. rebase on tag: ath/main(ath-202502181756).
>     2. rewrite commit message.
> 
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 26 +++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath12k/core.h | 27 +++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.c  | 11 +++++++++++
>  3 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 9b23329f1bf2..b5ade9c7530d 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -697,7 +697,7 @@ static void ath12k_core_stop(struct ath12k_base *ab)
>  	/* De-Init of components as needed */
>  }
>  
> -static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
> +static void ath12k_core_check_cc_code_bdfext(const struct dmi_header *hdr, void *data)
>  {
>  	struct ath12k_base *ab = data;
>  	const char *magic = ATH12K_SMBIOS_BDF_EXT_MAGIC;
> @@ -719,6 +719,28 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>  		return;
>  	}
>  
> +	spin_lock_bh(&ab->base_lock);
> +
> +	switch (smbios->country_code_flag) {
> +	case ATH12K_SMBIOS_CC_ISO:
> +		ab->new_alpha2[0] = u16_get_bits(smbios->cc_code >> 8, 0xff);
> +		ab->new_alpha2[1] = u16_get_bits(smbios->cc_code, 0xff);
> +		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios cc_code %c%c\n",
> +			   ab->new_alpha2[0], ab->new_alpha2[1]);
> +		break;
> +	case ATH12K_SMBIOS_CC_WW:
> +		ab->new_alpha2[0] = '0';
> +		ab->new_alpha2[1] = '0';
> +		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios worldwide regdomain\n");
> +		break;
> +	default:
> +		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot ignore smbios country code setting %d\n",
> +			   smbios->country_code_flag);
> +		break;
> +	}
> +
> +	spin_unlock_bh(&ab->base_lock);
> +
>  	if (!smbios->bdf_enabled) {
>  		ath12k_dbg(ab, ATH12K_DBG_BOOT, "bdf variant name not found.\n");
>  		return;
> @@ -758,7 +780,7 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>  int ath12k_core_check_smbios(struct ath12k_base *ab)
>  {
>  	ab->qmi.target.bdf_ext[0] = '\0';
> -	dmi_walk(ath12k_core_check_bdfext, ab);
> +	dmi_walk(ath12k_core_check_cc_code_bdfext, ab);
>  
>  	if (ab->qmi.target.bdf_ext[0] == '\0')
>  		return -ENODATA;
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 44e02ebb1071..3f9fcd4d6f20 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -175,9 +175,34 @@ struct ath12k_ext_irq_grp {
>  	struct net_device *napi_ndev;
>  };
>  
> +enum ath12k_smbios_cc_type {
> +	/* disable country code setting from SMBIOS */
> +	ATH12K_SMBIOS_CC_DISABLE = 0,
> +
> +	/* set country code by ANSI country name, based on ISO3166-1 alpha2 */
> +	ATH12K_SMBIOS_CC_ISO = 1,
> +
> +	/* worldwide regdomain */
> +	ATH12K_SMBIOS_CC_WW = 2,
> +};
> +
>  struct ath12k_smbios_bdf {
>  	struct dmi_header hdr;
> -	u32 padding;
> +	u8 features_disabled;
> +
> +	/* enum ath12k_smbios_cc_type */
> +	u8 country_code_flag;
> +
> +	/* To set specific country, you need to set country code
> +	 * flag=ATH12K_SMBIOS_CC_ISO first, then if country is United
> +	 * States, then country code value = 0x5553 ("US",'U' = 0x55, 'S'=
> +	 * 0x53). To set country to INDONESIA, then country code value =
> +	 * 0x4944 ("IN", 'I'=0x49, 'D'=0x44). If country code flag =
> +	 * ATH12K_SMBIOS_CC_WW, then you can use worldwide regulatory
> +	 * setting.
> +	 */
> +	u16 cc_code;
> +
>  	u8 bdf_enabled;
>  	u8 bdf_ext[];
>  } __packed;
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 7af12733a1ff..aee3080a934c 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -11550,6 +11550,17 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>  			goto err_unregister_hw;
>  		}
>  
> +		if (ar->ab->hw_params->current_cc_support && ab->new_alpha2[0]) {
> +			struct wmi_set_current_country_arg current_cc = {};
> +
> +			memcpy(&current_cc.alpha2, ab->new_alpha2, 2);
> +			memcpy(&ar->alpha2, ab->new_alpha2, 2);
> +			ret = ath12k_wmi_send_set_current_country_cmd(ar, &current_cc);
> +			if (ret)
> +				ath12k_warn(ar->ab,
> +					    "failed set cc code for mac register: %d\n", ret);

FYI I split this line in pending to fix the ath12k-check:
drivers/net/wireless/ath/ath12k/mac.c:11648: line length of 94 exceeds 90 columns

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=2d2ccff4c0efa4cb55d0a21c75c6e7162788f9db

> +		}
> +
>  		ath12k_fw_stats_init(ar);
>  		ath12k_debugfs_register(ar);
>  	}
> 
> base-commit: b80c52642c1159c2596776b39b06eb1c2e36baff


