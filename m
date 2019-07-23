Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC771209
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 08:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfGWGnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 02:43:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfGWGnk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 02:43:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6AEF7616F5; Tue, 23 Jul 2019 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563864219;
        bh=ugaAmYv+8m9eE3Zu93MoMkY4BcjM1RxnoOdUntCIJcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LquQDbeyn+sOVM+lDFY0nP6SovCD3vBq8mR2RTFECzhWuUkuXarEmBoIGJrBlGaAr
         G7RibavJcMTavuKA576ajlNnoATcKaiFk0Kiv0QqRpwcTyPzGPL9XS7oMcqe2qQpkL
         9Sx/JtaMVjgd3HnSY7J17XHiunn1/CxTST2gT9pw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6177D60E5A;
        Tue, 23 Jul 2019 06:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563864218;
        bh=ugaAmYv+8m9eE3Zu93MoMkY4BcjM1RxnoOdUntCIJcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QsM8J9OPIfIa7rR4nUv6sLmRmzJvE43djXsFkRp0KESXtQtV7Gm/zEZD6mKqg8JgN
         Kc1kf5IayMLX2YWj/H72cuIGT6drctQJJaUTLvdhjAG+RGZwOkWMTv2xznWwyoNLcp
         St0AphPH7VA6hUP8TRxfvY17HhTsv1mnZwFDkKxE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Jul 2019 12:13:38 +0530
From:   Govind Singh <govinds@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] ath10k: Move regulator config to driver private data
In-Reply-To: <20190722235735.GA5828@builder>
References: <20190703035711.25592-1-govinds@codeaurora.org>
 <20190703035711.25592-3-govinds@codeaurora.org>
 <20190722235735.GA5828@builder>
Message-ID: <9eb90be817330f531e8082af74f4c97e@codeaurora.org>
X-Sender: govinds@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-07-23 05:27, Bjorn Andersson wrote:
> On Tue 02 Jul 20:57 PDT 2019, Govind Singh wrote:
> 
>> WCN3990 Regulator config is varying b/w different MSM platforms.
>> In order to have scalable config, move regulator config to driver
>> private data.
>> 
> 
> Regulators supplying clients with fixed voltage requirements should be
> specified in the board devicetree with these required voltage values,
> rather than in the driver.  So the appropriate solution is not to add
> and adjust these values but rather to drop this code from the driver.
> 
> I was about to send a patch that does this, because I have an SDM845
> device where the voltage constraints specified on board level does not
> meet the ranges specified here in the driver.
> 
Thanks Bjorn for the feedback.
I will resend the qcs404 specific changes(dt) on top of your changes 
once available.

> Regards,
> Bjorn
> 
>> Signed-off-by: Govind Singh <govinds@codeaurora.org>
>> ---
>>  drivers/net/wireless/ath/ath10k/snoc.c | 38 
>> +++++++++++++++++++++-----
>>  drivers/net/wireless/ath/ath10k/snoc.h | 23 +++++++++-------
>>  2 files changed, 44 insertions(+), 17 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c 
>> b/drivers/net/wireless/ath/ath10k/snoc.c
>> index ca1186ec4129..bd7d97924fe0 100644
>> --- a/drivers/net/wireless/ath/ath10k/snoc.c
>> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
>> @@ -36,13 +36,20 @@ static char *const ce_name[] = {
>>  	"WLAN_CE_11",
>>  };
>> 
>> -static struct ath10k_vreg_info vreg_cfg[] = {
>> +static struct ath10k_vreg_info sdm845_reg_cfg[] = {
>>  	{NULL, "vdd-0.8-cx-mx", 800000, 850000, 0, 0, false},
>>  	{NULL, "vdd-1.8-xo", 1800000, 1850000, 0, 0, false},
>>  	{NULL, "vdd-1.3-rfa", 1300000, 1350000, 0, 0, false},
>>  	{NULL, "vdd-3.3-ch0", 3300000, 3350000, 0, 0, false},
>>  };
>> 
>> +static struct ath10k_vreg_info qcs40x_reg_cfg[] = {
>> +	{NULL, "vdd-0.8-cx-mx", 1224000, 1224000, 0, 0, false},
>> +	{NULL, "vdd-1.8-xo", 1800000, 1850000, 0, 0, false},
>> +	{NULL, "vdd-1.3-rfa", 1300000, 1350000, 0, 0, false},
>> +	{NULL, "vdd-3.3-ch0", 3300000, 3350000, 0, 0, false},
>> +};
>> +
>>  static struct ath10k_clk_info clk_cfg[] = {
>>  	{NULL, "cxo_ref_clk_pin", 0, false},
>>  };
>> @@ -54,10 +61,20 @@ static void ath10k_snoc_htt_rx_cb(struct 
>> ath10k_ce_pipe *ce_state);
>>  static void ath10k_snoc_htt_htc_rx_cb(struct ath10k_ce_pipe 
>> *ce_state);
>>  static void ath10k_snoc_pktlog_rx_cb(struct ath10k_ce_pipe 
>> *ce_state);
>> 
>> -static const struct ath10k_snoc_drv_priv drv_priv = {
>> +static const struct ath10k_snoc_drv_priv sdm845_wcn39xx_drv_priv = {
>> +	.hw_rev = ATH10K_HW_WCN3990,
>> +	.dma_mask = DMA_BIT_MASK(35),
>> +	.msa_size = 0x100000,
>> +	.vreg_cfg = sdm845_reg_cfg,
>> +	.vreg_count = ARRAY_SIZE(sdm845_reg_cfg),
>> +};
>> +
>> +static const struct ath10k_snoc_drv_priv qcs40x_wcn39xx_drv_priv = {
>>  	.hw_rev = ATH10K_HW_WCN3990,
>>  	.dma_mask = DMA_BIT_MASK(35),
>>  	.msa_size = 0x100000,
>> +	.vreg_cfg = qcs40x_reg_cfg,
>> +	.vreg_count =  ARRAY_SIZE(qcs40x_reg_cfg),
>>  };
>> 
>>  #define WCN3990_SRC_WR_IDX_OFFSET 0x3C
>> @@ -1465,7 +1482,7 @@ static int ath10k_snoc_vreg_on(struct ath10k 
>> *ar)
>>  	int ret = 0;
>>  	int i;
>> 
>> -	for (i = 0; i < ARRAY_SIZE(vreg_cfg); i++) {
>> +	for (i = 0; i < ar_snoc->vreg_count; i++) {
>>  		vreg_info = &ar_snoc->vreg[i];
>> 
>>  		if (!vreg_info->reg)
>> @@ -1498,7 +1515,7 @@ static int ath10k_snoc_vreg_off(struct ath10k 
>> *ar)
>>  	int ret = 0;
>>  	int i;
>> 
>> -	for (i = ARRAY_SIZE(vreg_cfg) - 1; i >= 0; i--) {
>> +	for (i = ar_snoc->vreg_count - 1; i >= 0; i--) {
>>  		vreg_info = &ar_snoc->vreg[i];
>> 
>>  		if (!vreg_info->reg)
>> @@ -1616,7 +1633,13 @@ static int ath10k_hw_power_off(struct ath10k 
>> *ar)
>> 
>>  static const struct of_device_id ath10k_snoc_dt_match[] = {
>>  	{ .compatible = "qcom,wcn3990-wifi",
>> -	 .data = &drv_priv,
>> +	 .data = &sdm845_wcn39xx_drv_priv,
>> +	},
>> +	{ .compatible = "qcom,sdm845-wcn39xx-wifi",
>> +	 .data = &sdm845_wcn39xx_drv_priv,
>> +	},
>> +	{ .compatible = "qcom,qcs40x-wcn39xx-wifi",
>> +	 .data = &qcs40x_wcn39xx_drv_priv,
>>  	},
>>  	{ }
>>  };
>> @@ -1680,8 +1703,9 @@ static int ath10k_snoc_probe(struct 
>> platform_device *pdev)
>>  		goto err_release_resource;
>>  	}
>> 
>> -	ar_snoc->vreg = vreg_cfg;
>> -	for (i = 0; i < ARRAY_SIZE(vreg_cfg); i++) {
>> +	ar_snoc->vreg = drv_data->vreg_cfg;
>> +	ar_snoc->vreg_count = drv_data->vreg_count;
>> +	for (i = 0; i < ar_snoc->vreg_count; i++) {
>>  		ret = ath10k_get_vreg_info(ar, dev, &ar_snoc->vreg[i]);
>>  		if (ret)
>>  			goto err_free_irq;
>> diff --git a/drivers/net/wireless/ath/ath10k/snoc.h 
>> b/drivers/net/wireless/ath/ath10k/snoc.h
>> index d62f53501fbb..0bdada11985c 100644
>> --- a/drivers/net/wireless/ath/ath10k/snoc.h
>> +++ b/drivers/net/wireless/ath/ath10k/snoc.h
>> @@ -10,10 +10,22 @@
>>  #include "ce.h"
>>  #include "qmi.h"
>> 
>> +struct ath10k_vreg_info {
>> +	struct regulator *reg;
>> +	const char *name;
>> +	u32 min_v;
>> +	u32 max_v;
>> +	u32 load_ua;
>> +	unsigned long settle_delay;
>> +	bool required;
>> +};
>> +
>>  struct ath10k_snoc_drv_priv {
>>  	enum ath10k_hw_rev hw_rev;
>>  	u64 dma_mask;
>>  	u32 msa_size;
>> +	struct ath10k_vreg_info *vreg_cfg;
>> +	u8 vreg_count;
>>  };
>> 
>>  struct snoc_state {
>> @@ -42,16 +54,6 @@ struct ath10k_snoc_ce_irq {
>>  	u32 irq_line;
>>  };
>> 
>> -struct ath10k_vreg_info {
>> -	struct regulator *reg;
>> -	const char *name;
>> -	u32 min_v;
>> -	u32 max_v;
>> -	u32 load_ua;
>> -	unsigned long settle_delay;
>> -	bool required;
>> -};
>> -
>>  struct ath10k_clk_info {
>>  	struct clk *handle;
>>  	const char *name;
>> @@ -77,6 +79,7 @@ struct ath10k_snoc {
>>  	struct ath10k_ce ce;
>>  	struct timer_list rx_post_retry;
>>  	struct ath10k_vreg_info *vreg;
>> +	u8 vreg_count;
>>  	struct ath10k_clk_info *clk;
>>  	struct ath10k_qmi *qmi;
>>  	unsigned long flags;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

BR,
Govind
