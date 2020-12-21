Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD082DFFCA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 19:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgLUSbe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 13:31:34 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:21301 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgLUSbd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 13:31:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608575474; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ec7SeXQDHx25dWwhw+YXkYHSs9dEI998KBUYdGlQym8=;
 b=n4j9HBPf2zk/TG3KHEM+Uam2H1rWfFBiENnarTqsxaESuFUKcfLr6CE5gTmUBdPvSOeiTlGt
 ECALAMIOaUKnnkaerCPfZ/Ki538mvUdw0Jq0Hl9ig0A+mmsCN0ADMubn07zUOkoD/lgcV52F
 HeTMI+xq/Ue+zj5vqIZ6rRVOAos=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fe0e9d3b00c0d7ad4b7e490 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Dec 2020 18:30:43
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C155BC433ED; Mon, 21 Dec 2020 18:30:42 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0ABF3C43462;
        Mon, 21 Dec 2020 18:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0ABF3C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: Per-chain rssi should sum the secondary
 channels
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191217183343.25585-1-greearb@candelatech.com>
References: <20191217183343.25585-1-greearb@candelatech.com>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Ben Greear <greearb@candelatech.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201221183042.C155BC433ED@smtp.codeaurora.org>
Date:   Mon, 21 Dec 2020 18:30:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com wrote:

> From: Ben Greear <greearb@candelatech.com>
> 
> This makes per-chain RSSI be more consistent between HT20, HT40, HT80.
> Instead of doing precise log math for adding dbm, I did a rough estimate,
> it seems to work good enough.
> 
> Tested on ath10k-ct 9984 firmware.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>

Commented out code etc so I assume this is an RFC. Has anyone tested
this with upstream firmware?

Patch set to RFC.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20191217183343.25585-1-greearb@candelatech.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

