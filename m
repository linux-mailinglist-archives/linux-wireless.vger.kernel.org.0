Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937D9583B59
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiG1JiK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 05:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiG1JiI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 05:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E461DA4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 02:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBA606108B
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 09:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F300C433D6;
        Thu, 28 Jul 2022 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659001087;
        bh=9SfBFuM3lBLuNHLEklCyJohR/yoexb9KomeGL3Dt/70=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PzJQ/IB5aHLlbQESRxc+IsGYCzT+3qWBEOz7kTl+6tXazmCutpdqISoQyapZ+Lrfm
         xTU34kzGCd1Wmsqr5sYqIlySYmQlBLhW5Ef3FREIQK9b6F1V0Xpdm75LCZkDfI4Yrt
         lRntrPIe1sYwEEK3rh9qNIoe6rpMonidtvFnHXB514qrcC7NAcEhJ8IbG7O6uMemEx
         c+L8A6MyV0lcbrAMzCJrLA6SiEadTMCnSU7AO7k39W3/60xaxYEOmsXeZE/qGZDuSx
         u+LtVdRr1DLRkAIzwYD06myBrtjsww5w3o8HlPLRPUzB1K5EoOdQlqp8MLQD7ycfPf
         NaWe/kT/pbEyg==
From:   Kalle Valo <kvalo@kernel.org>
To:     aspriel@gmail.com
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/7] brcmfmac: add support for Cypress firmware api
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
        <CAJ65rDwp=rR2noaUXMXd5cw9TVzFepmy8MGCyZDv4Keu3Dsz9A@mail.gmail.com>
Date:   Thu, 28 Jul 2022 12:38:04 +0300
In-Reply-To: <CAJ65rDwp=rR2noaUXMXd5cw9TVzFepmy8MGCyZDv4Keu3Dsz9A@mail.gmail.com>
        (aspriel's message of "Mon, 13 Jun 2022 05:19:26 -0400")
Message-ID: <87o7x9o9vn.fsf@kernel.org>
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

> Cypress uses the brcmfmac driver and releases firmware which will
> likely diverge over time. So adding support for handling that.
>
> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

[...]

> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
> @@ -24,6 +24,13 @@ config BRCMFMAC_VENDOR_WCC
>            This option will allow the driver to communicate with devices
>            shipped by Broadcom WCC division.
>
> +config BRCMFMAC_VENDOR_CYW
> +	bool "Cypress Wireless"
> +	depends on BRCMFMAC
> +	help
> +          This option will allow the driver to communicate with devices
> +          shipped by Cypress.
> +

Same comment here as in patch 3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
