Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C1AA2CF
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 14:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfIEMQU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 08:16:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731378AbfIEMQU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 08:16:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E003561214; Thu,  5 Sep 2019 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567685779;
        bh=VPAdkjohvkbfjDgG001DLgbkEGB4YTFim9HhrivJr4o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZO7GiVU2/UaVRtck7NE0PoEF9t9Ulxf8Igv/oL2MHdIjDS8l+ZerBupKOLJEgh13J
         E2x68q8sT/xUkm0UlWmkX3bXAd7mG6IXs+XyiWzb2E9J8DGXGcMH/akm0coJXuTkp3
         uPrOohBB1k5Ayj3ahm3wEuC/CrIpVnC/E4N4HMiE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2171C60328;
        Thu,  5 Sep 2019 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567685777;
        bh=VPAdkjohvkbfjDgG001DLgbkEGB4YTFim9HhrivJr4o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Y+G1fPUMVbG7hKMUJY36TlYufgBKRws44RmyNmtHDW7p6WMGjajHfulBn6CzOk+FL
         2i+DyWU565K0vwDY8bdsQX+cqiyYJBtHT6yWRy/AFwlq1B/zaQZTs96HCMQu5ri07c
         g65GuYFlMcw6U1WhR4s7nsJBekh/nanf+gm2q2Dg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2171C60328
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Wen Gong <wgong@codeaurora.org>
Subject: Re: [PATCH v4 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
References: <1567416146-14403-1-git-send-email-wgong@codeaurora.org>
        <1567416146-14403-2-git-send-email-wgong@codeaurora.org>
        <CANMq1KANHhmP+yEj7Yw3P+akT+mM=y6rjfq1sEjg0NUuWJkdCw@mail.gmail.com>
Date:   Thu, 05 Sep 2019 15:16:13 +0300
In-Reply-To: <CANMq1KANHhmP+yEj7Yw3P+akT+mM=y6rjfq1sEjg0NUuWJkdCw@mail.gmail.com>
        (Nicolas Boichat's message of "Tue, 3 Sep 2019 16:02:09 +0800")
Message-ID: <87a7bjlz02.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nicolas Boichat <drinkcat@chromium.org> writes:

> Kalle: Can you please help prioritize the review and merge of this
> patch? This is quite a serious regression (the rest of the series is
> performance improvement and probably a little less urgent).

Ok, I'll prioritise this (but I have not reviewed it yet).

But in the future if there's something urgent, it's best to submit the
patch separately and label it with "[PATCH 5.3]" or something like that:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#tree_labels

This way I can find the patch faster.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
