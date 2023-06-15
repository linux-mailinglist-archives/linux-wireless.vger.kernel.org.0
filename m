Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE96731282
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 10:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245146AbjFOInp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 04:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238198AbjFOInX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 04:43:23 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2462942
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 01:43:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2d2c:0:640:8fff:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 38E5D6E3D1;
        Thu, 15 Jun 2023 11:30:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rUXJKb9DV0U0-5Vf7gV7x;
        Thu, 15 Jun 2023 11:30:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686817853;
        bh=/liri3UZbGJ2KsypG4Ag5N4yIol72rCbP647zEmQ4/c=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=HkpX3NGwE71T9l0Pg6xKVfe9j7AW8thG0o9JIC2clnVUPcXTgycM53nDHabaRM2dY
         urg0CEw6svBqVjdPqUjL4OQ+SPuLscK8OauPR2FQUAiHWv+2TcfSI3wR19P2HOvNT5
         e002pj4Gc+ju1ZwBpTfJFSnAJgw9zSTOAP3s7cOo=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <4eb7080b-34f6-af68-6bf1-8b767d59ed61@yandex.ru>
Date:   Thu, 15 Jun 2023 11:30:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230607161611.85106-1-dmantipov@yandex.ru>
 <168681437386.8111.5132863492672751351.kvalo@kernel.org>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 1/3] wifi: brcmfmac: handle possible WOWL configuration
 error
In-Reply-To: <168681437386.8111.5132863492672751351.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/15/23 10:32, Kalle Valo wrote:

> This patchset feels like random cleanup which makes me wary

Note series v2 was posted a few days ago.

> How are these 3 patches tested?

It was quickly checked to not break (cheap noname) BCM43236-based
USB Wi-Fi adapter I occasionally have.

Dmitry

