Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F175AE499
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 11:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiIFJoE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 05:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbiIFJnq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 05:43:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E7378BEE
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=v5agCecfRutREzg/STNW1gkMfp/iXe1AKcVzGxL7Hx4=;
        t=1662457415; x=1663667015; b=ApEy1c/uTo55tIYiKOmaP9SYmmM3qMeYtLWP5ODCC26GMbj
        KhRPBONN/xLJzg+azPZklHrH2Q6lvMN8xkcWO+/ICwv/n5D5WCeOp8wUFHCqHrXBqCTGBLppGzsuR
        IeKkdyJoa82secTE3RcS1c0FDjm0Wdqqrp+/hIJeCmFHN9r675GKbUa5mqKkR6Vra/hnHzuceiHLP
        61ahdasiJ2nv+np+I+TPNavnvAY6gu8oX4JtmRW7my3o3QY14M/ue5S/7dwon/6tVasJHFON4U2hJ
        OwZ/hSQvtuFX5G7vEhC6cdQWrM9bnGRlUURwSfd3+Qdcl/mY4SLmHNLLIY0MP7vQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVV7E-009Mjp-1u;
        Tue, 06 Sep 2022 11:43:32 +0200
Message-ID: <d58015ea844a0b56ea39de5f63b7f6889afcd918.camel@sipsolutions.net>
Subject: Re: [PATCH v3 03/12] mac80211: S1G beacon/short beacon support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kieran Frewen <kieran.frewen@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com
Date:   Tue, 06 Sep 2022 11:43:31 +0200
In-Reply-To: <20220906044812.7609-4-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
         <20220906044812.7609-4-kieran.frewen@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Tue, 2022-09-06 at 16:48 +1200, Kieran Frewen wrote:
> If configured, use the S1G short beacon format. The S1G short beacon
> format includes a limited set of information elements.
>=20
> Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
> ---
>  include/net/cfg80211.h     |  2 +-
>  include/net/mac80211.h     |  1 +
>  net/mac80211/cfg.c         |  1 +
>  net/mac80211/ieee80211_i.h |  1 +
>  net/mac80211/tx.c          | 14 +++++++++++++-
>  5 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 945e7700de66..b750b2ad246b 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1328,7 +1328,7 @@ struct cfg80211_ap_settings {
> =20
>  	struct cfg80211_beacon_data beacon;
> =20
> -	int beacon_interval, dtim_period;
> +	int beacon_interval, dtim_period, short_beacon_period;
>=20

One way or the other, this doesn't belong into this patch - you should
reorder so cfg80211 comes first and then mac80211 can use it, and then
this change goes into the cfg80211 patch.

johannes
