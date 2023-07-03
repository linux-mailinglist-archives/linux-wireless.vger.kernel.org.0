Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5C746188
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jul 2023 19:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGCRou (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jul 2023 13:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjGCRoe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jul 2023 13:44:34 -0400
X-Greylist: delayed 532 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 10:44:30 PDT
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6ECE;
        Mon,  3 Jul 2023 10:44:30 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1688405733; bh=+R0Hb8zEZ0NJS2NS5jrb/LeWDYsJVs4ywi0TBqg82Gs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kTU6zVN02QEDyU5Xjv81z4BnAazEhg5v+ovvGVtkQlW8kZ87ZAmJuUZWPrlCCui6R
         OxF+Cu1eigXybXgLuDM7co+BweFLm/k7jRog+lCa1qcetwcpu1BRa/IWo8YHbGm0iw
         z/TnXacPUIoSvulHuySwTcFMFQIDUMYgqejSob10gWCDeNWveSfsbYSrxKlrgAYDng
         HYyrOZgaCAiHfschOC+0mRRUvSbBe1/Vhws4E/0jXov8IK1YWWZelXFqZYyjsUumWl
         XWYCfKfmrsRKrJwtMNgIlglyNdyR55bNtTYfFkpRDCrVNfrIDdajnE71W6Lil8eiHT
         JFFxheprwclWw==
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ath9k: use struct_group() to silence static checker
 warning
In-Reply-To: <6de44cd9-a9a0-4b76-a9b5-a3c37b97f9aa@moroto.mountain>
References: <6de44cd9-a9a0-4b76-a9b5-a3c37b97f9aa@moroto.mountain>
Date:   Mon, 03 Jul 2023 19:35:33 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877crgdhju.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@linaro.org> writes:

> We are deliberately copying both ba_high and ba_low so use a struct
> group to make that clear.  Otherwise static checkers like Smatch and
> Clang complain that we are copying beyond the end of the ba_low struct
> member.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for the fix; however, an identical patch is already queued, here:
https://patchwork.kernel.org/project/linux-wireless/patch/20230620080855.396851-2-dmantipov@yandex.ru/

-Toke
