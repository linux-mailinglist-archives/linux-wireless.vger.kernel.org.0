Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0CAC3333
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbfJALog (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:44:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33421 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732588AbfJALog (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569930274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/dMKHvsQVTKl0BVcuMGS27k4ITdJQ1v4XmbW+hMaSE=;
        b=WTmmcHzeE7KYDgN/JTakh9p6e0eTqGSRLemH9yCLvekJutXiKtuZaHpIqKyZ2pgQFB3wnt
        WgmutSozzHf1ypdDhIzHJkoVRxBYy087nVd1XBTe/MUowSvMLD3NzMcHF38DRUuNXb9pR9
        T40U01niHg8x3QnPZbODq5ekE3UiVF4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-wUxin_6OPNy6wRP86CwXTw-1; Tue, 01 Oct 2019 07:44:33 -0400
Received: by mail-lj1-f197.google.com with SMTP id i18so364124ljg.14
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 04:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h/dMKHvsQVTKl0BVcuMGS27k4ITdJQ1v4XmbW+hMaSE=;
        b=NKUtNT+Ya3W/5VTnh5WXijDXzVHCGceo6XFAdzdLHKZcfAkkTm4Y2+cMsk1E5ADn9E
         x3/IOpFGvTh06SoM4qIqUMxhHqiALGxhgWcoU4G4Wn3cscWzjiOOtoo2LHPv/3IbjKtn
         jAwIj6oTs9Hbd+EixQFt35JInhjiuY2fdgJax95kNFnEaYJaMZvBu/HP3dTZUT+WNslc
         qMc7tEy5xHEFXBvxhayNBRHURhVYSUPQVBMvjkxmnf/w2FEll+c22eUL5Em9C4JE5GNf
         44xZQh0uGHBhzcUinkwtrSRO9TgyI/2bSz/4Jzy6HjKU7+mGTvnxAIq9jZhiVCoPFxla
         X21Q==
X-Gm-Message-State: APjAAAUEYyCbe/TQf15YQ8BsTOwNpNAiGaJ9GFZrArrLItyBUmf9Kkml
        916qHmLA2RYUYS5CmzZLJFTXk9XdbWMRgLFNzYSWcTY0ENtfp+IPT0lH1tJXeoUNxrbaCibTubb
        6dGNM6tJtU5EihN9RtVuO1NGaQnU=
X-Received: by 2002:a05:6512:251:: with SMTP id b17mr15482847lfo.35.1569930271677;
        Tue, 01 Oct 2019 04:44:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwnT1+sf0TKg48VjVvqmrpYiQBeBo/Q6XPTzj3f3iVG7N0xf6z25UpDbnWAQfzVnQWSQkCXTw==
X-Received: by 2002:a05:6512:251:: with SMTP id b17mr15482836lfo.35.1569930271542;
        Tue, 01 Oct 2019 04:44:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id c3sm3805082lfi.32.2019.10.01.04.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 04:44:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1E24618063D; Tue,  1 Oct 2019 13:44:30 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Aaron Hill <aa1ronham@gmail.com>,
        Lukas Redlinger <rel+kernel@agilox.net>,
        Oleksii Shevchuk <alxchk@gmail.com>
Subject: Re: [PATCH v2] mac80211: keep BHs disabled while calling drv_tx_wake_queue()
In-Reply-To: <1569928763-I3e8838c5ecad878e59d4a94eb069a90f6641461a@changeid>
References: <1569928763-I3e8838c5ecad878e59d4a94eb069a90f6641461a@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Oct 2019 13:44:30 +0200
Message-ID: <87tv8su1up.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: wUxin_6OPNy6wRP86CwXTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Drivers typically expect this, as it's the case for almost all cases
> where this is called (i.e. from the TX path). Also, the code in mac80211
> itself (if the driver calls ieee80211_tx_dequeue()) expects this as it
> uses this_cpu_ptr() without additional protection.
>
> This should fix various reports of the problem:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D204127
> https://lore.kernel.org/linux-wireless/CAN5HydrWb3o_FE6A1XDnP1E+xS66d5kiE=
uhHfiGKkLNQokx13Q@mail.gmail.com/
> https://lore.kernel.org/lkml/nycvar.YFH.7.76.1909111238470.473@cbobk.fhfr=
.pm/
>
> Reported-by: Jiri Kosina <jikos@kernel.org>
> Reported-by: Aaron Hill <aa1ronham@gmail.com>
> Reported-by: Lukas Redlinger <rel+kernel@agilox.net>
> Reported-by: Oleksii Shevchuk <alxchk@gmail.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

