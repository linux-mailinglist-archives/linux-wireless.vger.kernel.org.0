Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBAF5630C1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiGAJzK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 05:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiGAJzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 05:55:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF39D7479E
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pePzQ70O3qF1BbrHwbaYS/YJeXplHbDhGHZky1QkMIw=;
        t=1656669308; x=1657878908; b=uAiovKPLrSW9l+YPDxobqiVbftjqXC/5gdN1JX4c1PptqbH
        R2sMiutxvuMspAqv5QXYi0olTJM+ldG/kUzysm9gagXSX5opt2rNSsPBGLppxPbi1j3ngv5Ve20vz
        uYrumRzOKYucZk7q99YpGWbxEmMQmmwnUfmaHABwvAqGK7QlcoXEzstOxvJR+qdKHYVLuXaZ4e0ai
        8Y6m4NELO6K/flNiTKQdC2hMnx6sszHlBgCzTxAxA2oR2tGl1aY6gY5Kwl/zwVo9def4uroIb3CJH
        ZYgjiHd7BU8z3MICZvT32aBPXwy6wCJA4uUz3k8X73deG/3v4nNkFgiLC1RyKuRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o7DMh-003QuP-7i;
        Fri, 01 Jul 2022 11:55:07 +0200
Message-ID: <8542c3eac729563fef1bc78d28c740453fba88bd.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211:  report per-chain signal values through
 ethtool.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Fri, 01 Jul 2022 11:55:06 +0200
In-Reply-To: <20220329210228.8137-1-greearb@candelatech.com>
References: <20220329210228.8137-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-03-29 at 14:02 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> Combine them into a u64, each byte is one chain.

This only works up to 4 chains, but the specs at least support 8. I
don't think we have any drivers for that, but ...

And it's also rather ugly, IMHO.

We're reporting these through nl80211 anyway though, no? Why should we
prefer ethtool, which fundamentally limits to a single value for the AP
rather than giving the full per-station view.

> Re-work the way that APs averaged stats to be more
> efficient.

Isn't that completely unrelated?

johannes
