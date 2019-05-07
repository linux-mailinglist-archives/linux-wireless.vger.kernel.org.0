Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BD9164BE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 15:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfEGNjF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 09:39:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfEGNjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 09:39:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8CAFD60A44; Tue,  7 May 2019 13:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557236344;
        bh=1fZe1jBdlBPNRD9P2xmudgV6fNxhFLukb/SXlOljpMw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=B6vNRvsVGNG/khkHYjWsL/fNwPP5bKST2QNkVr8gplIvduWN0Tp60cGry9lSZJvmA
         lK2vifjXQbZLuketJAgotmgLJ9vu+q0/Qd33KGoKpuLp8pbkq2irk07yUc+ZyVfUM1
         zqrfeF7OsgEDxkIUIkJFU219t+YqJAMmAx6NXZRs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FB6060779;
        Tue,  7 May 2019 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557236344;
        bh=1fZe1jBdlBPNRD9P2xmudgV6fNxhFLukb/SXlOljpMw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Q9pHPBEecjv7FVg9HmUxpF8LDbrbqpdWwx2IBfXedC85LfEuer+MZwUi5ayskPksi
         mZUI0z4RnQj9h6hpI6gJqwLWPcNmnW96iB8VGuj5bvZCXw7jUp0kJhrkJJhib/rylY
         vlaDei+AAqW3OkFN3wA42QQ64HoVIDb6iVHlCGA0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FB6060779
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Move board id and fw version logging to info level
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190301145000.22624-1-govinds@codeaurora.org>
References: <20190301145000.22624-1-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190507133904.8CAFD60A44@smtp.codeaurora.org>
Date:   Tue,  7 May 2019 13:39:04 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> Board id and fw version is not printed by default in qmi
> cap response message. Move board id and fw version logging
> to info level for default logging.
> 
> [   34.005399] ath10k_snoc a000000.wifi: qmi chip_id 0x30b chip_family 0x4001 board_id 0xff soc_id 0x40070000
> [   34.005432] ath10k_snoc a000000.wifi: qmi fw_version 0x3106836b fw_build_timestamp 2019-02-13 10:24 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.3.1-00875-QCAHLSWMTPL-1
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7b612ed94d0a ath10k: Move board id and fw version logging to info level

-- 
https://patchwork.kernel.org/patch/10835539/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

