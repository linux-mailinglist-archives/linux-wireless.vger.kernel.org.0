Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89A4738365
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjFUL6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 07:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjFUL6Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 07:58:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06581706
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+nZBb2oJzuhDKQpCWy5UN11fCiSArQF3qKmuf9I0HmE=;
        t=1687348684; x=1688558284; b=YS9yPAF1gFh7lrcVPURvl+pEITQ1qEJkzy4v0kQIafqK5YU
        80vTKqSE+L43+GKKGd0N0NCJzOpXZZ3lkUVgVB0T2bHnpX9t28ZIzsMfBtzqJx+rETky37dGgdYDC
        wou1MYfsLa8OuBjqiirWLw5RJx61z/5Rs/5MsLDN/1KVLPhSUw/a8D7CmkYj6Wr6+B/Kg6a6nxjHM
        pTPD3Etwf8eWoNzU7HvNTZTbim4MqCM+wiYkY/Qh75FmMRGH7nu/p8ZYt7AXzgGdWsafa4KDtef7g
        9Qn1HQlbKOOP0ekTbpy1kNaEvC+80sAhWCOM+th3suTedlhksDpQvlL4bN3E/rsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qBwTC-00DeK0-0v;
        Wed, 21 Jun 2023 13:57:54 +0200
Message-ID: <53612acba151d031f636626db20c1c60db09fdd0.camel@sipsolutions.net>
Subject: Re: [PATCH 10/19] wifi: iwlwifi: limit EHT capabilities based on
 PCIe link speed
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>, gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Jun 2023 13:57:53 +0200
In-Reply-To: <d220c5b6-7c8f-19cd-12d0-ceb484e29e48@candelatech.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
         <20230620125813.b77a1574a0a7.Id4120c161fb7df6dedc70d5f3e3829e9117b8cb1@changeid>
         <d220c5b6-7c8f-19cd-12d0-ceb484e29e48@candelatech.com>
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

On Tue, 2023-06-20 at 06:19 -0700, Ben Greear wrote:
> On 6/20/23 3:03 AM, gregory.greenman@intel.com wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > If a discrete NIC is connected to a PCIe link hat isn't at least
> > Gen3 (8.0 GT/s), then we cannot sustain 320 MHz traffic, so remove
> > that from EHT capabilities in that case.
> >=20
> > While at it, also move setting 320 MHz beamformee to the right
> > place in the code so it's not set while not supporting 320 MHz.
>=20
> Is there not an advantage to allowing 320Mhz for longer distance connecti=
ons
> where signal is relatively weak, so over-all tput would easily fit in les=
ser
> pcie bus?  Especially on 6E band where the US regdom allows more over-all=
 power
> when using wider bandwidths?
>=20

I actually don't know. This surely isn't ideal, but it's the only way to
really force the AP to not send too much than the NIC can pass out, and
it gets unhappy if it can't.

johannes
