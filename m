Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38610ACB95
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfIHId5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 04:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfIHId4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 04:33:56 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87BF889C31
        for <linux-wireless@vger.kernel.org>; Sun,  8 Sep 2019 08:33:56 +0000 (UTC)
Received: by mail-lf1-f71.google.com with SMTP id a14so2268203lfk.18
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2019 01:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Yx3kKsh4gyeDt5/46KJgnEnzulqjHSTWwYhh5BfKF6M=;
        b=mEFdo3uODURMEv4q/ai+bOlBkjQ2KP5NxbcxJYxQFbdlpCHd0LEABwOaR15v5+4O10
         gmUEd4W0tUJWiItf0TvMZZ0lQoYjvGDp+yYxWADJ5021oTxuUAngpCTelBfIRM0kB3+q
         Kn3UTeKVdt840n83QOdUUWlYx8qdF4PgHYOH0Z3t8aOVB9IPzZs4Dg37fLlFYWbO3DRP
         1dM7lIeEb5aUoHSxAqYDDxkEm5kzgntueSZKGmiy6XB9a5GJJXlbYEgCitL0jpzlVwAZ
         7yli+BzObfG6brA7S27+hD2Xcr5bzRGHATu0afXM25hMZcLCAKbGAEKRA9vpINn+vJ4k
         EHxg==
X-Gm-Message-State: APjAAAXZyL3dLuWlRNB/MGO2FvzfF1UC97z/A+m78ALq73r+lKB7FfUx
        tqefKBF4ATukEvuAOQqqvBP8qllfdLrAGM/3XGhw52pWi9/AQlWRBjEnmlLhBjLJX4QUcjp1n0W
        nMd1SCDdKvQnkadjz7hioXDSVK24=
X-Received: by 2002:a2e:a40e:: with SMTP id p14mr11869367ljn.29.1567931634716;
        Sun, 08 Sep 2019 01:33:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkyQoRp9d3iYIZBzRDfVde3dxjcokxivsZpSyT+YTN73wAApU9AFlsfUpCOXC23q8ZXUbvNA==
X-Received: by 2002:a2e:a40e:: with SMTP id p14mr11869361ljn.29.1567931634559;
        Sun, 08 Sep 2019 01:33:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id l18sm1892478lje.88.2019.09.08.01.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 01:33:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DEF52180615; Sun,  8 Sep 2019 09:33:51 +0100 (WEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH bpf-next] xdp: Fix race in dev_map_hash_update_elem() when replacing element
In-Reply-To: <20190908082016.17214-1-toke@redhat.com>
References: <0000000000005091a70591d3e1d9@google.com> <20190908082016.17214-1-toke@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 08 Sep 2019 09:33:51 +0100
Message-ID: <87sgp7w5jk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke Høiland-Jørgensen <toke@redhat.com> writes:

> syzbot found a crash in dev_map_hash_update_elem(), when replacing an
> element with a new one. Jesper correctly identified the cause of the crash
> as a race condition between the initial lookup in the map (which is done
> before taking the lock), and the removal of the old element.
>
> Rather than just add a second lookup into the hashmap after taking the
> lock, fix this by reworking the function logic to take the lock before the
> initial lookup.
>
> Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
> Reported-and-tested-by: syzbot+4e7a85b1432052e8d6f8@syzkaller.appspotmail.com
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---

Oops, this wasn't supposed to go to linux-wireless and make-wifi-fast;
apologies for the noise! :)

-Toke
