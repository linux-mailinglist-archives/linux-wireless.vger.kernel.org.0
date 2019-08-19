Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3892092
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfHSJnM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 05:43:12 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:38480 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfHSJnM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 05:43:12 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hzeBq-0006qe-Ru; Mon, 19 Aug 2019 11:43:03 +0200
Message-ID: <d3c6d084728e4203832688b63e884d25b0f74fcf.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] iwlwifi: Enable Extended Key ID for mvm and dvm
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 11:43:00 +0200
In-Reply-To: <cd1b1a83-55e2-3c07-dbe2-0c459bbcdc7e@wetzel-home.de>
References: <20190629195015.19680-1-alexander@wetzel-home.de>
         <20190629195015.19680-4-alexander@wetzel-home.de>
         <cd1b1a83-55e2-3c07-dbe2-0c459bbcdc7e@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-08-17 at 10:31 +0200, Alexander Wetzel wrote:
> > All iwlwifi cards are able to handle multiple keyids per STA and are
> > therefore fully compatible with the Extended Key ID implementation
> > provided by mac80211.
> 
> I just tried Extended Key ID with a AX200 card and it really looks like 
> it's incompatible:-(

Hmm.

> The card is starting to use the PTK key immediately after installation, 
> encrypting EAPOL #3 with the new (still Rx only!) key.

Right. This wasn't considered, I guess.

> Digging around in the driver code it looks like we do not even pass the 
> key information any longer to the card: iwl_mvm_set_tx_params() is 
> bypassing iwl_mvm_set_tx_cmd_crypto() completely when we use the "new tx 
> API". So all cards setting "use_tfh" to true are now incompatible.
> 
> Therefore it looks like that all cards starting with the 22000 series 
> can't be used with Extended Key ID any longer.
> 
> Is there a way to hand over the key information within the new API or is 
> the way forward to block Extended Key ID when the "new tx API" is being 
> used?

Not right now, but I think it could be fixed.

> The card is fine with using keyid 1 for unicast keys. But it looks like 
> it assumes that a new key install also tells it to use the new key 
> immediately... Still digging around but pretty sure that's happening now.

Right.

For now I guess we have to disable it with the new TX API (which is
really what it depends on), we can try to fix the firmware later.

johannes

