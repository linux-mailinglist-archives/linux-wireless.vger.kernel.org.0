Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BC875680C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjGQPbs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 11:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjGQPbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 11:31:48 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35011199
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 08:31:17 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1380:0:640:6985:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 0FF806009E;
        Mon, 17 Jul 2023 18:30:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id XUhFHjeWsGk0-z3lB7qnG;
        Mon, 17 Jul 2023 18:30:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1689607833;
        bh=VM7Seaw65R4bubaJ+D+M0Mbn2rUCnTsnFhL8KBH7gyo=;
        h=Subject:From:Cc:To:Date:Message-ID;
        b=NzFY2AzH5KQeg0B3KyJtoug4KdsUesF1q5AGu95darpST1HN51hcjbZeJTQunNpKv
         rBLN7IhCiZN4EKhEeAScFXGP5ogqn2D9bcvFhJrWs4dNmXMmheCdhAIfhmj3XwYZkI
         n+uT/olEynB/H8jH8pxE0dgOG0Si1w+m3m5WCo/A=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2300d056-26ad-d0ad-4527-f395cab06729@yandex.ru>
Date:   Mon, 17 Jul 2023 18:30:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Wright Feng <wright.feng@cypress.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: On brcmfmac console reading timer
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In dcb485dfc83b ("brcmfmac: add a timer to read console periodically in PCIE bus"), what
time units are assumed to manage the 'console_interval' of 'struct brcmf_pciedev_info'?
If the former is in jiffies, then comparing it with 'MAX_CONSOLE_INTERVAL' (which is in
seconds) in brcmf_pcie_console_interval_set() doesn't work in the way you might expect;
if it is in seconds, then the same applies to an attempts to reschedule timer with
'mod_timer(&devinfo->timer, jiffies + devinfo->console_interval)' etc.

Dmitry

