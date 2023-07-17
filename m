Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A623D756152
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGQLQR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 07:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGQLQQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 07:16:16 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C408E58
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 04:16:14 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2ea0:0:640:886e:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id B161C5EBB7;
        Mon, 17 Jul 2023 14:16:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AGdqt4eDbGk0-yPOv7O8w;
        Mon, 17 Jul 2023 14:16:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1689592571;
        bh=NrALcP/+/jMKHqUVG2Tu6ZCyPfPj55L/TozlRIOWfI8=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=IcI8y1lFZT/l87zBddWNMc/lCNdxMnlAa7OMRvLrClXts1zU33FxDBzxxiPo5QjkX
         AO/jEmgc49uXZAaFsDW9S0c6ogKC5Aixs+Rp6Lrj2GnYo8xYp0SjYj4im79KiFRk4/
         W/KsuX+qwPRPTE78dBs+yxFcmsBfdTQ0O7VqXsKU=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <c5b6d5a3-1c37-68a5-1b06-6b4bf90e94d9@yandex.ru>
Date:   Mon, 17 Jul 2023 14:16:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: mt76: use native timestamps for RX reordering
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
References: <20230712173437.162921-1-dmantipov@yandex.ru>
 <be80dd0f-a266-4666-4987-0659ca0449f3@nbd.name>
From:   Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <be80dd0f-a266-4666-4987-0659ca0449f3@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/14/23 12:10, Felix Fietkau wrote:

> Why?

1) 'unsigned long' is a native kernel way to manage jiffies and 2) comment
above 'time_after32()' states that this is a quirk for the cases where some
data format explicitly dictates using of 32-bit values.

Dmitry
