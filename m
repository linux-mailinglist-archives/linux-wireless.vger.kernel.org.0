Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAE06722B0
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjARQMj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjARQLM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:11:12 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E259273
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lSCic0QVAa/Up75IQnwSSirrbU/HEIGIdyM0jLbqwms=;
        t=1674057996; x=1675267596; b=LjmA6GJQRaW9NqtM/z93RbSBrzZCEtFy3x1gdAstEcMetrx
        EdpQvpoIHyOVymlMgoT1R1DfVcPK1iga858FPBLBVlgYbICwFxmUFDmFGZ+rR3zoeX3sjPyDfJIW4
        PLnNkEJ/jsZFCqyrZX4XK0f1erv9saAA8l9DYanIn3/l5b0YqXfQQ3BmdB3KVtu4XBb1l1ueqxN8G
        G3MamLWj03KTYBVs7jy+iHdGbSnOgFGXJZNj6UHVUbylvYja/wOEEutI3xL6nAZI/MP1OekrkfnKc
        46OGe1yl1a1vQBqTmiEZimkfEIQd1Mtw0j4JTIg9ueOspYs/I5CAfq7Bz3vKqDzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIAxO-005f00-26;
        Wed, 18 Jan 2023 17:06:34 +0100
Message-ID: <6b963cb79064fb70eeba7fdcc6ff5abb25348144.camel@sipsolutions.net>
Subject: Re: [PATCH 0/1] Fix __ieee80211_disconnect when not associated
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 17:06:33 +0100
In-Reply-To: <20221025203443.410121-1-prestwoj@gmail.com>
References: <20221025203443.410121-1-prestwoj@gmail.com>
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

Oh I guess I should read the cover letter too ...

On Tue, 2022-10-25 at 13:34 -0700, James Prestwood wrote:
> A user reported some behavior where IWD hangs expecting another event
> to come and it never does. This was due to the firmware (iwlwifi)
> timing out after authentication and calling __ieee80211_disconnect
> which essentially does nothing if not associated. The problem here
> is userspace expects some event to come after authenticating whether
> it be an association, disconnect, death etc.
>=20

Basically I don't understand why userspace expects some event. It asked
for authentication, and you got it. That's all. I don't see userspace
asking for association, or anything else, so what would it be waiting
for?

johannes
