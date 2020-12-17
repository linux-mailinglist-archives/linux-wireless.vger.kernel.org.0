Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C52DD0D7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 12:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgLQLwy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 06:52:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbgLQLwx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 06:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608205887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOFdFRmxlC/MY/hwHY3z4AJ/88+5ehhfJJwxKIclB2k=;
        b=UbjwFN9U4Ndz+Oan8NTUADlJsgMIrZYVkqOyh3P09iRujlMzZLBxCMKzAqai/qMoTfjOFa
        Nsq/6/e1KLPhkXKwLy802pahCenzM1NlkOua9ZiOMB8emO6rxEIjezv4oq7N3y6Lgo1iN6
        IdkCuiqKShndMg7w/aSeUi4kmqGYWi4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-L50JD5G7MimG5Dgh9u780A-1; Thu, 17 Dec 2020 06:51:25 -0500
X-MC-Unique: L50JD5G7MimG5Dgh9u780A-1
Received: by mail-ej1-f70.google.com with SMTP id h17so8466286ejk.21
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 03:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fOFdFRmxlC/MY/hwHY3z4AJ/88+5ehhfJJwxKIclB2k=;
        b=Wz8inWZnZYfLchiWAttz+Xnu5yezH+76Vn+SLXQX+39uI19tAz3LMyKr/qjZQIg5dg
         GmN3xCTdDji4KebscVlOo6Uxn8D5S8GFcGzqv5wOWWKXkTGyDDrST4FROruqX8r0AMdR
         xDY5/Q497Ls+2hH5qkzI89hAdWgXtR/e3Rmio+EbBAL02tuxkBsx+9coQIkw/2fvztsR
         IMyfK4Ag+jWRM++F3snjdU+uV9xBtpcGDMmv4/JpFFVi7arICNl+chKZ0Y38YY0thQoW
         biD+re50WPWQzYLGJ33sAFNqcmmTEnhSP6iiMMHm/869UPTgufJKgfOoa8w+65UVnW2A
         8WZw==
X-Gm-Message-State: AOAM530Hf2iIx8Kw5kVTxmo2MH5B6smki8bfrqp3zJnQ2X65Fp3QOLxp
        eqKeXXDVVfEgWFwSNIM6wUN8yKtaI4KvKe/yVNoHLHdeT90E5LBtnrKG01yiHLWgIuUir9haTet
        t/DLBxssAb8vJ/d7vY/Dr1TmI2VA=
X-Received: by 2002:a50:f089:: with SMTP id v9mr39072666edl.353.1608205884566;
        Thu, 17 Dec 2020 03:51:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxMB0atHxiqp4Lwd8C6FYXRj+umNI+gfHIxWaNlpFVQhmWpXGRuPZBZjJTlKEVstPQlGAcsQ==
X-Received: by 2002:a50:f089:: with SMTP id v9mr39072652edl.353.1608205884442;
        Thu, 17 Dec 2020 03:51:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o10sm3556607eju.89.2020.12.17.03.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 03:51:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 88C5D1802A7; Thu, 17 Dec 2020 12:51:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 1/7] net/fq_impl: bulk-free packets from a flow on
 overmemory
In-Reply-To: <20201216204316.44498-1-nbd@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Dec 2020 12:51:23 +0100
Message-ID: <87ft44bqh0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> This is similar to what sch_fq_codel does. It also amortizes the worst
> case cost of a follow-up patch that changes the selection of the biggest
> flow for dropping packets
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

