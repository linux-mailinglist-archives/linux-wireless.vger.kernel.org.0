Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1612761DA2
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjGYPuj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjGYPui (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 11:50:38 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB8B2102
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 08:50:34 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:7e9c:0:640:587e:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 94BEF5F195;
        Tue, 25 Jul 2023 18:50:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UoMH6SeDeW20-8lTJMnqh;
        Tue, 25 Jul 2023 18:50:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690300231;
        bh=PW3IuPT/nwRV0GUOG3pBA/3ZHuyXL8gTX67hcq44NKA=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=VGpo0CmgI6X1qE767wSePiAO7HBx0UBy2JdGYuAZ4wyzAa9Ynwfho1B5R0rwnTup8
         NxEoUcw5mylJ+5fk9YoxiqrfkK9fZhQPQKWUIgU728ygkJqGTObXdsDrUg8UOxNZH3
         K6k7zf0s2guXfMXerpb5wxTsY74W5NFH4ZXzVWxg=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d8f5991d-d3cd-4f15-ada7-53d3b93e07e3@yandex.ru>
Date:   Tue, 25 Jul 2023 18:50:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Ajay.Kathat@microchip.com
Cc:     Amisha.Patel@microchip.com, linux-wireless@vger.kernel.org
References: <20230713082616.112160-1-dmantipov@yandex.ru>
 <df4db7fe-b51d-5eba-dd9d-527753903eac@microchip.com>
 <87r0ow111o.fsf@kernel.org>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: wilc1000: simplify TX callback functions
In-Reply-To: <87r0ow111o.fsf@kernel.org>
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

On 7/25/23 18:08, Kalle Valo wrote:

> There was no response from Dmitry but I suspect this was not tested on a
> real device. Submitting patches like this without any real testing is a
> bad idea as the risk of regressions is high. Please _always_ test
> patches on a real device. Only exception are trivial patches which can
> be easily reviewed.

Note there was a 2nd version of this, see
https://patchwork.kernel.org/project/linux-wireless/patch/20230717084400.57882-1-dmantipov@yandex.ru.
I'm not insisting on accepting this patch as is, but hope that developers at
Microchip should be capable to consider it for their next major driver update.

Dmitry

