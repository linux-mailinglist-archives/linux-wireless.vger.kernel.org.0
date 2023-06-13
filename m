Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BDE72DD19
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbjFMI4a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjFMI42 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:56:28 -0400
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1A9C9
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:56:27 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1380:0:640:6985:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id 7101A5EA41;
        Tue, 13 Jun 2023 11:56:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OuVqRqpWueA0-PPizOHw9;
        Tue, 13 Jun 2023 11:56:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686646584;
        bh=ySoer8uLfPj0pHoIwfRFyNYawXAfzMHV23tyPdtCBM8=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=LpbdBwqQ7Li4vT8NLeTErRapyXQDSFXqydh49Y/0SpJOPfuB+jspwYFV0O0bdjai2
         LpXv5cVN8TA9TSPzDh0NFDB2X0Ab3V67n0bn77nNhyWeZJOl7VCBQ7XWhHVSdMlna8
         mJ1q8M0M2echVXZQ5KSPAdi2op0OSGS4ChZezv8s=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <975dee84-fa8f-1dbd-a2b8-2aba5a880b60@yandex.ru>
Date:   Tue, 13 Jun 2023 11:56:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
References: <20230608082457.36020-1-dmantipov@yandex.ru>
 <168664549483.24637.5306969377701572999.kvalo@kernel.org>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 1/2] [v3] wifi: rtw89: cleanup private data structures
In-Reply-To: <168664549483.24637.5306969377701572999.kvalo@kernel.org>
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

On 6/13/23 11:38, Kalle Valo wrote:

> Failed to build

Hmm... works for me against upstream at fb054096aea0 using following configuration:

CONFIG_RTW89=m
CONFIG_RTW89_CORE=m
CONFIG_RTW89_PCI=m
CONFIG_RTW89_8852A=m
CONFIG_RTW89_8852B=m
CONFIG_RTW89_8852C=m
CONFIG_RTW89_8852AE=m
CONFIG_RTW89_8852BE=m
CONFIG_RTW89_8852CE=m
CONFIG_RTW89_DEBUG=y
CONFIG_RTW89_DEBUGMSG=y
CONFIG_RTW89_DEBUGFS=y

Dmitry
