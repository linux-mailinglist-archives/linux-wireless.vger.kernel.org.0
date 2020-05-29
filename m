Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6325E1E80AE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgE2Om7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 10:42:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28825 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgE2Om6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 10:42:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590763378; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=sgwFhfx2LeNnQs2w/EH+FS4PjQINFn3/pt69hEPD/2w=;
 b=jn0P5eLxs68rvRD9PGDC/LIQHWOEpg0JXIFes2cLOd2kCTgzyRPauoZq241+C9MX2JEP5kVd
 iUiTNqOWAXYN5b5z5fQCJnHaLt6YeIyPRcg8LMj/eKHzFFGCpJRWgJNtWbXnrwvabIns5cK6
 Hnm4sQEF5awIL+pveN+LLoBF9Oc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ed11f6476fccbb4c8e4a413 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 14:42:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5C1E1C433CA; Fri, 29 May 2020 14:42:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11320C433C6;
        Fri, 29 May 2020 14:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11320C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath11k: add 802.3 undecap support to fix TKIP MIC
 error
 reporting
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1587720951-9222-3-git-send-email-murugana@codeaurora.org>
References: <1587720951-9222-3-git-send-email-murugana@codeaurora.org>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529144243.5C1E1C433CA@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 14:42:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sathishkumar Muruganandam <murugana@codeaurora.org> wrote:

> Currently DECAP_TYPE_8023 frames with TKIP MIC error is not undecaped
> and hence fails to do TKIP MIC error reporting in ieee80211_rx_napi()
> path.
> 
> Fix this by adding undecap support for ieee80211_rx_napi() to process
> these frames and perform TKIP counter-measures when there is MIC error
> reported.
> 
> Tested with STA triggering TKIP MIC error frames (using debugfs
> "tkip_mic_test" in SW encryption mode) twice within a minute and
> verify TKIP counter-measures are performed as expected.
> 
> Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>

Dropping this patch as the mac80211 patch was dropped.

Patch set to Rejected.

-- 
https://patchwork.kernel.org/patch/11507411/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

