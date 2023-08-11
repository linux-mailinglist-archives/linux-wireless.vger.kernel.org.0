Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41E2778976
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjHKJJM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHKJJL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:09:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCF630C0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kl5XogxFnI73l/sfFXXeYw0AXQWQv1tYcOogssTXXG0=;
        t=1691744942; x=1692954542; b=xIpff9+NOSc6XXsLRyjx0ndi+uVfCL8Xk4T8k0vKIAXpxOz
        MQeajwApDhPwlNVXL8Sv48PvyHQKvpDHW7O17ZEe29NI1xv+OCBybqDNP97/8RuvJhKRANSTbSQf/
        sT3MggUl9UvF655o3k3K+M43jv37EAbcu+vXEYVRt83HkjGaJyI+hL0RmOnqK0A+end0ZqhTwxwfW
        lOoNY1vqrO9XcDnESuL7ux19gO3rO/Vob4VFenFf3vkCTgeldd1qqS9GvW3zw8K1gGGxcy4htpNsO
        za+Mg5JlvVVoWLj0dWVrrN4P+00kbbfUhqi30a5yiyBJLEW3hkTaqCe7WY1eDsyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qUO8h-000oRx-22;
        Fri, 11 Aug 2023 11:08:59 +0200
Message-ID: <8627bb8a3dddc33be7f1f97f30fc0f716328ff81.camel@sipsolutions.net>
Subject: Re: [PATCH 61/76] wifi: nl80211: add EML/MLD capabilities to
 per-iftype capabilities
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org, quic_rkaliapp@quicinc.com
Date:   Fri, 11 Aug 2023 11:08:58 +0200
In-Reply-To: <cc6b83eb-ac30-34fc-4827-290a9ae25378@quicinc.com>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
         <20220713114426.4dfc9ebd0461.Ice7b841051cfeb23da17bb2caa0e45191b34c4db@changeid>
         <d2f17799-6d90-9d72-a389-565163d723d2@quicinc.com>
         <f577425e2d4fd6141c29bcbfbea919565da9326d.camel@sipsolutions.net>
         <cc6b83eb-ac30-34fc-4827-290a9ae25378@quicinc.com>
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

On Fri, 2023-08-11 at 17:05 +0800, Wen Gong wrote:
> On 8/11/2023 5:03 PM, Johannes Berg wrote:
> > On Fri, 2023-08-11 at 11:51 +0800, Wen Gong wrote:
> > > Now there are many nl80211_band such as NL80211_BAND_2GHZ/
> > > NL80211_BAND_5GHZ/NL80211_BAND_6GHZ... In the same interface, if some=
 bands
> > > support EML, and other bands not support EML, then how to handler thi=
s
> > > case?
> > But ... these are MLD capabilities, not of the (associated) STA?
> Yes, I know it.

Then you can't honestly be suggesting we move "MLD capa and ops" into
per-band, no?

> > So not sure how that would make sense? What would you even _do_ with
> > that?

> I think another change is not move "u16 eml_capabilities", and only add=
=20
> a new
> field "u16 eml_supp_bands" together with the "u16 eml_capabilities", the
> eml_supp_bands is filled with the bit map of enum nl80211_band. Is that O=
K?
>=20

And again, what would you do with it? Not advertise EML when you have
selected links that are not in the map? And if the links change
dynamically in the future? You'd probably need a bunch of validation for
that.

And usually you'd probably always connect to all the bands?

I really don't get it.

Btw this is all client - so your client implementation can just not send
the EML action frame (forgot the name right now) when the currently
active links are not compatible.

johannes
