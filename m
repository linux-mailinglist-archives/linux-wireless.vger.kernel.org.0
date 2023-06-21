Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8015573882D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjFUO5z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 10:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjFUO5j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 10:57:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4269830ED
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wzdeVBLuwidYP9CFAx3kh0aCaQYbJmp2pdK3//zkB0E=;
        t=1687359137; x=1688568737; b=S1xlh2KX6Bcc+T9JIonBW7KFK+76EPT7odHji0ArVIKbVoB
        mM2tkd8agJ/MUBayOqRXLbgf/FMWuiacz0bq/g7PaoKskbTuM+yT1t4G8Nbrt/EVaDLVXGV8EAF4K
        p/OEcYCVPjwNMs3rYpNEdEg3M8ysHlfE5F2YS9Mem5b4vBCyxORyIB55+jWf/Lwc17ufzcn+d6Hp3
        wLPpIGx4qQI0JqBtDjhe/HgZNaxZGRyKphemb4PXTB2WRxItcHRDNU8vcBIhQDH8BY5Qa8y6j8FY3
        /qExw/paDfDzsSA6hdGXAmGU3gg6yp6uyWZCBW26RiIWFdUWVN3oKj0DMWAFMmhQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qBzAu-00Dibv-13;
        Wed, 21 Jun 2023 16:51:12 +0200
Message-ID: <6ee9c93cfa5a8f6dbb6e07dc2c72e26bb0e57121.camel@sipsolutions.net>
Subject: Re: [PATCH 10/19] wifi: iwlwifi: limit EHT capabilities based on
 PCIe link speed
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>, gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Jun 2023 16:51:11 +0200
In-Reply-To: <9f4c589a-2160-cedb-d79a-1f57ea5244da@candelatech.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
         <20230620125813.b77a1574a0a7.Id4120c161fb7df6dedc70d5f3e3829e9117b8cb1@changeid>
         <d220c5b6-7c8f-19cd-12d0-ceb484e29e48@candelatech.com>
         <53612acba151d031f636626db20c1c60db09fdd0.camel@sipsolutions.net>
         <9f4c589a-2160-cedb-d79a-1f57ea5244da@candelatech.com>
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

On Wed, 2023-06-21 at 07:48 -0700, Ben Greear wrote:
> On 6/21/23 4:57 AM, Johannes Berg wrote:
> > On Tue, 2023-06-20 at 06:19 -0700, Ben Greear wrote:
> > > On 6/20/23 3:03 AM, gregory.greenman@intel.com wrote:
> > > > From: Johannes Berg <johannes.berg@intel.com>
> > > >=20
> > > > If a discrete NIC is connected to a PCIe link hat isn't at least
> > > > Gen3 (8.0 GT/s), then we cannot sustain 320 MHz traffic, so remove
> > > > that from EHT capabilities in that case.
> > > >=20
> > > > While at it, also move setting 320 MHz beamformee to the right
> > > > place in the code so it's not set while not supporting 320 MHz.
> > >=20
> > > Is there not an advantage to allowing 320Mhz for longer distance conn=
ections
> > > where signal is relatively weak, so over-all tput would easily fit in=
 lesser
> > > pcie bus?  Especially on 6E band where the US regdom allows more over=
-all power
> > > when using wider bandwidths?
> > >=20
> >=20
> > I actually don't know. This surely isn't ideal, but it's the only way t=
o
> > really force the AP to not send too much than the NIC can pass out, and
> > it gets unhappy if it can't.
>=20
> So this is to work around hardware/firmware bug in NIC?  If so, that shou=
ld
> be mentioned.

I'm not sure that's really even a _bug_, it just doesn't have a lot of
buffer space inside of it; as far as I know, given how the HW
architecture works, the FW doesn't have a lot of options.

> I have heard in the past that higher bandwidth works better than higher N=
SS
> in a lot of cases, so if HW/FW can be made to deal with floods in unlikel=
y
> case that the RF is perfect enough to saturate the PCI bus, then I think =
you
> should allow 320Mhz even on slower PCI bus configurations.

Right. I don't think it's likely that the firmware will do, but hey, I
can let them know :)

johannes
