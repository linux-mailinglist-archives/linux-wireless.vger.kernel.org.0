Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292C450491F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Apr 2022 21:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiDQTDL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Apr 2022 15:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiDQTDJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Apr 2022 15:03:09 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E4521827
        for <linux-wireless@vger.kernel.org>; Sun, 17 Apr 2022 12:00:31 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1650222029; bh=da1glS5y9kddgRxnHcvX9Fq04L0glAsQCSGMj80lJdc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X05BoVodvwTY6v8ujUwd36jrghshdJzXx/xYYa4wEcVN1NI1sevV0zDjcLTdspi1u
         dqfW0Ui5KHwNdKcpKWyocpNoEB2Cfw53DHRiTFQ5/MgeYIsQ6hWFWYJPs6x4qu1Buf
         Ug4f/y5hIuQvdSvc05GVWqLLA5uI9vhyoJpLx+8ZwVUYfGBBu4bGl+fMPauRAF+2rs
         Sac0bSFGvjV3Mi52k5cd5zHnC+ae6vtoPyS2LfuycBovFTikwzeHbPquMkWUY+S4OZ
         +/EspqxOPQPdYqZKYTbwSCjA5aCJHBUXAIHegUri6PjFZnZwkreGqPXbTNCx0U5+mS
         Ds5Q42HX1TRoQ==
To:     Thibaut =?utf-8?Q?VAR=C3=88NE?= <hacks+kernel@slashdirt.org>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Clemens Hopfer <openwrt@wireloss.net>,
        Thibaut =?utf-8?Q?VAR=C3=88NE?= <hacks+kernel@slashdirt.org>
Subject: Re: [PATCH v2] ath9k: fix QCA9561 PA bias level
In-Reply-To: <20220417145145.1847-1-hacks+kernel@slashdirt.org>
References: <EC4F8380-4725-441D-B3FF-8CD7048F2236@slashdirt.org>
 <20220417145145.1847-1-hacks+kernel@slashdirt.org>
Date:   Sun, 17 Apr 2022 21:00:28 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ilr73583.fsf@toke.dk>
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

Thibaut VAR=C3=88NE <hacks+kernel@slashdirt.org> writes:

> This patch fixes an invalid TX PA DC bias level on QCA9561, which
> results in a very low output power and very low throughput as devices
> are further away from the AP (compared to other 2.4GHz APs).
>
> This patch was suggested by Felix Fietkau, who noted[1]:
> "The value written to that register is wrong, because while the mask
> definition AR_CH0_TOP2_XPABIASLVL uses a different value for 9561, the
> shift definition AR_CH0_TOP2_XPABIASLVL_S is hardcoded to 12, which is
> wrong for 9561."
>
> In real life testing, without this patch the 2.4GHz throughput on
> Yuncore XD3200 is around 10Mbps sitting next to the AP, and closer to
> practical maximum with the patch applied.
>
> [1] https://lore.kernel.org/all/91c58969-c60e-2f41-00ac-737786d435ae@nbd.=
name
>
> Signed-off-by: Thibaut VAR=C3=88NE <hacks+kernel@slashdirt.org>

Thank you for the fix!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
