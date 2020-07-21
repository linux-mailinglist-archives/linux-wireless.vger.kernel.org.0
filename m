Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ADD228BBD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgGUVzA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jul 2020 17:55:00 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:19430 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbgGUVzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jul 2020 17:55:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595368499; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=cTVnp84kHulZAyJfBfdGXQ0sjsqMEUuo2dnBObkq9Vk=;
 b=eX7hbHZHBzf63EOp2/WAk55yFXTsSl5AjMobeutAHwXLBuJeAdBlL3pCClUnj4DuHAJzSACF
 CSYkGfQTaroRg+GKpCN7ZEuoozOEjr9Xp8x92Z7sH9M0M0fMTrAX5tI0YslWPMs4fNjaR9hb
 XPyBZfcQ6hLfgjCBmHKXnZSkKMQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f1763d01e603dbb4422667a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Jul 2020 21:53:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6D69C4339C; Tue, 21 Jul 2020 21:53:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E8F3C433C9;
        Tue, 21 Jul 2020 21:53:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 21 Jul 2020 14:53:19 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvalo@codeaurora.org,
        johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org, linux-wireless-owner@vger.kernel.org
Subject: Re: [RFC 2/7] ath10k: Add support to process rx packet in thread
In-Reply-To: <1595351666-28193-3-git-send-email-pillair@codeaurora.org>
References: <1595351666-28193-1-git-send-email-pillair@codeaurora.org>
 <1595351666-28193-3-git-send-email-pillair@codeaurora.org>
Message-ID: <13573549c277b34d4c87c471ff1a7060@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-07-21 10:14, Rakesh Pillai wrote:
> NAPI instance gets scheduled on a CPU core on which
> the IRQ was triggered. The processing of rx packets
> can be CPU intensive and since NAPI cannot be moved
> to a different CPU core, to get better performance,
> its better to move the gist of rx packet processing
> in a high priority thread.
> 
> Add the init/deinit part for a thread to process the
> receive packets.
> 
IMHO this defeat the whole purpose of NAPI. Originally in ath10k
irq processing happened in tasklet (high priority) context which in
turn push more data to net core even though net is unable to process
driver data as both happen in different context (fast producer - slow 
consumer)
issue. Why can't CPU governor schedule the interrupts in less loaded CPU 
core?
Otherwise you can play with different RPS and affinity settings to meet 
your
requirement.

IMO introducing high priority tasklets/threads is not viable solution.

-Rajkumar
