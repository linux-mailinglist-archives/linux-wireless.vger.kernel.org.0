Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F8E2DF5AF
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Dec 2020 15:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgLTOg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Dec 2020 09:36:58 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:55015 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgLTOg6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Dec 2020 09:36:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608474996; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=3uHl3ZOY5ex30zjTBUCloPec/y4isCuxKsN50qVLmnc=; b=pvVec2WC1IaRIyrBaXHKJI7/xPs8xAks9WRhSLIcyEA4kKxHzL/ewAQwF5i9fB3RDXMtXawa
 QNPh0C8/4fqMVZ7Hv12ucQDfEqb1tL8z1DrpJ+56RjsG/W1BvPZ/ixXDjIDuDoUoTiwPj3tB
 +bH7YSPtElFUEe+4zF2Cq+uMykE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fdf61560564dfefcd6362d9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 20 Dec 2020 14:36:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40290C43461; Sun, 20 Dec 2020 14:36:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86513C433CA;
        Sun, 20 Dec 2020 14:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86513C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] MAINTAINERS: switch to different email address
References: <20201220141807.17278-1-aspriel@gmail.com>
Date:   Sun, 20 Dec 2020 16:36:01 +0200
In-Reply-To: <20201220141807.17278-1-aspriel@gmail.com> (Arend van Spriel's
        message of "Sun, 20 Dec 2020 15:18:07 +0100")
Message-ID: <87czz4r1da.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <aspriel@gmail.com> writes:

> Switching to private mail account as work email is polluted with a legal
> disclaimer. Just making it extra clear by changing the email address in
> the MAINTAINERS file as well.
>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
> ---
> Hi Kalle,
>
> Not sure if both s-o-b lines are really necessary, but better be safe
> then sorry.

I don't see a problem with having two signed offs though I don't think
it's really needed as you are still just one person, I hope :)

I'll queue this for v5.11.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
