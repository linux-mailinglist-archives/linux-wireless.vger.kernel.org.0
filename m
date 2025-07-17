Return-Path: <linux-wireless+bounces-25594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA435B08934
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 11:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5AE7A8A7D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA8A28935C;
	Thu, 17 Jul 2025 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldomBH3i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788F289356
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744264; cv=none; b=EQUgjsZ1u7CfYM2XQSrFqkrzmnyU/4OCaCZYSjumv24GznWupcTUH5kwpNZt2wRrLEQpDS8ccE96dWxC5yM3G7kqXS4psHViKx9SY+YRiDPbJSUhb7oFZ1Dz0QEpwWIPEuXMBaFCV2MEbabUyeU+JJTWIdoJtM6TYb8+X/DVVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744264; c=relaxed/simple;
	bh=1CF/Gragh00xF9VVPjCjTM19/W5x3L/UM/4YXNNbhkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2oMqiyZxHVM5k8nn9uKSRH/cC7PvfD0GijRLvSql471CF00w8iYwN1UEtvZaSwCRjpv3GX98aEay8HXuRYcNUQYt3QIunlNk7S0JSQZmO7nmgvlxD0A250TAt/4k5A/UB65Uh2dFaYENEl5djS12ICPJChH0Ua3OmqDM0iN6Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldomBH3i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H4ZX5t032376
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 09:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ta2Lby5TifhBuvFmm9n6OoINsAcvWrh5mSznvYReTX4=; b=ldomBH3iXX9a/jA0
	XgSG5DLUi6l59L/4am/nVRDS2s+WyS7+3Zy/kVJdY4/btcr558vKLH9ZizTIMvuM
	eeg/2DBoc0vs20xziRoymKeh5uRElxqeX+9+HVXyNFDe1r/Amt/CGQdhrilFST0D
	W+31eKLthU4efv9D+Rgzjau+vT6rHj57ug2//2TgBFH19QOYcvQx2tPcdFOxTSJd
	Nf22fckurxLgK/7qDEPBAVCY54onncq+wayMSpsTqTS7QhotEbn8bROmMCJ4gYkR
	ZmDW9YMYayVDFNrI+OzQYH+YmqrlUKpmr50WmiDMbA51MCgZbIcCTuEeYZ0MdJZp
	8JCsOA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug3876nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 09:24:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b38fdc93c22so248955a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 02:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744261; x=1753349061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta2Lby5TifhBuvFmm9n6OoINsAcvWrh5mSznvYReTX4=;
        b=svaR3iYWKeE1xXfdrKecubieU2iaCAf9WCCPVmKPxDfg+v7arMpA64NQD38CwueGYY
         zbrE45nIKyxieVJX7kW0KYz2QVa6rn062xXIAZH7qcFNFeL6nzAhjxJQpZr78tZr5jEq
         8N1L/qeJ/HihWglNGFrAaA0OzhGDWn7NLazi3HCFoPZfroUq7YL/bBpGQ2KOEVpleHOb
         QJ+reB+H6tcWTt0ZQfYPv8zeAgN/pqY6GMo8nio3KaikJBjFUELCoKEyg3XWfqHyiCN2
         qVlo8vXCogN5kzRtuz1T7sNo58wde82OUxzi7BFIAdoWzVflGrdy5h20Rulkjgjyl2y6
         FkSQ==
X-Gm-Message-State: AOJu0YwFdUN+xShR1LgII+RcDvhFNrNX4q8gJ5j5LIsmqT+vKfumTCpK
	UWRYb/cjgnv1H4H5lSY6BBHF6NWhBOr/LRuRVqsE/7jduEjrGn9RZhXHmWUWkvKMBurYCoqlXpx
	ulTj//uEblBmIt2/aNY/d5FWuFwyUJEz5WJF4bAqSq7HuGOofovBa3A4uUBvRA+VZd30K2Q==
X-Gm-Gg: ASbGnct3bw2q3f+zLzXlPmyBmCbLVhkJEDnMJGs2u/CVkMSNGbv8DbRJbOfGNITC+SU
	hLghzG7depARDg8OXJoqyfZDMQopn3P8PaKSiJZ4dCAu4cSzFAveuuJLlFvC9xemIxqfMutqzbd
	SG0jHKouLDNUlXxOEpg4lZcPMtZPoDRm79sjUQwRaNj3TSEqBBurjRXEnxdPQlrbTjVd3oVk15P
	/+NZAvltkRLl2yT5H40atV4p7Rbyp2WRVbWv5P+QvzYDX7sfolPu4r093qbLs7qWKlgONErii+z
	p5fxeZyt6Rt6zZ5ZCMbwdm+mQ1UJV0g8t9p2hb2hXSoc1J4+v+r+P/bFv0PtnSPm7PFhvlvnOH/
	y74WqMucEw/drn0MI6graEr4zkhjGzvxr
X-Received: by 2002:a05:6a20:4304:b0:236:5ceb:b9d with SMTP id adf61e73a8af0-23811d5ac1emr8814786637.5.1752744260691;
        Thu, 17 Jul 2025 02:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/9JzHwiHOJVtQDz+Hk2T//V+UKML12UcqWERav6I7D2/TpiYea6gygrZcoMDvan9j0EK5hw==
X-Received: by 2002:a05:6a20:4304:b0:236:5ceb:b9d with SMTP id adf61e73a8af0-23811d5ac1emr8814754637.5.1752744260176;
        Thu, 17 Jul 2025 02:24:20 -0700 (PDT)
Received: from [10.133.33.245] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe579b0esm15220268a12.22.2025.07.17.02.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:24:19 -0700 (PDT)
Message-ID: <38ace6a3-d594-4438-a193-cf730a7b87d6@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 17:24:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
To: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA4MiBTYWx0ZWRfX0byTLUptmIau
 kdIb+lkKobx1vCEZDEy5PFl5zccP9WIYJvfpJRTm6wO7UYDK7T+e5G8JeXGirdmklP+ssMuxohG
 MJkYk8ExO54Rx9Nk9l5xjEnUPtDVenzqmuli4PNQLWcT1o02elo65e6xna2TZV48V6lArmvzFa3
 bMKoku7mWeP9s7yzycjRgGbYtpleDqOOhL5+S4e6rGdIlx/a9qETXwJhKjKO2sAu8YsLfyNGY2N
 ozWaKW4WYzdDhBspQ3DKPK9viCxFrYnmMkC4l6LdK+3NbQtPnB0HVtZAGsLxC0pJIjI5S91C2qG
 FOChzZQnbxGBsBZXpZ6MmrveRxFwxORyjUnR8UuxRoe/zXlccT1BAHmZaSCrkuxD5OMFI95MncL
 uNPqrytFPSiQuKdoID/AYPqIfJg41/Y/7gvOC2DCEuATjeeHu67luO6tBuYUbVpk9zcLZDfM
X-Proofpoint-GUID: MKvZVOIFRhVfUTe_A786RgsGqEj3NM-N
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6878c146 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=fqe-KcBmoLiKQ2-rxgMA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: MKvZVOIFRhVfUTe_A786RgsGqEj3NM-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170082



On 7/16/2025 8:56 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> It is not recommended to enable/disable the ASPM states on the back of the
> PCI core directly using the LNKCTL register. It will break the PCI core's
> knowledge about the device ASPM states. So use the APIs exposed by the PCI
> core to enable/disable ASPM states.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Reported-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath.h        | 14 ++++++++++++++
>  drivers/net/wireless/ath/ath12k/pci.c | 10 ++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
> index 34654f710d8a1e63f65a47d4602e2035262a4d9e..ef685123b66bf4f41428fec67c1967f242a9ef27 100644
> --- a/drivers/net/wireless/ath/ath.h
> +++ b/drivers/net/wireless/ath/ath.h
> @@ -21,6 +21,8 @@
>  #include <linux/skbuff.h>
>  #include <linux/if_ether.h>
>  #include <linux/spinlock.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
>  #include <net/mac80211.h>
>  
>  /*
> @@ -336,4 +338,16 @@ static inline const char *ath_bus_type_to_string(enum ath_bus_type bustype)
>  	return ath_bus_type_strings[bustype];
>  }
>  
> +static inline int ath_pci_aspm_state(u16 lnkctl)
> +{
> +	int state = 0;
> +
> +	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
> +		state |= PCIE_LINK_STATE_L0S;
> +	if (lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
> +		state |= PCIE_LINK_STATE_L1;
> +
> +	return state;
> +}
> +
>  #endif /* ATH_H */
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 489d546390fcdab8f615cc9184006a958d9f140a..a5e11509e3ab8faad6638ff78ce6a8a5e9c3cbbd 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c

I add some logs:

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index de5a4059a7a9..5a52093e0226 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1161,16 +1161,28 @@ void ath12k_pci_stop(struct ath12k_base *ab)
        ath12k_ce_cleanup_pipes(ab);
 }

+static void ath12k_pci_dump_pcie_link_ctrl(struct ath12k_pci *ab_pci, const char *str1,
u16 line)
+{
+       u16 link_ctl = 0;
+
+       pcie_capability_read_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+                                 &link_ctl);
+
+       pr_info("%s %u: link_ctl 0x%x\n", str1, line, link_ctl);
+}
+
 int ath12k_pci_start(struct ath12k_base *ab)
 {
        struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);

        set_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags);

+       ath12k_pci_dump_pcie_link_ctrl(ab_pci, __func__, __LINE__);
        if (test_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
                ath12k_pci_aspm_restore(ab_pci);
        else
                ath12k_info(ab, "leaving PCI ASPM disabled to avoid MHI M2 problems\n");
+       ath12k_pci_dump_pcie_link_ctrl(ab_pci, __func__, __LINE__);

        ath12k_pci_ce_irqs_enable(ab);
        ath12k_ce_rx_post_buf(ab);
@@ -1460,11 +1472,15 @@ int ath12k_pci_power_up(struct ath12k_base *ab)
        clear_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
        ath12k_pci_sw_reset(ab_pci->ab, true);

+       ath12k_pci_dump_pcie_link_ctrl(ab_pci, __func__, __LINE__);
+
        /* Disable ASPM during firmware download due to problems switching
         * to AMSS state.
         */
        ath12k_pci_aspm_disable(ab_pci);

+       ath12k_pci_dump_pcie_link_ctrl(ab_pci, __func__, __LINE__);
+
        ath12k_pci_msi_enable(ab_pci);

        if (ath12k_fw_feature_supported(ab, ATH12K_FW_FEATURE_MULTI_QRTR_ID))


> @@ -16,6 +16,8 @@
>  #include "mhi.h"
>  #include "debug.h"
>  
> +#include "../ath.h"
> +
>  #define ATH12K_PCI_BAR_NUM		0
>  #define ATH12K_PCI_DMA_MASK		36
>  
> @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
>  		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
>  
>  	/* disable L0s and L1 */
> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -				   PCI_EXP_LNKCTL_ASPMC);
> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);

Not always, but sometimes seems the 'disable' does not work:

[  279.920507] ath12k_pci_power_up 1475: link_ctl 0x43 //before disable
[  279.920539] ath12k_pci_power_up 1482: link_ctl 0x43 //after disable


>  
>  	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
>  }
> @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
>  {
>  	if (ab_pci->ab->hw_params->supports_aspm &&
>  	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
> -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> -						   PCI_EXP_LNKCTL_ASPMC,
> -						   ab_pci->link_ctl &
> -						   PCI_EXP_LNKCTL_ASPMC);
> +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));

always, the 'enable' is not working:

[  280.561762] ath12k_pci_start 1180: link_ctl 0x43 //before restore
[  280.561809] ath12k_pci_start 1185: link_ctl 0x42 //after restore


>  }
>  
>  static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
> 

In addition, frequently I can see below AER warnings:

[  280.383143] aer_ratelimit: 30 callbacks suppressed
[  280.383151] pcieport 0000:00:1c.0: AER: Correctable error message received from
0000:00:1c.0
[  280.383177] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Data Link
Layer, (Transmitter ID)
[  280.383184] pcieport 0000:00:1c.0:   device [8086:7ab8] error status/mask=00001000/00002000
[  280.383193] pcieport 0000:00:1c.0:    [12] Timeout



