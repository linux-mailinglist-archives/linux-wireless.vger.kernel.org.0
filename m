Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4C33AD6B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 09:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhCOIaU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 04:30:20 -0400
Received: from z11.mailgun.us ([104.130.96.11]:41561 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhCOIaD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 04:30:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615797003; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=witsg3Rh7/ygc4CvC2hVWOfnviPkiGEjA1BQm7s4IT4=;
 b=m84qPHBcAtOqwitmqRefpIhxbWlbC3qabzwrK/iFX+2F8HntQHu+uaKSdYM8JfVnSkRvTJtU
 CJJsDmTwlooeNJA+OXl9oQkHEq3gJwyaNLNj3JKMwWdr8MKOgQcwXCUhBfKO4vFndTmsqJDd
 jkhbH1anVYE1nbe+C4ucCLo6D4g=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 604f1b015d70193f885d456b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Mar 2021 08:29:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5296EC433CA; Mon, 15 Mar 2021 08:29:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59C6BC433C6;
        Mon, 15 Mar 2021 08:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59C6BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: 8822c: support FW crash dump when FW crash
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210309060121.9099-1-pkshih@realtek.com>
References: <20210309060121.9099-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210315082953.5296EC433CA@smtp.codeaurora.org>
Date:   Mon, 15 Mar 2021 08:29:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Although FW crash logs are already supported for dumping in driver, the
> logs may not be sufficient to analyze field issues. To improve this part,
> we add a support to dump FW memory.
> 
> When driver receives FW crash notifications, driver uses DDMA, which is a
> HW ability, to copy specified FW memory to FW fifo. Driver can then dump
> these information from FW fifo. With this support, not only FW crash log
> but also specified FW memory will be dumped while FW crash. Besides,
> specified registers are also dumped.
> 
> This feature is implemeted on 8822C first due to difference of FW layouts
> between ICs. In addition, we add a debugfs to trigger FW crash. It can
> simulate the process of crash, dump and reset. Through it, we can also
> check if a reset is ongoing.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

13ce240a932f rtw88: 8822c: support FW crash dump when FW crash

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210309060121.9099-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

