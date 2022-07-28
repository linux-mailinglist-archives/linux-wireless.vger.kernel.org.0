Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F4A583B53
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 11:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiG1Jg3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 05:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiG1Jg2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 05:36:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47A337F94
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 02:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EFC1B8040B
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 09:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54225C433C1;
        Thu, 28 Jul 2022 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659000985;
        bh=43iVTtiJ13HoSvU9WA10CynbFYNm3wgRhS5DsauDolM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hIqycj1e9DoPidLivtDxegYdcSNZlU3x/nLpJWp+G2N58gmxoAMnQ39cSZqj4Or6o
         dkJ8sHdI6N0kptQrsQbRi/S/5IG5yfWNdN9jv993nqPw3xSVNkc9rjB9TIY5Js9iK8
         c0cwbI4actjStIe9b5YRVlPHZm9JVAl8Rk1C5yoYhp/1vdDOCV3YxSbPYtX/rfxXV0
         n3vd6jR1YJ9nvE+k3vG7cqw8pmqB6AhB+eWrFqSti5dXHV1iUD3nMNI1CWDDVmnL9L
         00d8oM3Bmc6V8lCf4hASXhlGR2UuZOBydQYkL6TwOpkNOmDltdPVu3c6cWVDNyZuch
         HZc8Kaiiw0wTA==
From:   Kalle Valo <kvalo@kernel.org>
To:     aspriel@gmail.com
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/7] brcmfmac: add support for vendor-specific firmware api
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
        <CAJ65rDxy3ERmDAV1BYH_BCUM3_GnzotWpp7yYO6OtA_CZVgbzw@mail.gmail.com>
Date:   Thu, 28 Jul 2022 12:36:21 +0300
In-Reply-To: <CAJ65rDxy3ERmDAV1BYH_BCUM3_GnzotWpp7yYO6OtA_CZVgbzw@mail.gmail.com>
        (aspriel's message of "Mon, 13 Jun 2022 05:19:26 -0400")
Message-ID: <87sfmlo9yi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

aspriel@gmail.com writes:

> The driver is being used by multiple vendors who develop the firmware
> api independently. So far the firmware api as used by the driver has
> not diverged (yet). This change adds framework for supporting multiple
> firmware apis. The vendor-specific support code has to provide a number
> of callback operations. Right now it is only attach and detach callbacks
> so no real functionality as the api is still common. This code only
> adds WCC variant anyway, which is selected for all devices right now.
>
> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

[...]

> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
> @@ -8,6 +8,22 @@ config BRCMFMAC
>  	  interface support. If you choose to build a module, it'll be called
>  	  brcmfmac.ko.
>
> +config BRCMFMAC_VENDOR_MODULES
> +	bool "Use vendor-specific modules"
> +	depends on BRCMFMAC = m
> +	help
> +	  This option will build separate modules for the vendor-specific
> +	  firmware support. If not selected the vendor-specific support
> +	  will be build in brcmfmac.ko.
> +
> +config BRCMFMAC_VENDOR_WCC
> +	bool "Broadcom WCC"
> +	default y
> +	depends on BRCMFMAC
> +        help
> +          This option will allow the driver to communicate with devices
> +          shipped by Broadcom WCC division.
> +

I'm not really a fan of these Kconfig options, I would rather have them
always enabled. Why do we need these options, what would be the use case
when user disables these?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
