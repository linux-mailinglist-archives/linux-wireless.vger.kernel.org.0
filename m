Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6675A9765
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiIAMuq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 08:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiIAMun (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 08:50:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06C8DFE1
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 05:50:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70076B82566
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 12:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DB1C43470;
        Thu,  1 Sep 2022 12:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662036636;
        bh=OWtdBP4/+VXtdZ5lVRHsOHA3h+/yoWhw6ulhO3A835g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGdRNbgNIFpml+QvbmtsJzIb0+vFZKtb8nrkvP3udIwWJ5e5SDQTKl37kH4mCQS2j
         BsNoFggY93HzVdMPCwS3SVKP9GomDz4ugCTDnGc748XaxddLV02HjLfZ6I4VTTjasS
         JC7VuUJYRdFIN0MFOz89XqWNKzO/5VOfwxuiv401Sj6ZThmp/376w1Cxp/QeJBACJ5
         4Hjlu6DVfOtSkyeMQ35SLPfxeckOXWeo+m1C8pW7nQcd9eRCfTykvowuUo7kcSu8nl
         emGnBRaLuMit8fGFapsiuR5ZBeW6jm2qmicOm3LOnyIY7035pT57W8Jv+B9fiJ1Aql
         VA6LO/tR4vuFQ==
Date:   Thu, 1 Sep 2022 07:50:35 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Cesar Eduardo Barros <cesarb@cesarb.eti.br>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] wireless-regdb: Update regulatory rules for
 Brazil (BR)
Message-ID: <YxCqm+3tCDpsaZxR@do-x1extreme>
References: <271ca023-d574-7d84-a020-ec5950fb500e@cesarb.eti.br>
 <Yw4cTotCZm7CH/v7@ubuntu-x1>
 <2cf2cb6e-8083-9c09-c2a6-ae49424ea37a@cesarb.eti.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cf2cb6e-8083-9c09-c2a6-ae49424ea37a@cesarb.eti.br>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 31, 2022 at 11:44:17PM -0300, Cesar Eduardo Barros wrote:
> Em 30/08/2022 11:18, Seth Forshee escreveu:
> > On Wed, Aug 17, 2022 at 08:31:56PM -0300, Cesar Eduardo Barros wrote:
> > > 	#(902 - 907.5 @ ???), (30)
> > > 	#(915 - 928 @ ???), (30)
> > 
> > For these ranges I think you should use the same bandwidth as other
> > rules in the database, i.e. 2 and 16 MHz.
> 
> I found only two entries in the database with rules for the 900MHz
> frequencies: US and "world". I don't think the US rule is a good model here;
> it can use 16 MHz because it's a contiguous range, but the range for Brazil
> has a hole in the middle.
> 
> Since there's nothing that a found in these rules which mention a maximum
> channel width, the correct width is probably the maximum which fits on each
> piece of the range. That is,
> 
> (902 - 907.5 @ 4), (30)
> (915 - 928 @ 8), (30)
> 
> As far as I could find, the hole between 907.5 and 915 exists because there
> are three 2.5 MHz-wide GSM uplink channels there. However, I also found out
> that there is a proposal within ANATEL (Consulta Pública 52 from 2021) to
> expand it with another uplink channel at 905 - 907.5 (there are actually
> five uplink channels in that proposal, the other one is at 898.5 - 901). I
> have no idea when this will become official, or whether it has already
> happened (and just wasn't reflected yet in the restricted radiation rules I
> had researched), and what effect it would have on 802.11ah users.
> 
> Given the uncertainty from that change, and given that so far there are
> rules for the 900 MHz range in wireless-regdb only for the USA, it might be
> wise to hold it for now and apply only the rest of the changes, without
> these 900 MHz ranges.

Sounds good to me.

> > Otherwise I think these changes look good. If you can send a patch with
> > the changes I would appreciate it, otherwise let me know and I can send
> > a patch.
> 
> I will prepare a patch tomorrow.

Thanks!

> 
> -- 
> Cesar Eduardo Barros
> cesarb@cesarb.eti.br
> 
> 
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb
