Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5EF2712BB
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Sep 2020 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgITGp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Sep 2020 02:45:57 -0400
Received: from 2.mo174.mail-out.ovh.net ([178.33.110.43]:36769 "EHLO
        2.mo174.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgITGp5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Sep 2020 02:45:57 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 02:45:55 EDT
Received: from mxplan8.mail.ovh.net (unknown [10.109.143.129])
        by mo174.mail-out.ovh.net (Postfix) with ESMTPS id 99ED0439A055;
        Sun, 20 Sep 2020 08:37:17 +0200 (CEST)
Received: from awhome.eu (37.59.142.98) by mxplan8.mail.ovh.net (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2044.4; Sun, 20 Sep
 2020 08:37:16 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-98R002774a8836-a19b-4ee0-a5b9-9a61e6672be2,
                    75D883B0022EFA271CE7F5B6A0DE1F071752B67A) smtp.auth=postmaster@awhome.eu
Subject: Re: [PATCH] iwlwifi: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1600583836;
        bh=POXWF4OyPPRWU933sGcUJx9/7cgyl0ot2PqDgbBEw0I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mnKCEIGKgrTC58xZDvzwtY0w09nSLKkUvLFV5iWmCqi8Mx3ZAUAAocPoYqbPzxBx7
         sQ0JDO8bMP2daJTXp7TYeDS5QiLw9AJhbSD6yQWLfMQKZYZuf5g4t8Vi240qxqcHSo
         MV579LJzxcLPJ6rKLF7xDEJquYUhqfAxtyngqMyg=
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "luciano.coelho@intel.com" <luciano.coelho@intel.com>,
        "emmanuel.grumbach@intel.com" <emmanuel.grumbach@intel.com>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
References: <20200918171301.6942-1-alexander@wetzel-home.de>
 <f6df593556c3f395997dfe42a71a69f4919a5911.camel@sipsolutions.net>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <c887ae58-983b-0f4b-3b00-8ffbb669f37a@wetzel-home.de>
Date:   Sun, 20 Sep 2020 08:37:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f6df593556c3f395997dfe42a71a69f4919a5911.camel@sipsolutions.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-GUID: 7f968c6e-1140-45f6-abaf-5c2d1c376797
X-Ovh-Tracer-Id: 17914474895445597347
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdelgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheptehlvgigrghnuggvrhcuhggvthiivghluceorghlvgigrghnuggvrhesfigvthiivghlqdhhohhmvgdruggvqeenucggtffrrghtthgvrhhnpedtteduudehkedvgfdujeetjedugfelgeefueelueeiueeiteeugeeljeeuieeiteenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnkedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrlhgvgigrnhguvghrseifvghtiigvlhdqhhhomhgvrdguvgdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


 >>
 >> +		/* GCMP and 256 bit CCMP keys the key can't be copied into the
 >> +		 * MPDU struct ieee80211_tx_info. We therefore must flush the
 >> +		 * queues to ensure there are no MPDUs left which are referring
 >> +		 * to the outgoing key.
 >> +		 */
 >> +		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE &&
 >> +		    (key->cipher == WLAN_CIPHER_SUITE_GCMP ||
 >> +		     key->cipher == WLAN_CIPHER_SUITE_GCMP_256 ||
 >> +		     key->cipher == WLAN_CIPHER_SUITE_CCMP_256)) {
 >> +			ieee80211_stop_queues(hw);
 >> +			iwl_mvm_mac_flush(hw, vif, 0, true);
 >> +			ieee80211_wake_queues(hw);
 >> +		}
 >
 > Shouldn't the wake be after installing the new key? Otherwise new frames
 > can race and be there again?

mac80211 is taking care of that and has already stopped queuing new 
MPDUs which would use the key by setting KEY_FLAG_TAINTED on it. So for 
a PTK0 rekey we are fine, mac80211 won't queue frames with the key under 
deletion.

But I think we should start setting KEY_FLAG_TAINTED for *any* PTK 
deletion to make sure we are not sending out MPDUs with a zero key or 
something like that. This is a special kind of a rekey case we missed so 
far but should be trival cover that, too.

That is then basically taking care about the generic Kr00k vulnerability 
  some months ago.

Now I'm not aware of we have any mitigations in the code for that but 
when we set KEY_FLAG_TAINTED for key deletions any driver which is able 
to rekey PTK0 correctly can't be affected by Kr00k any longer.

I'll look into that in the next days and prepare a patch for mac8011 to 
discuss that.

Alexander
