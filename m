Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5F57608D0
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 06:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjGYEoG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 00:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjGYEoD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 00:44:03 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CEB10EC
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 21:44:01 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 8116E5EDAF;
        Tue, 25 Jul 2023 07:43:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id vhBFHEaDbeA0-D6ozNBsA;
        Tue, 25 Jul 2023 07:43:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690260238;
        bh=gxzA7kPvKXjH4mLPW7hhc0qARNg2LM+18kLvxMuSYNw=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=arDEn7/0moBnuMPCaP7Ho717Y/5GPA+1llm3CqM1kEqXltrbsMtDZrwBeXd9gL8iz
         SMjqAo6NMFXoT8nz+QQYeVzDHqYh7MuALQyh2YVJr9rqEh8zOIUdM1o9ym+R94ns9b
         zHMNVHBcvEUR5Npq/a0DXA+5MX0qZnGlNHU4c12g=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <271713a9-683e-0467-88c4-8f67a272741e@yandex.ru>
Date:   Tue, 25 Jul 2023 07:43:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] wifi: libertas: add missing calls to
 cancel_work_sync()
To:     Dan Williams <dcbw@redhat.com>
Cc:     Doug Brown <doug@schmorgal.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Kalle Valo <kvalo@kernel.org>
References: <20230724084457.64995-1-dmantipov@yandex.ru>
 <87cz0h3d1q.fsf@kernel.org>
 <d7262341b0d3b635403f9d19ff2d381f7a543c2a.camel@redhat.com>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <d7262341b0d3b635403f9d19ff2d381f7a543c2a.camel@redhat.com>
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

On 7/25/23 00:27, Dan Williams wrote:

> I can try to give the SDIO bits a run this week on an 8686. I don't
> have a SPI setup to test though.

It would be very helpful, thanks in advance.

Dmitry

