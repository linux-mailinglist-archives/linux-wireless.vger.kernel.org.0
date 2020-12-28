Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231542E693E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgL1Mxi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 07:53:38 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:43926 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgL1Mxh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 07:53:37 -0500
Received: by mail-lf1-f46.google.com with SMTP id 23so23602282lfg.10
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 04:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=vxAlMapaod3+O0NUmclUFGKXI89e2iNbe2epUOzmG28=;
        b=egDfktNLk1EeXQ9JGyn4XJs9gygb7sPiEYi/ITTyxUZbyCA3+7cQ2KOW5YsOPwbx1D
         zi5U559jymLmpLGVWlcTNrs7bI8MN1OzlZIMkGEp7ZgXSiA2jI1bjpjpn8EyeTK3R/PJ
         kpNuQMNLjiJJSKFkG5KFuPUQA3EpVqLMB4Fwz82p0aehoY2Bi+96z009V9sPfRKI375W
         P9PS5btGnUkewIpz99VKCkkT5WrtpBftIHGMZr6YGoqVytDqq3OWe0waAVAjxPUlifqK
         LTPE1y2rfpRdXd1ixJ3kJMdWWiRUgQeHd9QAwIQTdFAjiv3dgsLiAxMdcNPqubcQup+Y
         2jmQ==
X-Gm-Message-State: AOAM530TiVJHtepG3hrfi7QPQmhpsPbkjcDy0Iw+JrTkfkuwEWs9ZYGI
        eD1Sle8HQnyBjAE6oDMi/N1NIU4yRqO4HA==
X-Google-Smtp-Source: ABdhPJx82p5+bO6JVlsBymD7usJrnrhtUW2MHSfrEJ+fGKuavmmYfrhuGNq7WJAQFyzD7t0+oxZftQ==
X-Received: by 2002:a19:8149:: with SMTP id c70mr18302691lfd.502.1609159975331;
        Mon, 28 Dec 2020 04:52:55 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id m8sm5278239lfg.134.2020.12.28.04.52.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 04:52:55 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id y19so23525492lfa.13
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 04:52:55 -0800 (PST)
X-Received: by 2002:a19:4107:: with SMTP id o7mr18231670lfa.512.1609159975057;
 Mon, 28 Dec 2020 04:52:55 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Martin=2D=C3=89ric_Racine?= <martin-eric.racine@iki.fi>
Date:   Mon, 28 Dec 2020 14:52:44 +0200
X-Gmail-Original-Message-ID: <CAPZXPQdpcvjCBqzCGt55Fz0iAx6Dn3MB7hMfzPgoeejK6-AYQg@mail.gmail.com>
Message-ID: <CAPZXPQdpcvjCBqzCGt55Fz0iAx6Dn3MB7hMfzPgoeejK6-AYQg@mail.gmail.com>
Subject: AP support in iwl4965
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(non-subscriber, please CC me in replies)
Greetings,

I was wondering whether there's any plan to implement AP support in iwl4965?

Given how this is MIMO-capable multi-channel chipset (2.4/5GHz,
2x3:2), being able to use it as an access point with hostapd would be
desirable.

Cheers!
Martin-Éric
