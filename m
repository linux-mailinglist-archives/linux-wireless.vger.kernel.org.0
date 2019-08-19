Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19094FA4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfHSVPK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 17:15:10 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:49326 "EHLO
        3.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfHSVPK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 17:15:10 -0400
Received: from player716.ha.ovh.net (unknown [10.108.35.74])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 95EDE64484
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 23:15:07 +0200 (CEST)
Received: from awhome.eu (p4FF9179D.dip0.t-ipconnect.de [79.249.23.157])
        (Authenticated sender: postmaster@awhome.eu)
        by player716.ha.ovh.net (Postfix) with ESMTPSA id 0DF578E406D2;
        Mon, 19 Aug 2019 21:15:04 +0000 (UTC)
Subject: Re: [PATCH 4/4] iwlwifi: Enable Extended Key ID for mvm and dvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1566249303;
        bh=hbmNEuDHtukGJieI+S52JwOjHwsSoZzrGFjR5aHnaG4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sOHZQUbv8as+MLIDdN713rES/nrPwk5q2NLnJLny8aCRunbD6XbGJeBa4gqYs8tH3
         xxshjTZ38p9NBfBu4t3uwT53dgGJdSzjXHUK4RYYbpu44aUKHKY8uiCY/yP/dvB1Nr
         kt9l3ZPgIxT6tJ5viKY4ozSCiTcWLVcr/prCBcDA=
To:     Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
References: <20190629195015.19680-1-alexander@wetzel-home.de>
 <20190629195015.19680-4-alexander@wetzel-home.de>
 <cd1b1a83-55e2-3c07-dbe2-0c459bbcdc7e@wetzel-home.de>
 <d3c6d084728e4203832688b63e884d25b0f74fcf.camel@sipsolutions.net>
 <ae321cd5-6ef4-87c5-98ec-dbac37e83c6d@wetzel-home.de>
 <eb0481b1928b0554daeda59cfc1d631e44bb2bdd.camel@sipsolutions.net>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <42653433-58b5-10f0-288e-1e5731e012d1@wetzel-home.de>
Date:   Mon, 19 Aug 2019 23:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eb0481b1928b0554daeda59cfc1d631e44bb2bdd.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1250593322868219132
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefledgudehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 19.08.19 um 22:23 schrieb Johannes Berg:
> On Mon, 2019-08-19 at 17:52 +0200, Alexander Wetzel wrote:
> 
>> We may also get away by adding only means to pass the keyid of the MPDU
>> (zero or one) to the HW. That could be done quite simple, I think:
>>
>> We could add two new flags, e.g. IWL_TX_FLAGS_ENCRYPT_ID_0 and
>> IWL_TX_FLAGS_ENCRYPT_ID_1 to avoid the need to change the structures
>> iwl_tx_cmd_gen2 and iwl_tx_cmd_gen3.
>> When the firmware would check and use the key referenced by the STA +
>> flag-id prior to the "last installed" key that should be sufficient.
>> By still using the last installed key without any of the new flags set
>> we also would remain backward compatible.
>>
>> If you have any experimental firmware to test I'm happy to do so:-)
>> Till then I'm back using older iwlwifi cards.
> 
> I'm not convinced that we can change the TX API at all, I suspect we
> have to go detect it as we saw in the other patch. If we do actually
> have the ability to change the TX API it might be simpler overall, but
> anyway, I'd have to go look at how this is all implemented before I
> comment further. Doesn't seem like an intractable problem, the only
> question is if we get to spend time on it :)

You are thinking about keeping the tx API untouched and modify the key 
install logic?
Just prevent the firmware to activate a key for Tx when it's installed 
and notify the firmware by some means when the key can be used for Tx 
and then switch everything to the new key?

I guess there is no practical way I can get access to the firmware code, 
correct? For me it sounds harder than the optional flag extension I had 
in mind for the new tx API.

After all one of the existing flags can already suppress the encryption.
Checking for the presence of two optional flags and use these to select 
a different key sounded not very hard. But then I literally know nothing 
about that and if the card/firmware has some fundamental issue handling 
two unicast keys the picture changes of course...

So let's wait and see what you can turn up. Till then we have more than 
enough other cards supporting Extended Key ID:-)

Alexander
