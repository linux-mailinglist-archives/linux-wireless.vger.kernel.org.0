Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C59B015D013
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 03:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgBNCly (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 21:41:54 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:40746 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727879AbgBNCly (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 21:41:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581648113; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+rqY5qbMExF+ngVa5oDWoRnBVlwOwGnLGAE6LO1jv+w=;
 b=vDGNDMynXhPWPvxJrg46or/lX1sBlUO5bKm9A+gemkS5dwna42Cu2xxdzTd+ZQpibINK+cda
 IN5or38u1tk6Uw2pU1qEtg6+DZisRyR7QiI3qMxOj4YebTikW1S+WTJXZKTZ03wmqbpr4Pal
 USZe/FxmFEzWRE3U5spao3Bowkc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4608f1.7f1ee9e16a40-smtp-out-n03;
 Fri, 14 Feb 2020 02:41:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28E19C433A2; Fri, 14 Feb 2020 02:41:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5699BC43383;
        Fri, 14 Feb 2020 02:41:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Feb 2020 10:41:52 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: add retry mechanism for ath10k_start
In-Reply-To: <87mu9mwwhs.fsf@kamboji.qca.qualcomm.com>
References: <20200120025609.6060-1-wgong@codeaurora.org>
 <87mu9mwwhs.fsf@kamboji.qca.qualcomm.com>
Message-ID: <576c72fed4a15a13989dde163d77ed8c@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-02-13 19:35, Kalle Valo wrote:
> 
> I'm not convinved about this. ath10k assumes that SDIO bus works
> reliably and there's no data loss. In my opinion if the SDIO is not
> working reliably we should fail immediately with a clear error message
> for the user, instead of having an unstable connection. And I 
> understand
> from the logs that ath10k fails cleanly in this simulated failure.
> 
> So what you do here is ignore the assumption that the SDIO bus should
> always work reliably and add a workaround by trying to restart the
> firmware multiple times, and hope that by luck it works during one of 
> 10
> retry attempts. But then what? Isn't the WLAN connection flaky as SDIO
> bus is not reliable? So if we were to follow that design logic,
> shouldn't we add retries for _all_ ath10k SDIO transactions? But that
> would make ath10k even more complex as it is.
for other SDIO transfer, like data tx/rx, if it fail, the upper stack 
has
error mechanism to handle the fail.
but for ath10k_start, if it fails, especailly for recovery, then it can
not recovery again, because cfg80211_shutdown_all_interfaces, and it 
need
to reboot system to recovery wlan by test.
> 
> Because I think this patch makes things worse for the user, so I would
> like to understand the real life use case this patch is trying to fix
> and how it would help the user.
sometimes it has recovery/suspend/resume test case, it need to make sure
ath10k_start success, otherwise wlan will can not recovery unless reboot
system.
