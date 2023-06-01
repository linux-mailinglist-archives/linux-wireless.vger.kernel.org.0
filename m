Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB761719D4B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjFANVn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 09:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFANVm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 09:21:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4387EE7
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 06:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE5E964435
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 13:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC90C433EF;
        Thu,  1 Jun 2023 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685625700;
        bh=RqjrPYnvUJzRVywrJOrTYUsyPyv1BqLehdpXFxXeWv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewBtFp2rRzMe6WlmOU+McDv+7ilTktozcVAZKKsv1VraFly1hPrA0QAQk24rcdjDe
         g8z6EhK8jS4Ge/DZNt6fZGugURrB6V7ndFX6w8li2ddbzJ7yUOHPQxebRPVsVlGXk6
         1uAXYk59fvZx2Dc/IMcqd73e9xPHkBGxBOqyUIQZLazhh3UuBS7A59m/b64WNzxuOJ
         iWWvII7/8njibuEhdmjex0t+u0MaZY7xySvXITT+BQjtT93aTDN4vzr0Ti65uiKCo/
         e63cPXBjxJ2hUbt19zkEUtLYYKUeXfyEevREbEdd7G4YdnESA6byZfrCz6WLCj8Rae
         owec4JRFE8D+Q==
Date:   Thu, 1 Jun 2023 08:21:39 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Mohammed Ismail <m.ismael@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Egypt (EG) on 5GHz
Message-ID: <ZHibY/SqV02YuEWL@ubuntu-x1>
References: <CAKOr0YRiWtywH_hggMn0jFivS7GOp9huw+ib5Lz43BxWo5M7CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOr0YRiWtywH_hggMn0jFivS7GOp9huw+ib5Lz43BxWo5M7CA@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 25, 2023 at 12:04:00PM +0300, Mohammed Ismail wrote:
> Hi
> Current rules are
> 
> country EG: DFS-ETSI
>         (2402 - 2483 @ 40), (N/A, 20), (N/A)
>         (5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
>         (5250 - 5330 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
> 
> it is outdated , here are the updated information
> 
> https://www.tra.gov.eg/wp-content/uploads/2021/11/EGY-NTRA-June21-NFAT.pdf
> 
> https://www.tra.gov.eg/wp-content/uploads/2021/11/EGY-NTRA-June21-Chart.pdf

Thanks for the links, however they don't seem to contain the information
about power limits, etc. that we need to update the database. I found
this document:

https://www.tra.gov.eg/wp-content/uploads/2022/03/EGY-NTRA-March-2022-SRD_English_Final.pdf

From this I think the correct rules are:

country EG: DFS-ETSI
        (2402 - 2483.5 @ 40), (20)
        (5150 - 5250 @ 80), (23), AUTO-BW, wmmrule=ETSI
        (5250 - 5350 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
        (57000 - 66000 @ 2160), (40)

If this looks correct to you, I'll send a patch.

Thanks,
Seth
