Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4374994EAA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 22:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfHSUDT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 16:03:19 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:33077 "EHLO
        7.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfHSUDS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 16:03:18 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Aug 2019 16:03:18 EDT
Received: from player739.ha.ovh.net (unknown [10.108.35.90])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 7750F7519B
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 21:57:15 +0200 (CEST)
Received: from awhome.eu (p4FF9179D.dip0.t-ipconnect.de [79.249.23.157])
        (Authenticated sender: postmaster@awhome.eu)
        by player739.ha.ovh.net (Postfix) with ESMTPSA id 07926911B148;
        Mon, 19 Aug 2019 19:57:11 +0000 (UTC)
Subject: Re: [PATCH] iwlwifi: Extended Key ID support for mvm and dvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1566244631;
        bh=D8cCTBm+uI0sPWwFisFvHEA9kCD3sRhInJL3DTZw3ss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZoTsXIYjvWfl6YkWu2sHM0ZbSouAY5aOwYklv+UKXih7/irlMQ7E5oUBDGddhs5l7
         nA2Zj7kCmI8GplPmC4fnCju+4EH/JVjnJBMeURvvc1jKEGar+Z52TWD3P3nmELB4Ll
         kXQ3a/cG2ft6tc2XXfsWgqbVgc4CyuMuCOu/AMjw=
To:     Johannes Berg <johannes@sipsolutions.net>, luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
References: <20190819180540.2855-1-alexander@wetzel-home.de>
 <204c346ab9fc71865e4cb5f5c29ec33ca05050e2.camel@sipsolutions.net>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <da471544-3370-8ba1-2265-d02ab09cdcee@wetzel-home.de>
Date:   Mon, 19 Aug 2019 21:57:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <204c346ab9fc71865e4cb5f5c29ec33ca05050e2.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18382286307035847880
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefledgudeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>> +
>> +	/* The new Tx API does not allow to pass the key or keyid of a MPDU to
>> +	 * the hw, preventing us to control which key(id) to use per MPDU.
>> +	 * Till that's fixed we can't use Extended Key ID for the newer cards.
> 
> Technically we still don't need per MPDU, we just need to switch which
> one to use for TX after installing it for RX already.

The Extended Key ID API we finally merged in mac80211 is not notifying 
the driver when to switch the key over to the other id.
The current API provides the key/keyid per MPDU and let's mac80211 have 
the full control what's the correct key for each frame.

That's especially critical for drivers setting 
IEEE80211_KEY_FLAG_GENERATE_IV and/or supporting A-MPDU's. Allowing the 
driver to override the mac80211 decision is only safe when the 
driver/card generates the PNs itself and also handles the A-MPDU key 
borders correctly.

While less desirable we still could get that working: The mvm driver 
would have to detect the key borders and then tell the firmware to 
switch over to the other key. But we would have to make sure to not 
re-enable A-MPDU aggregation till the card really has switched.

Alexander

