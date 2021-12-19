Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A1147A089
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 13:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhLSMzA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 07:55:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49890 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhLSMzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 07:55:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E050B80CE6
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 12:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25D9C36AE0;
        Sun, 19 Dec 2021 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639918497;
        bh=Y5kd+4SfpDfoxYFfH0CmbOJ6COreTl+8I3sV54F9TSc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nGEPN8AedNPHZ4u787jTmsDyJ6i82OZwSyIg5KwiANE8SBZE13gtqDET1G8eJeTkj
         QdmL1Ks8PmVmzqDaRTPzu0O0lT4C49htHbQz+FWPRdeVcu+t0D9FpgcU0K2g9bpdOe
         a0x5GEt2rWMpAZG7iDswyjXL1z6ML+o/7DuPGxflz1/L5oYOWjnwQXEWXeSdA942vA
         kN67FIsV+7Bd8NwVY7gdEacbYP94MTpNzqO6gcJXn5oHqSlVjFqg+lb3IFf6awPfcs
         u3Dr4q3dlUYsBGGp3xmyRqeN/2Qy0fUw9keV/98543jcIa3zrFPEr8KfY3Jd69zrHy
         +uKAJ1wF1KdsQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-12-18
In-Reply-To: <de61c750-8580-c453-4c33-c1b71d818a71@nbd.name> (Felix Fietkau's
        message of "Sat, 18 Dec 2021 11:51:58 +0100")
References: <de61c750-8580-c453-4c33-c1b71d818a71@nbd.name>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Sun, 19 Dec 2021 14:54:52 +0200
Message-ID: <87a6gwbvqb.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my updated pull request for 5.17
>
> - Felix
>
> The following changes since commit f75c1d55ecbadce027fd650d3ca79e357afae0d9:
>
>   Merge tag 'wireless-drivers-next-2021-12-17' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-12-17 07:30:07 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-12-18
>
> for you to fetch changes up to a2a218b674cdbab132be5ed99cc2af06c4ff8cb8:
>
>   mt76: mt7921s: fix cmd timeout in throughput test (2021-12-18 11:48:02 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.17
>
> * decap offload fixes
> * mt7915 fixes
> * mt7921 fixes
> * eeprom fixes
> * powersave handling fixes
> * SAR support
> * code cleanups
>
> ----------------------------------------------------------------

This fails to build:

drivers/net/wireless/mediatek/mt76/debugfs.c: In function 'mt76_rx_queues_read':
drivers/net/wireless/mediatek/mt76/debugfs.c:84:31: error: 'queued' undeclared (first use in this function)
   84 |                            i, queued, q->head, q->tail);
      |                               ^~~~~~

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
