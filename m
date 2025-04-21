Return-Path: <linux-wireless+bounces-21782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B7FA94C8B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 08:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4651891551
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 06:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655DD2571D0;
	Mon, 21 Apr 2025 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xx0Zs0uy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615CA20C473
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745216777; cv=none; b=JLujzxbLUVKxjFCZhQQXJTULhgkExH8rEaSUiGyOVNBYXzrke5muzw58u+YWs9eJHbBxQj5wsk8BTsv6EAhonWxGBxyIbC04Cr2JoVqMalZLJCsTk/QT0qrSbgKZVswTTBMOsge+d0O8haCi+TKyUVVXL7Kaag679+/0Hr60+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745216777; c=relaxed/simple;
	bh=shfSbBKaJO6F+GH4M7z2f3Siz1ZXQjYrrH/nzBD+UCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaNDrfFJtHSQxDeewsvqHyAEJbTQBd9EpTgx0CtLIM/bbgQauVfM23EFAaEbcxNCDi+saSf0yzDta9sukc5WLOBkfBws3sS50q4lHAF0qqhRZtQhx91Dl10QGS2xEKIpGRRf8kAOIpzQLFbQrDTJugUAoS0aNePdTf5rPRoE5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xx0Zs0uy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNqm0u023986
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 06:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	81wtBN9+V7tXS0MM9Mk0cNCiAxviM10Y/8IbcHUZVzk=; b=Xx0Zs0uy2PLEplQm
	Figf5rUsODrhui6vPd+zq3iq0iKAAONZ2d1FAVf46wqXz18YsSV2iMCfsDMmtRhz
	6YNRKD74g//tv1pvpAmoa98FRNjmJ1V+9154oWG17RZ1aRjJ1fpjpkyAhIVTQvKE
	v0edFFPQ1zJVZaFfir7Y2hA5Qo5RaFjx1LZGgFhYrTdGZUu6CV9NSs94lIxnRgzI
	8RD/aX2pY+Rl2glZJ/TysrvTTffLORv7vU2SAY0zo9I2RrkvTnxSCE82FEeXeISX
	ZrNt117Zd37WWfkNrYNF/cI+aCI+oPjW/INLzoVJ01DCmJULWdHDDxlO7aGpL1ci
	QfRZ5g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 464426k5n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 06:26:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22650077995so57339035ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 23:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745216773; x=1745821573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81wtBN9+V7tXS0MM9Mk0cNCiAxviM10Y/8IbcHUZVzk=;
        b=NSuRDRnhq7/Q92plTokN90FY726fvxXdFKmoQygj26jOANgwMS4/Od0rmkj74kZvmw
         /Sezpwup68m2kCb8rjiJK8nusQrdxmLzxXxo1YGTANiK5sL2PSu3fvAraft5x1w6+Msk
         BUjVauzdm6hZjyzxNvDf5SAbZNINQMfiU/lpM5r6Sz8OWfZesPV3CxKyysmJlQubo7DE
         psXYTr7+kfzthvNEi8TgMJRmXNDDqiOi2eaG8h8EE3L50rwAbQilU9oiLHa6zJJiA1eU
         oPVz7xq/itjiWawJrL7Pudyd8lmr1HU32yDC2vMUauxXWCosShqyFBNHVjRiqcl+LDtP
         Se1A==
X-Gm-Message-State: AOJu0YwN831/2N/J0NGSg9LidjI0x6AZr/w0YAESZa2uTasZtmebc+kI
	1yoJ6pEuGtDJQYcC/mIc1lu1wc70uaIxN7QDC+IA0w5l17ydvE+Zsm/b3hrx1omqqhA0AiP8IW7
	09CLea28x++u5v+oHYvVSzV2+un1yjpMyh2A8nbMR8KZGve1VjIh36P3xvU9PRHg42g==
X-Gm-Gg: ASbGncsDMrbqySi+kPPlblP0sQN/KoFY4ctkAxUQ74XIv7w8Mnuwr9UO8RJZyHxbyFO
	jMZ4T97ODYCW3kEAjz6sHEgBn6rYAyzO5mKWCUw9bIDRz0DE50mbKbLx2AdCzCp/TmdLJtsAets
	qN4IbiaMCC1toslPodeQJl5BEkrRM1mITZGXam7ZBUDtqSy3y6MhL7YAeShmM9LrvldbYNboDm/
	C3BxgJ4LvrsAkOdiIipoUsduTGzuK2kba+tSRPBVozQ/T60OEeSfIsflBYEjhLBKCXfosYcCRqK
	kAG/A8dEziUMJEm2iO2hC3jjRk4fMtHr2T3GUnvzTye+XR8+sRaamJ/PiMsdQVwhtVXvMiWIsZs
	=
X-Received: by 2002:a17:903:41c7:b0:220:faa2:c911 with SMTP id d9443c01a7336-22c535a4b39mr144450985ad.14.1745216773203;
        Sun, 20 Apr 2025 23:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz7puTIUYsZfLXpiAYIfV0IpMtR7YCW1rRySiCsm+qOdt9M669LFqpmigrbCIjADkzxITKxw==
X-Received: by 2002:a17:903:41c7:b0:220:faa2:c911 with SMTP id d9443c01a7336-22c535a4b39mr144450715ad.14.1745216772785;
        Sun, 20 Apr 2025 23:26:12 -0700 (PDT)
Received: from [10.133.33.171] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fe2411sm57881205ad.256.2025.04.20.23.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Apr 2025 23:26:12 -0700 (PDT)
Message-ID: <8d428614-adea-43a5-a47f-457b569bc604@oss.qualcomm.com>
Date: Mon, 21 Apr 2025 14:26:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5] wifi: ath12k: read country code from SMBIOS
 for WCN7850
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>
References: <20250417024227.1712-1-kang.yang@oss.qualcomm.com>
 <83e417e5-31d8-4fe5-9774-fd97fb51f663@oss.qualcomm.com>
Content-Language: en-US
From: Kang Yang <kang.yang@oss.qualcomm.com>
In-Reply-To: <83e417e5-31d8-4fe5-9774-fd97fb51f663@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: umWi9BcrhumQUuISutge6N4CSZNXpnCl
X-Proofpoint-GUID: umWi9BcrhumQUuISutge6N4CSZNXpnCl
X-Authority-Analysis: v=2.4 cv=IP8CChvG c=1 sm=1 tr=0 ts=6805e506 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=h2vc5te2_RImeTn38vYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210048


On 4/18/2025 11:18 AM, Jeff Johnson wrote:
> On 4/16/2025 7:42 PM, Kang Yang wrote:
>> From: Wen Gong <quic_wgong@quicinc.com>
>>
>> Read the country code from SMBIOS and send it to the firmware. The
>> firmware will then indicate the regulatory domain information for
>> the country code, which ath12k will use.
>>
>> dmesg:
>> [ 1242.637253] ath12k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
>> [ 1242.637259] ath12k_pci 0000:02:00.0: bdf variant name not found.
>> [ 1242.637261] ath12k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
>> [ 1242.927543] ath12k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-02582-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
>>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
>> ---
>>
>> Note: This patch is an old patch in public review written by
>> Wen Gong. Just resend it for him.
>> Link: https://lore.kernel.org/linux-wireless/20230913105156.17618-1-quic_wgong@quicinc.com/
>>
>> v5:
>>      1. fix "From" header.
>>      2. rebase on tag: ath/main(ath-202504141512).
>>      3. change quic email to oss email.
>> v4:
>>      1. fix assignment error for case ATH12K_SMBIOS_CC_ISO.
>>      2. rebase on tag: ath/main(ath-202503251458).
>> v3:
>>      1. rebase on tag: ath-202503172347.
>>      2. add branch tag.
>>      3. add descripition for Wen Gong.
>> v2:
>>      1. rebase on tag: ath/main(ath-202502181756).
>>      2. rewrite commit message.
>>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.c | 26 +++++++++++++++++++++++--
>>   drivers/net/wireless/ath/ath12k/core.h | 27 +++++++++++++++++++++++++-
>>   drivers/net/wireless/ath/ath12k/mac.c  | 11 +++++++++++
>>   3 files changed, 61 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>> index 9b23329f1bf2..b5ade9c7530d 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -697,7 +697,7 @@ static void ath12k_core_stop(struct ath12k_base *ab)
>>   	/* De-Init of components as needed */
>>   }
>>   
>> -static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>> +static void ath12k_core_check_cc_code_bdfext(const struct dmi_header *hdr, void *data)
>>   {
>>   	struct ath12k_base *ab = data;
>>   	const char *magic = ATH12K_SMBIOS_BDF_EXT_MAGIC;
>> @@ -719,6 +719,28 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>>   		return;
>>   	}
>>   
>> +	spin_lock_bh(&ab->base_lock);
>> +
>> +	switch (smbios->country_code_flag) {
>> +	case ATH12K_SMBIOS_CC_ISO:
>> +		ab->new_alpha2[0] = u16_get_bits(smbios->cc_code >> 8, 0xff);
>> +		ab->new_alpha2[1] = u16_get_bits(smbios->cc_code, 0xff);
>> +		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios cc_code %c%c\n",
>> +			   ab->new_alpha2[0], ab->new_alpha2[1]);
>> +		break;
>> +	case ATH12K_SMBIOS_CC_WW:
>> +		ab->new_alpha2[0] = '0';
>> +		ab->new_alpha2[1] = '0';
>> +		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios worldwide regdomain\n");
>> +		break;
>> +	default:
>> +		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot ignore smbios country code setting %d\n",
>> +			   smbios->country_code_flag);
>> +		break;
>> +	}
>> +
>> +	spin_unlock_bh(&ab->base_lock);
>> +
>>   	if (!smbios->bdf_enabled) {
>>   		ath12k_dbg(ab, ATH12K_DBG_BOOT, "bdf variant name not found.\n");
>>   		return;
>> @@ -758,7 +780,7 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>>   int ath12k_core_check_smbios(struct ath12k_base *ab)
>>   {
>>   	ab->qmi.target.bdf_ext[0] = '\0';
>> -	dmi_walk(ath12k_core_check_bdfext, ab);
>> +	dmi_walk(ath12k_core_check_cc_code_bdfext, ab);
>>   
>>   	if (ab->qmi.target.bdf_ext[0] == '\0')
>>   		return -ENODATA;
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index 44e02ebb1071..3f9fcd4d6f20 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -175,9 +175,34 @@ struct ath12k_ext_irq_grp {
>>   	struct net_device *napi_ndev;
>>   };
>>   
>> +enum ath12k_smbios_cc_type {
>> +	/* disable country code setting from SMBIOS */
>> +	ATH12K_SMBIOS_CC_DISABLE = 0,
>> +
>> +	/* set country code by ANSI country name, based on ISO3166-1 alpha2 */
>> +	ATH12K_SMBIOS_CC_ISO = 1,
>> +
>> +	/* worldwide regdomain */
>> +	ATH12K_SMBIOS_CC_WW = 2,
>> +};
>> +
>>   struct ath12k_smbios_bdf {
>>   	struct dmi_header hdr;
>> -	u32 padding;
>> +	u8 features_disabled;
>> +
>> +	/* enum ath12k_smbios_cc_type */
>> +	u8 country_code_flag;
>> +
>> +	/* To set specific country, you need to set country code
>> +	 * flag=ATH12K_SMBIOS_CC_ISO first, then if country is United
>> +	 * States, then country code value = 0x5553 ("US",'U' = 0x55, 'S'=
>> +	 * 0x53). To set country to INDONESIA, then country code value =
>> +	 * 0x4944 ("IN", 'I'=0x49, 'D'=0x44). If country code flag =
>> +	 * ATH12K_SMBIOS_CC_WW, then you can use worldwide regulatory
>> +	 * setting.
>> +	 */
>> +	u16 cc_code;
>> +
>>   	u8 bdf_enabled;
>>   	u8 bdf_ext[];
>>   } __packed;
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 7af12733a1ff..aee3080a934c 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -11550,6 +11550,17 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>>   			goto err_unregister_hw;
>>   		}
>>   
>> +		if (ar->ab->hw_params->current_cc_support && ab->new_alpha2[0]) {
>> +			struct wmi_set_current_country_arg current_cc = {};
>> +
>> +			memcpy(&current_cc.alpha2, ab->new_alpha2, 2);
>> +			memcpy(&ar->alpha2, ab->new_alpha2, 2);
>> +			ret = ath12k_wmi_send_set_current_country_cmd(ar, &current_cc);
>> +			if (ret)
>> +				ath12k_warn(ar->ab,
>> +					    "failed set cc code for mac register: %d\n", ret);
> FYI I split this line in pending to fix the ath12k-check:
> drivers/net/wireless/ath/ath12k/mac.c:11648: line length of 94 exceeds 90 columns
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=2d2ccff4c0efa4cb55d0a21c75c6e7162788f9db

Oh, thanks


>
>> +		}
>> +
>>   		ath12k_fw_stats_init(ar);
>>   		ath12k_debugfs_register(ar);
>>   	}
>>
>> base-commit: b80c52642c1159c2596776b39b06eb1c2e36baff

