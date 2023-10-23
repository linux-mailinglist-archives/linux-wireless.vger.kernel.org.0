Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D37D3B60
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjJWPtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 11:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjJWPtu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 11:49:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D2101
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yoeFzFaKnDxPDAKi36FYKqJZPjkHaFo96kiWtzwC5F4=;
        t=1698076187; x=1699285787; b=MS2hvugHl+/kZD/kuv9rArCWKCzdOMOaQCY+KLUtS/ZOiQ5
        KhWYz6U7DmSlamWNmCCK1hOU+s9PeQ8D8Z31jLqXhxCtA1LzSYYpOiKiu+OpP929jKQjwlxmPaAE4
        p4XEVH0CCk9SBnWEvAihVDanKHdvW/TBMYr+IF2U8QylmpWzqpBCJ1i1RSJCnm7x84BseYtFd78OY
        Eg+oquZeZGDNuAFpbKMBqYERZJd6BBPedKBCJLLD6K7j2P3n5aMIJnqOkGZ5YzMhicQYyK5xbDGRe
        b6FbiyBS5F1l9KQYqLbNFUdA5DqGr7OanXlleBxvk1nO4xWFAZt12+HF2Y0VeaOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1quxBX-00000000L3v-2hOe;
        Mon, 23 Oct 2023 17:49:43 +0200
Message-ID: <f457efec4acf25b2bbfae1da90f7a757ac4f0012.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: use kstrtoX_from_user() in debugfs
 handlers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Date:   Mon, 23 Oct 2023 17:49:42 +0200
In-Reply-To: <0108de99-a82a-449a-ad36-77b141dd6691@yandex.ru>
References: <20231023143459.157306-1-dmantipov@yandex.ru>
         <011c648db5718754bd3f712a38e79235e3f8e836.camel@sipsolutions.net>
         <0108de99-a82a-449a-ad36-77b141dd6691@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-10-23 at 18:48 +0300, Dmitry Antipov wrote:
> On 10/23/23 17:45, Johannes Berg wrote:
>=20
> > Did you do that with spatch? :)
>=20
> Not yet.

OK.

> > We probably have a lot more files in other places and not yet
> > upstreamed, so it'd be useful to have that to apply it elsewhere?
>=20
> Hm... hard to say about the sources I've never seen. Anyway I can
> try and see how useful it might be.

Well if you had an spatch we could run it on everything ... since you
don't, never mind?

johannes
