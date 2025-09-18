Return-Path: <linux-wireless+bounces-27468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6930DB83487
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 09:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED79E7BAC1D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C415A2D94BB;
	Thu, 18 Sep 2025 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Et82SnX5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E791C84D7
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179739; cv=none; b=X5j7DrWHVb04YD6+NivUPy2aYi4F5h/OmdjbS5Rvy1Yt5THYIH9Yzl0AqGL1Muj9nEMUthEa4WntIjrm9Zdx5t9zkeYbEwo6RdUZaCP7EXhfjIyqcI8E2uQuxXQRmPB1x3kJZIAIJQehTIDWEJyKW9KUIAqR+nZCbMt0MzEmBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179739; c=relaxed/simple;
	bh=isIWH41acdsk+YD1gYFHMwH4nHfVKhn+w9wmxAdXSeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2SIooKZF5xCfeWH2jxPvpQ81rRngyUh97DPs3Eny5h+MSQJ+lPCmWdVDlrqj0emNJLkM5i077KlenlHXu6c8q8DJbWwwvhVerShGEcOUFXleUuqzvHKKs19dobF44YeReTzUa3WXToVZpa+RqMBORjv50vD9Bql+CwgwOXUrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Et82SnX5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3JVN9021451
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	isQJO2tp1yW9LHpXNsBMnq2xvDiCZjaipuE5JuNCerM=; b=Et82SnX5I+YGHrPM
	oLFGZTaMcau4VqLzTs9m/WadRoWBtNFNhC/ASFu25S8MTVAVhHASU2V0CmJSJBze
	7O0zgoolXAE6cp53SpPMIArSg9MHYJz0pMeBCuLRRuGLrkH2H2hu7+SlB+HF38xq
	KCH5Bd4E/jpqolvYhfiRzT3iTIyVPMfuN50cJsw1SQMbSfx3ptDpN+z5Xl/Q5m6b
	81MmoX0UHXc0dWL4OBxx9QcRjo4gfuXilbWv6uoKkB77ppMaS50KDYiRtfcrkAiu
	pmGzDQe141NtKIdsjJJrlM3t8VWnDf1w5Wl4CIZgs/o8w2qtLHaYsMQoIh2rT0Uf
	VATVYw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5dbep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:15:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24456ebed7bso8938145ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 00:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758179736; x=1758784536;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isQJO2tp1yW9LHpXNsBMnq2xvDiCZjaipuE5JuNCerM=;
        b=ShcXZWitwqRieV/GgjY2IiZ+Pa4u3dYp3g3Z+pAVVFlSFiSoisN2iQr19Apb5BhGzx
         LkF69dYFetfQLaiW0TRzA4+H+VccTV8XuE0x0U2OwUkbVMUvuIJNjV4EN0h21UDyqLGT
         oS5IIfr/hOKbNSod+Htc9GKOEPlfg7/L1c4hNFiiTbwJUAywTN0s7XjykS/4VVAoST0Q
         lEARV2IwkxN8dKAo5/FWHBrs3g4iP+Bi92bY4LYoIXr7mzGr7yrNX/AzR/lTMeTopI9e
         ZAFyyiTfUhQ/1YVgGqGbE3pLO0yaeKAIcdNplAV54JHDC6JJeo7zo+zXzTDTifzau60b
         zJpw==
X-Gm-Message-State: AOJu0YyvITzuYKgFyv2UIilo0/255r+gEuWEWFlE/OnscG1HrUtXNu52
	ag9y9T/OSEwriy/DslEa5QAqYFsWb2c7ZX+tTVF0rFDn1DYDEm0P3c3krDP97PT/nx7kEY6LUT2
	aI6n0R3k2l+9CcdAXoKJ2gk1lI7lWHf32GuL6JqR1gLtHXy9x5/Rn3aLNmGRbnordmKQQ5Q==
X-Gm-Gg: ASbGncsXtjUpy3NVwuB74ou7pKwW0UaAvqHIz5gH4VxKW1h0g6RWX0wjzzJhfSi6WtX
	1TLQ7wuscCuFMXsKrp+0VpCKddGXykkrUx1/Ku+WK9elxS1mSnPAN2CJEl6vtCQuD6jrEmj7uRp
	5BzqWCyjBw0/sw0TM7OxKgwNiIejurDFi06J9C8mGmDTetnF8CwQnX4nFpjjBLSwr5UDO7uzOTs
	iuB++GnCJ5e7Pt0pwbR4V2IoHRp6MRqB9CPppWd3e9iEqBg7rPsSWtc4VvvFaJ0qvux3ZZshVcq
	yNiSNGQ1ocJCGnoYTdnqHL4yXgDZdsnske3LI5YlsSyyuQTr3XHNsnNFFR9o7X96PvSHnFFd1rz
	Ph2V8/rzSG/Ov3OSMWIywGP6/F1Qzr+tqfkXG
X-Received: by 2002:a17:902:aa42:b0:267:912b:2b36 with SMTP id d9443c01a7336-2697cc743d4mr22020365ad.23.1758179735429;
        Thu, 18 Sep 2025 00:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIX3vycMF8GWM3haJsU06M45B6aT+PikV6fmM8SwFtI8cQ871GAtMURLGeZVBllnZe/eVXxQ==
X-Received: by 2002:a17:902:aa42:b0:267:912b:2b36 with SMTP id d9443c01a7336-2697cc743d4mr22020095ad.23.1758179734897;
        Thu, 18 Sep 2025 00:15:34 -0700 (PDT)
Received: from [10.133.33.30] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dff50sm16164135ad.85.2025.09.18.00.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 00:15:34 -0700 (PDT)
Message-ID: <5dd38154-ed56-47af-b509-87caecfa7890@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 15:15:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current v2] wifi: ath10k: Fix connection after GTK
 rekeying
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        alexey.klimov@linaro.org, johannes@sipsolutions.net
References: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: t6CvWT3ZlD8eyvCnvzhD02nj53pjvsmq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+K5jE6BcUZA4
 GAevZ9lBdaxlp319+Q/bUP9+gfk1V4XS2+6V0H+SKbOJQBSgcrB8e1vtipyEw2H6cccDg7GkQhb
 3SDQNDn/1LtRzo6qasDtHZEvI7oB9wd+tBS/1xlDqtbMlS3soIPKx9QKtmEjlMErveFuscPnmrB
 o/vk5Wr5DjUNpvXJTHUo+yGLMLGvnEoqpTXSCiGlVkcbnt/tWQswXBd+cjPsNt5FCMbt2K+0viI
 1EsHRXS60MMPXK7PwgeohNCw1Y0EcxGHyhCVqkiaF8E7asUaiH092BOHpQNyE1Vk/Q2swjZ3D4B
 5Zy/f9tc2SRPV5PT1a2cPd6+ZlabiMWfFD05V1QP3nbWk4yIHoduw7DIahVywwa4tHtMmA4y+u0
 CMd0Otn0
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cbb198 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=3sJy8hLxCyfA9cyCuJUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: t6CvWT3ZlD8eyvCnvzhD02nj53pjvsmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/2/2025 10:32 PM, Loic Poulain wrote:
> It appears that not all hardware/firmware implementations support
> group key deletion correctly, which can lead to connection hangs
> and deauthentication following GTK rekeying (delete and install).
> 
> To avoid this issue, instead of attempting to delete the key using
> the special WMI_CIPHER_NONE value, we now replace the key with an
> invalid (random) value.
> 
> This behavior has been observed with WCN39xx chipsets.
> 
> Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1
> Reported-by: "Alexey Klimov" <alexey.klimov@linaro.org>
> Closes: https://lore.kernel.org/all/DAWJQ2NIKY28.1XOG35E4A682G@linaro.org
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  v2: use random value instead of predictable zero value for key
>      Add Tested-on tag
> 
>  drivers/net/wireless/ath/ath10k/mac.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 24dd794e31ea..154ac7a70982 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -16,6 +16,7 @@
>  #include <linux/acpi.h>
>  #include <linux/of.h>
>  #include <linux/bitfield.h>
> +#include <linux/random.h>
>  
>  #include "hif.h"
>  #include "core.h"
> @@ -290,8 +291,15 @@ static int ath10k_send_key(struct ath10k_vif *arvif,
>  		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
>  
>  	if (cmd == DISABLE_KEY) {
> -		arg.key_cipher = ar->wmi_key_cipher[WMI_CIPHER_NONE];
> -		arg.key_data = NULL;
> +		if (flags & WMI_KEY_GROUP) {
> +			/* Not all hardware handles group-key deletion operation
> +			 * correctly. Replace the key with a junk value to invalidate it.
> +			 */
> +			get_random_bytes(key->key, key->keylen);
> +		} else {
> +			arg.key_cipher = ar->wmi_key_cipher[WMI_CIPHER_NONE];
> +			arg.key_data = NULL;
> +		}
>  	}
>  
>  	return ath10k_wmi_vdev_install_key(arvif->ar, &arg);

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


