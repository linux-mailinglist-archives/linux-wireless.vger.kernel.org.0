Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092A67E64F5
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Nov 2023 09:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjKIIKO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 03:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjKIIKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 03:10:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C172D44
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 00:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6B14+Kwoeoz6Ia3b3YrdRvENldWC0X91cuVGcchBjxk=;
        t=1699517411; x=1700727011; b=xj5Z2s7Ts8hewL2uZ3r/thqk9HDtYIg2O+5m91nZBEyEhWb
        YFNhre3FsOFZZUSPpH9vJsWC4J6UCBxuYxwx5/ScQTYxgaGnsCLwHRCAxJ+rc3dNXVVnuRRPV4J7K
        U+isM+i9d9QuZQQjwISuqnmqgzDYb4SGz80lqdfwEdnE8qc862GDVN6MqVb0xhvm4WKzJmtcfAbmY
        h+H006ICMh+uFHpf9mOPOmLt5BIaTZccd8fhhsD/0spJV2HN3mqtmYOgEyb2ANZ54J0xmFXSz9X62
        Ru5igSY1TG6eXNVpk1hjs5Z7BJvlJnL41JdRx2YV9++pUud2r1V9OT1RXCygsLPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r1076-00000001ed6-3IZe;
        Thu, 09 Nov 2023 09:10:09 +0100
Message-ID: <24df733c7f162357506c7246fad49d540970f82e.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] wifi: mac80211: simplify non-chanctx drivers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 09 Nov 2023 09:10:07 +0100
In-Reply-To: <8bf4b564a53d42f9a180c569c060d10a@realtek.com>
References: <20231109003040.4b25d42b8b14.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
         <8bf4b564a53d42f9a180c569c060d10a@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-11-09 at 07:00 +0000, Ping-Ke Shih wrote:
>=20
> Because old firmware can't support chanctx, rtw89 and mt76 could fall bac=
k=20
> to remove chanctx ops. I think we need to add below changes along with
> this patch.
>=20
> (I did 'drivers/net/wireless$ git grep add_chanctx | grep NULL' to find t=
hem)

Good catch! I found ath9k doing the other way around, but not this.

Will add that, thanks. Also needs the 4th emulate call for CSA though.

johannes
