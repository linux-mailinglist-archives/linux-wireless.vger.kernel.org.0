Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F17413A7B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 21:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhIUTGC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhIUTGA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 15:06:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E8AC061760
        for <linux-wireless@vger.kernel.org>; Tue, 21 Sep 2021 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H86o5NHsrnLzeXx/GkxhQlNri6K2y/oydtKq1IAb8uk=;
        t=1632251071; x=1633460671; b=a9x1aho+IH6w0M6bvmUkvCuHDc3zBBtmf+5k8711TOLae2W
        0MH1WOQWrIOdYZs4LJqEdpLzf+N2pp6OyCXl3M7w5cMRXFCZf+OKhvUtjg+mYxjTzPpqqg93f57A4
        13F3oE/QTPpKyo0VJyNF+Ovh8je/nYD9NcaE+uWNt46PaYT+sGrRvdkqd74kwBzws2h3pmmw7n4Wq
        MxwzpysXk+blz1+nvUPRihRdMIORcoMdecfKefPIRvdtuWWZhdoo6cdXMb5Y3oFikjvxPYoIReKgn
        UKQv6RNkAlx6/UEQMzCaybKsXnKbEAU++2QmzKL6T7+uGJBfl6i1SfxhQZ9C/9/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mSl48-009yRG-Kj;
        Tue, 21 Sep 2021 21:04:28 +0200
Message-ID: <92a61ea6f05d9c461eddced42ee75db944a191b1.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0
 support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "luciano.coelho@intel.com" <luciano.coelho@intel.com>,
        "emmanuel.grumbach@intel.com" <emmanuel.grumbach@intel.com>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
Date:   Tue, 21 Sep 2021 21:04:27 +0200
In-Reply-To: <a245ea65-d862-6388-d163-49b99046dc08@wetzel-home.de> (sfid-20200922_204540_116426_B91E091B)
References: <20200918171301.6942-1-alexander@wetzel-home.de>
         <f6df593556c3f395997dfe42a71a69f4919a5911.camel@sipsolutions.net>
         <c887ae58-983b-0f4b-3b00-8ffbb669f37a@wetzel-home.de>
         <a245ea65-d862-6388-d163-49b99046dc08@wetzel-home.de>
         (sfid-20200922_204540_116426_B91E091B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alexander,

On Tue, 2020-09-22 at 20:45 +0200, Alexander Wetzel wrote:
> 
> Ok, forget this patch, the mvm part is pointless.
> The maximum we have to do is pausing the queues when we delete a key, no 
> flush required at all... I'll look into that again and send an updated 
> version:

I know it's been (almost exactly) a year, but I was wondering about this
scenario recently
(due to e.g. https://bugzilla.kernel.org/show_bug.cgi?id=213059, though
I'm not sure that report even makes sense).

Did you ever send another patch? I can't seem to find any.


But basically, in mvm, we support two scenarios these days:

 1) PN assigned by the driver, in iwl_mvm_set_tx_cmd_crypto(), with two 
    sub-cases:
    a) key material embedded into the TX command (CCMP, TKIP, WEP)
    b) key material taken from firmware key offset (CCMP-256, GCMP)
 2) PN assigned by the device per the station, via the "new TX API"
    selected in iwl_mvm_set_tx_params().


Am I wrong in thinking that both scenarios 1a) and 2) are completely
acceptable for CAN_REPLACE_PTK0, since there's never any possibility of
sending a frame with a mismatch between the PN assignment and key
material?

However, it seems that scenario 1b) is what this patch attempted to
handle, by flushing the TX queues when the new key is installed, and I'm
not sure why you said it wasn't necessary - if the driver installs new
key material in the device while there are frames that already have a PN
set, then the old PN _might_ be used with a new key, leading to
problems.

There's a probabilistic defense against this, in that we attempt to
reuse key offsets (the hw_key ID that goes into the TX command) as
rarely as possible, so that if we put a frame with key offset 0 into the
queue, and then reinstall the PTK, it would go to key offset 2 (1 being
used by the GTK), and 0 would stay unless we did another rekeying or so.

I guess in theory we could arrange -- on the hardware where case 1b) is
even relevant, i.e. only 9260 since previous don't support GCMP, and
later use case 2) -- to never put the rekeyed PTK into the same slot,
that way, even if we do have to reuse the slot, it'd be with a different
key? But in theory that might leak data to the wrong station or
something ... functionally, it would lead to a rejection of the frame
and it being dropped at the receiver, but security-wise it'd be a
problem.


Anyway, I'm not really sure why you thought the flush wasn't needed, it
seems to me it is still needed in the case 1b).

Theoretically, it seems we could rely on the "no key slot (offset)
reuse" if we put some kind of barrier into the TX queues whenever we
stop using a key slot, that way we'd know if it might still get used or
not. If yes, we flush, but that basically never happens since there are
a relatively large number of slots and typical use cases don't have so
many keys.


The other question I had was concerning the documented requirements for
NL80211_EXT_FEATURE_CAN_REPLACE_PTK0, aren't those too strict? For
reference, this is what it says now:

> * Mac80211 drivers should set the @NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 flag
> * when they are able to replace in-use PTK keys according to the following
> * requirements:
> * 1) They do not hand over frames decrypted with the old key to
>      mac80211 once the call to set_key() with command %DISABLE_KEY has been
>      completed when also setting @IEEE80211_KEY_FLAG_GENERATE_IV for any key,

This is I think a bit misleading, how's the RX-side related to
GENERATE_IV? It seems to me that this requirement is to ensure we don't
get a bad replay counter on RX, but then that's unrelated to
GENERATE_IV?

>   2) either drop or continue to use the old key for any outgoing frames queued
>      at the time of the key deletion (including re-transmits),

That's mostly true for iwlwifi, apart from the case 1b) key offset reuse
I was explaining above.

>   3) never send out a frame queued prior to the set_key() %SET_KEY command
>      encrypted with the new key and

This I don't really know why - I think maybe *this* was meant to have
the "when also setting GENERATE_IV"?

I don't think this is necessary if you ensure that the PN is assigned
from the correct key? That is, it doesn't really apply in case 2) I
mentioned?


>   4) never send out a frame unencrypted when it should be encrypted.

Obviously :)


Thanks,
johannes

