Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072797318F5
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbjFOM1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240094AbjFOM1C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 08:27:02 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E443D1FE5
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 05:26:58 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1686832016; bh=p2JLR7eyq01/9LwarS3LHAUpoOAFYw45kGwkior1nBQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=wZaYxj4t35pT4fSuD75cWoRyumlNt1uky7QihvJZ9XfDNtr7RXz/M8yX9GkKfFe23
         qFCjstYDZfADu4JBSaZjE9lha5hQ5fB9RNJc9GBiDkLqhrQemu8sdn5bY8TLArP1+e
         IoNdDaoTTLwbr8pvv5tFs36eiXt7EMzWNJS28S9KbAjkHzcqrJkknQMDb5hPzPyiuq
         B52fAsW+iBpFkv+ByvGFra8d7i+80Y3ONHxF/3XPbIZmI0APcvPfMQ96SUs5dwXrWZ
         Pd1YJuc0ApZtuLg9RF6AI4o5uWPaw4WE/XeXfeNFM41oB4OidSZH+Gx2jPvNuXp9XJ
         Ozw8hJ/mnSZaw==
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: convert msecs to jiffies where needed
In-Reply-To: <878rcmf7jt.fsf@kernel.org>
References: <20230613134655.248728-1-dmantipov@yandex.ru>
 <87y1knw7ng.fsf@toke.dk> <87pm5yd3rz.fsf@kernel.org>
 <87a5x2l1bt.fsf@toke.dk> <878rcmf7jt.fsf@kernel.org>
Date:   Thu, 15 Jun 2023 14:26:55 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y1kkgbcg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>
>> Kalle Valo <kvalo@kernel.org> writes:
>>
>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>>>
>>>> Dmitry Antipov <dmantipov@yandex.ru> writes:
>>>>
>>>>> Since 'ieee80211_queue_delayed_work()' expects timeout in
>>>>> jiffies and not milliseconds, 'msecs_to_jiffies()' should
>>>>> be used in 'ath_restart_work()' and '__ath9k_flush()'.
>>>>>
>>>>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>>>>
>>>> I believe this warrants a:
>>>>
>>>> Fixes: d63ffc45c5d3 ("ath9k: rename tx_complete_work to hw_check_work")
>>>
>>> I can add that.
>>
>> I was hoping you'd say that - thanks :)
>
> BTW you can always assume that I can change or fix the commit messages.
> Just let me know exactly what to change, being able to copy paste is
> best :)

ACK :)

-Toke
