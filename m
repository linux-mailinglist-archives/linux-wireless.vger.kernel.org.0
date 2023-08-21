Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE417824A2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 09:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjHUHkg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 03:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjHUHkf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 03:40:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620CECA
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=a2YnMR9sKL36w+fjRI775d8yUbY27E77h+cTuZKWsZs=;
        t=1692603623; x=1693813223; b=KzLZEjvLcZr/r+0yhPeywYZPVubNykbkvzICKO7G6NnQDG5
        xtHMs4W/+i0wkFwXsUQLe32Ud1/ejxwXaykuSxMYouKtBUdrl7timIiGklp/QkUzsvCPaCb+3NsTu
        sA3RYIz/Fy4tEZ384VNf7Jq+VHJ0E2CZ/WlT4mHOTgcqdt1z9DQtO6TXW2y3xlwnLGTdmn+A6xms7
        dEREmig/xdVd5ON8TEw3tSRjCNe37DiNvm8tpxT4HYmgPWwrpDbxLeVFyXk1na7RGCCOnTaB1CoqR
        /lNgtmxBB/fddU0Y7dWLHwa5lnGq9wg4yLnZd+i7iHIIZZuoi+c5n45GNovDyZwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qXzWJ-002qhK-1p;
        Mon, 21 Aug 2023 09:40:15 +0200
Message-ID: <5c072b0a45ad29dc03b989fbd9a9fd974ae0c23d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix cfg80211_bss always hold when assoc
 response fail for MLO connection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 21 Aug 2023 09:40:14 +0200
In-Reply-To: <20230821061355.18168-1-quic_wgong@quicinc.com>
References: <20230821061355.18168-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-08-21 at 02:13 -0400, Wen Gong wrote:
>=20
> +++ b/net/mac80211/mlme.c
> @@ -5429,17 +5429,22 @@ static void ieee80211_rx_mgmt_assoc_resp(struct i=
eee80211_sub_if_data *sdata,
>  	for (link_id =3D 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
>  		struct ieee80211_link_data *link;
> =20
> -		link =3D sdata_dereference(sdata->link[link_id], sdata);
> -		if (!link)
> -			continue;
> -
>  		if (!assoc_data->link[link_id].bss)
>  			continue;
> =20
>  		resp.links[link_id].bss =3D assoc_data->link[link_id].bss;
> -		resp.links[link_id].addr =3D link->conf->addr;
>  		resp.links[link_id].status =3D assoc_data->link[link_id].status;
> =20
> +		link =3D sdata_dereference(sdata->link[link_id], sdata);
> +
> +		if (!link) {
> +			/* use the addr of assoc_data link which is set in ieee80211_mgd_asso=
c() */
> +			resp.links[link_id].addr =3D assoc_data->link[link_id].addr;

As I mentioned before, this cannot be done - it introduces use-after-
free since assoc_data is freed after the loop, and the
cfg80211_rx_assoc_resp() is after that.

> +			continue;
> +		}
> +
> +		resp.links[link_id].addr =3D link->conf->addr;
>=20

Also, I don't see that we need to use two different assignments for the
two cases.

johannes
