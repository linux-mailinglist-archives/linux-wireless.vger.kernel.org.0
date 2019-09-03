Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A753BA6A75
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfICNwu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:52:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICNwu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:52:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1C2760E3F; Tue,  3 Sep 2019 13:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518769;
        bh=mhhgQ7xUqeRy3wLXdfYTu2wDiYA5iUCDj77zrk+j9JQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GIRwlAXzHMQ4FZwycJEth8BCBy+u/u+wjvraVc0YDyznH/yWc/SywG62xLSitB2ib
         gf7eLLEbt8AFBieDFe0YTdiVM4lj81mCzN+KGwiezgCYDu+KE3K4NRWMVpTGXbciwd
         RBwwNMJYIOMUfLWYigEDGJ902Edotyd4KTF2GUMM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18838602EF;
        Tue,  3 Sep 2019 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518766;
        bh=mhhgQ7xUqeRy3wLXdfYTu2wDiYA5iUCDj77zrk+j9JQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=VTK3HWBdqY+ONV+64eQJ/38fl3n4NKgweZQPGATFH3zdFBqv8f7EQQ7XdgU9WymtS
         QI54AyUGaUl300Xyebwav/oTvqtIRh/5hVaV9AAAVrrYBCDUXDmMnR9PvkcD0VEooR
         MFp2JVpMTmGZVoNbE2mUqyPjdYWho+MzRpP7RlGc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18838602EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.3] Revert "rt2800: enable TX_PIN_CFG_LNA_PE_ bits per
 band"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1567078199-3645-1-git-send-email-sgruszka@redhat.com>
References: <1567078199-3645-1-git-send-email-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Mathias Kresin <dev@kresin.me>,
        Sergey Maranchuk <slav0nic0@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903135248.E1C2760E3F@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:52:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> This reverts commit 9ad3b55654455258a9463384edb40077439d879f.
> 
> As reported by Sergey:
> 
> "I got some problem after upgrade kernel to 5.2 version (debian testing
> linux-image-5.2.0-2-amd64). 5Ghz client  stopped to see AP.
> Some tests with 1metre distance between client-AP: 2.4Ghz  -22dBm, for
> 5Ghz - 53dBm !, for longer distance (8m + walls) 2.4 - 61dBm, 5Ghz not
> visible."
> 
> It was identified that rx signal level degradation was caused by
> 9ad3b5565445 ("rt2800: enable TX_PIN_CFG_LNA_PE_ bits per band").
> So revert this commit.
> 
> Cc: <stable@vger.kernel.org> # v5.1+
> Reported-and-tested-by: Sergey Maranchuk <slav0nic0@gmail.com>
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Patch applied to wireless-drivers.git, thanks.

13fa451568ab Revert "rt2800: enable TX_PIN_CFG_LNA_PE_ bits per band"

-- 
https://patchwork.kernel.org/patch/11121089/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

