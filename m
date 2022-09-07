Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C135AFCED
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 08:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiIGG5d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 02:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIGG5d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 02:57:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93BA883EB
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7aRf3LmAuOgsa0K3mZL4MWjWCbtZAFjGn1fJm/Bawa8=;
        t=1662533851; x=1663743451; b=fegTHe8u6t1gTPC6YH7hjfAB5mYdtHx9L2fAL+w8Sm18B3t
        /H/496CxMIygkg/G3gRXjD50kIlH3oIdKc85eu/IYcOEyqXtczomEY2TuvI+UkDATovAKrDZvmbYX
        gAFKmBdgiu8J9Z7SaMWgmukEG323vaR79ZZOT5+IvxyBmZlft5VXH9nukhPJ3c9zNSx4d5Tq3zX4K
        /L9kaL4vI4a7iIjpdxfas5ntkq8uj8xJ/Lnx1OdqQAzH3I4suXyfIUqiyB6gZ/Hq2wkfLu6kWtPrQ
        NPjBnBgMtSfMAzOkX3ORGXpDZd6uEjNsqoVXsXNF8/wFD7KfIbMLvYyKIIaygEJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVp05-00AEVR-1h;
        Wed, 07 Sep 2022 08:57:29 +0200
Message-ID: <b6f5ad5b9a50fd26838c019921f3ace1e739f9b8.camel@sipsolutions.net>
Subject: Re: [PATCH 07/12] wifi: mwifiex: fix array of flexible structures
 warnings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 07 Sep 2022 08:57:28 +0200
In-Reply-To: <YxfHwxuwEP1rQoAU@google.com>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
         <20220904212910.2c885310ebee.If7177ea588b56c405eee6e6df595e9efccdfb99a@changeid>
         <YxfHwxuwEP1rQoAU@google.com>
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

On Tue, 2022-09-06 at 15:20 -0700, Brian Norris wrote:
> Hi,
>=20
> On Sun, Sep 04, 2022 at 09:29:07PM +0200, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > There are two, just change them to have a "u8 data[]" type
> > member, and add casts where needed. No binary changes.
>=20
> Hmm, what exact warning are you looking at? This one?
> https://clang.llvm.org/docs/DiagnosticsReference.html#wflexible-array-ext=
ensions
>=20

I think gcc also has one with W=3D1 now?

But yes, it's similar to that one. I was looking at Jakub's netdev test
builds here:

https://patchwork.hopto.org/static/nipa/673828/12964988/build_32bit/stderr

../drivers/net/wireless/marvell/mwifiex/fw.h:2107:46: warning: array of fle=
xible structures
../drivers/net/wireless/marvell/mwifiex/fw.h:2257:47: warning: array of fle=
xible structures

> > @@ -2104,7 +2104,7 @@ struct mwifiex_fw_mef_entry {
> >  struct host_cmd_ds_mef_cfg {
> >  	__le32 criteria;
> >  	__le16 num_entries;
> > -	struct mwifiex_fw_mef_entry mef_entry[];
> > +	u8 mef_entry_data[];
>=20
> Do you actually need this part of the change? The 'mef_entry' (or
> 'mef_entry_data') field is not actually used anywhere now, but I can't
> tell what kind of warning is involved.

But it itself is variable, so the compiler is (rightfully, IMHO) saying
that you can't have an array of something that has a variable size, even
if it's a variable array.

> >  struct host_cmd_ds_coalesce_cfg {
> >  	__le16 action;
> >  	__le16 num_of_rules;
> > -	struct coalesce_receive_filt_rule rule[];
> > +	u8 rule_data[];
>=20
> These kinds of changes seem to be losing some valuable information. At a
> minimum, it would be nice to leave a comment that points at the intended
> struct; but ideally, we'd be able to still get the type safety from
> actually using the struct, instead of relying on casts and/or u8/void.

All fair points. This was the way we typically do this in e.g.
ieee80211.h ("u8 variable[]", not "struct element elems[]"), but YMMV.

I thought later after Kalle asked about making it a single entry such as

  struct coalesce_receive_filt_rule first_rule;

but then the sizeof() is messed up and then the change has to be much
more careful.

Anyway, I was mostly trying to remove some warnings in drivers that
don't really have a very active maintainer anymore, since we have so
many in wireless it sometimes makes it hard to see which ones are new.

No particular feelings about this patch :-)

johannes
