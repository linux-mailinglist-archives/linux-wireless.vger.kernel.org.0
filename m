Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0B6E28BA
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 18:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDNQwq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 12:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNQwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 12:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9C230FD
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 09:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 375916395A
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 16:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760F6C433EF;
        Fri, 14 Apr 2023 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681491162;
        bh=ymu7g2uaVdfKeqRIR4pB6ksp9kMd/qZYNI8NivqgtVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLEP+ZrGMGqLbSXrxc1YvNZHubyLPB1wjKu0YuftUQkHaBTYdiD8UXJYtovaZuoxh
         FotC1+NYNqz79QDOhquBfI5LDHgOU9TnEYcXEE5ZBC2lzWTWkS13vkpjNYkPKJuUpA
         uk2P21w5idHAJU9IyUhVEwbn/cWMsydACAdmZAhIbAcWT60uzmO61stHTibuxwWvGr
         ekHf4R53ISfGoA3Qy0K89xrVsctmQMOyaXHlJFPUnFKGa137Q072Ggw5ac036DArpa
         ONtPT8VpKi4fEtpqRnW2XHn4oBDngUOPuMU6a4esckMIJhAPj/18iFzLCegSc/KkmI
         1BgverK7L+u1w==
Date:   Fri, 14 Apr 2023 11:52:41 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Kirill <me@16depo.xyz>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] Update regulatory info for Russia (RU)
 on 6GHz
Message-ID: <ZDmE2YcOgbSektIE@do-x1extreme>
References: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
 <000cae34-88be-9ac1-84c3-d7d0e6748b18@16depo.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000cae34-88be-9ac1-84c3-d7d0e6748b18@16depo.xyz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 13, 2023 at 11:25:12PM +0300, Kirill wrote:
> Hello, Seth. Is patch for activation of 6GHz are good? Do i need to provide
> some additional links?

Sorry, I haven't had a chance to review it yet. It's been a busy week
and I have to review patches in my spare time. I'm planning to get
through all of these pending mails this weekend.

Seth

> 
> On 25.03.2023 04:04, Kirill wrote:
> > Update regulatory info for Russia on 6GHz in
> >  accordance with current regulatory rules.
> > 
> > Source: https://docs.cntd.ru/document/1300597464?section=text
> > 
> > Signed-off-by: Kirill Matvienko <me@16depo.xyz>
> > ---
> >  db.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/db.txt b/db.txt
> > index 915a3b9..7f338b2 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -1500,11 +1500,12 @@ country RS: DFS-ETSI
> >      # 60 GHz band channels 1-4, ref: Etsi En 302 567
> >      (57000 - 66000 @ 2160), (40)
> > 
> > -# Source: https://docs.cntd.ru/document/902048009?section=text
> > +# Source: https://docs.cntd.ru/document/1300597464?section=text
> >  country RU: DFS-ETSI
> >      (2400 - 2483.5 @ 40), (20)
> >      (5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, DFS
> >      (5650 - 5850 @ 160), (100 mW), NO-OUTDOOR, DFS
> > +    (5925 - 6425 @ 160), (100 mW), NO-OUTDOOR
> >      # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order
> > №129_22042015.pdf
> >      (57000 - 66000 @ 2160), (40), NO-OUTDOOR
> > 
