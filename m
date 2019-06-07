Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A98386FA
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 11:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFGJZy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 05:25:54 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:46503 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfFGJZy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 05:25:54 -0400
Received: by mail-vs1-f48.google.com with SMTP id l125so735557vsl.13
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8X/ZmOPmL8SqGAoePMmzgcyuaultg3+XQoJ7mnWPbK8=;
        b=Vp42f6Io8HkTyFQnujby1DtbdczxU+XZepEBphNXKC1mF3NBVDRzhJHmiqQ2mlJPrG
         kiyxwIh1r8US9EjGcVwtClqaRIZ7cpi+s8xsebOEjQ5m1ySqbQRlXbSpU4ZPKaKWOl3V
         McbJcpn/J4TU3nFCZ2I4E3RDBaZZtUSOav/6fa8nfSZsCGYJfVtFf++/GnA+yBmLOOSl
         vnmS3AqcGhXYtrR4aSC9hmWvYjxQ57nmFG/GtdiDONwDs+VClwAvv+irKOq5Fp/OQpCX
         5VmC+NGoOOpmXKGaCaLCnxVpIKH2qVjGkxIBZEDhJjm9Q82HpVMsmO8kw+MIaeNN4kDE
         ahZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8X/ZmOPmL8SqGAoePMmzgcyuaultg3+XQoJ7mnWPbK8=;
        b=b6lvJkYxD+9EhLNzt/GvKr+o/S1IQuNkEq0B9D97Rl+TMY9ORAG+OnLd5eAS8IhVFu
         afauZZo1MnXLQ/IrQZSttqY24N0R0r4YU7IAuxfi1IHPa5DIdHsoJ4R/UtN7fhmkx0M1
         hPpeMbfjONcq1WTRqx5me/CAn7mSXGStvJ1bYTp1qZtUUiSNV7KXhHstI0k2Of0pOy0A
         PSMmLQxrwBshkS5YJKrl3xPtW5KwviQQY0hKqZV7i3Atuq9RWEoTSQ9w3VUe8k90+OMc
         R96Os988vH0T3HOJ4y8nl8HiGj9cPfE9OcuL2z/Gn0qgvo7XHKBEndOUWcqKbqmjNeDl
         CfiQ==
X-Gm-Message-State: APjAAAUpWB5AlEL0+ZLLUu07jnGidy7SbycTLmKplVLPu/w21dx4SpOf
        QaQRDmItvIYhlct1X9PMTLQVTyFzg8jscYSaW5s=
X-Google-Smtp-Source: APXvYqzolCsBIvCHXaz/ibQiJtihaqLjlDqYspApMEcI80lA4FRoFcfTnUSGE1VK6ivUmup1gLtg9RKZdGe9a8bZ/Lc=
X-Received: by 2002:a67:8081:: with SMTP id b123mr18732946vsd.117.1559899553616;
 Fri, 07 Jun 2019 02:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <2455026.F8Aexx8IWb@zadesk>
In-Reply-To: <2455026.F8Aexx8IWb@zadesk>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Fri, 7 Jun 2019 12:25:41 +0300
Message-ID: <CANUX_P0=F4-Q5Drhcpk6-y7F7Ub3omQk=Pg6wh3pv=pLc9YHWQ@mail.gmail.com>
Subject: Re: iwlwifi module crash
To:     Balakrishnan Balasubramanian <linux-wireless-list@balki.me>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 7, 2019 at 5:22 AM Balakrishnan Balasubramanian
<linux-wireless-list@balki.me> wrote:
>
> I am using iwd demon for wifi. Once a while I loose connectivity. Restarting
> the demon does not help. But once I restart the system, it starts working fine.
> Attaching stack trace from journal.

This is because the device is removed from the PCI bus. Nothing from
iwlwifi side can be done.
If that happens upon suspend / resume, I know there are been fixes in
PCI bus driver. If not, check that the device sits correctly in its
socket.

>
> Regards,
> Bala
>
>
> ---------- Forwarded message ----------
> From: Denis Kenzior <denkenz@gmail.com>
> To: Balakrishnan Balasubramanian <iwd-lists@balki.me>, iwd@lists.01.org
> Cc:
> Bcc:
> Date: Thu, 06 Jun 2019 18:07:40 -0500
> Subject: Re: iwd crashes randomly
> Hi Bala,
>
> On 06/06/2019 06:00 PM, Balakrishnan Balasubramanian wrote:
> > Sometimes after a week and sometimes after two days. Once crashed, restarting
> > the service does not help. Had to restart the computer. Attaching stack trace
> > from journal.
>
> That implies that your kernel is crashing, not iwd.  The attached log
> shows a kernel stack trace somewhere inside iwlwifi module.  I would
> post this trace to linux-wireless@vger.kernel.org.
>
> If you have an associated iwd backtrace, then certainly post this here,
> but if the kernel module is crashing, there isn't much we can do.
>
> Regards,
> -Denis
