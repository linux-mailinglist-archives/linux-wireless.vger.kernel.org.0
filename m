Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1742603AD8
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 09:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJSHm2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 03:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJSHm1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 03:42:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E0E5FAD2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sr4uNjhD4A9/LGABpcIyC5VAFPcKwgRbzM9hQzdkQRE=;
        t=1666165346; x=1667374946; b=G+wgZoqF93QudB5RyBkpNdnVFKox3pYe1d31Cldp1cBcNfw
        iclAbCC9bR7OcbbRN4Xqqt6FZSGuk+U5t3adpK7biGkrD+PHSw3oAO4sPF82Un4p3kKE+vV7Z7RL9
        WgfJ2gSnmQ45rxSIW+Vsu7RyNI8igIwFn5po2kKEYpM62bo9UI+qRHqgyNOFulBCtIj8+mUBjJCfS
        REhtVhebEcM2Eo3y31CnaZYT4Av3vrCpYejgisNAxbce68jw7bHvNVtme+1Y6fUrI0FGM5HCZpFQF
        2U9shTQ7wgapczTVelJ48Rs9ZheS5QgQxxQZISZg7omGU/0KxDuJGK07caOdhwCg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ol3iZ-00B0vS-1K;
        Wed, 19 Oct 2022 09:42:23 +0200
Message-ID: <a47bf10273caff11c638ffbbfd7960fc84dbe0b9.camel@sipsolutions.net>
Subject: Re: [PATCH 4/7] cfg80211: add NL command to set 6 GHz power mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 19 Oct 2022 09:42:22 +0200
In-Reply-To: <df0b368c-3b84-653e-6ef8-5446b75ce797@quicinc.com>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
         <20220704102341.5692-5-quic_adisi@quicinc.com>
         <b36799bc1129baebbb64032deeaae72e4ca1af7b.camel@sipsolutions.net>
         <df0b368c-3b84-653e-6ef8-5446b75ce797@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Wed, 2022-10-19 at 09:54 +0530, Aditya Kumar Singh wrote:
> On 9/6/2022 16:35, Johannes Berg wrote:
> > On Mon, 2022-07-04 at 15:53 +0530, Aditya Kumar Singh wrote:
> > >=20
> > > + * @NL80211_ATTR_6GHZ_REG_AP_POWER_MODE: Configure 6 GHz regulatory =
power mode
> > > + *	for access points. Referenced from &enum ieee80211_ap_reg_power.
> > > + *
> > > + * @NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE: Configure 6 GHz regulat=
ory power
> > > + *	mode for clients. Referenced from &enum ieee80211_client_reg_powe=
r.
> >=20
> > I don't really see a good reason to have two attributes for this, rathe=
r
> > than validating their value based on the iftype?
> >=20
> The policy for each varies. For AP power mode, it can vary from 0 to 2=
=20
> (total 3 power modes currently), and for clients 0 to 1 (total 2 power=
=20
> modes). So, if we have just 1 NL_ATTR, while parsing obviously we can do=
=20
> based on iftype but in NL_ATTR policy validation, for clients it will=20
> pass value 2 where actually it should not. Will that be fine?

Yeah, I dunno. That just means we'd have to validate it in the code
rather than the policy. Not really sure which is better.

johannes
