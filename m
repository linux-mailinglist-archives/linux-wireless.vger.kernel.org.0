Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4B508534
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 11:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377331AbiDTJwI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350547AbiDTJwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 05:52:07 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A98E38781
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 02:49:20 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1650448159; bh=uWh15eKgUDnDFx4SW9NadA0nfRIrzB86LhvimqtPQWo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JfMtHmG06UVG6rXXSstXKFy0WWkbJzPopBju+EfIXe31B877IvMJcHrHaMvK4Rd15
         5sNHdu88kURykUOoLioIBXE000FJ95w7XiZ7T9sP0RzVCZHP7nR9yJDd+UA8XY1PSI
         RPx++6ms6nsKzg7xsCYAG0E391uU3+Q1MNuCA046Xwmus8g/SVIgrj4IE+8K3B79kC
         gXXwoYz6nWMRIxVA/VcbRdfYlJydBtBwl/kQJGjKasSzicRmWfHd1xpHg8zJ5li1/9
         FtoyXjFi67ckhaIY3416uWbVj2Tyi99RzzzEwHTLAw/lqbh6eUCtMByu1cT1fKsFul
         nM4Pz9edf54cA==
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
In-Reply-To: <a8b437f1fc466096f119298ae1562c2aa224ad95.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
 <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
 <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
 <be3b424aec839d899e4a8cd659ebb53a85d67339.camel@intel.com>
 <87mtghs3y2.fsf@toke.dk>
 <e0872b6f468bfda08717214044b64187f71b4e18.camel@intel.com>
 <94b98b712b86690dd5ae19df0cc608b8193be1f3.camel@intel.com>
 <877d7kn62t.fsf@toke.dk>
 <a8b437f1fc466096f119298ae1562c2aa224ad95.camel@intel.com>
Date:   Wed, 20 Apr 2022 11:49:17 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o80whyoy.fsf@toke.dk>
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

> On Tue, 2022-04-19 at 22:58 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com> writes:
>>=20
>> > On Tue, 2022-04-19 at 20:46 +0300, Grumbach, Emmanuel wrote:
>> > > On Tue, 2022-04-19 at 13:33 +0200, Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
>> > > > "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com> writes:
>> > > >=20
>> > > > > On Tue, 2022-04-19 at 09:41 +0300, Grumbach, Emmanuel wrote:
>> > > > > > Hi Toke,
>> > > > > >=20
>> > > > > > On Tue, 2022-04-19 at 06:24 +0000, Coelho, Luciano wrote:
>> > > > > > > On Mon, 2022-04-18 at 13:36 +0200, Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>> > > > > > > > Hi Luca
>> > > > > > >=20
>> > > > > > > Hi Toke,
>> > > > > > >=20
>> > > > > > > > I've started seeing issues with my iwlwifi interface going=
 away after
>> > > > > > > > suspend. I get errors like these in dmesg:
>> > > > > > > >=20
>> > > > > > > > [104393.142264] wlan0: deauthenticating from 4c:60:de:ea:b=
8:58 by local choice
>> > > > > > > > (Reason:
>> > > > > > > > 3=3DDEAUTH_LEAVING)
>> > > > > > > > [104393.347775] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1a=
a-5e70cbb1e865: Couldn't
>> > > > > > > > get
>> > > > > > > > ACK
>> > > > > > > > from
>> > > > > > > > CSME on HOST_GOES_DOWN message
>> > > > > > > > [104393.347876] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1a=
a-5e70cbb1e865: failed to
>> > > > > > > > send
>> > > > > > > > the
>> > > > > > > > SAP_ME_MSG_CHECK_SHARED_AREA message -19
>> > > > > > > >=20
>> > > > > > > > And when the host comes back up, there is no connectivity.=
 Restarting
>> > > > > > > > iwd fixes the problem.
>> > > > > > > >=20
>> > > > > > > > This is on a 5.17.3 kernel (Arch Linux distribution kernel=
), and lspci
>> > > > > > > > says the WiFi device is an "Intel Corporation Wi-Fi 6 AX20=
1".
>> > > > > > > >=20
>> > > > > > > > Any ideas? :)
>> > > > > > >=20
>> > > > > > > This seems to be related to iwlmei, so I added Emmanuel to t=
he thread.
>> > > > > > >=20
>> > > > > >=20
>> > > > > > Can we have the full dmesg output?
>> > > > > > What NIC / platform do you have?
>> > > > > > Do you have AMT configured in the BIOS?
>> > > > > > Did you enable wireless operation in AMT?
>> > > > >=20
>> > > > > Ah - this is AX201, ok, but I still need the platform and theful=
l dmesg :-)
>> > > >=20
>> > > > It's a Lenovo ThinkPad X1 Carbon Gen 9, model 20XXS3HC26; AMT is s=
et to
>> > > > "Disabled" in the BIOS. I rebooted and did a suspend/wake cycle af=
ter
>> > > > connecting to the WiFi network, which produced the dmesg below.
>> > >=20
>> > > Thanks.
>> > > This is a Skylake platform and we didn't have a handshake with CSME =
which is not enabled. We
>> > > are
>> > > missing a check before we shut down iwlmei.
>> >=20
>> > Hm... no, that seems to be 11th generation... so TigerLake?
>> > But still, the fix below seems relevant.
>>=20
>> Hmm, tried the patch and the message is still there (as is the bug)...
>> The error code is different now, though:
>>=20
>> [=C2=A0=C2=A0 65.773731] wlan0: deauthenticating from 4c:60:de:ea:b8:5a =
by local choice (Reason:
>> 3=3DDEAUTH_LEAVING)
>> [=C2=A0=C2=A0 65.973767] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e7=
0cbb1e865: Couldn't get ACK from
>> CSME on HOST_GOES_DOWN message
>> [=C2=A0=C2=A0 65.973845] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e7=
0cbb1e865: failed to send the
>> SAP_ME_MSG_CHECK_SHARED_AREA message -14
>>=20
>
> So you do get a SAP connection. Weird.
> Checking with the CSME guys.
> Can you get dynamic debug prints for iwlmei module?
> Best would be tracing with -e iwlmei_sap_cmd

Sure! Recorded these while doing a suspend-restore, then restarting iwd:

  kworker/u16:34-34555 [004] 46452.506238: iwlmei_sap_cmd:       sap_cmd Tx=
: type 1010 len 8 seq 11
  kworker/u16:34-34555 [004] 46452.506243: iwlmei_me_msg:        ME message=
: Tx: type 3 seq 8
  kworker/u16:34-34555 [004] 46452.559407: iwlmei_sap_cmd:       sap_cmd Tx=
: type 1001 len 4 seq 12
  kworker/u16:14-33311 [004] 46452.573077: iwlmei_sap_cmd:       sap_cmd Tx=
: type 1006 len 0 seq 13
  kworker/u16:14-33311 [004] 46452.573078: iwlmei_me_msg:        ME message=
: Tx: type 3 seq 10
     kworker/4:0-34305 [004] 46452.706737: iwlmei_me_msg:        ME message=
: Tx: type 3 seq 11
   kworker/u16:8-34462 [000] 46457.939453: iwlmei_me_msg:        ME message=
: Tx: type 1 seq 1
     kworker/4:2-32196 [004] 46457.940910: iwlmei_me_msg:        ME message=
: Rx: type 2 seq 81
     kworker/4:2-32196 [004] 46457.940912: iwlmei_sap_cmd:       sap_cmd Tx=
: type 1013 len 0 seq 1
     kworker/4:2-32196 [004] 46457.940913: iwlmei_me_msg:        ME message=
: Tx: type 3 seq 2
     kworker/4:2-32196 [004] 46457.942056: iwlmei_me_msg:        ME message=
: Rx: type 3 seq 82
     kworker/4:2-32196 [004] 46457.942060: iwlmei_sap_cmd:       sap_cmd Rx=
: type 502 len 4 seq 1
     kworker/4:2-32196 [004] 46458.042205: iwlmei_me_msg:        ME message=
: Rx: type 3 seq 83
     kworker/4:2-32196 [004] 46458.042208: iwlmei_sap_cmd:       sap_cmd Rx=
: type 500 len 1896 seq 2
     kworker/4:2-32196 [004] 46458.042209: iwlmei_sap_cmd:       sap_cmd Rx=
: type 512 len 64 seq 3
     kworker/4:2-32196 [004] 46458.042214: iwlmei_sap_cmd:       sap_cmd Rx=
: type 502 len 4 seq 4
             iwd-35396 [003] 46467.085642: iwlmei_sap_cmd:       sap_cmd Tx=
: type 1008 len 8 seq 2
             iwd-35396 [003] 46467.085645: iwlmei_me_msg:        ME message=
: Tx: type 3 seq 3
             iwd-35396 [003] 46467.102818: iwlmei_sap_cmd:       sap_cmd Tx=
: type 1008 len 8 seq 3
             iwd-35396 [003] 46467.103369: iwlmei_sap_cmd:       sap_cmd Tx=
: type 1016 len 20 seq 4
             iwd-35396 [003] 46467.103842: iwlmei_sap_cmd:       sap_cmd Tx=
: type 1001 len 4 seq 5
             iwd-35396 [003] 46467.104689: iwlmei_sap_cmd:       sap_cmd Tx=
: type 1002 len 12 seq 6

The dmesg log looked like this (back to -19 in the error):

[46452.483343] wlan0: deauthenticating from 4c:60:de:ea:b8:5a by local choi=
ce (Reason: 3=3DDEAUTH_LEAVING)
[46452.689465] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: Co=
uldn't get ACK from CSME on HOST_GOES_DOWN message
[46452.689567] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: fa=
iled to send the SAP_ME_MSG_CHECK_SHARED_AREA message -19

> I might also need dynamic debgug prints from the mei bus driver but that =
will be for later.
> Thanks for reporting and providing the data!

You're welcome! Thanks for looking into it :)

-Toke
