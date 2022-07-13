Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77F572F44
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 09:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiGMHdA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 03:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiGMHc7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 03:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3726E4774
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 00:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D23261768
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 07:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24001C34114;
        Wed, 13 Jul 2022 07:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657697577;
        bh=UcbUpXspfUdR2zvM5gzzHMfRiMHU4bnakBZL+5BG5H8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZpLFWGEmrbYJTl6EuBALQ0auDpwPBVBTcxR1KvhJfwcoUHXQZoKe66edvY11VtPjE
         tZ/Yf3kwl1WHjXSErTLegHuZlJJl7cqqDfLFypEjSfj6+LblJQn8H3ZFJJA1r0+C53
         N7AkNFaM4X3uzgBArJUQA/CDU2/HTQ/13VPA9ter5SIzmyJ7xDK6oPsIbYvVNk2hNy
         UAGnOgNsR34j4h/IJW/OqSlfpXuQ14tDTCzySKxnnfMU28ot7X21xrAuq/3IVyR1qP
         Ed5pfi/jMMbaMnCFgs9I5ci1RmnmtNP7oaTZfdvC2uDrMK8JKIL4sGY6ECZc9TjOBZ
         EEmK/DYBLfAYw==
From:   Kalle Valo <kvalo@kernel.org>
To:     viktor.barna@celeno.com
Cc:     linux-wireless@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
Subject: Re: [RFC v2 03/96] cl8k: add Kconfig
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
        <20220524113502.1094459-4-viktor.barna@celeno.com>
Date:   Wed, 13 Jul 2022 10:32:53 +0300
In-Reply-To: <20220524113502.1094459-4-viktor.barna@celeno.com> (viktor
        barna's message of "Tue, 24 May 2022 14:33:29 +0300")
Message-ID: <87v8s1mpqy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

viktor.barna@celeno.com writes:

> From: Viktor Barna <viktor.barna@celeno.com>
>
> (Part of the split. Please, take a look at the cover letter for more
> details).
>
> Signed-off-by: Viktor Barna <viktor.barna@celeno.com>

I haven't looked at rest of the driver yet, will do that in a later
revision. Just looking at build scripts in this round.

> --- /dev/null
> +++ b/drivers/net/wireless/celeno/cl8k/Kconfig
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +config CL8K
> +	tristate "Celeno CL8K WLAN support"
> +	depends on m
> +	depends on MAC80211
> +	help
> +	  This option enables support for Celeno CL8K WLAN.
> +	  Select M (recommended), if you have a wireless module.

Why depending on m? Drivers should be able to link to the kernel.

> +config CL8K_VERSION
> +	string "Version"
> +	depends on CL8K
> +	default "8.1.x"
> +	help
> +	  Sets module version, which may be important for FW compatibility
> +	  analysis and syncing upstream codebase with the internal codebase.

Johannes already commented on this.

> +config CL8K_EEPROM_STM24256
> +	bool "EEPROM STM24256 support"
> +	depends on CL8K
> +	default n
> +	help
> +	  Enables EEPROM STM24256 (specific for some of the platforms).

Kconfig should not be used for device configuration, ie. the same kernel
binary should work on all devices. Is there a better way to detect this
runtime? If not, I suggest to drop this in initial submission and submit
after the driver is accepted.

> +config CL8K_DYN_BCAST_RATE
> +	bool "Enable dynamic broadcast rate selection"
> +	depends on CL8K
> +	default n
> +	help
> +	  Enables dynamic broadcast rate selection,
> +	  that allows to tune rate of broadcast frames taking into account
> +	  capabilities of all associated stations.

I don't think features like this should be in Kconfig. Why not always enable this?

> +config CL8K_DYN_MCAST_RATE
> +	bool "Enable dynamic multicast rate selection"
> +	depends on CL8K
> +	default n
> +	help
> +	  Enables dynamic multicast rate selection,
> +	  that allows to tune rate of multicast frames taking into account
> +	  capabilities of all associated stations.

Same with this one.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
