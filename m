Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891425A2574
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbiHZKIW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbiHZKIF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 06:08:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9F3DB067
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PDuvFPTo8HiHHGWKwAUaiAGHb7eN4Oeuhh0ZRdSICKs=;
        t=1661508432; x=1662718032; b=gYDsdPA89kCSD47JDydjrWg2lXxSuZTL44798DzQO2s7yJk
        p3hBz8c1FdhKuZfRXIjBiR/VyEP07gu5mmAqcvd2L/BSjpQeWlQGekhBcWUrVeXkrUli+GrlMiWkr
        z/C1M0RtpspTValfJI+bXoyw60RdElW2f8sBoGKcK8BQu6KETaPNhikWy9NAcljJ15dyjVDGFvTho
        Qyz9u/7hrVE3cj81xaKDLxquUMxtqTgxqiRw0ttZFVxBcsbz0ok9G/PPB0VjcVgPFxt6CIHOMy82Q
        zrkZ9SjGADj0dGAQ5KnOSiI1Nd0uWHQlAkyYcibsAh2sPlzHkoUp575gxoFYYseg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oRWF3-000C6V-22;
        Fri, 26 Aug 2022 12:07:09 +0200
Message-ID: <ad9a0e601a5e7dd2642be9ae8b17c1408a8bd1d1.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] cfg80211: Update Transition Disable policy during
 port authorization
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Date:   Fri, 26 Aug 2022 12:07:08 +0200
In-Reply-To: <a408102ee0917de77ecb3a0b63cd7c650ba93750.1661506891.git.vinayak.yadawad@broadcom.com>
References: <a408102ee0917de77ecb3a0b63cd7c650ba93750.1661506891.git.vinayak.yadawad@broadcom.com>
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

> In case of 4way handshake offload, transition disable policy
> updated by the AP during EAPOL 3/4 is not updated to the cfg80211
> layer. This results in mismatch between transition disable policy
> between the upper layer and the driver


I find this a bit confusingly worded - cfg80211 doesn't care, so it
doesn't need to be updated _in_ cfg80211. "To" cfg80211 sounds a bit
weird. Maybe just phrase that in terms of userspace?

> +++ b/include/net/cfg80211.h
> @@ -7669,7 +7669,7 @@ void cfg80211_roamed(struct net_device *dev, struct=
 cfg80211_roam_info *info,
>   * indicate the 802.11 association.
>   */
>  void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
> -			      gfp_t gfp);
> +			      const u8 td_bitmap, gfp_t gfp);

Missing docs.

Also missing the corresponding driver update, even if it should just
pass 0 for now in this patch to not have a lot of new driver logic here?

Or maybe it should be valid to pass -1 (i.e. make it a s16) to avoid
passing it to userspace when the driver doesn't know?

Also no point in marking the parameter const.
=20
>=20
> +++ b/include/uapi/linux/nl80211.h
> @@ -3268,6 +3268,7 @@ enum nl80211_attrs {
> =20
>  	NL80211_ATTR_TX_HW_TIMESTAMP,
>  	NL80211_ATTR_RX_HW_TIMESTAMP,
> +	NL80211_ATTR_TD_BITMAP,

Also missing docs.

>  void nl80211_send_port_authorized(struct cfg80211_registered_device *rde=
v,
> -				  struct net_device *netdev, const u8 *bssid)
> +				  struct net_device *netdev, const u8 *bssid,
> +				  const u8 td_bitmap)


same here about const

>  	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
>  	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
> -	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid))
> +	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid) ||
> +	    nla_put_u8(msg, NL80211_ATTR_TD_BITMAP, td_bitmap))

and yeah maybe here check for <0 or something if it should sometimes
result in a missing attribute?

johannes
