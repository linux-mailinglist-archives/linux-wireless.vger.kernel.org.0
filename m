Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9C131497C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhBIH0i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 02:26:38 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:19661 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhBIH00 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 02:26:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612855565; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=7f/58di33FhLnyybzDD59JnC1AAwY17lovgQB8UGD/o=;
 b=SsBSYa6iG9CH8gBcZUF7E63fVpd73fjGRGvyFv4qznNB3Mqt4oGJLFcXR7eX32b1lWyuYVnv
 CHAABWcrqPiDixfH+Krt5mwSwf557aVY8KkLAOIdTgyWfucSpSgd1JboIA7dbxHrf6H0V9nG
 S0lwDvb3/FK49uCt/QKYJtE89Xk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6022390d4bd23a05ae4056da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 07:26:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5FDC8C43462; Tue,  9 Feb 2021 07:26:05 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81A02C433ED;
        Tue,  9 Feb 2021 07:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81A02C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] wil6210: Add Support for Extended DMG MCS 12.1
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1609977050-7089-3-git-send-email-mxchen@codeaurora.org>
References: <1609977050-7089-3-git-send-email-mxchen@codeaurora.org>
To:     Max Chen <mxchen@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Max Chen <mxchen@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210209072605.5FDC8C43462@smtp.codeaurora.org>
Date:   Tue,  9 Feb 2021 07:26:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Max Chen <mxchen@codeaurora.org> wrote:

> FW reports Tx/Rx extended MCS 12.1 to driver as "26". Driver will
> convert this into base MCS 7 + EXTENDED_SC_DMG flag so kernel can do
> the correct phy rate conversion. Also add log prints to print "12.1"
> instead of "26" for extended MCS.
> 
> Signed-off-by: Max Chen <mxchen@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7064e2193cab wil6210: Add Support for Extended DMG MCS 12.1

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1609977050-7089-3-git-send-email-mxchen@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

