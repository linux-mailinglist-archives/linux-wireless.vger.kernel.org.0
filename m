Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6473E333928
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 10:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhCJJrV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 04:47:21 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:32644 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhCJJrA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 04:47:00 -0500
Date:   Wed, 10 Mar 2021 09:46:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tmb.nu;
        s=protonmail; t=1615369618;
        bh=K+MyyLi02nS70sb/VfE6cm+jlc0QL64Rwqi3/t79rl8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=C0NCuDMlErjweojlsXVDfkcD0oQaXL60FYfqPOA7NkKARhOwaX2gDH9aD13RDO2cz
         cExHUddzKdfwqE73R4NMLkCdHVwd+SjcS4tLpczZvSsCST7YzDNJipofqiGyyucamB
         9A1m/cPfc+BMqKMJAbdsunHtDQAem7wGN0yIyvys=
To:     Luca Coelho <luca@coelho.fi>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
From:   Thomas Backlund <tmb@tmb.nu>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Reply-To: Thomas Backlund <tmb@tmb.nu>
Subject: Re: pull request: iwlwifi firmware updates 2021-03-05-v2
Message-ID: <dc668115-049c-0bbc-b25e-917ccf1bbdee@tmb.nu>
In-Reply-To: <42eb781e8f89b92ff54a4d65b0916d420eb2a381.camel@coelho.fi>
References: <8e3877efc92f413d47ee1d71a119885c765d7312.camel@coelho.fi> <69d01bfd-a15f-2ebb-b55a-c6864a065e1f@tmb.nu> <42eb781e8f89b92ff54a4d65b0916d420eb2a381.camel@coelho.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Den 10.3.2021 kl. 11:26, skrev Luca Coelho:
> Your email was in HTML, so it probably didn't reach the list.


Oops. sorry about that...

seems thunderbird decides on its own sometimes to swich it around...
evern if I have default to text...


> On Wed, 2021-03-10 at 09:09 +0000, Thomas Backlund wrote:
>> More=C2=A0 "issues"...
>>
>> Den 9.3.2021 kl. 13:57, skrev Luca Coelho:
>> Hi,
>>
>> This is v2 of my update which contains some new and updated files for
>> all our currently maintained FW binaries.
>>
>> In v2:
>>
>>  =C2=A0=C2=A0=C2=A0* Fixed WHENCE so that the new files match, with "62"=
 instead of
>>  =C2=A0=C2=A0=C2=A0"59".
>>
>> Please pull or let me know if there are any issues.
>>
>> --
>> Cheers,
>> Luca.
>>
>>
>> The following changes since commit
>> 5ecd13ffe8e24385cf4f30f3d0dcaff4dfb24de2:
>>
>>  =C2=A0=C2=A0Mellanox: Add new mlxsw_spectrum firmware xx.2008.2406 (202=
1-03-03
>> 13:23:49 -0500)
>>
>> are available in the Git repository at:
>>
>>  =C2=A0=C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwi=
fi-
>> firmware.git iwlwifi-fw-2021-03-05-v2
>>
>> for you to fetch changes up to
>> b46d336044c448987589bd6cf3057f404c5581ad:
>>
>>  =C2=A0=C2=A0iwlwifi: add new FWs from core59-66 release (2021-03-09 13:=
51:26
>> +0200)
>>
>> ----------------------------------------------------------------
>> Update iwlwifi firmwares to Core59-66
>>
>> ----------------------------------------------------------------
>> Luca Coelho (3):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iwlwifi: update 7265D firmware
>>
>> This one looks old... stuck in limbo for over 1.5 years... is that
>> correct ?
>> author=C2=A0=C2=A0=C2=A0 Luca Coelho <luciano.coelho@intel.com>=C2=A0=
=C2=A0=C2=A0 2019-08-23
>> 07:35:14 +0300
>>  =C2=A0committer=C2=A0=C2=A0=C2=A0 Luca Coelho <luciano.coelho@intel.com=
>=C2=A0=C2=A0=C2=A0 2021-03-05
>> 11:37:56 +0200
> Oh, I just reused the commit message from before and edited it as
> needed.  Does it really matter?


I guess not..

it was more a "is it acctually a correct commit " as it looked weird
when being so old...

considering the last update to the same firmware happend on 2020-10-14



>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iwlwifi: update 9000-family firmwar=
es
>>
>> This one adds duplicated fileinfo in WHENCE
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it/commit/?id=3Da6720504c812c1e8b0979a81d15b6ce6b4d87ae7
>> instead of updating existing ones.
> Okay, I'll fix it.
>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iwlwifi: add new FWs from core59-66=
 release
>>
>> This one still adds some duplicated WHENCE stuff for=C2=A0 *-59.ucode:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it/commit/?id=3Db46d336044c448987589bd6cf3057f404c5581ad
>>
>> +File: iwlwifi-cc-a0-59.ucode
>> +Version: 59.49eeb572.0
>> +
>> +File: iwlwifi-Qu-b0-hr-b0-59.ucode
>> +Version: 59.49eeb572.0
> Yep, copy/paste issue again, I'll fix it.
>
> --
> Luca.


--

Thomas



