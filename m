Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234BF116B99
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 11:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfLIK6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 05:58:41 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:36916
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbfLIK6k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 05:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575889120;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=zI4zJKd1PPcjys8X5dTXS/39xMIkO/LpYF9YUSljaM0=;
        b=aiVkVI9mjroZBkGrR2RTA+/aeMQi+hJMFtJDBenZZu0kxID1dNuYa9b0AlEXRT6T
        5+mt8/OBbTTB1sgvbkzGJt+qSkIJQ5j+eiec/hZYRQKI+lpY7hrs7Zx975QMmCpKTmp
        NpUyuQHSG4hA9EeSduhx7OKKjojp/bDnOY4CMVv4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575889120;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=zI4zJKd1PPcjys8X5dTXS/39xMIkO/LpYF9YUSljaM0=;
        b=IFNNQ/DQvdLKjdr/CQyqOMPp1gJM2b8PfIlaEnF8eOe4e0CQjScMke8cU5d7VUb8
        td8HG+Tg6RNfDc4T8GDpuY3uwXtYacFkyoa33HxmmOmggpdxdjw8omh9NxiR4eokTEW
        4XT3XUCi/hQGZGjkzRi0/N+ZwERE88gn6aSIlWCI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AD06C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>, dan.carpenter@oracle.com,
        solar@openwall.com, wangqize888888888@gmail.com
Subject: Re: [PATCH] mwifiex: drop most magic numbers from mwifiex_process_tdls_action_frame()
References: <20191206194535.150179-1-briannorris@chromium.org>
Date:   Mon, 9 Dec 2019 10:58:40 +0000
In-Reply-To: <20191206194535.150179-1-briannorris@chromium.org> (Brian
        Norris's message of "Fri, 6 Dec 2019 11:45:35 -0800")
Message-ID: <0101016eea4faad7-ffccbda4-deee-456f-9e01-cd4a52bc9fd1-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.09-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> AFAICT, the existing commit (1e58252e334d) isn't wrong, per se -- just
> very poorly styled -- so this probably doesn't need to go to -stable.
> Not sure if it's a candidate for wireless-drivers (where the original
> commit currently sites) vs. wireless-drivers-next.

I'll try to do so that I'll put this patch to "Awaiting Upstream" state
and apply it to w-d-next once 1e58252e334d is merged to w-d-next. Feel
free to remind me then that happens :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
