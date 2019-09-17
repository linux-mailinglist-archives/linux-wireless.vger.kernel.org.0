Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB55B5798
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 23:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfIQVbO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 17:31:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23798 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728051AbfIQVbO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 17:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568755872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVaGqS/TFjKhE/EptfKk75z9gnGR8vTzonot4HX3CsY=;
        b=S8Vbwkn42xJr/PMem1xChyydVrwxuG/NB2Mv26MscSWSAkd3U1Le5aIQlAWYMo7kmF2yMx
        gJQ95Z+T4wK07RO/ZFFpjy6cM5qzyqeeS5ycUxQ88WUwuX1HdoSF3OR4Dw/dXSNdoagngC
        rfXOkHk51uv2td2FXSDAL/Yy8RQiriw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-zz7xyQe-OpefX9rBv39ONA-1; Tue, 17 Sep 2019 17:31:11 -0400
Received: by mail-ed1-f71.google.com with SMTP id f9so3019350edv.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 14:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JVaGqS/TFjKhE/EptfKk75z9gnGR8vTzonot4HX3CsY=;
        b=GM6ohVKQwVLt9X3LIUND2vzHoZRBsIMM/cIqx4NYZYwitZEWqN1VTQNGyGRPmFhPdS
         mMHBaS/Oqgz137lxJryMocYancGzxAIOO5FBUXhy53ckt5UMKrAR/kZbW6qCXxFWutBA
         oMB95uqoXORwyRqQDy6na/WwM0GV9ZtfwfI0iSFrCs7tIJN+iIzSikSLllO/dfOQcUar
         vffzAsVyPy5O/KotV7rsSoy6XQIElRB4pTqUTB5DZP/aJbWZgQbSuSF0KsEU3CrLKkU1
         EUOn+cg7wYUh/eXUMEUXnAEeZ46piOnmvfP6JXF/WdrtLYaXTWjFRel9L1sbR+2Kem+P
         Nwqg==
X-Gm-Message-State: APjAAAWSVGIu39HgIGtmYh4t7WqHOFb+s03UOf5i7OuA7NTc9iHykhES
        /PfVKgnOXpYyPqcSKWzqHod2uAvG7tguXQmLNvUPn/VvOOKjP3uJS1TGo+tvUcUeiK9Po8w7e7C
        TZiR10BG5f2zOxhysgytAch8we6U=
X-Received: by 2002:a05:6402:78b:: with SMTP id d11mr4964741edy.14.1568755869725;
        Tue, 17 Sep 2019 14:31:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1wjlX98Jj01zS5MwohtCyWE1osliaa7sfDb/BoubXMW52uGvVGR84W7o5lDopiiD4H9If2Q==
X-Received: by 2002:a05:6402:78b:: with SMTP id d11mr4964726edy.14.1568755869581;
        Tue, 17 Sep 2019 14:31:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id z39sm638848edd.46.2019.09.17.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 14:31:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 62B041800B9; Tue, 17 Sep 2019 23:31:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/4] mac80211: Switch to a virtual time-based airtime scheduler
In-Reply-To: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Sep 2019 23:31:08 +0200
Message-ID: <87ftkuip9f.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: zz7xyQe-OpefX9rBv39ONA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> This switches the airtime scheduler in mac80211 to use a virtual time-bas=
ed
> scheduler instead of the round-robin scheduler used before. This has a
> couple of advantages:
>
> - No need to sync up the round-robin scheduler in firmware/hardware with
>   the round-robin airtime scheduler.
>
> - If several stations are eligible for transmission we can schedule both =
of
>   them; no need to hard-block the scheduling rotation until the head of t=
he
>   queue has used up its quantum.
>
> - The check of whether a station is eligible for transmission becomes
>   simpler (in ieee80211_txq_may_transmit()).
>
> The drawback is that scheduling becomes slightly more expensive, as we ne=
ed
> to maintain an rbtree of TXQs sorted by virtual time. This means that
> ieee80211_register_airtime() becomes O(logN) in the number of currently
> scheduled TXQs. However, hopefully this number rarely grows too big (it's
> only TXQs currently backlogged, not all associated stations), so it
> shouldn't be too big of an issue.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

I'll note that this patch still has the two issues that Felix pointed
out when I posted the RFC version. Namely:

- The use of divisions in the fast path. I guess I need to go write some
  reciprocal-calculation code, since that is also an issue with the AQL
  patches I linked to before.

- The fact that we don't count the airtime usage of multicast traffic,
  which with this series means that the vif TXQ will get priority over
  the others. I think we agreed to fix this by just adding an airtime
  v_t to the vif as well and use that for scheduling the TXQ. Does
  ath10k report airtime usage for multicast as well, or only for
  stations?


-Toke

