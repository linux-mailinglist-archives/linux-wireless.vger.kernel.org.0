Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614A61E80DA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 16:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgE2Otv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 10:49:51 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:25812 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbgE2Otu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 10:49:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590763790; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=CCAx0nMZ5M4ci8prsquEcl5EDHkzJ7MeKtXQ9/Smrfk=;
 b=tCK9WZpOzP8kdfESTm2DvZL2llgDoj8AZFsLQWQn4UKNEqQaDxa15RmFT+S+5nsuGJI7tODY
 d2DWG2/eu94JDOBesrB8WL8ooZLY9l1l6xPOEi5fMYUa2Ddl+MAsI7PvdC9QRsJ8nggekjfz
 szQeHOJO54KlxVahwRAJde/vbBA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed1210176fccbb4c8e7c43c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 14:49:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CE622C433CB; Fri, 29 May 2020 14:49:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F33AC433CA;
        Fri, 29 May 2020 14:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F33AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath11k: Add peer max mpdu parameter in peer assoc
 command
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588611900-21185-2-git-send-email-tamizhr@codeaurora.org>
References: <1588611900-21185-2-git-send-email-tamizhr@codeaurora.org>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     ath11k@lists.infradead.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529144936.CE622C433CB@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 14:49:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh Chelvam <tamizhr@codeaurora.org> wrote:

> Add peer max mpdu length configuration support in peer_assoc_he
> parameters. Noticed low throughput for the STA which
> supports HE, HT and not VHT in MU-MIMO case without this
> configuration
> 
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>

Depends on:

fedd0fe4e89b mac80211: Add new AMPDU factor macro for HE peer caps

Currently in mac80211-next.

-- 
https://patchwork.kernel.org/patch/11526769/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

