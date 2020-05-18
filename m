Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CBF1D784E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 14:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgERMRT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 08:17:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:29198 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbgERMRT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 08:17:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589804238; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=67HYg+z7iAmsjWcA23x4fndlXT85tNzYHeq1pt6rJBU=;
 b=N7JZH5jwO+ITt5q9DSpVzgy9md1ii2R2q/9Lcg82NSvkcXNGKSP1DAab28ounEhRDjDEL9C4
 qd3Pq87f8WXp1n9rdmwb1SEcxfj/rdczE/JUMZ2xv0Yz0U1xW+hPArzJiD1QS7ujzjFaS2++
 aw5FkLjHwl3q8RwURjD9IfadlDk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec27cc4.7f69890d8a40-smtp-out-n03;
 Mon, 18 May 2020 12:17:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AAD17C43636; Mon, 18 May 2020 12:17:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1E49C433F2;
        Mon, 18 May 2020 12:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1E49C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/7] rtw88: extract: export symbols used in chip
 functionalities
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200515052327.31874-2-yhchuang@realtek.com>
References: <20200515052327.31874-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <kevin_yang@realtek.com>, <briannorris@chromium.org>,
        <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200518121708.AAD17C43636@smtp.codeaurora.org>
Date:   Mon, 18 May 2020 12:17:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> In the current design, various chip functions and tables
> are built into rtw88 core. That causes kernel to load its
> functionalities even if a chip isn't currently used. We
> plan to make each chip's functionalities a separate
> kernel module to reduce rtw88 core. And kernel will be
> able to load the necessary.
> 
> Before extracting chip functionalities, we export symbols
> inside rtw88 core which will be used in chip modules.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

7 patches applied to wireless-drivers-next.git, thanks.

449be86670f5 rtw88: extract: export symbols used in chip functionalities
72f256c2b948 rtw88: extract: export symbols about pci interface
ba0fbe236fb8 rtw88: extract: make 8822c an individual kernel module
416e87fcc780 rtw88: extract: make 8822b an individual kernel module
f56f08636dda rtw88: extract: make 8723d an individual kernel module
51aab89a1808 rtw88: extract: remove the unused after extracting
6b684282afcc rtw88: rename rtw88.ko/rtwpci.ko to rtw88_core.ko/rtw88_pci.ko

-- 
https://patchwork.kernel.org/patch/11550499/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
