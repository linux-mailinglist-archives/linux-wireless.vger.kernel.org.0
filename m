Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B879536012
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 13:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351755AbiE0LoN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351822AbiE0Ln7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 07:43:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DDC122B4E
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 04:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC404CE250E
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 11:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACEAC3411C;
        Fri, 27 May 2022 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653651654;
        bh=ZSwn+KFa1dqvaB8GCoSx7stt3z8s8SixrjI2LW5R4BI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rVLmLHxmS6AX9gyD8KLf8GDR5CCyx61fsz21jOTMnPGxH2GLkM+2NVY168wSYkAp1
         VNMVbUnFFWIEuz9Yfom+/pGOePawOQIfKD959Yu1qjl4fg57Zuk2iOwYBJQR8Ftia2
         f/d7kqn1y65jl9Tqo0oKKP/GBk9+0/hLvmVF+0bXvRHRsBAFvghJUfhoOJS/Arl8zW
         Oz84ME383DivHpDrRvDHzEQx3keoltjjA40/ya9O6KqnFJM6NRK2dVbdZKvPQ4IFQf
         A6b20W9MJTmP09H8FGI4tTEv8EhZBPV1dMOTDK0KUaPQLpWNkrI+wdv3JRXLXnqbZ5
         vId/6sj1WsYow==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: libertas: use variable-size data in assoc req/resp cmd
References: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
        <20220525135326.1da8fe36@kernel.org>
        <ba0a2cec6291e700c5854e343cc72cffa249bc3f.camel@sipsolutions.net>
Date:   Fri, 27 May 2022 14:40:50 +0300
In-Reply-To: <ba0a2cec6291e700c5854e343cc72cffa249bc3f.camel@sipsolutions.net>
        (Johannes Berg's message of "Wed, 25 May 2022 23:18:40 +0200")
Message-ID: <87wne7urst.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2022-05-25 at 13:53 -0700, Jakub Kicinski wrote:
>> On Mon, 23 May 2022 18:02:01 +0200 Johannes Berg wrote:
>> > From: Johannes Berg <johannes.berg@intel.com>
>> >=20
>> > The firmware has a 512 limit here, but we use less, so gcc
>> > starts complaining about it:
>> >=20
>> > drivers/net/wireless/marvell/libertas/cfg.c:1198:63: warning: array su=
bscript =E2=80=98struct cmd_ds_802_11_associate_response[0]=E2=80=99 is par=
tly outside array bounds of =E2=80=98unsigned char[203]=E2=80=99 [-Warray-b=
ounds]
>> >  1198 |                       "aid 0x%04x\n", status, le16_to_cpu(resp=
->statuscode),
>> >       |                                                               =
^~
>> >=20
>> > Since we size the command and response buffer per our needs
>> > and not per the firmware maximum, change to a variable size
>> > data array and put the 512 only into a comment.
>> >=20
>> > In the end, that's actually what the code always wanted, and
>> > it simplifies the code that used to subtract the fixed size
>> > buffer size in two places.
>> >=20
>> > Reported-by: Jakub Kicinski <kuba@kernel.org>
>> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>=20
>> Is there a chance to get this into net before the merge window is over?
>>=20
> I guess you can just apply it. Kalle?

Yeah, Jakub can take this directly to net tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

But I can also take this to wireless tree and send a pull request on
Wednesday. Whichever is better for you, just let me know.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
