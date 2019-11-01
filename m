Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E046EBE88
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 08:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfKAHlf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 03:41:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbfKAHlf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 03:41:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8553160A7E; Fri,  1 Nov 2019 07:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572594094;
        bh=IsvKLHshSHQY3ManjGVgRyLXMN/xgVVz/9MwCZplqXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A7vKwM2JjSnKbvwKhPT1ykpz/87X0jbgO2qsBGt0+FPG6c68lWfB6/sZJ9WXRWvf5
         FBS0HQCUWH4Hpt27/KqWfuEwmHLX5SLLojFu5AZqk0MtpMzk8cp02AXU2reAcD+gjp
         WTr7bW5XnkEBD9woATiAaavVLc7LMlBY7GPRkXA0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1D8D960A03;
        Fri,  1 Nov 2019 07:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572594094;
        bh=IsvKLHshSHQY3ManjGVgRyLXMN/xgVVz/9MwCZplqXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A7vKwM2JjSnKbvwKhPT1ykpz/87X0jbgO2qsBGt0+FPG6c68lWfB6/sZJ9WXRWvf5
         FBS0HQCUWH4Hpt27/KqWfuEwmHLX5SLLojFu5AZqk0MtpMzk8cp02AXU2reAcD+gjp
         WTr7bW5XnkEBD9woATiAaavVLc7LMlBY7GPRkXA0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Nov 2019 15:41:34 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v6 2/3] ath10k: change max RX bundle size from 8 to 32 for
 sdio
In-Reply-To: <87y2x11dsr.fsf@kamboji.qca.qualcomm.com>
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
 <1569402639-31720-3-git-send-email-wgong@codeaurora.org>
 <87h83ysbjy.fsf@kamboji.qca.qualcomm.com>
 <73e2d996575023b14c24665b2607a5b3@codeaurora.org>
 <87y2x11dsr.fsf@kamboji.qca.qualcomm.com>
Message-ID: <dbc1ae9bbe59904910b7fe9a6bb67c9b@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-31 17:09, Kalle Valo wrote:

>> I will test the 3 patches.
> 
> Did you have a chance to test them? Do note that I did one minor change
> today:
Kalle,
Yes, I will test the 7 patches together later.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=28da1fe7a3ffa5c55c52328c21165d9efdf2e94c
