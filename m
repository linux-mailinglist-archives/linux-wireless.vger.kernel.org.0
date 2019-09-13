Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 143F6B2324
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390721AbfIMPO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 11:14:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390291AbfIMPO0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 11:14:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C24A3602C3; Fri, 13 Sep 2019 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568387665;
        bh=sINtqO5YlyMmoPSNWm7vgZpGdRo18mhvcRWepSlC+jQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mmTMdX5EJxDpDRKAeqTgovmXuMsWPqZT8co8kWxwP/cU0qadeqHuHqGyGC8iomgPu
         2lQBc9RfypIMYjQXqMwWUZtZ8PEnjk1b46Yt/lyem8D5WxlnRseyPRlG55O28mz4u4
         GgPDTQBzUu0SkT0R0TQpY/0V+DnIb+PYffbL9kGw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 735F5602C3;
        Fri, 13 Sep 2019 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568387665;
        bh=sINtqO5YlyMmoPSNWm7vgZpGdRo18mhvcRWepSlC+jQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=CYkcMwyHFDZsfFX4IQPH4WfsgkT3HtVGJmsu6zp0uXK8gePGqe7sfQxHAgfoNdTVW
         VYRfUkWyABXddY6aDZNHq/9y5V//WYp8zlM/qjLISmLwOpujUevtTCOzwP5buH7x12
         Z2V58LTUixnxyX3YcZmGwUKzWQIwOV10BEYgDoS4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 735F5602C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw88: fix wrong rx power calculation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1568270355-29727-2-git-send-email-yhchuang@realtek.com>
References: <1568270355-29727-2-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190913151425.C24A3602C3@smtp.codeaurora.org>
Date:   Fri, 13 Sep 2019 15:14:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Tsang-Shian Lin <thlin@realtek.com>
> 
> Fix the wrong RF path for CCK rx power calculation.
> 
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Chris Chiu <chiu@endlessm.com>

2 patches applied to wireless-drivers-next.git, thanks.

e9afa2dc4090 rtw88: fix wrong rx power calculation
98ab76ef6b6d rtw88: report RX power for each antenna

-- 
https://patchwork.kernel.org/patch/11142397/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

