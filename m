Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EABD507B91
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 22:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357878AbiDSVBV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357877AbiDSVBU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 17:01:20 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067C04132B
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 13:58:36 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1650401914; bh=U7jyPX2bgK8CoLgco4Slp0FkOWoz7hA6BQLdJt+mxuM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=f823i2//pnVusrlcsGeM3U93XntNPyhsPhb89AcUe6hlsGxA4438aJ/TWq/6r817U
         mI+Bll1cMjh9XE2d3PZhcaGqt1PVDnQayzRA4uDcc/8+m0HE/Hm4zXtW7IT9pvLLRT
         f5ih77uxUjsJgVLhDJQ94DLSKByL9BudDyKdLAmAL9Rznwt1EasjkMYRVQIUTbvipi
         JXy6RSWbDcyYP0hk6c3+6LEWyQ8/ADD1yuOPcMF+ykta77dnYwEW/CAiZQePo6UjIP
         NZQpAS+SNFvsOKJ5RlSQWJj6B/TFxSs4tC1O1KxirUTH2pqf8VSQw+bic3Wc92KhW6
         QBUfuyHD8Yosw==
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
In-Reply-To: <94b98b712b86690dd5ae19df0cc608b8193be1f3.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
 <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
 <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
 <be3b424aec839d899e4a8cd659ebb53a85d67339.camel@intel.com>
 <87mtghs3y2.fsf@toke.dk>
 <e0872b6f468bfda08717214044b64187f71b4e18.camel@intel.com>
 <94b98b712b86690dd5ae19df0cc608b8193be1f3.camel@intel.com>
Date:   Tue, 19 Apr 2022 22:58:34 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877d7kn62t.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com> writes:

> On Tue, 2022-04-19 at 20:46 +0300, Grumbach, Emmanuel wrote:
>> On Tue, 2022-04-19 at 13:33 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> > "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com> writes:
>> >=20
>> > > On Tue, 2022-04-19 at 09:41 +0300, Grumbach, Emmanuel wrote:
>> > > > Hi Toke,
>> > > >=20
>> > > > On Tue, 2022-04-19 at 06:24 +0000, Coelho, Luciano wrote:
>> > > > > On Mon, 2022-04-18 at 13:36 +0200, Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
>> > > > > > Hi Luca
>> > > > >=20
>> > > > > Hi Toke,
>> > > > >=20
>> > > > > > I've started seeing issues with my iwlwifi interface going awa=
y after
>> > > > > > suspend. I get errors like these in dmesg:
>> > > > > >=20
>> > > > > > [104393.142264] wlan0: deauthenticating from 4c:60:de:ea:b8:58=
 by local choice (Reason:
>> > > > > > 3=3DDEAUTH_LEAVING)
>> > > > > > [104393.347775] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e=
70cbb1e865: Couldn't get
>> > > > > > ACK
>> > > > > > from
>> > > > > > CSME on HOST_GOES_DOWN message
>> > > > > > [104393.347876] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e=
70cbb1e865: failed to send
>> > > > > > the
>> > > > > > SAP_ME_MSG_CHECK_SHARED_AREA message -19
>> > > > > >=20
>> > > > > > And when the host comes back up, there is no connectivity. Res=
tarting
>> > > > > > iwd fixes the problem.
>> > > > > >=20
>> > > > > > This is on a 5.17.3 kernel (Arch Linux distribution kernel), a=
nd lspci
>> > > > > > says the WiFi device is an "Intel Corporation Wi-Fi 6 AX201".
>> > > > > >=20
>> > > > > > Any ideas? :)
>> > > > >=20
>> > > > > This seems to be related to iwlmei, so I added Emmanuel to the t=
hread.
>> > > > >=20
>> > > >=20
>> > > > Can we have the full dmesg output?
>> > > > What NIC / platform do you have?
>> > > > Do you have AMT configured in the BIOS?
>> > > > Did you enable wireless operation in AMT?
>> > >=20
>> > > Ah - this is AX201, ok, but I still need the platform and thefull dm=
esg :-)
>> >=20
>> > It's a Lenovo ThinkPad X1 Carbon Gen 9, model 20XXS3HC26; AMT is set to
>> > "Disabled" in the BIOS. I rebooted and did a suspend/wake cycle after
>> > connecting to the WiFi network, which produced the dmesg below.
>>=20
>> Thanks.
>> This is a Skylake platform and we didn't have a handshake with CSME whic=
h is not enabled. We are
>> missing a check before we shut down iwlmei.
>
> Hm... no, that seems to be 11th generation... so TigerLake?
> But still, the fix below seems relevant.

Hmm, tried the patch and the message is still there (as is the bug)...
The error code is different now, though:

[   65.773731] wlan0: deauthenticating from 4c:60:de:ea:b8:5a by local choi=
ce (Reason: 3=3DDEAUTH_LEAVING)
[   65.973767] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: Co=
uldn't get ACK from CSME on HOST_GOES_DOWN message
[   65.973845] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: fa=
iled to send the SAP_ME_MSG_CHECK_SHARED_AREA message -14

-Toke
