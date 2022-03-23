Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E54E523C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 13:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242110AbiCWMg3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 08:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCWMg3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 08:36:29 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699EA140A6
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 05:34:58 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1648038897; bh=ynLlvBFbAghLbTzC3nZ4wJLUSewy18DQiGfQ7N/C3iY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TgwfCq3bvWYz6sSN3v9q/RyWdLvND/J6AXiDbepeNIfKUaptEPc4znX696AQGqBq0
         L6F3MkSxd7cxSgyKOYvRGIaGsB+XOw93ISz886W75BCXwv6EPfCLvmwtM5IV6jmYXH
         KEBTODO8HbRrJ6je4FUHD/V+x8G2kviDnoLzwDo8drvYwW1F+w1jJjVjGV+n7GP3Iy
         LyTotZ3kWI1Ug3bz1giQuZQCmtx6/4/qr6vpeT31nj5WIDP3bZTMP7IjAXS6k+DElf
         636DU9XBbLYhGtYEl/HYGPu1raCwQ5H3AMhP97sElh3maCDB/V3cclMo+D3pfP3yC3
         QYOY58DGxRh3Q==
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Wenli Looi <wlooi@ucalgary.ca>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 4/6] ath9k: fix ar9003_get_eepmisc
In-Reply-To: <87pmmckgnp.fsf@kernel.org>
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
 <20220320233010.123106-5-wlooi@ucalgary.ca>
 <8735j9vww4.fsf@tynnyri.adurom.net> <87v8w4api4.fsf@toke.dk>
 <87pmmckgnp.fsf@kernel.org>
Date:   Wed, 23 Mar 2022 13:34:56 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87sfr8alu7.fsf@toke.dk>
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
>>> Wenli Looi <wlooi@ucalgary.ca> writes:
>>>
>>>> The current implementation is reading the wrong eeprom type.
>>>>
>>>> Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving
>>>> the eepmisc value")
>>>> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
>>>
>>> The Fixes tag is wrong, I fixed it in the pending branch.
>>
>> Ah, oops, my bad for not catching that; thanks for the fixup! :)
>
> No worries, I'm using Stephen's script which check that :)

Ah yes, I thought I recognised the format of the notice ;)

-Toke
