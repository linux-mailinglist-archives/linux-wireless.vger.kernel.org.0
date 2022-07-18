Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C126A578831
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jul 2022 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiGRRSI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jul 2022 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGRRSI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jul 2022 13:18:08 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA6B2C135
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 10:18:06 -0700 (PDT)
Date:   Mon, 18 Jul 2022 17:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail3; t=1658164684; x=1658423884;
        bh=jirZHvt4u1Kp6psm5UkIeThesuuC9ZjPIZfQ3IjOwbM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=d4HEFVsPaL0SP+Czkm059MR65JsnZCGCw5UOlGDFhl8dNaDvVipUow0s3Y9ciVlXV
         Pxz8cDO/DubDyOVvCrx0p67/EHoR4dUfA+DgbQ1mWTU7upSK5BfPB3C62m6A1ZA6n9
         SFOj7/zBWE0vD6+FlJzLNyxAOwxP/9zBog6a41qFdCxQ5vhrE/Pe2wHtJc8A240ybk
         SeJvcyMcy182mg5XKoB4O+/Rh7G6jS/YKk91apORJhuAuHuglVTDoGg0GulshkhsNL
         A6yxHjB8xGZD6hI+eH8eu+CJ1JlNvR6gcolLrUJnYef4LMWOpZyWhXjE/b0ROvcV0u
         3GSt9tV+2Je/g==
To:     Ulf Hansson <ulf.hansson@linaro.org>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH v5] brcmfmac: prevent double-free on hardware-reset
Message-ID: <Jf288fBmG7i8omrWIg5n1dG3Ei2z8Cc-sPjQGVhBHbeHxN8OZYfMhPNX4kop3CpXz4dh7FBKtw-t29PO0MhIthA_030s1GhpnMlKjnAeies=@dannyvanheumen.nl>
In-Reply-To: <CAPDyKFpa6Z0Uhb0OnhMJ-KTQg5CQW93KMz1j1cQJS-Ho8FVhmQ@mail.gmail.com>
References: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl> <CAPDyKFpa6Z0Uhb0OnhMJ-KTQg5CQW93KMz1j1cQJS-Ho8FVhmQ@mail.gmail.com>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

------- Original Message -------
On Thursday, July 14th, 2022 at 12:04, Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:

> [..]
>
> That said, I think the $subject patch looks reasonable to me. So feel
> free to add:
>
> Reviewed-by: Ulf Hansson ulf.hansson@linaro.org

I am a first-time contributor. Is this your way of saying that I should sub=
mit
the patch somewhere other than 'linux-wireless@...'? I suppose this fix is =
not
urgent enough for 'stable@...', or is it?

I would appreciate information on who will and/or how to follow-up.

Regards,
Danny

