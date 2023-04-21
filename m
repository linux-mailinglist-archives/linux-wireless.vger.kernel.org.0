Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F716EAD38
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjDUOkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjDUOjq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 10:39:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF8415616
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=C4gj1rdsY5Z6p5jNGYbkOqRjPl5OXVGY3dVpTyv0MvY=;
        t=1682087896; x=1683297496; b=WuB/ZryuPajYmZndafaa0O7NM24H/Mqy8nlhhh+Ay8fqhte
        QUBi5tI56J1cq4ARlrErv06canUMd8flD9kKPrKjzsKI6Qs8d0HO7d0EkPo6h9mxEM7sMgpJP2nhz
        R935UlqEYL0e8WKd2sWhWDhQkQox4zjVLsb1zjgy0RpduqTx62KRbbZ6Fs3XSryL1sO+F3s2s0Zxa
        tCFFTwCrdCoaqZSqJ7Jrk6zNYpuWAElH/h3O7iclTgjwCeaeJ8mqd86djUrel6TM75WM3fPxnYt7N
        dzIoGaTjKREYRYBInAqL7ByKu4nXVQBN+tH+RW1ccc2m8+fuAuuGQSi8Hmxv53YQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pprtg-004TZl-0b;
        Fri, 21 Apr 2023 16:38:00 +0200
Message-ID: <3f505aba559d4ce068ef6d2fd7743045e0d93b9f.camel@sipsolutions.net>
Subject: Re: [RFC v2] average: rewrite for clearity
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Benjamin Beichler <benjamin.beichler@uni-rostock.de>, nbd@nbd.name,
        linux-wireless@vger.kernel.org
Date:   Fri, 21 Apr 2023 16:37:59 +0200
In-Reply-To: <20230421134604.211128-1-benjamin.beichler@uni-rostock.de>
References: <20230421134604.211128-1-benjamin.beichler@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-04-21 at 13:46 +0000, Benjamin Beichler wrote:
> Move the former *_add function with its implicit initialization into a
> separate function, when the user explicitly wants to init with the first
> added value, although this creates issues, when 0 is a expected value for
> the internal value.
>=20
> Add a separate init function with value parameter to allow init with
> distinct value, which was formerly done by the implicit init of old
> *_add function.
>=20

Sure, this is what you said :-)

I still don't really think it's feasible. First, this breaks all the
users, because if you have e.g. virtio's DECLARE_EWMA(pkt_len, 0, 64)
then it will take a long time to get away from 0.

So then we could say we'll just fix them, but what value actually makes
sense to init with? You don't necessarily know, right? Initially biasing
towards the first value makes a lot more sense than initially biasing
towards zero, no? And then if you want to achieve that, now you have to
either use _add_or_init(), which is probably what people will do, but
that continues having the problem ...

I don't really see how this is a net improvement - we'd still have to
fix the individual users with it, e.g. maybe the mesh case that started
this investigation could bias towards success (init with 100) and then
use _add() rather than _add_or_init(), but then again we're back to
having to make individual choices with the users. I don't really see how
that's better than fixing it for real with the existing behaviour of
biasing towards the first value?

johannes
