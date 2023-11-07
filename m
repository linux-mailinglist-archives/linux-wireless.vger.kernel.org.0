Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5D97E458B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 17:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjKGQLA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 11:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjKGQKD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 11:10:03 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4D621117
        for <linux-wireless@vger.kernel.org>; Tue,  7 Nov 2023 08:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xzU9VhB4mdbof3mIoxy7KRqil2lVEU5pGqPFku67oXc=;
        t=1699372964; x=1700582564; b=ni5wN0GtQSbAfTLvWPT9PntKgBMgAqa8FdA2cWH4JErvLXG
        UYKtzbd/41W+a2il7z0NAvCBcjZoFXm1xWRzXAhuBRm3sZS0vEUIFUsifDaauxuZjnGJ1cEUbl0BD
        86M1OtTb5OyPlFpJnsRLqZMPjXqGtPFkJaiq1kb/sQsuUk5sSCXqkrW9mm4rGi9bFZkI02z1dedqs
        Kg6V4HAnpfOklpzp2YeCNEule/2ncO6XChJcfMjb0HExRC08JVMtRJ99Z/ZX068Iex7p+ec9WGw0/
        diZU7qlH7a6C7QoJ5T1IYauPNmemvagN3dXgqpieQuxt7GdG+9/p/Btjiglqjs7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0OXJ-0000000H0nH-1dPK;
        Tue, 07 Nov 2023 17:02:41 +0100
Message-ID: <9ca0a134b2ca98c44d861329fe8e5040f0522890.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: add missing milliseconds to TUs
 conversion
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Date:   Tue, 07 Nov 2023 17:02:40 +0100
In-Reply-To: <73a27525-bed6-4bee-8bd6-973bff07e608@yandex.ru>
References: <20231107152611.61952-1-dmantipov@yandex.ru>
         <22c0b564fc18fcd4d421d520f94a78bdb644d1e4.camel@sipsolutions.net>
         <73a27525-bed6-4bee-8bd6-973bff07e608@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-11-07 at 18:53 +0300, Dmitry Antipov wrote:
> On 11/7/23 18:41, Johannes Berg wrote:
>=20
> > Well, the function is actually documenting both TUs and ms depending
> > where you look ;-)
>=20
> I've relied on the comments around 'struct iwl_time_event_cmd'.

Yes but the function docs also say:

 * @min_duration: will start a new session if the current session will end
 *      in less than min_duration.
 * @max_delay: maximum delay before starting the time event (in TU)

so it expects input in TU already. Then it goes on to say:

 * This function can be used to start a session protection which means that=
 the
 * fw will stay on the channel for %duration_ms milliseconds. This function

so it's not consistent, but I'm not surprised, my son's teachers always
praise him for tracking units and I think it's obvious you have to ;-)
Why should the code be different :P

(Then again, "duration_ms" isn't even an argument)


The value from mac80211 that's passed in comes from

 * struct ieee80211_prep_tx_info - prepare TX information
 * @duration: if non-zero, hint about the required duration,
 *      only used with the mgd_prepare_tx() method.


which doesn't even say the unit ... but in the one place setting it uses
jiffies_to_msecs() to fill it, so it's also not necessarily very
accurate (depending on CONFIG_HZ.)


Maybe we should rename IWL_MVM_TE_SESSION_PROTECTION_MAX_TIME_MS and
IWL_MVM_TE_SESSION_PROTECTION_MIN_TIME_MS to _TU to make it more
aligned? Dunno.

> > It's also only 2.4% off, so ...
>=20
> The corner case when MSEC_TO_TU(1) yields to 0 may be more interesting.

The input should be in the order of (a) hundred(s) TU/ms, so that won't
really ever happen.

The reason why I don't really want to convert it is that the beacon
intervals are typically 100 TU, and so if we use 400 ms which converts
to 390 TU we _just_ don't cover 4 beacon intervals which is a bit stupid
since the precise timing doesn't matter. Covering 4 gives us a better
chance here, and anyway the firmware will also have some delays etc.

johannes
