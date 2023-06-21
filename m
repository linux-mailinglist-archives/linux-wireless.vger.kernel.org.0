Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30141737D60
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 10:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjFUIIx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 04:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjFUIIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 04:08:52 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D8F10D5
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 01:08:49 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:150a:0:640:1aa5:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 19A275E5FF;
        Wed, 21 Jun 2023 11:08:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id k8dXGX3WuiE0-P5X9g9uo;
        Wed, 21 Jun 2023 11:08:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687334926;
        bh=q78sq2YhM22Z00OGiJGLqB9JmI8Evj5dQU327NtR4YU=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=VPa39nsPVxwdcOEcHig6L83zVARKOsQkzOmBdzi8FNehiPWDM1jgi8tjpHV7oMDwD
         BnD9iAYFhnmSnfKw0rZYekaSNRqndv1JKwy5dFS/Nvi1JpnC6v7tQXA0qeT/uVn61q
         hpzPwuLaPwCJa3GimeOyys1/0dszopOGT0tbxoZE=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <ee69ac82-bc62-a288-d7c9-bb432a1b5959@yandex.ru>
Date:   Wed, 21 Jun 2023 11:08:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>
Cc:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
References: <20230620100803.519926-1-dmantipov@yandex.ru>
 <ZJHO/pa7JB49j3rN@google.com>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 1/2] [v2] wifi: mwifiex: avoid strlcpy() and use strscpy()
 where appropriate
In-Reply-To: <ZJHO/pa7JB49j3rN@google.com>
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

On 6/20/23 19:08, Brian Norris wrote:

> I'm not sure how a compile-time constant makes this "unsafe" at all, but
> if you feel the need to change this, then sure, this works too.

The only reason is to avoid strlcpy() which is now considered deprecated.

> FWIW, this 'firmware' pointer is all derived from compile-time constants
> too. So the commit messages seems misleading ("all other calls [...]
> should be safe" --> well, *all* calls are safe).

Indeed. So I think we can stay with strcpy() everywhere except strlcpy() to strscpy() replacement
(just to follow https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy rather than
to fix something).

Dmitry

