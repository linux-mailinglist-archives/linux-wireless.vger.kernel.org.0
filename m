Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA3572F5B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 09:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiGMHj6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 03:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiGMHj4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 03:39:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33129E474F
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 00:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D72EDB81D40
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 07:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F6CC34114;
        Wed, 13 Jul 2022 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657697992;
        bh=1LDaMlVzLp+e2V4+SwHZ0NnElrRAMcMfQgCMvL6oM9s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lrP7oq6gmUJTufv0oDM40COGNvnER1CsAwosA9BnnFx8SQavPNFHeuwrRjauTa2n6
         4zOkOucV/kkRH6EW9ClMtMLggF+Lhw/yQ1JZZBveZsyBHTPGKC/UPSAmcIbgF/w5qU
         5jk/G9jgy4Ccx4gcP8DFGSecaO6poZjTcmCYRHpW7MTXt42NlBn1A8IOrwH43s87+z
         2pViqYJniNIs9AXmpL8IbGdcT7DaOWZQiRHeSlJHpu8G65RCfvI8/wRz9h7ORnUQBA
         ZsfiLisV8GyU4HYGi7kWuUYXkP0R2i1JpaeyNFgZ8nErrWqhf9MqsVNfXNd0eH+cGK
         TDNpsWnuhvSQg==
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
Subject: Re: [RFC v2 04/96] cl8k: add Makefile
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
        <20220524113502.1094459-5-viktor.barna@celeno.com>
Date:   Wed, 13 Jul 2022 10:39:46 +0300
In-Reply-To: <20220524113502.1094459-5-viktor.barna@celeno.com> (viktor
        barna's message of "Tue, 24 May 2022 14:33:30 +0300")
Message-ID: <87o7xtmpfh.fsf@kernel.org>
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

> +cl-objs += \
> +	wrs.o \
> +	phy.o \
> +	key.o \
> +	sta.o \
> +	hw.o \
> +	chip.o \
> +	fw.o \
> +	utils.o \
> +	channel.o \
> +	rx.o \
> +	tx.o \
> +	main.o \
> +	mac_addr.o \
> +	ampdu.o \
> +	dfs.o \
> +	enhanced_tim.o \
> +	e2p.o \
> +	calib.o \
> +	stats.o \
> +	power.o \
> +	motion_sense.o \
> +	bf.o \
> +	sounding.o \
> +	debug.o \
> +	temperature.o \
> +	recovery.o \
> +	rates.o \
> +	radio.o \
> +	config.o \
> +	tcv.o \
> +	traffic.o \
> +	vns.o \
> +	maintenance.o \
> +	ela.o \
> +	rfic.o \
> +	vif.o \
> +	dsp.o \
> +	pci.o \
> +	version.o \
> +	regdom.o \
> +	mac80211.o \
> +	platform.o \
> +	scan.o
> +
> +ifneq ($(CONFIG_CL8K),)
> +cl8k-y += $(cl-objs)
> +endif

I don't understand why you need ifneq here. Please check how are other
drivers (like iwlwifi) do it, Makefile can be really simple

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
