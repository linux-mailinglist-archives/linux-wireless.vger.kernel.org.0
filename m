Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B67416CE8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 09:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbhIXHii (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhIXHih (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 03:38:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241A5C061574
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 00:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=I+YLR9zeeWbS3toGZIeyYl0hMzOdWURJthpJ0Bxb/s0=;
        t=1632469025; x=1633678625; b=FMPXLmYv/QL46D2vuBvoo5IcPZ67DcVUS9J8/qWGQUM0Ks7
        P5PDvB8koyxEOZByKNctyPuNZ3CeNzMDLFcohBGdi1r78cewmBEkvwlmeMlWLkgbYXC7g4tyG1G8q
        +q2TU9/ym6dBmhB8sel4hdWtKRR1tBKhFSXbl2xwWowJblPrCsltaVByRUNd6eqpi4WCD7NvAEqnf
        h/lxv+w6KjCx3tbEJl//pAkMtEuwT9MRUNUqIOIYEuC45ikB2f4Mi4VHldapERAhNdHiyvZJ3o16q
        Z7LqgaJokY6J8CAAv8aDXnXu22yJvqOthqaAUvpy8z0khpEOZAvMQEIiuV9spLew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mTflU-00B6DA-Bt;
        Fri, 24 Sep 2021 09:37:00 +0200
Message-ID: <69e267ef88a0e9bc49cc17bb38f2472462f27360.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0
 support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "luciano.coelho@intel.com" <luciano.coelho@intel.com>,
        "emmanuel.grumbach@intel.com" <emmanuel.grumbach@intel.com>
Date:   Fri, 24 Sep 2021 09:36:59 +0200
In-Reply-To: <0afe858a-3fcf-24bb-6d20-95b74f1540e5@wetzel-home.de>
References: <20200918171301.6942-1-alexander@wetzel-home.de>
         <f6df593556c3f395997dfe42a71a69f4919a5911.camel@sipsolutions.net>
         <c887ae58-983b-0f4b-3b00-8ffbb669f37a@wetzel-home.de>
         <a245ea65-d862-6388-d163-49b99046dc08@wetzel-home.de>
         <92a61ea6f05d9c461eddced42ee75db944a191b1.camel@sipsolutions.net>
         <0afe858a-3fcf-24bb-6d20-95b74f1540e5@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[dropping now dead linuxwifi@intel.com]

> 
> > I know it's been (almost exactly) a year, but I was wondering about this
> > scenario recently
> > (due to e.g. https://bugzilla.kernel.org/show_bug.cgi?id=213059, though
> > I'm not sure that report even makes sense).
> 
> I had a quick look in the ticket. It may just be the "other end" which 
> is not able to re-key correctly. After all the tests I did with mvm I 
> should have noticed rekey issues.

Maybe. But we see this also on Cisco gear, which I'd hope wasn't so bad
:)

Also, I wasn't sure what NIC you had actually tested - there are three
different scenarios depending on the NIC/encryption, as I outlined in my
previous email (1a, 1b, 2).

> But there is one thing sticking out in the problem description:
> kernel: wlan0: disassociated from 4c:a6:4d:54:32:6b (Reason: 
> 15=4WAY_HANDSHAKE_TIMEOUT)
> 
> --> with that it's can't be a PTK0 rekey bug as we defined it so far.
> With the 4way handshake incomplete the new key has never been install on 
> the device the log is from.

Hmm. Good point. But we did also see the message saying

	Rekeying PTK for STA ... but driver can't safely do that.

so it would appear that some rekeying happened successfully.

Oh. So maybe in this particular case some rekeying happened
successfully, but then another rekeying later got stuck?

> So this is probably a case where the other end - should be the STA and 
> not the AP - activated the new key and then encrypts EAPOL#4 with the 
> new key... When the other end is not using control port and the driver 
> has no special workaround this can easily happen..
> 
> Problem here is, that when wpa_supplicant hands over EAPOL #4 to the 
> kernel this only guarantees that one frame is send out. When there are 
> others in the QDISC that won't be the EAPOL#4 frame. See
> https://patchwork.ozlabs.org/project/hostap/patch/20190912192002.6105-1-alexander@wetzel-home.de/

Well, we don't even know that the other end is using mac80211/hostapd,
but I get your point.

> > Did you ever send another patch? I can't seem to find any.
> > 
> 
> No, I never send a patch. To be able to detect incorrect key usage I 
> ended up implementing key color for mac80211 only to discover that this 
> in not adding anything useful and never submitted it. I ended up with 
> the understanding that we do not need the flush but have now problems to 
> reproduce the reasoning for that. But let's see what I can together here.

OK.

> > 
> > But basically, in mvm, we support two scenarios these days:
> > 
> >   1) PN assigned by the driver, in iwl_mvm_set_tx_cmd_crypto(), with two
> >      sub-cases:
> >      a) key material embedded into the TX command (CCMP, TKIP, WEP)
> >      b) key material taken from firmware key offset (CCMP-256, GCMP)
> >   2) PN assigned by the device per the station, via the "new TX AP >      selected in iwl_mvm_set_tx_params().
> > 
> > 
> > Am I wrong in thinking that both scenarios 1a) and 2) are completely
> > acceptable for CAN_REPLACE_PTK0, since there's never any possibility of
> > sending a frame with a mismatch between the PN assignment and key
> > material?
> 
>   CAN_REPLACE_PTK0 only has to confirms that the driver is handling all 
> the races PTK0 rekeying has. Which is possible in all of the cases above.
> In a nutshell the driver and cards must never send out a frame where the 
> PN is not matching to the PTK key used for encryption AND never send out 
> a frame - when we are set up for encryption - with a deleted keys

Right. Mostly, anyway. In 1b, we do have a race, because the PN is
assigned by driver and the key material can be programmed while frames
(with old PN) are on the TX queue(s), which can be handled by flushing
all the (affected) queues (i.e. for this station).

However, the race is often benign, because what happens is that we have
32 (I think? maybe 16) key "slots" and reuse them as late as possible.
Thus, if we do a pretty standard rekeying, the reference to the old key,
when dereferenced in the firmware, will actually still be to the correct
old key. Only if we had enough new keys installed to override that
reference, would we have any issues.

The bigger problem here happens if we do have enough key slots for this
(e.g. because we're the AP) and then reuse it ... potentially with a key
for a *different* station/connection. Then when the firmware
dereferences it, it'd be (theoretically) readable to another station
that it wasn't intended for, though the good thing is that the receiver
won't be able to decrypt it (anyway even if it's with the old key).

Only if we roll over enough keys that the new PTK0 ends up in the same
slots would we actually end up in the "stuck connection" case.

Either way though, if we roll over the key (regardless with which key),
we have a problem.

> > However, it seems that scenario 1b) is what this patch attempted to
> > handle, by flushing the TX queues when the new key is installed, and I'm
> > not sure why you said it wasn't necessary - if the driver installs new
> > key material in the device while there are frames that already have a PN
> > set, then the old PN _might_ be used with a new key, leading to
> > problems.
> 
> You are probably right but it depends how the HW is handling that in detail:
> 
> mac80211/iwlwifi/mwm together make sure that when a skb is send to the 
> HW the HW also has a valid key for it. At that very moment the frame can 
> be send. Of course chances are it will be queued there again...
> Now when the key is only de-referenced on dequeue we may have an issue 
> and need a flush or another mitigation.

Yes, this is what happens in 1b.

> Regardless how the HW is handling that here are some indirect mitigations.
> mac80211 sets first KEY_FLAG_TAINTED and then waits for all rcu 
> sections. After that the HW can't get any skb depending on the outgoing 
> key. Then the old key is deleted from the HW and when it still has 
> frames queued needing the deleted one it may go out with a null key or 
> so. Even more time and waiting on running RCU sections will pass till 
> the new key is installed and we can freeze the connection instead "only" 
> having a cleartext leak.

(Note the above description about key slot rollover)

> When A-MPDU is active on rekey stopping it will also flush the 
> problematic frames for my understanding.

Yeah. I think so.

Actually, I think this whole business of stopping aggregation sessions
is another potential issue - though particularly *RX* sessions, because
we don't know if the AP will always re-establish them.

> > There's a probabilistic defense against this, in that we attempt to
> > reuse key offsets (the hw_key ID that goes into the TX command) as
> > rarely as possible, so that if we put a frame with key offset 0 into the
> > queue, and then reinstall the PTK, it would go to key offset 2 (1 being
> > used by the GTK), and 0 would stay unless we did another rekeying or so.
> 
> The HW must then also be able to detect when a frame refers to a free 
> hw_key ID and drop those frames.

No, the hw_key ID isn't marked free, it just keeps the old key material,
unless we reuse that slot. If it's not overwritten, this isn't really a
big deal since the receiver won't be able to decrypt it any more, but in
any case it's still protected well.

The complication just comes in if we reuse that slot, as described
above.
> 
> Maybe keeping the hw_key_id but setting and checking a key color would 
> be better?

That would require firmware support.

> Not sure what the HW is capable of here but adding a single bit to the 
> key information and compare it to the color of the frame can hopefully 
> be done in the firmware.

It could be, yes. And I could even implement it, but it wouldn't really
roll out well, and it's a really old device. I don't think it's worth
the effort.

> We then would have to make sure the hw_key_id is not changing on rekey 
> to be sure concurrent rekeys are not swapping the hw_key_ids somehow.

Yeah we could ensure that.


> I was never able to get my mvm cards to mix up the key or send cleartext 
> frames. (I think I first played around with CCMP-256 and later hacked 
> CCMP to also use the key mapping.)

CCMP-256 was never supported, I think, but GCMP/GCMP-256.

But yes, I'm not surprised you weren't able to, given that key slot
reuse would have to occur.

> But I may have mixed up mac80211 queues with HW queues:
> While mac80211 queues are safe the HW queues may still need the flush.
> We don't have to flush the mac80211 queues. Cycling or draining all 
> frames handed off to the HW must be sufficient.

Right.

> 
> One of my attempts to fix the PTK0 issues tried to use something like 
> that for the ath9k driver. It turned out that we still have to stop TX 
> for the outgoing key and can only resume once the new key is active in 
> the HW, making key slot cycling unnecessary.
> That said it should work here, but only when the HW is able to drop 
> frames pointing to an cleared hw key.
> 
> As I see it mvm only can get and hand over frames to the HW when the 
> correct key is still installed in the HW.

It's not HW, it's firmware, but yeah. The thing though is that the
driver has assigned the PN - so key slot reuse ...
> 

> > The other question I had was concerning the documented requirements for
> > NL80211_EXT_FEATURE_CAN_REPLACE_PTK0, aren't those too strict? For
> > reference, this is what it says now:
> > 
> > > * Mac80211 drivers should set the @NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 flag
> > > * when they are able to replace in-use PTK keys according to the following
> > > * requirements:
> > > * 1) They do not hand over frames decrypted with the old key to
> > >       mac80211 once the call to set_key() with command %DISABLE_KEY has been
> > >       completed when also setting @IEEE80211_KEY_FLAG_GENERATE_IV for any key,
> > 
> > This is I think a bit misleading, how's the RX-side related to
> > GENERATE_IV? It seems to me that this requirement is to ensure we don't
> > get a bad replay counter on RX, but then that's unrelated to
> > GENERATE_IV?
> 
> Yes, looks like that ended up in the wrong sections with all the 
> rewording I've done here.

OK, thanks. Want to send a patch? Or I can fix it too.

> The idea is to not bump the PN of the new key with a frame decrypted by 
> a now deleted key only.

Yeah. I'd phrase it TX-side and say "the idea is to never do PN
assignment and encryption from two different keys" :)

> > 
> > >    2) either drop or continue to use the old key for any outgoing frames queued
> > >       at the time of the key deletion (including re-transmits),
> > 
> > That's mostly true for iwlwifi, apart from the case 1b) key offset reuse
> > I was explaining above.
> > 
> > >    3) never send out a frame queued prior to the set_key() %SET_KEY command
> > >       encrypted with the new key and
> > 
> > This I don't really know why - I think maybe *this* was meant to have
> > the "when also setting GENERATE_IV"?
> 
> Now I'm sure you are right:
> Any frame queued prior to %SET_KEY with @IEEE80211_KEY_FLAG_GENERATE_IV 
> can bump the new PN to a invalid value. But when the hw or driver is 
> handling that it's ok.

Right.

Thanks a lot!

johannes

