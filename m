Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63623717661
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 07:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjEaFvP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 01:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEaFvO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 01:51:14 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A2211C
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 22:51:12 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1d21:0:640:c9e4:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id 2C4CA5F0CD;
        Wed, 31 May 2023 08:51:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7pFZr8dDTqM0-fgJFTTBZ;
        Wed, 31 May 2023 08:51:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685512269;
        bh=q/nKUMUVJvX/6VAG6XyEzpceA6DfLvIhIIjPeVqiK1M=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=RDmXarGvCStcYUaj7AH2YCoTQCu6gdgfYaCIZfpXBFClS4j8/Y+CiB6mEi2u2LSGq
         sJvfH+G/bo8hTefpdkmK1a4vjq1ZD7NGfmXdibTmzSKmZjMDol+BAektM+0dDFmaws
         ocNNOecpdKXczMV4xLiuJ7abM2sLVXB6tGKVGbDo=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <b2198915-0e92-de99-d950-be46c2bd8e91@yandex.ru>
Date:   Wed, 31 May 2023 08:51:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Dmitriy Antipov <Dmitriy.Antipov@softline.com>
References: <20230530155446.555091-1-dmantipov@yandex.ru>
 <b747b45e-e176-4c55-0886-abfcb1e33717@lwfinger.net>
 <09191d90-c29d-bdf5-4192-19553f8911fd@yandex.ru>
 <bee18794-8c4a-2af9-cf1c-807969be3dd2@lwfinger.net>
 <c861d21d606441c9bf40ff963090d098@realtek.com>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] rtlwifi: rtl8188ee: drop RTX_POWER_BEFORE_IQK_A and
 RTX_POWER_AFTER_IQK_A reads
In-Reply-To: <c861d21d606441c9bf40ff963090d098@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/31/23 03:25, Ping-Ke Shih wrote:

> Another way is to add a debug message to show them, and then static checker
> shouldn't warn this. Also, people can diagnose IQK & LOK results if needed.

1. When CONFIG_RTLWIFI_DEBUG is not set, rtl_dbg() becomes a no-op inline
function which doesn't use any of its arguments at all. This may (an will)
cause the tool to produce even more warnings.

2. I don't like an idea to add some code just to make some tool happy.

3. In general, is it always (or just sometimes) required to read (some
subset of?) BB registers even if we don't interested in their values?
Is it explicitly required by the hardware design?

Thanks,
Dmitry

