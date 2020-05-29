Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2B1E8515
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgE2RhB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 13:37:01 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19157 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgE2RhB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 13:37:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590773820; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=O9Gk6t27K6v8nXyC9EMGoqGAAyjerDeZDQutwwvJNA4=;
 b=RCd3RkMfbDA9No4U0Wv++0YV5gbiuy6a1gJttN+McgpAdGMqq+mXVmSK7mXNwQxEWJrKlHaY
 PxSKdZDBf/RS2iyi+XHhAP7DbpEQu3rsHGz6aiY5kxVdcPSvop4fUgj14wVcbwBf4pV4QRNM
 dWPGuQlYsj3oEzg30XWUsJsZly8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ed148222c5499847527aeda (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:36:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0409EC433CB; Fri, 29 May 2020 17:36:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EADF2C433C6;
        Fri, 29 May 2020 17:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EADF2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] rtw88: coex: 8723d: set antanna control owner
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200529025009.2468-2-yhchuang@realtek.com>
References: <20200529025009.2468-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <kai.heng.feng@canonical.com>, <bigeasy@linutronix.de>,
        <vicamo.yang@canonical.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529173634.0409EC433CB@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:36:33 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> Without setting antenna control owner, the WiFi could be disconnected if
> the BT has traffic. Because the antenna is switched to BT side for its
> traffic, and the WiFi will have no chance to transfer data. Set control
> owner to prevent WiFi disconnect issue.
> 
> Fixes: f5df1a8b4376 ("rtw88: 8723d: Add 8723DE to Kconfig and Makefile")
> Tested-by: You-Sheng Yang <vicamo.yang@canonical.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

3 patches applied to wireless-drivers-next.git, thanks.

efad661168c7 rtw88: coex: 8723d: set antanna control owner
2647d2827f2a rtw88: coex: 8723d: handle BT inquiry cases
7a242fb69821 rtw88: fix EAPOL 4-way failure by finish IQK earlier

-- 
https://patchwork.kernel.org/patch/11577459/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

