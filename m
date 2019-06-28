Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAE75A4EF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 21:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfF1TNY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 15:13:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39488 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfF1TNY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 15:13:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF14660909; Fri, 28 Jun 2019 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561749203;
        bh=V3e8RLwz8lc/MJnEgI1dytrXcoNcPY+04lyxkFAkiXg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HSIzG3HGRNv6zARH8N1dmIktTeUcqg95CebPc5ohSU3prPfjU174odcQ2zYZzx0m+
         6KoNswJl0tfD16DVbctyVq4HkBu3jsnXaS6uw/5jDqq+D0wysIBJpq0zFNscf5GxVe
         V2dB8L2q3GPVqru+KheBFSQV3vVXbdYNWbANH0h0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 885146070D;
        Fri, 28 Jun 2019 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561749203;
        bh=V3e8RLwz8lc/MJnEgI1dytrXcoNcPY+04lyxkFAkiXg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=K8uMNRlwj3PzgaDsLTG85ib0AUJJ1mzR2Rx9SZdfDeLc3MjpmOQL8h3kRjWxKo8SY
         g4BV02+j+YhOjPCP1barSEPHB26xg34PxQcZqnHsJqkwF3dBvzOE9zJktZXC1rc9KO
         t/JVsklCiPLupVNYUopuu52rIL3dvOoVbyM+srys=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 885146070D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: destroy sdio workqueue while remove sdio module
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1561515940-13748-1-git-send-email-wgong@codeaurora.org>
References: <1561515940-13748-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190628191323.BF14660909@smtp.codeaurora.org>
Date:   Fri, 28 Jun 2019 19:13:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> The workqueue need to flush and destory while remove sdio module,
> otherwise it will have thread which is not destory after remove
> sdio modules.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

3ed39f8e747a ath10k: destroy sdio workqueue while remove sdio module

-- 
https://patchwork.kernel.org/patch/11016767/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

