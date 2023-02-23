Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0806A038B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 09:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBWIMi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 03:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBWIMh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 03:12:37 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F414988C
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 00:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=g9zJh4OweQLP57wx+17bWtBOq6svkRWoOwkRE+NebmY=;
        t=1677139955; x=1678349555; b=MDMjJeg+PP19Q2Mluk7chSO+4X9ejSBhPEhuzW60+vAhDmt
        hGM/fhF2Q5Uw24RCF67/RUr3Qu29wvpkeLPdcCVMqsh+6ztCgpUxDcH5EB1tDWib2Swmz+bYGoIYE
        lD3WWPkZ32Utn2YYOsZRxM9Ity/yegm7hYFaGz5ntgWiANcAr1zBHfRPu6Dn5vZqQc53BYyPDy1wR
        3IUfZU03W8tHVTV7pjW6HdMmjLT8V6z+Bm9EVPtv7f3NMc+Li+srUi2S0FA4xBHyricpf3zkhVnPT
        PpfeskPnjnW4b0mf7i3jUcaPWxItwspbz1SxCufUtcfz38q3eApBHp0R0zXyOREA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pV6iM-003AWJ-2q;
        Thu, 23 Feb 2023 09:12:31 +0100
Message-ID: <2564165999cf5319e58aa0898a2866612f8af293.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: wext: Eliminate log spamming in
 wireless_warn_cfg80211_wext()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 23 Feb 2023 09:12:29 +0100
In-Reply-To: <20230222204945.6716-1-Larry.Finger@lwfinger.net>
References: <20230222204945.6716-1-Larry.Finger@lwfinger.net>
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

On Wed, 2023-02-22 at 14:49 -0600, Larry Finger wrote:
> Commit dc09766c755c {"wifi: wireless: warn on most wireless extension
> usage") introduces a warning when wireless extensions are used with
> cfg80211 drivers. Although such a warning is desirable, the current
> implementation overflows the dmesg buffer with thousands of warnings,
> all of which are the same.
>=20

What are you seeing them from?

This is rate-limited, so not sure why you're getting so many?

>  A WARN_ONCE() call is sufficient.

I think a WARN is inappropriate (it's a userspace 'issue', not an in-
kernel consistency problem), but I guess we could pr_once().

But that's not great because it only shows a single application that was
still using it, not if there are multiple.

Hmm. Not sure what to do. Let's start with "why are you getting it so
much". Maybe we can somehow print it less, or try to do per application
once, or something.

johannes
