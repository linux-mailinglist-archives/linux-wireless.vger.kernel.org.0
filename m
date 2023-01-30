Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA006807D3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 09:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbjA3ItO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 03:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbjA3ItA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 03:49:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0BC7287
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 00:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0qp6HVlKC67m5za4MUq2+XE9c9SrZj4WElmrkWUD/tI=;
        t=1675068516; x=1676278116; b=Uu2t+BvA5xGz1du8aESWn16rf0iP5UCBU7DvOwSFiH8QsJ1
        1bw/NkOurKcaj3VWWT54WnfmdIJYIbwS3uSVPbHnmAquacYaJBs/x1jgrsqZdLzFu3LnPpYwwciAo
        Zdjm0K37gTMEH6ujB4Tvs2E0hSePzCw4BQN9uIt0+puYKTw5et+TSzwYSjEAQYRB8sg85cTMTzeuv
        KhIao9Lw9nKxAO6jIgE2qeV7X+C40docGHARVL2o3r6jYy+Cg9xvwgXEzEm9Wop8Gvf0sTWgaCor4
        VU7Ga3VhpLdR5/2cMTMEXPuV10RxtV78UMN/VvgpOR8UV38JrK9BZDFu80K3DZ8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pMPq5-00G1L2-39;
        Mon, 30 Jan 2023 09:48:34 +0100
Message-ID: <a22a32c66189dc715c6faf00778e44dccb8fb5ac.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/6] Puncturing support in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 30 Jan 2023 09:48:33 +0100
In-Reply-To: <20230130072239.26345-1-quic_alokad@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
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

Thanks!

> Aloka Dixit (6):
>   wifi: nl80211: configure puncturing bitmap in NL80211_CMD_START_AP
>   wifi: mac80211: validate and configure puncturing bitmap in start_ap()
>   wifi: nl80211: configure puncturing in NL80211_CMD_CHANNEL_SWITCH
>   wifi: mac80211: configure puncturing bitmap in channel_switch()
>   wifi: cfg80211: add puncturing bitmap in channel switch notifications
>   wifi: nl80211: add puncturing bitmap in channel switch events
>=20

I feel like maybe you can/should squash 1 and 3, 2 and 4, and 5 and 6?

1/3 are cfg80211 for config, 2/4 are mac80211 for config, and 5/6 are
basically both cfg80211 anyway? Of course 5 updates the users.

And maybe I'd then reorder and put them in this order:

 - new: validation move
 - 1/3
 - 5/6
 - 2/4

so 5/6 just pass 0 from mac80211 to cfg80211_ch_switch_started_notify()
and cfg80211_ch_switch_notify(), and the mac80211 patch (2/4) fills in
the actual values. That way the cfg80211 patch is 'pure' API, no
functionality changes.

What do you think?

johannes
