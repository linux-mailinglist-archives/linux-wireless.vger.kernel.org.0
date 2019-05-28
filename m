Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D433A2C569
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 13:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfE1LaY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 07:30:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45838 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfE1LaY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 07:30:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 076016077A; Tue, 28 May 2019 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559043024;
        bh=QQFHc7KHGT1XlP39+/THNeGXGy/8ShnovAPHytS2qgQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=X2i9qTl5tSvcr0hOq975DFNXJwYiet/j+KX9g+vGU8h4q+J1hCsf3CSzTVVtrlIgB
         WzHvVm+5QWk+rg/rGKU2zjAkxXOYF7F7joJI0+5V2quBwbNIOIgaL2mPZOBYB0Ppq2
         e1vQa0GpCR7uHQpHZWZhyqOEf9Qo0NG6Kc7oVR/g=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1AE1560312;
        Tue, 28 May 2019 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559043023;
        bh=QQFHc7KHGT1XlP39+/THNeGXGy/8ShnovAPHytS2qgQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=FQCIgX9O+L+4cy96JtwAefRUeCJCPaPzqJ2VspWzA7s8n2Dr6inhkgJUyZFTQUHTu
         xonJwTR19Qg//tYhjYli6A6U1FGJtJ9WwxYnd2ZRhXYJzVHkiHuRFGq0CYwjMsvwCy
         ZClPoafBo08NvZV/LmDRvgOEywQ4QuRXMPmbqa5k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AE1560312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.2 v3] rtw88: fix unassigned rssi_level in rtw_sta_info
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1557196098-1479-1-git-send-email-yhchuang@realtek.com>
References: <1557196098-1479-1-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190528113024.076016077A@smtp.codeaurora.org>
Date:   Tue, 28 May 2019 11:30:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> The new rssi_level should be stored in si, otherwise the rssi_level will
> never be updated and get a wrong RA mask, which is calculated by the
> rssi level
> 
> If a wrong RA mask is chosen, the firmware will pick some *bad rates*.
> The most hurtful scene will be in *noisy environment*, such as office or
> public area with many APs and users.
> The latency would be high and the overall throughput would be only half
> or less.
> 
> Tested in 2.4G in office area, with this patch the throughput increased
> from such as "1x Mbps -> 4x Mbps".
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers.git, thanks.

a24bad74737f rtw88: fix unassigned rssi_level in rtw_sta_info

-- 
https://patchwork.kernel.org/patch/10932181/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

