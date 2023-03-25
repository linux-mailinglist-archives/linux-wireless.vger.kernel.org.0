Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24016C8EEC
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Mar 2023 15:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCYOzw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Mar 2023 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYOzv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Mar 2023 10:55:51 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462F9F97F
        for <linux-wireless@vger.kernel.org>; Sat, 25 Mar 2023 07:55:50 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g19so4225860qts.9
        for <linux-wireless@vger.kernel.org>; Sat, 25 Mar 2023 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679756149;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQgqe5+AQbVbAQaTBfv+LXJe8JsbtvbU6wmximPDe8c=;
        b=RabBr6FngvE1RlU+bQgS4QVj3NCPan3TnzMbJntlq7Rifrn2V6YL2u2rm1L8Tbrt0R
         9Isu9qfdbqr60V060H+gtnZ74W94WlsEEzxy/sczdX4Kd6cQ/wkN/D+l+RvEWl7EX4FI
         fH73UjaPqrEtEzA0mULs/lvWT1oSvkH8KUoZEXfyHKQoBDkPnwhLTozdxRE1tmrHcyPm
         6npiV5LatS2ZW+9NH9g2e91siyyX+k9tBrTGHNpk8CCTxCL7TMpivFqNht/GpUqbUa+P
         vce6vD0b+K3d4QpMiO3Z7UmcTokIJX11D8wouuc2Bs+ACvA3C/CcJxNftheq+v1c9UZ1
         YVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679756149;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQgqe5+AQbVbAQaTBfv+LXJe8JsbtvbU6wmximPDe8c=;
        b=GSfMFWDOJuiJ7M8sgEzjSikRuRppscGYGdZeAId0mYeeju1d2hf7rFVPokE8UW5cJn
         4RpkavDlWY9UHLX4KUF+d1a4XaQYaCUugzQMp6K7MO3W8GlpbIa6FIRq6l12zdRgIs/V
         war+vsqsrRXVRfE5oI2wgC4hsDUrfPZm0ttucVDV+oNd0wqc2oIH8T3kSCbgzOGt6r60
         EMZz/5vZS0mBV16AIyqtjHkF9ASlWbTlZNy++HUhdy5OHoH+04T/TnF1/JKq2FJYad2m
         ftZ+kpEc85c6Adslh41f4+tzI4OeOME3AmZOb1XlkU3orn/Hk9GMNMEMYRPW7tUUaR1u
         hZYA==
X-Gm-Message-State: AAQBX9fuXpPrhdbwIlNSFr76Rz2ig/6vZqScARudxmEqNi0fhQng31xj
        pk5XjQRIT5LQKiGikGcl0Vi+CAziOjyof8/qdEw=
X-Google-Smtp-Source: AK7set8CQgD0tZr6tBrqJfgfYYjaoawjjNUaY1nK0FKdjGkZmQk8N7aDvb6BNlB9T/zjmWLC3D3kEsY7GUvnhntJX7E=
X-Received: by 2002:ac8:5905:0:b0:3de:1720:b54b with SMTP id
 5-20020ac85905000000b003de1720b54bmr2355518qty.0.1679756149308; Sat, 25 Mar
 2023 07:55:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:f389:0:b0:56e:c5f4:412e with HTTP; Sat, 25 Mar 2023
 07:55:49 -0700 (PDT)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <pa5328675@gmail.com>
Date:   Sat, 25 Mar 2023 07:55:49 -0700
Message-ID: <CAAFtOb8Rirqj9aLiOcWtX3ktmqmA=fSPY7FQvLX2CuH=T0Dw9A@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prosz=C4=99 o uwag=C4=99,

Jestem pan Abraham Morrison, jak si=C4=99 masz, mam nadziej=C4=99, =C5=BCe =
wszystko w
porz=C4=85dku i jeste=C5=9B zdrowy? Uprzejmie informuj=C4=99, =C5=BCe pomy=
=C5=9Blnie
sfinalizowa=C5=82em transakcj=C4=99 z pomoc=C4=85 nowego partnera z Indii i=
 teraz
=C5=9Brodki zosta=C5=82y przelane do Indii na konto bankowe nowego partnera=
.

W mi=C4=99dzyczasie zdecydowa=C5=82em si=C4=99 zrekompensowa=C4=87 ci sum=
=C4=99 500 000,00 $
(tylko pi=C4=99=C4=87set tysi=C4=99cy dolar=C3=B3w ameryka=C5=84skich) za t=
woje dotychczasowe
wysi=C5=82ki, chocia=C5=BC rozczarowa=C5=82e=C5=9B mnie na linii. Niemniej =
jednak bardzo
si=C4=99 ciesz=C4=99 z pomy=C5=9Blnego zako=C5=84czenia transakcji bez =C5=
=BCadnych problem=C3=B3w i
dlatego zdecydowa=C5=82em si=C4=99 zrekompensowa=C4=87 Ci sum=C4=99 500 000=
,00 $, aby=C5=9B
m=C3=B3g=C5=82 dzieli=C4=87 ze mn=C4=85 rado=C5=9B=C4=87.

Radz=C4=99 skontaktowa=C4=87 si=C4=99 z moj=C4=85 sekretark=C4=85 w sprawie=
 karty bankomatowej
na 500 000,00 $, kt=C3=B3r=C4=85 zatrzyma=C5=82em dla ciebie. Skontaktuj si=
=C4=99 z ni=C4=85
teraz bez zw=C5=82oki.

Imi=C4=99 i nazwisko: Linda Koffi
E-mail: koffilinda785@gmail.com

Uprzejmie potwierd=C5=BA jej poni=C5=BCsze informacje:

Twoje pe=C5=82ne imi=C4=99:........
Tw=C3=B3j adres:..........
Tw=C3=B3j kraj:..........
Tw=C3=B3j wiek:.........
Tw=C3=B3j zaw=C3=B3d:..........
Tw=C3=B3j numer telefonu kom=C3=B3rkowego: .........
Tw=C3=B3j paszport lub prawo jazdy: .........

Pami=C4=99taj, =C5=BCe je=C5=9Bli nie przes=C5=82a=C5=82e=C5=9B jej w ca=C5=
=82o=C5=9Bci powy=C5=BCszych informacji,
nie wyda Ci karty bankomatowej, bo musi mie=C4=87 pewno=C5=9B=C4=87, =C5=BC=
e to Ty. Popro=C5=9B
j=C4=85, aby przes=C5=82a=C5=82a ci =C5=82=C4=85czn=C4=85 sum=C4=99 (500 00=
0,00 $) karty bankomatowej,
kt=C3=B3r=C4=85 dla ciebie zatrzyma=C5=82em.

Z wyrazami szacunku,

Pan Abraham Morrison
