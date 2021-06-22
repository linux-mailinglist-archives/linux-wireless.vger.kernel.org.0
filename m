Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF26B3B05F3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhFVNl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhFVNl2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 09:41:28 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4CEC061574
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 06:39:12 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id b1so11235049vsh.7
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J28wSdJJok/UpidUjauwwEx6MtrLSmD7zBPcnbz8C6g=;
        b=L0i7+3RS+2urDkT41s3k0BUQtlEmHvSEUUBK4u/HMzzpR2Sw6aC5Ub1usDPdoaAePg
         /dM66+QC4SunNX7gd3Jl356eKELg1CWo8mu2PkQJVwKXkfZitQ6zciS2NkfQH14LRhAW
         2OdNB1hd4zXYFgFZvOART3UpOp4Ze+RuFRqRjlTGZQen8xyN4hdNFCdlA/RVXyTkxXtR
         qm8+z7H2nW+uRC7LEpvnxRXlAAor/2cXcqFeEYzZaL+fMzhWuBsIr/UW8NOQQYy5IW69
         BtZZmDUH2OBwkYcgVmTcj+anQbK+Qc8JTJhLcVFRn9DBa9herRKanPbeX7PdL6ZcAzzx
         YaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J28wSdJJok/UpidUjauwwEx6MtrLSmD7zBPcnbz8C6g=;
        b=fNOAcEX4S72BF8VnEu+hN5jRYijkPUtISCvD6lud0eMpC0Ou+uDVyAq7m5m2AJkt7N
         jd08ugUHAa2j7I+OjT5i/tDsP9OUcGitU+PjnoTVYlGfkaDvp7TlAVfdOism/ePDCWHd
         WGBcGAAnDCLpc++0mSsacJOvxd+E4w0VTgnNBAUxkHL1ZAzpXOMRJymZcTSgO2MJpgGo
         +pj9fgNzv2XJP4k1b6y1nN+A8kdIlFV4XCDLOR8x3yYtxd4g2Ekjsd5M76WX2LRoHwLI
         nNE96kh9m/IESXaoxu44EzCldZEhO77fBqUM1zDKUfR9fr6S+KXJEGmAak5rv/RCzE56
         iT6A==
X-Gm-Message-State: AOAM530HTn++KuSjDs1ZH6uc8EngspMF6JyWePIV/esvee37MXbVutj9
        7iuXC0ZJTcPkAfVeoYnvFGmjMJUaFqfWVlOMkmu+xdhwyWo=
X-Google-Smtp-Source: ABdhPJwXQQfOdzjVsR70SGiQveawqjf57Jv7JEz4eZ1mkGzMbt8E7wghKzYGDxI6BZG5fQx2wDw3Y1aeaSCD6YpRs0Q=
X-Received: by 2002:a67:ee84:: with SMTP id n4mr7663620vsp.24.1624369151344;
 Tue, 22 Jun 2021 06:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621080159.12883-1-emmanuel.grumbach@intel.com> <87k0mmjaep.fsf@tynnyri.adurom.net>
In-Reply-To: <87k0mmjaep.fsf@tynnyri.adurom.net>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Tue, 22 Jun 2021 16:39:00 +0300
Message-ID: <CANUX_P2rdkaBpKV=RTkS9ffLR89hL1yqBHskRp_Vdu8hJVrshg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iwlwifi: mei: add the driver to allow cooperation
 with CSME
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 22, 2021 at 4:32 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>
> > iwlmei is a driver that handles the communication with the
> > Wireless driver of the CSME firmware.
> > More details in the documentation included in this patch.
>
> A complicated new feature and just two sentences in the commit log? The
> commit log should give a proper overview what the patch does and why.
> This commit log really says to the reader "I don't care, find out
> yourself".
>
> And being nice I did try to read few paragraphs from the patch but as I
> didn't even see any explanation for CSME or SAP I gave up.
>

CSME stands for converged security and management engine.
It is well known and has a driver in the kernel under drivers/misc/mei

CSME is a CPU inside the chipset that runs a firmware that is also
able to control the WLAN device. iwlwifi needs to negotiate with the
firmware that runs on the CSME to take the device. The language they
talk is SAP which is just a command based protocol.
I can add that to the commit message.

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
