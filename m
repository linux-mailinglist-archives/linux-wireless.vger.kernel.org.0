Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6BADB1B85
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 12:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfIMKYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 06:24:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfIMKYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 06:24:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 64B6F607F1; Fri, 13 Sep 2019 10:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568370264;
        bh=e3i7LyjuZoefOpU7WVotbY1n6ppk4QBWqYZmO0jebRw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=G6gWT1uHuQglHPrlF7/jNSR+fUWSgNQ822rOwFWErV0/VyLzEd5CyawbTEnOtkBzv
         3+FDnjDJxLFJ1dde/CpWS/cNd+P3ZP0MdRiVrt052/A4CoZY4KE694RU8Y23P6zals
         buAOerNwBRFwbdBK9NF1Oj7ow3GXEc/icKD8sxss=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2902B60452;
        Fri, 13 Sep 2019 10:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568370263;
        bh=e3i7LyjuZoefOpU7WVotbY1n6ppk4QBWqYZmO0jebRw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KE80GEMIFcJByUc7qM0yi5mFKldZ9TzLhX2HRbpBpdRAbEeHgd5JUbfcws9YLqrJH
         pb8noQYflSYxj4cozcJqZV/ZwQ3WRu2AJeg8y4CgPhp1XIX8KfVq+HS6iHkxCpFtgP
         K5R4Nw+rDLtKKlqXGCtPnBfztZK6/LK9bomJYzr8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2902B60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     James Prestwood <prestwoj@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC 0/4] Allow live MAC address change
References: <20190904191155.28056-1-prestwoj@gmail.com>
        <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
        <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
        <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
        <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
Date:   Fri, 13 Sep 2019 13:24:20 +0300
In-Reply-To: <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com> (James
        Prestwood's message of "Wed, 11 Sep 2019 12:20:55 -0700")
Message-ID: <87a7b8lciz.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

James Prestwood <prestwoj@gmail.com> writes:

> I know 3ms doesn't seems like a lot but everything counts and from my
> testing this is even a further 20% improvement to doing so with RTNL.
> Plus the added simplicity to the userspace code/API. We have taken a
> lot of time to optimize IWD's connection times, and everything counts.
> The connection times are fast already, but when there is room for
> improvement we will push for it, especially in situations like this
> when the change is quite minimal and does not introduce much
> complexity.

So what kind of _total_ connection times you get now?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
