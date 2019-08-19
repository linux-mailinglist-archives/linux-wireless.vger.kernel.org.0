Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B9594EDA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfHSUXe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 16:23:34 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47590 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfHSUXd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 16:23:33 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hzoBa-00044T-W5; Mon, 19 Aug 2019 22:23:27 +0200
Message-ID: <eb0481b1928b0554daeda59cfc1d631e44bb2bdd.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] iwlwifi: Enable Extended Key ID for mvm and dvm
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 22:23:24 +0200
In-Reply-To: <ae321cd5-6ef4-87c5-98ec-dbac37e83c6d@wetzel-home.de>
References: <20190629195015.19680-1-alexander@wetzel-home.de>
         <20190629195015.19680-4-alexander@wetzel-home.de>
         <cd1b1a83-55e2-3c07-dbe2-0c459bbcdc7e@wetzel-home.de>
         <d3c6d084728e4203832688b63e884d25b0f74fcf.camel@sipsolutions.net>
         <ae321cd5-6ef4-87c5-98ec-dbac37e83c6d@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-08-19 at 17:52 +0200, Alexander Wetzel wrote:

> We may also get away by adding only means to pass the keyid of the MPDU 
> (zero or one) to the HW. That could be done quite simple, I think:
> 
> We could add two new flags, e.g. IWL_TX_FLAGS_ENCRYPT_ID_0 and 
> IWL_TX_FLAGS_ENCRYPT_ID_1 to avoid the need to change the structures 
> iwl_tx_cmd_gen2 and iwl_tx_cmd_gen3.
> When the firmware would check and use the key referenced by the STA + 
> flag-id prior to the "last installed" key that should be sufficient.
> By still using the last installed key without any of the new flags set 
> we also would remain backward compatible.
> 
> If you have any experimental firmware to test I'm happy to do so:-)
> Till then I'm back using older iwlwifi cards.

I'm not convinced that we can change the TX API at all, I suspect we
have to go detect it as we saw in the other patch. If we do actually
have the ability to change the TX API it might be simpler overall, but
anyway, I'd have to go look at how this is all implemented before I
comment further. Doesn't seem like an intractable problem, the only
question is if we get to spend time on it :)

johannes

