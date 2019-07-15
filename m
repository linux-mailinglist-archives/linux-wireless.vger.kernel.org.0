Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945DD6869B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2019 11:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfGOJru (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jul 2019 05:47:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfGOJru (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jul 2019 05:47:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3DA1660F3B; Mon, 15 Jul 2019 09:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563184069;
        bh=MvzJ9SUPxAPfny0L4MoJT7DHs6A2WXr8xqGCGGeevVA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TRKTs/JW0jUZSwsyfWU4wz4tm1yTgaKuGEb0KF+qT2q5I+tkpmtYG5RcFc8VDqlTd
         LzotL9FMsgEtBbOByVSwz5TLKoOCs8KQJZtAqNJ47goGc3i3DHDZcdxCSAkyS/MwC/
         J5C5HZsq3ub7zhmw+tOepSByjt15fiJrzRDwvhXQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A49FA60E59;
        Mon, 15 Jul 2019 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563184068;
        bh=MvzJ9SUPxAPfny0L4MoJT7DHs6A2WXr8xqGCGGeevVA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=U6/vs6JjvEi6BQ86qCSPjcFJShWPeL3mdNJx1tD1bCARPugDFqW5dZdBOOOVqo1l2
         0VqpB4LZoCHUhG4EnPZaVpHZf771LMPT5YeVxSlU2/4Pt3eVFrEzNxuCV6FFWjewqk
         koiiH8oJ5nkBEowSZ0Y8dXIM+9z68kzWAZehMT9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A49FA60E59
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: Re: [PATCH 0/2] iwlwifi: fixes intended for 5.3 2019-07-08
References: <20190708155534.18241-1-luca@coelho.fi>
Date:   Mon, 15 Jul 2019 12:47:45 +0300
In-Reply-To: <20190708155534.18241-1-luca@coelho.fi> (Luca Coelho's message of
        "Mon, 8 Jul 2019 18:55:32 +0300")
Message-ID: <87r26rpr26.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> This is the first patchset with fixes for v5.3.
>
> The changes are:
>
> * A few new PCI IDs for 9000 and 22000 series;
> * Support for C-step 22000 devices;
>
> As usual, I'm pushing this to a pending branch, for kbuild bot.  And
> as we agreed, I'll delegate these patches to you in patchwork for you
> to apply them directly.

Great, thanks.

> There's no hurry with this, I know we're still in the merge window, I
> just wanted to send them out for people who have these devices and are
> having problems. It's your call: either send them during the merge
> window, if you send a new pull-req; or take it when the merge window
> closes, for v5.3-rc1.

There seems to few other fixes for v5.3 so I'll try to send a pull
request by end of this week, time permitting of course.

> Note: all this area will probably have some conflicts when merging
> with -next, because I've been sending new PCI IDs and such things for
> fixes, while some other changes are being made for -next.  Let me know
> if you need any help merging, when time comes.

Ok, I'll keep on eye on those.

-- 
Kalle Valo
