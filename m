Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EBA6ADA24
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 10:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCGJUo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 04:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCGJUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 04:20:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31F387A14
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 01:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FWJek77JJraltJOA9S/rKvd/LLYSvQYCbgD8IJtq7lY=;
        t=1678180815; x=1679390415; b=grKghAVAMWho4b+wkjVn9QGdS2Xa3Yb+AtRk49cGvDHzLNg
        z2RsmoJZl8R80upp+GoJO6u+O50k4SUMAo3ejqMawjKTPsnnaOSvQmZJf/+RCBRLll+fuwBdefphN
        hbwQaoMLmaWHwEO3BEnJ8Nwm7vh42lADo8BMwt+xwDt/XZmKgo0+QxjrP/apwj6nLXvM9hm9Ly2Wu
        F6sZYpvaRw/mVIXC70049OF1sNSjxnamCvl4giNjZwSb7OEMZuI+l7Tq8pMGi1+TC1fM2lM7iycx+
        kgSetK9nQ8RdVQxQnAGBuIA04ZyeR4n3SpPTa5auVONaQ6/E8xrBs4M4xTiFyACw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pZTUS-00EHH9-0n;
        Tue, 07 Mar 2023 10:20:12 +0100
Message-ID: <6796c3c209a071983d330ca145d7ab8b929d53c6.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] wifi: nl80211: Add support to specify channel width
 for scan
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Xinyue Ling <quic_xinyling@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 07 Mar 2023 10:20:10 +0100
In-Reply-To: <20230301090242.1613672-1-quic_xinyling@quicinc.com>
References: <20230301090242.1613672-1-quic_xinyling@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-03-01 at 17:02 +0800, Xinyue Ling wrote:
> nl80211_trigger_scan() processes scan request netlink attributes,
> defined in enum nl80211_attrs, and fills struct
> cfg80211_scan_request *request.
>=20
> Currently there is no logic to fill this member:
> 	enum nl80211_bss_scan_width scan_width;

Right, noticed that too some time ago while working on MLO.

> We have a requirement to fill this member for drone use cases, in
> which drone controller needs to scan and connect to drone in 5 MHz
> or 10 MHz channel width (may support other channel widths lower
> than 20 MHz later).

:-(

> The following series of patches is the implementations of above two
> options. In order to make them a series, a revert patch is included,
> which can be ignored. Please review and decide which option is more
> reasonable and acceptable.

I'm not sure this matters so much right now ... either works. I suspect
a new attribute might be nicer (fsvo "nicer").

However, all this stuff is currently completely broken in mac80211. Are
you wanting to use it with mac80211? ieee80211_vif_get_shift() is fairly
much broken (deflink), and even if we don't expect to use MLO with
narrow channels, it's still a huge mess.

In fact, had I had enough time, I'd have removed all that code entirely
from mac80211 already, since it's clearly unreachable. There's nothing
that can ever select a narrow-band BSS since you can't actually scan
that way as you noticed too.


So ... for your use case:
 1) are you going to use mac80211?
 2) if not, which (upstream!) driver are you going to use?
 3) if yes, are you willing to dig through mac80211 and clean up all
    that narrow-band code:
     - to make sure it interacts well with MLO
       (even if it doesn't _support_ MLO),
     - to define it correctly wrt. what's supported such as
       HT/VHT/HE/EHT with narrow channels? How would that even work? I
       guess none of those - unless we're dealing with vendor
       extensions?
     - if we're dealing with vendor extensions here, anyone actually
       willing to commit to those and document them properly outside of
       just having a half-baked implementation?


So honestly, I'm not even going to look at these patches before I can
get some answers on this, because while it may work for your use case
right now, it's clearly a mess. For example, nothing prevents you even
from trying to create MLO out of a narrow-band and regular BSS, other
than that no AP would likely beacon that way ... Hopefully!! But I don't
think we should just hope that no AP does this and that wpa_s is smart
enough.

johannes
