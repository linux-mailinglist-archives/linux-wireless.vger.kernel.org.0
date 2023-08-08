Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145EF774200
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjHHRcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjHHRbn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 13:31:43 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC7221E58
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 09:13:44 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1691502151; bh=LmHioS78WpREkDZ5AvTzfIhe8IBROYGP7LCaFFjvJEM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HpxwCbV+mwjNCIlupg9JVcQp1NPwOy5KTNn6WbCWo5azM+FPu7+RJDD9OWvJ9Kuvb
         A01AZ1POAxp53nv6FXKsEkBGRHAL78FzV0PJB8uxQJMWBfglKA21R2Ez1Qb+i1Wo6U
         Jtd8B+mM+S/sFBP2KM7ocz8laBgi2NMHxRehxd1W0yLgGHK9wiYKi2YGa/RHyk121K
         LUMUJ+Dw4kDgG/sykPWWujzseuquYKN6bdU7QFpPx0q8dt8j24vn+5AMJK024kgUXO
         Hq/O4PNi2Ecb3p3HKiCofcQBT+AXQdCuqkKh+fMUvBLeB5WE7HPGqjdXpd5MjJ20B6
         uIlSLSJmc4vrA==
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: ath9k: consistently use kstrtoX_from_user()
 functions
In-Reply-To: <20230726185046.188225-1-dmantipov@yandex.ru>
References: <20230726185046.188225-1-dmantipov@yandex.ru>
Date:   Tue, 08 Aug 2023 15:42:31 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87jzu5bqgo.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Use 'kstrtoul_from_user()' and 'kstrtobool_from_user()'
> where appropriate and thus avoid some code duplication.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
