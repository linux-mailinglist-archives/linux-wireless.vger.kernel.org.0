Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C02CA0AC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Dec 2020 12:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgLAK63 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Dec 2020 05:58:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgLAK62 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Dec 2020 05:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606820222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsdEwjCNIS7jI2V9W1lCEEM3KKIhI5ZSq0TWP3er66I=;
        b=QiODzYuMZKmMjKuI5SJwuu5DlnhC776wFzPRGNTRbx9TFFoA9mD5y8vNSDPkOMHTqdgsm7
        +u2A+tPohkVK7MnzBsCCnqczFk4CWJKfue2Ki+8SGcdzSoyzZ5fx7iT79zHDW63kRLSO1y
        ZhOl5Ij4MkajKhokXcRevToi9nSjUHs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-7x4GMrOQPxOo54gSNY3OyA-1; Tue, 01 Dec 2020 05:57:01 -0500
X-MC-Unique: 7x4GMrOQPxOo54gSNY3OyA-1
Received: by mail-ej1-f70.google.com with SMTP id t4so1014564eju.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Dec 2020 02:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AsdEwjCNIS7jI2V9W1lCEEM3KKIhI5ZSq0TWP3er66I=;
        b=GodtBp4UEUXpUm3Y2nWuRy72VVMRxGxTduT6rms1/DTFGRh8RRge6/E7vOLDFrYqh+
         29dUTpbWIjd8O5UoxbKD4YLoh2rvhGhnCf4HJpi8a5xrEuLVOfJ5f1vyqUGt5aJUJ79m
         BVpeawPEi/K44hJpo44lSV6xL73L3ODUe9WHluMqGd8TqDh/JrmiYl3fSJedgnD01YUw
         RzRH895qd5C+LlcsVTkOI8M8/oGl7UD/L7m6UFEHM1WbkQiiG+2ssQ+LkcBcXBqQzmwn
         gvF4dpxaKfjfvHpWbJfqM4hSk8YgZHObzCDDh0bRCfNmyWMde3w+mWxqkwL2pY9xrnzV
         O32w==
X-Gm-Message-State: AOAM5300sJy4oRTcFIY3YVXsWqxYFUxQmz+Y3dstjzDmRio/mO4BKSWd
        DTq5yeCtZ+p98nBh/0hYDcqRQV35RAY298ykGsUJzTh00+WMcUM1Q7QgBkwnj8ReT/RPeT5VdtR
        HXs+GERtAEowuN1H8hjfkxzCfHvM=
X-Received: by 2002:a17:906:6ce:: with SMTP id v14mr2436120ejb.209.1606820219049;
        Tue, 01 Dec 2020 02:56:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuByT1KG2w02HNqjVu2dVL0Rzjn/litljitGCnbtpbJa07ldpTVhbcNoA676VStHGNryoOEA==
X-Received: by 2002:a17:906:6ce:: with SMTP id v14mr2436104ejb.209.1606820218742;
        Tue, 01 Dec 2020 02:56:58 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q19sm642863ejz.90.2020.12.01.02.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 02:56:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 97C8D182EF0; Tue,  1 Dec 2020 11:56:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sven Eckelmann <sven@narfation.org>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: ath10k: Missing airtime scheduler parts
In-Reply-To: <2631481.BEx9A2HvPv@ripper>
References: <2631481.BEx9A2HvPv@ripper>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Dec 2020 11:56:57 +0100
Message-ID: <87a6uxx092.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> Hi,
>
> I was asked what parts are currently missing for (a better) airtime fairness 
> with ath10k. I know that the AQL were merged and enabled for ath10k (and 
> mt76). But there was also the virtual time-based airtime scheduler [1] which 
> was proposed. I think the development on that one didn't continue since last 
> year.

I did recently rebase that patch to the current mac80211-next, actually.
Sent it off to Felix for some testing, but if you wan to give it a go I
can post it to the list as well :)

> Maybe someone else knows if there were some other parts worked on
> which I've am missed and which were not yet merged.

I don't think there have been any other patches being actively worked
on, but I seem to recall something about AQL (partly?) breaking airtime
fairness because the scheduler only keeps fairness between stations that
are actually scheduled, and AQL interrupting that...

-Toke

