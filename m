Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C410E573D6
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 23:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFZVq5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 17:46:57 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:37399 "EHLO
        4.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZVq5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 17:46:57 -0400
X-Greylist: delayed 1799 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jun 2019 17:46:56 EDT
Received: from player760.ha.ovh.net (unknown [10.109.146.168])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2B9931A0E75
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2019 23:11:05 +0200 (CEST)
Received: from awhome.eu (p4FF919DE.dip0.t-ipconnect.de [79.249.25.222])
        (Authenticated sender: postmaster@awhome.eu)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id C08EB74DFB5A;
        Wed, 26 Jun 2019 21:11:02 +0000 (UTC)
Subject: Re: [PATCH 2/2] iwlwifi: Extended Key ID support
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1561583461;
        bh=CTeBt6deupLCWji8dEYszqS0+oYSZbhIsk2oTGgFwTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ty313rkbMliASDJHyrvjmEzYcvTC9XTsM6vBDY5Yr5egK9asUw4w5qP/FjBGoGkBu
         KLb4maj5yqWQx6fZpmu51a3dmAU2m/VFBVOYpsShh5epoT24sY3I8zX/qPHLCBXyrz
         CXgUy5M/SccMbpCkZvcJzsWu36ULZX/D/g/pne8s=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
References: <20190506190149.3624-1-alexander@wetzel-home.de>
 <20190506190149.3624-2-alexander@wetzel-home.de>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <7a173bac-37d2-b470-8cb6-0f7e41e26ca5@wetzel-home.de>
Date:   Wed, 26 Jun 2019 23:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190506190149.3624-2-alexander@wetzel-home.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16098398343428250876
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeigdduieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> iwlwifi cards are all able to support Extended Key ID as long as
> mac80211 stops A-MPDU aggregation when replacing the unicast key.
> 
> Enable Extended Key ID support and tell mac80211 that it has to tear
> down any running Tx aggregation sessions during rekey when using
> Extended Key ID.

With the merge of the A-MPDU handling patch 
https://patchwork.kernel.org/patch/10931861/ we probably should simplify 
the API for Extended Key ID and not merge the patch as it is:

1) We can drop EXT_KEY_ID_NATIVE from mac80211 and let the drivers set
    NL80211_EXT_FEATURE_EXT_KEY_ID instead of mac80211.
    Without the COMPAT support the naming is off and the flag is simply
    pointless. Assuming we want to pick up the COMPAT Extended Key ID we
    still can just define a new flag, e.g.
    SINGLE_STA_UNICAST_KEY_OFFLOAD_ONLY to tell mac80211 it can only
    have one unicast key active in the HW per STA.

2) Mac80211 would then enable Extended Key ID for all drivers using SW
    crypto and just also set NO_AMPDU_KEYBORDER_SUPPORT when the driver
    supports A-MPDU

3) we then could undo (revert?) cfe7007a9b4c ("mac80211_hwsim: Extended
    Key ID support") and let the more generic code in mac80211 handle it

If you agree I'll prepare and test a small patch series for that.
And we better only merge a iteration of this patch here once we got the 
API updated.

Alexander
