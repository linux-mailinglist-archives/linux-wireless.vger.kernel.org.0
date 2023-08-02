Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6414676C522
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 08:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjHBGEm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 02:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHBGEl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 02:04:41 -0400
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF141707
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 23:04:37 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3c99:0:640:7c39:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id 48C2A5EC43;
        Wed,  2 Aug 2023 09:04:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id M4L8DW5DgCg0-bcbCn8lk;
        Wed, 02 Aug 2023 09:04:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690956263;
        bh=whPNRifSnV2NVjfsKwz/SQ6bUYmNJugmI7Ldb2FcwTU=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=itSeH+Xtw7ZruJobSl4kVSbft8p3E4wTkU9HvVimPbWyGybpTSC8WF2BmJ7hWIu8P
         RTqFS/RF1927EzbdY66tnbO5ZQWjVcy0sFw5+D2LvXjX9BkI2QycWA7BK1qmuZEe6c
         iJlj+K7NoOd04XRzcDfOHrRgdwN7Y9cvuGnYRq4w=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <022650a5-103a-c6b7-a84c-2597179c5b98@yandex.ru>
Date:   Wed, 2 Aug 2023 09:04:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
References: <20230731074334.56463-1-dmantipov@yandex.ru>
 <ZMlOn7VqW2Ds30XO@google.com>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: mwifiex: fix error recovery in PCIE buffer
 descriptor management
In-Reply-To: <ZMlOn7VqW2Ds30XO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/1/23 21:27, Brian Norris wrote:

> I'm not sure that's truly an appropriate "Fixes" target, as that commit
> just shuffled the existing bad code around. I'd either remove that line,
> or else also add:
> 
> Fixes: d930faee141b ("mwifiex: add support for Marvell pcie8766 chipset")
> 
> where the buggy stuff was first introduced.
> 
> I don't think you need to resubmit just for this; Kalle can usually make
> small adjustments like this when applying. And even if not, the issue is
> trivial.

I have some more PCIe bits; would it be better to submit them separately or
create a series (of 3 patches I think) and make this one a part of the series?

Dmitry

