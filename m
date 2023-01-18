Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3804F6722F6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjARQYb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjARQX7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:23:59 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1702658293
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=u7KUcHBG4EeeiM3dnzAz+lw1y/drlKduTd/T7QAfkyc=;
        t=1674058955; x=1675268555; b=OZ1e8Hv9MLiShiBimA9AiMHs/Sbt1sqQYLKda00YYcp6Zol
        Lw+d/Zh8/rNV8+UzlArjuQRON1eN/lHLrBgSQVFYTyNZzn45IfU0YarqJlm6I2VUZMIUkUcOWUhls
        nfS9R/lvuGDpoLPGNjyzIeBmmxw838CTvyKQXQilYWrb02xhj4ZL78yzDJUcw0Q2WaYS3oxQkb6eT
        hfbNVN4aaci9+wZWzgd/kScgSqRYLud+CkiMqYYpMTs1HHNF2ikToj5rfjMUNUiB8nQbwIcCMfVcs
        sMQbXcqsCbwvUhlzg689kvs+jQhHYtNTtWMDOu88ELecK3emW3ytJyzTZr1aYEmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIBCp-005fbi-2n;
        Wed, 18 Jan 2023 17:22:31 +0100
Message-ID: <3fe52061d5d9e3701f598add5c64f8b3583c31df.camel@sipsolutions.net>
Subject: Re: [PATCH] bitfield: add FIELD_PREP_CONST()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 17:22:30 +0100
In-Reply-To: <92209c00-7fcf-1592-e97c-f49e7734fdfc@intel.com>
References: <20230118142652.53f20593504b.Iaeea0aee77a6493d70e573b4aa55c91c00e01e4b@changeid>
         <92209c00-7fcf-1592-e97c-f49e7734fdfc@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Wed, 2023-01-18 at 17:10 +0100, Alexander Lobakin wrote:
>=20
> Have you tried combining it with FIELD_PREP() using
> __builtin_choose_expr() + __builtin_is_constexpr() (or
> __builtin_constant_p() depending on which will satisfy the compiler)?
> I'm not saying it's 100% possible, but worth trying.
>=20

I haven't tried it that way, but I tried rewriting FIELD_PREP() itself
to be constant-compatible, and as soon as the compiler saw
__builtin_constant_p() in the initializer it already complained that it
was non-constant...

I didn't think of __builtin_choose_expr, but it doesn't work either
because it only promises that the unused expression is not *evaluated*,
not that it's not "looked at", so it still complains both ways (in the
constant case that you can't have ({ }) braced groups, and in the non-
constant case that the _CONST version is bad...

johannes
