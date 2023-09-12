Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9879D778
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 19:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbjILRX1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Sep 2023 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjILRXZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Sep 2023 13:23:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3610D9
        for <linux-wireless@vger.kernel.org>; Tue, 12 Sep 2023 10:23:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E186CC433C7;
        Tue, 12 Sep 2023 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694539401;
        bh=G1we36iGe4CkE77od0JjjgAzmx37GrnqdGoAlnxSogI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NKHNb2llGzM8Ee6aHjVa5dQWPVjZJO+2DtsIwhim41WoAwOnMpeS1mmVS4GVAWowm
         H3zCAAXXyzkrhcIQTMlnmpaFxT6knrCJE3PzMm76nbqQopf9dOLNMTJ2cMevqwM28r
         R8BfOaSt9iDyQkTiprd4aNA88knZceS/6t4dvt0amYBL8qw0mwfgUeLw7uASRY/cbi
         SnriFJ9VMKa2Rs5Pd8dVgfatk4isTjbgS47ZAF8RUst29l/CF+r+A8sr/FOVzrSzeC
         NJL4jP8yGRac1VcQUgzFlstQi46AiINqFRooXMKA1sZ/e8QNbMTueRPUXEhQ638Ju2
         a/XyMzs9p+n3g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-wireless@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next] wifi: ti/wlcore: Convert to platform remove
 callback returning void
References: <20230912171249.755901-1-u.kleine-koenig@pengutronix.de>
Date:   Tue, 12 Sep 2023 20:23:18 +0300
In-Reply-To: <20230912171249.755901-1-u.kleine-koenig@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 12 Sep 2023 19:12:49
 +0200")
Message-ID: <87sf7jcnll.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code.  However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> wlcore_remove() returned zero unconditionally. With that converted to
> return void instead, the wl12xx and wl18xx driver can be converted to
> .remove_new trivially.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/net/wireless/ti/wl12xx/main.c   | 6 +++---
>  drivers/net/wireless/ti/wl18xx/main.c   | 2 +-
>  drivers/net/wireless/ti/wlcore/main.c   | 6 ++----
>  drivers/net/wireless/ti/wlcore/wlcore.h | 2 +-
>  4 files changed, 7 insertions(+), 9 deletions(-)

wireless patches go to wireless-next, not net-next. But no need to
resend because of this.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
