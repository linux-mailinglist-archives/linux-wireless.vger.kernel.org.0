Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91B06963E3
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 13:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjBNMuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 07:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjBNMuV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 07:50:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A110FC
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 04:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xT7ZT0M7pj7pucvZRxfm/Cpa0bD44LbZ0IlMHvmWze0=;
        t=1676379020; x=1677588620; b=yCle/LH9uzqBsGIw5XEv2lmvKdrD0aJDc5sToTvHT7Om87q
        slSyf9N0u/KjpnuigEzRLyDLSkOwhvEZtXR/USIZwh0VbOsqFm876JQXNUk3ZDJwMzyr73+el9O5A
        eQlI2EbFR3eqHIQIn8MFTDYPqnPLawFqwy5THMJBFLlEDcllz6QNtIqcT/vGp3iP6Gv2WUlSoL1rg
        Ooy8r8Qq6Rvt0aAHKRR6+lf7dMMz451GBci8Qr8SDfFRy+uKGgnM36/ZgZ4Vwmw8+H0V6nBo2Qmpg
        33685cEDo0s1pzLHrSA8U0BW7wbXO6xxwuITudpZz6Balphfsi1Knz6KSlVPumJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRulG-00C8v1-0c;
        Tue, 14 Feb 2023 13:50:18 +0100
Message-ID: <92344e56e895b18a33ff6d9eed2a2b58e6d92180.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: cfg80211/mac80211: add support for channel
 switch with MLO
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 14 Feb 2023 13:50:17 +0100
In-Reply-To: <20230118151604.1278-2-quic_adisi@quicinc.com>
References: <20230118151604.1278-1-quic_adisi@quicinc.com>
         <20230118151604.1278-2-quic_adisi@quicinc.com>
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

On Wed, 2023-01-18 at 20:46 +0530, Aditya Kumar Singh wrote:
> +++ b/net/mac80211/cfg.c
> @@ -1488,6 +1488,13 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, =
struct net_device *dev,
> =20
>  	mutex_unlock(&local->mtx);
> =20
> +	/* The below work requires sdata lock which we have already acquired
> +	 * here. But before that, it will check whether link_conf->csa_active
> +	 * is true, which we have made false above. Hence, it will not proceed
> +	 * to acquire the sdata lock and deadlock will be avoided.
> +	 */

This is obviously wrong.

I know the locking here is hard and that we may need to make some bigger
changes to support cancelling these work items properly, but this
doesn't address it at all.

johannes

