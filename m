Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B845F455D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 16:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJDOWP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 10:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJDOWL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 10:22:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCED8220E0
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 07:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AA24B81AFB
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 14:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F718C433C1;
        Tue,  4 Oct 2022 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664893328;
        bh=JoGJygE4MFzKauBoMrgTzJ8z3YQKwR8zMoNj6Xhtc7k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=k2JDndwkLFjsm/ntbcQWE2MEtbtnxBYssyU+mNdAXNyT96dheG3D/yr+FwSwUsuiw
         iRTGRmd4CcC4I00EDoD9mnp1Zgm8dyMlOdM1z4X5TH5WD42BUjf+puuu969UW0jguP
         we1P1fhuEfWA8AOF4qBIoOgt1uz+jehBdVP+Xn51XkHbbfhJekG4S7h7Am/qaVVZvC
         3M5W0I4zQv0bgRm+b6GrChxK2RPVWH5CI+u47veZUeHdV5tPne2E3lKBDS9SJOYa1F
         muQHaTKhGwxhIsTzETe3BdHLISPUh9JZDvR4FiqMmt8q8xhlnyEen1HSoOYwdMIWXP
         4qUCGS/2o80cw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C2DD264E9DB; Tue,  4 Oct 2022 16:22:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Wireless workshop at Netdevconf 0x16, Lisbon 2022
In-Reply-To: <8735c3r8wt.fsf@kernel.org>
References: <8735c3r8wt.fsf@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 04 Oct 2022 16:22:05 +0200
Message-ID: <871qrnk6sy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> We're going to hold a Wireless workshop during Netdevconf 0x16 in
> Lisbon, Portugal:
>
> https://netdevconf.info/0x16/session.html?Wireless-Workshop
>
> The schedule is not published yet but we have requested it to be on
> Tuesday October 25th, though the date will be confirmed once the
> schedule is publically available.
>
> As usual we have set up a wiki page for the event:
>
> https://wireless.wiki.kernel.org/en/developers/summits/lisbon-2022
>
> Everyone are welcome to join, but a registration to the conference is
> required. We ask people to add their name to the wiki if you are
> planning to come. Feel free to add any topics you want to discuss,
> presentations are also very welcome.
>
> We hope to see you there,

Will it be possible to participate remotely (seeing as it's billed as a
hybrid conference this year)? :)

-Toke
