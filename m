Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13E41A9723
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894856AbgDOImQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 04:42:16 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62693 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2894865AbgDOImO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 04:42:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586940134; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=gnWUKVTF2Dn7tUMLJrJKql5lrfANcY6Bknq4Dhn2z3g=;
 b=ra/c/10VJz2G0hcwW2T9stCpp7FFQkVnBhRrkFN5i6vbety944GbWu9f9sWcYRU19M90GBI/
 QN2NOlCvcKlFGLqluW+wojXsrkIal0fu2/UFVPQozn9hXorhNGYDK5T9ROUQgpegvxPknNLq
 obFz8kBGuDLE0e9GSyFwMlB8LHM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96c8de.7f4d421f0420-smtp-out-n05;
 Wed, 15 Apr 2020 08:42:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F2D0C432C2; Wed, 15 Apr 2020 08:42:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A19AFC433F2;
        Wed, 15 Apr 2020 08:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A19AFC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw88: make rtw_chip_ops::set_antenna return int
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200410100950.3199-2-yhchuang@realtek.com>
References: <20200410100950.3199-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200415084205.4F2D0C432C2@smtp.codeaurora.org>
Date:   Wed, 15 Apr 2020 08:42:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> To support ieee80211_ops::set_antenna, the driver can decide if the
> antenna mask is accepted, otherwise it can return an error code.
> Because each chip could have different limitations, let the chip
> check the mask and return.
> 
> Also the antenna mask for TRX from upper space is 32-bit long.
> Change the antenna mask for rtw_chip_ops::set_antenna from u8 to u32.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

2 patches applied to wireless-drivers-next.git, thanks.

b9ed7e9505ba rtw88: make rtw_chip_ops::set_antenna return int
297bcf8222f2 rtw88: add support for set/get antennas

-- 
https://patchwork.kernel.org/patch/11483097/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
