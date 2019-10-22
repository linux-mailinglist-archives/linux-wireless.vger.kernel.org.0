Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B869DFE81
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 09:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbfJVHlC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 03:41:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387614AbfJVHlC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 03:41:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 90833607EF; Tue, 22 Oct 2019 07:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571730061;
        bh=QuqBvyXmiPRZUq96WqDG8E3ujBoX/SM0M39BxLLd+CA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hwvM43KBXyUq2gGX5IJXUWNadrPUxvPPxp3nacmjsxppWVuxZbZ3oSqsn0VSRBiGd
         EyWhQbAUwpG+ZDIg6aMk7CVDiHjbW1eBFMHwHIbyy05NVPnDRTM0fApesp7hMUZ4gS
         ZybhB18+EL6rOEK6SwlUsG5YqwSd0NyotlzJTWtA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB4936039C;
        Tue, 22 Oct 2019 07:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571730060;
        bh=QuqBvyXmiPRZUq96WqDG8E3ujBoX/SM0M39BxLLd+CA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=aRUr+1tmkVkgtfJVj1C0qcMOjvtpQK7UV3ncGegSqDSzW8V6CjQuipglDxGUPoh5p
         fgRUaNLx5P4soc9UGTYxb0UX25zQ79t6z5SpN/zgnpGWr4bcSdVP3khC2TNuawo7mG
         TtZ5qVArZCcQi0J4rKX622/dVtZ9mqfgT/WkS21E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB4936039C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/2] ath10k: Enable Airtime-based Queue Limit (AQL)
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191011022413.176208-3-kyan@google.com>
References: <20191011022413.176208-3-kyan@google.com>
To:     Kan Yan <kyan@google.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, ath10k@lists.infradead.org, yiboz@codeaurora.org,
        Kan Yan <kyan@google.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191022074101.90833607EF@smtp.codeaurora.org>
Date:   Tue, 22 Oct 2019 07:41:01 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> wrote:

> Calculate the estimated airtime pending in the txqs and apply AQL to
> prevent excessive amounts of packets being queued in the firmware queue.
> 
> Signed-off-by: Kan Yan <kyan@google.com>

Dropped per Kan's and Toke's comment:

https://lkml.kernel.org/r/878speqh75.fsf@toke.dk

Patch set to Rejected.

-- 
https://patchwork.kernel.org/patch/11184783/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

