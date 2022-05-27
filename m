Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC475368D9
	for <lists+linux-wireless@lfdr.de>; Sat, 28 May 2022 00:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354809AbiE0WhF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 18:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354820AbiE0Wg6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 18:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E146F63514
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 15:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D15C61686
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 22:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6397C34113;
        Fri, 27 May 2022 22:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653691014;
        bh=pYjj6IE4W6bd8gVv8bNzBA9NVC0pkJM5mU5/MMdXBJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ez/+VQzxGtxCO5MWFw6k7YiRMiuflx7SNsN9FV2E+92E6sr1beZ8L775l01wCIXt2
         Pm6a4HZQtuMX8etwSCGEUKlatAUSgYFG/y1y+KQ0p8FetAZaxtHLXUU7DM70Q7yVO+
         bUFp8CM612gSN+7j7rO6uGh2C3FUhU7yjqc+w3PRWnlAhfUVs2N0IH1f70Lvi1Z+4X
         LsYapOkEDcgVZk4ZWoWP4i4eYV6TLysjBXbJmCCDFT8scMxhzjvs7vh+HNDAKQfglF
         BZu0BMclNcnY3+SRxOLAgjXx5LDMEnuNgezjzfBlxmXi+oirENQY7/ULO40MLNqsJV
         CIhdWSCqEkwHw==
Date:   Fri, 27 May 2022 15:36:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: libertas: use variable-size data in assoc
 req/resp cmd
Message-ID: <20220527153653.56da9155@kernel.org>
In-Reply-To: <87wne7urst.fsf@kernel.org>
References: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
        <20220525135326.1da8fe36@kernel.org>
        <ba0a2cec6291e700c5854e343cc72cffa249bc3f.camel@sipsolutions.net>
        <87wne7urst.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 27 May 2022 14:40:50 +0300 Kalle Valo wrote:
> >> Is there a chance to get this into net before the merge window is over?
> >>   
> > I guess you can just apply it. Kalle?  
> 
> Yeah, Jakub can take this directly to net tree:
> 
> Acked-by: Kalle Valo <kvalo@kernel.org>
> 
> But I can also take this to wireless tree and send a pull request on
> Wednesday. Whichever is better for you, just let me know.

PR on Wednesday sounds good, thanks! The patch didn't end up in our PW
instance, I'd have to apply it manually.
