Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9126DE568
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 16:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfD2Owi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 10:52:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfD2Owi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 10:52:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D162E60E41; Mon, 29 Apr 2019 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556549557;
        bh=Wjq2h5vre5y0bW0Mr5l5Eu4XzsvQkhOSmyWFDH05/FU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kYg68XXha727rDxtd5IdOppPors0vlewjmaPwbohlATg9DPqBv9qJdWYiDaKbJQ21
         ZoVZ17AA/0i0QhZHs8CvQ8D/cSKVisU8cdj5qey4IlsAWd72DucnqMCWtDqbImgbks
         XskkB3y3v5NI5mcfuKQFUOYHoenMSHm5paEqXF4c=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8D67605A2;
        Mon, 29 Apr 2019 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556549555;
        bh=Wjq2h5vre5y0bW0Mr5l5Eu4XzsvQkhOSmyWFDH05/FU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=AahlZjU1YiDWu2rDT4H7hUmAMySaH1kdGujraYz15Eqt1v7npeXTeYjVzhxUbqJ8e
         pLcHYtCnDMd6AXIb6Og84J4Kvg/tPQEqnMxeYbVH0dwI+GX7yuIliaNwpb4EiY9O7A
         tEk77Rps2I062V73ol1v4ifbvQcDHpvTBKpa5Pj0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8D67605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath9k: Don't trust TX status TID number when reporting
 airtime
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190307183944.11190-1-toke@redhat.com>
References: <20190307183944.11190-1-toke@redhat.com>
To:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Miguel Catalan Cid <miguel.catalan@i2cat.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190429145236.D162E60E41@smtp.codeaurora.org>
Date:   Mon, 29 Apr 2019 14:52:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke Høiland-Jørgensen wrote:

> As already noted a comment in ath_tx_complete_aggr(), the hardware will
> occasionally send a TX status with the wrong tid number. If we trust the
> value, airtime usage will be reported to the wrong AC, which can cause the
> deficit on that AC to become very low, blocking subsequent attempts to
> transmit.
> 
> To fix this, account airtime usage to the TID number from the original skb,
> instead of the one in the hardware TX status report.
> 
> Reported-by: Miguel Catalan Cid <miguel.catalan@i2cat.net>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

389b72e58259 ath9k: Don't trust TX status TID number when reporting airtime

-- 
https://patchwork.kernel.org/patch/10843731/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

