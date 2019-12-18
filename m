Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755541245CF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLRLcJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 06:32:09 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:47933 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfLRLcJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 06:32:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576668728; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6xFV6l7wd4qIDuzh2oJqUdDBEQytyqXsysx/qvsS2uU=;
 b=jXejbg6Kakz9KHf8yKI9u7On+UDbWV06RvGmluKHXD/YvueYzGU0Mr01O3Qs15U9VNgycdt1
 MVkT8ltxDKwa/DBD+/MXGcB7aVq+nhZHZj7XqeNGYBRwTa5Z4B/oBdSrcTLm6g0zIb1sYzU7
 Y7gJsS9nojfNPIWQ8rcGz96ve+A=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa0e33.7f6508a997d8-smtp-out-n02;
 Wed, 18 Dec 2019 11:32:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29B68C433CB; Wed, 18 Dec 2019 11:32:02 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6D1BC43383;
        Wed, 18 Dec 2019 11:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6D1BC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V3 6/9] ath11k: add debugfs for TWT debug calls
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213153839.12372-7-john@phrozen.org>
References: <20191213153839.12372-7-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218113202.29B68C433CB@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 11:32:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> These new debugfs files allow us to manually add/del/pause/resume TWT
> dialogs for test/debug purposes.
> 
> The debugfs files expect the following parameters
> add_dialog	- mac dialog_id wake_intvl_us wake_intvl_mantis
> 		  wake_dura_us sp_offset_us twt_cmd flag_bcast
> 		  flag_trigger flag_flow_type flag_protection
> del_dialog	- mac dialog_id
> pause_dialog	- mac dialog_id
> resume_dialog	- mac dialog_id sp_offset_us next_twt_size
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This added a new warning, fixed in pending branch:

drivers/net/wireless/ath/ath11k/debug.c:123: quoted string split across lines

-- 
https://patchwork.kernel.org/patch/11290751/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
