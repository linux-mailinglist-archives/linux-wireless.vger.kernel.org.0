Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BEC21ED2A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgGNJsY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 05:48:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59512 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgGNJsW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 05:48:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594720101; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=EIUT7RSvmJm9YD3PhFZ2aKN7mz7yICK/9Cf0I364IhM=;
 b=o0YEuTJOoX4ngwD+R17HZoPqtHoRIVFqtGC+cPHl+dIKnxPksUMMuPL4KsJ44G2kT8KqQ2EA
 m0goN5trRfQ5JN5nLqrPSq0zQtrFOW1OcLMo4vFO6n0aQsXpIsU7QMc5glDQlHVzJBBHu8Ce
 ZREKkxEO4y7lOE0fulf5I7tQLrc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5f0d7f6510127684905a3bd6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 09:48:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28279C43387; Tue, 14 Jul 2020 09:48:21 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B34EC433C8;
        Tue, 14 Jul 2020 09:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B34EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] brcmfmac: Fix for unable to return to visible SSID
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200618160739.21457-2-chi-hsien.lin@cypress.com>
References: <20200618160739.21457-2-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Soontak Lee <soontak.lee@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200714094821.28279C43387@smtp.codeaurora.org>
Date:   Tue, 14 Jul 2020 09:48:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> wrote:

> From: Soontak Lee <soontak.lee@cypress.com>
> 
> Unable to change back to visiable SSID because there is
> no disable hidden ssid routine.
> 
> Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>

3 patches applied to wireless-drivers-next.git, thanks.

d9429d03b6bc brcmfmac: Fix for unable to return to visible SSID
1b050d9711f9 brcmfmac: Fix for wrong disconnection event source information
0d9de08da52a brcmfmac: do not disconnect for disassoc frame from unconnected AP

-- 
https://patchwork.kernel.org/patch/11612797/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

