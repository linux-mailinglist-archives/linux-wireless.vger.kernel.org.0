Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7004C4D616C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 13:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbiCKMVh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Mar 2022 07:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiCKMVg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Mar 2022 07:21:36 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94FF1B2AE2
        for <linux-wireless@vger.kernel.org>; Fri, 11 Mar 2022 04:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dWSroW6uTeFiwZyURixo9RYgFQ2qB/m2hp8si0wAD5s=;
        t=1647001232; x=1648210832; b=u+p5f0VrlNpcDvpvRigILkUetMMeGeBYCumhctfMprodGcv
        3KT+i7cdvs0+w3ArTsPGpdGlBY0M9ObM2S8i0i3vLrg6PN+wha0UctR5tuxzibIANEB3tJfH/+2qy
        EgFAuzz8fsvbO2PLBSuv8aEBSqVwPVDKiMr90UDlOAUp5Y8GQKvyl2sawj+Hg7h2IlnHOlOWdFpv/
        omZ43pW5Ns1HTSKi9wOuKp/b7wnJ1ppyPgA+zCLkz+hUs4R9pqHqEqcTcKVuF1zrmwfZOi7ieixUx
        pIGjiCGyJUPW75kdqb0hfCF7Lx4PKLh1pQ4eXa6C8isUss6G/Dnd8IdRJ5z4T8CQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nSeFz-00Btrv-8q;
        Fri, 11 Mar 2022 13:20:31 +0100
Message-ID: <fa3389544e67220b11e0f905a0fa724a165f0445.camel@sipsolutions.net>
Subject: Re: [PATCH v2 3/3] cfg80211: Add support for key operations on
 NL80211_IFTYPE_MLO_LINK
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, quic_usdutt@quicinc.com
Date:   Fri, 11 Mar 2022 13:20:30 +0100
In-Reply-To: <1645613200-30221-4-git-send-email-quic_vjakkam@quicinc.com>
References: <1645613200-30221-1-git-send-email-quic_vjakkam@quicinc.com>
         <1645613200-30221-4-git-send-email-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-02-23 at 16:16 +0530, Veerendranath Jakkam wrote:
> 
> --- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
> @@ -1123,17 +1123,25 @@ void ath6kl_cfg80211_ch_switch_notify(struct ath6kl_vif *vif, int freq,
>  	mutex_unlock(&vif->wdev.mtx);
>  }
>  
> -static int ath6kl_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
> +static int ath6kl_cfg80211_add_key(struct wiphy *wiphy,
> +				   struct wireless_dev *wdev,
>  				   u8 key_index, bool pairwise,
>  				   const u8 *mac_addr,
>  				   struct key_params *params)
>  {
> -	struct ath6kl *ar = ath6kl_priv(ndev);
> -	struct ath6kl_vif *vif = netdev_priv(ndev);
> +	struct ath6kl *ar;
> +	struct ath6kl_vif *vif;
>  	struct ath6kl_key *key = NULL;
>  	int seq_len;
>  	u8 key_usage;
>  	u8 key_type;
> +	struct net_device *ndev = wdev->netdev;
> +
> +	if (!ndev)
> +		return -EOPNOTSUPP;
> 

Rather than changing all the drivers in this way, it's probably better
to introduce a WIPHY flag "supports MLD" and allow a non-netdev wdev to
appear only when the flag is set?

That still changes the prototype from ndev to wdev, but doesn't require
the introduction of a lot of "!ndev" changes, which would be needed for
more operations, and probably we can then just add a single line

	struct net_device *ndev = wdev->netdev;

at the beginning of the variable initializer block (even with spatch), 
without changing everything else.

Seems nicer? What do you think?

johannes
