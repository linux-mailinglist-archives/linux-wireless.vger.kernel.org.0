Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4760D10C4D6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfK1IT0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:19:26 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:53854
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbfK1IT0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929165;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=PgfWQsX14sdH7pnxhfurCbJxnb83qyTaeT/YMZp+Kog=;
        b=Nm+6H6stwQtVFhJ2viuSuEmEDILE81OgGWpeBo9+lF6zsV3seHAFf1qcW8diQdDQ
        6iCuvnotdzmJU6yl08+qeh80R43VMrtFdgALMjMnAL/Oa28YrDBIcm0ZYCgsRdb2bPD
        U6ZztASqk5N83OrxAtqAXXYE+SAiMpnbPD29rXZM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929165;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=PgfWQsX14sdH7pnxhfurCbJxnb83qyTaeT/YMZp+Kog=;
        b=WI0IDs4SA/Ol30mfU8ufyFa2LbWuz5IDamtehK1jbXSZYXTbbzP7msF4PGlDVPff
        ahTlyhotYw8hxKafH51GHOeM26rl9aWVTM79bz4dft7gSNnTSoK9nsa+VJcKr9qyEOG
        OGtklJvkoM6O0nD1UIO0DXemQUey0C8vHsa4btr0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C27DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: use iowrite32 over __raw_writel
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191124144059.985102-1-chunkeey@gmail.com>
References: <20191124144059.985102-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Mathias Kresin <dev@kresin.me>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016eb117ec9e-b3daa3f7-0f4a-4bba-b257-1249dbae6f07-000000@us-west-2.amazonses.com>
Date:   Thu, 28 Nov 2019 08:19:25 +0000
X-SES-Outgoing: 2019.11.28-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch changes the ath9k_pci_owl_loader to use the
> same iowrite32 memory accessor that ath9k_pci is using
> to communicate with the PCI(e) chip.
> 
> This will fix endian issues that came up during testing
> with loaned AVM Fritz!Box 7360 (Lantiq MIPS SoCs + AR9287).
> 
> Fixes: 5a4f2040fd07 ("ath9k: add loader for AR92XX (and older) pci(e)")
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Patch applied to wireless-drivers.git, thanks.

22d0d5ae7a08 ath9k: use iowrite32 over __raw_writel

-- 
https://patchwork.kernel.org/patch/11259213/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

