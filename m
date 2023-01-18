Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2472E672648
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjARSGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 13:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjARSFq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 13:05:46 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149145B458
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 10:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gtbOFdjeWTYapyLj2/X5cTZU78QSbSHsXv1TABjo9FI=;
        t=1674065018; x=1675274618; b=bQuHsTMsP9/e5JNtAzOqhffP88gACLudOzI+mDploCbHvK0
        Pb4kXko2Jw/K/LU+iJlz8kIhkdPVBalHlKC+WoP2W6bDGjF7fq3yZCBQQLlnxkp2/GUPlSVVXG5/s
        A/CcbE6Cs1lsPWuzj+UyObkoVqSy+x64Dgb/+zIizdcphriIKJQHGhpyQOm2VagLUIVwbTO28k0lH
        etiqp0t7wgumKaBhsyvHrLTMjR7M9NWqJLOHE431pWsZKOLE7xfcI+b+pSEfgOlWhUx0g6b3MbrYn
        HYqx//Q/ndLvw1QKltjyx/TR+EVx59nUxh5uk3tTtqHRVMZbcpu/VEZ7di35G8Jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pICmT-005iMZ-0t;
        Wed, 18 Jan 2023 19:03:25 +0100
Message-ID: <8b955e4d859aafdf42f1a11f37ddf2a5e47c2610.camel@sipsolutions.net>
Subject: Re: [PATCH] bitfield: add FIELD_PREP_CONST()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 19:03:24 +0100
In-Reply-To: <b2c78f45-345b-e3ec-20b1-9d18ee0c9f98@intel.com>
References: <20230118142652.53f20593504b.Iaeea0aee77a6493d70e573b4aa55c91c00e01e4b@changeid>
         <92209c00-7fcf-1592-e97c-f49e7734fdfc@intel.com>
         <3fe52061d5d9e3701f598add5c64f8b3583c31df.camel@sipsolutions.net>
         <b2c78f45-345b-e3ec-20b1-9d18ee0c9f98@intel.com>
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

On Wed, 2023-01-18 at 17:49 +0100, Alexander Lobakin wrote:
>=20
> Aaaah right. Seems like we can't avoid introducing a separate macro for
> that. I like the idea of your patch anyways!

:)

> One note re __BF_CHECK_POW2(): can't we reuse is_power_of_2() anyhow?
> Foe example, by deriving the code of the latter into a macro and then
> using it in both?
>=20

Well, not directly - for example is_power_of_2() doesn't accept 0, while
we want to accept 0 (mask being e.g. "0xfull<<60", we already check for
mask !=3D 0).

I thought about __BUILD_BUG_ON_NOT_POWER_OF_2 but it uses BUILD_BUG_ON,
not BUILD_BUG_ON_ZERO, and BUILD_BUG_ON is nicer in most contexts ...

So you could pull out the expression "((n) & ((n) - 1)) !=3D 0" from all
four of these, but it doesn't feel worth it.

johannes
