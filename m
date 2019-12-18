Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA84124FDB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfLRRy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 12:54:59 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:40238 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbfLRRy7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 12:54:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576691698; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=xmkts6baYtfSOSFKDvHGtDzBgWDv71Vf1olaANn+h9c=;
 b=fJcPh6fzIf4vgmurW2tqGI0qTfJk8pV6jp7ho2K1lM5wASLJs2a2FAV6ZuSbpPqxGmU9SGoU
 r+8mmjogPG0y8q4I/Ob+YqkQmlTV7TIuFwghzwKd445RJvCucAdG9DEnrcsiVqORgRyJi4yP
 6L34sKqV7M5dSiZDmZ+/sx426Wc=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa67ed.7f16649d9d50-smtp-out-n03;
 Wed, 18 Dec 2019 17:54:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3AD92C43383; Wed, 18 Dec 2019 17:54:53 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0E21C43383;
        Wed, 18 Dec 2019 17:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0E21C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: delete a stray unlock in
 ath11k_dbg_htt_stats_req()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213104754.2lwrq2qqokycjjbm@kili.mountain>
References: <20191213104754.2lwrq2qqokycjjbm@kili.mountain>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Anilkumar Kolli <akolli@codeaurora.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218175453.3AD92C43383@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 17:54:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The callers unlock this lock so this error path has a double unlock.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

cd21c827a155 ath11k: delete a stray unlock in ath11k_dbg_htt_stats_req()

-- 
https://patchwork.kernel.org/patch/11290409/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
