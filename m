Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740C94CC9E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfFTLIG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 07:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfFTLIG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 07:08:06 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D3B2083B
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561028885;
        bh=MAchn5o7llcfEXuTbr6cIuiUUttG8yLX0VDvViv1fzI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XbLF49rJusTls4zdmNGkAs4uYNRrYFv3ikXTSNgXtYkcqySzyJoB598gPq8ipSihp
         iwQiUoOaLNeBtu6+DGG/flxlZAhMYfXO6IlXw5ql69AiGlNgR7FBCz2AEgV+K0Ca59
         /dfuTRErPyqKVc3RTmVl9qkUEVAWAGNJ872RAAN8=
Received: by mail-qk1-f169.google.com with SMTP id b18so1566527qkc.9
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 04:08:05 -0700 (PDT)
X-Gm-Message-State: APjAAAWQJTKvY+zgnUTqLcQA9nH3U6Yc3nLKnCrPAYS4Rd3eLMjrEhw+
        EwuznlWmEIuwEwK6x6KpjvGP/1UcTZXUYo5gwu0=
X-Google-Smtp-Source: APXvYqydP9iWEJ3Fswhl+jzDLAhwma5F6sScHbipXVo6dG9YOp9It7B+HabmfabqzZ6G3BpBGp1Q6T2UEAlC6hYv+TE=
X-Received: by 2002:a05:620a:1285:: with SMTP id w5mr17296774qki.302.1561028884357;
 Thu, 20 Jun 2019 04:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <86eada55d771732ac0477a008d3c5f0a61570952.camel@coelho.fi>
In-Reply-To: <86eada55d771732ac0477a008d3c5f0a61570952.camel@coelho.fi>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Thu, 20 Jun 2019 07:07:52 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4-BhUaxrjU4b-ow5us2rZjAxgrMJnAJ2Wj0YWoFnqptw@mail.gmail.com>
Message-ID: <CA+5PVA4-BhUaxrjU4b-ow5us2rZjAxgrMJnAJ2Wj0YWoFnqptw@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2019-06-20
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

On Thu, Jun 20, 2019 at 4:16 AM Luca Coelho <luca@coelho.fi> wrote:
>
> Hi,
>
> This contains some updated firmwares for the 9000 and 22000 series of
> devices, and new firmwares for new integrated 22000 series devices.
>
> Please pull or let me know if there are any issues.
>
> --
> Cheers,
> Luca.
>
>
> The following changes since commit acb56f2fae3235195bc99ecb7d09742fb4b65e63:
>
>   cavium: Add firmware for CNN55XX crypto driver. (2019-06-18 09:12:52 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2019-06-20

Pulled and pushed out.

josh
