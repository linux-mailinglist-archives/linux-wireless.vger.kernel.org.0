Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D173A588
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjFVQHc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFVQHa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:07:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5A5199F
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XhCI5rI9FtpLEhhWuf52l5MTNbLY8bL6LaTVqV30ue4=;
        t=1687450048; x=1688659648; b=pdHk/iM9rogM7GHQ5CzdcrBIUcVnh4xu2R/uHL2W3Aa8c4H
        16n421qvqPvQkJKuGh6csra056HOuXtm3FeYHc9gdomlYyeN4urReHf2ZBUKonkIHwt4lO88/vHZ7
        c6f+LKdSwD22Nk48+YIdxHfYaZbpX+JE6YUUqYf7Mz+LFHfbk0bgaYc+nomI9j0Hs//uoCfNOFfkI
        X4Cu2lSb/yGlHuRVdko5jUHm78vb0EBYMjBnZD7oyxzpBUMXylUiopAM2ltEIWkXAtf/YOEWcg5E1
        2AHdPret20y5GuTaTtUzXRWopwTUfkSiUlYBO973E+luIKQVRH0SD95cybAnvVHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qCMqD-00Eo8R-1E;
        Thu, 22 Jun 2023 18:07:25 +0200
Message-ID: <adf8c1b8ea96c0c6ddc12579eacb8d9948440dcf.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: fix sband iftype data lookup for AP_VLAN
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Thu, 22 Jun 2023 18:07:24 +0200
In-Reply-To: <20230622160501.40666-1-nbd@nbd.name>
References: <20230622160501.40666-1-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
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

On Thu, 2023-06-22 at 18:05 +0200, Felix Fietkau wrote:
> Since AP_VLAN interfaces are not pushed to the driver,=C2=A0
>=20
That's a mac80211 thing though.

> the driver should not
> be expected to register iftype data for them.
> Map them to the regular AP iftype on lookup.

And this is in cfg80211 - not sure that seems right?

OTOH I'd expect no callers with VLAN here, it doesn't really make sense
since they're not a standalone mode that actually has HE/EHT, but still,
seems odd this way?

What's actually calling it? I'm guessing somewhere in mac80211?

johannes
