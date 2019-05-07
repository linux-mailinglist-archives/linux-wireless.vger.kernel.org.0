Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12E1652D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 15:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfEGNzU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 09:55:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34136 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEGNzT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 09:55:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 202CF61340; Tue,  7 May 2019 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557237318;
        bh=FzVrmAEM0SCeTZL/lLnMcxA7vw2vfgD3XNlbsC95Wao=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FeNjJrZHijmRY8+cn/LirBqZVFSz526WDjd0tTXMXjiZVjy8UXxhFpEihFLxZXb2U
         X8f8KmyiF/k5pYOr35rAtaXijLF8iUBBt1ANDDjswv+2m2Kb/u2H5YBk6m/h+gPG4D
         0CAB1f3vXyIYkOuzJENWe591pqHtQsxRdHu4oGi4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 361AC60CEC;
        Tue,  7 May 2019 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557237316;
        bh=FzVrmAEM0SCeTZL/lLnMcxA7vw2vfgD3XNlbsC95Wao=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=OiDyL1sZ1dAUqrTnZ1LiBIXYxpdw8DT4IvY9Jg0FUQ3EIHqXP2YITFwr3zIoKFF+m
         U+oX5dpBogLLC+rN85L6ayi9Pg02ReCKKTGjzQmuYyrd6i71lTg2flYcEApX44g47i
         WklqMb7mp6FheCPf2jwmwnApMIUL9bVmEGjSIk0A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 361AC60CEC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix the wrong value of enums for wmi tlv stats id
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1554792193-22535-1-git-send-email-svishnoi@codeaurora.org>
References: <1554792193-22535-1-git-send-email-svishnoi@codeaurora.org>
To:     Surabhi Vishnoi <svishnoi@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Surabhi Vishnoi <svishnoi@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190507135518.202CF61340@smtp.codeaurora.org>
Date:   Tue,  7 May 2019 13:55:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Surabhi Vishnoi <svishnoi@codeaurora.org> wrote:

> The enum value for WMI_TLV_STAT_PDEV, WMI_TLV_STAT_VDEV
> and WMI_TLV_STAT_PEER is wrong, due to which the vdev stats
> are not received from firmware in wmi_update_stats event.
> 
> Fix the enum values for above stats to receive all stats
> from firmware in WMI_TLV_UPDATE_STATS_EVENTID.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
> 
> Fixes: f40a307eb92c ("ath10k: Fill rx duration for each peer in fw_stats for WCN3990)
> Signed-off-by: Surabhi Vishnoi <svishnoi@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9280f4fc06f4 ath10k: Fix the wrong value of enums for wmi tlv stats id

-- 
https://patchwork.kernel.org/patch/10890577/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

