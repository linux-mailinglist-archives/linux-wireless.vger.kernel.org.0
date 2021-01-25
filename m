Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4743930252A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 13:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbhAYMvb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 07:51:31 -0500
Received: from maquina46.madrimasd.org ([193.145.15.46]:51497 "EHLO
        estafeta21.imdea.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbhAYMtr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 07:49:47 -0500
Received: from antispam1r1.madrimasd.org (antispam1r1.madrimasd.org [10.17.49.176])
        by estafeta21.imdea.org (ALVA Mail Server) with ESMTP id 4579D371344
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 13:25:12 +0100 (CET)
X-Virus-Scanned: by ALVA antispam-antivirus system at imdea.org
Received: from estafeta21.imdea.org ([10.17.49.129])
        by antispam1r1.madrimasd.org (antispam1.imdea.org [10.17.49.176]) (amavisd-new, port 25021)
        with ESMTP id Xl_nJ-PVyd4h for <linux-wireless@vger.kernel.org>;
        Mon, 25 Jan 2021 13:24:41 +0100 (CET)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pablo.jimenez)
        by estafeta21.imdea.org (ALVA Mail Server) with ESMTPSA id B9A3F371334
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 13:24:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 estafeta21.imdea.org B9A3F371334
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imdea.org; s=mail;
        t=1611577481; bh=nffLrjzL8ycMFIgT3Yt6m1IhFEEjZw7dRZfPYVoEx2U=;
        h=From:Date:Subject:To:From;
        b=c5AjP/U9vVMyxuk/LAOrEtN5j/cWJOx8w4OVMHtgMKUqkywMHV3Z8UmpTKQoQG0qg
         O+s90jXnK5IAIIqtqIuxv59eTLhzDub80kAOOReODfyX//iluzBk/k5CcaqS4X+REI
         AZNL/9t80mYOAt3gOosfNgVlZSNaIZB9HQWuepqI=
Received: by mail-io1-f42.google.com with SMTP id h11so25953611ioh.11
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 04:24:41 -0800 (PST)
X-Gm-Message-State: AOAM530mUD+P05/hjmS11IcCERLjS8pfJvveHo8QavbzxgUwf8uAfXA5
        iEc/T1xhd4k49t/FbEqhqXzeJNaUGvMtTP+hzDc=
X-Google-Smtp-Source: ABdhPJz4kjnkiyJghElPid01aQ28n7JEluGAXGq7L/eug+vz7JFnBQhxDdMBD+/71hYhSSLmjolg14Lt9F2+Aa5vEjY=
X-Received: by 2002:a6b:b245:: with SMTP id b66mr183417iof.76.1611577480663;
 Mon, 25 Jan 2021 04:24:40 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Pablo_Jim=C3=A9nez_Mateo?= <pablo.jimenezmateo@imdea.org>
Date:   Mon, 25 Jan 2021 13:24:29 +0100
X-Gmail-Original-Message-ID: <CAFJivsxRDcgRBPsxbG4AKh+vi5RcvpAPYdj43YTS5a3zh0fKMQ@mail.gmail.com>
Message-ID: <CAFJivsxRDcgRBPsxbG4AKh+vi5RcvpAPYdj43YTS5a3zh0fKMQ@mail.gmail.com>
Subject: [wil6210] Register mapping question
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I want to enable live debugging via the DEBUG register of the ARC600
as shown here: http://me.bios.io/images/d/dd/ARCompactISA_ProgrammersRefere=
nce.pdf

I have been checking the file wil6210.h and I understand that some of
the registers are defined there:

/* registers - FW addresses */
#define RGF_USER_USAGE_1 (0x880004)

My question is regarding this mapping, I see that the names are not
the ones of the Core Register Set or the Auxiliary Register Set (r0,
r1, STATUS32, DEBUG and so on).

My question is how could I find the addresses to those registers?
Let's say I want to write read to the DEBUG register (0x0) on the MAC
and on the USER cores, how could I do that? What is the offset to
those registers?

If successful I will try to document all hardware addresses and
hopefully implement further debug capabilities and send a patch!

 ------
Pablo Jim=C3=A9nez Mateo,
PhD student, IMDEA Networks
