Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3ED1C3238
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfJALSO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:18:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58166 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJALSO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:18:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2134D6083C; Tue,  1 Oct 2019 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569928693;
        bh=MPag75lsYtF0JbmFj0RgLbwaTpCm3c+JDYunHGgHzVg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=onG90TwfIZtnJClk+6pk1q5Kz8Mxt8XGBBi2n05f7pvr3zwpe0hkabsIPYzP2KxqT
         J7fHhY7dfJt6LzWxm7evDgLuuq+qjzSrhnxHC64rriUiLDqKN9PUFgA4FKNf+HSIQ2
         awq9DxUT873dIqGMzfJhLm8Kcvd3Lb2KJXfzWzuw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D5A8601D4;
        Tue,  1 Oct 2019 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569928692;
        bh=MPag75lsYtF0JbmFj0RgLbwaTpCm3c+JDYunHGgHzVg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=BGuCvkz9+mIkR2EH2xzW5lqfE7MRF5D1Trfpf1NyPk+BGqqp8CfQOg9MXvZy/lSPd
         LuEhyRN+e1m0zHUuU+PVtvlpKkjmN4ErWc1s9VVoJD66CaG/mA2sbM9zjDafg5WX4Y
         hcOGT9oNTMgMSUMEyjy+y3upQBNv4P5gO2spaiQs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D5A8601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath10k: fix IRAM addr in coredump
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1569505021-20515-1-git-send-email-akolli@codeaurora.org>
References: <1569505021-20515-1-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191001111813.2134D6083C@smtp.codeaurora.org>
Date:   Tue,  1 Oct 2019 11:18:13 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> The IRAM start address in coredump was wrong for QCA9984, QCA4019, QCA9888 and
> QCA99x0.
> 
> Tested on: QCA9984, QCA4019
> FW version: 10.4-3.9.0.2-00044
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

93f9fefcf528 ath10k: coredump: fix IRAM addr for QCA9984, QCA4019, QCA9888 and QCA99x0
d98ddae85a4a ath10k: fix backtrace on coredump

-- 
https://patchwork.kernel.org/patch/11162763/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

