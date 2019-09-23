Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 643C6BB2A4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393674AbfIWLKr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 07:10:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393480AbfIWLKr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 07:10:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE45F602F8; Mon, 23 Sep 2019 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569237046;
        bh=NS8r6+bC+2MSJe533xfyqMZy190jcWVuvxxcEET6yPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pI5m/8FuCyIXHiDaCfzE1gitCXqccg/ok/5GTT+wzxxlw07l+Xm6X41T/Cs6pOJv2
         r3+SoQXg5kJ5iVj8CWaUcM+yn48rEaO1/2/cevv28UsAlw3jgtYhvZ0+4hLL57wUc6
         Frn2laL2wJ0jK3mOZAYjGVHgatITWlHvSu8G4Y5k=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5B681601D4;
        Mon, 23 Sep 2019 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569237046;
        bh=NS8r6+bC+2MSJe533xfyqMZy190jcWVuvxxcEET6yPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pI5m/8FuCyIXHiDaCfzE1gitCXqccg/ok/5GTT+wzxxlw07l+Xm6X41T/Cs6pOJv2
         r3+SoQXg5kJ5iVj8CWaUcM+yn48rEaO1/2/cevv28UsAlw3jgtYhvZ0+4hLL57wUc6
         Frn2laL2wJ0jK3mOZAYjGVHgatITWlHvSu8G4Y5k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Sep 2019 19:10:46 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: add fw coredump for sdio when firmware assert
In-Reply-To: <87zhixamyp.fsf@codeaurora.org>
References: <1567132338-7407-1-git-send-email-wgong@codeaurora.org>
 <87zhixamyp.fsf@codeaurora.org>
Message-ID: <b8298efd20f3d05a38866b687f597c30@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-21 19:49, Kalle Valo wrote:

> After looking more closely, the ar->bmi.done_set checks in bmi.c does
> not look necessary to me, I have never seen that warning. I would 
> remove
> those and the done_sent field altogether from ath10k to make the code
> cleaner and I avoid hacks like above. This should be done in a separate
> patch, of course.

so I will use it this patch :)
