Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002B577E28E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 15:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbjHPN2H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245584AbjHPN1v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 09:27:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7E0268A
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8zxGsWuPzNFx3gnngQsb4CZc20+YpQJixMOk4dUOoyc=;
        t=1692192467; x=1693402067; b=Z5uZ9BfmqxKPhJFJN16JfkV8fVAKhhgOxrUSZGdBzDd4V4c
        fxDWx0j4Zp7C1ex4H4hxChqBbQkkK10aHD/D1Fk3Lt+rfCv0bK6zU87y28r/vzfiJsRKqu/pCRPit
        rvx3Edre70hh0f3KPieTXezPnw+gLB3Yc+z6TNr1/xrasPHur+NlyOsNTeP30ToPK7BNF8jdLJNlq
        vr4zZJmy9StaXIo2IWalQBxRIeVDX1dia2Do9U6iYdU8dOtVliiPCnQXfArwZ6ytkNPxme4yMzh12
        /xSgAeI5OkCAh8umFRgMuOt3lvURoP8uWEwR5Sn0CQClb80fTPyl8h07ILiGCvFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWGYr-00AxW1-21;
        Wed, 16 Aug 2023 15:27:45 +0200
Message-ID: <0b072729eb4d131df7daad3ebb683783549e5686.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 6.1] wifi: cfg80211: fix cqm_config access race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Max Schulze <max.schulze@online.de>
Date:   Wed, 16 Aug 2023 15:27:44 +0200
In-Reply-To: <20230815153741.cc51cb52a296.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
References: <20230815134247.4b4bd52ea708.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
         <20230815153741.cc51cb52a296.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
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

On Tue, 2023-08-15 at 15:37 +0200, Johannes Berg wrote:
>=20
> =20
> -	err =3D cfg80211_cqm_rssi_update(rdev, dev);
> +	err =3D cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
> +	if (err) {
> +		rcu_assign_pointer(wdev->cqm_config, old);
> +		kfree(cqm_config);


OK, that's wrong wrt. RCU handling, maybe that causes heap corruption if
someone sees wdev->cqm_config under RCU but it was freed and re-
allocated.

I think I'll just remove this failure path handling change entirely and
do it separately.

johannes
