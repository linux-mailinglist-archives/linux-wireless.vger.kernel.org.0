Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C69178FBF8
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 12:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbjIAK4U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbjIAK4T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 06:56:19 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26010CE
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 03:56:16 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1693565775; bh=r35om7C4Xak0sVBbZJkMT33h1hoNvHorlRv/eb40kiI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RI/1b5CM2yLAUG6ytWba5/yisT7vXpo1XjxWxi12M+0IgqJO8D5GhFVcuPuO3NBHD
         xlXuHzeh8ySnLqeYj9eiEjfyx6m3Li/VqJp2tXgI9gEo+0RX17XEmGaPeR4zeZ6Y9S
         +kysQ/kDMndTiGoz4o7iZ8S0mfAOiyuP6G4XbKw0NZX2fjpTdhrHN/Uxnb4CXtpjxK
         Uj3H/y1mUJngrvne0LigMR3A6W0rLXHYQ4V24qhD2di6jXsFrc0dVl3s8RIstpPMKX
         0xbE854O8VGdQDfr0iPMM6I2B2spMDHQhCevCu1FLFk2+ZZ+WPeFgiGG/JEZzXw57R
         d8fU46EvWg8yQ==
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 2/2] wifi: ath9k: use u32 for txgain indexes
In-Reply-To: <20230823182401.196270-2-dmantipov@yandex.ru>
References: <574813ed-b9aa-458f-9758-29662eb60689@quicinc.com>
 <20230823182401.196270-1-dmantipov@yandex.ru>
 <20230823182401.196270-2-dmantipov@yandex.ru>
Date:   Fri, 01 Sep 2023 12:56:15 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o7imtb5c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Since both 'ar9550_hw_get_modes_txgain_index()' and
> 'ar9561_hw_get_modes_txgain_index()' never returns
> negative values, prefer 'u32' over 'int' and adjust
> 'ar9003_hw_process_ini()' accordingly.
>
> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
