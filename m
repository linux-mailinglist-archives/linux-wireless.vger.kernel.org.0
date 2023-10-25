Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36E57D68FB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 12:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjJYKjw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 06:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjJYKhf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 06:37:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ED41A5
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=VW/fA97JPE9q6x0GQ4oL1/8JOS/DJXZfjL7eN2JuLxo=;
        t=1698230193; x=1699439793; b=ImIbLyJ94H5GIZR8ipzc7sp6UeeWa5Hq/DEwvcuUJEpiZkJ
        U4HzCOHAnjcPBKB8IeRmc6FIxLeDfsQwNeMuKpMozjy5PO7qsmJpwnCmOAayqErDwWOKZ/dUy6wlZ
        reOVVfZ/Z9wONh3xE8Ucty7Exm9ZFD3X38IUqVj1ypcbtAQPoXdRtPgXAN2uVBfk/2ZlpzosR7Bhb
        N6RdNe1kl/h1KLWpc5AUaI8xpe9c4X+6Rx9a/arHZvEbZ59tgj/AzTUVV7rS0qDv6KtlqZqStLqkF
        p/zIdTYuPAZcj/WPk9OikaRGNECHUwCFv8QMtXm98pua7USWPwXX4Hq7mJ+k9VRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvbFR-00000002VNL-1jea;
        Wed, 25 Oct 2023 12:36:25 +0200
Message-ID: <b1358d256500d5bb6b3bbc312673c24b54b3674e.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: fix bss rbn double erase issue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiazi Li <jqqlijiazi@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jiazi Li <jiazi.li@transsion.com>, linux-wireless@vger.kernel.org
Date:   Wed, 25 Oct 2023 12:36:24 +0200
In-Reply-To: <20231025103304.22082-1-jiazi.li@transsion.com>
References: <20231025103304.22082-1-jiazi.li@transsion.com>
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

Huh.

On Wed, 2023-10-25 at 18:33 +0800, Jiazi Li wrote:
> If cfg80211_update_assoc_bss_entry call rb_insert_bss re-insert bss
> failed because cmp_bss return 0,
>=20

Ok that's bad - so you hit the WARN_ON there? How that? We should fix
that too?

> this bss->rbn will continue to hold
> expired data, such as __rd_parent_color.

Does that matter in any way?

> And this bss still in rdev->bss_list, maybe double erase in
> __cfg80211_bss_expire later.
> Double erase a rbtree node(with expired parent and color data) maybe
> corrupt rbtree, so add a in_rbtree flag to fix this issue.

This seems overly complex - couldn't we just remove it from the list too
or something? It's already a case that "should never happen" so ... not
sure we need to do something "good"?

johannes

