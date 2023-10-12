Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1A17C6D79
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 13:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347349AbjJLL4w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 07:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379450AbjJLL4U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 07:56:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D5D4C
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 04:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zvV8HJf8+fwhhuE67KO1C9f/ZGrxGuUHaWyVCQvIRRk=;
        t=1697111630; x=1698321230; b=Btite5s//5Rd4Yj8mKt8+zbv4AKYfWHzSjmhziSMsg/rg/7
        ugmKTXzxGKscbf5KkyzvYR29YaroiN0vQeT/9ricLBlJ57w/5wg3yf6jTZVeMlf6srmTRc4+8/64l
        zS8fhzjDAr7HMejD/U96wKVlgFtXj6b8FsBsVGMFuVB/fuZb8+r+Pq4Yepqsebo7wey3IwwVGFKNE
        xumH5nSthLEbYwX+Wenv8szpkDTcUE6Hnm67rVDIzBl95u129hcCKkK7kcoO4Qm/zdn9OUAehAT+F
        w3+GYcLOkq5wzbCNti344Bkt0D/R8LlE+1zzHgi0ntH30VsZMA0Rc0JLil18bhhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qquGA-00000003Inv-1V2C;
        Thu, 12 Oct 2023 13:53:46 +0200
Message-ID: <9fd4a3097e078c1fe2acd5fbd0c559b0390daa49.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] cfg80211: validate RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 12 Oct 2023 13:53:45 +0200
In-Reply-To: <58fdd62041c0388740cabea5a421c5417f959124.camel@sipsolutions.net>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
         <20220214223051.3610-3-quic_alokad@quicinc.com>
         <a9813545a25cd63f71cc31476230514a80350802.camel@sipsolutions.net>
         <6cf56be5-16d6-2bcd-150f-bf29f98b7f1b@quicinc.com>
         <58fdd62041c0388740cabea5a421c5417f959124.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

Hi Aloka, all,

Reviving an ancient thread, but this is where we discussed these things
last I think ...

So I said, back at the beginning of 2022:

> > > Conceptually, I'm wondering if it really belongs into the chandef? Ca=
n
> > > you explain why it's part of the channel configuration? If you've got
> > > two chandefs with the same control channel, CCFS and bandwidth, but
> > > different puncturing, does it really make sense to treat them as two
> > > separate channel contexts, e.g. in mac80211? It seems strange to do
> > > that.


And you replied two things:

> > Added it here so that any command working with chandef will be updated=
=20
> > without any other change.
> > Example: During channel switch, user can provide a puncturing bitmap=
=20
> > with a new option I added in userspace, and because it is part of=20
> > chandef, the same code path validates it for that command automatically=
.
>=20
> Yeah but is it really a CSA/chanswitch if the puncturing changes? I
> don't think so?

Which, well, I think I was confused about - it could we CSA/chanswitch
depending on what you actually want to do, i.e. it's up to the AP to do
this as just a puncturing bitmap update in the beacon, or with CSA. It
might do one way or the other depending on what it wants...


But also, I read this as being a bit more about the software POV, which
I didn't really think was the most important part.


And also, you said:

> > Regarding if different puncturing pattern should be considered as a new=
=20
> > context - yes, depending on if it is HE or non-HE mode, the new bitmap=
=20
> > may be invalid and the operation should fail.

Which I'm not sure I understood then, and certainly not sure I
understand now, but I said:

> That wasn't really the question though. Consider this:
>=20
> Say you have STA + STA, if the first STA is connected to an AP with no
> puncturing, and the second STA is connected to an AP where the channel
> and bandwidth are the same, but some puncturing is done, should that
> really be two channel contexts as far as mac80211 is concerned, and thus
> require channels=3D2 in the interface combinations etc.? It doesn't seem
> right to me.
>=20
> Or consider AP + STA, where the AP is set up for some channel but the
> STA is connecting to an AP on the exact same channel, but with
> puncturing... Again, same thing, I don't think it should consume two
> channel resources.

Which, actually, I've learned since that I was completely wrong about!
It should, and likely must, in fact be two separate channel contexts,
with all the limitations that implies.

The thing is - back then I was making not just one, but in fact *two*
wrong assumptions:

   1. The DSP/radio can receive punctured PPDUs if listening on the non
      punctured channel.
     =20
      At least for our device that's not true, not sure about ath12k? It
      seems you have a per-peer puncturing configuration even, but that
      seems odd, and it's always just set to the vif puncturing
      configuration.
     =20
   2. You can simply transmit punctured PPDUs when on a non-punctured
      channel, i.e. it's just a rate control decision.
     =20
      This is perhaps less important, but it's also not really true.
      While you can clearly _transmit_ this way, that's not the only
      thing - you also need to do the CCA before transmitting, and if
      there's noise/interference on the punctured channel, you'd much
      more rarely find the channel to be clear and be able to transmit
      if this doesn't consider the puncturing, but that's something to
      do sort of generally in the background for the transmit.

It might be possible to work around #2, but I'm not sure it's possible
to work around #1?


So I think I have two questions:
   A. Would you object if I moved the puncturing into the chandef after
      all?
     =20
   B. How does ath12k cope #1/#2 above? Would we need to have a callback
      to the driver to compare if two channel contexts are compatible or
      not (e.g. if they have different puncturing), or does ath12k also
      have limitations on RX/TX that mean it would actually prefer two
      channel contexts for the cases I had outlined in the quoted text
      above (STA+STA/AP+STA)?

Thanks,
johannes
