Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E64122E58
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 15:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfLQORb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 09:17:31 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:60508 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728706AbfLQORb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 09:17:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576592250; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=UtmgPpEFOZkssaFrp4KrDqwAOg97aJHbpF0NhZoc5Rs=;
 b=Lw7rZAJr4VFZ2xpDwr5BqUDa7pBY1NPfKIfIsGUibsFTCxK7thamDfKEt5ZsBseZzUH88Qux
 dxqvCBljdQQgWHLuZqT+4pMdvpJJl1BNQ4hli2RmT1dg3yK1gyd981KvcqsRc9hbqBI+IpWw
 QNgjaDAfSxa5hYTsfyyEmzaljMI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df8e375.7fd7586955e0-smtp-out-n01;
 Tue, 17 Dec 2019 14:17:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8398AC433A2; Tue, 17 Dec 2019 14:17:24 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25BACC43383;
        Tue, 17 Dec 2019 14:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25BACC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7] ath11k: register HE mesh capabilities
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191202075815.20409-1-sven@narfation.org>
References: <20191202075815.20409-1-sven@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191217141724.8398AC433A2@smtp.codeaurora.org>
Date:   Tue, 17 Dec 2019 14:17:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> wrote:

> The capabilities for the HE mesh are generated from the capabilities
> reported by the fw. But the firmware only reports the overall capabilities
> and not the one which are specific for mesh. Some of them (TWT, MU UL/DL,
> TB PPDU, ...) require an infrastructure setup with a main STA (AP)
> controlling the operations. This is not the case for mesh and thus these
> capabilities are removed from the list of capabilities.
> 
> Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

13591a1c3899 ath11k: register HE mesh capabilities

-- 
https://patchwork.kernel.org/patch/11268775/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
