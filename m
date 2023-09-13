Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE879E2CC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 10:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbjIMI6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 04:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbjIMI6u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 04:58:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED391993
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IJmGX4PzqBWbICPZgzgys4nGdzhJ0QEPwQa9yf0ZT1c=;
        t=1694595526; x=1695805126; b=tf91t3cp1wxXPIjp3PA8CZrsGMNO6TmAzJxhzvsqkP4tDpa
        XMmsIhmdOuYXfiL/Tzp7c5eUbTsIukzSZBuEpV3qHL30Za9M+hve59VqyMTiORRiKex3Sz3ai4HOx
        XjUlVM2h2HGn7/Edszljg/XesbltVPI4UVYYYk0oHMyvLBpTozVIWJuuJB46K9zb5Qv/WUD1ZQqsG
        UwKNK24aDJrrRtAAVhkNVS8u3zH7BTwiTcbLQj7l7+y4EopF/5zrIBsO2n106sWts9xSuE340x4st
        PXol+FRhreo/DOd6RofAVmCIiZHxwnZ1/F9aU5DfxyBdBce4sU+LCPdASMzT4MZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgLhn-00Ehnm-33;
        Wed, 13 Sep 2023 10:58:40 +0200
Message-ID: <4b597bba9dc13c3260f174826de38b4f1bc3bf6e.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] wifi: mac80211: add support to allow driver to set
 active link while connection for station
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 13 Sep 2023 10:58:38 +0200
In-Reply-To: <20230906103458.24092-3-quic_wgong@quicinc.com>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
         <20230906103458.24092-3-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-09-06 at 06:34 -0400, Wen Gong wrote:
> There are 2 fields valid_links and active_links in struct ieee80211_vif
> of mac80211. For station mode, valid_links is always include the bitmap
> of active_links. valid_links stores the bitmap of links which is created
> in mac80211, and mac80211 only indicate the info of links which is existe=
d
> in active_links to driver. Finally, the active_links is the bitmap of
> links which station can interactive with MLO AP it is connected to.
>=20
> Currently the active links is always only contain the primary link,
> primary link means the link used by the latest exchange of successful
> (Re)Association Request/Response frames. Then it will always have only
> one link in driver after connected.
>=20
> Hence add this ops in struct ieee80211_ops to allow driver to determine
> the active links bit map dynamically while connecting to MLO AP.

This commit log does nothing to address the question "why do we need
this", particularly since we already have
ieee80211_set_active_links(/_async), so the driver can pretty much
immediately enable all the links it wants.

I see no value in this patch whatsoever.

> @@ -166,6 +167,13 @@ static void ieee80211_set_vif_links_bitmaps(struct i=
eee80211_sub_if_data *sdata,
>  		WARN_ON(dormant_links);
>  		break;
>  	case NL80211_IFTYPE_STATION:
> +		active_links =3D drv_calculate_active_links(sdata->local, sdata,
> +							  valid_links & ~dormant_links);
> +		if (active_links) {
> +			sdata->vif.active_links =3D active_links;
> +			break;
> +		}
>=20

I also _really_ don't think this should operate at this low-level
infrastructure.

johannes
