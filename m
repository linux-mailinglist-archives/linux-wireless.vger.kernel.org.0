Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702DC9E74D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 14:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfH0MDy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 08:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfH0MDx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 08:03:53 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A9A21881
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 12:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566907433;
        bh=s84cD7haxf2hpTbkx/t2BSYvWRzO6ORzX2YUXXagA6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xxPlP1Um7BraHeaARaviJ7NoduW8JGTuaIOHcwjY4p0bZ+5DWEULDc4T0lw3e9RF+
         5BRBG1BBnJLSwINOVr0JOtmzobmCDMpA5zO+MAdEHAypGgY2YSs2kyHj1HcXEv0zx1
         NxuZ1mo5NUqlaEa80JmLtY5+gbVHM8Mfxun/lCDg=
Received: by mail-qk1-f173.google.com with SMTP id w18so16755081qki.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 05:03:52 -0700 (PDT)
X-Gm-Message-State: APjAAAX0epFvIRiVbQ9YH/yl9N30Y6I4SdWP91IrQ53gUhQ1DwooOj+v
        xPIVFKTwOjZ0bqT54J5JAntK8/BiIaGVTcye4nU=
X-Google-Smtp-Source: APXvYqztBvDCA4ZPMbz01lQEexDltApdWi9QxIwhlApTwLtDbt4TBF7qBMBBkvzVRgPgEvNfJA5QNA5KKYuTXp9D6Og=
X-Received: by 2002:a37:4f41:: with SMTP id d62mr20034815qkb.302.1566907432176;
 Tue, 27 Aug 2019 05:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <2a5e239858780618fa248bf825e10e3958c56bc9.camel@coelho.fi>
In-Reply-To: <2a5e239858780618fa248bf825e10e3958c56bc9.camel@coelho.fi>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Tue, 27 Aug 2019 08:03:40 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5F+-SB9m_YKz3p3JLJzJ5ADga9RHQzGYoKvQYqFMRK4Q@mail.gmail.com>
Message-ID: <CA+5PVA5F+-SB9m_YKz3p3JLJzJ5ADga9RHQzGYoKvQYqFMRK4Q@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2019-08-23
To:     Luca Coelho <luca@coelho.fi>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>, dor.shaish@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 23, 2019 at 12:45 AM Luca Coelho <luca@coelho.fi> wrote:
>
> Hi,
>
> This contains some updated firmwares for all our currently maintained
> FW binaries.
>
> Please pull or let me know if there are any issues.
>
> --
> Cheers,
> Luca.
>
>
> The following changes since commit c0fb3d9862477e31717e04e008debf6328b8980a:
>
>   check_whence: Add copy-firmware.sh to the list of ignored files (2019-08-21 08:03:43 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2019-08-23
>
> for you to fetch changes up to 40e4162adfc91390f6fbbd8269f9439832af1dde:
>
>   iwlwifi: update FWs to core45-152 release (2019-08-23 07:35:14 +0300)
>
> ----------------------------------------------------------------
> Update iwlwifi firmwares to Core45-152
>
> ----------------------------------------------------------------
> Luca Coelho (1):
>       iwlwifi: update FWs to core45-152 release
>
>  WHENCE                            |  22 +++++++++++-----------
>  iwlwifi-8000C-36.ucode            | Bin 2401356 -> 2401356 bytes
>  iwlwifi-8265-36.ucode             | Bin 2414592 -> 2414592 bytes
>  iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1467952 -> 1462068 bytes
>  iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1469012 -> 1463820 bytes
>  iwlwifi-Qu-b0-hr-b0-48.ucode      | Bin 1106204 -> 1106228 bytes
>  iwlwifi-Qu-b0-jf-b0-48.ucode      | Bin 1052772 -> 1052796 bytes
>  iwlwifi-Qu-c0-hr-b0-48.ucode      | Bin 1106224 -> 1106248 bytes
>  iwlwifi-Qu-c0-jf-b0-48.ucode      | Bin 1052792 -> 1052816 bytes
>  iwlwifi-QuZ-a0-hr-b0-48.ucode     | Bin 1105644 -> 1105668 bytes
>  iwlwifi-QuZ-a0-jf-b0-48.ucode     | Bin 1052584 -> 1052608 bytes
>  iwlwifi-cc-a0-48.ucode            | Bin 1096680 -> 1096704 bytes
>  12 files changed, 11 insertions(+), 11 deletions(-)

Pulled and pushed out.

josh
