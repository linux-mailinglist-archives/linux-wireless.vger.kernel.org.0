Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB4145DE4F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 17:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhKYQK6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 11:10:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345575AbhKYQI5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 11:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637856345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kQAVBmCIUXbsnvYlnlq+/aIWUaqTO8/mr8RJ7oEZ8Rs=;
        b=faR4lItzved3Aob456XgxdfKohELJqNIq/+qPIsF954MiNp7hH31iqwJwEM6DZgxCg+n6D
        rT9Z2N1S/x7LL9EhbpEArchNpAWdjSktfJVs1s0Cuy5t2J1PYW7H6bSW0FZ4OTXOtBiDae
        Ka2NRBZjTyHrPIQ6GCH3jQwK6ZHB9aY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-Hzu8ogE6NR-C-WGKvcuLKg-1; Thu, 25 Nov 2021 11:05:44 -0500
X-MC-Unique: Hzu8ogE6NR-C-WGKvcuLKg-1
Received: by mail-ed1-f71.google.com with SMTP id m17-20020aa7d351000000b003e7c0bc8523so5851922edr.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 08:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kQAVBmCIUXbsnvYlnlq+/aIWUaqTO8/mr8RJ7oEZ8Rs=;
        b=TpsPro9Xjd6jCwv+BQBefkOhjzqaBcYXe4TvsyW1T9sPc+H72Q9ABhopPE7WsQbrOf
         e1FF2jwQROqqS6EXeAFSfJ5Z1H/4RiWNvQcL13RyhCe1qEAyLUJQmfAMmK3S8A+4j5oK
         OHAemHNADfnrSQO3oELHfl04qj+qSVURf2q6sUKCSy4auyWPzOTocEq9KkqsOVtx94xc
         3+reAohkdfQ9+lzG3z9WhPNvbiyCMjeKECfrsRUlImS/+r/9KYMcGjUp08XO57QYTDlR
         v1MJrpRuhyqoj9TZUjLIbUdjg6iKA8cj5MIx50FEyQ40uPetiOmFiwjwQuHfak2KMc4s
         vJqw==
X-Gm-Message-State: AOAM530zYHG07jQDa/cQrxempHT5LrTbMnVKW3TVaBnwwZyQatF6NfEQ
        PJ8UjSAfAIMkZCaA9DYACqYbXGuwFK+RQN18SXyU90jw9RVJwhFP7oyBCHLFy3MoTXE1gKmZ8EL
        i8ynL3koIOKjxXkmio5QQ8diYyW8=
X-Received: by 2002:a17:906:398:: with SMTP id b24mr32522548eja.49.1637856343347;
        Thu, 25 Nov 2021 08:05:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJBTTNiYr8s6BLp8wYbM9XTJNmYGSwdJlYdB9t+x6iF0QE5GiFjXm4PKwWdHp5IuaF83OSbg==
X-Received: by 2002:a17:906:398:: with SMTP id b24mr32522490eja.49.1637856342990;
        Thu, 25 Nov 2021 08:05:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id lv19sm1961812ejb.54.2021.11.25.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 08:05:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 441DF1802A0; Thu, 25 Nov 2021 17:05:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: Re: [PATCH] ath9k: switch to rate table based lookup
In-Reply-To: <20211125121652.6073-1-jelonek.jonas@gmail.com>
References: <20211125121652.6073-1-jelonek.jonas@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 25 Nov 2021 17:05:41 +0100
Message-ID: <878rxcb4q2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> writes:

> This patch changes mac80211 rate control for the ath9k driver.
> The rate lookup per packet is changed from legacy usage of
> ieee80211_get_tx_rates() to the new rate table based lookup
> in struct ieee80211_sta.rates.

What's the practical implication of this? Performance benefits, better
rates selected, or what? Got any benchmark numbers?

> Co-developed-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Co-developed-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
> Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>

You don't generally need a co-developed-by for yourself, and your S-o-b
should go at the end when you're the submitter...

-Toke

