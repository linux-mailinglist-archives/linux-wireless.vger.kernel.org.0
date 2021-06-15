Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562FF3A7B78
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFOKMI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 06:12:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61674 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231214AbhFOKMI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 06:12:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623751804; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Y7k77VBQP3fCpe/TV53XvcFofZF7ubKF7cXmVcJsMyE=;
 b=q0uFLj7ama24M+OG7NpJeqUOq5AKwImGu5OgjTdo7eOlNfxdEeKfgKZa5QEHEGQBwQ1trCGm
 mOWW82cuzVckYnMkdpopHsVCC4Q/Y1vLbYJd46fKcO6VzLYNMFKxIlMNUCqgSzeCWIf215mr
 aQYfdfk/c1o7OLCHxgt2C3h+MCA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60c87c65ed59bf69cc211b4b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 10:09:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7C9BC4360C; Tue, 15 Jun 2021 10:09:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66C64C4338A;
        Tue, 15 Jun 2021 10:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66C64C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v2] ssb: pcicore: Fix indentation of comment
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210428161836.sdrxzcrfiekloucz@kewl-virtual-machine>
References: <20210428161836.sdrxzcrfiekloucz@kewl-virtual-machine>
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615100940.E7C9BC4360C@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 10:09:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shubhankar Kuranagatti <shubhankarvk@gmail.com> wrote:

> Shifted the closing */ to the next line
> This is done to maintain code uniformity.
> 
> Acked-by: Michael Büsch <m@bues.ch>
> Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

2a3d830fa8f9 ssb: pcicore: Fix indentation of comment

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210428161836.sdrxzcrfiekloucz@kewl-virtual-machine/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

