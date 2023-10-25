Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C229C7D663A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjJYJHm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJYJHk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 05:07:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D5AB9
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 02:07:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96764C433C8;
        Wed, 25 Oct 2023 09:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698224857;
        bh=4G01akPkyEPijEtE2W13lSkia+1tlCXbjiVbzylr19M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YJommjB41w5Ed2UcL2OBN7HGNrPUetS4/1kqt2iwBzwR6JzfFo4CorYiWWiaOCuDW
         9iciRu3mXHAhik+e+/jx1ZJ9pvsrIZ5XSzAz0UMbElIaptmoGgSdqIsvyPN+FzdTiM
         3dOoBIjXjznI6KjGMmGGY1DyglHUa6h/GOsEzfxa5TyU7DJN/zetbP4at80ZUBcOmc
         E3aHL44Xf0HMPAN2eMFhOnJ/RP3jHFTuoSq90S2ax1I+dbQHA5/FcmA82HuAZjRRHn
         xY5BJWnZ5/OB6hnmqqws6cMveU9FUYoKJ6zLjikhXN6OfR2ECUPSb9N5bFb/8Ur4Yn
         t29xnRHzEQvLg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 1/3] wifi: rt2x00: improve MT7620 register
 initialization
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <TYAP286MB031553CCD4B7A3B89C85935DBCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: <TYAP286MB031553CCD4B7A3B89C85935DBCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169822485445.836535.2990258505958425099.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 09:07:36 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shiji Yang <yangshiji66@outlook.com> wrote:

> 1. Do not hard reset the BBP. We can use soft reset instead. This
>    change has some help to the calibration failure issue.
> 2. Enable falling back to legacy rate from the HT/RTS rate by
>    setting the HT_FBK_TO_LEGACY register.
> 3. Implement MCS rate specific maximum PSDU size. It can improve
>    the transmission quality under the low RSSI condition.
> 4. Set BBP_84 register value to 0x19. This is used for extension
>    channel overlapping IOT.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

3 patches applied to wireless-next.git, thanks.

1ffe76d5ae78 wifi: rt2x00: improve MT7620 register initialization
a28533c6be17 wifi: rt2x00: rework MT7620 channel config function
cca74bed37af wifi: rt2x00: rework MT7620 PA/LNA RF calibration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB031553CCD4B7A3B89C85935DBCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

