Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE951697763
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 08:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjBOHb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 02:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjBOHb1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 02:31:27 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB5728D1A
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 23:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mkqE2r3m51/LiSQIdo/az6Tf1nHb/Z9frMWJQw/+3Bg=;
        t=1676446286; x=1677655886; b=Z3+f28gZfooptJ9HF+T4YiySU5FAHa3iqvBZmAnv4mnCDZ3
        01zqrBvQBUbG+WhtDDWB0YX0/7Sc4ZW6n2iEH8tWZg37oKF5UaWYlFzxjzp9iI8P7i7gJXmLDUy7k
        MiG3P4sRaxPNSMOuaIxcKw7pVUWYdm5Rx9vKZvhB4G72r5XWks4Iegq0Aux468rCRoL9wrOrEG0o9
        G6RVJ9J17skr0im/pE0S7O7fO957Fsb7JjAufxOPl8ZJ4vuGMblT+S/mBxSg5eO3ake7nwmy5WTaE
        muJkJ9l5ZFNCcLIVzhEVIbdUzZ6bsOkY75UNMBsRngtFwXjBth9tKMk5MTodlQmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSCFu-00Cy6v-1F;
        Wed, 15 Feb 2023 08:31:08 +0100
Message-ID: <4ab31b2407d9b2d930a2637730c4f3c0b2555c6a.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: call reg_notifier for self managed
 wiphy from driver hint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 15 Feb 2023 08:31:05 +0100
In-Reply-To: <bcaf5a88-76f3-c4ed-0fca-2c131d392f82@quicinc.com>
References: <20230201070327.27578-1-quic_wgong@quicinc.com>
         <bcaf5a88-76f3-c4ed-0fca-2c131d392f82@quicinc.com>
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

Hi Wen,

> I see you have merged v2 to wireless-next.git and this v3's state is reje=
ct.

Yeah. Actually, I saw v3 only after I merged v2, but then I saw what the
change was and figured that was unnecessary anyway.

> So do you mean we should not keep hole BIT 24 in enum wiphy_flags from=
=20
> now as well as hole 11/12 in commit 8e8b41f9d8c8/ca986ad9bcd3?

Indeed. The point of the comment saying "use" was to actually, well,
_use_ the hole next time. I haven't really enforced that since I keep
forgetting (and we're nowhere near running out of bits), but yes, the
point is that you could even have used bit 11 or 12.

> If that, then backport this patch will be more complex, because the=20
> backport kernel already have
> WIPHY_FLAG_HAS_STATIC_WEP=3D BIT(24), then firstly the backport kernel=
=20
> need backport other
> patch(585b6e1304dc ("wifi: cfg80211: remove support for static WEP"))=20
> which is not really needed.

I guess it could use another bit number (such as 11) in a backport, but
I don't see that this really _needs_ to be backported? And if you're
using backports to backport the whole wifi stack then this isn't even a
question since it all comes in backports.

johannes
