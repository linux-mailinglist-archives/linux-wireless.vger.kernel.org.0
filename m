Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD88053604B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 13:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351944AbiE0Lse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351936AbiE0Lrz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 07:47:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012E114AF6A
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 04:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB7BB61D19
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 11:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3397DC385A9;
        Fri, 27 May 2022 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653651809;
        bh=W6+Ainh6+lsPiKu1V+0al+xGQAysrEuhpN9Tzm2zZbI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=pwbfK2G/yPk4TX7FmlG+NnooH41pxUrnTA7n1yGqqZfwtgPwT8m7OvgNliuthnkwt
         1UwjOJuc0/GvBOi569KL7WxKLFUeasTIrWXjS6sPV1dgUHFZZ3GJwU/VKnU3NXSm1r
         ViJ82BSjNYCckfujw2MuXiYj05Q+Wpot2/fkcR8J0xapLmk4FQllX5VA/hYLbHTidd
         zMh2Y5kN4mfSDrVMFUhnzvm+xAGvnusXNjoIFFBH59TcZvnRsPsG/c8qKe339p9qWi
         sD+rA5AQde47QjEKBNsTfORHlQrHhZjU4kI7lDwpxq2hKO9rN9rVCbPLyxvjwm3Zqv
         otp0HsE3njbCQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] wifi: libertas: use variable-size data in assoc req/resp cmd
References: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
Date:   Fri, 27 May 2022 14:43:26 +0300
In-Reply-To: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
        (Johannes Berg's message of "Mon, 23 May 2022 18:02:01 +0200")
Message-ID: <87sfovuroh.fsf@kernel.org>
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

> From: Johannes Berg <johannes.berg@intel.com>
>
> The firmware has a 512 limit here, but we use less, so gcc
> starts complaining about it:
>
> drivers/net/wireless/marvell/libertas/cfg.c:1198:63: warning: array subsc=
ript =E2=80=98struct cmd_ds_802_11_associate_response[0]=E2=80=99 is partly=
 outside array bounds of =E2=80=98unsigned char[203]=E2=80=99 [-Warray-boun=
ds]
>  1198 |                       "aid 0x%04x\n", status, le16_to_cpu(resp->s=
tatuscode),
>       |                                                               ^~
>
> Since we size the command and response buffer per our needs
> and not per the firmware maximum, change to a variable size
> data array and put the 512 only into a comment.
>
> In the end, that's actually what the code always wanted, and
> it simplifies the code that used to subtract the fixed size
> buffer size in two places.
>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Can we now remove the no-array-bounds hack from libertas?

+# FIXME: temporarily silence -Warray-bounds on non W=3D1+ builds
+ifndef KBUILD_EXTRA_WARN
+CFLAGS_cfg.o +=3D -Wno-array-bounds
+endif

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
