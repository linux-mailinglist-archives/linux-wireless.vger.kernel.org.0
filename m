Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0981C2C60FE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Nov 2020 09:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgK0IiS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Nov 2020 03:38:18 -0500
Received: from simonwunderlich.de ([79.140.42.25]:57574 "EHLO
        simonwunderlich.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgK0IiQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Nov 2020 03:38:16 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 03:38:15 EST
Received: from p200300c59712a4a002d861fffeb7ca5c.dip0.t-ipconnect.de (p200300c59712a4a002d861fffeb7ca5c.dip0.t-ipconnect.de [IPv6:2003:c5:9712:a4a0:2d8:61ff:feb7:ca5c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by simonwunderlich.de (Postfix) with ESMTPSA id 2D9F317405F;
        Fri, 27 Nov 2020 09:31:09 +0100 (CET)
Message-ID: <813524690ec0565bfcb76fd6047c0a89c4af6d30.camel@simonwunderlich.de>
Subject: Re: AX210 version 0024 not detected by iwlwifi
From:   Jan Fuchs <jf@simonwunderlich.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 27 Nov 2020 09:31:08 +0100
In-Reply-To: <03e8284e-4ea8-fe3e-8da7-62a778b1a059@gmail.com>
References: <03e8284e-4ea8-fe3e-8da7-62a778b1a059@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey Heiner,

thanks for that, got mine working with your patch too.
By the way, a newer firmware (iwlwifi-ty-a0-gf-a0-60.ucode) blob can be
found here [0]. Though I do still have an issue, that the module is
connecting with VHT-only to my Wifi6 access point on 5 GHz.

@Intel guys: Wifi6E channels are still not available for usage
according to the iw output [1], right?

Kind regards, Jan


[0] 
https://chromium.googlesource.com/chromiumos/third_party/linux-firmware/+/master/
[1] https://pastebin.com/Z7WQc6ny

Am Sonntag, den 22.11.2020, 22:35 +0100 schrieb Heiner Kallweit:
> I have an AX210 card that isn't detected by iwlwifi.
> 
> 01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
>         Subsystem: Intel Corporation Device 0024
> 
> Adding following entry seems to be sufficient.
> 
>         {IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0)},
> +       {IWL_PCI_DEVICE(0x2725, 0x0024, iwlax210_2ax_cfg_ty_gf_a0)},
>         {IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},
> 
> [  419.473140] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
> [  419.486984] iwlwifi 0000:01:00.0: api flags index 2 larger than
> supported by driver
> [  419.487190] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> Version: 93.8.63.28
> [  419.488828] iwlwifi 0000:01:00.0: loaded firmware version
> 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
> [  419.533136] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210
> 160MHz, REV=0x420
> 
> Maybe there are more AX210 subversion id's to be added ..
> 
> How about the api flags index warning? I saw it in several posts,
> is there something to be fixed in the driver?

