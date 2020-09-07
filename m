Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3F25F53F
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 10:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgIGIax (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 04:30:53 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:48630
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbgIGIav (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 04:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599467450;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=GrBS3Bd6Lgg2mvDo/4wHTDrDQy2RgiYkbMxMX9JK3jw=;
        b=mVnTFH/jNhcIeJ8rAEUO1T2D9MmAFSqSyWX4XAzzkmNV9TRHrUsjYsUqFPBqSl8S
        /nFOrPDzc/fa5uojswOvQuND/KyfENCdS0b6o8nqlyC6Vwt59qUtwwPlw15E2TsrCD8
        JhgBkbjL+V1zZh8y4b8nUi78+S6oyOMlfbiL4YtM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599467450;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=GrBS3Bd6Lgg2mvDo/4wHTDrDQy2RgiYkbMxMX9JK3jw=;
        b=hgHozskAinyC7c5ieQ8fMmWg93ztyKWsqXrBcv/aHR1HXRsHCf3bIpjNWRieF703
        ijrZgEAFnjVVYkrpJjMNcpHnrrKT+4tslZYAw7DLVA1AbJEB6CGGOu/szjFc7Gyqut0
        E38LHBgbVEAPV9BnhZWAlEP7baIgXkIMBVsin/C4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FEFEC43385
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: fix compile warning: [-Wignored-qualifiers]
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200902053402.12839-1-yhchuang@realtek.com>
References: <20200902053402.12839-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <0101017467b06ff3-21adfbf6-c52d-4511-a9ab-84f06dea724f-000000@us-west-2.amazonses.com>
Date:   Mon, 7 Sep 2020 08:30:50 +0000
X-SES-Outgoing: 2020.09.07-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Tzu-En Huang <tehuang@realtek.com>
> 
> Remove function return type const in rtw8821c_get_swing_index().
> This is unused, and unnecessary to be const.
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/wireless/realtek/rtw88/rtw8821c.c:71:8: warning: type
> qualifiers ignored on function return type [-Wignored-qualifiers]
>        71 | static const u8 rtw8821c_get_swing_index(struct rtw_dev *rtwdev)
>           |        ^~~~~
> 
> Fixes: f745eb9ca5bf ("rtw88: 8821c: Add 8821CE to Kconfig and Makefile")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

8f8b8aa62e68 rtw88: fix compile warning: [-Wignored-qualifiers]

-- 
https://patchwork.kernel.org/patch/11749861/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

