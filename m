Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1459F64079D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 14:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiLBNVD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 08:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLBNVC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 08:21:02 -0500
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 05:21:01 PST
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B062A431D
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 05:21:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 362D9110C2;
        Fri,  2 Dec 2022 13:13:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5Eolp4VQP3Ph; Fri,  2 Dec 2022 13:13:17 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Fri, 02 Dec 2022 15:13:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1669986797; bh=MIHRH2XreRgFV9QnIbRn96BvIEylyoYXEacluIlgLzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z1MV3q0XpSpdfzwN9aQSCDa39eJh0X0RTHwDv3XvVUHGWXDumIoBV8/AzsMA0TuJj
         sQGoj9pPCpPjTzJ/uxUekmnW8D/Klo3ZP3Hmm5r9UTmUR0wyhLFwagFSkdxxxn/JdY
         GX9d+msl7EDgVRgswBGI4ANzQ5fLNw0UcbOqYqM15QzDhpupt/j4xozyc5SHXx/m9u
         TARv0ChxeNlNlso5Red8s1QRdARySWgAgFpXMjnpEQWBRjHGMvudjh5sxad+2rjkbf
         SZ+BHkCSos5tlDllICCZCKxrLNK8THgqFFNla5HCUC2ciSxmDOaHjoweU9XAARrMV4
         bh5gIO4WVjy9w==
Date:   Fri, 2 Dec 2022 15:13:15 +0200
From:   Jouni Malinen <j@w1.fi>
To:     "Matthias G." <maps4711@gmx.de>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, hostap@lists.infradead.org
Subject: Re: Bug report: Can connect with 'wext', but not 'nl80211'
Message-ID: <20221202131315.GD444432@w1.fi>
References: <1235df2ba1757a5917dc21455fa8c1d0a48bb2c4.camel@gmx.de>
 <f694e9d9dbf36b870f278f8eabed14d5dede55aa.camel@sipsolutions.net>
 <f8dea92e4fa8e26bd1cc7ff8c6ba6ccd4843d8eb.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8dea92e4fa8e26bd1cc7ff8c6ba6ccd4843d8eb.camel@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 01, 2022 at 06:45:01PM +0100, Matthias G. wrote:
> On Wed, 2022-11-30 at 21:29 +0100, Johannes Berg wrote:
> > Sounds like the AP is broken and doesn't like some elements wpa_s
> > includes when nl80211 has certain capabilities ...

> Just for reference, both my Windows 10 and my Android phone can connect
> to this 'Congstar'-labelled device without further configuration. I
> don't know what Windows and Android are doing behind the scenes though.

If you have a means for capturing wireless sniffer traces of the frames
exchanged between the AP and these various station devices, it would be
useful to take a look at what the exact differences in the Association
Request frame contents. For the nl80211 interface case itself, it would
be interesting to see what is the exact information element that makes
the AP misbehave, e.g., by removing them one by one (this might be
either in wpa_supplicant or kernel) until the association succeeds.

-- 
Jouni Malinen                                            PGP id EFC895FA
