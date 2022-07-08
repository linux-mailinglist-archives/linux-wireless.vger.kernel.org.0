Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E441956BB09
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbiGHNfO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 09:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiGHNfL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 09:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD401193F9
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657287309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhv04bXQ+Px7bg0YLzGWeNRW8EeF+eIRaXYbNqrxf+0=;
        b=c5xSRi5RbtcYtxCjuq5SV9bIA870n2Jb1/bnGdeTOFi9cmAiBnTNc62hK9l3RI9WiH5sHr
        hzVZtBLm0mvCxzWPj3iziP1ec+bTlfPcFFI8EAR0xvj7bpdn5/7oZpqWoAZTDrbuho8HxT
        fBjN8wDUoBj8qzQDYj4oMh6kuUPC9gM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-HdKfqfK1NeG_pZ0IYuw1kA-1; Fri, 08 Jul 2022 09:34:59 -0400
X-MC-Unique: HdKfqfK1NeG_pZ0IYuw1kA-1
Received: by mail-ed1-f71.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso15973925edx.19
        for <linux-wireless@vger.kernel.org>; Fri, 08 Jul 2022 06:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fhv04bXQ+Px7bg0YLzGWeNRW8EeF+eIRaXYbNqrxf+0=;
        b=JGUkHUK8JZL20o1M6Hgudb0yeVQdpk2DNQJJYDrGnnMa7yrb4NKI/HIVUyZuy4ifur
         Wu6T/5VM+tfENT45HYKuAS3QC+7zKfQftvQ1/mKSPth4kcoDdbRs7hze6rt5VhenMk+J
         dC9WgEMT5RVrfGj6Frn/216NAaLplg6hysa2banRTqRjEPVvy9WImPbFtFmdkTfwcVOb
         Y9iLASPEObgpiULtW+okXAPIYJHVQILXxKFZvhM1ZbGSD/nSqAIfQ9ZXA/n5BXMKppF4
         qPi3m2d0iI1JU8qy9otMU9yccr1Bt5LYG29bKA+fw6BNG5Qapx1MhUUwIS2Qj602tQTi
         p95A==
X-Gm-Message-State: AJIora9+rZryvNMEwaNOlgV79j7rSovO+ThBlupPB2AHa4Qf4WJ7UvYJ
        hM08z9IqGGxZWISurz8MZFBFpi6BUaE1bBuXLyStJBMCYqmBk6sb6fkj3epaG9spH3KaepBINEk
        R3Lqw+HIz0bpBMi3taogJWveoyuk=
X-Received: by 2002:a05:6402:274c:b0:43a:9204:95fb with SMTP id z12-20020a056402274c00b0043a920495fbmr4884753edd.259.1657287298683;
        Fri, 08 Jul 2022 06:34:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1spdjfVQtbAIpmoYkqwGVrWpZpvPppif39SvlskVYajjBzxY/moSIg8tlz0/zwOe9//c1sNNQ==
X-Received: by 2002:a05:6402:274c:b0:43a:9204:95fb with SMTP id z12-20020a056402274c00b0043a920495fbmr4884731edd.259.1657287298525;
        Fri, 08 Jul 2022 06:34:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id bu23-20020a170906a15700b006fec56c57f3sm20512880ejb.178.2022.07.08.06.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 06:34:58 -0700 (PDT)
Message-ID: <56fa5cfb-7f38-4380-67e5-ba362dd8e440@redhat.com>
Date:   Fri, 8 Jul 2022 15:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] brcmfmac: Add brcmf_c_set_cur_etheraddr() helper
Content-Language: en-US
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20220708133223.101558-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220708133223.101558-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 7/8/22 15:32, Hans de Goede wrote:
> Add a little helper to send "cur_etheraddr" commands to the interface
> and to handle the error reporting of it in a single place.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Ugh, I accidentally used Kalle's old address. I'll resend this with
the right address, sorry for the duplicate emails.

Regards,

Hans


> ---
>  .../broadcom/brcm80211/brcmfmac/common.c       | 18 +++++++++++++-----
>  .../broadcom/brcm80211/brcmfmac/common.h       |  1 +
>  .../broadcom/brcm80211/brcmfmac/core.c         |  8 ++------
>  3 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> index fe01da9e620d..dccd8f4ca1d0 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> @@ -190,6 +190,17 @@ static int brcmf_c_process_clm_blob(struct brcmf_if *ifp)
>  	return err;
>  }
>  
> +int brcmf_c_set_cur_etheraddr(struct brcmf_if *ifp, const u8 *addr)
> +{
> +	s32 err;
> +
> +	err = brcmf_fil_iovar_data_set(ifp, "cur_etheraddr", addr, ETH_ALEN);
> +	if (err < 0)
> +		bphy_err(ifp->drvr, "Setting cur_etheraddr failed, %d\n", err);
> +
> +	return err;
> +}
> +
>  int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
>  {
>  	struct brcmf_pub *drvr = ifp->drvr;
> @@ -204,12 +215,9 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
>  
>  	if (is_valid_ether_addr(ifp->mac_addr)) {
>  		/* set mac address */
> -		err = brcmf_fil_iovar_data_set(ifp, "cur_etheraddr", ifp->mac_addr,
> -					       ETH_ALEN);
> -		if (err < 0) {
> -			bphy_err(ifp->drvr, "Setting cur_etheraddr failed, %d\n", err);
> +		err = brcmf_c_set_cur_etheraddr(ifp, ifp->mac_addr);
> +		if (err < 0)
>  			goto done;
> -		}
>  	} else {
>  		/* retrieve mac address */
>  		err = brcmf_fil_iovar_data_get(ifp, "cur_etheraddr", ifp->mac_addr,
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
> index 15accc88d5c0..7329eb751945 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
> @@ -65,6 +65,7 @@ void brcmf_release_module_param(struct brcmf_mp_device *module_param);
>  
>  /* Sets dongle media info (drv_version, mac address). */
>  int brcmf_c_preinit_dcmds(struct brcmf_if *ifp);
> +int brcmf_c_set_cur_etheraddr(struct brcmf_if *ifp, const u8 *addr);
>  
>  #ifdef CONFIG_DMI
>  void brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index 87aef211b35f..bd164a0821f9 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> @@ -233,16 +233,12 @@ static int brcmf_netdev_set_mac_address(struct net_device *ndev, void *addr)
>  {
>  	struct brcmf_if *ifp = netdev_priv(ndev);
>  	struct sockaddr *sa = (struct sockaddr *)addr;
> -	struct brcmf_pub *drvr = ifp->drvr;
>  	int err;
>  
>  	brcmf_dbg(TRACE, "Enter, bsscfgidx=%d\n", ifp->bsscfgidx);
>  
> -	err = brcmf_fil_iovar_data_set(ifp, "cur_etheraddr", sa->sa_data,
> -				       ETH_ALEN);
> -	if (err < 0) {
> -		bphy_err(drvr, "Setting cur_etheraddr failed, %d\n", err);
> -	} else {
> +	err = brcmf_c_set_cur_etheraddr(ifp, sa->sa_data);
> +	if (err >= 0) {
>  		brcmf_dbg(TRACE, "updated to %pM\n", sa->sa_data);
>  		memcpy(ifp->mac_addr, sa->sa_data, ETH_ALEN);
>  		eth_hw_addr_set(ifp->ndev, ifp->mac_addr);

