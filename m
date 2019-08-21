Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A94976AE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 12:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbfHUKI4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 06:08:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43933 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfHUKIz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 06:08:55 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A88A56404C
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 10:08:55 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id f11so1091449edb.16
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 03:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=umZ1aaOBeJjkeJ1S0Jm8f7ll4VqlupnyjFqoji04PLs=;
        b=QsMoJmYQV+tHkicvrrlWRdQmwRdeq0xvUl0lZ38HnUrqj1My+WKTZL3Uveokp0jJWF
         RtmzcNA6j6Yfta2HTCAw6/8dPTzL799PUAywc7be2+pxJlaXIlVtEa2QGAKAuZsx7e2s
         6kAf2yskPIAoMhqF3oURQ4/nopCj1LA8pBDMfR2m4yMUAsAKBAffPMjYBdCOdNVlrdvi
         oyb/R5+LI3W5juItuM0q/sxaqgsKUVxSOyeJN7cjLeVfsFqQfQBcOhBC1PVQpBiTpSWV
         TdwOA5+25rr8ivS/CM7P5rUSI56Q5vG2xGcsrv/9+QkdOLluME6HKd1fCnNZpj5Gd74r
         NA0A==
X-Gm-Message-State: APjAAAWoKDvHn41eX3WvU8dA5if2Y2QQKrY6UdLLGD0P7QBmW8FMzkYJ
        xicbvVy5F+9Bn8YZ1L1iD8gGCMZ5ahpbbTU33CAOdi7N5l1Zs0A4Us20JOLqT8R5EpVC6//1/7v
        48rUNskDkzS56MYMIxEfo74BUefA=
X-Received: by 2002:a50:f10d:: with SMTP id w13mr35413407edl.222.1566382134250;
        Wed, 21 Aug 2019 03:08:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyjtqsPfVaOVcGj4bIlvdZRLCMANdsMw6mmT1TMubKmHil2CT5/yEMGNW9mzQ6x4eSTUcPRVQ==
X-Received: by 2002:a50:f10d:: with SMTP id w13mr35413397edl.222.1566382134121;
        Wed, 21 Aug 2019 03:08:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id x42sm4028988ede.24.2019.08.21.03.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 03:08:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D5D07181CEF; Wed, 21 Aug 2019 12:08:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
In-Reply-To: <ac6e7dbbd53e7ba9e82e49baca22b73c@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org> <1566316095-27507-32-git-send-email-kvalo@codeaurora.org> <8736hvu6e6.fsf@toke.dk> <ac6e7dbbd53e7ba9e82e49baca22b73c@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 21 Aug 2019 12:08:52 +0200
Message-ID: <875zmqsudn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vasanthakumar Thiagarajan <vthiagar@codeaurora.org> writes:

> On 2019-08-20 22:21, Toke Høiland-Jørgensen wrote:
>> [... snip ... ]
>> 
>>> +static const struct ieee80211_ops ath11k_ops = {
>>> +	.tx				= ath11k_mac_op_tx,
>> 
>> No wake_tx_queue? :(
>
> Yes, packet queueing is handled in firmware. This makes sense
> especially when we enable 802.11 encap offload support where most of
> the data path processing in mac80211 will be skipped and packet is
> given to driver/firmware in 802.3 format itself. Then firmware would
> take care of all the classification, queueing and encapsulation
> operations.

Well, so does ath10k, and yet we still saw a significant improvement by
moving queueing back into the host where it can be handled by the
FQ-CoDel-enabled queueing structure.

So, *how* does the firmware handle the queueing? Does it have
per-stations queues? Per-flow queues? What's the latency under load
figures for the firmware queues?

-Toke
