Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5FBABA55
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 16:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392650AbfIFOJ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 10:09:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388731AbfIFOJ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 10:09:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01290611FD; Fri,  6 Sep 2019 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567778965;
        bh=KSJpt9scN4yU1PTl/pWE/qpGUaJDYlS33aeVkCOmrkc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DH8r0WMHvwvKvOFeQjbtLQUdgem93LxqCKMd3779rTNbdloje6ih5FXNbDhlCx6eR
         L9UOuUqZOElDUAvLIWVbp0SoxJKWj1veVXzwMT1S+V3M4ograHd2g7tVeflnsMww4q
         sQwQD+XQhTcb5/9tPeJ4cYpu7zZZmgHJl1gBbdzw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9E976115A;
        Fri,  6 Sep 2019 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567778964;
        bh=KSJpt9scN4yU1PTl/pWE/qpGUaJDYlS33aeVkCOmrkc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=m/FTmyOOJxcKZgRm0ygG7HuYWdo8tHU+vSXNgSjP5coXzn0yUP6QXDTWWgIga5762
         bPU+5EhdozMuZ/wdND0EyoAzEX4bSKG45crUby8AtxrXJst2KCc7RVeLlq0hxAa5db
         UNIdQylHsajeMo+DtnnF9KaQeEb3VSXX6g9mQwco=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9E976115A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 1/2] brcmfmac: add stub version of
 brcmf_debugfs_get_devdir()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190901113436.23665-1-zajec5@gmail.com>
References: <20190901113436.23665-1-zajec5@gmail.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190906140925.01290611FD@smtp.codeaurora.org>
Date:   Fri,  6 Sep 2019 14:09:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> In case of compiling driver without DEBUG expose a stub function to make
> writing debug code much simpler (no extra conditions). This will allow
> e.g. using debugfs_create_file() without any magic if or #ifdef.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

2 patches applied to wireless-drivers-next.git, thanks.

cb34212b1c25 brcmfmac: add stub version of brcmf_debugfs_get_devdir()
2f8c8e62cd50 brcmfmac: add "reset" debugfs entry for testing reset

-- 
https://patchwork.kernel.org/patch/11125179/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

