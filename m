Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7216F1083D9
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2019 15:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKXOv2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Nov 2019 09:51:28 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:41114
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbfKXOv2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Nov 2019 09:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574607087;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=LFsucqZpUXxs5vCIzQJND0Z+/nHNJejcRZj8IwZAiOA=;
        b=fMyw55jBGJ3AOJlG7EWv+jxQOv+L3A2ZPHHhQr+2ZEeA4iWZbwpY7s8Qe0w/eC2j
        7EpQU+JOHd2zg40m/YpnoXRAH+xM/DlslQL7XoVSDqcGMYDyipggTzW7dWtEaWNVANs
        cWxuYtDZXPK525OEJnasFaYQghwpEkwxy4y2suxo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574607087;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=LFsucqZpUXxs5vCIzQJND0Z+/nHNJejcRZj8IwZAiOA=;
        b=b8g6CSAqEvvNvyIYcdJedGYvVX/uVKAJYTo5q+kkrN5uPbjbtgR6sOU4Qthlh1VD
        mAzMnglikY+4guI1qxCVJiVa9Ms+xIJFdZGz830AFTgNYi/fzB1/QPQ6+B0ebeukX/F
        erS6Zz7HjSMJPhRd4PvSiUc583c1A5ffQKBD+5lI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05FAAC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Mathias Kresin <dev@kresin.me>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] ath9k: use iowrite32 over __raw_writel
References: <20191124144059.985102-1-chunkeey@gmail.com>
Date:   Sun, 24 Nov 2019 14:51:27 +0000
In-Reply-To: <20191124144059.985102-1-chunkeey@gmail.com> (Christian
        Lamparter's message of "Sun, 24 Nov 2019 15:40:59 +0100")
Message-ID: <0101016e9de566b8-1f9bb6ea-6e63-4d1c-9b0f-50c5cbf38226-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.24-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> This patch changes the ath9k_pci_owl_loader to use the
> same iowrite32 memory accessor that ath9k_pci is using
> to communicate with the PCI(e) chip.
>
> This will fix endian issues that came up during testing
> with loaned AVM Fritz!Box 7360 (Lantiq MIPS SoCs + AR9287).
>
> Fixes: 5a4f2040fd07 ("ath9k: add loader for AR92XX (and older) pci(e)")
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

I'll queue this to v5.5.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
