Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F508D89CE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2019 09:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbfJPHfw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 03:35:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35834 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfJPHfw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 03:35:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B65960D74; Wed, 16 Oct 2019 07:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571211351;
        bh=TCkkE7HZcgQa8TEgwxI66v9F0vZK3Am/I5+x9gKIvHs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nUtWlb5M0U3xjpGLsHWfv42zKp8StYj1JxMpGlftLp02epobIpzFwOCQOABhAMZVB
         GY75oyw0CNFOzxcYCn8n2OgvVy0elzAGF/6HS77tN+UKkVfmI3KyzbTHm1WTqQdSaz
         2A5pQ2mLw1ruaLuwaPjP6raalgNCjDTjP+ZTNjx4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7824F60D74;
        Wed, 16 Oct 2019 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571211349;
        bh=TCkkE7HZcgQa8TEgwxI66v9F0vZK3Am/I5+x9gKIvHs=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=itnAR6V66YUUp1uh6UUc96DBWcjMtIc9YprFICCauySxy2QA43qoHZhPkV0CLDWql
         jsOJY/oNOIrmJQaXSr3IiBuGZYtOCndkBrL5ZS6HSNjJ2IdM6+6IssrHAlf2dZ5UXx
         DQk8LdxSQ7NzPD3zPUvuv9gUNkRvBqzOyO0Kla6Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7824F60D74
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: mark rtw_fw_hdr __packed
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191014212648.122549-1-briannorris@chromium.org>
References: <20191014212648.122549-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191016073551.6B65960D74@smtp.codeaurora.org>
Date:   Wed, 16 Oct 2019 07:35:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> The use of u8 and __le16 in this struct assumes that it's going to be
> packed to byte alignment. C doesn't guarantee that, so we should mark
> this __packed.
> 
> Fixes: cc20a7139836 ("rtw88: use struct rtw_fw_hdr to access firmware header")
> Cc: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

89dca86d29b4 rtw88: mark rtw_fw_hdr __packed

-- 
https://patchwork.kernel.org/patch/11189429/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

