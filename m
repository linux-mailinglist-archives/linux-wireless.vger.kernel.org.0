Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692FC2DD0EE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 12:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgLQL51 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 06:57:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbgLQL50 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 06:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608206160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v0nc2jWooiWZweLhAUjYaXXn/QbqI1nosDk+p9SnMDk=;
        b=brPFZzUTcjJ49w+tAtOJE3INHynjWlG/ebJd8V9q6dxG8PtDz/wxaNJbmRx/L8e+1596TL
        LT8IjWIKlnK3sDrBnsNE5WOE2CK5xYlPn78HSyHu4fX+/EeMTRn3/qkyEeX6FrKTX5oZ5f
        OMZJ1nEd7PgeVMl+GaKrq/u++zemhDE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-nQZQfQ_OO-i0DoqUQ4jJSQ-1; Thu, 17 Dec 2020 06:55:58 -0500
X-MC-Unique: nQZQfQ_OO-i0DoqUQ4jJSQ-1
Received: by mail-ed1-f69.google.com with SMTP id dc6so13291029edb.14
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 03:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=v0nc2jWooiWZweLhAUjYaXXn/QbqI1nosDk+p9SnMDk=;
        b=FMK7pGwifv+mKj1yySUsDekH0ltf4HpE8cSvZ0G+7J16SMfGduIykN0XiXMxTJb91z
         yl0OPNt5tL9VDSwhdHooTsyCTF1U52nw8mRexJJmqPcDHIoKgtITulGB1++Yad+Ub35N
         xCVxKYPFkPxyKjtRmNp9CC5WsrDmsU+vcv+9eBcAS8VE9KEMsTzJ0FsQxpIZgDEEM77J
         MIPiYyLGV2j4T5S5ZB0uzzlwjcb57+Thest9XLlH5/wKpRpo4uGWD7KhDI+EyDLVznqU
         ycEUgxIAJXM07uooCs+8UUXqypQm3pf/skOkK7vSiYaFlgGrmGb13WpCizNOLinE7ab0
         wKlg==
X-Gm-Message-State: AOAM530Jpy55aAGvAu16ZgZVCAkcceahwmKkVbVX5te2K5pYo+BJ5/2U
        lOCPwRSihDhwe7DQyhdIw7GRoz1xL43jCjwmU7n2kGs9VWPk/zZZJ16hvSqDI/waMP1kn1fjg4A
        q3scaZmRDw1H2BI43WxK6IKNcJjQ=
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr38552521edj.293.1608206157186;
        Thu, 17 Dec 2020 03:55:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1p1tkZsOP0NLvBiK2ZLOgekLnQrHFWSKYTG5cyOhqHD7uldin4KgqzOsw8hicKhE5HS1uqg==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr38552514edj.293.1608206157068;
        Thu, 17 Dec 2020 03:55:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j23sm9869314edv.45.2020.12.17.03.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 03:55:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4E4FF1802A7; Thu, 17 Dec 2020 12:55:56 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 3/7] net/fq_impl: drop get_default_func, move default
 flow to fq_tin
In-Reply-To: <20201216204316.44498-3-nbd@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-3-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Dec 2020 12:55:56 +0100
Message-ID: <87a6ucbq9f.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Simplifies the code and prepares for a rework of scanning for flows on
> overmemory drop.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

This seems reasonable.

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

