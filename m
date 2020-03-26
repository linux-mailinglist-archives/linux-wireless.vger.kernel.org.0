Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2F2193C12
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 10:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCZJmi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 05:42:38 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:59974 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbgCZJmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 05:42:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585215757; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=wTCkq/fHmWJk5v+Qmt4gk0xwR53fh8nF9Wr9D7Ah75o=;
 b=s7eapV6ceDou7gdm5GkcJk6DO1hGHeAu0qrizRv5mo9RSgljE5kP+OMy/EEqJE2pe79xx12G
 g2t/1MY5LlRPTDjWi4tNyOF0/PPBDrXuClXkHCz4gaQIcceyJDtcVw6D9+9I7EMTtDroda3h
 kdeRhTqiRHwq0q7xzNTOUHrGvsk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7c790c.7f3c272f0570-smtp-out-n01;
 Thu, 26 Mar 2020 09:42:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16403C43637; Thu, 26 Mar 2020 09:42:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B2132C433D2;
        Thu, 26 Mar 2020 09:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2132C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] rtw88: add a debugfs entry to dump coex's info
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200313033008.20070-2-yhchuang@realtek.com>
References: <20200313033008.20070-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <johannes@sipsolutions.net>, <arend.vanspriel@broadcom.com>,
        <tamizhr@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200326094236.16403C43637@smtp.codeaurora.org>
Date:   Thu, 26 Mar 2020 09:42:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Add a new entry "coex_info" in debugfs to dump coex's states for
> us to debug on coex's issues.
> 
> The basic concept for co-existence (coex, usually for WiFi + BT)
> is to decide a strategy based on the current status of WiFi and
> BT. So, it means the WiFi driver requires to gather information
> from BT side and choose a strategy (TDMA/table/HW settings).
> 
> Althrough we can easily check the current status of WiFi, e.g.,
> from kernel log or just dump the hardware registers, it is still
> very difficult for us to gather so many different types of WiFi
> states (such as RFE config, antenna, channel/band, TRX, Power
> save). Also we will need BT's information that is stored in
> "struct rtw_coex". So it is necessary for us to have a debugfs
> that can dump all of the WiFi/BT information required.
> 
> Note that to debug on coex related issues, we usually need a
> longer period of time of coex_info dump every 2 seconds (for
> example, 30 secs, so we should have 15 times of coex_info's
> dump).
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Chris Chiu <chiu@endlessm.com>

2 patches applied to wireless-drivers-next.git, thanks.

1fe188da9de5 rtw88: add a debugfs entry to dump coex's info
d05550936ac8 rtw88: add a debugfs entry to enable/disable coex mechanism

-- 
https://patchwork.kernel.org/patch/11435925/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
