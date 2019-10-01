Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1706CC2FAD
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfJAJJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:09:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728892AbfJAJJi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569920976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ey2S05y+qH9qcmtAVhMGP0PZwCwz3gwo0pP+/KPv2RA=;
        b=gkG76F9CbZqEFCLqOAzEcGCDhgysDJzeeMASotw2zoB3rXeO2KA3Zn+6+vQLCUnKj0SnCW
        KM1vJAlJcXDfr9p9S8qco0/2HfLihcwBgvJqRDyDFaoh9NjSYvIzg6kaDN5hwH4UpqZzxp
        j2dC1VgLbRjZZm92GpGsrsh5V9fuSIE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-C4vqDroYP7-2vJ0NuHonmA-1; Tue, 01 Oct 2019 05:09:32 -0400
Received: by mail-ed1-f71.google.com with SMTP id d7so8156432edp.23
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 02:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wlyXXImOIp1mcAi7TD8GXAiJ2gSaRKFmxGZ/4rWjOZk=;
        b=HQeSgTxXWUdeZO1B0wlK8XQ9RRXIQt4INzhxalj5laM92C7nopexqA2yr7NTxfQvgr
         4vdZZYhpWqlAxP7eK9UXQRTq/dN6toSqTKqhfqU2VjfSo+nRClyMVtkoeLvnmwooaFEl
         GyrDysgA/UMy3iblHBL2UFbJ9/eosbLCEGTSucuBrcrCyltSFYvKU5gxc1S0Fwkw3KEP
         uPhprvglg7NzpDQKPp9ykJiuGRgl+rk+mep3Vze7Bs9rogI9KnIXtCCr3FDt/pq+tsO5
         AFwltiARthJp/JNqp89sV3NyTetiGOjVDWwFVGHw427aReLZQNkrZImYRcXOtUsRzmnM
         zaRw==
X-Gm-Message-State: APjAAAUo8AqRGO9nKt+RfQcd6bFMGlgUPF/fBUwuNIB7dfNYVYEouwcO
        FxXFAvpTluifkEtT3jY2qn5YiIx14FuCl8yEsYPEWJweQSwHSSxyrHJ6c0i2i+hxkXbhCWuWCo5
        4U0ejQ0MlZ9B62pODt89KIey0GEw=
X-Received: by 2002:aa7:d789:: with SMTP id s9mr24215875edq.62.1569920971873;
        Tue, 01 Oct 2019 02:09:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCqH9jlzfDumYbdUArITAjkR/o1V5EP9TaHmmbcp6BHtfMgQprpm+eLJx+fRgaiLD0rIE/BQ==
X-Received: by 2002:aa7:d789:: with SMTP id s9mr24215867edq.62.1569920971722;
        Tue, 01 Oct 2019 02:09:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id u27sm3018104edb.48.2019.10.01.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 02:09:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B4F9118063D; Tue,  1 Oct 2019 11:09:30 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH RFC/RFT 2/4] mac80211: Add API function to set the last TX bitrate for a station
In-Reply-To: <2518c49c96b8b5233fabcb8bafccba6b8f3155bf.camel@sipsolutions.net>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576646.191202.14461472477971784776.stgit@alrua-x1> <2518c49c96b8b5233fabcb8bafccba6b8f3155bf.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Oct 2019 11:09:30 +0200
Message-ID: <87sgocvnlh.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: C4vqDroYP7-2vJ0NuHonmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Thu, 2019-09-19 at 14:22 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>
> Given a ULL constant:
>
>> +/* constants for calculating reciprocals to avoid division in fast path=
 */
>> +#define IEEE80211_RECIPROCAL_DIVISOR 0x100000000ULL
>
> [...]
>
>> +void ieee80211_sta_set_last_tx_bitrate(struct ieee80211_sta *pubsta,
>> +=09=09=09=09       u32 rate)
>> +{
>> +=09struct sta_info *sta =3D container_of(pubsta, struct sta_info, sta);
>> +
>> +=09sta->last_tx_bitrate =3D rate;
>> +=09sta->last_tx_bitrate_reciprocal =3D ((u64)IEEE80211_RECIPROCAL_DIVIS=
OR / rate);
>
> that cast seems unnecessary?

Yeah. I only remembered to make it a ULL constant later, and forgot to
remove the cast. But I guess this should be using do_div() anyway...

-Toke

