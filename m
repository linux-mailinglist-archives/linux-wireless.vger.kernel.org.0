Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAEA6D1C88
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 11:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjCaJgQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 05:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjCaJgC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 05:36:02 -0400
X-Greylist: delayed 61057 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 02:35:33 PDT
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3401DF8E
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 02:35:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id C1F56111C1;
        Fri, 31 Mar 2023 09:34:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xbDi_xsbcz9l; Fri, 31 Mar 2023 09:34:39 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Fri, 31 Mar 2023 12:34:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1680255279; bh=LNSD32VpgY9NTzLqqB5MHdoijxuxEAdJAG7PDPGoJeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZiXH2lwZ9lnA240JrPvhB+4xYc+xyn5g+3grF/QiHs755pvPlSwnQvmpVLvCNbHx
         tTw+yhhqbYB/xto/YMCuIB3rxmRvqEh7Ezr6n9HmxShdI7DYsglbwU5MFfpxQ6TL69
         n19ALNOPYf7GGIJO3wwR2g68EHUYigxJxmg1/RqIKkmkazDOb+fLJxRKMBW/fUVIxI
         Bf0uDymWYOKwMJbribgdlvExJalN6NIZs0yavnxRTQJGwSlzIIJj0ysAxg0UKAN6UK
         hlNuIjPxeNS89dh74KVTTNNHJqRoEWWOhfE7I5rdLvIJs1b3Oc5prH67GTmcjyj6Lh
         Xu1Y4v1QbXCBQ==
Date:   Fri, 31 Mar 2023 12:34:37 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] nl80211: Add support to configure allowed frequency list
 for AP operation
Message-ID: <ZCapLa6oYIRgF3f4@w1.fi>
References: <20230328093105.3640436-1-quic_vjakkam@quicinc.com>
 <421e93d78deda5ac9e62c58ee275758a3355a503.camel@sipsolutions.net>
 <ZCW5HVMLHHW2bzKW@w1.fi>
 <3d09a8c687fc3d37a8be367a518ea174cdc1325d.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d09a8c687fc3d37a8be367a518ea174cdc1325d.camel@sipsolutions.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 31, 2023 at 11:14:14AM +0200, Johannes Berg wrote:
> On Thu, 2023-03-30 at 19:30 +0300, Jouni Malinen wrote:
> Oh, no, I'm entirely happy with this happening in nl80211, it's just the
> age-old question again of whether those upstream drivers will ever even
> get support for it, or if we end up with more code that effectively
> looks dead as far as upstream is concerned :-)
> 
> If this actually came with a driver patch using it, the question
> wouldn't even arise, since then it's clear why it's needed and what
> for...

This is one of those cases where the changes seem to be of general
interest, but there is no immediate plans to work on any upstream driver
to use that. As far as the current potentially applicable upstream
drivers are concerned, I would not expect ath6kl to be extended to use
this. I do not really know whether anyone maintaining the drivers for
other vendors would be interested.

This is a balance on what would be the cleanest design (i.e., the most
appropriate nl80211 command for this type of configuration) and
potential help for others vs. what could be done with a somewhat ugly
vendor specific command before the start AP command. Since this specific
case can be handled with a vendor command, I'm not planning on pushing
strongly for this to get accepted into upstream nl80211, but it did seem
to make sense to propose this to see if there would be sufficient
interest for other drivers.

-- 
Jouni Malinen                                            PGP id EFC895FA
