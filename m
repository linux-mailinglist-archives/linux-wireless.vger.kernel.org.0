Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDCE73019E
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245547AbjFNOWF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245544AbjFNOWD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 10:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9FC10CB
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 07:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4463A6366A
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 14:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47A2C433C8;
        Wed, 14 Jun 2023 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686752521;
        bh=GfQJxl85hzKrEjkYhXQ3HB9Y5yFJayBpHrbM0fIs25E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=tPKRIBRjYs+mehBhz3KfiPFDcNxPcjHuJg5tHglpb5qU9TocepAuSuHt2yIfZNaNz
         peHoTGYOVfrauooqK1I2rzr6GyKbandGK2FrBMMl3+uwCKoZpQ67TCBXRFOwxaFzNC
         iODbtPU7R84UN/CE0fz7grfkdmNnjHTsCly2rUo81L9LTkZYgJDVNPzPL4QA0pdQfl
         zxc6pQioHDu0zgZT+1ab3R2ZcKunitTIdi7C1e5mDLm3Q9qG+Ft2hqr+lU1SoMobnZ
         d4WNMU0LIjbU9HKW4yzlHYiST9VpCWjwE7EJ2HWZjqGOY0puHapoJ/4SkxSWZUrgMt
         sjMe3ptBf6+Gw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: convert msecs to jiffies where needed
References: <20230613134655.248728-1-dmantipov@yandex.ru>
        <87y1knw7ng.fsf@toke.dk> <87pm5yd3rz.fsf@kernel.org>
        <87a5x2l1bt.fsf@toke.dk>
Date:   Wed, 14 Jun 2023 17:21:58 +0300
In-Reply-To: <87a5x2l1bt.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Wed, 14 Jun 2023 13:39:50 +0200")
Message-ID: <878rcmf7jt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>>
>>> Dmitry Antipov <dmantipov@yandex.ru> writes:
>>>
>>>> Since 'ieee80211_queue_delayed_work()' expects timeout in
>>>> jiffies and not milliseconds, 'msecs_to_jiffies()' should
>>>> be used in 'ath_restart_work()' and '__ath9k_flush()'.
>>>>
>>>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>>>
>>> I believe this warrants a:
>>>
>>> Fixes: d63ffc45c5d3 ("ath9k: rename tx_complete_work to hw_check_work")
>>
>> I can add that.
>
> I was hoping you'd say that - thanks :)

BTW you can always assume that I can change or fix the commit messages.
Just let me know exactly what to change, being able to copy paste is
best :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
