Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484ED50868A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 13:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357186AbiDTLGw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377886AbiDTLGt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 07:06:49 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B544131E
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 04:03:57 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1650452636; bh=naWMBiinACBkPb3VQa4ASl1RJDyD1VGA8MbhP3dsIB4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jtMBYJCRo0XPnPPX/wVzPei6uKKHCcEIa2FxlthZj7phnHMJqIMK6S1y6/d1X2eWs
         1g4/1+v5PCOhu0GmZLBjeSjAWXgo63/1W6ftvzDm2+eZ4ouqnGq8YD7qGFPTnfd2Io
         4PYTSJEfaUCKXBqo7lH4Qf32A/8sAta+YZxjmP2QySz9XgH68ya7ZPA2RPzrdtwGbs
         7z+hP7XUMzIvPprkkFvVrzsuzIjuTQ/K5Zyk0/NpPf7+YKaRONsQcisHAhA5Q9HR2d
         99S8OzlXpgZ+eB4M514uTxSZFR/Fgy7/8XGjC+551a/L7Wsk5VI6xZV61nt/V2mkoc
         yeBMkWUyV74wg==
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
In-Reply-To: <724999bde562fedea5933cbe7bc949da796b2f30.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
 <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
 <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
 <be3b424aec839d899e4a8cd659ebb53a85d67339.camel@intel.com>
 <87mtghs3y2.fsf@toke.dk>
 <e0872b6f468bfda08717214044b64187f71b4e18.camel@intel.com>
 <94b98b712b86690dd5ae19df0cc608b8193be1f3.camel@intel.com>
 <877d7kn62t.fsf@toke.dk>
 <a8b437f1fc466096f119298ae1562c2aa224ad95.camel@intel.com>
 <87o80whyoy.fsf@toke.dk>
 <724999bde562fedea5933cbe7bc949da796b2f30.camel@intel.com>
Date:   Wed, 20 Apr 2022 13:03:55 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ilr4hv8k.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com> writes:

> removing Luca
>
> On Wed, 2022-04-20 at 11:49 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>
> <snip>
>
>> > >=20
>> >=20
>> > So you do get a SAP connection. Weird.
>> > Checking with the CSME guys.
>> > Can you get dynamic debug prints for iwlmei module?
>> > Best would be tracing with -e iwlmei_sap_cmd
>>=20
>> Sure! Recorded these while doing a suspend-restore, then restarting iwd:
>>=20
>> =C2=A0 kworker/u16:34-34555 [004] 46452.506238: iwlmei_sap_cmd:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 sap_cmd Tx: type 1010 len 8 seq
>> 11
>> =C2=A0 kworker/u16:34-34555 [004] 46452.506243: iwlmei_me_msg:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ME message: Tx: type 3 seq 8
>> =C2=A0 kworker/u16:34-34555 [004] 46452.559407: iwlmei_sap_cmd:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 sap_cmd Tx: type 1001 len 4 seq
>> 12
>> =C2=A0 kworker/u16:14-33311 [004] 46452.573077: iwlmei_sap_cmd:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 sap_cmd Tx: type 1006 len 0 seq
>> 13
>> =C2=A0 kworker/u16:14-33311 [004] 46452.573078: iwlmei_me_msg:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ME message: Tx: type 3 seq 10
>> =C2=A0=C2=A0=C2=A0=C2=A0 kworker/4:0-34305 [004] 46452.706737: iwlmei_me=
_msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ME message: Tx: type 3 seq =
11
>> =C2=A0=C2=A0 kworker/u16:8-34462 [000] 46457.939453: iwlmei_me_msg:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ME message: Tx: type 1 seq 1
>> =C2=A0=C2=A0=C2=A0=C2=A0 kworker/4:2-32196 [004] 46457.940910: iwlmei_me=
_msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ME message: Rx: type 2 seq =
81
>> =C2=A0=C2=A0=C2=A0=C2=A0 kworker/4:2-32196 [004] 46457.940912: iwlmei_sa=
p_cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sap_cmd Tx: type 1013 len 0 seq 1
>> =C2=A0=C2=A0=C2=A0=C2=A0 kworker/4:2-32196 [004] 46457.940913: iwlmei_me=
_msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ME message: Tx: type 3 seq 2
>> =C2=A0=C2=A0=C2=A0=C2=A0 kworker/4:2-32196 [004] 46457.942056: iwlmei_me=
_msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ME message: Rx: type 3 seq =
82
>> =C2=A0=C2=A0=C2=A0=C2=A0 kworker/4:2-32196 [004] 46457.942060: iwlmei_sa=
p_cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sap_cmd Rx: type 502 len 4 seq 1
>> =C2=A0=C2=A0=C2=A0=C2=A0 kworker/4:2-32196 [004] 46458.042205: iwlmei_me=
_msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ME message: Rx: type 3 seq =
83
>> =C2=A0=C2=A0=C2=A0=C2=A0 kworker/4:2-32196 [004] 46458.042208: iwlmei_sa=
p_cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sap_cmd Rx: type 500 len 1896 seq
>> 2
>> =C2=A0=C2=A0=C2=A0=C2=A0 kworker/4:2-32196 [004] 46458.042209: iwlmei_sa=
p_cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sap_cmd Rx: type 512 len 64 seq 3
>> =C2=A0=C2=A0=C2=A0=C2=A0 kworker/4:2-32196 [004] 46458.042214: iwlmei_sa=
p_cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sap_cmd Rx: type 502 len 4 seq 4
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 iwd-35396 [003] 46467.085642: iwlmei_sap_cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sap_cmd Tx: type 1008 len 8 seq 2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 iwd-35396 [003] 46467.085645: iwlmei_me_msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ME message: Tx: type 3 seq 3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 iwd-35396 [003] 46467.102818: iwlmei_sap_cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sap_cmd Tx: type 1008 len 8 seq 3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 iwd-35396 [003] 46467.103369: iwlmei_sap_cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sap_cmd Tx: type 1016 len 20 seq
>> 4
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 iwd-35396 [003] 46467.103842: iwlmei_sap_cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sap_cmd Tx: type 1001 len 4 seq 5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 iwd-35396 [003] 46467.104689: iwlmei_sap_cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sap_cmd Tx: type 1002 len 12 seq
>> 6
>
> can you please send the content of tracing unparsed?
> There is more binary data that I can use.

Sure! I'll send you the trace.dat file off-list (it's almost 10 MB).

> I definitely need to talk to the CSME guys, I can see that CSME is
> alive even if you have AMT disabled.

What is this CSME thing, anyway? And does this imply that the AMT is not
really disabling itself (there's also a "permanently disable" option in
BIOS that I have not dared pick..)

> Problem: it's holiday season here.

No worries, I can live with working around the issue in the meantime; I
guess I can get systemd to automatically restart iwd when returning from
suspend if I can just figure out the right incantation :)

-Toke
