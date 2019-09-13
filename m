Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CE5B2154
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391742AbfIMNpH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 09:45:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388489AbfIMNpH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 09:45:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E0AC7601C3; Fri, 13 Sep 2019 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568382305;
        bh=ADAqA+whk9w0uC3vat1A4dogJzHi6GhWR1q6R+KlqbE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Mv5EQRF+2icBxLcVdL3hWvzuWSHJUKX+icoHEpcFsKEz/gmkaugUuGDrsDqBlKpAo
         MW+1ryZavunSzj4lrVRVx2he/5kgpASn8ixy494tJCbLJ7SaZmNa9b/64FCUrTRTHd
         udqTs7uXADwX/SNo3+je8RIGTfD+no7olbmpxh1o=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBEAE602C3;
        Fri, 13 Sep 2019 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568382304;
        bh=ADAqA+whk9w0uC3vat1A4dogJzHi6GhWR1q6R+KlqbE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=lO449eYqECj0tX0nxq5RHUcGQnAzKv/NnU8sxJd8dSMbVeJUqfyJKqg9+VBWXJOSV
         LwKMs7jNPhJHf0DdZfYWxp1pjmcTMHhSZCbblwgHKfD+E1LysD8xqBIwiamySYeY6n
         TvHZ+7/qqUz2PEKqlWLsxQiDy44Yz34J4SsqF+fc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBEAE602C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: make arrays pwr_info_offset and sprom_sizes static
 const, shrinks object size
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190905162049.14333-1-colin.king@canonical.com>
References: <20190905162049.14333-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190913134505.E0AC7601C3@smtp.codeaurora.org>
Date:   Fri, 13 Sep 2019 13:45:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Arrays pwr_info_offset and sprom_sizes can be make static const rather
> than populating them on the stack. Shrinks object size by 236 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   11300	   1320	     64	  12684	   318c	drivers/bcma/sprom.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   10904	   1480	     64	  12448	   30a0	drivers/bcma/sprom.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

c57391f41572 bcma: make arrays pwr_info_offset and sprom_sizes static const, shrinks object size

-- 
https://patchwork.kernel.org/patch/11133647/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

