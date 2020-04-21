Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB4F1B2194
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgDUI3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 04:29:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:32221 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727891AbgDUI3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 04:29:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587457771; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=v17CtKm6osaSN2ILKAtQCmOwQerCKJS1+8XxWCRJxX0=; b=lMkjHjWiuGgmZyYM6Pmc9Z/g1LwW3trsFHoqkjGZ0OZghfg2LfjVjgbBH4XfQDwz9AkHvTEy
 uLAJC3eY/R+XbSJ6LjnLl1EWLjUccg4N60bBAyQRxfIznNyVtFuwK0h406QulAchOBMGkP67
 xkHaR6+083c5w++8KPlCps6CNhQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9eaedf.7f618aad6ce0-smtp-out-n05;
 Tue, 21 Apr 2020 08:29:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24F16C433F2; Tue, 21 Apr 2020 08:29:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E49DC433D2;
        Tue, 21 Apr 2020 08:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E49DC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     RazB <r-Bouganim@ti.com>
Cc:     <linux-wireless@vger.kernel.org>, <d-levy@ti.com>
Subject: Re: [PATCH] wlcore: Adding suppoprt for IGTK key in wlcore driver
References: <1587389390-29407-1-git-send-email-r-Bouganim@ti.com>
Date:   Tue, 21 Apr 2020 11:29:14 +0300
In-Reply-To: <1587389390-29407-1-git-send-email-r-Bouganim@ti.com> (RazB's
        message of "Mon, 20 Apr 2020 16:29:50 +0300")
Message-ID: <87d081p7hh.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RazB <r-Bouganim@ti.com> writes:

> [PATCH] wlcore: Adding suppoprt for IGTK key in wlcore driver
> This patch adding support for new cipher suite - AES-CMAC in wlcore driver.
> This patch is required for support PMF/WPA3 connection to install IGTK key.
>
> Signed-off-by: RazB <r-Bouganim@ti.com>

Is your legal full name really "RazB"?

Also this patch looks have formatting issues. Please use checkpatch and
other tools verify that the patch is correct. More info in the link
below.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
