Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298297854CF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 12:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjHWKDh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjHWKDI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 06:03:08 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94ECD5
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 03:03:04 -0700 (PDT)
Received: from [10.10.2.52] (unknown [10.10.2.52])
        by mail.ispras.ru (Postfix) with ESMTPSA id 33B5440205B9;
        Wed, 23 Aug 2023 10:03:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 33B5440205B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1692784981;
        bh=BF1XWQu28f5mi3DFQdG2h2d17gYkyiEXrurTZMhCYsU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iRjAR/HxVTAVOwV5Vd8TtrYtrEpsDdgsOq+5/MTIdwhOOkA5tFA/2GMKLvnHGFX/w
         uhwiLqDt8T9CcKe11UqLl32BZYI2mdYyAcZtakF5xykInuColRfWZoBhYl5n+WmAn2
         dFLjoNfbvW/HJI5+XsXsv/KXLt/QHtfuqKMi55no=
Subject: Re: [lvc-project] [PATCH] [v2] wifi: ath10k: cleanup CE
 initialization
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath10k@lists.infradead.org
References: <20230823095008.50515-1-dmantipov@yandex.ru>
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
Autocrypt: addr=khoroshilov@ispras.ru; prefer-encrypt=mutual; keydata=
 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
 kK2E04Fb+Zk1eJvHYRc=
Message-ID: <fb14be76-c3af-8ede-38aa-8b88f3cea7b7@ispras.ru>
Date:   Wed, 23 Aug 2023 13:03:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20230823095008.50515-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

You could also use

git format-patch -v 2

to get Subject with version in it:
[PATCH v2 1/3]
[PATCH v2 2/3]
[PATCH v2 3/3]



> v2: adjust to match series

Do mean that nothing has been changed in the patch regarding the
previous version?

--
Alexey


On 23.08.2023 12:50, Dmitry Antipov wrote:
> Commit 25d0dbcbd5c7 ("ath10k: split ce initialization and allocation")
> changes 'ath10k_ce_init_src_ring()' and 'ath10k_ce_init_dest_ring()'
> so these functions can't return -ENOMEM but always returns 0. This way
> both of the above may be converted to 'void' and related code may be
> simplified as well.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: change 'ath10k_ce_alloc_rri()' to return -ENOMEM in case
> of 'dma_alloc_coherent()' failure and fix error handling in
> 'ath10k_snoc_hif_power_up()'
> ---
>  drivers/net/wireless/ath/ath10k/ahb.c  |  6 +---
>  drivers/net/wireless/ath/ath10k/ce.c   | 50 +++++++++-----------------
>  drivers/net/wireless/ath/ath10k/ce.h   |  6 ++--
>  drivers/net/wireless/ath/ath10k/pci.c  | 29 ++++-----------
>  drivers/net/wireless/ath/ath10k/pci.h  |  2 +-
>  drivers/net/wireless/ath/ath10k/snoc.c | 30 +++++-----------
>  6 files changed, 36 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
> index 76efea2f1138..c3a2eeb5542d 100644
> --- a/drivers/net/wireless/ath/ath10k/ahb.c
> +++ b/drivers/net/wireless/ath/ath10k/ahb.c
> @@ -655,11 +655,7 @@ static int ath10k_ahb_hif_power_up(struct ath10k *ar,
>  		goto out;
>  	}
>  
> -	ret = ath10k_pci_init_pipes(ar);
> -	if (ret) {
> -		ath10k_err(ar, "failed to initialize CE: %d\n", ret);
> -		goto out;
> -	}
> +	ath10k_pci_init_pipes(ar);
>  
>  	ret = ath10k_pci_init_config(ar);
>  	if (ret) {
> diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
> index c27b8204718a..d7275dcc1f99 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.c
> +++ b/drivers/net/wireless/ath/ath10k/ce.c
> @@ -1352,9 +1352,9 @@ void ath10k_ce_enable_interrupts(struct ath10k *ar)
>  }
>  EXPORT_SYMBOL(ath10k_ce_enable_interrupts);
>  
> -static int ath10k_ce_init_src_ring(struct ath10k *ar,
> -				   unsigned int ce_id,
> -				   const struct ce_attr *attr)
> +static void ath10k_ce_init_src_ring(struct ath10k *ar,
> +				    unsigned int ce_id,
> +				    const struct ce_attr *attr)
>  {
>  	struct ath10k_ce *ce = ath10k_ce_priv(ar);
>  	struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
> @@ -1389,13 +1389,11 @@ static int ath10k_ce_init_src_ring(struct ath10k *ar,
>  	ath10k_dbg(ar, ATH10K_DBG_BOOT,
>  		   "boot init ce src ring id %d entries %d base_addr %pK\n",
>  		   ce_id, nentries, src_ring->base_addr_owner_space);
> -
> -	return 0;
>  }
>  
> -static int ath10k_ce_init_dest_ring(struct ath10k *ar,
> -				    unsigned int ce_id,
> -				    const struct ce_attr *attr)
> +static void ath10k_ce_init_dest_ring(struct ath10k *ar,
> +				     unsigned int ce_id,
> +				     const struct ce_attr *attr)
>  {
>  	struct ath10k_ce *ce = ath10k_ce_priv(ar);
>  	struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
> @@ -1427,8 +1425,6 @@ static int ath10k_ce_init_dest_ring(struct ath10k *ar,
>  	ath10k_dbg(ar, ATH10K_DBG_BOOT,
>  		   "boot ce dest ring id %d entries %d base_addr %pK\n",
>  		   ce_id, nentries, dest_ring->base_addr_owner_space);
> -
> -	return 0;
>  }
>  
>  static int ath10k_ce_alloc_shadow_base(struct ath10k *ar,
> @@ -1659,30 +1655,14 @@ ath10k_ce_alloc_dest_ring_64(struct ath10k *ar, unsigned int ce_id,
>   * initialization. It may be that only one side or the other is
>   * initialized by software/firmware.
>   */
> -int ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
> -			const struct ce_attr *attr)
> +void ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
> +			 const struct ce_attr *attr)
>  {
> -	int ret;
> -
> -	if (attr->src_nentries) {
> -		ret = ath10k_ce_init_src_ring(ar, ce_id, attr);
> -		if (ret) {
> -			ath10k_err(ar, "Failed to initialize CE src ring for ID: %d (%d)\n",
> -				   ce_id, ret);
> -			return ret;
> -		}
> -	}
> -
> -	if (attr->dest_nentries) {
> -		ret = ath10k_ce_init_dest_ring(ar, ce_id, attr);
> -		if (ret) {
> -			ath10k_err(ar, "Failed to initialize CE dest ring for ID: %d (%d)\n",
> -				   ce_id, ret);
> -			return ret;
> -		}
> -	}
> +	if (attr->src_nentries)
> +		ath10k_ce_init_src_ring(ar, ce_id, attr);
>  
> -	return 0;
> +	if (attr->dest_nentries)
> +		ath10k_ce_init_dest_ring(ar, ce_id, attr);
>  }
>  EXPORT_SYMBOL(ath10k_ce_init_pipe);
>  
> @@ -1926,7 +1906,7 @@ int ath10k_ce_alloc_pipe(struct ath10k *ar, int ce_id,
>  }
>  EXPORT_SYMBOL(ath10k_ce_alloc_pipe);
>  
> -void ath10k_ce_alloc_rri(struct ath10k *ar)
> +int ath10k_ce_alloc_rri(struct ath10k *ar)
>  {
>  	int i;
>  	u32 value;
> @@ -1939,7 +1919,7 @@ void ath10k_ce_alloc_rri(struct ath10k *ar)
>  					   &ce->paddr_rri, GFP_KERNEL);
>  
>  	if (!ce->vaddr_rri)
> -		return;
> +		return -ENOMEM;
>  
>  	ath10k_ce_write32(ar, ar->hw_ce_regs->ce_rri_low,
>  			  lower_32_bits(ce->paddr_rri));
> @@ -1954,6 +1934,8 @@ void ath10k_ce_alloc_rri(struct ath10k *ar)
>  		value |= ar->hw_ce_regs->upd->mask;
>  		ath10k_ce_write32(ar, ce_base_addr + ctrl1_regs, value);
>  	}
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(ath10k_ce_alloc_rri);
>  
> diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
> index 666ce384a1d8..c90c00316356 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.h
> +++ b/drivers/net/wireless/ath/ath10k/ce.h
> @@ -220,8 +220,8 @@ int ath10k_ce_completed_send_next_nolock(struct ath10k_ce_pipe *ce_state,
>  
>  /*==================CE Engine Initialization=======================*/
>  
> -int ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
> -			const struct ce_attr *attr);
> +void ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
> +			 const struct ce_attr *attr);
>  void ath10k_ce_deinit_pipe(struct ath10k *ar, unsigned int ce_id);
>  int ath10k_ce_alloc_pipe(struct ath10k *ar, int ce_id,
>  			 const struct ce_attr *attr);
> @@ -262,7 +262,7 @@ void ath10k_ce_enable_interrupts(struct ath10k *ar);
>  void ath10k_ce_dump_registers(struct ath10k *ar,
>  			      struct ath10k_fw_crash_data *crash_data);
>  
> -void ath10k_ce_alloc_rri(struct ath10k *ar);
> +int ath10k_ce_alloc_rri(struct ath10k *ar);
>  void ath10k_ce_free_rri(struct ath10k *ar);
>  
>  /* ce_attr.flags values */
> diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
> index a7f44f6335fb..f6988075cd83 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -2524,21 +2524,13 @@ void ath10k_pci_free_pipes(struct ath10k *ar)
>  		ath10k_ce_free_pipe(ar, i);
>  }
>  
> -int ath10k_pci_init_pipes(struct ath10k *ar)
> +void ath10k_pci_init_pipes(struct ath10k *ar)
>  {
>  	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
> -	int i, ret;
> -
> -	for (i = 0; i < CE_COUNT; i++) {
> -		ret = ath10k_ce_init_pipe(ar, i, &ar_pci->attr[i]);
> -		if (ret) {
> -			ath10k_err(ar, "failed to initialize copy engine pipe %d: %d\n",
> -				   i, ret);
> -			return ret;
> -		}
> -	}
> +	int i;
>  
> -	return 0;
> +	for (i = 0; i < CE_COUNT; i++)
> +		ath10k_ce_init_pipe(ar, i, &ar_pci->attr[i]);
>  }
>  
>  static bool ath10k_pci_has_fw_crashed(struct ath10k *ar)
> @@ -2703,12 +2695,7 @@ static int ath10k_pci_qca988x_chip_reset(struct ath10k *ar)
>  		 * sufficient to verify if device is capable of booting
>  		 * firmware blob.
>  		 */
> -		ret = ath10k_pci_init_pipes(ar);
> -		if (ret) {
> -			ath10k_warn(ar, "failed to init copy engine: %d\n",
> -				    ret);
> -			continue;
> -		}
> +		ath10k_pci_init_pipes(ar);
>  
>  		ret = ath10k_pci_diag_read32(ar, QCA988X_HOST_INTEREST_ADDRESS,
>  					     &val);
> @@ -2846,11 +2833,7 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
>  		goto err_sleep;
>  	}
>  
> -	ret = ath10k_pci_init_pipes(ar);
> -	if (ret) {
> -		ath10k_err(ar, "failed to initialize CE: %d\n", ret);
> -		goto err_sleep;
> -	}
> +	ath10k_pci_init_pipes(ar);
>  
>  	ret = ath10k_pci_init_config(ar);
>  	if (ret) {
> diff --git a/drivers/net/wireless/ath/ath10k/pci.h b/drivers/net/wireless/ath/ath10k/pci.h
> index 480cd97ab739..3b3ded87aef9 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.h
> +++ b/drivers/net/wireless/ath/ath10k/pci.h
> @@ -238,7 +238,7 @@ void ath10k_pci_free_pipes(struct ath10k *ar);
>  void ath10k_pci_rx_replenish_retry(struct timer_list *t);
>  void ath10k_pci_ce_deinit(struct ath10k *ar);
>  void ath10k_pci_init_napi(struct ath10k *ar);
> -int ath10k_pci_init_pipes(struct ath10k *ar);
> +void ath10k_pci_init_pipes(struct ath10k *ar);
>  int ath10k_pci_init_config(struct ath10k *ar);
>  void ath10k_pci_rx_post(struct ath10k *ar);
>  void ath10k_pci_flush(struct ath10k *ar);
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 26214c00cd0d..f41948d9eebb 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -939,20 +939,12 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
>  	return 0;
>  }
>  
> -static int ath10k_snoc_init_pipes(struct ath10k *ar)
> +static void ath10k_snoc_init_pipes(struct ath10k *ar)
>  {
> -	int i, ret;
> -
> -	for (i = 0; i < CE_COUNT; i++) {
> -		ret = ath10k_ce_init_pipe(ar, i, &host_ce_config_wlan[i]);
> -		if (ret) {
> -			ath10k_err(ar, "failed to initialize copy engine pipe %d: %d\n",
> -				   i, ret);
> -			return ret;
> -		}
> -	}
> +	int i;
>  
> -	return 0;
> +	for (i = 0; i < CE_COUNT; i++)
> +		ath10k_ce_init_pipe(ar, i, &host_ce_config_wlan[i]);
>  }
>  
>  static int ath10k_snoc_wlan_enable(struct ath10k *ar,
> @@ -1082,18 +1074,14 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
>  		goto err_hw_power_off;
>  	}
>  
> -	ath10k_ce_alloc_rri(ar);
> -
> -	ret = ath10k_snoc_init_pipes(ar);
> -	if (ret) {
> -		ath10k_err(ar, "failed to initialize CE: %d\n", ret);
> -		goto err_free_rri;
> -	}
> +	ret = ath10k_ce_alloc_rri(ar);
> +	if (ret)
> +		goto err_snoc_wlan_disable;
>  
> +	ath10k_snoc_init_pipes(ar);
>  	return 0;
>  
> -err_free_rri:
> -	ath10k_ce_free_rri(ar);
> +err_snoc_wlan_disable:
>  	ath10k_snoc_wlan_disable(ar);
>  
>  err_hw_power_off:
> 

