Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43BD2418E8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Aug 2020 11:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgHKJb3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Aug 2020 05:31:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46145 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728397AbgHKJb3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Aug 2020 05:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597138288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BeFHlVEM1atMd3LCirP1AEYTOK32W8KWrO3HGDqDN08=;
        b=MpoYM/K0mTBNEbia0gvsXRCmKlDmHdAh3uxLXTPKKH3FohY0a8SpWfN2HThiTM6aebBQ0v
        K1z2bPOozEX45TmzLD50gcnpWrVPFmX8IEY1ptka7EVZCJiOBzfKpiorpsytIbl9jXBbDe
        bwyiPQQsSJUvhUd74JQoFneFBxWUme0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-Td71DCctO8qyQABiC7_5-g-1; Tue, 11 Aug 2020 05:31:26 -0400
X-MC-Unique: Td71DCctO8qyQABiC7_5-g-1
Received: by mail-wr1-f71.google.com with SMTP id k11so5354681wrv.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Aug 2020 02:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BeFHlVEM1atMd3LCirP1AEYTOK32W8KWrO3HGDqDN08=;
        b=aWjpX6GsynRj9spFhIoJT+qBWfeqI+cWo7fsgAJofXuYWVqdsT6G2LofBto9wSbVCZ
         JaHgSeeWVuFijnF4qg73VbSiIWc5qaSpBLajvo8w27ydFZ/qTmSvEsTa6nWZ7WFTFL9S
         +CB69NIPYUNoTKBEYA2DysZ3riK+v09uORs9u33ZI0p4hW0XFvVMqHDeemRs+F9QtGdq
         +qHml7csFhMgOhaUyG1DyA63hodGiP3qNNk67sSx/+IOjIBgRzM9HjcLBptPAwQ3dkxJ
         KObpBOJY5SQxV+UzY/khujT5Wye6kfx5XHJVZZyYrUHP2tZv9oaaOELvsy4BmuZCUdp9
         NDSA==
X-Gm-Message-State: AOAM531+W9fmz3RRtCiTY1vTam1wQ1iEm2kK0vhXYFpEsByvGUn6ig6R
        yF0hGOhdz02IYx8QUqaiMPyqrYj45C6J6K44FYmZxqp54Kt7xvj0M9r8cz+rhlWLtOK7bSK4V3g
        oFlr/Os2s0L6UTRlPBPkdJuq98cc=
X-Received: by 2002:a5d:514c:: with SMTP id u12mr29703464wrt.90.1597138285403;
        Tue, 11 Aug 2020 02:31:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxGgzuJzADnBfZJZwnE3Lb5pI3HdVreOzilmBTvNSPT4JYadO0jSNAl+QyJINgfSQhZa2Dzg==
X-Received: by 2002:a5d:514c:: with SMTP id u12mr29703453wrt.90.1597138285259;
        Tue, 11 Aug 2020 02:31:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j24sm27551419wrb.49.2020.08.11.02.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 02:31:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 497C618282F; Tue, 11 Aug 2020 11:31:16 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH] mac80211: remove STA txq pending airtime underflow warning
In-Reply-To: <20200725084533.13829-1-nbd@nbd.name>
References: <20200725084533.13829-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 11 Aug 2020 11:31:16 +0200
Message-ID: <87a6z134wr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> This warning can trigger if there is a mismatch between frames that were
> sent with the sta pointer set vs tx status frames reported for the sta ad=
dress.
>
> This can happen due to race conditions on re-creating stations, or even
> in the case of .sta_add/remove being used instead of .sta_state, which ca=
n cause
> frames to be sent to a station that has not been uploaded yet.
>
> If there is an actual underflow issue, it should show up in the device ai=
rtime
> warning below, so it is better to remove this one.

Fair enough.

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

