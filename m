Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792AD2DD0EC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 12:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLQL4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 06:56:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727260AbgLQL4K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 06:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608206084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8Jn8LKGgwImDs3gX0kSYr7ZcVilHSZk2X0p4qxfS/M=;
        b=gSqlZDQZfSNAqDfJeBTD5XI4L+1x+CndUGF+cgfQ6ur2wwp1XYl18iZ8DgxXIjEeXJ9ByM
        Po/0CoYx/cdCPadBdRzgaFCTmlnevTvhvHsWX8SQTwUAXg+25ezHQnDkDhHoQMXUwNwF71
        Sf0BsSf64x3XSUZZtKvND5B6HNxA5mQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-y64Fel3aPMewPwh0Q-FkFw-1; Thu, 17 Dec 2020 06:54:42 -0500
X-MC-Unique: y64Fel3aPMewPwh0Q-FkFw-1
Received: by mail-ed1-f69.google.com with SMTP id e11so13360057edn.11
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 03:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=z8Jn8LKGgwImDs3gX0kSYr7ZcVilHSZk2X0p4qxfS/M=;
        b=iRAeZiZSE6nC7T8FnfsyxFXXzmysNSCGTlzOGFPXlRzvmr14Y24TPRZpo+L4smcjNR
         Om/78RwOBwOQrsiJQO1mAJ8CybY/WNuAiYe5ZbQCsVlfQXwMxV/oa9Peac4V1SzFqaYg
         /Zfw94enCWJm39dgb6xn8c9YIXfk9xBeZbaR5MNQmWE0P45Yl3tM8XukuO+t+3Hw1PdM
         hqpQzmQYPCWVISW9nlAjZIDD+3uxdrca60+yUwaM2AzTLnmNHtD+9WtEUs2+UO+71Wkn
         ys303vvUE5KiAq9Fu7DDNNbceG9g16VNC3rBbK/9QDiR1TsOv5mQUhCXc25mhpWEWd/i
         LBHA==
X-Gm-Message-State: AOAM532D58ldigIg9Y+fpj+hJWpxO7ffrkcLnaQeOW7G5XaMNK4Ao4o7
        V8wHk4xmaMHUvvN1rHPjxficSCnW/mvzzkP0aKfFVvEYlsP9ZPzWr1sQLq4uu3duq34I0zM3ivR
        mzGcKjOeBE44vmOgIJtymbOsG0EM=
X-Received: by 2002:a05:6402:2da:: with SMTP id b26mr38378020edx.350.1608206081205;
        Thu, 17 Dec 2020 03:54:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+kemalwTPXbfTQmjhIgwOOeOSLT9liO0ewJoO2WzZs0UXSWlSA91kRWGLBL7ZzpDH/H3fNA==
X-Received: by 2002:a05:6402:2da:: with SMTP id b26mr38378010edx.350.1608206081080;
        Thu, 17 Dec 2020 03:54:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s19sm23578651edx.7.2020.12.17.03.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 03:54:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4602F1802A7; Thu, 17 Dec 2020 12:54:40 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/7] mac80211: force calculation of software hash for tx
 fair queueing
In-Reply-To: <20201216204316.44498-2-nbd@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-2-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Dec 2020 12:54:40 +0100
Message-ID: <87czz8bqbj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Depending on the source, a hardware calculated hash may not provide the
> same level of collision resistance.

This seems like it would have performance implications?

Also, this can potentially discard information from tunnels that
preserve the hash before encapsulation (we added support for this to
Wireguard which had some nice effects on queueing of encapsulated
traffic).

Could you elaborate a bit on the kind of bad hardware hashes you were
seeing?

-Toke

