Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC5596067
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 18:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbiHPQia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiHPQi2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 12:38:28 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F8C7F
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 09:38:27 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1660667906; bh=DDLXlIiM1HQqC2sxPgK6XJiiqnjKJvJbTkPegFracBU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BJZ/hjJDePs/eklJ/gLX83uRRBTVLu83IHytDpSBbeKie3H2kcuDLqgd+m2+8S98g
         O25wnEcmLKCUb/ntb0mWkcEmwm9LOCgpQv1JTDOaqtVrEOdN3Gp9xblisWbmTzhydC
         AsKxJfDjjHDAr+m7yn/eqfjZYtyJdn/dgdRFenyMb+BhpPQT3AZUNBHJbh2JRKLXnK
         LgHCD2dRjuZdl8Uv8yOywj7TJqO3wJRSjyfMxNY/RpEl9zWHr0C6pLxCwJW17rMKnV
         CvWUt8RXi5cre/GRquYFUP20Bdx+k8+ttA7bADkNMAznZT1n7cBm/DDmnzaJLie/v/
         hXFWencJATSBw==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath9k: avoid uninit memory read in ath9k_htc_rx_msg()
In-Reply-To: <7acfa1be-4b5c-b2ce-de43-95b0593fb3e5@I-love.SAKURA.ne.jp>
References: <000000000000c98a7f05ac744f53@google.com>
 <cd4287be-5434-039e-59ba-2a9cb2ab5185@I-love.SAKURA.ne.jp>
 <e0bcd6d4-4029-4ab3-0405-054d26262f64@I-love.SAKURA.ne.jp>
 <87edxgwarp.fsf@toke.dk>
 <7acfa1be-4b5c-b2ce-de43-95b0593fb3e5@I-love.SAKURA.ne.jp>
Date:   Tue, 16 Aug 2022 18:38:25 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871qtgw3cu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> syzbot is reporting uninit value at ath9k_htc_rx_msg() [1], for
> ioctl(USB_RAW_IOCTL_EP_WRITE) can call ath9k_hif_usb_rx_stream() with
> pkt_len =3D 0 but ath9k_hif_usb_rx_stream() uses
> __dev_alloc_skb(pkt_len + 32, GFP_ATOMIC) based on an assumption that
> pkt_len is valid. As a result, ath9k_hif_usb_rx_stream() allocates skb
> with uninitialized memory and ath9k_htc_rx_msg() is reading from
> uninitialized memory.
>
> Since bytes accessed by ath9k_htc_rx_msg() is not known until
> ath9k_htc_rx_msg() is called, it would be difficult to check minimal valid
> pkt_len at "if (pkt_len > 2 * MAX_RX_BUF_SIZE) {" line in
> ath9k_hif_usb_rx_stream().
>
> We have two choices. One is to workaround by adding __GFP_ZERO so that
> ath9k_htc_rx_msg() sees 0 if pkt_len is invalid. The other is to let
> ath9k_htc_rx_msg() validate pkt_len before accessing. This patch chose
> the latter.
>
> Note that I'm not sure threshold condition is correct, for I can't find
> details on possible packet length used by this protocol.
>
> Link: https://syzkaller.appspot.com/bug?extid=3D2ca247c2d60c7023de7f [1]
> Reported-by: syzbot <syzbot+2ca247c2d60c7023de7f@syzkaller.appspotmail.co=
m>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
