Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C5370DCD
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 01:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfGVX5j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 19:57:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46155 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730693AbfGVX5j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 19:57:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id c73so18127115pfb.13
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2019 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XNBNNSCz0NurpUlM34BsDoF+zjgtIj/BeN2sdzZA8WU=;
        b=XNv3iloizpXqSPNJCQVhGa9XDMUwN3wAWb+iBl7R+vSvtIQLPZQVLQocUDLh+tY+3E
         YkHrSqVOkE/su5x439XtjJjduyNHqai01+7Qv6otfLPpk6h6Nug196wsPnv7DQ7Yf5xb
         6GM7fsj7Rn36Wys8HOFtcstyEErrGj1aBM+G/MsQzXH0vsuSJKacojpyn1iJwRAoz/AK
         Xz9iU/xvpHoUhjSx4IazJ+buBzx7QOClwKZs5hQnLTu8544aV7pW4DUDKUien1oCreF7
         91cN/qCCJ5KmXE5Kh5ME18gXukkIb0wQCHewNTOX3nq2n4ruroGAdqFLfl+nlaIZ9K+U
         mXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XNBNNSCz0NurpUlM34BsDoF+zjgtIj/BeN2sdzZA8WU=;
        b=AmCMvlwiY+ZSPnfUz9ZG4ouxzSOik6UmyOTX4Ehg7BpNiYej1Gp7ynnv2e1TV+hbqh
         Xoy4JF/5rabKw7WizvwAlnHdJY5Jid/Zp5SHZRJ2N+t2TpRwhCvS2LSPmKAAoky1OCFZ
         KhWOxQRF5SNs3cV2z7EFJfwBKtzqtT0Svc48iXZvjlLOwZcSgdcog1+hxzrxkZRtRKnq
         K62iTHHJDJP4I5g3hSmMy53LF6RfBxaI+/OQsHE79J+8VXBFCJitkein0Q8AgFyOJBnm
         zODU7lUejwWqb2Us4p9Xxw/RURAUQhztvrpRm/uYWEyTEsB+sImWs/g33wt+TiXVSElt
         gRzw==
X-Gm-Message-State: APjAAAUNwU/IJuktsJFSxXZRVrv4pyYzwg0mdTYWIMle6UAdX7Kxq+F7
        tHmCChzlTx3wSkjEFFdd69UPSQ==
X-Google-Smtp-Source: APXvYqzuRr/BcvaJOUHFxq2MD2sLSSYI3Dj4iu9bal0cEcSIDZkIFUs8ZlxO1COKd/5hmlDae6/vDA==
X-Received: by 2002:a62:2ad3:: with SMTP id q202mr2874862pfq.161.1563839858549;
        Mon, 22 Jul 2019 16:57:38 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t9sm41161209pji.18.2019.07.22.16.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 16:57:37 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:57:35 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] ath10k: Move regulator config to driver private data
Message-ID: <20190722235735.GA5828@builder>
References: <20190703035711.25592-1-govinds@codeaurora.org>
 <20190703035711.25592-3-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703035711.25592-3-govinds@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue 02 Jul 20:57 PDT 2019, Govind Singh wrote:

> WCN3990 Regulator config is varying b/w different MSM platforms.
> In order to have scalable config, move regulator config to driver
> private data.
> 

Regulators supplying clients with fixed voltage requirements should be
specified in the board devicetree with these required voltage values,
rather than in the driver.  So the appropriate solution is not to add
and adjust these values but rather to drop this code from the driver.

I was about to send a patch that does this, because I have an SDM845
device where the voltage constraints specified on board level does not
meet the ranges specified here in the driver.

Regards,
Bjorn

> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 38 +++++++++++++++++++++-----
>  drivers/net/wireless/ath/ath10k/snoc.h | 23 +++++++++-------
>  2 files changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index ca1186ec4129..bd7d97924fe0 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -36,13 +36,20 @@ static char *const ce_name[] = {
>  	"WLAN_CE_11",
>  };
>  
> -static struct ath10k_vreg_info vreg_cfg[] = {
> +static struct ath10k_vreg_info sdm845_reg_cfg[] = {
>  	{NULL, "vdd-0.8-cx-mx", 800000, 850000, 0, 0, false},
>  	{NULL, "vdd-1.8-xo", 1800000, 1850000, 0, 0, false},
>  	{NULL, "vdd-1.3-rfa", 1300000, 1350000, 0, 0, false},
>  	{NULL, "vdd-3.3-ch0", 3300000, 3350000, 0, 0, false},
>  };
>  
> +static struct ath10k_vreg_info qcs40x_reg_cfg[] = {
> +	{NULL, "vdd-0.8-cx-mx", 1224000, 1224000, 0, 0, false},
> +	{NULL, "vdd-1.8-xo", 1800000, 1850000, 0, 0, false},
> +	{NULL, "vdd-1.3-rfa", 1300000, 1350000, 0, 0, false},
> +	{NULL, "vdd-3.3-ch0", 3300000, 3350000, 0, 0, false},
> +};
> +
>  static struct ath10k_clk_info clk_cfg[] = {
>  	{NULL, "cxo_ref_clk_pin", 0, false},
>  };
> @@ -54,10 +61,20 @@ static void ath10k_snoc_htt_rx_cb(struct ath10k_ce_pipe *ce_state);
>  static void ath10k_snoc_htt_htc_rx_cb(struct ath10k_ce_pipe *ce_state);
>  static void ath10k_snoc_pktlog_rx_cb(struct ath10k_ce_pipe *ce_state);
>  
> -static const struct ath10k_snoc_drv_priv drv_priv = {
> +static const struct ath10k_snoc_drv_priv sdm845_wcn39xx_drv_priv = {
> +	.hw_rev = ATH10K_HW_WCN3990,
> +	.dma_mask = DMA_BIT_MASK(35),
> +	.msa_size = 0x100000,
> +	.vreg_cfg = sdm845_reg_cfg,
> +	.vreg_count = ARRAY_SIZE(sdm845_reg_cfg),
> +};
> +
> +static const struct ath10k_snoc_drv_priv qcs40x_wcn39xx_drv_priv = {
>  	.hw_rev = ATH10K_HW_WCN3990,
>  	.dma_mask = DMA_BIT_MASK(35),
>  	.msa_size = 0x100000,
> +	.vreg_cfg = qcs40x_reg_cfg,
> +	.vreg_count =  ARRAY_SIZE(qcs40x_reg_cfg),
>  };
>  
>  #define WCN3990_SRC_WR_IDX_OFFSET 0x3C
> @@ -1465,7 +1482,7 @@ static int ath10k_snoc_vreg_on(struct ath10k *ar)
>  	int ret = 0;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(vreg_cfg); i++) {
> +	for (i = 0; i < ar_snoc->vreg_count; i++) {
>  		vreg_info = &ar_snoc->vreg[i];
>  
>  		if (!vreg_info->reg)
> @@ -1498,7 +1515,7 @@ static int ath10k_snoc_vreg_off(struct ath10k *ar)
>  	int ret = 0;
>  	int i;
>  
> -	for (i = ARRAY_SIZE(vreg_cfg) - 1; i >= 0; i--) {
> +	for (i = ar_snoc->vreg_count - 1; i >= 0; i--) {
>  		vreg_info = &ar_snoc->vreg[i];
>  
>  		if (!vreg_info->reg)
> @@ -1616,7 +1633,13 @@ static int ath10k_hw_power_off(struct ath10k *ar)
>  
>  static const struct of_device_id ath10k_snoc_dt_match[] = {
>  	{ .compatible = "qcom,wcn3990-wifi",
> -	 .data = &drv_priv,
> +	 .data = &sdm845_wcn39xx_drv_priv,
> +	},
> +	{ .compatible = "qcom,sdm845-wcn39xx-wifi",
> +	 .data = &sdm845_wcn39xx_drv_priv,
> +	},
> +	{ .compatible = "qcom,qcs40x-wcn39xx-wifi",
> +	 .data = &qcs40x_wcn39xx_drv_priv,
>  	},
>  	{ }
>  };
> @@ -1680,8 +1703,9 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
>  		goto err_release_resource;
>  	}
>  
> -	ar_snoc->vreg = vreg_cfg;
> -	for (i = 0; i < ARRAY_SIZE(vreg_cfg); i++) {
> +	ar_snoc->vreg = drv_data->vreg_cfg;
> +	ar_snoc->vreg_count = drv_data->vreg_count;
> +	for (i = 0; i < ar_snoc->vreg_count; i++) {
>  		ret = ath10k_get_vreg_info(ar, dev, &ar_snoc->vreg[i]);
>  		if (ret)
>  			goto err_free_irq;
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
> index d62f53501fbb..0bdada11985c 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.h
> +++ b/drivers/net/wireless/ath/ath10k/snoc.h
> @@ -10,10 +10,22 @@
>  #include "ce.h"
>  #include "qmi.h"
>  
> +struct ath10k_vreg_info {
> +	struct regulator *reg;
> +	const char *name;
> +	u32 min_v;
> +	u32 max_v;
> +	u32 load_ua;
> +	unsigned long settle_delay;
> +	bool required;
> +};
> +
>  struct ath10k_snoc_drv_priv {
>  	enum ath10k_hw_rev hw_rev;
>  	u64 dma_mask;
>  	u32 msa_size;
> +	struct ath10k_vreg_info *vreg_cfg;
> +	u8 vreg_count;
>  };
>  
>  struct snoc_state {
> @@ -42,16 +54,6 @@ struct ath10k_snoc_ce_irq {
>  	u32 irq_line;
>  };
>  
> -struct ath10k_vreg_info {
> -	struct regulator *reg;
> -	const char *name;
> -	u32 min_v;
> -	u32 max_v;
> -	u32 load_ua;
> -	unsigned long settle_delay;
> -	bool required;
> -};
> -
>  struct ath10k_clk_info {
>  	struct clk *handle;
>  	const char *name;
> @@ -77,6 +79,7 @@ struct ath10k_snoc {
>  	struct ath10k_ce ce;
>  	struct timer_list rx_post_retry;
>  	struct ath10k_vreg_info *vreg;
> +	u8 vreg_count;
>  	struct ath10k_clk_info *clk;
>  	struct ath10k_qmi *qmi;
>  	unsigned long flags;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
