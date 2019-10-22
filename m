Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFF6DFE97
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfJVHsV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 03:48:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44434 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726978AbfJVHsV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 03:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571730499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzDsrMcHKszz3bwRYvuYtX+rSBuI9PjDoCSQT3XEhEg=;
        b=FiSAfc5Bm5QktWdS/7LHh1jnGG1eWcDL7uUID7NJhVZvXa85JhnJUpPxIwTM86KDI+v6Am
        1Yehd/s3xBDg7vfrxXOTCdfE8W4xexi71EaN7fgtjiiqpO4WxVzDWnBmhpUfAWL5EXrQHt
        V6Asv8G5sknbK7uZDHC9+4na74kjmio=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-ALZeyBLfMeCUI0T6exsLmA-1; Tue, 22 Oct 2019 03:48:18 -0400
Received: by mail-lf1-f72.google.com with SMTP id x21so80997lff.13
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 00:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XzDsrMcHKszz3bwRYvuYtX+rSBuI9PjDoCSQT3XEhEg=;
        b=p1OXyZn6v1wA9pZjNyyzZg7ErayLqNOW057Vf92FJkmIBS6UiwXGG04iCUHew0FJsc
         xatTwyDAPn5KufZ16xLRSjaeTYb2klKQvEqgSsV/K/ySfELL6TSjZDUaMGeTotM/y5l/
         VY5upHBH4tZQ5WD1RA3zpyHdmaUn++fiBrTcdjgo2gVr5kN2ujkvFEI4UVasPyNn/GGT
         9A+wElndLF2Z2R/VFRBIdLa8yrpR41m/b/7mWPpMFJuV8h7EVH2HFI3Os+9uzETz+R30
         eAbYPJG0eeYa/5TseZoOacvby1fiMC8dWQVZmC7a8+RqPFVndgGHbgtqriDjjPXn+vGo
         HoxA==
X-Gm-Message-State: APjAAAXLGN6ZMWD0VSVwVBSVvWpgwkPW8ji8+68LMiXPW5WnRd6Rv3WQ
        oSUA2SQ70WKksEiho0hgpv5soudKLD5h/go1TAp8oyw6eTpMkIbsZLU0rU6uDX4TEDjX3WFqqYP
        WEvgHtu1/4WquuLlFOU+2mgmd2CY=
X-Received: by 2002:ac2:5108:: with SMTP id q8mr13287469lfb.150.1571730496571;
        Tue, 22 Oct 2019 00:48:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyn/tAnr8l4ROLViTmyqAcrVK7VhXoaRsahHOaDoG02J2cAdtveTyigBCd/b0rd08yVvDyeBA==
X-Received: by 2002:ac2:5108:: with SMTP id q8mr13287460lfb.150.1571730496413;
        Tue, 22 Oct 2019 00:48:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id m17sm22490540lje.0.2019.10.22.00.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 00:48:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 297A21804B1; Tue, 22 Oct 2019 09:48:15 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Ryan Adolf <ryanadolf123@gmail.com>, Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Fwd: iw package typo in help command output
In-Reply-To: <CADh-Cm=bG2wV6Ccy3ATx3g=dsoXa6KAvxwBJ+pPxMSscaQ0AXA@mail.gmail.com>
References: <CADh-Cm=umBWCkz41-e0-PDnDrbpfQi_PRdT--SePmQLCqj5rwg@mail.gmail.com> <CADh-CmnrWe_hrdfs3RqL0mF4ipAxthUgE3=eBSvaiudbEtsQvw@mail.gmail.com> <0f33cba3dd5fdcc4697c26e97e8f265c1bb9958c.camel@coelho.fi> <CADh-Cm=bG2wV6Ccy3ATx3g=dsoXa6KAvxwBJ+pPxMSscaQ0AXA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Oct 2019 09:48:15 +0200
Message-ID: <87blu9p6f4.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: ALZeyBLfMeCUI0T6exsLmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryan Adolf <ryanadolf123@gmail.com> writes:

> The patch is attached.
> There's only one modified line in it: correcting the typo of timstamp
> --> timestamp.

You'll probably need to send this as a properly formatted patch. Pretty
simple to do:

- Make you change (you already did that)
- Run 'git add event.c; git commit -s' and write a commit message; check
  that the signed-off-by has your name and email address right.
- Run 'git format-patch HEAD^' which will produce a file
- Run 'git send-email <filename>.patch' to send it

You'll need some config to teach git how to talk to your SMTP server for
the last one to work. It should be straight-forward to to set it up with
gmail (just Google it).

-Toke

