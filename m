Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8A6E2140
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDNKth (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDNKte (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:49:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7468B93F7
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FFqWWqcg+eLPvzXi23BcqD9cmTgxy77R+/SgiTV18Uc=;
        t=1681469359; x=1682678959; b=v7dZs5qxbL/TA4l+gcTMQmALD1e8QuEhE25fbNEYynKNzp7
        p6Veiy5/3jRVSi0fO+GzRNBb86Z43B5ZETVsyrnYjhuimCeyoqFqESEmnXhqtlYEDbOxAlbiDCtV5
        jMIELW8t3/4UTXuKiEk3j8QT1XeObhv9pKJY3DmW2xpzlsZiE/7PbCeh6aQns3wFmArVtL6GdVQwG
        M5OzVJKOtr69bGn/azm5MGZpoUOS1eDkPpLAOpXDKFtYJvinQc6mIkoqiohKn56FBbw9t/C5eXhuO
        ZOcPlMJrl3Yq1tRP0QXNaWEgGXTbyBTDzTAA5swCyKExGZsOQ4/638C6yYDpRcWg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pnGzV-00FYto-1J;
        Fri, 14 Apr 2023 12:49:17 +0200
Message-ID: <d595419a19c4707848eefd8d5dec86ca877f8b1e.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: Add more VHT capabilities reporting
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Anthony Refuerzo <anthony96922@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 14 Apr 2023 12:49:16 +0200
In-Reply-To: <20230217084044.11424-1-anthony96922@gmail.com>
References: <20230217084044.11424-1-anthony96922@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-02-17 at 00:40 -0800, Anthony Refuerzo wrote:
>=20
>  	/* RX STBC */
> +	switch ((capa & 0x700) >> 8) {
> +	case 1: printf("\t\t\tRX STBC 1-stream\n"); break;
> +	case 2: printf("\t\t\tRX STBC 2-streams\n"); break;

wait, isn't that wrong, this should be +1 (and can also just use the
value+1 instead of having all those switch cases) no?

Also generally, I'm not a huge fan of those compressed case statements
yeah it seems denser at first, but then at least I had to look twice if
the break was there, etc.

> +	printf("\t\t\tMax A-MPDU Length: %d (exponent: %d)\n",
> +		(1 << (((capa & 0x3800000) >> 23) + 13)) - 1,
> +		((capa & 0x3800000) >> 23));

this kind of thing really makes me want to have bitfield.h from the
kernel, but I guess we can't just copy that due to the license ... oh
well.

but at least it could use a variable for the exponent, so it doesn't
have to be done twice? :)

johannes
