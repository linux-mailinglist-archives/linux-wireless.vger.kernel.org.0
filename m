Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 747A06F291
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jul 2019 12:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfGUK0w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jul 2019 06:26:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfGUK0w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jul 2019 06:26:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E2CD0608A5; Sun, 21 Jul 2019 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563704810;
        bh=7RDOLUIE9KO0O7cBAwJ6NfKfJO3maV64i9i4jxGYZcs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QKxCkpXB1JVQdK6GyG/vAdLj1LFAQkvQ7o4kqxXVsolyWD9AVNJ2PfkZYZSmpYJJz
         67s7Kpwuk9yyF5+o7qxHlnyezyFtAW/tOAscPZD6QwXgc5ONY8bG9atiVSAZL+7GjB
         WFQ/AegL++eAqDkCZ7DeJxK4NRgmVs8ZwJ/wWWNU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6FFE60258;
        Sun, 21 Jul 2019 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563704809;
        bh=7RDOLUIE9KO0O7cBAwJ6NfKfJO3maV64i9i4jxGYZcs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aV1jM+urDLjxjQVxzvryRe3UyGH4ipT0NPyOYuvLpmFqzcwBLZFUNDRD3gBcbBq5l
         0OWxJ695ad4UjEsd8XmY6dFMTpfm2exBfye05MFzbmdbeywCUS7ZbE3dsOsN39IbPe
         chVSwtGHSQGUW27TjifxNQhBmwWne7XMNv9qMI1o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6FFE60258
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mt76: fix checkpatch warnings and errors
References: <50d28c9b0f9e7d6b277d36fc93f55142d7535259.1563518381.git.ryder.lee@mediatek.com>
Date:   Sun, 21 Jul 2019 13:26:45 +0300
In-Reply-To: <50d28c9b0f9e7d6b277d36fc93f55142d7535259.1563518381.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Fri, 19 Jul 2019 14:55:34 +0800")
Message-ID: <87blxnsmxm.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> Fix warnings and errors as much as possible.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/agg-rx.c   | 21 +++++----
>  drivers/net/wireless/mediatek/mt76/dma.c      |  2 +-
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 30 ++++++------
>  drivers/net/wireless/mediatek/mt76/mt76.h     | 46 +++++++++----------
>  .../wireless/mediatek/mt76/mt7603/beacon.c    |  2 +-
>  .../net/wireless/mediatek/mt76/mt7603/core.c  |  2 +-
>  .../wireless/mediatek/mt76/mt7603/debugfs.c   |  2 +-
>  .../net/wireless/mediatek/mt76/mt7603/dma.c   |  7 +--
>  .../wireless/mediatek/mt76/mt7603/eeprom.c    |  2 +-
>  .../net/wireless/mediatek/mt76/mt7603/init.c  |  3 +-
>  .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 +--
>  .../net/wireless/mediatek/mt76/mt7603/main.c  |  7 +--
>  .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  2 +-
>  .../net/wireless/mediatek/mt76/mt7603/pci.c   |  2 +-
>  .../net/wireless/mediatek/mt76/mt7603/soc.c   |  2 +-
>  .../wireless/mediatek/mt76/mt7615/debugfs.c   |  2 +-
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   |  5 +-
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 -
>  .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  2 +-
>  .../net/wireless/mediatek/mt76/mt76x0/phy.c   | 23 ++++++----
>  .../net/wireless/mediatek/mt76/mt76x0/phy.h   | 10 ++--
>  .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  6 +--
>  drivers/net/wireless/mediatek/mt76/mt76x02.h  | 24 +++++-----
>  .../wireless/mediatek/mt76/mt76x02_beacon.c   |  3 +-
>  .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 16 +++----
>  .../net/wireless/mediatek/mt76/mt76x02_mcu.c  | 13 +++---
>  .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 11 +++--
>  .../net/wireless/mediatek/mt76/mt76x02_phy.c  |  3 +-
>  .../net/wireless/mediatek/mt76/mt76x02_regs.h | 18 ++++----
>  .../wireless/mediatek/mt76/mt76x02_trace.h    |  3 +-
>  .../wireless/mediatek/mt76/mt76x02_usb_core.c |  2 +-
>  .../net/wireless/mediatek/mt76/mt76x02_util.c | 20 ++++----
>  .../wireless/mediatek/mt76/mt76x2/eeprom.c    | 10 ++--
>  .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  1 -
>  .../wireless/mediatek/mt76/mt76x2/pci_mcu.c   |  4 +-
>  .../net/wireless/mediatek/mt76/mt76x2/phy.c   |  3 +-
>  drivers/net/wireless/mediatek/mt76/trace.h    |  9 ++--
>  drivers/net/wireless/mediatek/mt76/tx.c       | 14 +++---
>  drivers/net/wireless/mediatek/mt76/usb.c      | 31 +++++++------
>  .../net/wireless/mediatek/mt76/usb_trace.h    | 11 +++--
>  drivers/net/wireless/mediatek/mt76/util.h     |  4 +-
>  41 files changed, 201 insertions(+), 185 deletions(-)

This is way too big and the commit log is too vague, please fix one
problem at a time and describe in the commit log what you fixed.

-- 
Kalle Valo
