Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB5236203D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 14:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhDPMuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 08:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37586 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234312AbhDPMuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 08:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618577385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GS4ToV5E6dghYVJzyGzgURMr14Yx6ZBvyTw6j+N6YnY=;
        b=PrN2MWSsztEjRFFpzMI3+lcjrYNzEQ0ZDBqVS6MNXCmrAPxIxi5f4VI2J9lYs0a38lL2rE
        FbobaTRhoNSLRqflSxGXUZBwv88lTkLrKFbcAUTULAXbXdiyiYCUVrQG3lMaXfYtdI9UhN
        Qr12huCmWdiX5s93gGiLk8LIyY5jfjo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-LKpaqcvaNv6rncsNOIk8IA-1; Fri, 16 Apr 2021 08:49:43 -0400
X-MC-Unique: LKpaqcvaNv6rncsNOIk8IA-1
Received: by mail-ej1-f72.google.com with SMTP id k5-20020a1709061c05b029037cb8a99e03so1962562ejg.16
        for <linux-wireless@vger.kernel.org>; Fri, 16 Apr 2021 05:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GS4ToV5E6dghYVJzyGzgURMr14Yx6ZBvyTw6j+N6YnY=;
        b=CfUzUVkoYuqmujGYkRgag06FH+tN2eBkjcRtO7mI9RacOAUdOdRvMwbjGhRb/agE4i
         OMclMLL30zGve4kQ3YzFbNCRFX6aKsB237aFhDn7oAfsJvvZCY17UurxXBwXW773jcBp
         4BkiS6ad3JgvfaqZtaaf9r1inYWe1A5CPFljtfMvYp7kmm1kAWWDST/K8TPiaAxfz+xY
         4/v/XEB828Gz/Wv3EDWPGE1K42rVCq1Tvsb6vZsy2J6HCXNhgiwwJK5offVBytaCJcIY
         76UJ8+xwF/MvCcCF+IPbuZi6fQ5SgWO2g679A1Rb28LMNKIRVv6hAi9oObBhV4SHTrBy
         D9qA==
X-Gm-Message-State: AOAM5323b08JOJwpl7uT158qYO6bjHTiHRDqyrmS6TmMbu9YC2EPkjui
        7QN8bv1QoKeKpjkBGApLffBMZ9+4BLNwobmkMmM6vdV0Hgep3EoJUlsvWGNryBTc+SY9tVJi5Lk
        uLl+//jerU8r55RP2uB8gGa+WUBQ=
X-Received: by 2002:a05:6402:51d0:: with SMTP id r16mr6384406edd.52.1618577382562;
        Fri, 16 Apr 2021 05:49:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHunU7kQif4ORYs81GUT2QieQJmJigq2d09iUa7J8ceIdNrHhQyMD0heEiJTjirMfw9xSuCA==
X-Received: by 2002:a05:6402:51d0:: with SMTP id r16mr6384397edd.52.1618577382354;
        Fri, 16 Apr 2021 05:49:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id kj24sm4201875ejc.49.2021.04.16.05.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 05:49:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3D02E1806B2; Fri, 16 Apr 2021 14:49:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211: properly process TXQ management frames
In-Reply-To: <20210416134702.ef8486a64293.If0a9025b39c71bb91b11dd6ac45547aba682df34@changeid>
References: <20210416134702.ef8486a64293.If0a9025b39c71bb91b11dd6ac45547aba682df34@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 16 Apr 2021 14:49:40 +0200
Message-ID: <87sg3qgzrv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> My previous commit to not apply flow control to management frames
> that are going over TXQs (which is currently only the case for
> iwlwifi, I think) broke things, with iwlwifi firmware crashing on
> certain frames. As it turns out, that was due to the frame being
> too short: space for the MIC wasn't added at the end of encrypted
> management frames.
>
> Clearly, this is due to using the 'frags' queue - this is meant
> only for frames that have already been processed for TX, and the
> code in ieee80211_tx_dequeue() just returns them. This caused all
> management frames to now not get any TX processing.
>
> To fix this, use IEEE80211_TX_INTCFL_NEED_TXPROCESSING (which is
> currently used only in other circumstances) to indicate that the
> frames need processing, and clear it immediately after so that,
> at least in theory, MMPDUs can be fragmented.
>
> Fixes: 73bc9e0af594 ("mac80211: don't apply flow control on management fr=
ames")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

