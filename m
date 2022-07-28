Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D81F583B5B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 11:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiG1Jiw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 05:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiG1Jiv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 05:38:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1837F94
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 02:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 720A16108B
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 09:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170BDC433D6;
        Thu, 28 Jul 2022 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659001129;
        bh=XlYP3rP90lZ7xluWz4x8yDGmdK6YEK24vHxY0R5SE4Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=c69pJAKdRlx5GRHMZRwm2UoZ3xZI1musgiaY3bmWglz8zAhHaZPSNMSbi2HykE3Ky
         8Af0rXNjBlRh+3TBMP2wcDeA3xCOYoY1yFQnrOoTXYRFCW4Pnnczg7y5zK9qJQNlWx
         BOkqUjt0xm5PPDW1Mt5DkA6DNtD7wp7jG9stjE0vouaYLAcrsvrbFWQPxqpv9WVSe/
         ulvlLwQxjF8DLmMSq8UhH+YNZRbPD5Faty6ggMIlW4Vet/7U8U/HhxqWLiCKrmkrVQ
         pEraPEcq4WGFUXcPTKYd73wRH48bXJ9p4YJhxWgedCPVKw6S4g/nq/O4idB2+joWNC
         0wqezRJnaxqbw==
From:   Kalle Valo <kvalo@kernel.org>
To:     aspriel@gmail.com
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5/7] brcmfmac: add support Broadcom BCA firmware api
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
        <CAJ65rDwC3U1KSCR0G4s=11bkRAxp0b2Y8p0AFKP9BpgjQECEag@mail.gmail.com>
Date:   Thu, 28 Jul 2022 12:38:47 +0300
In-Reply-To: <CAJ65rDwC3U1KSCR0G4s=11bkRAxp0b2Y8p0AFKP9BpgjQECEag@mail.gmail.com>
        (aspriel's message of "Mon, 13 Jun 2022 05:19:28 -0400")
Message-ID: <87k07xo9ug.fsf@kernel.org>
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

> Broadcom BCA division develops its own firmware api and as such will
> likely diverge over time. Add support for handling this.
>
> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

[...]

> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
> @@ -31,6 +31,13 @@ config BRCMFMAC_VENDOR_CYW
>            This option will allow the driver to communicate with devices
>            shipped by Cypress.
>
> +config BRCMFMAC_VENDOR_BCA
> +	bool "Broadcom BCA"
> +	depends on BRCMFMAC
> +	help
> +	  This option will allow the driver to communicate with devices
> +	  shipped by Broadcom BCA division.

Same comment here as in patch 3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
