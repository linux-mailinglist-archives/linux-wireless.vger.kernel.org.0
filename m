Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4F251C44E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354455AbiEEP6D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 11:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbiEEP6C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 11:58:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779015BD3E
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 08:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 263FCB82DFA
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 15:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFD4C385A4;
        Thu,  5 May 2022 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766059;
        bh=BZ4OcKa4RZLJkgigptDDspCRyo7W2fFlrgS6bKz8hPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tGz4QzBrZjDakhoRCIYMtY0E6VP9AT3BDrvh7fBOOLqGng6wlt9IXiBOspYw5aArR
         GSxxe+TnBsFNfJ0DEQcTFhfcmmJFX31i3xdEo8hh1SoYNWgzRIwenI1EiUtPy4mYIV
         7BLGcRH7ZcPdOshHCdesv1OGrQv7oEujFSh57+tnobIz9wMp7oGumXxFdPM8/StEsz
         zdzlJXJZSC1Zl4Tirtq6Yivs+ZFmu6qzvIZNf1u7N9H0X+eFKmJIoWnjtE1fsxDVc1
         rwksg63l7dq20zrejecaOQAUhGZW8MR8AgQfB7H74HyB3hpU8Y0WRtjkNtlKucgnvw
         +S4vHkEp99ENg==
Date:   Thu, 5 May 2022 08:54:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] wifi: netif_napi_add() conversions
Message-ID: <20220505085418.5384f6c9@kernel.org>
In-Reply-To: <87a6bwzjvk.fsf@kernel.org>
References: <20220504163316.549648-1-kuba@kernel.org>
        <87a6bwzjvk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 05 May 2022 07:25:03 +0300 Kalle Valo wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
> > Convert wifi callers to the new netif_napi_add() APIs.
> >
> > The callers passing 64 or NAPI_POLL_WEIGHT to the non-Tx flavor
> > are left alone. I'm planning to include wifi drivers in the massive
> > tree-wide patch/series which will drop the last argument from
> > netif_napi_add(). Alternatively I can switch all of wifi to
> > netif_napi_add_tx_weight() and back after the netif_napi_add()
> > change makes its wait into wireless-next.
> > Please LMK if you prefer that.
> >
> > Jakub Kicinski (3):
> >   wifi: wil6210: switch to netif_napi_add_tx()
> >   wifi: mt76: switch to netif_napi_add_tx()
> >   wifi: qtnfmac: switch to netif_napi_add_weight()  
> 
> We don't use that "wifi:" prefix, otherwise looks good. 

I know, my silent effort to make git log --oneline be more
understandable for folks outside of networking is not really
being met with much applause :) Ethernet people also don't
like the "eth:" prefix..

AFAICS drivers tend to use a format consisting of (numbers at 
the top denoting commonality):

3    4       1       2
net: vendor: driver: component: bla bla

Driver name is the most common prefix. It is the most meaningful
and natural for people working on the code. Not everyone is working 
on the driver code, tho.

1) When I send PRs to Linus I always wonder how much he can 
make out of the shortlog. And if people throw "net:" into the mix
whether it's still clear when something is "just" a driver bug vs
a core bug affecting everyone. So I started using "eth: " for ethernet
drivers, and "wifi: " for wireless drivers in the text of the PRs.

2) For people doing backporting the driver names may not be meaningful,
but if I'm doing backports for a datacenter kernel I know to pay
attention to "eth:" while "wifi:" I can safely skip.

3) The case of this set - I have conversions for the entire tree queued
up on a branch, it's quite useful for me to use a common area-specific
prefix to see what goes were.

Anyway, that's just me rambling. I hope you don't mind if I send things
with a wifi prefix from time to time given it's a convenient way for me
to mark the queued patches.

> Feel free to take via your tree:
> 
> Acked-by: Kalle Valo <kvalo@kernel.org>

Actually I didn't cc netdev so would be easier if you could take them :)
I have to wait for RDMA/infiniband to get merged up before I can start
deleting stuff anyway :(
