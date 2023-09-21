Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871047A9626
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 19:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIUQ6x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIUQ6w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 12:58:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DAE1BD6
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 09:58:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACEBC4E66D;
        Thu, 21 Sep 2023 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298346;
        bh=0oOKV5dd8K+N8q0nDh5k3SZD+WjqZu42p4J1UFU6oR8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UGiiGfV3KJCu3NO3o4MsPbiX5YZgKfLI/tQle52lRMMwVmDtELeCb8l6h7lIjZMOw
         6HLVSfV9O+ncaAW7KnDdwNrOfwaeGf/i07i5pe9MP2mX3VlAjtyRMvJ9Kchb5ETAsi
         m6/9hvXB9SrVUxkamEVzEN7e2QkwwKSvycR6qNETwnNhc2p4IS2Xnq/80CVucxOcR2
         LEQ21mAGwqFzNGAWVq6NdavWFQVLJDXlaPZPJGfeZNIQn4+kLqXuZB1+Sl6/SfYk3g
         5TozBzk/GtEoxsRukE32bUuF3YS74j/P6FV8tclPSmG0pbPzBKs+pEjdgQ6bgo/wkM
         HBdJ7Jnzmfybw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: mwifiex: fix SDIO firmware dump wait
References: <20230920112259.18656-1-dmantipov@yandex.ru>
        <ZQt89BPMN6Fg3H6z@google.com>
        <cc57fb2f-1eca-f366-bec3-d4cdbb2c39ec@yandex.ru>
Date:   Thu, 21 Sep 2023 15:12:23 +0300
In-Reply-To: <cc57fb2f-1eca-f366-bec3-d4cdbb2c39ec@yandex.ru> (Dmitry
        Antipov's message of "Thu, 21 Sep 2023 12:22:59 +0300")
Message-ID: <87o7hvafo8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> On 9/21/23 02:15, Brian Norris wrote:
>
>> Have you tested this patch? You've certainly caught a logic bug, but
>> that doesn't mean the seemingly obvious solution actually works.
>
> Unfortunately by eyes only :-(. IIUC there should be a weird hardware
> stall to trigger an execution of the branch in subject, so I'm not sure
> how to actually test it even if I would have an access to the hardware.

I don't know about Brian but for me testing for regressions is the most
important part. If the patch is only compile tested it could break the
whole driver without anyone noticing. And then it's in a release and too
late.

That's why I have been asking you to add "Compile tested only" to the
commit log so that it's obvious to everyone that your patches have
received zero testing but you don't seem to care.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
