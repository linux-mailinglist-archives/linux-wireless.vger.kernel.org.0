Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D95B737DA4
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjFUIco (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 04:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFUIci (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 04:32:38 -0400
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAAE186
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 01:32:29 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:6284:0:640:826e:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id 88F9F5F21A;
        Wed, 21 Jun 2023 11:32:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PWddPfQWouQ0-cWDHQOet;
        Wed, 21 Jun 2023 11:32:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687336346;
        bh=oghJorLXyGpZkR6+AUlhJDyc66XsFU4ZskxeabE7VQI=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=l9oRvTRRsMWxiHHcsG8bG6QU3FULooa59EQaTnym5Bvl2NSIElGCYB8viUkatfkhf
         /s3oHamnFtQqJk9/oz8a2TCfJxg9lMDvj+So5AWIsZlgGRo9/ozxT094ul+of89y0A
         VStvxfjMxEKMwmeHMNexRa/XQucbKR4vCucRfQsY=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <a1f55197-6138-68d0-9e4f-8e53840d5d90@yandex.ru>
Date:   Wed, 21 Jun 2023 11:32:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>
Cc:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
References: <20230620100803.519926-1-dmantipov@yandex.ru>
 <20230620100803.519926-2-dmantipov@yandex.ru> <ZJHTLhQNM4oj40Zn@google.com>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 2/2] [v2] wifi: mwifiex: fix fortify warningg
In-Reply-To: <ZJHTLhQNM4oj40Zn@google.com>
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

On 6/20/23 19:26, Brian Norris wrote:

> This invocation seems a bit suspect, as it uses a 'sizeof' of a field
> that doesn't match the actual pointer (it's off by 1 byte), but that's
> not your fault. I suppose it's no wonder we had so many problems with
> TDLS support on mwifiex...

Hm, ieee80211_prep_tdls_direct() seems takes this byte into account. But
do you know why 'u.action.u.tdls_discover_resp' is ended with a flexible
array, e.g.:

struct {
	u8 action_code;
	u8 dialog_token;
	__le16 capability;
	u8 variable[0];
} __packed tdls_discover_resp;

Dmitry
