Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48728000D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgJANYU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 09:24:20 -0400
Received: from z5.mailgun.us ([104.130.96.5]:45221 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbgJANYT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 09:24:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601558659; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fj9K3Uz3c9VPPs0rNuLlzNeFiOSveLwgREK4ka11z3w=;
 b=xFYpSt8JueFrUu8xTO/z1tGGbx80pnCIO0muVUuR4PuYJ5J25WQFSkOaXc69Ge5KAf3rMpgg
 fg5E19nvXta+ftJ+m5Ge7Hi60uA2ZBD6YdYgdw2mfgOIL5cZA8gYhf0v2yqInlpYrrOF4MCh
 07gv099DRnV2IgBatFfa/oadNKQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f75d87b7671600ec8f63233 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 13:24:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6DF9C433FE; Thu,  1 Oct 2020 13:24:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1430C433CB;
        Thu,  1 Oct 2020 13:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1430C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/18] bcma: use semicolons rather than commas to separate
 statements
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1601233948-11629-6-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-6-git-send-email-Julia.Lawall@inria.fr>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        =?utf-8?q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201001132411.C6DF9C433FE@smtp.codeaurora.org>
Date:   Thu,  1 Oct 2020 13:24:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> @@ expression e1,e2; @@
> e1
> -,
> +;
> e2
> ... when any
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Patch applied to wireless-drivers-next.git, thanks.

703314b2db3b bcma: use semicolons rather than commas to separate statements

-- 
https://patchwork.kernel.org/patch/11802381/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

