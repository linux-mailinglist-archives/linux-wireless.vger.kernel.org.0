Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9FF3B8627
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jun 2021 17:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhF3PUU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Jun 2021 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhF3PUU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Jun 2021 11:20:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08240C061756
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jun 2021 08:17:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso1912163wmj.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jun 2021 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Si4/3mbVmM5VJxy6bW+MVjJGaS3XheqtQW8xlZqafc=;
        b=lVdn7Lp4EpNU4LT33sKXscSBPErMV2XKU55z4P8urc0t8YbcEm9qsxXySDVbd6Jhpi
         /M0XOy/ykjXbK5sqj+hEPevj8mggSJdX9Src2vwXYC0si+/hlcUZ5JvsZgarDw+fqhMw
         dLI487lcNJnd0tqiDx4Wb1VxUR5NQ3qU0OiiVxxikSwkGNSrKfeKe988Mrombfgwra2I
         AeKP8syWoRt7lBYBZN7fnMckNW1F4gaoq2ZicmdTzSCZoQjwKQBakRaTf3Q535ycAbri
         yhdI6EWrwdprIjGMiKZy9dMMpl4toYpecYuMyeuFf7S7A1P3EHt0IOIflloO2rSSDQin
         FBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Si4/3mbVmM5VJxy6bW+MVjJGaS3XheqtQW8xlZqafc=;
        b=WC/AdiU6TZy1EWvenadr4sCgPQz0c64cGCpYRIXNGn7TsyVj7cLJfQuw9eAtpTBPWW
         ZW4TWdQRKnlRK68S119oSVJ39/ykkh7TPttrIe8XHFR9GMMokXSCmPMZaTecOSsmCc4y
         W1TJ3nHwvq2q5Ncv3py4VJqhiadvtQ0iyBRvyfE8cmT1CiL6RN0hSBlDZM0Yh1bqoM79
         2w47ux+UCxviAAVYiT/cF2DBaLANrBR8wIRMBMoBJyd5sSSKuhuSOR7KaQHbJ9NjcE/J
         PdtdgnEWNPVGuzJzczFDDsNCRwuGWP7goS4cmFX4Bs2VYteUlGKOLRvdP2mlzSjpR2VC
         1dbw==
X-Gm-Message-State: AOAM533OYsXxGENyDc6gS2mfHJ25SIZmM3nWkyIrkPoXulMXi1+F8d8R
        CB/ukewWQlNmgFSVdEV6QiNR1jp+elRVXflYmlEZRam87j4=
X-Google-Smtp-Source: ABdhPJy5IqKZx5CNsWcNRVg9j8AjosPJZAWplzawZ9lT4NWTEEgeR3s8AzFquXlEESPCdVLndObvFtw1J8TrROjN0J0=
X-Received: by 2002:a05:600c:4f56:: with SMTP id m22mr5372469wmq.16.1625066268617;
 Wed, 30 Jun 2021 08:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
 <YL+RDtGatz/ybG+M@ubuntu-x1>
In-Reply-To: <YL+RDtGatz/ybG+M@ubuntu-x1>
From:   b.K.il.h.u+tigbuh@gmail.com
Date:   Wed, 30 Jun 2021 17:17:37 +0200
Message-ID: <CAPuHQ=GbacSTgyimkJtx1FXp319Df=LdrPQZ6ZDnPQ_JVXueKw@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: recent FCC report and order allows
 5850-5895 immediately
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb <wireless-regdb@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> On Tue, Jun 8, 2021 at 5:47 PM Seth Forshee <seth.forshee@canonical.com> =
wrote:
> I think we concluded previously that both 5730-5850 and 5850-5895 should
> have a max bandwidth of 160 MHz to permit use of 160 MHz across these
> channels.
>

Yes.

> We also discussed using NO-IR for 5850-5895. The regulations forbid
> active scans, and PMTP-ONLY does not prevent them. NO-IR appears to be
> the only option which conforms to this restriction, though that will
> also block running an AP in this range.
>

So we would not be able to operate an OpenWrt or other Linux-based AP,
while other vendors would be allowed to do this? How is this
acceptable? How does this help in liberating the band?

> I also read the max EIRP for clients as 30 dBm without any TPC
> requirement. Did I overlook something which limits the EIRP to 27 dBm?
>

The 27 dBm EIRP is needed for 20 MHz operation due to spectral density
requirements. Is my information correct that regdb has no notion of
specifying a separate limit for spectral density? (If it did, we might
be able to double the EIRP for 2.4GHz of 10MHz channels)

I have summarized the reasoning in a comment of the original patch,
but let me cite it here then (copied from the more recent link you
have now given):

> "(iii) For client devices operating under the control of an indoor access=
 point in the 5.850-5.895 GHz band, the maximum power spectral density must=
 not exceed 14 dBm e.i.r.p. in any 1-megahertz band, and the maximum e.i.r.=
p. over the frequency band of operation must not exceed 30 dBm."
> "the Commission limited indoor access point EIRP spectral density to 20 d=
Bm/MHz with a maximum EIRP of 36 dBm over the bandwidth of operation (e.g.,=
 33 dBm/20 MHz and 36 dBm/40 MHz)"
> "To keep the potential for causing harmful interference low, the Commissi=
on required client devices to operate under the control of an access point,=
 and limited client device's power spectral density and maximum transmit po=
wer to 6 dB below the power permitted for the access point."
