Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209F932AF58
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhCCARw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446089AbhCBDDn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Mar 2021 22:03:43 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91349C061756
        for <linux-wireless@vger.kernel.org>; Mon,  1 Mar 2021 19:02:57 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id f124so748055qkj.5
        for <linux-wireless@vger.kernel.org>; Mon, 01 Mar 2021 19:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TKrxavIalk54o974DPjthQgKg3zkXEG/iErTitPYSbY=;
        b=sH/0UfeZDXPX0uNqNZQW8uPXA+B9DUWnQ3H1RwGnXLbzju5sHnIlGi1tukKyGWgBLK
         GOhYlLHueTu5+UZZCs/i6RV1Y4mgU4v9yEx28px/amaWVZwihgqa7qkn928raYCO/sL0
         AVikyGBqF2DxGVWJMWQfVco0uLX1n/gDkxBqy3Hx9ZuJUtlE0JExQPRLakDMBZFO9oI/
         ulm+zHolCCGMKQKuKmFJhvyAVhiHzEbGr5vC/yBO2xvC68JSF6O7D71+3GNnu5c4ohaZ
         UlvijYeoaYfzMRg8ZxpBb+/AehkkuUsDCBCMkXoGpEIZuQBAO6/wKV7KjxYsVwXnkM3m
         WnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TKrxavIalk54o974DPjthQgKg3zkXEG/iErTitPYSbY=;
        b=FiDJGamlRBeUgHHavn7lPnOPrNHCOpqQX2j005Cs/566JJ138Z+aDS77z9f8tCNqQ7
         OFOrv+UioUVeO5Fe8UZdlNLGn8QnvBpkjDaQLiDYNNODG2EieGT+cm5NTID5TtkjoCw1
         ztFxT+UAp9JxvTMH7JegXngbzmEM4lvKqZIsYf8v7zzhXbzoT4OnkG9Us1jA03lYQlud
         8nyf54GF9dQX/WKxKOGHVONNdY/BErhKtIqdyNUCsFsElKd+Mm02bza513PoKG9CKz94
         hgYEMQHCY26WkBbTuq7s04WPhSw/OAq7ckckHKCA5t6PeK6KQNX0gltDy4lf0Zt00QQS
         EP8g==
X-Gm-Message-State: AOAM532g/nAEiIvDYcU57+7eNbUos3Zhnfy0Zr1illTgx7bfkw/JnLra
        dC0R4KJff8rvTAQMOUAFrJVA3oglEScTRw==
X-Google-Smtp-Source: ABdhPJyYRonf2Cmp0ddGEUKHb6DQ75d3x6JNgCVqHgE9qawxjyadYAiOa9J8pxxos6NDeZWo4tFW1w==
X-Received: by 2002:a37:6f87:: with SMTP id k129mr4509267qkc.470.1614654176821;
        Mon, 01 Mar 2021 19:02:56 -0800 (PST)
Received: from elrond.bobcopeland.com ([2607:fea8:5ac0:7d5:a81b:d39d:76c7:d569])
        by smtp.gmail.com with ESMTPSA id 17sm8064929qky.7.2021.03.01.19.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 19:02:55 -0800 (PST)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 3F6CEFC007E; Mon,  1 Mar 2021 22:02:54 -0500 (EST)
Date:   Mon, 1 Mar 2021 22:02:54 -0500
From:   Bob Copeland <me@bobcopeland.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wmediumd: fix use-after-free in client removal
Message-ID: <20210302030254.GC27894@bobcopeland.com>
References: <20210225143708.419462-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225143708.419462-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 25, 2021 at 03:37:08PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If a client dies while we're waiting for an ACK from it, then
> wmediumd_api_handler() will call wmediumd_remove_client() and
> free the client, even while we're still waiting for it to
> respond in wmediumd_wait_for_client_ack(). This leads then to
> wmediumd_wait_for_client_ack() using the data after it was
> already freed, and we also get stuck.

Applied, thanks.
