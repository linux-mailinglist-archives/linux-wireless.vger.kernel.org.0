Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77804F9A13
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 18:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiDHQHw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Apr 2022 12:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbiDHQHv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Apr 2022 12:07:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F61237FCC
        for <linux-wireless@vger.kernel.org>; Fri,  8 Apr 2022 09:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A3D9B82BCE
        for <linux-wireless@vger.kernel.org>; Fri,  8 Apr 2022 16:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AA4C385A3;
        Fri,  8 Apr 2022 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649433943;
        bh=k2qCXXomEcAYdSFbcqOIT43BVhU94YLzspEslYFtN1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p2cF+0FiRQOqJcfpwzeFpZnZ/eWs8GZmXtP6RJiKpK7GWabw55PZx5TBOEuLCbdza
         8UfI4OnWLSJ1fglTVjShVQiHvI9/sMPqltFYoH5VxqOP2z9HU48pD2i0aHU6lMr2Hh
         fRtzLFls4GAbzMDzHBbFMvrF5CpK83m/ABjaFHRUpc/HC2mj6J2PcTgz83s2felDWi
         NczUjP+SBrs5fqCUjSWgtbS0svWcR2ckJoGlNcW+wNkhVy1h9w5QEdhDxDyhHMdN2l
         +RtiSnJy05FFEE40cOx6qqz0SEuI3HOtLRZOSrIISAhHzGprABfU7XN8RM/AhMypVK
         OBvbQ8EhX4Szg==
Date:   Fri, 8 Apr 2022 11:05:42 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Sid Hayn <sidhayn@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [ANN] wireless-regdb: master-2022-04-08
Message-ID: <YlBdVvV7NGNccysW@ubuntu-x1>
References: <YlBLWuf0eKyS1HL0@ubuntu-x1>
 <CAM0KTbBCeyx8TGkGcNkjJ7TYjtr6zeFY2=1TWwbzd5d3xHdZXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0KTbBCeyx8TGkGcNkjJ7TYjtr6zeFY2=1TWwbzd5d3xHdZXg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 08, 2022 at 11:37:54AM -0400, Sid Hayn wrote:
> Are "regulatory.db" and "regulatory.db.p7s" missing from this release
> on accident or no longer required?
> 
> I package wireless-regdb for gentoo but I honestly haven't been
> following development much more closely than just bumping for
> releases.  For the recent releases I've been installing regulatory.bin
> in /usr/lib/crda and regulatory.db and regulatory.db.p7s in
> /lib/firmware

Oops, it looks like a typo caused them to be removed by accident. I've
updated the archives and the signature to contain the missing files.
Thanks for letting me know!

Seth

> 
> Thanks,
> Zero_Chaos
> 
> On Fri, Apr 8, 2022 at 10:49 AM Seth Forshee <sforshee@kernel.org> wrote:
> >
> > A new release of wireless-regdb (master-2022-04-08) is available at:
> >
> > https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2022.04.08.tar.xz
> >
> > The short log of changes since the master-2022-02-18 release is below.
> >
> > Thanks,
> > Seth
> >
> > ---
> >
> > Richard Huynh (1):
> >       wireless-regdb: Update regulatory rules for Australia (AU)
> >
> > Roman Kunzman (1):
> >       wireless-regdb: Update regulatory rules for Israel (IL)
> >
> > Seth Forshee (2):
> >       wireless-regdb: add missing spaces for US S1G rules
> >       wireless-regdb: update regulatory database based on preceding changes
> >
> > _______________________________________________
> > wireless-regdb mailing list
> > wireless-regdb@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/wireless-regdb
