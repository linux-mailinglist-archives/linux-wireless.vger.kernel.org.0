Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB30150E17B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Apr 2022 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiDYNYo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Apr 2022 09:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbiDYNYl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Apr 2022 09:24:41 -0400
X-Greylist: delayed 216 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 06:21:36 PDT
Received: from mail1.nippynetworks.com (mail1.nippynetworks.com [91.220.24.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA97433E0D
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 06:21:36 -0700 (PDT)
Received: from [192.168.8.188] (unknown [94.228.36.46])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: ed@wildgooses.com)
        by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4Kn5D632CszTgSQ;
        Mon, 25 Apr 2022 14:17:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1650892678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugldtJvJRE+iZ7grfzTpN4hFTUFMYT/R84SKDFhQpEU=;
        b=FPQd6IKeSalwjjWt93VUceESHSDwBrK/TrQ8ZUPEZm7+o7bOmVc4b1DWvyVv8Hwk5W/jX9
        c8L+Q6bwMuSdo011LK3KPaEiPh9goUw7SHzGQ3DOYn6BwTQDfiE7qZQYXqGJ3LSxDR0wYN
        tXxcROiOWtw3vslDhSlA557EvH22th4=
Message-ID: <e7268989-03cf-ae7c-f3c6-b48fe679b790@wildgooses.com>
Date:   Mon, 25 Apr 2022 14:17:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [wireless-regdb] Correction of wireless-regdb for GB
Content-Language: en-GB
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <4d07581c-a3be-a3c6-bf32-7007eb45d541@wildgooses.com>
 <20201106214446.GG6125@ubuntu-x1>
 <2a710032-f2ec-d55b-5da4-d881089fe0cd@wildgooses.com>
 <20201120175444.GN5439@ubuntu-x1>
From:   Ed W <lists@wildgooses.com>
In-Reply-To: <20201120175444.GN5439@ubuntu-x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20/11/2020 17:54, Seth Forshee wrote:
>> Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
>> ---
>>  db.txt | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/db.txt b/db.txt
>> index ac32483..cc5ffd0 100644
>> --- a/db.txt
>> +++ b/db.txt
>> @@ -588,13 +588,16 @@ country FR: DFS-ETSI
>>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0019/136009/Ofc=
om-Information-Sheet-5-GHz-RLANs.pdf
>>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2=
030.pdf
>>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0013/126121/Sta=
tement_Implementing-Ofcoms-decision-on-the-57-71GHz-band.pdf
>> +# GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0036/198927/6gh=
z-statement.pdf
>>  country GB: DFS-ETSI
>>  	(2400 - 2483.5 @ 40), (100 mW)
>>  	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
>>  	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=3DET=
SI
>> -	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
>> +	(5470 - 5730 @ 160), (500 mW), DFS, wmmrule=3DETSI
> This looks okay to me.
>
>>  	# short range devices (ETSI EN 300 440-1)
>> -	(5725 - 5875 @ 80), (25 mW)
>> +	# See UK specific notes in ir-2030.pdf, p47
>> +	(5725 - 5850 @ 80), (200 mW), AUTO-BW, wmmrule=3DETSI
> To echo what I said above, I'm unclear whether this change is in effect=

> yet, and based what I've seen so far I think it would need to include
> NO-OUTDOOR.
>
>> +	(5925 - 6425 @ 160), (250 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
> I'm also unclear on whether this change is in effect yet.
>
> Thanks,
> Seth
>
>>  	# 60 GHz band channels 1-6
>>  	(57000 - 71000 @ 2160), (40)
>> =20
>> --=20
>> 2.26.2
>>

Hi all, I dropped off watching this for a while....

Seems like the update to IR2030 (GB country code regulations) was re-publ=
ished last year, and the
relevant sections are in pages 32 + 34-36

My reading of this is:

- Other stuff we changed 2 years ago seems ok, caveat I'm unclear when we=
 need to state half power
vs using mean EIRP?
- The 5.9-6.4Ghz range is now good for use (page 35 near the bottom), per=
haps add something like:

+=C2=A0=C2=A0=C2=A0 (5925 - 6425 @ 160), (250 mW), NO-OUTDOOR, AUTO-BW, w=
mmrule=3DETSI

- The 60Ghz range seems to available now, but I'm not sure what power num=
ber we should have in our
db.txt, see page 32.
Says "40 dBm e.i.r.p / 27 dBm maximum transmit output power"
- There are also some geographic restrictions, not sure what we can do ab=
out those?

So something like this perhaps?:

> +	(5700 - 71000 @ 160), (40)

Happy to knock this up into a patch if you can help with a little guidanc=
e (although it might be
faster for you to just commit the 2 extra lines if you agree?)

Thanks

Ed W
