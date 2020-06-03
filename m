Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C877A1ECB65
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 10:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgFCIWu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 04:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCIWt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 04:22:49 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3225207DA;
        Wed,  3 Jun 2020 08:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591172569;
        bh=qqz0k20YWYbr0n3jYALym4hvMwlW9s5zcf4P/skeQgc=;
        h=From:To:Cc:Subject:Date:From;
        b=mg+jg4XBFFgU1M/lPSHPudz1xNoHKqCu6CUWQG/B0Apm0gEjA6uQcuM+0TJYyxnWF
         EMGZqY3v4knYjjuacx0wB6DCoij3s/LV40+OGMyhPx2cWCOrjpf/fs2KWwB64j9+yd
         5PF5DbDW1trNDn8IawD7y0JCOiCkcWY2D5NC7ZmQ=
Received: by pali.im (Postfix)
        id 6B38C6F0; Wed,  3 Jun 2020 10:22:46 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Hemantkumar Suthar <shemant@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Zhaoyang Liu <liuzy@marvell.com>, Cathy Luo <cluo@marvell.com>
Subject: [PATCH 0/4] marvell: Fix firmware filenames for sd8977/sd8997 chipsets
Date:   Wed,  3 Jun 2020 10:22:25 +0200
Message-Id: <20200603082229.15043-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series fixes mwifiex and btmrvl drivers to load firmware for sd8977
and sd8997 chipsets from correct filename.

Both Marvell distribution package and linux-firmware repository [1] contain
firmware for these chipsets in files sdsd8977_combo_v2.bin/sdsd8997_combo_v4.bin.

Linux drivers mwifiex and btmrvl try to load firmware for these chipsets from
sd8977_uapsta.bin/sd8997_uapsta.bin files which obviously fails as these files
do not exist neither in linux-firmware [1] nor in Marvell distribution packages.

So the result is that Marvell sd8977 and sd8997 chipsets via mainline kernel
drivers (mwifiex and btmrvl) do not work out of box.

Each patch in this series fixes particular git commit which introduced usage
of incorrect firmware filename. Also each patch contains Fixes: line for easier
backporting to stable kernels.

mwifiex (1/4, 2/4) and btmrvl (3/4, 4/4) parts of this patch series can be
applied separately via wireless and bluetooth trees. I'm sending all four
patches in one patch series for easier review.

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/mrvl

Pali Rohár (4):
  mwifiex: Fix firmware filename for sd8977 chipset
  mwifiex: Fix firmware filename for sd8997 chipset
  btmrvl: Fix firmware filename for sd8977 chipset
  btmrvl: Fix firmware filename for sd8997 chipset

 drivers/bluetooth/btmrvl_sdio.c             | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/sdio.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.20.1

