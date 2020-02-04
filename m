Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A215150E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2020 05:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgBDEmb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 23:42:31 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:45976 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDEmb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 23:42:31 -0500
Received: by mail-il1-f177.google.com with SMTP id p8so14692624iln.12
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2020 20:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=q0qFMAPlpIif/WUzkvX+0vWo8RAka1cyW/tA0f1CbCk=;
        b=fuvODWxspwX6QN0Ji6snZD4cM2tiTmsGEakE6/d4oQpZGutRu8cyOSIdGrf1acT9wT
         m69fAJF/1ViJOUltNXdnFtCQxj7XjkbZkP/8Ad5LH1112dkqrNQDrTcY5GnBHomPwpwp
         mLkMB0iCluhMjaqk4C56j8dr0qS9BKNeX75M6IRPs7o68qqDhP4P78q06FSkysw4JGDW
         +UChtvs8UY++Rw1nmg5+NnO8vB9ESpOHKNX2fYXdnsRknCBWscjwITBcgBSw8ALh6QlH
         YeiBoJWEBdgHrJeX/sBLXgbjFQmQc3BpNFNFc8wcsemenjfc2gD03QrxAcud67XnxoSI
         Nlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=q0qFMAPlpIif/WUzkvX+0vWo8RAka1cyW/tA0f1CbCk=;
        b=n6vItmJglrtdu0DGLWsGBp/01hkBERnh+V5RT3Av835khrHaDMZc3JXDXWAb7BwfYj
         j1DSVbiaKcXHi/CsMrY0nMEvjQdBQqPfQr/2wuhSafsEeXvVKAg2T+KUpy/ZbfOYy8Kt
         NEa3o/gQ6qlhJD3MM0/J8T4oqkJ4VJ2tHdIJPha+gbAvBxNXJsUM8XDmSObVF/fkDe6X
         taUSUsfktnCQ7DL0joUMvurc2m60Xb1WAz/BMumoJmp6eXDoerMnj32uhPSVh8OMd95A
         Jez3NpHqzONP5FcaXBvJ6ililkP3bh0wWeSO1kcmSStSy6cwRNpb2t1SyUrMMiWSKZGs
         MY6w==
X-Gm-Message-State: APjAAAVNjiB5YLe1QawVv8/ddS4yP45an+17ZoxfjOBVRVwr+V66O70u
        8xSiI/yeX6uncKZQTisjGbxuakG9TROslMrhcsLb2DMK0Ts=
X-Google-Smtp-Source: APXvYqxNenXES/xcoAwPNtNGrJpwU9ozyAeMVxrYnEGD1wlVEsQ20p38ePYzyPV/38fAIaIgbImc38CkTWQHb5EbkkU=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr17943555ilq.306.1580791350294;
 Mon, 03 Feb 2020 20:42:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5d0d:0:0:0:0:0 with HTTP; Mon, 3 Feb 2020 20:42:29 -0800 (PST)
From:   JH <jupiter.hce@gmail.com>
Date:   Tue, 4 Feb 2020 15:42:29 +1100
Message-ID: <CAA=hcWQo-NhePgyFhQ-OxP-7xTdM+zVf+cWN+Owpjfk+Mgs6dA@mail.gmail.com>
Subject: 
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     connman <connman@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am running kernel 4.19.75 on iMX6, the WiFi was working most of
time, but from time to time, the connman could not get WiFi be
connected due to following error:

[23703.958751] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters

What does that error means, in which circumstance it occurred? How can
we prevent it?

Thank you.

Kind regards,

- jh
