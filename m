Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6B777D036
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 18:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbjHOQhZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 12:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbjHOQgy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 12:36:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C531F10E3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=f+/S+SOoPSL+WW0wjpxqkVbBWnc7pA+nvQVlHswHNL0=;
        t=1692117413; x=1693327013; b=ABuQmY0fVK877qTp+OcN1VRFpOf93Zq5YS/0i7uHfOWvhOR
        KyN2mrs6TTWxIvyQlQmRq5If2b+eqf2XwPBSEc9kbYNPKx1fFLoSGb82VR4oE1YmFZNUgHO4xFYiL
        yZPNqqIK+gLyRW4wYwSEdippqYqHvTWpC5STn37DJaIc3AON8jzXMWWsBxHIPXawdbWMPjCZel1fV
        sX6R6qxwpOHMRLrHBJXx+NkAL+NpV0qqnT5nSPO/Um+V0xKemKmMa+5UgO2D4+8192zxoQ3Ul1Mni
        KksjZ4He89fYDrhtaAgVJtnf0dYn4RZg1vbQ0a657mf0XBiZNoJM9zuDjWxWR3WA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVx2J-0093CS-20;
        Tue, 15 Aug 2023 18:36:51 +0200
Message-ID: <e7de5c256abf35cad890964842efa2f8f4c8cc77.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: ocb: don't leave if not joined
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com
Date:   Tue, 15 Aug 2023 18:36:50 +0200
In-Reply-To: <20230815183202.f5edf5ebc737.I3cbb49aa52aed2bace903a019f7300c66c61ea83@changeid>
References: <20230815183202.f5edf5ebc737.I3cbb49aa52aed2bace903a019f7300c66c61ea83@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-08-15 at 18:32 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> If there's no OCB state, don't ask the driver/mac80211 to
> leave, since that's just confusing. Since set/clear the
> chandef state, that's a simple check.
>=20
> Reported-by: syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com
>=20

Note there are at least three different signatures in this syzbot
report, similar warning but different things that happen ...

johannes
