Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E822D1D4F30
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2020 15:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgEONX4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 May 2020 09:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgEONX4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 May 2020 09:23:56 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8D12065F;
        Fri, 15 May 2020 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589549036;
        bh=/0i5GAiE3iEWTH++PER3m05MtECmVly6M7AdsDkEHyA=;
        h=Date:From:To:Subject:From;
        b=eUxA01FL7MpcaT18FllxBXLQi5y9mqy236JTywcAJTO8U50scr1ovwBvhXnf5rcCd
         NmB3ZYqF9blLrTuUnzPPACskQWp11Dk+8WHs4VphSMi/paxMa0PyXFdS6S425XRUnm
         evmmrflY204CAYpsmKTxynPd9YZaGxIGAYTLKk2U=
Received: by pali.im (Postfix)
        id BF6F15F0; Fri, 15 May 2020 15:23:53 +0200 (CEST)
Date:   Fri, 15 May 2020 15:23:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: mwifiex: Firmware name for W8997 sdio wifi chip
Message-ID: <20200515132353.vfor7v4buzoddfmb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

There is inconsistency in firmware naming for W8997 SDIO wifi chip.

Firmware for this chip is stored in linux-firmware [1] repository under
filename sdsd8997_combo_v4.bin.

But mainline linux kernel driver mwifiex_sdio.ko [2] expects and loads
firmware for this chip from filename sd8997_uapsta.bin.

So result is that W8997 SDIO wifi chip does not work out of box and
people are complaining where to get "sd8997_uapsta.bin" firmware file as
it does not exist [3]. People suggest to rename it.

Do you have any opinion how to solve this problem?

As Marvell is using sdsd8997_combo_v4.bin name for this firmware I would
suggest to extend mwifiex_sdio.ko Linux driver to load this firmware
also from the file sdsd8997_combo_v4.bin.

Also firmware file sdsd8997_combo_v4.bin in linux-firmware git
repository [1] is in version 16.68.1.p179. But there is already newer
version available (e.g. 16.68.1.p197) . Are you able to update firmware
for W8997 SDIO chip in linux-firmware repository to the lasted version?

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/mrvl
[2] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/marvell/mwifiex/sdio.h?h=v5.6#n41
[3] - https://raspberrypi.stackexchange.com/q/93478
