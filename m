Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F7612D3F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfECMLP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 08:11:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54966 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfECMLP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 08:11:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8E10F60AA3; Fri,  3 May 2019 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556885474;
        bh=OvmHI6295HWtbHxfwxDMKKu6kKznje9lJ5vJvZBAKFE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eAn0R6AebrFea6rM+SjKFIV2Iyp/3axH3bLv+qIqnYiKflE639legWW5h4JyavNKw
         x7GsWZIbm4djJoWCY2cZ4iwhJNRTlTXR1Ak1w3RunAqBC2g8UfzK24eDKjzmPPx/zq
         dNmZ3UqLj+dsSKZTC+tQUeYs0ISLY9TUVxwEEguw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D82A60AA3;
        Fri,  3 May 2019 12:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556885474;
        bh=OvmHI6295HWtbHxfwxDMKKu6kKznje9lJ5vJvZBAKFE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=LN27O/ytMJR81D7gFneTlGNw3Za43Ik4XWR/jrK8TSu3xfLesQWbs05keYnoZ+i9E
         WhekF2pMh+BxzjPnlPMclf0VPSgJgQT6ydv30a4xE4FyMb+FzrlCJn/gNdnVQtK/xm
         oc7yHDgG7lq9VD/6PfEn/LV+WneOSyMqCOrXSN8g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D82A60AA3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/5] rtw88: add license for Makefile
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1556884415-23474-2-git-send-email-yhchuang@realtek.com>
References: <1556884415-23474-2-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190503121114.8E10F60AA3@smtp.codeaurora.org>
Date:   Fri,  3 May 2019 12:11:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Add missing license for Makefile
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

f9b628d61fae rtw88: add license for Makefile

-- 
https://patchwork.kernel.org/patch/10928421/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

