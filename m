Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F769B224
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 19:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBQSBT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 13:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBQSBS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 13:01:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743FC2B091
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 10:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xG89Mz9pj4E3T/EI2ryZS5Oc9+f4DJBf5248lLVypVI=;
        t=1676656876; x=1677866476; b=u6ckP86mts92e/1/7YNnhpID4JTCySHM/MlpHftVTiWsJlg
        1/SnnRm+a6QF4IDGOZPqxRTV8D2siqrSxi1s6NxrNrXhH0VpenPLlE6U/qBcD5lIPRvjbS9tAggB+
        IEjqxPk0ymP0TPju9l4VEUqggbKxzHbzj4DPVdymLg76XJ8Ajg3cPgTCQ6hvRRr2/XpdGEi0f7Fwd
        ARphe4MZ11/nChykNqh3Qq/VIxFIEZ/IlZqBkC3nmyM5NPrhi7LXXmNbzpYInhdjwXGn91h0MH0Y5
        nNzKficiu/dj51Dw6QFsPNo/iMRevqbGUg9n2dNhK+6+Cbpj6E20gcQE7V+vPrqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pT52l-00F90e-0k;
        Fri, 17 Feb 2023 19:01:11 +0100
Message-ID: <44f956b493e33bf394b2947b77e7c86f394b28ed.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: introduce
 ieee80211_refresh_tx_agg_session_timer()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Fri, 17 Feb 2023 19:01:10 +0100
In-Reply-To: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
References: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
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

On Sat, 2023-02-18 at 01:50 +0800, Ryder Lee wrote:
> This allows low level drivers to refresh the tx agg session timer, based =
on
> querying stats from the firmware usually. Especially for some mt76 device=
s
> support .net_fill_forward_path would bypass mac80211, which leads to tx B=
A
> session timeout for certain clients.
>=20

Does it even matter? We could just request sessions without a timeout in
the first place.

Or do you have a strong reason to need the timeout, such as limited
hardware resources for (TX) aggregation sessions?

But then maybe you should just time them out based on FW statistics
directly, rather than having to periodically refresh the timer in
mac80211?

I don't mind the patch, and I'll happily take it if it's needed, I'm
just wondering if that isn't a very roundabout way of achieving things.

johannes
