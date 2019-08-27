Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CA59F18F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfH0R1V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 13:27:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbfH0R1V (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 13:27:21 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D43D385360
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 17:27:20 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id w22so11099edx.8
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 10:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YmLb+EgtCjKbjsP72nDuR7gCcltdq6dvJWkJFscEBhU=;
        b=i8zxqdJjg5XS8gUNEfOkXvQ2/Jlci6YR1WIMlaV1PnlaZko+Y2kfIZzXmBf9tYN3WF
         PsBHbh9jGs9GP8AVZwakN1Q3EDwZY5f2iVm/of+GhLBxoMj96+1PJugQVdVjSohA4Uc+
         yriSnAmnqHSkj+yPUnTycmwUcYt8kwgQx/O9n/tS2BTj6St5E6qDpeZzOi3v+L0PJDzb
         TZVhyRmoY8vk6P2g0W930MBuUDGHbjOLMmCbk4y3Y07vhuq4CqJPjCj83QxAi9xfxUqk
         FsZvwXW5IDF5svQTN4ynqm+dIy0fyAENL3qQa/80QI93Dl8VRyEvw7cGX6szNyc90Z0Z
         RC6Q==
X-Gm-Message-State: APjAAAXhglTSQPq0rFwDo/jvsHBSgK3vGcxYxI7CE0d4p91jdmNWWjCI
        TYiSW3P6lmQbjNhzm0rHKWTN0KSDSPAJgszf9ertvVIQXk2TPBK5e/vZyxCA2wZHyxE9rFHBEhp
        trD2Kpgxtgttu2DmcqesTcv6D+1M=
X-Received: by 2002:a17:906:1c8b:: with SMTP id g11mr22158476ejh.81.1566926839371;
        Tue, 27 Aug 2019 10:27:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy6kCL8ylCKmKPBNZRv3ewOAXE4EniTndu2nFf4f+l/TLjIHR7W9o9lCRgQGf97PKW1WW6WNA==
X-Received: by 2002:a17:906:1c8b:: with SMTP id g11mr22158469ejh.81.1566926839187;
        Tue, 27 Aug 2019 10:27:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id d20sm3448191ejb.75.2019.08.27.10.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 10:27:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A2E07181C2E; Tue, 27 Aug 2019 19:27:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
In-Reply-To: <14737343f1925a771ddd8dadf0f2b5a3@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org> <1566316095-27507-32-git-send-email-kvalo@codeaurora.org> <8736hvu6e6.fsf@toke.dk> <ac6e7dbbd53e7ba9e82e49baca22b73c@codeaurora.org> <875zmqsudn.fsf@toke.dk> <14737343f1925a771ddd8dadf0f2b5a3@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Aug 2019 19:27:17 +0200
Message-ID: <87sgpmikne.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vasanthakumar Thiagarajan <vthiagar@codeaurora.org> writes:

> On 2019-08-21 15:38, Toke Høiland-Jørgensen wrote:
>> Vasanthakumar Thiagarajan <vthiagar@codeaurora.org> writes:
>> 
>>> On 2019-08-20 22:21, Toke Høiland-Jørgensen wrote:
>>>> [... snip ... ]
>>>> 
>>>>> +static const struct ieee80211_ops ath11k_ops = {
>>>>> +	.tx				= ath11k_mac_op_tx,
>>>> 
>>>> No wake_tx_queue? :(
>>> 
>>> Yes, packet queueing is handled in firmware. This makes sense
>>> especially when we enable 802.11 encap offload support where most of
>>> the data path processing in mac80211 will be skipped and packet is
>>> given to driver/firmware in 802.3 format itself. Then firmware would
>>> take care of all the classification, queueing and encapsulation
>>> operations.
>> 
>> Well, so does ath10k, and yet we still saw a significant improvement by
>> moving queueing back into the host where it can be handled by the
>> FQ-CoDel-enabled queueing structure.
>> 
>
> Sure, we could probably try that with ath11k as well at some point when 
> we have a baseline with HE support.

Well, rather than retrofit change things later, why not start out with a
wake_tx_queue-based driver?

-Toke
