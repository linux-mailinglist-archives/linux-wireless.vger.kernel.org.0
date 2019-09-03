Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1000AA6A58
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfICNtS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:49:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56658 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbfICNtS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:49:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 449E5602CA; Tue,  3 Sep 2019 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518557;
        bh=mnaFV7XJnFz6G8NXxmImCVpTBftk1UBUWzAq4JGnIco=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oenNZt/3emlnzGAyHDlLx4olOXDc4ObRDXEzuAx0cAuaOsB1ezh04CUjQ4mXcI3GI
         hFBfySfA970KdDQUEfYyA5Rr5+ODtFo2ds/pdrDp86bZsNNnEy38EblFCil0kfMJNP
         Bi/QO4pFr+wYZ93Xa0dzO09gHSL07UyUrDC0JeaM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43B85602A9;
        Tue,  3 Sep 2019 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518556;
        bh=mnaFV7XJnFz6G8NXxmImCVpTBftk1UBUWzAq4JGnIco=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=IPQrOIdc3yX7DIQhQZKShytxc/L4G24eWWANn4YUfksksdP5e5Ez5zdGOs/l/KnRa
         NqWy9xAmudS6ULa77Q9ppuF0z4K02lfhpaBiZICYmBrjyhtU2KnzwkVAz9FtVXVTf5
         okdAnFd2NpgGg5M+0sWtXr00iLsbFciOGK8dZa4I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43B85602A9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.3] mt76: mt76x0e: don't use hw encryption for MT7630E
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
References: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903134917.449E5602CA@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:49:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> Since 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
> I can observe firmware hangs on MT7630E on station mode: tx stop
> functioning after minor activity (rx keep working) and on module
> unload device fail to stop with messages:
> 
> [ 5446.141413] mt76x0e 0000:06:00.0: TX DMA did not stop
> [ 5449.176764] mt76x0e 0000:06:00.0: TX DMA did not stop
> 
> Loading module again results in failure to associate with AP.
> Only machine power off / power on cycle can make device work again.
> 
> It's unclear why commit 41634aa8d6db causes the problem, but it is
> related to HW encryption. Since issue is a firmware hang, that is super
> hard to debug, just disable HW encryption as fix for the issue.
> 
> Fixes: 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Patch applied to wireless-drivers.git, thanks.

34b0e9b767bf mt76: mt76x0e: don't use hw encryption for MT7630E

-- 
https://patchwork.kernel.org/patch/11092283/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

