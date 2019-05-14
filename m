Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425EA1C744
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 12:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfENKyq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 06:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfENKyq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 06:54:46 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A49D2166E
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 10:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557831286;
        bh=sfROtJyJvbXTyfXmcjKTQsK+QNZQayNvVmxuBao/JH0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ezlIjubQpMoYzozoFSp52Y8fffxHHb9WRuOMeEWcPJj7e/Salm3IT6lAUDzAWoqcU
         FMBD7CBVaesp5BxFegVMEvkKlCmwq2zjvOhAtdZ98XpPdaoFHlNrBh/mLDaMrcUuPX
         hJ+TZv1AT7dJsxLbE8ZVdV33IlIDkDGnK5s0aw7U=
Received: by mail-qt1-f181.google.com with SMTP id a17so17109591qth.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 03:54:46 -0700 (PDT)
X-Gm-Message-State: APjAAAUGyUe7zRTOa72yG9MZc8Qco6TKbouLY0WbB7IpXkRsJANwmxuE
        mYFRMSZbS2n9lNHaQW7kVvmG1DCuks8Rw2FMHqs=
X-Google-Smtp-Source: APXvYqzVEudAngmazxlnYPHElobyRR6ElyaiODyA+Kv/Co0jQumNg48ltBsZZEwbMETHlYVjpxaU2tz7E6bNGkb710A=
X-Received: by 2002:a0c:8aad:: with SMTP id 42mr27561243qvv.200.1557831285254;
 Tue, 14 May 2019 03:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <1546157106.3213.3.camel@intel.com> <76e0ec375091a0b0f16d3cd9b15abc7b1840e89d.camel@coelho.fi>
In-Reply-To: <76e0ec375091a0b0f16d3cd9b15abc7b1840e89d.camel@coelho.fi>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Tue, 14 May 2019 06:54:33 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5DO6fGiFa0x3jfbEgWUJaFaFS1ivu=Y60xUG=Kx1MexA@mail.gmail.com>
Message-ID: <CA+5PVA5DO6fGiFa0x3jfbEgWUJaFaFS1ivu=Y60xUG=Kx1MexA@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2019-05-03
To:     Luca Coelho <luca@coelho.fi>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 3, 2019 at 1:16 PM Luca Coelho <luca@coelho.fi> wrote:
>
> Hi,
>
> This contains some new versions of firmwares for the 9000 series of
> devices and the firmware for a new device, namely 22260.
>
> Please pull or let me know if there are any issues.
>
> --
> Cheers,
> Luca.
>
>
> The following changes since commit 92e17d0dd2437140fab044ae62baf69b35d7d1fa:
>
>   amdgpu: update vega20 to the latest 19.10 firmware (2019-05-02 06:24:19 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2019-05-03
>
> for you to fetch changes up to 95a93535b723085ff74845eb8733d01c8ff5c052:
>
>   iwlwifi: update -46 firmwares for 22260 and 9000 series (2019-05-03 19:33:53 +0300)
>
> ----------------------------------------------------------------
> updates for -46.ucode for 9260, 9000 and 22260
>
> ----------------------------------------------------------------
> Luca Coelho (3):
>       iwlwifi: add -46.ucode firmwares for 9000 series
>       iwlwifi: add firmware for 22260 and update 9000 series -46 firmwares
>       iwlwifi: update -46 firmwares for 22260 and 9000 series
>
>  WHENCE                            |   9 +++++++++
>  iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 0 -> 1448644 bytes
>  iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 0 -> 1456088 bytes
>  iwlwifi-cc-a0-46.ucode            | Bin 0 -> 1044072 bytes
>  4 files changed, 9 insertions(+)
>  create mode 100644 iwlwifi-9000-pu-b0-jf-b0-46.ucode
>  create mode 100644 iwlwifi-9260-th-b0-jf-b0-46.ucode
>  create mode 100644 iwlwifi-cc-a0-46.ucode

Pulled and pushed out.

josh
