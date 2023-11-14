Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A847EB540
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjKNRCv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 12:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNRCv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 12:02:51 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E0CB
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 09:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xdWfV1jK41rLW+vwjUaGY2+CHRneTdw41ou4qGffX/Q=;
        t=1699981368; x=1701190968; b=t7LcZwcNwLgUSm3HEnGanzdz/SKdIlObHmZssq26yrjO/qS
        cToTAjyXI4GENZfb5q92dfv6c/gbhff+af867jUk/PPIwQyvkVUG3QjrqIYAXZhLqT9hI3k1Gesrl
        3C5UZJDwLC7ClKzrkaS71SUS9IyqTKpGJSRWM0XOz9Ve6d7xnjd/8AodNhi1Y9+geCYYA7Vu4qZDe
        DGhdHUSkFvIEKRDGm31mnzmdoDRzZuvkQC+MWyA2hsVVQTeqMZ3jGw4h3D0TYHaasqP4c75JDIiAG
        fH1sk+5rUCwiB8aHD+iI6dzaHQFaSxngoyE74fMpNf5gVqM07DXfr2qNwCdLCSwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r2wo6-000000082gd-0mdz;
        Tue, 14 Nov 2023 18:02:34 +0100
Message-ID: <02159e92fd1d9a6fd993ae9f913c7ed756b6d3ac.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: lockdep splat with 6.7-rc1
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 14 Nov 2023 18:02:33 +0100
In-Reply-To: <ZVOXX6qg4vXEx8dX@hovoldconsulting.com>
References: <ZVOXX6qg4vXEx8dX@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-11-14 at 16:50 +0100, Johan Hovold wrote:
> Hi,
>=20
> I get the lockdep splat below when booting 6.7-rc1 with ath11k (Lenovo
> ThinkPad X13s).
>=20
> It's the new assert added by commit 0e8185ce1dde ("wifi: mac80211: check
> wiphy mutex in ops") which triggers in drv_get_txpower().
>=20
> Naively adding locking around the call in ieee80211_get_tx_power()
> (e.g. similar to 6b348f6e34ce ("wifi: mac80211: ethtool: always hold
> wiphy mutex")) does not work as there are other paths that call this
> function with the lock held, specifically via ieee80211_register_hw().

The latter we can just take the lock I guess?

> [    7.127780]  ieee80211_get_tx_power+0x19c/0x1c0 [mac80211]
> [    7.127859]  nl80211_send_iface+0x208/0x6a4 [cfg80211]
> [    7.127946]  nl80211_dump_interface+0x120/0x254 [cfg80211]
>=20

And here maybe we should just take the mutex at the nl80211 level.
That's the nice thing now, it's shared between the layers :)

I can't do it right now, but I'll take a look tomorrow.

johannes

