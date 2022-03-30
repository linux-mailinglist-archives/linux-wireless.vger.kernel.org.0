Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976844EBA40
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 07:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243017AbiC3Fh3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 01:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243016AbiC3FhY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 01:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143D321F76E
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 22:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9099B61626
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 05:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D9DC340EC;
        Wed, 30 Mar 2022 05:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648618539;
        bh=TWVPJfY5eyKwBexepSodh8rgKJMsyWSpBXPJjSDi398=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aDNuRbuqqyWc4lemm8RsnNQeJouNvC3oVxjZEYiCweSzb/bwBDcmohWU6OOEaq27/
         fIY50FCwcbj7wSxyix5owQ95FCxP/BavKXclz2L536tluUcd1RyFdopHRiX7tNR8lK
         ldtqvPHw/1Ys7nsPqoPuOZg+BUPxcZzC3U7I0uiqaBq+UF18l+5gQjKbF2ttW9NJ5u
         qxesyrL0xgHr/8S2ZEdVL8enOVlNQJicCycwwI2Y53hnaUPmVB1xMH3+l9sM5o/uMy
         OwfofbKvruuInvtgHUJ8OI/KXtZe3DjhOCgnkXkyMN9/PVw58hJACosQtKwJm2hVcq
         1C1wbc+v1MAmg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     ALSI@bang-olufsen.dk,
        Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Julian Calaby <julian.calaby@gmail.com>, svp <svpm@yandex.ru>,
        Massimo Maggi <me@massimo-maggi.eu>
Subject: Re: Revert: ath: add support for special 0x0 regulatory domain
References: <YSJ//ki/A1EgfLga@skv.local>
        <CA+ASDXNzv6D1PthjUU-CVw6amT+JHmJP2mNSL=LVJKGm0zkEXw@mail.gmail.com>
        <YSQC32TygIq2SHJR@skv.local>
        <CA+ASDXPi0RRd0gFYcON=XLu8ABwKKcRXf0j0QoCRnvDwGa0VyQ@mail.gmail.com>
        <4c44fdc2-8dde-8a98-8dd4-4b7e6b57a090@bang-olufsen.dk>
        <CA+ASDXOeC+S2d7g0b=aS_q9XxNtdayF1S5XE9T85NZrxXnK5KA@mail.gmail.com>
Date:   Wed, 30 Mar 2022 08:35:34 +0300
In-Reply-To: <CA+ASDXOeC+S2d7g0b=aS_q9XxNtdayF1S5XE9T85NZrxXnK5KA@mail.gmail.com>
        (Brian Norris's message of "Tue, 29 Mar 2022 14:06:40 -0700")
Message-ID: <8735j0xas9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> Side note: it's a small shame that Kalle's scripts seem to have munged
> the authorship date -- git thinks it was authored in 2022, when in
> fact it was in 2020 ;)

Oops, sorry about that. I use stgit and then I edited the commit log to
add the Link tag, it must have changed the date.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
