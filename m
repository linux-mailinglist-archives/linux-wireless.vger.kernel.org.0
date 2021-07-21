Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4963D11BB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 16:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbhGUOQj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239284AbhGUOQi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 10:16:38 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C26C061575
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jul 2021 07:57:14 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id a16so3641346ybt.8
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jul 2021 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8dnBbcqLM6HFKu6k8qAqy2NQB4jOc43AcKD5Q4tuTwU=;
        b=qtul2um0szTmZOrPf5ZtuQbmcQZtU3yRmrBHzN+qQXo33H0NRsvh8PdsZKhUDw9UWJ
         wFWvM6r0OS4Uy4TxtvZCVkmqvomMeViBkYJSSFgEcF06qbV6sq6YV/r3+L3SejEREHBd
         MKT4K5i/AV/sor77UmWPivsB9NxJ8nKB4FCu7F47Ho6cZJVN8pCC+buyZVx5v632jUHT
         m2mrFTwNgXjWj389tZSgKwDBtNXXIYfsLh8tMV88kxfl5aqYMsND8ND2e9s9n33fgiEy
         LVoN0RSCjv6jBxPkLVOvM1M+aQa11lIe0+4JJ/AeUzKoeS98dhY7ztzESlFsPcvxeQF4
         IkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8dnBbcqLM6HFKu6k8qAqy2NQB4jOc43AcKD5Q4tuTwU=;
        b=DlhMwXui+8bymZORx6IMd/DYWWFjPP2RYLRFIDbUOid8Kg0Vo3di6M79eRf/+eQ7QF
         cCvKXavVIdsRAP3lKM4pLv5OlnkfMl8/heduq6NcIzCOK7S+0PVI45rERQ8rRv/DVuIf
         DI6MgL+9WhAJ0n4L/9ozuOwioCFPjzjhPyxnWQ4aCBZ/JSBRNrYhkIUqUB+RDsmCzv+f
         10WrsUm3mfHYJHSyGB2DQosMvGvkbz04HKix7QgUZg/1Q3h8Nem8HjiFa8v+z4zt/g9t
         un+TkZ/BJwvBpGz1z/uxSzlsjydr7djwBOzhccQwGA8tt8Yh/BN4rDSCgg1lNwFhP+Fq
         GtZw==
X-Gm-Message-State: AOAM531VKXaHBU7T/q2lUimHSP6HdOKJkYEGHfXoP63rjmI3m7Yl/51a
        8ASk0AmU7kRPw7KI0gT1cQqvrNi56NnrLAm/DB4=
X-Google-Smtp-Source: ABdhPJzSN3c+ljWxyX/DF3VpwJv1Wfr2ewgV+eAW6D89dBeRWpR8XgA2sEaVf4HeKYQrcSq6WrU4DVAuuZHcsIqy8Zs=
X-Received: by 2002:a25:b3c9:: with SMTP id x9mr45357692ybf.514.1626879433781;
 Wed, 21 Jul 2021 07:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <CANB4YXTf0DhJfL6kPa26ZCzj8FRwwdw_enGROzL-zXuWGyrwOQ@mail.gmail.com>
 <CANB4YXRtyvgu946rL=gxaRqhXja1qfBQ+DSYfiMvYcax7o45EQ@mail.gmail.com> <YPgvMph+3vRbrol3@ubuntu-x1>
In-Reply-To: <YPgvMph+3vRbrol3@ubuntu-x1>
From:   Timo Witte <timo.witte@gmail.com>
Date:   Wed, 21 Jul 2021 16:57:03 +0200
Message-ID: <CANB4YXSDuYndC26KPkV+XqPkowbN54MMceuj7MNaxh+EwLN4kw@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Germany (DE) on 6GHz
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From f9a99269b00f961e40024632c7b831c615bfa392 Mon Sep 17 00:00:00 2001
From: Timo Witte <timo.witte@gmail.com>
Date: Wed, 21 Jul 2021 16:51:40 +0200
Subject: [PATCH] add wifi6e for germany

Signed-off-by: Timo Witte <timo.witte@gmail.com>
---
 db.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/db.txt b/db.txt
index 1e5ed03..411b7ac 100644
--- a/db.txt
+++ b/db.txt
@@ -448,6 +448,12 @@ country CZ: DFS-ETSI
 # Bereich 57 GHz - 66 GHz f=C3=BCr Funkanwendungen f=C3=BCr weitbandige
 # Daten=C3=BCbertragungssysteme; =E2=80=9EMultiple Gigabit WAS/RLAN System=
s (MGWS)=E2=80=9C).
 # https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Tel=
ekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/20=
11_08_MGWS_pdf.pdf
+#
+# Allocation for the WiFi 6E Band (Allgemeinzuteilung von Frequenzen im
+# Bereich 5945 MHz - 6425 MHz f=C3=BCr drahtlose Zugangssysteme,
+# einschlie=C3=9Flich lokaler Funknetze WAS/WLAN (=E2=80=9EWireless Access=
 Systems
+# including Wireless Local Area Networks=E2=80=9C))
+# https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Tel=
ekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/Mo=
bilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf
 country DE: DFS-ETSI
        (2400 - 2483.5 @ 40), (100 mW)
        (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
@@ -455,6 +461,10 @@ country DE: DFS-ETSI
        (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
        # short range devices (ETSI EN 300 440-1)
        (5725 - 5875 @ 80), (25 mW)
+       # WiFi 6E
+       (5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
+       # WiFi 6E Short range (Outdoor allowed)
+       (5945 - 6425 @ 160), (25 mW), AUTO-BW, wmmrule=3DETSI
        # 60 GHz band channels 1-4 (ETSI EN 302 567)
        (57000 - 66000 @ 2160), (40)

--=20
2.31.1

On Wed, Jul 21, 2021 at 4:29 PM Seth Forshee <sforshee@kernel.org> wrote:
>
> On Mon, Jul 19, 2021 at 02:20:34AM +0200, Timo Witte wrote:
> > The bundesnetzagentur has assigned WiFi 6E frequencies for germany you
> > this is the
> > publication of that change:
> > https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Te=
lekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/M=
obilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf?__blob=3DpublicationFile&v=3D3
> >
> > Following frequencies have been assigned for general use:
> > 5945 - 6425 Mhz
> > maximum (200 mW)
> > No outdoor usage is allowed for 200mW
> >
> > For "very low power devices" outdoor usage
> > is allowed, but only with (25 mW)
> > same frequency range 5945 - 6425
> >
> > There is no DFS requirement.
>
> This all matches with my reading of a translated version of the
> document. Do you plan to send a patch to add this range? If not, I can
> send one.
>
> Thanks,
> Seth
