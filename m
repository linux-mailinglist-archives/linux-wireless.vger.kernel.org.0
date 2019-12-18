Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE662125015
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 19:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLRSGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 13:06:12 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:29300 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727121AbfLRSGL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 13:06:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576692370; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=lHBwTe4HTodi+wkaR5RLi4Gp7TZTCEaHQXQwjYymORA=; b=Dj4gdcYXGUfj2E7VXmMMn9TQQkqo996f+38lqLufc9Ewoo4TktQOSxD+Tjvw6EiVnkS50fCY
 qVyskj8vFeGxS8Bzjwxg9pXkpZxqsjN4nUEpb1JVAESdvbysE+P+3u5aHtHrteKe6A/C7s0z
 0JAyUOQ6fDHr5Yp/yq3eokxQFCI=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa6a91.7fb7220eed50-smtp-out-n02;
 Wed, 18 Dec 2019 18:06:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10C06C447A5; Wed, 18 Dec 2019 18:06:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B33FC4479C;
        Wed, 18 Dec 2019 18:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B33FC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH V2 1/2] ath11k: fix pdev when invoking ath11k_wmi_send_twt_enable_cmd()
References: <20191213153457.11946-1-john@phrozen.org>
Date:   Wed, 18 Dec 2019 20:06:04 +0200
In-Reply-To: <20191213153457.11946-1-john@phrozen.org> (John Crispin's message
        of "Fri, 13 Dec 2019 16:34:56 +0100")
Message-ID: <87h81x8q5v.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
>
> The code currently uses the wrong pdev id when enabling TWT. Fix this by
> using the correct ones.
>
> Fixes: e65a616f4e74 ("ath11k: add TWT support")
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

I noticed only after I applied this, but the s-o-b line is in wrong
order. Pradeep, being the author, should have his s-o-b line first.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
