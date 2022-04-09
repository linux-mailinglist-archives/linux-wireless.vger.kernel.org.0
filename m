Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC624FAAFD
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Apr 2022 23:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiDIVjf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Apr 2022 17:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiDIVjd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Apr 2022 17:39:33 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA726F7
        for <linux-wireless@vger.kernel.org>; Sat,  9 Apr 2022 14:37:23 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1649540241; bh=vgHyx9BgxzG0UUENvbI1qWkuRKnGIRcnPb2rw2vPhac=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hzIw18JJEu/uR3fjBa5QErIhy8JdKEc//GE+ftX+gw0dxf7BlJK5HF46iyfzQp+eh
         PUOnW8WZnud0l/ONM3GQks2gwaOZp+W63FLZUrr7pfBXxfx/BQQyj02c76Olmm1vik
         Grie5b1hj/aDWxV/IN7455ZrLkR/nY/LpGuQycwCTStbaQUu30sfk1yIr5dVRRL2Je
         KFAjfGxMPHXEoPN73uozsHrx+9txpc7gkBT2GWvnIwVo4C32mHxKNFsgUX/AKmS71V
         O9AuiF+BIXRg5ceUs1WtmuEcByuKtmka2iYBkPgKJpYHa09tlQqGWide/pQLkRf6G4
         zN+gn/3jONl3w==
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Oleksij Rempel <linux@rempel-privat.de>
Cc:     Kalle Valo <kvalo@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ath9k_htc: fix potential out of bounds access with
 invalid rxstatus->rs_keyix
In-Reply-To: <20220409061225.GA5447@kili>
References: <20220409061225.GA5447@kili>
Date:   Sat, 09 Apr 2022 23:37:21 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tub26ir2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> The "rxstatus->rs_keyix" eventually gets passed to test_bit() so we need =
to
> ensure that it is within than bitmap.

s/than/the/ ?

This I think Kalle can fix up when applying :)

> drivers/net/wireless/ath/ath9k/common.c:46 ath9k_cmn_rx_accept()
> error: passing untrusted data 'rx_stats->rs_keyix' to 'test_bit()'
>
> Fixes: 4ed1a8d4a257 ("ath9k_htc: use ath9k_cmn_rx_accept")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
