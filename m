Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6933F3C41
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 21:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhHUTUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 15:20:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24212 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230022AbhHUTUW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 15:20:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629573583; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=eF0gYav3vS9Hx4zy3jnW+UB9dHq4sPLBVBcMFnDnzQY=;
 b=C2YhiKkSXWg6EggzTeDXe+64Lg/uE0Iu7uy71E3HIKDOlz1OlrHxPoWR+ocQInfdIhNoUY8A
 uIV07Kz4lk+srOSmSHvOQ+8+RG6ticu1FZEUz0Ok8ab929UyixeY0yJU2dyb5l+bz5iICmng
 gP/qU0XH0Q57zU82JSFyCw1nKWk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 612151ca1d4eeff4c3613ae0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 19:19:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 22F45C43460; Sat, 21 Aug 2021 19:19:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6018DC4338F;
        Sat, 21 Aug 2021 19:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6018DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/5] rtw88: use read_poll_timeout instead of fixed
 sleep
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210728014335.8785-2-pkshih@realtek.com>
References: <20210728014335.8785-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821191938.22F45C43460@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 19:19:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> In current wow flow, driver calls rtw_wow_fw_start and sleep for 100ms,
> to wait firmware finish preliminary work and then update the value of
> WOWLAN_WAKE_REASON register to zero. But later firmware will start wow
> function with power-saving mode, in which mode the value of
> WOWLAN_WAKE_REASON register is 0xea. So driver may get 0xea value and
> return fail. We use read_poll_timeout instead to check the value to avoid
> this issue.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-drivers-next.git, thanks.

02a55c0009a5 rtw88: use read_poll_timeout instead of fixed sleep
67368f14a816 rtw88: refine the setting of rsvd pages for different firmware
05e45887382c rtw88: wow: build wow function only if CONFIG_PM is on
4bac10f2de22 rtw88: wow: report wow reason through mac80211 api
69c7044526d9 rtw88: wow: fix size access error of probe request

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210728014335.8785-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

