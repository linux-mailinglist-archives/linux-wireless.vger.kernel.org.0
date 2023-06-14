Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB5B72FEB5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 14:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbjFNMcr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 08:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbjFNMcp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 08:32:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A211FD5
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iKNDkocZpavorovVWZXECbv8Vc+7HiWanqVcNNoSqAA=;
        t=1686745936; x=1687955536; b=kjehX2zqKTVGDaPWl1JkZrJanm35ayDDOBUNxBNSspbHvf0
        s6zFCb3n2xGwPiqH8Pz1uch2pdYp6pJFZJP+qLm9lX9cuRg5xFBy1DjBY6keGQfw6Tg6f/a0Zv87c
        RnUu1f0q1hqCDnyjMMIa4WSQ4YkVMlJJ8UIOpXu09yP760DPIDcaQSbsnyEUD2M5uk79vaI6pSB+a
        8ZDwZB1XKezAnlZSyfK7u7tdIduGxy/gKvAbn7unFTjtydlUGR0rH7AGmXqN4lq/3QrjJ7XeOQbzh
        VimDuZyOoSXud2ptbHmRnRtO0xHnInL56Zb4SWokpuyvpDwEOFSKtm03p+dSeyDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9PfY-0068Eh-0U;
        Wed, 14 Jun 2023 14:32:12 +0200
Message-ID: <b65dad8137855de027ce332c0f1b87837287a038.camel@sipsolutions.net>
Subject: Re: [PATCH 08/15] wifi: iwlwifi: mvm: Add NULL check before
 dereferencing the pointer
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>
Date:   Wed, 14 Jun 2023 14:32:11 +0200
In-Reply-To: <75ea42d01f6397f5b46842e6eccd3fced9b6e31a.camel@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
         <20230612184434.cf7a5ce82fb0.Id3c05d13eeee6638f0930f750e93fb928d5c9dee@changeid>
         <416fc1eba88e13c245fac4499ee0af2efbd5485a.camel@sipsolutions.net>
         <75ea42d01f6397f5b46842e6eccd3fced9b6e31a.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-06-14 at 12:28 +0000, Greenman, Gregory wrote:
> On Wed, 2023-06-14 at 12:07 +0200, Johannes Berg wrote:
> > On Mon, 2023-06-12 at 18:51 +0300, gregory.greenman@intel.com=C2=A0wrot=
e:
> > > From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> > >=20
> > > The p2p, bss and ap vif pointers are assigned based on the mode.
> > > All pointers will not have valid value at same time and can be
> > > NULL, based on configured mode. This can lead to NULL pointer
> > > access.
> >=20
> > This is not true.
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* enable PM on bss i=
f bss stand alone */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vifs->bss_active && !v=
ifs->p2p_active && !vifs->ap_active) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (bss_mvmvif && vifs->bs=
s_active && !vifs->p2p_active &&
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vifs->=
ap_active) {
> > >=20
> >=20
> > The pointers can only be NULL iff *_active is false, however, it may be
> > false even if the pointer is non-NULL, so it's not exactly the same.
> >=20
> > Probably a static checker thing that didn't understand it?
> >=20
> > johannes
>=20
> Right, so the commit message could be rephrased like this:
> "While vif pointers are protected by the corresponding "*active" fields,
> static checkers can get confused sometimes. Add an explicit check."
>=20
> Do you want me to resend it with the fixed commit message?

Yes please. I also delegated this and the other one to you in patchwork
again.

johannes
