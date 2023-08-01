Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37276B1B7
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 12:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjHAK0n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 06:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjHAK0S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 06:26:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1115B96
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 03:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E79E61521
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 10:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB814C433C8;
        Tue,  1 Aug 2023 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690885404;
        bh=c929dygUnOm1BSbok++ltvpLIUzEv2S+5RUbs/24cKE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SZBNNn/j7jmUXjAWXZ5tNVLUas80puBbv1YOyXZTIIqdLY3gDQDyCZN5zcVg2GU5a
         GZ0KnfJDBO68CukcGuQaPwVNrY5We4NDrCfpNiCCgL+ly5cZGybUa27+/cGWEJra/e
         YOnJHOQ6HtgXvcPb9ohpoDA8iRqTnXtsVffKfAqdNhAQQruTxDnHa+sBonwTBS7OyA
         CP+O7/MnTjcPH0bTHZM+9ns4L6fB5IcME9w6n0oyrXw+nWUPBpu8qQIdnkAtEVHzA0
         +URNxwbRCIEZFZnpx/KqS6ldUoJdmlFgaXxu7MvZjuZzJGc/S4W1FRKFSYfOR6i3o1
         ACwTWBUiBGMzg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Doug Brown <doug@schmorgal.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/4] wifi: libertas: add missing calls to
 cancel_work_sync()
References: <20230724084457.64995-1-dmantipov@yandex.ru>
        <87cz0h3d1q.fsf@kernel.org>
        <ae49815a-c125-5a22-6757-b526d9712103@yandex.ru>
Date:   Tue, 01 Aug 2023 13:23:21 +0300
In-Reply-To: <ae49815a-c125-5a22-6757-b526d9712103@yandex.ru> (Dmitry
        Antipov's message of "Mon, 24 Jul 2023 11:57:12 +0300")
Message-ID: <87r0onxdra.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> On 7/24/23 11:54, Kalle Valo wrote:
>
>> How have you tested these patches?
>> 
>
> No physical hardware so compile tested only.

In that case please always add "Compile tested only" to the commit log.
It's important for us to know if a (non-trivial) patch is tested on a
real hardware or just with a compiler.

Another problem I see that you don't always reply to review comments and
that gives an impression that the comments are ignored. Please always
try to reply something to the review comments, even if just a simple
"ok" or "I don't agree because...".

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
