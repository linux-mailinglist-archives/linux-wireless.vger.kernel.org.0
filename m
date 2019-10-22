Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12766E004A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfJVJHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 05:07:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41604 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfJVJHT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 05:07:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4DED86078F; Tue, 22 Oct 2019 09:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571735239;
        bh=ApUGZYgh33UJoQCW+BZQrwxQct95D/UJnMmb5Z+Q1Gw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GGNBnuy2oMDhg1KBIMGtuPCqoivNZ/Ukbv3zCDmQBINiEkQU6ana443MLI8l3E46K
         pa/EQr5eFpBlmzxLYGoAWpXpYD3EAZ4FqrAPE5GG+KMqkrwriFTrEwQYWVb0OPfVVJ
         dEdaZf5nZ69daOIQ2WwzAQzUtjDbqNaVBCSbxGgQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 420046050D;
        Tue, 22 Oct 2019 09:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571735239;
        bh=ApUGZYgh33UJoQCW+BZQrwxQct95D/UJnMmb5Z+Q1Gw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GGNBnuy2oMDhg1KBIMGtuPCqoivNZ/Ukbv3zCDmQBINiEkQU6ana443MLI8l3E46K
         pa/EQr5eFpBlmzxLYGoAWpXpYD3EAZ4FqrAPE5GG+KMqkrwriFTrEwQYWVb0OPfVVJ
         dEdaZf5nZ69daOIQ2WwzAQzUtjDbqNaVBCSbxGgQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 420046050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ryan Adolf <ryanadolf123@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iw: Fix typo in iw --help
References: <79e3b9aba5159d1e7fbf908af6621e9d0fdb57fd.camel@gmail.com>
Date:   Tue, 22 Oct 2019 12:07:16 +0300
In-Reply-To: <79e3b9aba5159d1e7fbf908af6621e9d0fdb57fd.camel@gmail.com> (Ryan
        Adolf's message of "Tue, 22 Oct 2019 01:07:09 -0700")
Message-ID: <8736flf8sb.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryan Adolf <ryanadolf123@gmail.com> writes:

> Signed-off-by: Ryan Adolf <ryanadolf123@gmail.com>
> ---
>  event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/event.c b/event.c
> index 100f644..4a932d1 100644
> --- a/event.c
> +++ b/event.c
> @@ -1172,5 +1172,5 @@ static int print_events(struct nl80211_state *state,
>  TOPLEVEL(event, "[-t|-r] [-f]", 0, 0, CIB_NONE, print_events,
>  	"Monitor events from the kernel.\n"
>  	"-t - print timestamp\n"
> -	"-r - print relative timstamp\n"
> +	"-r - print relative timestamp\n"
>  	"-f - print full frame for auth/assoc etc.");

Thanks, look good. You can now follow the status in patchwork:

https://patchwork.kernel.org/patch/11203919/

But do note that maintainers are busy so sometimes it might take even
weeks before your patch is reviewed.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
