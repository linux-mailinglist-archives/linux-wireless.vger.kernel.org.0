Return-Path: <linux-wireless+bounces-28011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D75BE6580
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 06:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 536714E3209
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 04:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF33090C7;
	Fri, 17 Oct 2025 04:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mc9vaBHh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462064204E
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760676923; cv=none; b=P3ZnJToXKEqFnVdNxjq/pb49Cg3Ho6zO7rfmxl7zs5ecMR07zHon8O9FQlnsf4tRVFcRlu6KQowb+/MzpKfiv4eS2zYcsaHCaBFUTlSejdpSI/7GK5XiXg+B5yjCyW0ISZnRr/sebTIbNrTfHXnjzEPBX2PXGl5YHGJ8r1QudoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760676923; c=relaxed/simple;
	bh=Wg0tXeclFSxmSkWBOCVKQPcXoZGxQulJAroF7KJUFdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TedtBOPNsy+Z41Q3w9ZBHkEXi+zsbZq8O4A8oJf6c7xvTwM/8vSvlZ82XA28OUxmoZHAxWthKkdeHYCPjYFotUzgpZBgs4l/t9F440o/YLpVk+hVQaD6qXWeaEAsZ2pWbBD2pBEpgfQJFAp3p7/bBM2gNp4XJAOWdgWV1ptlhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mc9vaBHh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLUdo020254
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B2GoAmRUXWOqDeKWbHxWz4SlkDTe5271EwJBTML8h5o=; b=mc9vaBHhRrovUvmQ
	776G29NC6Oz+jbX7L287c+pOBLMv/RCCymkr5veLkGPTN93wg5ZRadUBKAj6he4s
	20e3DLjJJfvo8xKpdAVceZUlJJiijc++k1ofo3xG5vtZQHOIJpFBek85PUNfc30P
	YGnXY/Ftvtr1y0p/vm6kueVk/P2ujyzQr3a55HSY9YdEpbHs86W77UgEx4OUaL4e
	3RDJPPZTim177LZfQjj1mOb3s+8vUPNTf8GUNvW56UcYWInmQk9yYzKv6M2e3nYl
	SYehxGnrGN4BA+UE7azA5Q+XNhBb1MQ4PMl6zIFBYJvFIxYjRjE8y8W3zG1DmpoA
	336nWA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpm9e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:55:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62da7602a0so1154952a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 21:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760676911; x=1761281711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2GoAmRUXWOqDeKWbHxWz4SlkDTe5271EwJBTML8h5o=;
        b=cll3pscMF1mjmVP+OlzKON2WgJ+gOlQMg7ceWRFp8D8luue8+vTNx57uw/stz2HIAT
         CjitpmGOqxt/9RmfXltMLlzPWh4IAyywNGXOL9gYQAvG/a/OHBTAgSRmBM+I7AZRX9Ro
         jZtIZkRPuyWICx5zJ1tmEJdb3vuxIv965MET1aLW1xtqRWTxoH8G2jXF1YqEHIszde5S
         jEoZq2tTO7Ht4X8G4nn8jU2Kpa3f2oBuCCMcXoJzcOdjtNRKc3ukG1ApMhBF8lKj4oXs
         azTZi9JRBAO0o6UwanRjIFfquTVdMgdvrlRbUbDI8YOdJPbHKPH6i2+/Hi205CKojtB4
         Y61A==
X-Gm-Message-State: AOJu0Yxtl2HEAZDAbaJ5FD+jVXW+fbsE3vtVDnO+TivjXu+DxrRr/qE3
	Vmz5XJI/OBPeE8Ia1iiPOujFPYdgxUF2dG8pBFbkAGRWCornM+m8pWvZlfwOjBgelrAMgk4D4Gd
	mje8XIL6v81gr0I+fgtcj1E8a6kXk0fkqvkOR3sFKcMQzuloJOBT+ZX49FRwXQTIpGOTEpHzw2G
	LrYQ==
X-Gm-Gg: ASbGnctBu9u4UzYR1QS2nEvlwdC1Htw5RMPm4QfX0q+b74Tbah9nsJ+oYGm86UvdOAk
	5IQy/6utqKNLECOOZxq3qCiJd5Oqlh8PhEXrPsD2eVJat1AnLnY+iszFTAMhdT8YgtiOgTl9fYI
	DCGHQvEpcEboFGmyzePygeoq9rh+TJcHwqzry3tQPMsQA7h6knqP+hG/FFtguu/OwZS227hOccy
	mpar+jAGpI0NaP4KSlsMxgMSFtJh1DcKHCcaXhUFRBwXtakS18WwUelSyAhZTjRUajZo9+iIwOg
	/IH7QDx0UOE13Q1xutbWSrOa0RYesg7KpTbonbdkyYU2EfjfsE/oF0IMdckMX0rGIvQGQrwZgFa
	594cFulZ4JNiKMtGt+/5wVCzaqNkmmBLjqHDw6Jofd7nc
X-Received: by 2002:a17:902:d60d:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-290c9cf0f1amr27985405ad.26.1760676910963;
        Thu, 16 Oct 2025 21:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8wmtkH/zXjtGl9tsOITQqDIS7+ABeAjviNaWDx6IWkS2pAFr4SP762G/+gjBxYnECa2W5nQ==
X-Received: by 2002:a17:902:d60d:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-290c9cf0f1amr27985145ad.26.1760676910482;
        Thu, 16 Oct 2025 21:55:10 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afdc02sm48554895ad.110.2025.10.16.21.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 21:55:10 -0700 (PDT)
Message-ID: <a752e890-b54f-b2e3-817f-7da1cafee86a@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 10:25:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: Add MODULE_FIRMWARE() entries
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20251003082955.11436-1-tiwai@suse.de>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251003082955.11436-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f1cc39 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2wKZT7uEXQSXzUSAk68A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX4x3GmmW/7Fau
 0e+QpCkVH0Q9JRBtbnqTr6vmC7NGyd3fzxv9x2Kdf9t0bOa/Bcn+6KRqEBfBHWPcdyN/mUc4Jp3
 Diip0LNhXO/M/9qxg68oSyM+8qgVR9IBqePOaAE5a+spcIdd7C9flf0xRpixSEHpr+wiIxvDZfK
 mays9MctpSJdnkNfMXltNjQo8bHNnW1lsF1SSkC1XDJgwYrMbZ8oZPavroN9OUe7gkCKRkfR+k0
 wKTIfiKuSfQQ5G13hlzw4j55DoPA2TPG0cUf3NuT0PUEDjW3CcFYf0mMT+2VpiRoToGiUZVyrSr
 dJRsmv8BkiOcoPFy4mGHcZkykBw/wtxQDiur4/Qt8IBxqgyucHOcYgnAAvf5V2EweM+0ko7H+vM
 iaznEyODvrBAm3dLBXhMK4CIMDHAOw==
X-Proofpoint-ORIG-GUID: 7UwBG3is6kMZfE0Iz33uQG8JjKGn2wp_
X-Proofpoint-GUID: 7UwBG3is6kMZfE0Iz33uQG8JjKGn2wp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017



On 10/3/2025 1:59 PM, Takashi Iwai wrote:
> Some systems such as live-image or installer require the firmware
> information for each module declared by MODULE_FIRMWARE(), which is
> currently missing in ath12k driver.
> 
> For addressing it, this patch adds the MODULE_FIRMWARE() entries.
> Like ath11k driver, we can just put the currently used firmware
> entries for QCN9274 and WCN7850 with wildcards.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   drivers/net/wireless/ath/ath12k/pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index c729d5526c75..48161db6af57 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -1871,3 +1871,7 @@ void ath12k_pci_exit(void)
>   {
>   	pci_unregister_driver(&ath12k_pci_driver);
>   }
> +
> +/* firmware files */
> +MODULE_FIRMWARE(ATH12K_FW_DIR "/QCN9274/hw2.0/*");
> +MODULE_FIRMWARE(ATH12K_FW_DIR "/WCN7850/hw2.0/*");

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

