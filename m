Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7957C3EB14A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 09:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbhHMHUc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 03:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbhHMHUb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 03:20:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432CC061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ii8qigtqoWhNY+QmoOCkpVp/ABXpmn52aG2GUe/zRcw=;
        t=1628839205; x=1630048805; b=T1Denlz1Bu4lSYlkD0ysxIPyb029VfLjXn+mJwKAkNt1NMg
        Ww/cJE7bN9MfureyTOGNwrtR+JbqiKb0cBRhlNMuWrvOn5Ens+1pSdjzi9HndGcVr2+lYCsWPOt6f
        ptNAVkmAUG5wRRmYQcdaHbikaAghpX82AJKwmsOe7+jO5NxLascabmu94z1V6PiaNK8BFXRFJzFQZ
        Pvj8op7rGU/ug3zTspH2YvPqj0YM0Keta4P/MKcJlQzw1Dp5Z2VJSD7rdsTnMgfLGrhBqAj/r5qIS
        RWcg/vDXOgoWstPirRhWFM2yic/u0S1o82kzkCDDzfWY+5fmE17sD45exXUi7WcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mERTw-00A8YF-8k; Fri, 13 Aug 2021 09:19:56 +0200
Message-ID: <38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] mac80211: save transmit power envelope element and
 power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 13 Aug 2021 09:19:55 +0200
In-Reply-To: <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-10-wgong@codeaurora.org>
         (sfid-20210517_222034_029448_A9A89D57) <d9491db4ece67ac78eb39a1078b91a106770fbb0.camel@sipsolutions.net>
         <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-07-30 at 18:47 +0800, Wen Gong wrote:
> 
> > And then two more questions:
> > 
> > 1) Could this information change? Should we track it in beacons?
> > 
> 
> The information is from AP side, it should be not changed untill the AP 
> restart.
> If someone want to change configure of AP, the AP should restart and 
> then take effect by my understand.
> Is it have some case for this information change?

No, I guess that's fine then, I just didn't know.

> > 2) Should we at least check it again from the protected beacon or such
> > after association, so we don't blindly trust the probe response or
> > beacon (received during scan, not validated) at least when BIGTK is in
> > use?
> 
> May we add support for BIGTK in future with another patch?

We already have BIGTK support in mac80211, so if we don't do that now
we're almost certainly not going to do it, so I'd really prefer if you
did it here, or if a separate patch still did it now.

> The info(pwr_reduction and tx_pwr_env) is used by lower driver such as 
> ath11k.

Sure.

> If the info changed after association, then how to notify lower driver?
> Do it like below in ieee80211_rx_mgmt_beacon()?
> And use BSS_CHANGED_TXPOWER or a new enum in ieee80211_bss_change?

Yeah, dunno. Are the drivers assuming now it's set once you get to
associated state?

johannes

