Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9787191AA
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 06:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjFAETV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 00:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFAETT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 00:19:19 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F8107
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 21:19:17 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:239a:0:640:2833:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 672155E59C;
        Thu,  1 Jun 2023 07:19:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CJFqPP2WkOs0-dWqkhg6O;
        Thu, 01 Jun 2023 07:19:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685593152;
        bh=wM7CM/ZJ2pDBqDdqTea46gMYTXmppt61sFT8IQqfCOc=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=tCzcTzrH43RQOyds3qf3RcV24zjCLKgxp2zz2iMh5dNr9SxKjXHSDgqTA6DgDMGWq
         MtpUAmh6GwmA3rKhwp58MH0Dp4wMZnQicZeAVHyDk/b9tJt7MIBWaDcTJyVtNnJipR
         kWYCXmUm6B0Zl5pzs/Xn4yz3NRmfr4pBpI/sDEVI=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <f9db0f15-bd7e-7ccb-0fd3-190f47a82037@yandex.ru>
Date:   Thu, 1 Jun 2023 07:19:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Dmitriy Antipov <Dmitriy.Antipov@softline.com>
References: <20230531143001.674220-1-dmantipov@yandex.ru>
 <b3860092d9d342e389569be49512ef8f@realtek.com>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] rtlwifi: remove unused timer and related code
In-Reply-To: <b3860092d9d342e389569be49512ef8f@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/1/23 04:36, Ping-Ke Shih wrote:

> subject prefix "wifi: rtlwifi: ..."

OK

> s-o-b doesn't match your e-mail address of "From".

There are some corporate rather than technical reasons for introducing such a mess.
I should say sorry for it and hopes that the things will change in the near future.

Dmitry

