Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF656367B3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 18:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiKWRyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 12:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiKWRyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 12:54:14 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED11E64A2C;
        Wed, 23 Nov 2022 09:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669226051; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1O/qeaT6DVSGwZFjj+0GGqQHqMGAQ6aVICj9N+I6Cg=;
        b=Qnm9cqwIvObrA3v4tAAwNgmzQbzkZzabJqwXqmDpJFvOAzwd2O/CdZThHBItyqSpSZjve/
        J1QiEi1pM1bowLIAfqvBUibaGk1tdapCYUMc38UtlQwCF9hlQgHYV60KaNpV1m/ralLTR3
        KErJ9EQaa9STUoYl5kypSx8yM4Dsu6o=
Date:   Wed, 23 Nov 2022 17:54:00 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Please bump brcm/bcm4330-sdio.bin firmware
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-mips@vger.kernel.org,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <02BTLR.2900VTVOISJZ@crapouillou.net>
In-Reply-To: <fa5b46e2-f13e-547e-8df9-70c65f191957@broadcom.com>
References: <L70QLR.XAGB8X2431341@crapouillou.net>
        <fa5b46e2-f13e-547e-8df9-70c65f191957@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

Le mar. 22 nov. 2022 =E0 20:35:41 +0100, Arend van Spriel=20
<arend.vanspriel@broadcom.com> a =E9crit :
> On 11/22/2022 12:06 AM, Paul Cercueil wrote:
>> Hello,
>>=20
>> As a week-end project I got the BCM4330 chip to work with the=20
>> mainline =7FLinux kernel on the MIPS CI20 board. One of the problems I=20
>> was facing =7Fwas the firmware crashing, resulting in timeout errors=20
>> in the brcmfmac =7Fdriver.
>>=20
>> It turns out the bcm4330-sdio.bin firmware that's currently in=20
>> =7Flinux-firmware is not the latest one. Running "strings" on the blob=20
>> =7Fpoints out to a version 5.90.125.104 dated 2011-10-25. The firmware=20
>> that =7Foriginally came on the CI20 is version 5.90.195.26 dated=20
>> 2012-05-09, and =7Fthe version found in Android [1] is 5.90.195.114=20
>> dated 2013-01-23. Only =7Fthe last two will work on the CI20 board.
>>=20
>> My question then, could we bump the firmware available in=20
>> linux-firmware =7Fto the latest version? Or is there a valid reason=20
>> why an older firmware =7Fis kept in the tree?
>=20
> We "Broadcom" could. The linux-firmware repo provides all firmware=20
> that linux distro can freely redistribute. The license info is listed=20
> in the README in the repo as are the applicable firmware license=20
> documents. So releasing the firmware to linux-firmware under the=20
> given license can only be done by anyone owning it, not by people=20
> licensed to use it.

I actually did not know this.

> The bcm4330 chip was one of the first chips that brcmfmac supported=20
> and Broadcom has EOL-ed that chip a long time ago hence no newer=20
> firmware was considered for release to linux-firmware. In the past we=20
> often re-released what was available in Android so we probably can do=20
> that again for this and other chips.

This would be great.

Cheers,
-Paul


