Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073DA6D00A6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjC3KGf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjC3KGd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 06:06:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80A7689
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JfFJZNchjeMN1TQ8MGFZliQJTBtxtlbHA0I4GjdbyTQ=;
        t=1680170792; x=1681380392; b=lUwWyOUJif+53aGo0m0FoC/snCOORVoeFLjDOV0RgWPSi9d
        jNUGF+uc8Iw4WzGqOSSGnpRo6WVdCYr+Q8faPyU8gxEBoBgQ4U8otPjRWA5HSWAR5f+dZJZvhLK5d
        KZqD0PMN+X8OCb7GCoGj4uSdjxuo14skDIhLnTqwC9F9vyRF+Km5MFp0WZzzwpen7IEea2qiU1gBs
        WsaJiR9/IRvzuWAi43bBDkqK85Bhe2wCNxTbRZWMLTGo4oQY31aWlrblSbZjCRAbFE7wo1xohpPUo
        rUruKgqAdqa7BPZJR33ivLmpUWeHj43RZjfEBMdcorD6w9kGZ0BUY3SpWrbv7ueA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1phpAs-000yop-17;
        Thu, 30 Mar 2023 12:06:30 +0200
Message-ID: <78fc12945f0f4ed90836e9031fd18d95a8c473a8.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Initialize EWMA fail avg to 1
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Karthik M <quic_karm@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Date:   Thu, 30 Mar 2023 12:06:29 +0200
In-Reply-To: <20230317144432.10477-1-quic_karm@quicinc.com>
References: <20230317144432.10477-1-quic_karm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-03-17 at 20:14 +0530, Karthik M wrote:
> If the average value has been rounded to 0 (success),
> reset it to the smallest nonzero value (similarly to the initialization) =
to
> avoid a case where a single failure would result in an average value
> that goes beyond the threshold value of 95.

What does 95 have to do with it?

Also the whole commit message doesn't even mention mesh a single time.


> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Karthik M <quic_karm@quicinc.com>
> ---
>  net/mac80211/mesh_hwmp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
> index 9b1ce7c3925a..e9fcaff9cc7e 100644
> --- a/net/mac80211/mesh_hwmp.c
> +++ b/net/mac80211/mesh_hwmp.c
> @@ -298,10 +298,21 @@ void ieee80211s_update_metric(struct ieee80211_loca=
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
> +		/* If the average value has been rounded to 0 (success),=20
> +		 * reset it to the smallest nonzero value (similarly to=20
> +		 * the initialization) to avoid a case where a single=20
> +		 * failure would result in an average value that goes=20
> +		 * beyond the threshold value of 95 */

Comment style, trailing whitespace ... please run at least some kind of
checkpatch yourself.

johannes

