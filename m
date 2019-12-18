Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF64C124571
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 12:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfLRLOr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 06:14:47 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:46859 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfLRLOr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 06:14:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576667686; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2h8kYzc8GCrZ/bGRc0CiqzrLA8hBzoH3kk8C5UgLK1Q=;
 b=EXKV4VQbCJj34GESJHKrSHUnEQOOnNZw/8ELt4GDFn7O8/ffZfzoPa7B4dWi7iCPo+TOnB7m
 NK8u00NRbnRR91JXH6F6DKfC8U88NvGMoQ3WMIeHq+TN6IwlKjkJ2TLIMyXASWtydi+gAfW3
 QceeigXw+UH+GwG2Es33zcPm+4o=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa0a24.7fedd81f86f8-smtp-out-n03;
 Wed, 18 Dec 2019 11:14:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5039C4479C; Wed, 18 Dec 2019 11:14:43 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6990DC433CB;
        Wed, 18 Dec 2019 11:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6990DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V3 5/9] ath11k: add WMI calls to manually
 add/del/pause/resume TWT dialogs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213153839.12372-6-john@phrozen.org>
References: <20191213153839.12372-6-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218111443.E5039C4479C@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 11:14:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> These calls are used for debugging and will be required for WFA
> certification tests.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This had two warnings, fixed in pending branch:

drivers/net/wireless/ath/ath11k/wmi.c:2625: quoted string split across lines
drivers/net/wireless/ath/ath11k/wmi.c:2626: quoted string split across lines

-- 
https://patchwork.kernel.org/patch/11290749/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
