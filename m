Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E41A7196A7
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjFAJRz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjFAJRv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 05:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B094C97
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 02:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40CA164259
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 09:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02B0C433D2;
        Thu,  1 Jun 2023 09:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685611069;
        bh=q0CJdSwXOIJZvPvJU/z1sdvR3U3gXtkEs4k/nknZCKE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Pu4TajYAxmVtPK8l64pTxUbVC50dU99ybV9kjG4vUZuzP1MTiXLq4ebRN9JEswJPC
         9gqrdWezwjMfxd3n8dW2tpct1bHWQ4u/93au/v8Ux9Tn2lMsGg9DtedCWXQrl0L6Dy
         70unoZ4Q5hx+1uCP5TK8MUelatzwOkP2LxASzUrk8EcPyukgPdwemfpC9dCCW9NZ+Z
         7BXfENmmF9ewBz4RvAlGyhE6Gzqcy9lX8vR7qfkUcC/Fx3WeoO9RGi2Op2l7NOyd09
         evmmFrp0BeDKZlLbqrbIBAgIRIK5LA9G73XQTjOEdbjz5+P4Vl+3A7uUQn4xvZbxrO
         uzmTG7QxQxGsQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/4] Convert to platform remove callback returning void
References: <20230601082556.2738446-1-u.kleine-koenig@pengutronix.de>
Date:   Thu, 01 Jun 2023 12:17:44 +0300
In-Reply-To: <20230601082556.2738446-1-u.kleine-koenig@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Thu, 1 Jun 2023 10:25:52
 +0200")
Message-ID: <87h6rrk0cn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> the motivation for this series is patch #3, patch #2 is a preparation for=
 it
> and patches #1 and #4 are just cleanups that I noticed en passant.
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (4):
>   ath10k: Drop cleaning of driver data from probe error path and remove
>   ath10k: Drop checks that are always false
>   ath10k: Convert to platform remove callback returning void
>   atk10k: Don't opencode ath10k_pci_priv() in ath10k_ahb_priv()
>
>  drivers/net/wireless/ath/ath10k/ahb.c  | 20 +++-----------------
>  drivers/net/wireless/ath/ath10k/snoc.c |  8 +++-----
>  2 files changed, 6 insertions(+), 22 deletions(-)

ath10k patches go to my ath.git tree, not net-next. Also "wifi:" is
missing from the title but I can add that.

No need to resend because of these.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
