Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9C97191
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 07:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfHUF3q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 01:29:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37632 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727201AbfHUF3q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 01:29:46 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0JBo-0000Zs-FR; Wed, 21 Aug 2019 08:29:45 +0300
Message-ID: <ec9cd5cf1a351788ae0fa692ae4ac7b29c328b16.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Alexander Beregalov <a.beregalov@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 08:29:43 +0300
In-Reply-To: <CAA1sL1SoUWqQ7TRFnsPthHpPRhYjF6cnSh0tTY4nwO2O=FAGUQ@mail.gmail.com>
References: <CAA1sL1SoUWqQ7TRFnsPthHpPRhYjF6cnSh0tTY4nwO2O=FAGUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: iwlwifi 9000 issue with FW v46
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alex,

On Thu, 2019-08-01 at 16:30 -0400, Alexander Beregalov wrote:
> Hello,
> After some update WiFi stopped working, there is an error with FW 9000 ver46
> /lib/firmware/iwlwifi-9000-pu-b0-jf-b0-46.ucode
> 
> iwlwifi 0000:00:14.3: loaded firmware version 46.a41adfe7.0 op_mode iwlmvm
> iwlwifi 0000:00:14.3: Detected Intel(R) Dual Band Wireless AC 9560, REV=0x318
> iwlwifi 0000:00:14.3: Applying debug destination EXTERNAL_DRAM
> iwlwifi 0000:00:14.3: FW already configured (0) - re-configuring
> iwlwifi 0000:00:14.3: Microcode SW error detected. Restarting 0x0.
> iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
> iwlwifi 0000:00:14.3: Status: 0x00000100, count: 6
> iwlwifi 0000:00:14.3: Loaded firmware version: 46.a41adfe7.0
> ieee80211 phy0: Hardware restart was requested
> iwlwifi 0000:00:14.3: iwlwifi transaction failed, dumping registers
> iwlwifi 0000:00:14.3: iwlwifi device config registers:
> iwlwifi 0000:00:14.3: 00000000: 9df08086 00100406 02800030 00800010
> a121c004 00000000 00000000 00000000
> iwlwifi 0000:00:14.3: 00000020: 00000000 00000000 00000000 42348086
> 00000000 000000c8 00000000 000001ff
> iwlwifi 0000:00:14.3: iwlwifi device memory mapped registers:
> iwlwifi 0000:00:14.3: 00000000: 00c89008 00000040 00000000 00000000
> 00000000 00000000 00000000 00000000
> iwlwifi 0000:00:14.3: 00000020: 00000000 0c040005 00000312 d55555d5
> d55555d5 d55555d5 80008040 041f0040
> iwlwifi 0000:00:14.3: FW error in SYNC CMD GEO_TX_POWER_LIMIT
> 
> FW is provided by
> iwl7260-firmware-25.30.13.0-99.fc30.noarch
> 
> Kernel is 5.1.16-300.fc30.x86_64
> Full dmesg is attached
> 
> ver43 does work
> 
> iwlwifi 0000:00:14.3: Direct firmware load for
> iwlwifi-9000-pu-b0-jf-b0-46.ucode failed with error -2
> iwlwifi 0000:00:14.3: Direct firmware load for
> iwlwifi-9000-pu-b0-jf-b0-45.ucode failed with error -2
> iwlwifi 0000:00:14.3: Direct firmware load for
> iwlwifi-9000-pu-b0-jf-b0-44.ucode failed with error -2
> iwlwifi 0000:00:14.3: loaded firmware version 43.95eb4e97.0 op_mode iwlmvm
> iwlwifi 0000:00:14.3: Detected Intel(R) Dual Band Wireless AC 9560, REV=0x318
> iwlwifi 0000:00:14.3: base HW address: a8:6d:aa:5e:59:ed
> ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
> thermal thermal_zone8: failed to read out thermal zone (-61)
> iwlwifi 0000:00:14.3 wlo1: renamed from wlan0
> wlo1: authenticate with 70:b3:17:4a:cc:ce
> wlo1: send auth to 70:b3:17:4a:cc:ce (try 1/3)
> wlo1: authenticated
> 
> I also tried iwlwifi-9000-pu-b0-jf-b0-46.ucode from git
> (git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git)
> with the same result, however images are different:
> FC30: size 1460788, md5 43103f10a8f8657db3f5791f5d0e82aa
> git: size 1467952, md5 b0158bcaded550a01f9c446bb7940a9e

This problem was solved with the following patch:

https://patchwork.kernel.org/patch/11021735/

I have sent it to stable v5.2 and Greg queued it for the next stable
release.  Not that v5.1 has reached EOL, so it will probably never get
the fix.

--
Cheers,
Luca.

