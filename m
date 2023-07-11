Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3728574F328
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGKPQV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 11:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKPQU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 11:16:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4484A0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 08:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 712D961557
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 15:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B460EC433C8;
        Tue, 11 Jul 2023 15:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689088578;
        bh=jkOs/sMxgD3MzJjm39sfOwLuLRX58r1S5uoM9MWiK8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1y49BRoIZIFelBqBuZZIO+4SgB2ZHY41gI0bpOzGXoeLBZZElBwDVoQRn7IZf1uZ
         S6Pty5fpq9RtXkP7WwhUwx+WUFGTgxMeJdwlYNrdFOrP5qZwrE5PGjBKZCWbU9v/A/
         W+1TQefYR5hpmpI8cK6x7bHNjUTVG+1QGe3m6d2oGxbbgSM73Sevx0IpOqKcXFNCii
         82c6XkgWL50+YPLXU5T/QBUHz0Ri0oHbzzS9Jywb0ILFnIThdt8FR4PVZrTHlfHsVE
         slz3CbB3FA+MqyNtCi7Lx5lBlZqqFQyRPf1sk8OHdj54vo/baoAYtoGcUVk6kXbsS/
         YQZmjpiH2gPAQ==
Date:   Tue, 11 Jul 2023 10:16:17 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Mohammed Ismail <m.ismael@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Egypt (EG) on 5GHz
Message-ID: <ZK1yQciEefUp1vUt@do-x1extreme>
References: <CAKOr0YRiWtywH_hggMn0jFivS7GOp9huw+ib5Lz43BxWo5M7CA@mail.gmail.com>
 <ZHibY/SqV02YuEWL@ubuntu-x1>
 <CAKOr0YRy=14-0QHBJNPWK3LHNMY01eVZnGL8nToP1271vJwz+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKOr0YRy=14-0QHBJNPWK3LHNMY01eVZnGL8nToP1271vJwz+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please be sure that you do not drop the mailing lists when you reply.

On Tue, Jul 04, 2023 at 08:07:35PM +0300, Mohammed Ismail wrote:
> Dear  Seth,
> Thank you for your swift reply, and I am sorry for that huge delay in my
> response.
> 
> You are right that there is no power information in the documents I
> provided.
> 
> But the power allowed for 5150-5350 is 200mw
> and your rules defined (5250 - 5350 @ 80), (*20*), DFS, AUTO-BW,
> wmmrule=ETSI

This is because 5250-5350 MHz requires TPC. Linux does not support TPC, so
we must reduce the max EIRP by half to 100 mW in this range.

I'll send a patch soon.

Thanks,
Seth

> 
> 
> thank you for your cooperation
> 
> best regards.
> Muhammad
> 
> On Thu, Jun 1, 2023 at 4:21 PM Seth Forshee <sforshee@kernel.org> wrote:
> 
> > On Thu, May 25, 2023 at 12:04:00PM +0300, Mohammed Ismail wrote:
> > > Hi
> > > Current rules are
> > >
> > > country EG: DFS-ETSI
> > >         (2402 - 2483 @ 40), (N/A, 20), (N/A)
> > >         (5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
> > >         (5250 - 5330 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
> > >
> > > it is outdated , here are the updated information
> > >
> > >
> > https://www.tra.gov.eg/wp-content/uploads/2021/11/EGY-NTRA-June21-NFAT.pdf
> > >
> > >
> > https://www.tra.gov.eg/wp-content/uploads/2021/11/EGY-NTRA-June21-Chart.pdf
> >
> > Thanks for the links, however they don't seem to contain the information
> > about power limits, etc. that we need to update the database. I found
> > this document:
> >
> >
> > https://www.tra.gov.eg/wp-content/uploads/2022/03/EGY-NTRA-March-2022-SRD_English_Final.pdf
> >
> > From this I think the correct rules are:
> >
> > country EG: DFS-ETSI
> >         (2402 - 2483.5 @ 40), (20)
> >         (5150 - 5250 @ 80), (23), AUTO-BW, wmmrule=ETSI
> >         (5250 - 5350 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
> >         (57000 - 66000 @ 2160), (40)
> >
> > If this looks correct to you, I'll send a patch.
> >
> > Thanks,
> > Seth
> >
