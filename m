Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 014E6D5F3B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 11:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfJNJpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 05:45:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39448 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJNJpQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 05:45:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CC5BF60610; Mon, 14 Oct 2019 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571046314;
        bh=NjVIXW9ak9QOQspHjRNwALNsgTmhIPv2GgmHFJkEiHY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lMYufs+e6yGlq63HExm7fp3uh/xoBMKm0m4FdtJgsCFZ0TfJcf8Q/5abPKSLpRATK
         NJTRMCQntV41rfzce6Eeyntr4TUkxNtKeTnPjnw4fOcvlcccTfJVbKl55XvwPks9FZ
         EZ6nBxuiogaQzRwuY7iTdGwPXG3uqKG//KMtiI60=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61FE9602E0;
        Mon, 14 Oct 2019 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571046314;
        bh=NjVIXW9ak9QOQspHjRNwALNsgTmhIPv2GgmHFJkEiHY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lMYufs+e6yGlq63HExm7fp3uh/xoBMKm0m4FdtJgsCFZ0TfJcf8Q/5abPKSLpRATK
         NJTRMCQntV41rfzce6Eeyntr4TUkxNtKeTnPjnw4fOcvlcccTfJVbKl55XvwPks9FZ
         EZ6nBxuiogaQzRwuY7iTdGwPXG3uqKG//KMtiI60=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61FE9602E0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: Re: [PATCH 00/10] rtw88: minor throughput improvement
References: <20191008082101.2494-1-yhchuang@realtek.com>
Date:   Mon, 14 Oct 2019 12:45:11 +0300
In-Reply-To: <20191008082101.2494-1-yhchuang@realtek.com> (yhchuang's message
        of "Tue, 8 Oct 2019 16:20:51 +0800")
Message-ID: <87mue3fyoo.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> This patchset mainly adds support for beamforming and power
> tracking. Power tracking can monitor the thermal value of
> the device and adjust corresponding power indexes, to make
> sure the RF output power is expected.
>
> And another thing is to add a debugfs for physical layer
> information. This is useful when sometimes the environment
> is too harsh for the device, and provides the activities
> for us to debug.
>
> The rest patches are some minor fixes.
>
>
> Ping-Ke Shih (1):
>   rtw88: coex: Set 4 slot mode for A2DP
>
> Tsang-Shian Lin (1):
>   rtw88: add phy_info debugfs to show Tx/Rx physical status
>
> Tzu-En Huang (6):
>   rtw88: add power tracking support
>   rtw88: Enable 802.11ac beamformee support
>   rtw88: config 8822c multicast address in MAC init flow
>   rtw88: add set_bitrate_mask support
>   rtw88: update regulatory settings implementaion
>   rtw88: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support
>
> Yan-Hsuan Chuang (2):
>   rtw88: Use rtw_write8_set to set SYS_FUNC
>   rtw88: pci: config phy after chip info is setup

It would be easier for me if you could split the patchsets even more,
for example fixes into one set and new features into another. That way I
can apply the fixes faster. (I now applied five fixes from this set)

And maybe you could even split the new features into smaller sets, or
maybe even just send them one by one once you have a patch ready
(especially on bigger features). That would also make it faster to
review, reviewing big patchsets is pain.

But whenever you submit, just to use wireless-drivers-next as the
baseline, and no extra patches on top of. That way it's for git to
handle conflicts.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
