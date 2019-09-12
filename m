Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65513B120E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 17:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfILPWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 11:22:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732699AbfILPWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 11:22:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 58DEB60721; Thu, 12 Sep 2019 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568301744;
        bh=xJW5vnSW0xtpqAmoxihKdTOOdXupf7C9bR/J2VrocSs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=J9kH0+6J7qLn3hMbqrafmASVQ98ZxM6LgCSfUBXWJhYS6dkFOK64jTZ6Becty0vMt
         Iuq5qAQAN3fYIInZRs4iV0DNLdIBhSlShTH1XWtw4MlgGu1OejRrqIegPsNwb29LMZ
         iSv0khwZvPrlbl1zuiHBXzL+MoHc7wGvjr8so3js=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12B5C602C3;
        Thu, 12 Sep 2019 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568301744;
        bh=xJW5vnSW0xtpqAmoxihKdTOOdXupf7C9bR/J2VrocSs=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=VYMuGG0tt8gbPMwiaNCrdOrzgetOmN6BPGxXui9Q5uXzmC1Eez8PjiLbFWT8ZHK93
         d56Yo9oXaolTqs/KodHqnxmX5vIg4eiKiclCyl9JAmxg6q7IgMR/B5Q58Q+RmaB6qr
         dLzUq1YPVwrnjlq0n/Np6fDKzo9FgduIJMPzJYvk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12B5C602C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/11] wil6210: add support for pci linkdown recovery
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1567931575-27984-3-git-send-email-merez@codeaurora.org>
References: <1567931575-27984-3-git-send-email-merez@codeaurora.org>
To:     Maya Erez <merez@codeaurora.org>
Cc:     Maya Erez <merez@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190912152224.58DEB60721@smtp.codeaurora.org>
Date:   Thu, 12 Sep 2019 15:22:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maya Erez <merez@codeaurora.org> wrote:

> Some platforms can notify on pci linkdown events.
> Add pci linkdown recovery flow, invoked upon pci linkdown
> notification.
> A new wil6210 status flag is added, wil_status_pci_linkdown, to
> prevent pci suspend / resume until the recovery is completed.
> After the pci link is recovered in the platform pci recovery
> callback the device is being reset and the interface and AP
> mode states are restored.
> 
> Signed-off-by: Maya Erez <merez@codeaurora.org>

Dropping per Maya's request

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11136843/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

