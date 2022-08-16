Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4800595DDE
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiHPN62 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiHPN60 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 09:58:26 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBD95E678
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 06:58:22 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1660658300; bh=4MaAOuGtfGy51Q8bsqlh+zi5ulOMA2bxgVNmWeVp5QU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Z3Us0SnIY6tokmXmLJmroHWVNKmqiKeT5UUdowqlSbi9u8uamLKqLJzk73V6hIyLf
         LPV0JhDjILr2cyU34ZXI/HPh4VpokTB9Hi7JGLggK8cLCxHcTK7GFUYYFK7ILYDtzN
         q4bRSesMQd5it2YHRNh7PIo1d8LjTY4R/CBiaUZjSd5g1ki0vY8axt8Fz7wboqIVzA
         mWJgFI0Ptw/gGNi5B1tef9Z9jzWX/zZDdFdOIRgco9fixkoKLGafDJeEs2iY2tkgE9
         a0Ibbe7myIKXDKmdT4XFMUVvyP905K67WQTvkJtoMRkpS17+V0eJu6axXP1T36lYGM
         l9Yl20fdJtA4Q==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath9k: avoid uninit memory read in ath9k_htc_rx_msg()
In-Reply-To: <e0bcd6d4-4029-4ab3-0405-054d26262f64@I-love.SAKURA.ne.jp>
References: <000000000000c98a7f05ac744f53@google.com>
 <cd4287be-5434-039e-59ba-2a9cb2ab5185@I-love.SAKURA.ne.jp>
 <e0bcd6d4-4029-4ab3-0405-054d26262f64@I-love.SAKURA.ne.jp>
Date:   Tue, 16 Aug 2022 15:58:18 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87edxgwarp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> On 2022/07/30 21:13, Tetsuo Handa wrote:
>> We have two choices. One is to workaround by adding __GFP_ZERO so that
>> ath9k_htc_rx_msg() sees 0 if pkt_len is invalid. The other is to let
>> ath9k_htc_rx_msg() validate pkt_len before accessing.
>
> Which choice do we want to go?

I prefer the explicit length checks as you do in your patch. Could you
please resend with an updated commit message making it explicit that
this is the choice this patch is going with?

-Toke
