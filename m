Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E9DDE826
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2019 11:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfJUJez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Oct 2019 05:34:55 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:45915 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUJez (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Oct 2019 05:34:55 -0400
Received: by mail-il1-f175.google.com with SMTP id u1so11344561ilq.12
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2019 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PJBlx8MUt4FojMRZ9wTw+AdBZ7uXuAxeK3s1S608x0E=;
        b=NcOj25e2KNatmN6nDma6o13Ze4M+fZpGymZQeZX4f4Fu9Eu9aaJqtM4gPYVPgZIfTj
         +HxdDXTQuI8AChGZDxcg0wj7z7mOGJitbx/z9up2+MSA30plbvw2t457pitX9yffpZCa
         p4qre1yOx6rk/MooqvXE0NOqve0cE/4eeNE/fsvXmJc3dY0axspfDMVaL5ELiZ/yLvhd
         LPotMIU9nQa0XmXgLapviROb3N6lsDSqER7/DOELSTSdI/S9AndhR5TbkNB1y4K66DL0
         l133elmnORHtDse8L70z1r8+JfRNKM4NnbjqaCtpE+EUv7QIWmx4L3ZP2FxhMT4/fi4q
         TjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PJBlx8MUt4FojMRZ9wTw+AdBZ7uXuAxeK3s1S608x0E=;
        b=GBo6kmLNP88PJsHcB/cXMpLImE5nBSh3dlfqxIBEyH8iz2dE5t1jCup1MFpVZaSWsw
         FodvsN+1lwkVXgqa26kc60VMIrAOwW9lRd0+42lhpu8C1HRlFHPDi/1MLc5SiXu3qLd/
         IVQUBGnTsX3+kH6z+eIdLa+TS/Gx1d2n4aNl58juhvsvf5xyr7jviLq4EaVhE8g6os7/
         HAY1qCiZR0GfClFsJjxuFSdcbzs4JkzOM1QMTQwfVjK+wZ7N1B5LNZXW++YELl7p4r8Y
         zQdh6xZM9XEO1FGuLBNF1BM8RcXqWdXmYffhXZaI4bhquoWODPulIl5SuzDuSMfFgyfR
         LJvA==
X-Gm-Message-State: APjAAAXclAhbdjw9+QtMXlcjKD3hOEb/7248rBAKEQMPtShFF0FJvdOs
        bPYYPIAN1ch5m9aS5NWhkXnFXhmG/U8I1j6CNpVt9g==
X-Google-Smtp-Source: APXvYqzPMD865o43bnHMqAuU2oi9xl45HisKyHg8Gh+4uY1NbKyQkxhMbeFBmbZI7gBfEvM7P3kIewvPg8FUZlregD0=
X-Received: by 2002:a92:3c1a:: with SMTP id j26mr25619113ila.167.1571650493347;
 Mon, 21 Oct 2019 02:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <CADh-Cm=umBWCkz41-e0-PDnDrbpfQi_PRdT--SePmQLCqj5rwg@mail.gmail.com>
In-Reply-To: <CADh-Cm=umBWCkz41-e0-PDnDrbpfQi_PRdT--SePmQLCqj5rwg@mail.gmail.com>
From:   Ryan Adolf <ryanadolf123@gmail.com>
Date:   Mon, 21 Oct 2019 02:34:42 -0700
Message-ID: <CADh-CmnrWe_hrdfs3RqL0mF4ipAxthUgE3=eBSvaiudbEtsQvw@mail.gmail.com>
Subject: Fwd: iw package typo in help command output
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

First of all I'm not sure what the policy of this community is on
typos. It's my first time contributing to iw :) If you consider this
too minor to fix, I understand. The package has a lot of amazing stuff
to it.

While reading through the output of `iw help`, I noticed that
"timestamp" was misspelled as "timstamp":

event [-t|-r] [-f]
Monitor events from the kernel.
-t - print timestamp
-r - print relative timstamp
-f - print full frame for auth/assoc etc.

The erroneous line seems to be
https://git.sipsolutions.net/iw.git/tree/event.c#n1175.

Thanks,
Ryan
