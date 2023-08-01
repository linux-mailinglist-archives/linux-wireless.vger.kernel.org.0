Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7876B3B6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjHALrW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjHALrU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 07:47:20 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FCD10FD
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 04:47:16 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:4212:0:640:eaad:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 011FF5EEEC;
        Tue,  1 Aug 2023 14:47:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BlP0P0tDSGk0-se9AEOHg;
        Tue, 01 Aug 2023 14:47:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690890433;
        bh=qm5mnywxPcVe+s41otEBNp0/krEP7Rsg5HJ4piOitaY=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=wDI6r/0URoohG0NE6VP7Mmd/y/c+aY4reWZffddyqqmP+oJ/vX9EdvUllNK6rekHN
         AAn6IUn7lxz9WbRwiSRpX24MNGdtb6bGrQ2PALQYaAsNf7cSz49VMxorzkBw49jl3z
         OWSVw/jR7FbXdfGI4LXvImMaIH4JN3QbaEk97yE8=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <0368ccdc-74f4-6ec1-1b7d-cfb5ebfd479d@yandex.ru>
Date:   Tue, 1 Aug 2023 14:47:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Doug Brown <doug@schmorgal.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230724084457.64995-1-dmantipov@yandex.ru>
 <87cz0h3d1q.fsf@kernel.org> <ae49815a-c125-5a22-6757-b526d9712103@yandex.ru>
 <87r0onxdra.fsf@kernel.org>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 1/4] wifi: libertas: add missing calls to
 cancel_work_sync()
In-Reply-To: <87r0onxdra.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/1/23 13:23, Kalle Valo wrote:

> In that case please always add "Compile tested only" to the commit log.
> It's important for us to know if a (non-trivial) patch is tested on a
> real hardware or just with a compiler.

OK.

> Another problem I see that you don't always reply to review comments and
> that gives an impression that the comments are ignored. Please always
> try to reply something to the review comments, even if just a simple
> "ok" or "I don't agree because...".

Looking through my e-mails for the previous month, I was unable to find an
unanswered review. Could you please provide an example? I'll fix it ASAP.

I don't want to speculate around the workflow of others and realize that someone
(especially the maintainer) may be overloaded and too busy. OTOH it's not quite clear
why the trivial things like https://marc.info/?l=linux-wireless&m=169030215701718&w=2
stalls for almost a week. Should I consider this as "ignored" too?

Dmitry

