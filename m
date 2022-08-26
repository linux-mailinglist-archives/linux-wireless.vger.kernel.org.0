Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1925A22E4
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 10:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbiHZIXM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343575AbiHZIXI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 04:23:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A02FD4F56
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ttuuzgJKCaXKHhEMA/NaoiYjnJWDTfP6JpnnkBaBFF4=;
        t=1661502181; x=1662711781; b=Odh+hlqxz+S5xwiUSW8Lnf0Jt8Giegc21Up0tfYNtxz1pco
        xmOp/eFWvUzjuZRIFKDCLPI6iyJ/UDC5uZAkRM6mBKlOQDyjOUUEpBF6E3nkfRATzIeG6jAhJTYD9
        SuBlCuwxyz3+8G4LtDoBLN88yTab62eblNt7WYHl/9xxgLhppKwsurg+oMfHULwjgoLaD4vIQhseh
        dSiHO677oJLiQhc1HjHZKQ+M9+jH951AoX2rw2bbJgZTePZyacTF5aGBDiXOejCjAiLLei02M/koJ
        Jp5QNpEAgeMBWOhCdfohC1N+PaFNjzHQhiCpCpZkc3jQz5lDsucjvPvDa9DL1Pmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oRUc9-000ACj-0H;
        Fri, 26 Aug 2022 10:22:53 +0200
Message-ID: <a991cbeb70e5f9603f89864278e6acf0f262d870.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: Fix spamming of logs when number of scan
 results is limited
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Maxim Klimenko Sergievich <klimenkomaximsergievich@gmail.com>
Date:   Fri, 26 Aug 2022 10:22:52 +0200
In-Reply-To: <20220217011226.31579-1-Larry.Finger@lwfinger.net>
References: <20220217011226.31579-1-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

Hi,

Sorry I didn't get to this for so long ... Didn't really give it
priority since it's such a strange special case configuration.

On Wed, 2022-02-16 at 19:12 -0600, Larry Finger wrote:
> When the cfg80211 option "bss_entries_limit" is set to 1, routine
> cfg80211_bss_expire_oldest() fails by issuing repeated warnings.

Yeah ... special configuration, not very sensible.

> The problem could also occur in the unlikely event that a scan only finds
> a single SSID.
>=20

That's not true though, it could only happen if there are as many as
bss_entries_limit entries (which defaults to 1000!) that *all* have a
reason to be held in place (e.g. bss->hold, or part of a hidden SSID
BSS).

So to hit this with default settings, you'd have to have 1 network
connected, and 999 real SSIDs for it with other hidden SSIDs or
something like that?

Anyway, I think the right thing to do is to just remove the warning
completely, even if bss_entries_limit=3D=3D1 is probably a config you don't
want to make.

johannes
