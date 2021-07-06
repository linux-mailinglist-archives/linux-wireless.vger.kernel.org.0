Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44553BDA85
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 17:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhGFPy0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 11:54:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36595 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhGFPyY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 11:54:24 -0400
Received: from mail-oo1-f71.google.com ([209.85.161.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth.forshee@canonical.com>)
        id 1m0nMO-0008V6-Lv
        for linux-wireless@vger.kernel.org; Tue, 06 Jul 2021 15:51:44 +0000
Received: by mail-oo1-f71.google.com with SMTP id b1-20020a4ac2810000b029024bec618157so10718306ooq.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jul 2021 08:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fnkhej73dUEU6YVyHpWgnSTg07nu+TcT/vupwjNhaLI=;
        b=DcbXtQ/Sc4EIzKGD6MR0wDlexvIRBuoqqo9ppVnXbOo+CzID3EBO4IjaLu99rX33vU
         DEs6KDXQEtg01ZAurPTvoiJqrCrtkxx8EksJoc84rv7isNJEZ52WoSJ3/UdkelLc7UEF
         2dAWK32FdXhhxT6BbS+3/yoPIgkCwjmpWF3ptTxjB6EaVAJmAPqBH+ZMXWTanJhbZLEF
         R68MBUYKNWDTPsFB+/jaEDGsDWljUuExmR3xsZzBCFuFXhtpYq1G+E903FFScd0a9rlz
         ZP2V9BxnpSQ5juuuDf8IKbG+7Nf2ptfZx1yQSTMcUx6RUB3mBJzL1JP7J7Phgk4ryOHv
         EHtQ==
X-Gm-Message-State: AOAM532ojnwuz5wLRPe+zfAus1AUTt5wHbbGMhR5QD4DZbDcN2vUtUlK
        1B1fOylm8/aWrN45takNItKIlAb1FL2iUtsgpms+yznzI1zRk27nMusJkAYRQNNxLMcQI/So2Ga
        ioArimgCSVviRQ3Zhw3degwL0I4h17Q4iL2IPFRYHGjVm
X-Received: by 2002:a05:6808:13c5:: with SMTP id d5mr14425762oiw.163.1625586703634;
        Tue, 06 Jul 2021 08:51:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBKAaApSJkPVh9B6CsP17jzAs2R8fEQgoy9gIBqHOb8MGhQe8WFfzQViYkxBXDh0tg2AkukQ==
X-Received: by 2002:a05:6808:13c5:: with SMTP id d5mr14425754oiw.163.1625586703385;
        Tue, 06 Jul 2021 08:51:43 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:defe:f101:dc1c:6a12])
        by smtp.gmail.com with ESMTPSA id w15sm1539207oie.21.2021.07.06.08.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:51:42 -0700 (PDT)
Date:   Tue, 6 Jul 2021 10:51:42 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     bkil <b.K.il.h.u+tigbuh@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless-regdb: recent FCC report and order allows
 5850-5895 immediately
Message-ID: <YOR8DtyIkVP0fg3f@ubuntu-x1>
References: <CAPuHQ=GbacSTgyimkJtx1FXp319Df=LdrPQZ6ZDnPQ_JVXueKw@mail.gmail.com>
 <10ffaa74a0779b7c7047de70cb1db7dfb0000022.1625068999.git.b.K.il.h.u+tigbuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ffaa74a0779b7c7047de70cb1db7dfb0000022.1625068999.git.b.K.il.h.u+tigbuh@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 30, 2021 at 06:03:20PM +0200, bkil wrote:
> The new band is called U-NII-4.
> 
> The report recommends combining it with 5725-5895 to allow 160 MHz
> bandwidth, but that's technically not that easy with regdb due to the
> differing restrictions of the two parts. Marking the line for U-NII-3
> NO-OUTDOOR and PTMP-ONLY along with extending its range would be a
> possible workaround, but this needs to be discussed.
> 
> I don't see a requirement for TPC, hence reducing EIRP by 3dB is not
> needed. I've marked it 33dBm (minus 6dB for clients) to cope with 20MHz,
> but the band can support higher power, though the logic is complicated.
> 
> The upper subband (5895-5925 MHz) of the new band is reserved for ITS.
> 
> "We limit unlicensed use to indoor operations in recognition of the
> potential that ITS licensees may currently be operating"
> 
> "We also proposed that U-NII-4 devices be permitted to operate at the same
> power levels as U-NII-3 devices."
> 
> "For the U-NII-4 band, indoor access point EIRP will be limited to
> 33 dBm/20 MHz and 36 dBm/40 MHz. When combined with U-NII-3 band spectrum,
> indoor access point EIRP can scale to 36 dBm for 80 and 160 megahertz
> channels."
> 
> "Client devices would be limited to power levels 6 dB below the power
> limits for access points."
> 
> "the First Report and Order prohibit U-NII-4 client-to-client
> communications to protect co-channel incumbent ITS"
> 
> Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>

Applied, thanks!
