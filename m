Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1936E6555
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDRNFX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 09:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjDRNFV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 09:05:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640815603
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=K7FJ7FI8oAkoE9CPn0O02RL+RzJfQNRy/qZoovLxgX8=;
        t=1681823097; x=1683032697; b=Yqg2QIsCL7h7RpE4zaVIbxmNmUr276n9v97Nyqivj2Rc3Mb
        +i1//SwjFdvp2s72SVxVp2MEFU9iJQASSkEx7lJ3hxTnXtK6dsOUfpmUnUt/2HmFDDlQQqJCSTxns
        ytOLCjbSxhEgO8MMQ8rcIccHtDvOMzX6h05Vmgol6N7d37hBN6itQ5X8eJLD4vXSpNjCvMO2y6y8j
        9Nd6we7MqlMvTKggJISYNHCdSE5HMA8x9m570ymbehl0MeGA/4RbwwOhs8QMUGNQSkoiFak7KiJqh
        U97oQeVGM90mYJ8cKNIpdmfsZGD0addxnjOd9KasgNnmqrG/yo4mDwnhOjURe8Vw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pol0u-001dWz-0T;
        Tue, 18 Apr 2023 15:04:52 +0200
Message-ID: <bc1903aa09391667262aeadf1859600579f0a9f1.camel@sipsolutions.net>
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Karthik M <quic_karm@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Date:   Tue, 18 Apr 2023 15:04:51 +0200
In-Reply-To: <20230417100258.22965-1-quic_karm@quicinc.com>
References: <20230417100258.22965-1-quic_karm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-04-17 at 15:32 +0530, Karthik M wrote:
> If the average value in mesh metrics calculation
> has been rounded to 0 (success), this resets it to
> the smallest nonzero value (similarly to the initialization)
> to avoid a case where a single failure would result in
> an average value that goes beyond the value
> of 95 (Link Failure Threshold).
>=20
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Karthik M <quic_karm@quicinc.com>
> ---
> Changes since v1:
>  - Altered the comment to mention "mesh" and thershold value.
>  - Checkpatch done

This is v2 now, how did an explicit "v1" happen? :)

Anyway ...

> +++ b/net/mac80211/mesh_hwmp.c
> @@ -298,10 +298,23 @@ void ieee80211s_update_metric(struct ieee80211_loca=
l *local,
>  {
>  	struct ieee80211_tx_info *txinfo =3D st->info;
>  	int failed;
> +	u32 fail_avg;
>  	struct rate_info rinfo;
> =20
>  	failed =3D !(txinfo->flags & IEEE80211_TX_STAT_ACK);
> =20
> +	fail_avg =3D ewma_mesh_fail_avg_read(&sta->mesh->fail_avg);
> +	if (!fail_avg) {
> +		/* If the average value in mesh metrics calculation
> +		 * has been rounded to 0 (success), this resets it to
> +		 * the smallest nonzero value (similarly to the initialization)
> +		 * to avoid a case where a single failure would result in
> +		 * an average value that goes beyond the value
> +		 * of 95 (Link Failure Threshold)
> +		 */
> +		ewma_mesh_fail_avg_add(&sta->mesh->fail_avg, 1);
> +	}
> +
>  	/* moving average, scaled to 100.
>  	 * feed failure as 100 and success as 0
>  	 */

This still seems really non-intuitive to me.

It seems to me this is down to the special "0 means init" behaviour,
that you don't want, because your values actually fluctate between 0 and
100, and you can actually legitimately reach 0 with a lot of successes.

But to me it's really non-intuitive, if not counter-intuitive, to say
"oh yeah my values are 0 to 100 inclusive, but I can't ever deal with
reaching 0 because then I jump to 100 immediately". That doesn't make
much sense to me?

I mean, I guess I can see where this patch makes some sense like from a
code point of view, this is sort of the minimal code change you could
make to make the existing code work, but ... I'd argue you're optimising
to the wrong metric here, "minimal code changes to fix the bug" should
normally not be your metric, it should be "code changes that make this
clearer and avoid the problem", or something like that?

Anyway I guess that's all a long-winded way of saying that I don't
really agree with this change.

To me, basically, I see two ways to solve this:

1) we have DECLARE_EWMA_ZERO_VALID() or something like that which
   *doesn't* treat 0 as an uninitialized value, and either has a
   separate "not initialized yet" bit (but that's iffy storage wise),
   or simply has another argument to _init() for the initial value or
   so.

2) you don't just don't use 0 and 100 but say 1 and 100, that results in
   basically the same behaviour, but avoids the special 0.

johannes
