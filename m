Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62AC4375E7
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 13:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhJVLWo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 07:22:44 -0400
Received: from static-109-72-52-77.cpe.sn.co.rs ([109.72.52.77]:52142 "EHLO
        fx.arvanta.net" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232539AbhJVLWo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 07:22:44 -0400
X-Greylist: delayed 1785 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2021 07:22:43 EDT
Received: from elm.arvanta.net (arya.arvanta.net [10.5.1.6])
        by fx.arvanta.net (Postfix) with ESMTP id 8492C250F9;
        Fri, 22 Oct 2021 12:50:39 +0200 (CEST)
Date:   Fri, 22 Oct 2021 12:50:39 +0200
From:   Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Subject: [BUG] mwifiex sdio wifi crashes on samsung peach pi chromebook
Message-ID: <YXKXf1cBjPWqD1Aw@elm.arvanta.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

[ sorry if I send this to wrong address but you are listed as
  maintainers for MARVELL MWIFIEX WIRELESS DRIVER ]

On my chromebook samsung peach pi (exynos-5800) wifi driver stops to
work at random time, sometimes after few hours and sometimes after day
or two.

dmesg shows this (and repeating till reboot):
----------------------------------------------
[ 3718.465572] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (1) failed: -110
[ 3718.465925] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (2) failed: -110
[ 3718.466262] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (3) failed: -110
[ 3718.466340] mwifiex_sdio mmc1:0001:1: mwifiex_write_data_async failed: 0xFFFFFFFF
[ 3718.916823] mwifiex_sdio mmc1:0001:1: read mp_regs failed
[ 3718.917338] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (1) failed: -110
[ 3718.917522] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (2) failed: -110
[ 3718.917689] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (3) failed: -110
[ 3718.917804] mwifiex_sdio mmc1:0001:1: mwifiex_write_data_async failed: 0xFFFFFFFF
[ 3718.918096] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (1) failed: -110
[ 3718.918371] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (2) failed: -110
[ 3718.918501] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (3) failed: -110
[ 3718.918546] mwifiex_sdio mmc1:0001:1: mwifiex_11n_aggregate_pkt: host_to_card failed: 0xffffffff
[ 3719.245817] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (1) failed: -110
[ 3719.246101] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (2) failed: -110
[ 3719.246381] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (3) failed: -110
[ 3719.246449] mwifiex_sdio mmc1:0001:1: mwifiex_write_data_async failed: 0xFFFFFFFF
[ 3719.437566] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (1) failed: -110
[ 3719.437842] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (2) failed: -110
[ 3719.438119] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (3) failed: -110
[ 3719.438184] mwifiex_sdio mmc1:0001:1: mwifiex_write_data_async failed: 0xFFFFFFFF
[ 3719.935954] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (1) failed: -110
[ 3719.936173] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (2) failed: -110
[ 3719.936301] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (3) failed: -110
[ 3719.936348] mwifiex_sdio mmc1:0001:1: mwifiex_write_data_async failed: 0xFFFFFFFF
[ 3720.149548] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (1) failed: -110
[ 3720.149870] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (2) failed: -110
[ 3720.150212] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (3) failed: -110
[ 3720.150477] mwifiex_sdio mmc1:0001:1: mwifiex_write_data_async failed: 0xFFFFFFFF
[ 3720.269532] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (1) failed: -110
[ 3720.269754] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (2) failed: -110
[ 3720.269937] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (3) failed: -110
[ 3720.269988] mwifiex_sdio mmc1:0001:1: mwifiex_write_data_async failed: 0xFFFFFFFF
[ 3720.358851] mwifiex_sdio mmc1:0001:1: host_to_card, write iomem      (1) failed: -110
----------------------------------------------

kernel is mainline 5.14.4 without patches, but I recall that I noticed
this crashes on older ones but can't remember exact version.

I don't have idea how I could trigger this bug to appear because I din't
find anything related which could trigger it.

I'm ready to test patches if anyone made them but I don't have
experience in kernel drivers programming so can't make fix.

Thanks in advance
