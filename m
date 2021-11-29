Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D3246171D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhK2N74 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241459AbhK2N5z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638194077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmFmqiQmz+mMV+UJGaPqUu6B2Kx8gZxvOEw+IykHWJw=;
        b=ddk1liGRDnERACy0mM8zJf6y4Wdkpx8e1Rq2BLlyS0z2nYGxvOMjO+xKISIQ/tmc2zY48B
        Auu30lDN/iInFWMDepjR4qiyqZECmD4Ym6+1mPxzOQ10ZFuLDTRmxSA7od6/ev56oYROVj
        Irrjk2jBmezXJpPIkb4xaX9+zbp02hA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-BwrjNVMzOHm5aZEXBOWiMw-1; Mon, 29 Nov 2021 08:54:36 -0500
X-MC-Unique: BwrjNVMzOHm5aZEXBOWiMw-1
Received: by mail-ed1-f70.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so13844701edx.9
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 05:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bmFmqiQmz+mMV+UJGaPqUu6B2Kx8gZxvOEw+IykHWJw=;
        b=cuSarYYts8d40uPrZy1C+x5en2jJnrOvMqz8cmpF4IketeqAeF5/laIW3Wpn3Kxazd
         KPhJPyuTsBu9Sy0dhGk6g1V9wmvZf93K56vaeIyKrhcBwDC8dNghAKllwKeqr3m95sD1
         fq/89QtOMveG4BVQuFLG7PtPhDQmTNmebTixsJZaIeKz0w6cYzdCwWMxXS/5ZK9IxFZS
         4rEhfK1lVudT8FH/r/2qnTF2Z3lQ8ce95VokPgzTMIgLPNusJe7R6rZIEhw27fNKuRBz
         7V0w6hODgaRYFE5ifGSdIeaYgBIh63+EODJKAiC5fIl4Qqpob7xNHz6ioCIAA8J6PQ+c
         qS+w==
X-Gm-Message-State: AOAM532C9nUtCQ/hJe5cICUb0oNSYoNRyhxsnGJ3UpN7lkHsZauiDVwO
        cl1LvwDo9m6TxqBrX26AMUDr5X1ySjf1281JRjfXArxiH9kvNLzqzZLgkObsulAGtsrE461Gbyp
        7vX5UtH+NIVlvVbLLJ2zPp1aFn58=
X-Received: by 2002:a17:906:82c5:: with SMTP id a5mr60991851ejy.127.1638194073871;
        Mon, 29 Nov 2021 05:54:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjKagDja+imbncCnUeOmlq6H3pJBQU0hYQjCNsOppcZ9tkhFmscmZ3kVkKq9UCdTPU0IFs6A==
X-Received: by 2002:a17:906:82c5:: with SMTP id a5mr60991751ejy.127.1638194072988;
        Mon, 29 Nov 2021 05:54:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id nb4sm7758557ejc.21.2021.11.29.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:54:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9534B1802A0; Mon, 29 Nov 2021 14:54:31 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 15/16] mac80211: agg-tx: don't schedule_and_wake_txq()
 under sta->lock
In-Reply-To: <iwlwifi.20211129152938.d5fceeb7e166.I555fef8e67d93fff3d9a304886c4a9f8b322e591@changeid>
References: <20211129133248.83829-1-luca@coelho.fi>
 <iwlwifi.20211129152938.d5fceeb7e166.I555fef8e67d93fff3d9a304886c4a9f8b322e591@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 29 Nov 2021 14:54:31 +0100
Message-ID: <8735nf9ieg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> When we call ieee80211_agg_start_txq(), that will in turn call
> schedule_and_wake_txq(). Called from ieee80211_stop_tx_ba_cb()
> this is done under sta->lock, which leads to certain circular
> lock dependencies, as reported by Chris Murphy:
> https://lore.kernel.org/r/CAJCQCtSXJ5qA4bqSPY=oLRMbv-irihVvP7A2uGutEbXQVkoNaw@mail.gmail.com
>
> In general, ieee80211_agg_start_txq() is usually not called
> with sta->lock held, only in this one place. But it's always
> called with sta->ampdu_mlme.mtx held, and that's therefore
> clearly sufficient.
>
> Change ieee80211_stop_tx_ba_cb() to also call it without the
> sta->lock held, by factoring it out of ieee80211_remove_tid_tx()
> (which is only called in this one place).
>
> This breaks the locking chain and makes it less likely that
> we'll have similar locking chain problems in the future.
>
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Does this need a fixes: tag?

-Toke

