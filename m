Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60731298D83
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Oct 2020 14:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770490AbgJZNK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Oct 2020 09:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404344AbgJZNKZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Oct 2020 09:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603717824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=et3kBMVvmEKrepF7XtX8Goew8HAC49Ia+764yZJnI0Y=;
        b=IzTHbg4IPoMVO4tpEg3P8wnNyKk1jcEadtKgSDn5gSNzRudlBe8jR0oIqEOwiOJFQnk/rb
        YGqiIYtOchmXis64nYoG+I/d+xeXgShOybUj7b3VJvuXRmzjCXPXArqRBdFiuPZXvphEo0
        CP+L49k0klxG2hjlG2+eBoFR6/8LXao=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-v9H0yD2cNpCCh_Xl3PGVqw-1; Mon, 26 Oct 2020 09:10:22 -0400
X-MC-Unique: v9H0yD2cNpCCh_Xl3PGVqw-1
Received: by mail-ot1-f72.google.com with SMTP id n21so3529184ota.18
        for <linux-wireless@vger.kernel.org>; Mon, 26 Oct 2020 06:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=et3kBMVvmEKrepF7XtX8Goew8HAC49Ia+764yZJnI0Y=;
        b=cpz8mgNPm++JY03G+qRzrxFvZSaYVx/j+2SPe90fvm6saFaaJT8IHDvbp6i4+pzD1Q
         LtC72Y7BlYA9yLMXylslKyCjR52Q7x9YzpDL/lJnsS5feULsd3CZO+iS3sYg2lnJeLes
         xuSKWBLYBPi2vjs0+NGSHfCoK/zCVczQ90tVv7GKv+/s7ceCinjDNSlbaOuVffocqtVr
         Bjd8zy9bC78CHriWE9Ah25oUB8rkG8gcUzpjTVOq0fAgWDH5trv1dyBm19BtBdN8nu6E
         /HTF7M+BfF6Viens+sW6Ph9nufWut45XpqiigGv04tfzBxF9YMaVmb78aDhnGbD27Bcg
         UK2A==
X-Gm-Message-State: AOAM5323ndYAdv5ytEb6GAVdxxG3iNuQsUbmyAMtrPZvduhD/VKLs2/i
        NEoUuv5TD+xGq3yiRHNh31wocLC6KS3jXwqb6rCYoNClPtKx5tHF998DwjBKragbeehkKAqgdtq
        1ft7DT0Ibcsu4RAZCFwN4ZvnvMOremCCosam0259esNQ=
X-Received: by 2002:aca:c485:: with SMTP id u127mr10497754oif.92.1603717821818;
        Mon, 26 Oct 2020 06:10:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGx1+wbrUkTBgg9rBxw7GgRgKG5GyViwh18Iog1g4tZh6X7fliCsJ+aS6RvAB6nHcqCsXWQ+qA3vi73uofsn8=
X-Received: by 2002:aca:c485:: with SMTP id u127mr10497730oif.92.1603717821554;
 Mon, 26 Oct 2020 06:10:21 -0700 (PDT)
MIME-Version: 1.0
From:   Jarod Wilson <jarod@redhat.com>
Date:   Mon, 26 Oct 2020 09:10:10 -0400
Message-ID: <CAKfmpScwQ2w_CKu0=goRNAFoRd8RpqXQHHREYOEXSvNPzupytg@mail.gmail.com>
Subject: mt7601u panic on device removal
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Started noticing somewhere in the 5.9 devel cycle that removing a usb
wireless adapter driven by the mt7601u driver, that removing the
device after using it leads to a panic 100% of the time. With earlier
kernels, I believe it didn't panic, though I did get a slew of Warning
messages about TX and RX DMA not stopping. Further details in
bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=209571

-- 
Jarod Wilson
jarod@redhat.com

