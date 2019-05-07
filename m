Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F405016556
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfEGOEY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 10:04:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfEGOEY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 10:04:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C1A076016D; Tue,  7 May 2019 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557237863;
        bh=Rh2Tb9urtGdokt8As1N1nKrD1+2/gAmYvJ/otuz1q7k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YbZrBmPSWNqypS0/n3YVqCzBs+FoTHC3m9TDZqFOzA9xLrmAci9nWIcmH+Jd89SBB
         RoxXcBdoGeUQRWu2pKjgrcNpowcOJJ1TQ7U9K+lWWSL7FNmvjEPjuv2sdpvd131s7C
         SXHG9foVBnVywWOBDgRLcPX+dRpSgBMogLhXQtdY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7C7E60350;
        Tue,  7 May 2019 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557237863;
        bh=Rh2Tb9urtGdokt8As1N1nKrD1+2/gAmYvJ/otuz1q7k=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=giYbXG1QioGxoB6xlpg3U/TJw8iZmWOvvyIimkrV+zD3XAzhApT868BbyqY4GzS1H
         J1UNhR3qzldt2OUU/rHX+L457FEhZKrjc1fXdIRiVW9mOXcHjDzyoJ4McdMOLVFAjR
         vSCdxy5YplTpfENQgOwkJLZHuEtxOiETPdbj715M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7C7E60350
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Check tx_stats before use it
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1556804210-28599-1-git-send-email-yintang@codeaurora.org>
References: <1556804210-28599-1-git-send-email-yintang@codeaurora.org>
To:     Yingying Tang <yintang@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190507140423.C1A076016D@smtp.codeaurora.org>
Date:   Tue,  7 May 2019 14:04:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yingying Tang <yintang@codeaurora.org> wrote:

> tx_stats will be freed and set to NULL before debugfs_sta node is
> removed in station disconnetion process. So if read the debugfs_sta
> node there may be NULL pointer error. Add check for tx_stats before
> use it to resove this issue.
> 
> Signed-off-by: Yingying Tang <yintang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9e7251fa3897 ath10k: Check tx_stats before use it

-- 
https://patchwork.kernel.org/patch/10926861/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

