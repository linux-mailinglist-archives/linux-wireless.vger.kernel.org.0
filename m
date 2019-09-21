Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A536FB9C9D
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 08:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfIUGbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 02:31:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbfIUGbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 02:31:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9FF666141B; Sat, 21 Sep 2019 06:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569047495;
        bh=UsEhXiedwH1UXYLIVXKJ1e8J9VKVYvtraBikkOmIXEU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZoXfQOXzQo0tDsKnfyrdqo4KNbhUq2wlMgz1ZXoXAHHaTdes+m86tt4/IFvDXuUUX
         JzksHc+ffwGqWaDNWeWP2CtDMzgZ0s4ocSOwXpgXfF+gtvYUMEVJaSeiCKFa14yEE+
         fh9rwlVXVyjQ2zzl8cFTYwZabcXwLg6CjIO09iNs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AA4E607DE;
        Sat, 21 Sep 2019 06:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569047495;
        bh=UsEhXiedwH1UXYLIVXKJ1e8J9VKVYvtraBikkOmIXEU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZoXfQOXzQo0tDsKnfyrdqo4KNbhUq2wlMgz1ZXoXAHHaTdes+m86tt4/IFvDXuUUX
         JzksHc+ffwGqWaDNWeWP2CtDMzgZ0s4ocSOwXpgXfF+gtvYUMEVJaSeiCKFa14yEE+
         fh9rwlVXVyjQ2zzl8cFTYwZabcXwLg6CjIO09iNs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AA4E607DE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Maya Erez <merez@codeaurora.org>,
        Dedy Lansky <dlansky@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wil6210: use after free in wil_netif_rx_any()
References: <20190921060145.GD18726@mwanda>
Date:   Sat, 21 Sep 2019 09:31:30 +0300
In-Reply-To: <20190921060145.GD18726@mwanda> (Dan Carpenter's message of "Sat,
        21 Sep 2019 09:01:45 +0300")
Message-ID: <87lfuib1od.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> The debug code dereferences "skb" to print "skb->len" so we have to
> print the message before we free "skb".
>
> Fixes: f99fe49ff372 ("wil6210: add wil_netif_rx() helper function")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

As this is a regression starting from v5.4-rc1, I'll queue this to v5.4.

-- 
Kalle Valo
