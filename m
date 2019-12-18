Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7DA124FE8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfLRR4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 12:56:55 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:49682 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727031AbfLRR4z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 12:56:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576691815; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=N9aK8LRxFPBgc6cxwY6aP4KXf0PlA7ijFAJHfblzt+g=;
 b=Y487yi9BEbI4Oh2dNt2ZrnqbRFAhHRTkTnaoeLKOJQlBbtuqVPsbpVAijTeMKYEIwl8md0GZ
 Zew3tXNnE3+mBuxasP33k0XAGBepYbkqhpU7poGgnuXUw0XZlZkRT3iAf5l2P2bh1dnxOHrC
 e9sYlfptHHYB9kIUqqVjk7jsHoI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa6862.7f684f01e8b8-smtp-out-n02;
 Wed, 18 Dec 2019 17:56:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44196C4479C; Wed, 18 Dec 2019 17:56:50 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0D92C433CB;
        Wed, 18 Dec 2019 17:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0D92C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: remove an unneeded NULL check
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213105219.qbpng7eut5zgty2p@kili.mountain>
References: <20191213105219.qbpng7eut5zgty2p@kili.mountain>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218175650.44196C4479C@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 17:56:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The list iterator is always non-NULL so it doesn't need to be checked.
> I also removed the unnecessary initializer because the list iterator is
> always initialized.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

269663f18474 ath11k: remove an unneeded NULL check

-- 
https://patchwork.kernel.org/patch/11290433/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
