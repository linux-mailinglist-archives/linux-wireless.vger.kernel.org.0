Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95543504815
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Apr 2022 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiDQOt0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Apr 2022 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQOtZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Apr 2022 10:49:25 -0400
Received: from vps.slashdirt.org (vps.slashdirt.org [144.91.108.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32E9644B
        for <linux-wireless@vger.kernel.org>; Sun, 17 Apr 2022 07:46:48 -0700 (PDT)
Received: from smtpclient.apple (tardis.herebedragons.eu [171.22.3.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vps.slashdirt.org (Postfix) with ESMTPSA id 27A4960029;
        Sun, 17 Apr 2022 16:46:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 vps.slashdirt.org 27A4960029
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=slashdirt.org; s=mail;
        t=1650206806; bh=Wn2UhQpIh6kaFXN4J0iyHm1Rvy3slXa4tCoWY/WrbdY=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=y8cpEBepbQofpYBEzwGpOR9Pst7jgVymhMTjs7nfcm8ivAbj/vjudTzfURADVgzwM
         bWveT7EUN/HwSCK0LS/lm6rPJ/g58y40BDLytcPTMIWYJ3p44wpZGbyAj4Yq1NLWL0
         fF3ajk0RpdpJftYHNcpbKIw4TlFiy2Xg4qFkmpXw=
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] ath9k: fix QCA9561 PA bias
From:   =?utf-8?Q?Thibaut_VAR=C3=88NE?= <hacks+kernel@slashdirt.org>
In-Reply-To: <91c58969-c60e-2f41-00ac-737786d435ae@nbd.name>
Date:   Sun, 17 Apr 2022 16:46:43 +0200
Cc:     =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        =?utf-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Clemens Hopfer <openwrt@wireloss.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC4F8380-4725-441D-B3FF-8CD7048F2236@slashdirt.org>
References: <20220415104419.22749-1-hacks+kernel@slashdirt.org>
 <91c58969-c60e-2f41-00ac-737786d435ae@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Le 16 avr. 2022 =C3=A0 20:39, Felix Fietkau <nbd@nbd.name> a =C3=A9crit =
:

> The patch looks wrong to me. I'm pretty sure that AR_CH0_TOP2 is the =
correct register, the definition has an explicit check for 9561 as well.
> I believe this patch works by accident because it avoids writing a =
wrong value to that register.
> The value written to that register is wrong, because while the mask =
definition AR_CH0_TOP2_XPABIASLVL uses a different value for 9561, the =
shift definition AR_CH0_TOP2_XPABIASLVL_S is hardcoded to 12, which is =
wrong for 9561.
> Please try adjusting it to this:
> #define AR_CH0_TOP2_XPABIASLVL_S (AR_SREV_9561(ah) ? 9 : 12)

This works, thanks. I=E2=80=99ll submit a v2 now.

Thibaut=
