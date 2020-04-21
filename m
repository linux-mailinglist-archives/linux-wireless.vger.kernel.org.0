Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38591B2584
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 14:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDUMEy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 08:04:54 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:42663 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbgDUMEy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 08:04:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587470693; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=4SxVHVQVrD43/pRWvBCEq3JZFOE1kHwsNx2ELKuYVZA=;
 b=w6VdGTn9xSl9f/iVdxS47zXIgfqJE7I2YWdBezICrsasyt/CtVIiOXpJZ4Io27qvBWjodAz2
 K9h+QYZktmR0DvcpMCIaLQ6RLylBqj3XYnNZ7xGMgRIOQeVxZ3mcQM25uOimAT5rgmCdeweO
 9/LkRjK3Y8dm5X0MEk1tN2fRl5A=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9ee159.7f8d5e0fef80-smtp-out-n02;
 Tue, 21 Apr 2020 12:04:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0C091C433F2; Tue, 21 Apr 2020 12:04:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D248AC433D2;
        Tue, 21 Apr 2020 12:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D248AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] ath10k: rename ath10k_hif_swap_mailbox() to
 ath10k_hif_start_post()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1587037859-28873-2-git-send-email-kvalo@codeaurora.org>
References: <1587037859-28873-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200421120440.0C091C433F2@smtp.codeaurora.org>
Date:   Tue, 21 Apr 2020 12:04:40 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Convert ath10k_hif_swap_mailbox() to a more generic op so that bus drivers can
> do more than just swap the mailbox, for example set power save settings like in
> the following sdio patch.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

4 patches applied to ath-next branch of ath.git, thanks.

557e171434eb ath10k: rename ath10k_hif_swap_mailbox() to ath10k_hif_start_post()
22f28076b6c3 ath10k: improve power save performance for sdio
589217632103 ath10k: sdio: remove _hif_ prefix from functions not part of hif interface
96c64857983f ath10k: hif: make send_complete_check op optional

-- 
https://patchwork.kernel.org/patch/11492849/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
