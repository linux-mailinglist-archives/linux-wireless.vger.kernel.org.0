Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B987103577
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 08:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfKTHpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 02:45:19 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:39894
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727304AbfKTHpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 02:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574235918;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=grJYUde4lqXi5RMnMI6fWRIbzpgWK1HnS217ne/8Xp8=;
        b=om14ixHgxw9Oi/tVOVldwEbBIlkqHDRkb6Mqmvs3AWIwk3YKoFOCdPncXCkntlEl
        Ke5AjIB4m+dw4FkvhV3W7IBwLRBM/uHIdp1WGo0Mh/HzYCK9QMtwqURiIYjKHYq0dY0
        Tz8X9PKdoTjs2241DIaHIrikpfhJwyrHEg7bfmQ0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574235918;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=grJYUde4lqXi5RMnMI6fWRIbzpgWK1HnS217ne/8Xp8=;
        b=cUmJtNCtXlFrqC5f/n8Wb5n4AqlZ719BP+s7c6BzdQEANph2hy3Nbz+Buz/LmpNF
        Swuxp1AVMQjh3G9oVkZ2UrUufSKpz8s78MBJX2E6R5MTVxEaoulQpK0yQtWpe1WlLIb
        P631KkcBaDS5kd5cr5keWVdnIVOE8P7Ebg2HMme8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC6A3C4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] rtw88: pci: use macros to access PCI DBI/MDIO
 registers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191118095432.4507-2-yhchuang@realtek.com>
References: <20191118095432.4507-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016e87c5d058-f887a693-65d0-4aeb-8af7-5b2115e66b73-000000@us-west-2.amazonses.com>
Date:   Wed, 20 Nov 2019 07:45:18 +0000
X-SES-Outgoing: 2019.11.20-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Add some register and bit macros to access DBI/MDIO register. This
> should not change the logic.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

4 patches applied to wireless-drivers-next.git, thanks.

83a5a2d76f99 rtw88: pci: use macros to access PCI DBI/MDIO registers
ff3297f62fff rtw88: pci: use for loop instead of while loop for DBI/MDIO
d2e2c47e65af rtw88: pci: enable CLKREQ function if host supports it
3dff7c6e3749 rtw88: allows to enable/disable HCI link PS mechanism

-- 
https://patchwork.kernel.org/patch/11249239/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

