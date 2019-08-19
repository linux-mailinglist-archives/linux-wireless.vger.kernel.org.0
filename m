Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B6394F3C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 22:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfHSUmz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 16:42:55 -0400
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:45258 "EHLO
        6.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfHSUmz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 16:42:55 -0400
X-Greylist: delayed 17392 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Aug 2019 16:42:53 EDT
Received: from player755.ha.ovh.net (unknown [10.108.42.145])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 8687E12BE0C
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 17:52:59 +0200 (CEST)
Received: from awhome.eu (p4FF9179D.dip0.t-ipconnect.de [79.249.23.157])
        (Authenticated sender: postmaster@awhome.eu)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id 0C80A90A4B2C;
        Mon, 19 Aug 2019 15:52:56 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1566229975;
        bh=eIvcs0iqIrxoz4T9tyYlAB4GiLp35OTVycjMUEyOhJM=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To;
        b=ghb/zn/din7ehT1mPJvWerGNlZDgqJeolRJFyGbAJw3okw4PsowJ5s/1on9TCgNpG
         fjgyNsr0vJ3e25gsglhK1I6BkINpJPOavjOClHXZ9TBPBa5dg3Q/Gr4l7y8zyQgbXM
         nDLpq/LTfov4uF6nutuUK1PGW9JeAh+L8OwDA/nA=
Subject: Re: [PATCH 4/4] iwlwifi: Enable Extended Key ID for mvm and dvm
To:     Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
References: <20190629195015.19680-1-alexander@wetzel-home.de>
 <20190629195015.19680-4-alexander@wetzel-home.de>
 <cd1b1a83-55e2-3c07-dbe2-0c459bbcdc7e@wetzel-home.de>
 <d3c6d084728e4203832688b63e884d25b0f74fcf.camel@sipsolutions.net>
Message-ID: <ae321cd5-6ef4-87c5-98ec-dbac37e83c6d@wetzel-home.de>
Date:   Mon, 19 Aug 2019 17:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d3c6d084728e4203832688b63e884d25b0f74fcf.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14256989047950679292
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefledgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 19.08.19 um 11:43 schrieb Johannes Berg:
> On Sat, 2019-08-17 at 10:31 +0200, Alexander Wetzel wrote:
>>> All iwlwifi cards are able to handle multiple keyids per STA and are
>>> therefore fully compatible with the Extended Key ID implementation
>>> provided by mac80211.
>>
>> I just tried Extended Key ID with a AX200 card and it really looks like
>> it's incompatible:-(
> 
> Hmm.
> 
>> The card is starting to use the PTK key immediately after installation,
>> encrypting EAPOL #3 with the new (still Rx only!) key.
> 
> Right. This wasn't considered, I guess.
> 
>> Digging around in the driver code it looks like we do not even pass the
>> key information any longer to the card: iwl_mvm_set_tx_params() is
>> bypassing iwl_mvm_set_tx_cmd_crypto() completely when we use the "new tx
>> API". So all cards setting "use_tfh" to true are now incompatible.
>>
>> Therefore it looks like that all cards starting with the 22000 series
>> can't be used with Extended Key ID any longer.
>>
>> Is there a way to hand over the key information within the new API or is
>> the way forward to block Extended Key ID when the "new tx API" is being
>> used?
> 
> Not right now, but I think it could be fixed.

That would be great!

We may also get away by adding only means to pass the keyid of the MPDU 
(zero or one) to the HW. That could be done quite simple, I think:

We could add two new flags, e.g. IWL_TX_FLAGS_ENCRYPT_ID_0 and 
IWL_TX_FLAGS_ENCRYPT_ID_1 to avoid the need to change the structures 
iwl_tx_cmd_gen2 and iwl_tx_cmd_gen3.
When the firmware would check and use the key referenced by the STA + 
flag-id prior to the "last installed" key that should be sufficient.
By still using the last installed key without any of the new flags set 
we also would remain backward compatible.

If you have any experimental firmware to test I'm happy to do so:-)
Till then I'm back using older iwlwifi cards.

> 
>> The card is fine with using keyid 1 for unicast keys. But it looks like
>> it assumes that a new key install also tells it to use the new key
>> immediately... Still digging around but pretty sure that's happening now.
> 
> Right.
> 
> For now I guess we have to disable it with the new TX API (which is
> really what it depends on), we can try to fix the firmware later.

Ok. I'll update the iwlwifi Extended key ID support patch accordingly.

Alexander
