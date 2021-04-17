Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60B3363199
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhDQRr4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 13:47:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34240 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236692AbhDQRrz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 13:47:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618681648; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fV6Mz6u/Lhxzac+O0UMKpYTg7k95TOBdOR7pWne3wrA=;
 b=VknSZOeQEQrcKGm5h1GlNh6k7PqXrxEx+DI4FjI2yDtJR++ZWO12nW3TANAhlatFMZsmlvYy
 l4RAHgrSGddAP6hwrbm/hdADfU8px9YU+9VzfAHFs0fjgKiAiP83xdjxxRvC7hRDq+KEJ6Gf
 gddC9PmFxjxO93dXXnYNR/SnBOk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 607b1f1ba817abd39a262755 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Apr 2021 17:47:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF190C43217; Sat, 17 Apr 2021 17:47:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43413C433D3;
        Sat, 17 Apr 2021 17:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43413C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: don't print SSID to logs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210225024454.4106485-1-briannorris@chromium.org>
References: <20210225024454.4106485-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210417174706.DF190C43217@smtp.codeaurora.org>
Date:   Sat, 17 Apr 2021 17:47:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> There are a few reasons not to dump SSIDs as-is in kernel logs:
> 
> 1) they're not guaranteed to be any particular text encoding (UTF-8,
>    ASCII, ...) in general
> 2) it's somewhat redundant; the BSSID should be enough to uniquely
>    identify the AP/STA to which we're connecting
> 3) BSSIDs have an easily-recognized format, whereas SSIDs do not (they
>    are free-form)
> 4) other common drivers (e.g., everything based on mac80211) get along
>    just fine by only including BSSIDs when logging state transitions
> 
> Additional notes on reason #3: this is important for the
> privacy-conscious, especially when providing tools that convey
> kernel logs on behalf of a user -- e.g., when reporting bugs. So for
> example, it's easy to automatically filter logs for MAC addresses, but
> it's much harder to filter SSIDs out of unstructured text.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

d23a96220353 mwifiex: don't print SSID to logs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210225024454.4106485-1-briannorris@chromium.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

