Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2853CD4C0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jul 2021 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhGSLvC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jul 2021 07:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231290AbhGSLvB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jul 2021 07:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626697901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJ3gtglIGncKRCxVqidJX6ON/dIC6SE6P45IMrzaQ9M=;
        b=Jo46AymPbckqN+7DAie42MkYb18WLy1rV7qZJYW4m9lgdjKwApY+LjyXXaKoA7Y224dmBf
        z+/fPI7Lg/cnHhtN1VHiWuYVFlmo3YhEEDtKMfJyCMsI/1So9DzoQxPBwdiX55c/V2R9Lj
        W0ZY4mYahI8305QORfCV3DjrA2LpBzU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-f3r4GBtvNS232fdjEm2h8A-1; Mon, 19 Jul 2021 08:31:39 -0400
X-MC-Unique: f3r4GBtvNS232fdjEm2h8A-1
Received: by mail-ed1-f69.google.com with SMTP id v4-20020a50a4440000b02903ab1f22e1dcso9224518edb.23
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jul 2021 05:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zJ3gtglIGncKRCxVqidJX6ON/dIC6SE6P45IMrzaQ9M=;
        b=XFMwYNNoqGbpNsnqhgAG8H053946TKe9lbUnasaC0kGYg9VSeLWV4J7FnNRz41I/CY
         HHZWRfRcRTX5+o81oOR/rmDssmbLwyN2truwGhQOjnEx2VnGmgm1FKItyqYx8FjCPHA8
         OqHmHTIA1IzRsPC8WePkp72ZWWSDYey/tx7uMTvZbDaR5mWX5jzBMQkYFpAOypHOp5iL
         rm1JyLXRVsjwGZrj++vKxkFROY9SFjTmGBs4q8IZvJPJwmJgP1JgMHxK3dAE70vYh4C7
         2ZGIR+QuVgQYtNYtX70tUDi9vb7z3PQLmrqfIcwEWtvBp+AyM3ONAl/a4jeFn99WdPvX
         y2rg==
X-Gm-Message-State: AOAM531uwcwpAcFt3ByBEDsFW1Pavbqgw+Jqs3b79OJp2A88n1IssOAn
        AFmtEN4ml3jpcknq+GZewbZ4fCNVVqThaM/s268JPxgDznOOwoSRsRMDWcPUeCQ/grdlqia5lWF
        t1mLjSmk55K55xJbnTwlpRpEckIs=
X-Received: by 2002:a05:6402:3482:: with SMTP id v2mr34242900edc.116.1626697898361;
        Mon, 19 Jul 2021 05:31:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5BemfyYCelXujZKVUw9YdHA2Y0jtswqGQdChSu4++2hb53MKvOnIr9zTizXweRuvbyBVgXg==
X-Received: by 2002:a05:6402:3482:: with SMTP id v2mr34242876edc.116.1626697898181;
        Mon, 19 Jul 2021 05:31:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a5sm7678070edj.20.2021.07.19.05.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 05:31:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3F4B2180065; Mon, 19 Jul 2021 14:31:36 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211: include <linux/rbtree.h>
In-Reply-To: <20210715180234.512d64dee655.Ia51c29a9fb1e651e06bc00eabec90974103d333e@changeid>
References: <20210715180234.512d64dee655.Ia51c29a9fb1e651e06bc00eabec90974103d333e@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 19 Jul 2021 14:31:36 +0200
Message-ID: <8735sav61j.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> This is needed for the rbtree, and we shouldn't just rely
> on it getting included somewhere implicitly. Include it
> explicitly.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Does this need a Fixes: tag?

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

