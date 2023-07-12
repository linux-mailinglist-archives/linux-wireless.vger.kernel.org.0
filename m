Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46E17501F5
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jul 2023 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjGLIoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jul 2023 04:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGLIoa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jul 2023 04:44:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C711894;
        Wed, 12 Jul 2023 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZLP3oZ1RCbimO+7JPSUEQLGcAJZSBa1VvbPrkzhanDQ=;
        t=1689151468; x=1690361068; b=KMcgYF025YOwkY2t8q7ygmTR6w4fkO4mCJQvRQFw+KLstqp
        NS3FZUM1wZyL++9WpwE3RejNUKNpc6WruHmYxXKe37FiXMiJygmpgf2cUTmrYBRnzJfCXNGarL7bh
        XGIh7CQYIN9oC7+bdODI7Yw7sOwY1id9sBsx9YSnQXVagFLfOkTgcnpzJtSjvcAi5D5cp8WPx/WHD
        mIdpXeLZ074unNDm7EW8COXmThWT6V0PfWLIIwsTzauxNNXcUHfhcEhdMRt22VZDl6nGpmzt5+jWF
        TmI5w1OE/nH7PDWbuNVrzrJELPFemBV2xCR9/yBCQdUAPBkG2zrNORvxIGk4yUog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qJVSM-00GYj9-0z;
        Wed, 12 Jul 2023 10:44:18 +0200
Message-ID: <9936de52da43347ba0ccfb8737440a9698fb4585.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: fix mbssid nesting
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Koen Vandeputte <koen.vandeputte@citymesh.com>,
        linux-wireless@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>, stable@vger.kernel.org
Date:   Wed, 12 Jul 2023 10:44:17 +0200
In-Reply-To: <20230712083841.222607-1-koen.vandeputte@citymesh.com>
References: <20230712083841.222607-1-koen.vandeputte@citymesh.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-07-12 at 10:38 +0200, Koen Vandeputte wrote:
> Executing command NL80211_CMD_GET_WIPHY and parsing it's output
> natively without libnl shows following attributes as part of
> the nl80211 generated netlink message (part 16):
>=20
> GetWiphy: Type: 1
> GetWiphy: Type: 2
> GetWiphy: Type: 46
> GetWiphy: Type: 33074 <-- wrong enum value, above MAX also ..

That's not wrong, that's just NLA_F_NESTED | NL80211_ATTR_MBSSID_CONFIG,
since it *is* in fact a nested attribute.

> Switching to nla_nest_start_noflag() which ommits the NLA_F_NESTED
> flag (like most other similar functions do) fixes this:
>=20
> GetWiphy: Type: 1
> GetWiphy: Type: 2
> GetWiphy: Type: 46
> GetWiphy: Type: 306 <-- correct enum value
> GetWiphy: Type: 316

Let's say it _changes_ it, but it doesn't _fix_ it, since it's not
broken.

Using nla_nest_start_noflag() is a legacy thing, it shouldn't be done
any more. You need to update your userspace, I'm not applying this
patch.

johannes

