Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC76698E2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 14:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbjAMNmt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 08:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbjAMNmF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 08:42:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFC3D1DA
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 05:35:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1957661D3B
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 13:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A75C433AC;
        Fri, 13 Jan 2023 13:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673616957;
        bh=0VUYSRdY8EWQcNYqlZI+gsBHhOOxM1wVAQO1t2nBgcU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oNWS2w2DhC0FgaOo8rv2hy0LVnpJPGf5baCrdaj4pSJWvC2Kf+sLpLi7X/T1Pacpt
         ACPag5NiS05XKb7iVJDKGu8pfpFdMlonQQSX034kFJe3bcUxjTsf4PojgQFlXJroS8
         BCXXvfByzyJtmbBYKgysmcugqH2p9fXeNxN/fZh6j9JKyKCUad6zA3ITJgub/1DLJO
         QHowe64uq9a4v/SgMMnOlPylQsFi5obz3LrAJMgsvpXN86EvgfFzEeMxz0ia5RrcHM
         It1uSUA5b0y/wzzg2Lr4/cDK8WqUFZcAchoC4TGYpJCfqzgeauR8FPXs2EIFkKUylU
         u/xl93hdQ2MKQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: brcmfmac: Unexpected cfg80211_set_channel: set chanspec ... fail, reason -52
References: <2635fd4f-dfa0-1d87-058b-e455cee96750@i2se.com>
        <1f428e2b-f73f-64ff-02d3-eefbcd11db89@broadcom.com>
        <ee24c4eda8d389ac7197b6296944e168ccc6b602.camel@sipsolutions.net>
Date:   Fri, 13 Jan 2023 15:35:51 +0200
In-Reply-To: <ee24c4eda8d389ac7197b6296944e168ccc6b602.camel@sipsolutions.net>
        (Johannes Berg's message of "Tue, 03 Jan 2023 08:07:41 +0100")
Message-ID: <878ri6d0aw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

>> > [=C2=A0 104.897615] brcmfmac: cfg80211_set_channel: set chanspec 0x100=
e fail,=20
>> > reason -52
>
> [...]
>
>>=20
>> > All of these 10 errors are repeated every 60 sec.
>>=20
>> Catching up after the holidays ;-) Above chanspec values are invalid.=20
>> 0x100e =3D channel 14/bw 20MHz. The 'iw list' output shows all these=20
>> channels are disabled. So who/what is trying to set these channels.=20
>> Scanning sets the channel in firmware. Is this initiated from hostapd?=20
>
> Yeah, what userspace is running here? Looks like cfg80211_set_channel()
> is only used for survey?
>
> Couple of observations on the side:
>  * might be nice to have some "brcm" indication in that name :P

Indeed, having a function cfg80211_set_channel() in brcmfmac/cfg80211.c
is VERY misleading. I first though that is a cfg80211 function and
didn't understand Johannes' comment until I started grepping :) Can
someone fix that, please?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
