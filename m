Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384D278FBF7
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 12:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbjIAK4H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 06:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbjIAK4G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 06:56:06 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3248210CF
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 03:56:03 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1693565761; bh=+BE53OQoR3nTNkd5dNvxhOG6Ws+RKCDuPIDgi9qeyrQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=b54i8F80xF9ct82yvC/Llz1siO+G9d66jYh8shR5KZxC4HrjkEqQqayiGThAFtTAN
         eHgk3idasWvFtGSAdV8zbc1XlCDOz8Mis5aPdNqZKWCFTqlH3G8eGBaFPvoI4NSRIE
         4Kz+nend6pp5Nn7hK6W3yyFO1GdszxM+kEZy0DU4iTt1a0qxjKbGUDR0NslQVLDFqk
         FLd6YXNvCN8a97kvnS838mIrVkuo0XLOeE4osEEY0eGLFo+SOlao1uEXNccVNq8Y5g
         U7FGVig4r48iYl9JvhVBAL/65bzXpvqhJc0qsFwo0DEoyjbG2bMS0RW2DvSfRQp309
         kf1BiwbHpng8A==
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 1/2] wifi: ath9k: simplify ar9003_hw_process_ini()
In-Reply-To: <20230823182401.196270-1-dmantipov@yandex.ru>
References: <574813ed-b9aa-458f-9758-29662eb60689@quicinc.com>
 <20230823182401.196270-1-dmantipov@yandex.ru>
Date:   Fri, 01 Sep 2023 12:56:01 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87sf7ytb5q.fsf@toke.dk>
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

> Since commit 8896934c1684 ("ath9k_hw: remove direct accesses to channel
> mode flags") changes 'ar9550_hw_get_modes_txgain_index()' so it never
> returns -EINVAL, and 'ar9561_hw_get_modes_txgain_index()' never returns
> negative value too, an extra check in 'ar9003_hw_process_ini()' may be
> dropped.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
