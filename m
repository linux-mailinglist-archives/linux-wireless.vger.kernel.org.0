Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E4583B60
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiG1Jj7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiG1Jj6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 05:39:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92156583D
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 02:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E842ECE2454
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 09:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5AAC433D6;
        Thu, 28 Jul 2022 09:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659001194;
        bh=qXUVGAu6hglYXNpvMNBsrp9DHVGY7weJHUgB4TfEgXs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PAfGQozZUH1RF44yXPAZK+8nc+YtOf8tgZedZnvnItWxP77ZSca4afB9odIMSmLLH
         zyVzTWrz2qSzlRuPU/n6DJWn7BGNnXhL9ZVBWectwEUJBBfYAEo0ShuvGLRYpU6wpr
         p+Jtp3y0cqi9ps+IB5nAJ3ihBbdNmS23A+OO/8vG5FD6o7/82qNZbWmwRJeLagQId2
         I5+UCbZAaK9OQ4S5qQDECOyeYRkv9nwRh6Act2ZYC/FkkQ6EX+uTc/KDRfJdZwvrSD
         7nlExQ5trq5lV87giNZPh9ACO/xVpPOPTQ7OUPM5jHwC/OKk71cVrkJK/egXNu2opK
         kvFA1LuNU0E7g==
From:   Kalle Valo <kvalo@kernel.org>
To:     aspriel@gmail.com
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 7/7] brcmfmac: introduce BRCMFMAC exported symbols namespace
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
        <CAJ65rDwMzF8hhuykrikSdsPMgy4GhLkTUfqTfn-cbHwCL5OE2Q@mail.gmail.com>
Date:   Thu, 28 Jul 2022 12:39:51 +0300
In-Reply-To: <CAJ65rDwMzF8hhuykrikSdsPMgy4GhLkTUfqTfn-cbHwCL5OE2Q@mail.gmail.com>
        (aspriel's message of "Mon, 13 Jun 2022 05:19:29 -0400")
Message-ID: <87fsilo9so.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

aspriel@gmail.com writes:

> Instead of using EXPORT_SYMBOL() use namespace variant and only if
> build vendor-specific code as separate module.

The commit log should always answer to the question "why?".

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
