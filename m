Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81B4274876
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIVSph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 14:45:37 -0400
Received: from 2.mo174.mail-out.ovh.net ([178.33.110.43]:41491 "EHLO
        2.mo174.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVSpe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 14:45:34 -0400
Received: from mxplan8.mail.ovh.net (unknown [10.109.146.129])
        by mo174.mail-out.ovh.net (Postfix) with ESMTPS id 08C4A44F2B26;
        Tue, 22 Sep 2020 20:45:30 +0200 (CEST)
Received: from awhome.eu (37.59.142.105) by mxplan8.mail.ovh.net (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2044.4; Tue, 22 Sep
 2020 20:45:30 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-105G00684d37a1e-bfa2-4b27-a5be-75639e02e191,
                    4C3E3D8FEB463474C42C0B9415162D5E591AC1A3) smtp.auth=postmaster@awhome.eu
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1600800329;
        bh=D2O/29a+2Ir93722aA1JuMzU1wFGsj/YUTfeTXhvuoI=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To;
        b=XGmuMRFGTt/VOuo86KgZ+2VNhbs3HIm625wkkvHexHB68Yvvt9hIsyTOZhUuuChKA
         NznDlRrPoFzftBOoDpr6Mbf6NN5LAMk63L8zgfGEfkgpo/2VT/6snV//GJAEmzBXRN
         5t016tMreNnaV1ms/5phMfoYxggnJA7iIK6Telsw=
Subject: Re: [PATCH] iwlwifi: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "luciano.coelho@intel.com" <luciano.coelho@intel.com>,
        "emmanuel.grumbach@intel.com" <emmanuel.grumbach@intel.com>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
References: <20200918171301.6942-1-alexander@wetzel-home.de>
 <f6df593556c3f395997dfe42a71a69f4919a5911.camel@sipsolutions.net>
 <c887ae58-983b-0f4b-3b00-8ffbb669f37a@wetzel-home.de>
Message-ID: <a245ea65-d862-6388-d163-49b99046dc08@wetzel-home.de>
Date:   Tue, 22 Sep 2020 20:45:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c887ae58-983b-0f4b-3b00-8ffbb669f37a@wetzel-home.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-GUID: 9f3fffd8-5ab9-49d3-9832-5236c24847a2
X-Ovh-Tracer-Id: 5064860732984401059
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffuvfhfkffffgggjggtgfesthekredttdefjeenucfhrhhomheptehlvgigrghnuggvrhcuhggvthiivghluceorghlvgigrghnuggvrhesfigvthiivghlqdhhohhmvgdruggvqeenucggtffrrghtthgvrhhnpefhueekgfdvieetveehvdelgefgveeufffgvdeuteeufeduieehkefhlefgteegtdenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhekrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghlvgigrghnuggvrhesfigvthiivghlqdhhohhmvgdruggvpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 20.09.20 um 08:37 schrieb Alexander Wetzel:
> 
>  >>
>  >> +        /* GCMP and 256 bit CCMP keys the key can't be copied into the
>  >> +         * MPDU struct ieee80211_tx_info. We therefore must flush the
>  >> +         * queues to ensure there are no MPDUs left which are 
> referring
>  >> +         * to the outgoing key.
>  >> +         */
>  >> +        if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE &&
>  >> +            (key->cipher == WLAN_CIPHER_SUITE_GCMP ||
>  >> +             key->cipher == WLAN_CIPHER_SUITE_GCMP_256 ||
>  >> +             key->cipher == WLAN_CIPHER_SUITE_CCMP_256)) {
>  >> +            ieee80211_stop_queues(hw);
>  >> +            iwl_mvm_mac_flush(hw, vif, 0, true);
>  >> +            ieee80211_wake_queues(hw);
>  >> +        }
>  >
>  > Shouldn't the wake be after installing the new key? Otherwise new frames
>  > can race and be there again?
> 
> mac80211 is taking care of that and has already stopped queuing new 
> MPDUs which would use the key by setting KEY_FLAG_TAINTED on it. So for 
> a PTK0 rekey we are fine, mac80211 won't queue frames with the key under 
> deletion.
> 

Ok, forget this patch, the mvm part is pointless.
The maximum we have to do is pausing the queues when we delete a key, no 
flush required at all... I'll look into that again and send an updated 
version:

The hw_key and the keyid is set (again) when we dequeue. So we either 
get a valid key or ieee80211_tx_dequeue() drops the MPDU itself.
Therefore it's irrelevant if we lookup the key from a table or store it 
in the MPDU info struct. Now we may still have a race within the driver 
but simply pausing dequeuing during key deletion should do the trick.

> But I think we should start setting KEY_FLAG_TAINTED for *any* PTK 
> deletion to make sure we are not sending out MPDUs with a zero key or 
> something like that. This is a special kind of a rekey case we missed so 
> far but should be trival cover that, too.
> 
> That is then basically taking care about the generic Kr00k vulnerability 
>   some months ago.
> 
> Now I'm not aware of we have any mitigations in the code for that but 
> when we set KEY_FLAG_TAINTED for key deletions any driver which is able 
> to rekey PTK0 correctly can't be affected by Kr00k any longer.
> 

Looked at the current code and turns out we have at least two 
mitigations for that now:
1) commit ce2e1ca70307 "(mac80211: Check port authorization in the 
ieee80211_tx_dequeue() case)" and

2) commit a0761a301746 "(mac80211: drop data frames without key on 
encrypted links)"

> I'll look into that in the next days and prepare a patch for mac8011 to 
> discuss that.

I've the patch basically ready, but there are already the two 
mitigations mentioned above in place.

The only thing the new patch seems to improves is deleting an active PTK 
key without de-authentication which seems to have no valid use cases.
And it makes KEY_FLAG_TAINTED more logical by also stopping Tx for an 
outgoing key and not only when we replace it.

I'll probably still send it as an RFC patch to sort out if we still want 
that or not.

Alexander

