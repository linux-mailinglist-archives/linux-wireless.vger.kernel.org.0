Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A540F4167D6
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 00:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhIWWLy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 18:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhIWWLu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 18:11:50 -0400
X-Greylist: delayed 340 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Sep 2021 15:10:18 PDT
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 131B6C061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 15:10:18 -0700 (PDT)
Subject: Re: [PATCH] iwlwifi: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1632434672;
        bh=Rn2SCiB3lZFzmgTGkgoZCuB/Ue+D8q2xFQRqWbqd6qY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WGhQIa9WdXmjsfit2+4QhHeNu2lt7bfq4crFZndoVOnst3woG/Vu/pBu2iin85Spi
         YDPSgY3b/Vwa2IQ5iw7jdWGi7U5OSfiTGu5k0pXADujAh82GJ3ovkZ/4hOAGS9F/fX
         /4DvW8QhkHMQVq+XFd0RXRbh3/61+vmJlGz6vmX4=
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "luciano.coelho@intel.com" <luciano.coelho@intel.com>,
        "emmanuel.grumbach@intel.com" <emmanuel.grumbach@intel.com>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
References: <20200918171301.6942-1-alexander@wetzel-home.de>
 <f6df593556c3f395997dfe42a71a69f4919a5911.camel@sipsolutions.net>
 <c887ae58-983b-0f4b-3b00-8ffbb669f37a@wetzel-home.de>
 <a245ea65-d862-6388-d163-49b99046dc08@wetzel-home.de>
 <92a61ea6f05d9c461eddced42ee75db944a191b1.camel@sipsolutions.net>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <0afe858a-3fcf-24bb-6d20-95b74f1540e5@wetzel-home.de>
Date:   Fri, 24 Sep 2021 00:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <92a61ea6f05d9c461eddced42ee75db944a191b1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 21.09.21 21:04, Johannes Berg wrote:
> Hi Alexander,
> 
> On Tue, 2020-09-22 at 20:45 +0200, Alexander Wetzel wrote:
>>
>> Ok, forget this patch, the mvm part is pointless.
>> The maximum we have to do is pausing the queues when we delete a key, no
>> flush required at all... I'll look into that again and send an updated
>> version:
> 
> I know it's been (almost exactly) a year, but I was wondering about this
> scenario recently
> (due to e.g. https://bugzilla.kernel.org/show_bug.cgi?id=213059, though
> I'm not sure that report even makes sense).

I had a quick look in the ticket. It may just be the "other end" which 
is not able to re-key correctly. After all the tests I did with mvm I 
should have noticed rekey issues.

But there is one thing sticking out in the problem description:
kernel: wlan0: disassociated from 4c:a6:4d:54:32:6b (Reason: 
15=4WAY_HANDSHAKE_TIMEOUT)

--> with that it's can't be a PTK0 rekey bug as we defined it so far.
With the 4way handshake incomplete the new key has never been install on 
the device the log is from.

So this is probably a case where the other end - should be the STA and 
not the AP - activated the new key and then encrypts EAPOL#4 with the 
new key... When the other end is not using control port and the driver 
has no special workaround this can easily happen..

Problem here is, that when wpa_supplicant hands over EAPOL #4 to the 
kernel this only guarantees that one frame is send out. When there are 
others in the QDISC that won't be the EAPOL#4 frame. See
https://patchwork.ozlabs.org/project/hostap/patch/20190912192002.6105-1-alexander@wetzel-home.de/


> 
> Did you ever send another patch? I can't seem to find any.
> 

No, I never send a patch. To be able to detect incorrect key usage I 
ended up implementing key color for mac80211 only to discover that this 
in not adding anything useful and never submitted it. I ended up with 
the understanding that we do not need the flush but have now problems to 
reproduce the reasoning for that. But let's see what I can together here.

> 
> But basically, in mvm, we support two scenarios these days:
> 
>   1) PN assigned by the driver, in iwl_mvm_set_tx_cmd_crypto(), with two
>      sub-cases:
>      a) key material embedded into the TX command (CCMP, TKIP, WEP)
>      b) key material taken from firmware key offset (CCMP-256, GCMP)
>   2) PN assigned by the device per the station, via the "new TX AP >      selected in iwl_mvm_set_tx_params().
> 
> 
> Am I wrong in thinking that both scenarios 1a) and 2) are completely
> acceptable for CAN_REPLACE_PTK0, since there's never any possibility of
> sending a frame with a mismatch between the PN assignment and key
> material?

  CAN_REPLACE_PTK0 only has to confirms that the driver is handling all 
the races PTK0 rekeying has. Which is possible in all of the cases above.
In a nutshell the driver and cards must never send out a frame where the 
PN is not matching to the PTK key used for encryption AND never send out 
a frame - when we are set up for encryption - with a deleted keys

> 
> However, it seems that scenario 1b) is what this patch attempted to
> handle, by flushing the TX queues when the new key is installed, and I'm
> not sure why you said it wasn't necessary - if the driver installs new
> key material in the device while there are frames that already have a PN
> set, then the old PN _might_ be used with a new key, leading to
> problems.

You are probably right but it depends how the HW is handling that in detail:

mac80211/iwlwifi/mwm together make sure that when a skb is send to the 
HW the HW also has a valid key for it. At that very moment the frame can 
be send. Of course chances are it will be queued there again...
Now when the key is only de-referenced on dequeue we may have an issue 
and need a flush or another mitigation.

Regardless how the HW is handling that here are some indirect mitigations.
mac80211 sets first KEY_FLAG_TAINTED and then waits for all rcu 
sections. After that the HW can't get any skb depending on the outgoing 
key. Then the old key is deleted from the HW and when it still has 
frames queued needing the deleted one it may go out with a null key or 
so. Even more time and waiting on running RCU sections will pass till 
the new key is installed and we can freeze the connection instead "only" 
having a cleartext leak.

When A-MPDU is active on rekey stopping it will also flush the 
problematic frames for my understanding.


> 
> There's a probabilistic defense against this, in that we attempt to
> reuse key offsets (the hw_key ID that goes into the TX command) as
> rarely as possible, so that if we put a frame with key offset 0 into the
> queue, and then reinstall the PTK, it would go to key offset 2 (1 being
> used by the GTK), and 0 would stay unless we did another rekeying or so.

The HW must then also be able to detect when a frame refers to a free 
hw_key ID and drop those frames.

> I guess in theory we could arrange -- on the hardware where case 1b) is
> even relevant, i.e. only 9260 since previous don't support GCMP, and
> later use case 2) -- to never put the rekeyed PTK into the same slot,
> that way, even if we do have to reuse the slot, it'd be with a different
> key? But in theory that might leak data to the wrong station or
> something ... functionally, it would lead to a rejection of the frame
> and it being dropped at the receiver, but security-wise it'd be a
> problem.

Maybe keeping the hw_key_id but setting and checking a key color would 
be better?
Not sure what the HW is capable of here but adding a single bit to the 
key information and compare it to the color of the frame can hopefully 
be done in the firmware.
We then would have to make sure the hw_key_id is not changing on rekey 
to be sure concurrent rekeys are not swapping the hw_key_ids somehow.

> 
> 
> Anyway, I'm not really sure why you thought the flush wasn't needed, it
> seems to me it is still needed in the case 1b).
> 

I was never able to get my mvm cards to mix up the key or send cleartext 
frames. (I think I first played around with CCMP-256 and later hacked 
CCMP to also use the key mapping.)

But I may have mixed up mac80211 queues with HW queues:
While mac80211 queues are safe the HW queues may still need the flush.
We don't have to flush the mac80211 queues. Cycling or draining all 
frames handed off to the HW must be sufficient.


> Theoretically, it seems we could rely on the "no key slot (offset)
> reuse" if we put some kind of barrier into the TX queues whenever we
> stop using a key slot, that way we'd know if it might still get used or
> not. If yes, we flush, but that basically never happens since there are
> a relatively large number of slots and typical use cases don't have so
> many keys.
> 
One of my attempts to fix the PTK0 issues tried to use something like 
that for the ath9k driver. It turned out that we still have to stop TX 
for the outgoing key and can only resume once the new key is active in 
the HW, making key slot cycling unnecessary.
That said it should work here, but only when the HW is able to drop 
frames pointing to an cleared hw key.

As I see it mvm only can get and hand over frames to the HW when the 
correct key is still installed in the HW.

> 
> The other question I had was concerning the documented requirements for
> NL80211_EXT_FEATURE_CAN_REPLACE_PTK0, aren't those too strict? For
> reference, this is what it says now:
> 
>> * Mac80211 drivers should set the @NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 flag
>> * when they are able to replace in-use PTK keys according to the following
>> * requirements:
>> * 1) They do not hand over frames decrypted with the old key to
>>       mac80211 once the call to set_key() with command %DISABLE_KEY has been
>>       completed when also setting @IEEE80211_KEY_FLAG_GENERATE_IV for any key,
> 
> This is I think a bit misleading, how's the RX-side related to
> GENERATE_IV? It seems to me that this requirement is to ensure we don't
> get a bad replay counter on RX, but then that's unrelated to
> GENERATE_IV?

Yes, looks like that ended up in the wrong sections with all the 
rewording I've done here.
The idea is to not bump the PN of the new key with a frame decrypted by 
a now deleted key only.

> 
>>    2) either drop or continue to use the old key for any outgoing frames queued
>>       at the time of the key deletion (including re-transmits),
> 
> That's mostly true for iwlwifi, apart from the case 1b) key offset reuse
> I was explaining above.
> 
>>    3) never send out a frame queued prior to the set_key() %SET_KEY command
>>       encrypted with the new key and
> 
> This I don't really know why - I think maybe *this* was meant to have
> the "when also setting GENERATE_IV"?

Now I'm sure you are right:
Any frame queued prior to %SET_KEY with @IEEE80211_KEY_FLAG_GENERATE_IV 
can bump the new PN to a invalid value. But when the hw or driver is 
handling that it's ok.

> 
> I don't think this is necessary if you ensure that the PN is assigned
> from the correct key? That is, it doesn't really apply in case 2) I
> mentioned?

exactly.

> 
> 
>>    4) never send out a frame unencrypted when it should be encrypted.
> 
> Obviously :)
> 
> 
> Thanks,
> johannes
> 

