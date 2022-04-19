Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96A65069E2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 13:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351054AbiDSLXa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351195AbiDSLXW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 07:23:22 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ED3BF50
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 04:19:55 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1650367193; bh=ImV75DspqBzTBIa7VCAWmmDstVhBl5XCg3+TW5i4o6U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BWFfCMW88ZaKWg29GYeb35tS+SK1N5O6vaMgfKSEVC+VTaIkPmVDcGP6dUG9xHhH8
         Ap8yuOFJ3bOECQQK66Rimpa3uWI+6xKY+hhn22QXRiibZgCFoufYA6v+XdPVKFsq8d
         ptLMU8B3H8Pem0B8gGOR6H5AZrodmMUxcVCcsgfUAGHNoDrFdt6nSmsQBoE6Xpyn7+
         tYKyX2MQtbe99bqmcQWMSZxxOu9GKxu9OKd8nxFWs9E+4ChenpMK4GdcJg8ActX6MY
         ghm3dBYeq2l4iOZ0LyFPcuoXavvcuaiBbmGUg2+TVrjOlr/CuiguNyfBqIfXuyyLFX
         xqmepjjsqCXng==
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
In-Reply-To: <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
 <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
Date:   Tue, 19 Apr 2022 13:19:53 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871qxt2ucm.fsf@toke.dk>
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

"Coelho, Luciano" <luciano.coelho@intel.com> writes:

> On Mon, 2022-04-18 at 13:36 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hi Luca
>
> Hi Toke,
>
>> I've started seeing issues with my iwlwifi interface going away after
>> suspend. I get errors like these in dmesg:
>>=20
>> [104393.142264] wlan0: deauthenticating from 4c:60:de:ea:b8:58 by local =
choice (Reason: 3=3DDEAUTH_LEAVING)
>> [104393.347775] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865=
: Couldn't get ACK from CSME on HOST_GOES_DOWN message
>> [104393.347876] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865=
: failed to send the SAP_ME_MSG_CHECK_SHARED_AREA message -19
>>=20
>> And when the host comes back up, there is no connectivity. Restarting
>> iwd fixes the problem.
>>=20
>> This is on a 5.17.3 kernel (Arch Linux distribution kernel), and lspci
>> says the WiFi device is an "Intel Corporation Wi-Fi 6 AX201".
>>=20
>> Any ideas? :)
>
> This seems to be related to iwlmei, so I added Emmanuel to the thread.
>
> Additionally, I'm not working with Intel's WiFi any more, so I also
> CCed Gregory, who is the new iwlwifi maintainer.

Thanks for the forward! How about updating MAINTAINERS to reflect this? :)

-Toke
