Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43774E499C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 00:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiCVXWP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 19:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiCVXWO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 19:22:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1944199A
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 16:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ADE9ACE1EE0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 23:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE7BC340EC;
        Tue, 22 Mar 2022 23:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647991241;
        bh=stgZX6h605XxAKfywxr4EJjuodyoqFxsAASzapTxM94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mzq6pznfPP9DaoIeQAAq53dvARmVtRMJanBrY3mjPu8Em+ceW0bfFBvWDmY48oBt0
         fsdyG8cNkHUL6xKILyxX4kEH5h3XKZ5BtVS7IsfU4z4/9Xe+ys/3NWcVyXYjXKFSDl
         xxLzsZYFq71Qvu/dQrqpP28TLGyQxQQp5TeKmj6jjWmK4xbEJQfyMDRmCTOP/bKVfq
         YZcMz/Xgi98EX0Od+vnOPxurycVekNgVXMlXmfNfzvBtYlSHxg5XCOGaE6U6OY4IUK
         BhHgg/GUh0y7d4FCtvxderQYW5rAzqu5ER3HAKEP3SpKzmoGNOV8H6BtxyiDMB5N+i
         KK26hVxgjI9lw==
Date:   Tue, 22 Mar 2022 16:20:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net,
        socketcan@hartkopp.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: mvm: Don't fail if PPAG isn't supported
Message-ID: <20220322162040.4569094e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <87a6dhwzin.fsf@tynnyri.adurom.net>
References: <iwlwifi.20220322173828.fa47f369b717.I6a9c65149c2c3c11337f3a802dff22f514a3a436@changeid>
        <3166a024cd5bef43bf192418e95d3c75409a861f.camel@coelho.fi>
        <87a6dhwzin.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 22 Mar 2022 21:36:16 +0200 Kalle Valo wrote:
> > Jakub, this is the fix for the PPAG regression that we talked about
> > earlier.  If it's fine with Kalle, you can apply it directly to net-
> > next to expedite it.  
> 
> You didn't CC netdev though so it's not visible on their patchwork.

I think we're in luck, looks like my scripts don't care which 
pw instance the series is in. Applied to net-next.

> > Kalle can you ack?  
> 
> Acked-by: Kalle Valo <kvalo@kernel.org>

Thanks everyone!
