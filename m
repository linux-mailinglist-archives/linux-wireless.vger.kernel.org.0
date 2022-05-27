Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11C4536244
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 14:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349859AbiE0MXX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 08:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352420AbiE0MWi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 08:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA8916F91C
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 05:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84EC161A34
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 12:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269BEC385A9;
        Fri, 27 May 2022 12:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653652970;
        bh=GMhroN9tgfWna+E3OeugTh5Q+3jOGLhGKI0Khu3t3Ic=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gzL2AAtWkylgQkiMxmK4zH9DiEcrZi/5i2y4OKoaI8ZZaA1gTcmrOc5ijLnHSR80p
         T6oc6kL1hV2/F2EomdXdsmOyIc1IY+ZnGL+wuJBFR3RG9UlpZhePJaEAhieY8gzVBk
         1KX5AOKLFGtGUkuBjCit9vy+7hTOaziSN7Bf2VvOOr/3Ba9Te6R06EZ9mXAv1jEf35
         +MYewqDz/ZyyQfeus9mYHnhgM9VErEPQCPL/289OntD4KPS0Qql3I+UJQXfYDawOkl
         tNTsGussxoyJBEaCveomxxP+TM99XNh0/v4Kzu2onnJKn/6PRVm+6VMfWjjd0DXTYV
         uu2BxsApD/QpA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] wifi: libertas: use variable-size data in assoc req/resp cmd
References: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
        <87sfovuroh.fsf@kernel.org>
        <c5fe3475cdfbe2633e965682ac41db5e61271411.camel@sipsolutions.net>
Date:   Fri, 27 May 2022 15:02:47 +0300
In-Reply-To: <c5fe3475cdfbe2633e965682ac41db5e61271411.camel@sipsolutions.net>
        (Johannes Berg's message of "Fri, 27 May 2022 13:44:01 +0200")
Message-ID: <87r14fp4ig.fsf@kernel.org>
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

> On Fri, 2022-05-27 at 14:43 +0300, Kalle Valo wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>>=20
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
>> Can we now remove the no-array-bounds hack from libertas?
>>=20
>
> I think Jakub said he dropped it from the patches?

Ah, indeed. I missed that, sorry for the noise.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
