Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD86B21D5
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfIMOXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 10:23:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfIMOXg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 10:23:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C25DF607F1; Fri, 13 Sep 2019 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568384615;
        bh=zWlfvzD0O5IBrdDw1HOpbbjEiZ8kkIkXWCZbeIhl/U4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=O47+liZeya1C/CrzL3K0ZaidYHOi8U2XU3wG5qYYrObcm11hxJFNkbpwa57lAE8Ca
         A0MXwPjqKr5OhilBSJli5w6f7KaIwRRrPePDXGJI+a3Hwhl5BySuigqFs2gZ7gLrYY
         CAHNQN5cU6Gurvyh9Nw3KHgFLS2/a0beqBA867AQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD91760769;
        Fri, 13 Sep 2019 14:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568384615;
        bh=zWlfvzD0O5IBrdDw1HOpbbjEiZ8kkIkXWCZbeIhl/U4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Jlm9fbzUEHDDsoJtyC+3fOOBQnXB+kCtUffKNOvsyx92KQUaNZvB4Y2VNDH04JH3z
         EQNrpyMWG0smO65fC5ilEsp/0bnE8ZnLvLhOJi6XZ3CCk/gY3nFHHDUUWNobInUsjo
         Lt33+tknuOdlMn8VyhL+ZV9Zi7P2q61Ix6Mj50Bo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD91760769
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ssb: make array pwr_info_offset static const,
 makes object smaller
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190906154053.32218-1-colin.king@canonical.com>
References: <20190906154053.32218-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190913142335.C25DF607F1@smtp.codeaurora.org>
Date:   Fri, 13 Sep 2019 14:23:35 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array pwr_info_offset on the stack but instead make it
> static const. Makes the object code smaller by 207 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   26066	   3000	     64	  29130	   71ca	drivers/ssb/pci.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   25763	   3096	     64	  28923	   70fb	drivers/ssb/pci.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Michael Büsch <m@bues.ch>

Patch applied to wireless-drivers-next.git, thanks.

d3bb26868105 ssb: make array pwr_info_offset static const, makes object smaller

-- 
https://patchwork.kernel.org/patch/11135599/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

