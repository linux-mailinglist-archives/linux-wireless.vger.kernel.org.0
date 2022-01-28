Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F05449FD48
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbiA1P6m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiA1P6i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE42C061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 07:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E446B803F5
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F351DC340E0;
        Fri, 28 Jan 2022 15:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385515;
        bh=NCXv+ooHdTvP5bhtbHkUYN+rQZT47F5Ooap9N0Oqsgs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DovGbHW1imhEM6PBFi+qbB1A/YpHUIGJYLJ0L3whY2DtAnGw0PguEYXuuELjkoJFv
         O/YM20tr8rNq6qnj3aqnkH4MB05l/vbuUxfPio49j89pI3E4qoG1aIpQlYjDNvRC6D
         2juJbW/PkAimuQN9t9x+OgK0uhy4YYFbC2gDuBLufX9uQ9TfdFny+spAuCTSABOIK+
         thDGJd3Ak5QAkgTFMg89ES7G9peZtOFgQ0LMuzd6+4wDrJ2ciQ0bj0dNTq317CQ8k+
         Ee3NakBUCxnGneCYVUBnJW2CSmk75X5A6mRFanQ5O6KWNhOX4IdIg+tbx8TDbF+DW7
         zOfa1mVsKn5Uw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: use pci_read/write_config instead of dbi
 read/write
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220121075555.12457-2-pkshih@realtek.com>
References: <20220121075555.12457-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <johnson.lin@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338551330.19531.4222303619102299534.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 15:58:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> In the past we use dbi function of wifi mac to read/write
> pci config space, but the function will be remove in new
> chip. So use kernel api pci_read/write_config_byte instead.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

db38d9cd26c9 rtw89: use pci_read/write_config instead of dbi read/write

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220121075555.12457-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

