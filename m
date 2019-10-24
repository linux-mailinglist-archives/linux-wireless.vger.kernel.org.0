Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C5CE27B7
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 03:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392295AbfJXB3o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 21:29:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38406 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbfJXB3o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 21:29:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id p4so21829481qkf.5
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 18:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbIr1oDSQ4EPbvIHPFNZbAyS3NB93QhbsBV4jJ3VP1k=;
        b=tzh0AgOXkfbqhCuKFKxoKO7S4f9RzUekJ6ryKIIbV668YrBdWD7X/nPXj2f1VVxHEy
         VbIbGZybsXTfsQq8QT0dYS/lDSbUsnIA/RT6lw8yRXVsnf0DFKpounTkPcrYTyAYYGUK
         7Cn6722/+MM9G62uEBXkJx8mFzUQRlMwnwdd0UoU0mI/t0PQVPWr+i8NSLSVv2u9JGMw
         1z01K77rP3W0k4t8m+a6LRR70wOI5LRBa8HXcBgzzm2TeY/IzWL2lXQY4DOMNpiYjCIH
         U1bgz/5/2itAThK5rRkmZxP9kPue0G1SGWpjW38LcKvqPceKFgc+pU6bc+UQGcz+jd5a
         K2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbIr1oDSQ4EPbvIHPFNZbAyS3NB93QhbsBV4jJ3VP1k=;
        b=NdMz/v+8smCkvC+3aeSM+EbGv3ku86dC6xleLssYbymP/1zLZDiTIZYi/+O1AsnauY
         jPkMHWDu2TcoycOTlxo7huh00u36UDr2OELwwpV914m1t0Su2ouEMfVlZikFzKDw2gZX
         bAi60G2dk5CwzhHGUFg3zwBBXufy5qvN1NSRIXLUzfzk4vDTqYovJIx8ETrIl5nDR7IZ
         1wwVxvmV5pgCxWzMZDZ997ypEj2/RY9/8HWGesUhY8GD+j62GL78Ql28Y2zJ4zREAbOw
         vuzAlYji3oC3FiloTKd5dDTyl1o8DkZfhXUAHyiWV/U464mmoZ8CdlHRj358YIg+tY5v
         rbvA==
X-Gm-Message-State: APjAAAWSayTstOgmADD/8KZhPwb/UguiotAqh8g3T/kHgcNlbEID/5NW
        KxNsEuARy0R996lgvy8m/AdZrMnZzOJgvgVPnq9WBA==
X-Google-Smtp-Source: APXvYqz5CJUUK0qyAseXj87mmB6Nt0seAeXquM4IvjhczlDYn60KVA4MXVjTWwbk59KNHiacIziBk1T/NZtcf3RQVgw=
X-Received: by 2002:a37:847:: with SMTP id 68mr10906479qki.366.1571880581745;
 Wed, 23 Oct 2019 18:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191022100420.25116-1-yhchuang@realtek.com> <20191022100420.25116-3-yhchuang@realtek.com>
In-Reply-To: <20191022100420.25116-3-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 24 Oct 2019 09:29:30 +0800
Message-ID: <CAB4CAwcMxOgRXUT=QxU26S7TvaE9oYgBcUdj-WEvEhV7Krypzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] rtw88: add power tracking support
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 22, 2019 at 6:04 PM <yhchuang@realtek.com> wrote:
>
> From: Tzu-En Huang <tehuang@realtek.com>
>
> The temperature of the chip can affect the output power
> of the RF components. Hence driver requires to compensate
> the power by adjusting the power index recorded in the
> power swing table.
>
> And if the difference of current thermal value to the
> default thermal value exceeds a threshold, the RF IQK
> should be triggered to re-calibrate the characteristics
> of the RF components, to keep the output IQ vectors of
> the RF components orthogonal enough.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---

Reviewed-by: Chris Chiu <chiu@endlessm.com>

>
> v1 -> v2
>   * Use macros to check current band
>   * Some coding style refinement
>   * Not casting "const" pointers
>
> v2 -> v3
>   * Use RF_PATH_* for thermal values
>
