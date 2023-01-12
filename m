Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42044667000
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 11:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjALKoO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 05:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjALKnQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 05:43:16 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C751317
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 02:38:34 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id k19so13459153pfg.11
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 02:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NEk0tRbd0iJjf3Z9S3v3OpKZ5mu2a9PefQc+E8hvAVo=;
        b=vQxcMgPe/GENVGqz7X3YqTw09X3rZc25cFzIP28wNSrfz4wEu5SXJ21zGVgFN39XSu
         VLDQboYQ5HahkHMzEbIuwL4rV7v4TPzBhwCFdDHrz330J1VJo2Uqor8Qa7Tkw6HrVjnJ
         EMBKgMm25+c4jCpSJ67pPiqWLrknHJeyFPwO673FAABIWralOp0adC1tOnN9RuVSZYPn
         nMYHnBZ3LMXsuJS/jIR5yaaju8lE9BPb2SryCPXYF/C3o7Nb/yX9SzgNDqfZJAfXgnVz
         TMvye8aOp2UMo+FBIPy1OhTAmWZo+cW0foicZN5dZT9Qtr8Qzuqd4OLfi18JQZAhfka7
         vCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEk0tRbd0iJjf3Z9S3v3OpKZ5mu2a9PefQc+E8hvAVo=;
        b=dq8tL7G0qQR6Icn1GXL4xp7nJulmPK11ykVZILgeBU26hDlzT82yBJdoca/RljkM9r
         eAeXWyTjAunPeJQPVSA6NYW94hs3T5DqkKkW2TqQ/PXs4GIEN8xcax7vgTSyix+Zn3ef
         unehBh2cWKX6ivuXrxq4j53vrjcIWo8eC282EgeRzp3jO8eUqAlJwsDx9F0MtpkgdfMZ
         irlcmFizvfp8t3qreA5bp5WTy9npu3/pVGSY4g887T8DuY6jCuijECZjh/Ue1aI5MFrK
         UrjV6qPdTbpUEvItIbas1GHUI184diSLgShchTGzSHRfNz79B9lEc+z6JFX+chvHonIX
         Z7vA==
X-Gm-Message-State: AFqh2kokorC36zBuwWW+X13+EXny8WujB+DUzwe1KsTSjfErdnRcODps
        xtQIbF3HGTjb3aesJYoAsWaR
X-Google-Smtp-Source: AMrXdXvm4o+3fdzPRs8OqT1T99A+ATYPJpSZWbd0zR5N4z+1w7drpqvowp/hqLUsiAVCasSEc9sNvQ==
X-Received: by 2002:aa7:8152:0:b0:587:d491:995f with SMTP id d18-20020aa78152000000b00587d491995fmr14395203pfn.20.1673519913649;
        Thu, 12 Jan 2023 02:38:33 -0800 (PST)
Received: from thinkpad ([117.217.177.135])
        by smtp.gmail.com with ESMTPSA id o2-20020a62f902000000b0058b128ae034sm4139426pfh.60.2023.01.12.02.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 02:38:32 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:08:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, robert.marko@sartura.hr
Subject: Re: [PATCH RFC] ath11k: Add multiple QCN9074 devices support
Message-ID: <20230112103824.GD4782@thinkpad>
References: <20230111170033.32454-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111170033.32454-1-kvalo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jan 11, 2023 at 07:00:33PM +0200, Kalle Valo wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> On platforms with two or more QCN9074 devices, the QMI service will run with
> identical QRTR ids. qmi_add_lookup() is called with same qmi.service_ins_id.

identical QRTR instance ID.

> Because of this identical id, the QMI .new_server is received on all ath11k QMI
> clients and the QMI state machine fails.
> 
> To solve this generate a unique instance id from PCIe domain number and bus
> number, write to the register ATH11K_PCIE_LOCAL_REG_PCIE_LOCAL_RSV0 before
> power up. It is available for firmware when the QMI service is spawned. As not
> all firmware releases support this feature add a new firmware feature flag
> ATH11K_FW_FEATURE_MULTI_QRTR_ID to detect if it's supported.
> 
> With this change, qrtr-lookup is shown in below example.
> 
> Example:
> root@OpenWrt:/# qrtr-lookup
> Service Version Instance Node Port
> 15 1 0 23 1 Test service
> 69 1 23 23 2 ATH10k WLAN firmware service
> 15 1 0 24 1 Test service
> 69 1 24 24 2 ATH10k WLAN firmware service
> 
> Here 23 and 24 on column 3 (QMI Instance ID) and column 4 (Node ID) are the
> node IDs that is unique per ath11k device.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.6.0.1-00760-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Anilkumar Kolli <quic_akolli@quicinc.com>
> Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
> 
> Kalle's comments:
> 
> Depends on: https://patchwork.kernel.org/project/linux-wireless/list/?series=710862&order=date
> 
> It's also possible to do a simple test by just changing the test
> "test_bit(ATH11K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features)" to true, no
> extra patches should be needed.
> 
> I don't have a test setup for this so compile tested only. But I assume Praneesh has tested this.
> 
> This is alternative approach to Robert's patchset:
> 
> https://patchwork.kernel.org/project/linux-wireless/list/?series=692423&state=*&order=date
> 

For what devices the compatible firmware is available? Any plan to fix the
devices with old firmware?

>  drivers/net/wireless/ath/ath11k/fw.h  |  5 +++++
>  drivers/net/wireless/ath/ath11k/pci.c | 31 +++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/pci.h |  1 +
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/fw.h b/drivers/net/wireless/ath/ath11k/fw.h
> index e33b0f78b571..94f50d675f8d 100644
> --- a/drivers/net/wireless/ath/ath11k/fw.h
> +++ b/drivers/net/wireless/ath/ath11k/fw.h
> @@ -17,6 +17,11 @@ enum ath11k_fw_ie_type {
>  };
>  
>  enum ath11k_fw_features {
> +	/* The firmware supports setting the QRTR id via register
> +	 * ATH11K_PCIE_LOCAL_REG_PCIE_LOCAL_RSV0.
> +	 */
> +	ATH11K_FW_FEATURE_MULTI_QRTR_ID = 0,
> +
>  	/* keep last */
>  	ATH11K_FW_FEATURE_COUNT,
>  };
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index 776362d151cb..c42e1e8da624 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -27,6 +27,8 @@
>  #define QCN9074_DEVICE_ID		0x1104
>  #define WCN6855_DEVICE_ID		0x1103
>  
> +#define ATH11K_PCIE_LOCAL_REG_PCIE_LOCAL_RSV0  0x1E03164
> +
>  static const struct pci_device_id ath11k_pci_id_table[] = {
>  	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
>  	{ PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },
> @@ -367,9 +369,14 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
>  	ath11k_mhi_set_mhictrl_reset(ab);
>  }
>  
> +#define ATH11K_QRTR_INSTANCE_PCI_DOMAIN		GENMASK(3, 0)
> +#define ATH11K_QRTR_INSTANCE_PCI_BUS_NUM	GENMASK(7, 4)
> +
>  static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
>  {
>  	struct ath11k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
> +	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
> +	struct pci_bus *bus = ab_pci->pdev->bus;
>  
>  	cfg->tgt_ce = ab->hw_params.target_ce_config;
>  	cfg->tgt_ce_len = ab->hw_params.target_ce_count;
> @@ -380,6 +387,15 @@ static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
>  
>  	ath11k_ce_get_shadow_config(ab, &cfg->shadow_reg_v2,
>  				    &cfg->shadow_reg_v2_len);
> +
> +	if (test_bit(ATH11K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features)) {
> +		ab_pci->instance_id =
> +			FIELD_PREP(ATH11K_QRTR_INSTANCE_PCI_DOMAIN,
> +				   pci_domain_nr(bus)) |
> +			FIELD_PREP(ATH11K_QRTR_INSTANCE_PCI_BUS_NUM,
> +				   bus->number);
> +		ab->qmi.service_ins_id += ab_pci->instance_id;
> +	}
>  }
>  
>  static void ath11k_pci_msi_config(struct ath11k_pci *ab_pci, bool enable)
> @@ -597,6 +613,18 @@ static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
>  					   ab_pci->link_ctl);
>  }
>  
> +static void ath11k_pci_update_qrtr_node_id(struct ath11k_base *ab)

The function name says update node_id but instance_id is what getting updated.

Thanks,
Mani

> +{
> +	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
> +	u32 reg;
> +
> +	reg = ATH11K_PCIE_LOCAL_REG_PCIE_LOCAL_RSV0 & ATH11K_PCI_WINDOW_RANGE_MASK;
> +	ath11k_pcic_write32(ab, reg, ab_pci->instance_id);
> +
> +	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci reg 0x%x instance_id 0x%x read val 0x%x\n",
> +		   reg, ab_pci->instance_id, ath11k_pcic_read32(ab, reg));
> +}
> +
>  static int ath11k_pci_power_up(struct ath11k_base *ab)
>  {
>  	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
> @@ -613,6 +641,9 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
>  
>  	ath11k_pci_msi_enable(ab_pci);
>  
> +	if (test_bit(ATH11K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features))
> +		ath11k_pci_update_qrtr_node_id(ab);
> +
>  	ret = ath11k_mhi_start(ab_pci);
>  	if (ret) {
>  		ath11k_err(ab, "failed to start mhi: %d\n", ret);
> diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
> index e9a01f344ec6..b9d4018d53c6 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.h
> +++ b/drivers/net/wireless/ath/ath11k/pci.h
> @@ -72,6 +72,7 @@ struct ath11k_pci {
>  	/* enum ath11k_pci_flags */
>  	unsigned long flags;
>  	u16 link_ctl;
> +	u32 instance_id;
>  };
>  
>  static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
> -- 
> 2.30.2
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
