Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2DA11729C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 18:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLIRRr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 12:17:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33145 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbfLIRRr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 12:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575911866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7Spb12zjYvrMaluBGctHDexi8G/lq3SA13UWUowwEk=;
        b=B92xod3SLqwAqUxyQIsC/HoEuhSoH/Il7mREOvfD60CwOhSbUuXzoT4dY1rNszdjDBzkAL
        vHFcR/4lcLZ3NEpPQmJpXBv+E27EhAK+sLa2cpL6XiZ59OBm8j+pMm+UTvNaBGthEyFRnX
        8CpKl7TIJUDN0TYBItMX83XzZzWfwrg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-rTDGrpSNO_qZQRSdhR6njg-1; Mon, 09 Dec 2019 12:17:24 -0500
Received: by mail-lf1-f71.google.com with SMTP id h7so3039568lfp.20
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 09:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EOyBnBrsD+bWp49YaHXco3v2nEbQfH6z60I7SzVnZcM=;
        b=WTwEAnsSfH3E1aLfk2RYOoacLu0qtA0kst8IXpYXpifx5KiQTBDYSoe9Y7XDT0q6Nm
         Lp/CgUzgaWGgOtnRqwzez2/Lhb4GuKQhA+IuciD1FBl8BxIoiBQXJH6j6icb4Xl6F9hd
         6mbixfGslGIMWGjcb7xFDb5pkpaM6Cx3EQ+G48vmjUUI7s7xXoG4JoIiMc08NsPM8C/W
         n8tyf8loawqdL/sJs6gk0vGJe40g2FTlSffIBfTHTF5M2yDLduPQbNQY8Dskzx2kweq1
         CfOijUTr+yDC7Ugu8tPY3j5yBRj3nfGlnP//riS+0/Tq6m6kpf7p4sn/pOnVu6oCGKDN
         M/1g==
X-Gm-Message-State: APjAAAVlkBuSaiqaS/BcULEPVmeoW2Aoug4MkZ6sCL+QlqQEK+UHtGrr
        MIkj/2g/ElSxWdR8WbLCGEfKt6U2k2s2VG0ogg7KR9emShrTqIOqJRnGXiqx0vDEhPJlHkUX3ig
        zYHUj9sUraaOv/5ttw4oJhM5nRqA=
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr2960357ljn.85.1575911838156;
        Mon, 09 Dec 2019 09:17:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLOgtGLfaMAXm7H4Gl6HAr4AQFm6pWyFLPFA/320U91QRZ9CueyCiNqjJerVH4fklQ88oDAw==
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr2960349ljn.85.1575911838045;
        Mon, 09 Dec 2019 09:17:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m21sm22681lfh.53.2019.12.09.09.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 09:17:17 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4733C181938; Mon,  9 Dec 2019 18:17:16 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Subject: Re: 5.5-rc1 oops on boot in 802.11 kernel driver
In-Reply-To: <CAH2r5msb63LFeDZ9D9dNv8tTS1yS9oLXx8tNqmjTQfXRsKrFzg@mail.gmail.com>
References: <CAH2r5mvZ=S0FHGP+Y_r5f37TXVehv2shj9f6w67zBxfjR+Zt-Q@mail.gmail.com> <0101016eea3353da-835ca00e-d6c9-4e2c-aa0b-f6db8a4c518a-000000@us-west-2.amazonses.com> <87h829lpob.fsf@toke.dk> <87muc1io8r.fsf@toke.dk> <CAH2r5msb63LFeDZ9D9dNv8tTS1yS9oLXx8tNqmjTQfXRsKrFzg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 09 Dec 2019 18:17:16 +0100
Message-ID: <87zhg1h10j.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: rTDGrpSNO_qZQRSdhR6njg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Steve French <smfrench@gmail.com> writes:

> Let me know if any additional information is needed. Reproduces with
> default config on my Lenovo laptop with Fedora with default config on boo=
t
> of 5.5-rc1

Might be helpful to know your exact hardware model and firmware version.
Also, when does this happen? When first connecting to a network? What
kind of security is on that network (wpa type, etc)?

-Toke

