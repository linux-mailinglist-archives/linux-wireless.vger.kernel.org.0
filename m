Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE631B47A2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404313AbfIQGoO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 02:44:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfIQGoN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 02:44:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E237C61577; Tue, 17 Sep 2019 06:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568702652;
        bh=XOGjgZr+LKfe7TJSeX81ayFXlkoRYJg8kD9pa3v0y0o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hHjwk3DykCmXNhPPM/jZWBftN5aNOMZ6SRxV7iUI1/zojpoJEk20owyBxMfZCFSle
         U58s7w/U/aPUHcE7DEtrWa5SYyUCCBOVJWlcMFZ1TfdNf2/YSMtI9oKwjrYWJvqA6V
         kiFBKfP3Y4w05Svq6MWTrBhQyqS92KhlfUgaJrf8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0609611DC;
        Tue, 17 Sep 2019 06:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568702652;
        bh=XOGjgZr+LKfe7TJSeX81ayFXlkoRYJg8kD9pa3v0y0o=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=FfMsWvpo4s9+BpSAs2QkflnUgXyJmp+LDKNBSEkUV+EtqwU5q11C9BHQyL7ITNrQh
         fmYJ4MURt6sxG21zgR6JF0GprOAXMh3WZqw+g+bsds2jYpdlEZ3UQMpV21NSF208ni
         2ly+oDmMJxNea5yF5iy8IoHNIahF0GBPbZeFa4UQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A0609611DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: restore QCA9880-AR1A (v1) detection
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190906215423.23589-1-chunkeey@gmail.com>
References: <20190906215423.23589-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190917064412.E237C61577@smtp.codeaurora.org>
Date:   Tue, 17 Sep 2019 06:44:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch restores the old behavior that read
> the chip_id on the QCA988x before resetting the
> chip. This needs to be done in this order since
> the unsupported QCA988x AR1A chips fall off the
> bus when resetted. Otherwise the next MMIO Op
> after the reset causes a BUS ERROR and panic.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a7fecb766c8 ("ath10k: reset chip before reading chip_id in probe")
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

I'll drop this as there's no plan to support QCA988X hw1.0.

-- 
https://patchwork.kernel.org/patch/11136089/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

