Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB186966EF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 15:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjBNOeB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 09:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjBNOeA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 09:34:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A5861A5
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 06:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Kye4XejH1SLc7iQMen0gZQWdPniYKzSte/j+/w3Hhnc=;
        t=1676385239; x=1677594839; b=GtAcELEguaQ3Vsa7Zb2LEDZD+fUFM/KENGFQUJvXvhKpgF2
        xROSIpw87idyQL2baHxJL88/Hxlo+UOjr1aAotQraK9O1+5spLHPO/KeC0G16chcKLm1H889LX5G6
        mtmyACPmkGNn2yoXfoJ3PZHcJAGYlMUGo1HTzG9S01iLyVD88s1RAH7BdJdv/tyyw4wxBu6VXsUW/
        omAkJ7RNix/EIgbxOzSaOvwA55MY6s3niiXcv1SFOG6JaNxW8F9NFB6YNZJh6ijbTmCYbSqcKQkR7
        NA0b1exDTey/NA5dJ0SCwjBPv5OLR8um2mPmEKfcUw/CN3pkEKvWuKaBLQCHSpKg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRwNZ-00CAuo-21;
        Tue, 14 Feb 2023 15:33:57 +0100
Message-ID: <d9461ebd1a17608f73ef832c60fa7489e358a84e.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: support RNR for EMA AP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 14 Feb 2023 15:33:56 +0100
In-Reply-To: <20221114230416.20192-3-quic_alokad@quicinc.com>
References: <20221114230416.20192-1-quic_alokad@quicinc.com>
         <20221114230416.20192-3-quic_alokad@quicinc.com>
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

On Mon, 2022-11-14 at 15:04 -0800, Aloka Dixit wrote:
>=20
>  	if (params->mbssid_ies) {
>  		mbssid =3D params->mbssid_ies;
>  		size +=3D struct_size(new->mbssid_ies, elem, mbssid->cnt);
> -		size +=3D ieee80211_get_mbssid_beacon_len(mbssid, mbssid->cnt);
> +		if (params->rnr_ies) {
> +			rnr =3D params->rnr_ies;
> +			size +=3D struct_size(new->rnr_ies, elem, rnr->cnt);
> +		}

Is this right? The struct_size() is only the size of the struct, but you
need the size of the elements contained in it here, i.e. the sum of the
.len fields?

johannes

