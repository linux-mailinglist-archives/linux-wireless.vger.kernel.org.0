Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C987E2A14
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 07:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407022AbfJXFqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 01:46:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406898AbfJXFqx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 01:46:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A67860DBC; Thu, 24 Oct 2019 05:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571896013;
        bh=0GkOS8cG3Vs9AvvgJ8VECet2YEd1/rQLcTS72m0fg8c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=el52M3uFAFocYGInNQHz5vdtqmslYrkSUR/T2lPGwcGfm50/caOzOvg4ouxNYZTdB
         HI/6gUDUdOxZj0uYvUaZgXTIFJWC6SYpsbgknZoEDxXNeBmiRRIdZtkQx0Z/5X22/f
         LyPYrwT4Z06o4ZKe25ELxtj51UHMR8wk8SHVdHRs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA0A660DA9;
        Thu, 24 Oct 2019 05:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571896012;
        bh=0GkOS8cG3Vs9AvvgJ8VECet2YEd1/rQLcTS72m0fg8c=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=VGPtI0G63SZaJgXIfXmBYfhvSeILYnz+iEp8P36vAFqIV5CDoF6BKan407gqarqKF
         w90pm+r2fujK0Bww0H/AL7Ljs8XsMEJ4JrdQOZN326VVbiw0z5Xvua8a8FBK0JNCtK
         aHIr7Lv4UvPWDiQKOkCC/ZVtcfMaOQy7kdSEMeKw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA0A660DA9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/5] rtw88: use macro to check the current band
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191022100420.25116-2-yhchuang@realtek.com>
References: <20191022100420.25116-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191024054653.6A67860DBC@smtp.codeaurora.org>
Date:   Thu, 24 Oct 2019 05:46:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Add macros to see which band we are, based on the current channel.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

5 patches applied to wireless-drivers-next.git, thanks.

8575b534b000 rtw88: use macro to check the current band
c97ee3e0bea2 rtw88: add power tracking support
0bd9557341b7 rtw88: Enable 802.11ac beamformee support
f39e9bd49a3d rtw88: add set_bitrate_mask support
082a36dc9995 rtw88: add phy_info debugfs to show Tx/Rx physical status

-- 
https://patchwork.kernel.org/patch/11204137/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

