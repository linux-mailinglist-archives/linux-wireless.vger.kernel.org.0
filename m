Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24E83BDA73
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhGFPrq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 11:47:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36426 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhGFPrn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 11:47:43 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth.forshee@canonical.com>)
        id 1m0nFv-0007um-MU
        for linux-wireless@vger.kernel.org; Tue, 06 Jul 2021 15:45:03 +0000
Received: by mail-io1-f69.google.com with SMTP id d200-20020a6bb4d10000b0290509f7e28fb5so6559252iof.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jul 2021 08:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kuH2rCrDKE4NUdJyUOHhlsE+UoTWU7LUnvgfUaQcpgQ=;
        b=exfxHEbFR9bEC855aKlu12YGa+TdX8E2L7X73hbaYDcNVAiHHv0CWsINWbdCZ1K+gt
         BksBKntM/8uEI8/Fqj74170LkfIjkfBcQTxMVGSIXdZfgiH3gQSk+QhcYsZ4wjts6MqB
         B8Z62c96w92BHsWCz0ACfQIb3pjtQ+0cE93tSIjaLLbunCbXAeCHTvgFl7zWdP2fDWbt
         yL0lCzj8luPj5Ug9TSWmTzvuh7NzZMpBlEbyYPDpJpCihv6KJpJYvqxzNwAgx4u2DnBS
         DB+1P0hFtCAQzYhDrAlvlwb/9iwRnLkfoDB8Gc13NYPb3yD9BecnlCTa5wk10023GugI
         uD0w==
X-Gm-Message-State: AOAM533rfR0EW1bDeBkNL0tGpAUs3YulCXuwelr6j6SJDn4ZiylSLht9
        aTCUmIBl/KNS0f/Klx4w1iw+GnDrWqQbKwRTs2UgAqXQ/n5ta0H6dLaWdaGO0JwJxYPGwL1+VWg
        VCi2Sx8AxQQSbDqyfMYy+ac/8G3L7SHXXPhivZsqMGFIp
X-Received: by 2002:a6b:cf12:: with SMTP id o18mr16325417ioa.86.1625586302756;
        Tue, 06 Jul 2021 08:45:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2ifZJeBGzup8i1SaHJcxs5jLJJ5iH3GorZZjVhVt3btJDDHnNMHea27CovFbBYAGEyjo/yg==
X-Received: by 2002:a6b:cf12:: with SMTP id o18mr16325405ioa.86.1625586302525;
        Tue, 06 Jul 2021 08:45:02 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:defe:f101:dc1c:6a12])
        by smtp.gmail.com with ESMTPSA id u20sm8475010ilj.77.2021.07.06.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:45:02 -0700 (PDT)
Date:   Tue, 6 Jul 2021 10:45:01 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     b.K.il.h.u+tigbuh@gmail.com
Cc:     wireless-regdb <wireless-regdb@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wireless-regdb: recent FCC report and order allows
 5850-5895 immediately
Message-ID: <YOR6fRX+RkpjWECF@ubuntu-x1>
References: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
 <YL+RDtGatz/ybG+M@ubuntu-x1>
 <CAPuHQ=GbacSTgyimkJtx1FXp319Df=LdrPQZ6ZDnPQ_JVXueKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPuHQ=GbacSTgyimkJtx1FXp319Df=LdrPQZ6ZDnPQ_JVXueKw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I've been on vacation; sorry for the delay.

On Wed, Jun 30, 2021 at 05:17:37PM +0200, b.K.il.h.u+tigbuh@gmail.com wrote:
> > On Tue, Jun 8, 2021 at 5:47 PM Seth Forshee <seth.forshee@canonical.com> wrote:
> > I think we concluded previously that both 5730-5850 and 5850-5895 should
> > have a max bandwidth of 160 MHz to permit use of 160 MHz across these
> > channels.
> >
> 
> Yes.
> 
> > We also discussed using NO-IR for 5850-5895. The regulations forbid
> > active scans, and PMTP-ONLY does not prevent them. NO-IR appears to be
> > the only option which conforms to this restriction, though that will
> > also block running an AP in this range.
> >
> 
> So we would not be able to operate an OpenWrt or other Linux-based AP,
> while other vendors would be allowed to do this? How is this
> acceptable? How does this help in liberating the band?

We're allowing clients which use the rules in the db to connect to APs
in the band. We may be able to get APs supported later on by getting
changes to break up passive-scan and no-IR. But with what we have to
work with right now, and based on my interpretation of the rules, I
think this is the best we can do currently.

> > I also read the max EIRP for clients as 30 dBm without any TPC
> > requirement. Did I overlook something which limits the EIRP to 27 dBm?
> >
> 
> The 27 dBm EIRP is needed for 20 MHz operation due to spectral density
> requirements. Is my information correct that regdb has no notion of
> specifying a separate limit for spectral density? (If it did, we might
> be able to double the EIRP for 2.4GHz of 10MHz channels)
> 
> I have summarized the reasoning in a comment of the original patch,
> but let me cite it here then (copied from the more recent link you
> have now given):
> 
> > "(iii) For client devices operating under the control of an indoor access point in the 5.850-5.895 GHz band, the maximum power spectral density must not exceed 14 dBm e.i.r.p. in any 1-megahertz band, and the maximum e.i.r.p. over the frequency band of operation must not exceed 30 dBm."
> > "the Commission limited indoor access point EIRP spectral density to 20 dBm/MHz with a maximum EIRP of 36 dBm over the bandwidth of operation (e.g., 33 dBm/20 MHz and 36 dBm/40 MHz)"
> > "To keep the potential for causing harmful interference low, the Commission required client devices to operate under the control of an access point, and limited client device's power spectral density and maximum transmit power to 6 dB below the power permitted for the access point."

Ah, thanks, I had forgotten about this.

Seth
