Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEA265D287
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jan 2023 13:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjADMZQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Jan 2023 07:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjADMZP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Jan 2023 07:25:15 -0500
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F227A;
        Wed,  4 Jan 2023 04:25:15 -0800 (PST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1672835113; bh=/+pRFYBFedAsDHtqPmYRk6+gARXS3x0OS30HV0pfR2o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PO6juiQSEWQ1PvLyaLt0qEeuSEh5AXrX2wGV4plGsdqSOw3RdtozBvvggYtXUZbvW
         WmTVS+NiKhPUGlQEpoRy/557epfU56AU/H7QxUAisd8q0vFoIl/ssTuVIERPvmMPOJ
         QEju92uqpzntj2r/qKU8feDGrDdi+kkw+PLWJPR/yBCDl+PWDGUjAmNXx0EiEd+ydr
         3EeRJzZeJmVtzSawzBjEtnQ78nfOmEslEUfW2AtON1Y4zZeKKLK3IgH4KAKAkfPXSM
         zzADMXSg7XiiROdIi9T14UfHfJl/H7Z2kx2xCtBY7gbcej5sT17mqvMkOsPIlQkJAF
         IMwMXnTfUnpiA==
To:     Fedor Pchelkin <pchelkin@ispras.ru>, Kalle Valo <kvalo@kernel.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sujith <Sujith.Manoharan@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Vasanthakumar Thiagarajan <vasanth@atheros.com>,
        Senthil Balasubramanian <senthilkumar@atheros.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+e008dccab31bd3647609@syzkaller.appspotmail.com,
        syzbot+6692c72009680f7c4eb2@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] wifi: ath9k: htc_hst: free skb in ath9k_htc_rx_msg()
 if there is no callback function
In-Reply-To: <20230104121558.38969-1-pchelkin@ispras.ru>
References: <20230104121558.38969-1-pchelkin@ispras.ru>
Date:   Wed, 04 Jan 2023 13:25:13 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87edsa32s6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fedor Pchelkin <pchelkin@ispras.ru> writes:

> It is stated that ath9k_htc_rx_msg() either frees the provided skb or
> passes its management to another callback function. However, the skb is
> not freed in case there is no another callback function, and Syzkaller was
> able to cause a memory leak. Also minor comment fix.

The comment fix seems to be missing from this version? So either it
should be reinstated, or the commit message updated to not mention it...

-Toke
