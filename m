Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533B17DC15C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 21:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjJ3UjL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 16:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjJ3UjK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 16:39:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC1EAB
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 13:39:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE1EC433C7;
        Mon, 30 Oct 2023 20:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698698348;
        bh=3P2qlkX+DrVyadaT90jeCX8ol+J/3yj2L/wdhbe9yzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lmgo8NhNPupJ0NhOoB4yZewAcFFr6Aji12DHSPpOsGQsHpeObSWOSpLm4jfsbFhBB
         5ZoI4gFSUd/F0/AqaDXqEAzn/Abno6fD2nZi0ycY1l1+Y4Xfz/LpxdHuvMxbMAuu16
         ZQ7YMEH06xRjdig2grPmPPn9SOZVcVGvOUGBFQInZrCGfYnGBrigyTjuGYKY/R8hpN
         gyuaGCIlyjLVAKD5DurRLo7ypcRkgls15PHIPNXO4v3myJoRxT/w2c5WTpXQj99eKW
         ZjOGQLxxM/ZCXxcAqPHj9rbChH5lV13DdLhF5msft7KKLecLMfmWKV+TWdqTv0bn04
         1IPtrWxOTxnRA==
Date:   Mon, 30 Oct 2023 15:39:06 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [ANN] wireless-regdb: master-2023-09-01
Message-ID: <ZUAUahZakEvOXpip@do-x1extreme>
References: <ZPJF1/2YA4dP+ggY@ubuntu-x1>
 <CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 24, 2023 at 02:23:26PM +0800, Chen-Yu Tsai wrote:
> I'd like to take up maintainership.

Thanks for volunteering! Sorry I didn't get respond sooner, this thread
was buried kinda deep in my inbox so I didn't notice your message right
away.

> As far as I know, I would need to:
> 
> 1. Make a clone of the repository on git.kernel.org under my own namespace.
> 2. Generate a key pair and certificate
> 3. Put the certificate into the kernel tree
> 4. Update the docs to point to the new repository and certificate
> 5. Review incoming patches and apply them
> 6. Tag releases timely
> 
> I'm not sure if I missed anything.

That's the bulk of it. Most of the time is spend validating proposed
changes against the government documents. There's also maintaining the
tools to build the database and moderating the mailing list, but neither
of those are much effort.

Johannes will be the one who needs to accept your key into the kernel,
so we should wait for a +1 from him at least before we really get the
ball rolling.

Thanks,
Seth
