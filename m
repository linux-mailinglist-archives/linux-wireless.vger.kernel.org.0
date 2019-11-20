Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0B103554
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 08:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfKTHmJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 02:42:09 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:57902
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfKTHmJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 02:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574235728;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=bb2gj2SOfwsX9izvgC7y3Qozbz88Q6l4mnvu2JrtoN0=;
        b=CRfNlEkw1g0ecNhmdIMbW3j+osy64cbc354qy3GfFfIYYR0hUIdRltIhaNj1aEqV
        cxT3pD3EBKDDU/FUC7hJ9HaBgkFpYi3545aJBMQ220Ugx+6bukJO0yw2+zN9eYRtUEh
        w+94hofj9zaar7vjdVlAmfnx62zrw34kj1HNSZNE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574235728;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=bb2gj2SOfwsX9izvgC7y3Qozbz88Q6l4mnvu2JrtoN0=;
        b=eyuetTc33JIf0zJ6sFA31xTtwXUg5cfE6AdvwRLIYdvl304+vD/7L4XTjI9EXBNg
        IHpaQQfjc0Bq2I4B/74UYJqFwB3WnpanbxVolRUk1m24vu5KK5BrtTpkMKlCsxodIDF
        UvKghDqLBNmo3gi9D4vDdBCzvvTaX5O4tph20UQY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71803C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtlwifi: rf_lock use non-irqsave spin_lock
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191118031455.3893-1-pkshih@realtek.com>
References: <20191118031455.3893-1-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <Larry.Finger@lwfinger.net>, <dev@lynxeye.de>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016e87c2eb31-77fc51ef-76f6-43fe-bbf4-ca1d18891a5f-000000@us-west-2.amazonses.com>
Date:   Wed, 20 Nov 2019 07:42:08 +0000
X-SES-Outgoing: 2019.11.20-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> rf_lock is used to protect RF register access, but they will not called
> from interrupt context, so *_irqsave version isn't necessary. Then, these
> delays don't affect IRQ services.
> 
> The old code holds spin_lock_irqsave() that will be detected a long delay
> as below:
> 
>   kworker/-276     4d...    0us : _raw_spin_lock_irqsave
>   kworker/-276     4d...    0us : rtl8723_phy_rf_serial_read <-rtl8723de_phy_set_rf_reg
>   kworker/-276     4d...    1us : rtl8723_phy_query_bb_reg <-rtl8723_phy_rf_serial_read
>   kworker/-276     4d...    3us : rtl8723_phy_set_bb_reg <-rtl8723_phy_rf_serial_read
>   kworker/-276     4d...    4us : __const_udelay <-rtl8723_phy_rf_serial_read
>   kworker/-276     4d...    4us!: delay_mwaitx <-rtl8723_phy_rf_serial_read
>   kworker/-276     4d... 1004us : rtl8723_phy_set_bb_reg <-rtl8723_phy_rf_serial_read
>   [...]
> 
> Reported-by: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-drivers-next.git, thanks.

92541dd9dda5 rtlwifi: rf_lock use non-irqsave spin_lock
4c8c0d8f709d rtlwifi: set proper udelay within rf_serial_read

-- 
https://patchwork.kernel.org/patch/11248815/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

