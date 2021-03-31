Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479CE3502F0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhCaPHe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 11:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235273AbhCaPHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 11:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617203228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ge/knHmpTU1ADfduHgtC/CSwVUa3isyOKivPlvkFT1Y=;
        b=GSSd5QUmj0u0bB4UnAjRGPsquFGhGHPPjKehFsfrngdoncUbKjRzoDvbP57byvJNvgbzU1
        pLwOfWPOxRUQuJ9Vi4ur+Rh7bqpEegAfkP8qSdrM2GcOZX5BqkVV9j8hGKF/kIs8G7rDqi
        KPhox4RgMwUNOnwVk4yIaeEFd6+qaYw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-zKytoiFsOFCVXIw8xRpA3g-1; Wed, 31 Mar 2021 11:07:03 -0400
X-MC-Unique: zKytoiFsOFCVXIw8xRpA3g-1
Received: by mail-ej1-f71.google.com with SMTP id a22so920121ejx.10
        for <linux-wireless@vger.kernel.org>; Wed, 31 Mar 2021 08:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ge/knHmpTU1ADfduHgtC/CSwVUa3isyOKivPlvkFT1Y=;
        b=mvnpDOor8FQx7Mn00zcj9qA9IlLiWEVtZ+/IAnBHBTy9x4BkJ8cZYS8SgH7AlNmCak
         7QNXXbNd1YPAaZ+I4eEI63gaNXKnBkNMQlVyoRAzdgyMYZx0z1BTWSmVCKhw13fgTfzt
         MWP5QJf+aXRaT8PtscPMaUY6HCgyCxpJC1H+U+0RvKy8Af6ktthLydhb5EMrILVe874V
         Cmih3grKIiFz7wcqY/jOmc4W5SHZ3SbJpBSWUf+TeMUG5oCxfqt6LDVlxqjDNV81Gvt0
         IFmVg1DJA816gE9sCd+hAYGWsVkSPGnawlKziBAhaPPXFdh0eivMfPbp6nurdygOAaIw
         wE/g==
X-Gm-Message-State: AOAM5315pyqz0ONwLzeSMFxd/w6EtfbcC2J/9uCBnzxM1p4rvADA+7/o
        cd14/2ype7h3H7w5+rdHOvGFoc7TxW3akKAHgShP297gexwmephL2rYQQXvx16IkokMH4+hRDOM
        qfB6XLq9hZ4Prdsz54fO9CkuxxhY=
X-Received: by 2002:aa7:c4d1:: with SMTP id p17mr4307503edr.387.1617203222137;
        Wed, 31 Mar 2021 08:07:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqcSSW/ySrXBXyEaq3BIEmygI4u9aOqJgnWBhz76bK91s4tXqBOVmWSYm5DBjJYbasFo52Xw==
X-Received: by 2002:aa7:c4d1:: with SMTP id p17mr4307462edr.387.1617203221702;
        Wed, 31 Mar 2021 08:07:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r19sm1296863ejr.55.2021.03.31.08.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 08:07:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 826FA1801A8; Wed, 31 Mar 2021 17:07:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     make-wifi-fast@lists.bufferbloat.net,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH mac80211-next v6] mac80211: Switch to a virtual
 time-based airtime scheduler
In-Reply-To: <a6ca1ab9-29a0-18fe-8097-20abc5f253bd@nbd.name>
References: <20210318213142.138707-1-toke@redhat.com>
 <a6ca1ab9-29a0-18fe-8097-20abc5f253bd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 31 Mar 2021 17:07:00 +0200
Message-ID: <87czvfpdkb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Toke,
>
> Thanks for continuing to work on this! I just did a quick reading of the
> code and haven't tested this yet - I might have some more comments in
> the next few days.

Friendly ping on those comments? :)

-Toke

