Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC96963DE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 13:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjBNMsX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 07:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjBNMsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 07:48:07 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D65010FC
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 04:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ccOsmS/Kqrmrs7KrW8CJER1Vma99I3H7hgGjIhwNsKs=;
        t=1676378884; x=1677588484; b=XyE6K2Vmr/PG+stda5wOew1nqhXoa257osUoJI0dcWYk2Hg
        7ekiuNWYMO7e6kduCaF8E+pR+nfaDSi/MAXwNh+o9WjmeGbe2eQIb3fyxk+dvUUbcjKb7rkJFXqur
        X/u+1RCqzGafIVtNGn4HmU2l0w2cmYRzimcWEjC3pFDgTSgFFJS0fZBOlFgikT7Y+PQeelnfPH50T
        6qRAtCvPQMnf70GBmonq6IO/cxy07iKRnt3ZrCZXN4DQPk698ReWqMxM7QnwlqXZQZiEro/9smStC
        e/ZCCXwmsc2YJHqWaTwIbwZ9FV0HeRsvRbWkBogchW8HDZ/fxdd3PyxVfv3MPSow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRuj4-00C8rn-0u;
        Tue, 14 Feb 2023 13:48:02 +0100
Message-ID: <8512c5c275dbbb9f3f9d5e946905c3a3fc35457b.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: support poll sta for ML clients
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sriram R <quic_srirrama@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 14 Feb 2023 13:48:01 +0100
In-Reply-To: <20230119221240.24441-1-quic_srirrama@quicinc.com>
References: <20230119221240.24441-1-quic_srirrama@quicinc.com>
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

On Fri, 2023-01-20 at 03:42 +0530, Sriram R wrote:
> Update the client probe handling which sends Null data
> frames to check inactivity to support ML Stations as well.
>=20
> Replace the use of default bss conf with the link specific
> conf and use the stations default link to send the probe
> frame. Non ML Stations associated to the ML AP would use
> its default link as well which is one of the active links.
>=20
> For Non ML AP, the default link id is 0 and it is taken care
> as well.

This seems very wrong.

It seems like if we have a link here then userspace should pick it.

But! The station could have disabled that link, for example, after
having used it for association. The station always has the deflink used
(unlike vif) but there's nothing that says that it must actually be
active at any given time.

However that obviously means userspace _cannot_ pick it.

And then really it means we should address this frame to the MLD and let
driver/firmware pick the right link, and do address translation on it,
etc.

After all, we want to know the MLD is still there, not a specific STA,
right?

johannes
