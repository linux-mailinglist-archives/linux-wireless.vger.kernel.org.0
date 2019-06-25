Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45F54F81
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 15:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfFYNAq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 09:00:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfFYNAq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 09:00:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ACEDB60312; Tue, 25 Jun 2019 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467645;
        bh=l1ftwfLHJSnmxo9eNQhQI7nfLkar2T3uSvhlFW2ynL4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WcCZVsvhDeatju/DcxVxe+2WffICy1m0yPEl+cKmpAfr6Jpd39QhY6sggYGaBAt6x
         dC5AWPOdS+82dLoW0mibvk7NsBSTyr622yoKZGG8R8xoY6jHo/ItnbIGoWJxXav0W0
         y17ojP4qCS4BP3Pyf3JgEKRot6anJDwk6nUEqX20=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A00916019D;
        Tue, 25 Jun 2019 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467645;
        bh=l1ftwfLHJSnmxo9eNQhQI7nfLkar2T3uSvhlFW2ynL4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=gNemgL90Yn1+T04AKPx0XrSd2vGag8XT0zAwDzrkYSx3q9PxF7X33LKBVfX0nK3ma
         /mb4o/UvIMbmi6uqQ1jPrc3l+h2fWYUzWgqQMzu4DsWjvlliyvi+WtqWosbpGGjavZ
         wfd5rZ97oczVlhjIpGOmneUi88oKRdRRzK00lbU0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A00916019D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Change the warning message string
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190509121500.4730-1-festevam@gmail.com>
References: <20190509121500.4730-1-festevam@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     ath10k@lists.infradead.org, andreyknvl@google.com,
        gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625130045.ACEDB60312@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 13:00:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fabio Estevam <festevam@gmail.com> wrote:

> The "WARNING" string confuses syzbot, which thinks it found
> a crash [1].
> 
> Change the string to avoid such problem.
> 
> [1] https://lkml.org/lkml/2019/5/9/243
> 
> Reported-by: syzbot+c1b25598aa60dcd47e78@syzkaller.appspotmail.com
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

265df32eae58 ath10k: Change the warning message string

-- 
https://patchwork.kernel.org/patch/10937077/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

