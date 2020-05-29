Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A631E824D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 17:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgE2PnD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 11:43:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48917 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgE2PnC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 11:43:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590766982; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=RhNe8ApHQBpvFbvoJFJul5NOqY6IbZJGAYDJMCkk1lg=;
 b=Jt+3HaT2h2DRrr82pbZ8azOGDXzwnhi53t/Dg74Z80Y7mGGcwdszyX7KbYaqEyF50ZBzcSBW
 0z1e0fdkckJqX0zrGAPyb+2pLKLXMY+w+aN0VvzGDWnEjvMT2k+/RNKPuVwWJoNxz8ipftNk
 qsbenqgmsxIXxUT7is7KiyVtCvw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ed12d7dc28b2cdd98dc4dd5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 15:42:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21EC5C43391; Fri, 29 May 2020 15:42:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF45AC43391;
        Fri, 29 May 2020 15:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF45AC43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rt2800: enable MFP support unconditionally
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200525134906.1672-1-rsalvaterra@gmail.com>
References: <20200525134906.1672-1-rsalvaterra@gmail.com>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     johannes@sipsolutions.net, stf_xl@wp.pl, julian.calaby@gmail.com,
        Larry.Finger@lwfinger.net, linux-wireless@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529154253.21EC5C43391@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 15:42:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rui Salvaterra <rsalvaterra@gmail.com> wrote:

> This gives us WPA3 support out of the box without having to manually disable
> hardware crypto. The driver will fall back to software crypto if the connection
> requires management frame protection.
> 
> Suggested-by: Stanislaw Gruszka <stf_xl@wp.pl>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

b6b15e20421f rt2800: enable MFP support unconditionally

-- 
https://patchwork.kernel.org/patch/11568861/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

