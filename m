Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB622F23
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 10:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfETIoo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 04:44:44 -0400
Received: from canardo.mork.no ([148.122.252.1]:44795 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfETIoo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 04:44:44 -0400
Received: from miraculix.mork.no ([IPv6:2a02:2121:340:66a5:f0c1:6ff:fe1f:cac9])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x4K8gHrN032429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 May 2019 10:42:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1558341739; bh=o0E1/HFfUTNvSCD20OJ6Y5M/hnSJMjBXfroAVF8mgn0=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=ExqPKmyl+jBx37GydIJo6Z3NjQsixL2pBD/5ep7O6CtJ05zmQ6/TiOxisnr2JkICJ
         QHSAXiQDJB1hDoMi4i2W4Ce8JCKKKljFMAGpoNdnMRXfjkeb9PM4CMJIY8j7z8v5vw
         2jIhBUNAt5j2jtnqe1+ek7reYCA5VnDvdE2lNIdc=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1hSds2-0006bk-Ob; Mon, 20 May 2019 10:42:10 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: Re: [PATCH 3/3] iwlwifi: add support for quz firmwares
Organization: m
References: <20190322124744.17924-1-luca@coelho.fi>
        <20190322124744.17924-4-luca@coelho.fi>
Date:   Mon, 20 May 2019 10:42:10 +0200
In-Reply-To: <20190322124744.17924-4-luca@coelho.fi> (Luca Coelho's message of
        "Fri, 22 Mar 2019 14:47:44 +0200")
Message-ID: <87k1el8ql9.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.3 at canardo
X-Virus-Status: Clean
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> --- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
> @@ -549,6 +549,7 @@ extern const struct iwl_cfg iwl22000_2ac_cfg_hr;
>  extern const struct iwl_cfg iwl22000_2ac_cfg_hr_cdb;
>  extern const struct iwl_cfg iwl22000_2ac_cfg_jf;
>  extern const struct iwl_cfg iwl_ax101_cfg_qu_hr;
> +extern const struct iwl_cfg iwl_ax101_cfg_quz_hr;
>  extern const struct iwl_cfg iwl22000_2ax_cfg_hr;
>  extern const struct iwl_cfg iwl_ax200_cfg_cc;
>  extern const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0;
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/w=
ireless/intel/iwlwifi/iwl-csr.h
> index aea6d03e545a..e539bc94eff7 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
> @@ -327,6 +327,7 @@ enum {
>  #define CSR_HW_REV_TYPE_NONE		(0x00001F0)
>  #define CSR_HW_REV_TYPE_QNJ		(0x0000360)
>  #define CSR_HW_REV_TYPE_QNJ_B0		(0x0000364)
> +#define CSR_HW_REV_TYPE_QUZ		(0x0000354)
>  #define CSR_HW_REV_TYPE_HR_CDB		(0x0000340)
>  #define CSR_HW_REV_TYPE_SO		(0x0000370)
>  #define CSR_HW_REV_TYPE_TY		(0x0000420)
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/ne=
t/wireless/intel/iwlwifi/pcie/trans.c
> index 1d6f3053f233..79c1dc05f948 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> @@ -3543,6 +3543,10 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_=
dev *pdev,
>  		}
>  	} else if (cfg =3D=3D &iwl_ax101_cfg_qu_hr) {
>  		if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) =3D=3D
> +		    CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
> +		    trans->hw_rev =3D=3D CSR_HW_REV_TYPE_QNJ_B0) {
> +			trans->cfg =3D &iwl22000_2ax_cfg_qnj_hr_b0;
> +		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) =3D=3D
>  		    CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR)) {
>  			trans->cfg =3D &iwl_ax101_cfg_qu_hr;
>  		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) =3D=3D

Did you intend to use CSR_HW_REV_TYPE_QUZ and iwl_cfg
iwl_ax101_cfg_quz_hr here, or am I misunderstanding something?

Must admit that I didn't actually read the code.  Just happend to look
at this patch briefly while glancing through linux-wireless...  Sorry if
I'just adding noise.


Bj=C3=B8rn
