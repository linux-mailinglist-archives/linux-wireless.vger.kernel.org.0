Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F3C4A5DDB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 15:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbiBAODg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 09:03:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237314AbiBAODf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 09:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643724215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oNbC+wtx40oBnonNLNFbz32bISJYfa3rFv3xLx44b4g=;
        b=QgBREAbhZYVOL0Q5x/19tbIASIllyPpNoES+/pVwOy740BRRe9uhQWqwNnc19N7cHK1Cak
        YGq/cAu/fTvT6BpsbgEHTLxQ3nqR2ylqVPtpa+6F0qreiWJ16T19ZHR6/YknFYfM4vpETd
        x3fYyDoYIwnMAORZpBCwI1fbb+flDJ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-S_3lrZcqOp27BpTVPlUXYw-1; Tue, 01 Feb 2022 09:03:33 -0500
X-MC-Unique: S_3lrZcqOp27BpTVPlUXYw-1
Received: by mail-ej1-f70.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso6559714eje.20
        for <linux-wireless@vger.kernel.org>; Tue, 01 Feb 2022 06:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oNbC+wtx40oBnonNLNFbz32bISJYfa3rFv3xLx44b4g=;
        b=yeI66x8k7xPos3LHo0zyz8o5aMSKuTatusDjPgoGX7j2HR4CYUEL5sMgp7F/kpr9J4
         1DmaRBBvKmCbWiv7cyFagS0ytWLYnJXPZTZM9UjUvOtPj8qT5aCvjOuhhO61cauM0Kd0
         OCE1b/HcFfRoO2ctGUv68lxbXt1aurKf/tkyfM8vseTd5r8k3owxbjD5+z/bwulfVrHR
         VzbxoPKeHERXoaNbVT1hCApOzcfxJ81NvxPl2gUtssMiKmrzvb0xRgPrqOPUlM0fw9dr
         3TeKSzeh39vUsxSC6FQZJuO8DRS2/W8FUD3/xD7hxd4DEeXkmwSorZkoZWyXfFNHtEhF
         Hveg==
X-Gm-Message-State: AOAM532TXXGtBI23MIdKN/5rlNBcU9zkNxaagmxErkdH4IrBNrEJ2rh3
        OKUwnjS4D0OOEhqxyVjwZsSyP25Q+jCRkfPVR4bNxAEEoyBXGKOSahHHKT3GgPi0sJQ5a2tsYES
        ILRJDOpYwyZeh7PJIn5j7eLzAdB8=
X-Received: by 2002:a17:907:948a:: with SMTP id dm10mr20987965ejc.61.1643724212678;
        Tue, 01 Feb 2022 06:03:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzS6ReABEcsd5/wEQ5nkN96fOPU8SwbbdGSBFz20msdAMOM8tPv/vzGVt8N3O2WmCqkQceK4Q==
X-Received: by 2002:a17:907:948a:: with SMTP id dm10mr20987921ejc.61.1643724212201;
        Tue, 01 Feb 2022 06:03:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ce20sm2100369ejb.169.2022.02.01.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:03:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BDC51180703; Tue,  1 Feb 2022 15:03:29 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] cfg80211: fix race in netlink owner interface destruction
In-Reply-To: <20220201130951.22093-1-johannes@sipsolutions.net>
References: <20220201130951.22093-1-johannes@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Feb 2022 15:03:29 +0100
Message-ID: <87h79ielam.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> My previous fix here to fix the deadlock left a race where
> the exact same deadlock (see the original commit referenced
> below) can still happen if cfg80211_destroy_ifaces() already
> runs while nl80211_netlink_notify() is still marking some
> interfaces as nl_owner_dead.
>
> The race happens because we have two loops here - first we
> dev_close() all the netdevs, and then we destroy them. If we
> also have two netdevs (first one need only be a wdev though)
> then we can find one during the first iteration, close it,
> and go to the second iteration -- but then find two, and try
> to destroy also the one we didn't close yet.
>
> Fix this by only iterating once.
>
> Change-Id: Ie56cd0ef3f0d2108bb8a25c8bb5efced15e6a909
> Reported-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Fixes: ea6b2098dd02 ("cfg80211: fix locking in netlink owner interface de=
struction")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Looks like this fixed the crash I was seeing - thanks!

Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

