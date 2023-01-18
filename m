Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9C67228B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjARQIv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjARQIE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:08:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678A59B71
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RHicEkJuAKhouUoav7pWmWn+2KgazY4Vbbpdle0tjtU=;
        t=1674057869; x=1675267469; b=JHcAznSlfHEGbswyFiYMeGBjYMYVNKoZwKCLguKSuoJxUF8
        22hOuFwsg3B7FruiPK5abpx3EU7kMIoD2zInfry7mH16BRe16JT/tfyG+DfDHW+hVW8XbeGY9BweS
        VjFIfp296DmfaqosmrROF8NxtF2pJD4MRZ0zgpOlNF/9iJ5SIyiOr67WncRTZvRoU9qRRJGGqpFnX
        dLInoTRNhtpTapA6TY+Ce3G8GPIYlArAEHuJ7EhPsQM/JK5NfcZvTaGvy9hIFcTudOQHsxsUhAaaT
        CLrTovrssfLVwThcBDVfZH7ft9zdm4utFEVjJySXASFvAYv3RDa4ziHPRqnPrVQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIAvL-005ew1-2Y;
        Wed, 18 Jan 2023 17:04:27 +0100
Message-ID: <6a81f3d5f25a9a7258587e469209f48bdeac558f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: handle connection loss in
 __ieee80211_disconnect
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 17:04:27 +0100
In-Reply-To: <20221025203443.410121-2-prestwoj@gmail.com>
References: <20221025203443.410121-1-prestwoj@gmail.com>
         <20221025203443.410121-2-prestwoj@gmail.com>
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

On Tue, 2022-10-25 at 13:34 -0700, James Prestwood wrote:
> The ieee80211_connection_loss() can be called during times when the
> kernels state is in flux, such as after a successful authentication
> but prior to successful association. This can result in the kernel
> never telling userspace due to __ieee80211_disconnect bailing out
> if !ifmgd->associated. This has been seen out in the wild on
> iwlwifi:
>=20
> [503619.324379] wlan0: disconnect from AP d0:15:a6:70:e1:20 for new auth =
to d0:15:a6:70:b5:40
> [503619.367204] wlan0: authenticate with d0:15:a6:70:b5:40
> [503619.367233] wlan0: bad VHT capabilities, disabling VHT
> [503619.367236] wlan0: Invalid HE elem, Disable HE
> [503619.367237] wlan0: 80 MHz not supported, disabling VHT
> [503619.371184] wlan0: send auth to d0:15:a6:70:b5:40 (try 1/3)
> [503619.406401] wlan0: authenticated
> [503620.270833] iwlwifi 0000:00:14.3: Not associated and the session prot=
ection is over already...
> [503620.270943] wlan0: Connection to AP d0:15:a6:70:b5:40 lost
>=20
> At this point userspace has received a CMD_AUTHENTICATE event but
> nothing else. No disconnect or anything to indicate something is
> wrong. Userspace supplicants expect _something_ to come after a
> successful authentication.
>=20

I'm not sure I understand this scenario - there's nothing wrong with
this, is there?

The way I read this is that userspace simply asked for auth, but then
didn't (quickly enough) ask for assoc? Or got a comeback or something
(though we would log that too, I think)?

Userspace got a successful NL80211_CMD_AUTHENTICATE event at this point,
but didn't associate (yet anyway).

You could argue that iwlwifi shouldn't be waiting for an association if
nobody ever requested association, but that's a driver bug, and
shouldn't cause any problem with state between userspace and kernel.

johannes
