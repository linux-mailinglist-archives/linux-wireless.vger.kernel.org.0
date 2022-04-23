Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5350C8D7
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 11:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiDWJ4C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 05:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiDWJ4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 05:56:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23051139980
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 02:53:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1BA860EE8
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 09:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF66C385A0;
        Sat, 23 Apr 2022 09:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650707584;
        bh=g0CSQfVj8f+HdsINpgSUoMHy+AtbLXBzQvR6XRvrKf8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AcAkHdJOStXXqbFnszYctJOGObKt8a8vpq+E5/Dqbg0wTjMLgD/XQ0OMolQQKxfq+
         N9Ak887YBbn4hyA8ZOZDcljfpvtaUyfeJerZMaqWds3vrjxDaObGQBgso1zr9aNSW6
         sHtcFoUT1+BCNg2iJ2MmCdKSxuWaqXlcVOhQBU+MBS7gOuVuF5vOs9AFvBsMTiyInM
         Gelg0HM8hRa3h5UH4RiTsJeRFv4jmZjQIeybAP/+rovBpPNPDTPQDdAdjSZgh8ERbd
         xoIZYF5u4pCX92QCW66v40U44P94/19DSyY9NxfUWHbAK4DHDAFP5SRZZTuadbBQ37
         ylXVxWz9kAM5g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: add read country code from SMBIOS for WCN6855/QCA6390
References: <20220421023501.32167-1-quic_wgong@quicinc.com>
Date:   Sat, 23 Apr 2022 12:53:01 +0300
In-Reply-To: <20220421023501.32167-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Wed, 20 Apr 2022 22:35:01 -0400")
Message-ID: <8735i4m8hu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> This read the country code from SMBIOS and send the country code
> to firmware, firmware will indicate the regulatory domain info of the
> country code and then ath11k will use the info.
>
> dmesg:
> [ 1242.637173] ath11k_pci 0000:02:00.0: chip_id 0x2 chip_family 0xb board_id 0xff soc_id 0x400c0200
> [ 1242.637176] ath11k_pci 0000:02:00.0: fw_version 0x110b09e5 fw_build_timestamp 2021-06-22 09:32 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HSP.1.1-02533-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> [ 1242.637253] ath11k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
> [ 1242.637259] ath11k_pci 0000:02:00.0: bdf variant name not found.
> [ 1242.637261] ath11k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
> [ 1242.637263] ath11k_pci 0000:02:00.0: DT bdf variant name not set.
> [ 1242.927543] ath11k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -169,12 +169,31 @@ struct ath11k_ext_irq_grp {
>  	struct net_device napi_ndev;
>  };
>  
> +enum ath11k_smbios_cc_type {
> +	/* disable country code setting from SMBIOS */
> +	ATH11K_SMBIOS_CC_DISABLE = 0,
> +	/* set country code by ANSI country name, based on ISO3166-1 alpha2 */
> +	ATH11K_SMBIOS_CC_ISO = 1,
> +	/* worldwide regdomain */
> +	ATH11K_SMBIOS_CC_WW = 2,
> +};

In the pending branch I did some whitespace cleanup in this and the
following struct.

> +
>  struct ath11k_smbios_bdf {
>  	struct dmi_header hdr;
> -	u32 padding;
> +	u8 features_disabled;
> +	/* enum ath11k_smbios_cc_type */
> +	u8 country_code_flag;
> +	/* To set specific country, you need to set country code
> +	 * flag=ATH11K_SMBIOS_CC_ISO first, then if country is United States, then country
> +	 * code value = 0x5553 ("US",'U' = 0x55, 'S'= 0x53), To set country
> +	 * to INDONESIA, then country code value = 0x4944 ("IN", 'I'=0x49, 'D'=0x44).
> +	 * If country code flag = ATH11K_SMBIOS_CC_WW, then you can use
> +	 * worldwide regulatory setting.
> +	 */
> +	__le16 cc_code;
>  	u8 bdf_enabled;
>  	u8 bdf_ext[];
> -};
> +} __packed;

Is cc_code really in little endian? I would expect data in smbios to be
in native endian (ie. u16), bios using different endian than the host
sounds strange to me. And struct dmi_header also uses native endian:

struct dmi_header {
	u8 type;
	u8 length;
	u16 handle;
} __packed;

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
