Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0480553590F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 08:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbiE0GJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 02:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiE0GJ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 02:09:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8B4EC30F
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 23:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3516560E86
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 06:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7F7C385A9;
        Fri, 27 May 2022 06:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653631765;
        bh=e2bx8g1ZSPXC8wVCgZd27mdDgVxjXuh4ERx10fHKwto=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dEn55Vpme8voFhxOcXrvIz5WpS9pBITqTeBWK7Fd36L6v0xruj1c48cW73FvNh0fM
         0+Vi2GCkQ+EvqARVhDLiGexXkK5yxfcT1LCFvQskH20UN2uQdpIQZw/TTCNaLn5GoQ
         D/GiIA9faPcDx6qRXepCqp/VQKbuW77F5jCdp2XzIey0iyvIFflWmiV/pcbNXKJZYB
         vQtzdNsLBPgFVWBJaHw0YQP+GSeAB0sL4ZDKzV4xaAdpcvGrTLNKSHO8Y88b2CBFDO
         lORwO+NXWCJDmSuC6SaWhhi6clt4unX8P8z1w08BfzYqHg655uZVbnS/iSrEa1jeJG
         RzkUG+kke5jJw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     viktor.barna@celeno.com, linux-wireless@vger.kernel.org,
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
        <d8b7572e888dd544462efdecd435742601e01517.camel@sipsolutions.net>
Date:   Fri, 27 May 2022 09:09:19 +0300
In-Reply-To: <d8b7572e888dd544462efdecd435742601e01517.camel@sipsolutions.net>
        (Johannes Berg's message of "Thu, 26 May 2022 20:18:35 +0200")
Message-ID: <87a6b3wlps.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2022-05-24 at 14:33 +0300, viktor.barna@celeno.com wrote:
>> +
>> +config CL8K_VERSION
>> +	string "Version"
>> +	depends on CL8K
>> +	default "8.1.x"
>> +	help
>> +	  Sets module version, which may be important for FW compatibility
>> +	  analysis and syncing upstream codebase with the internal codebase.
>> 
>
> This, along with the def.h stuff using it, and MODULE_VERSION(), is all
> rather pointless, I think you should remove it.

s/should/need to/ :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
