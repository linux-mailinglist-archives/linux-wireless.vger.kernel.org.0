Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3B810E520
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 05:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLBEpX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Dec 2019 23:45:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45437 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfLBEpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Dec 2019 23:45:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id 14so31164406oir.12
        for <linux-wireless@vger.kernel.org>; Sun, 01 Dec 2019 20:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xx1IcUCVnmm+ltQmJpqmycxjMGQYkRxxjPLHuniV3bs=;
        b=u8LXDOsi/31CpWJAQz7I7WHgjXVzzU/IXOOu6ngWLP+lUeYaYlObs0lybNUhrsEeN8
         pgE5v8nft+wbIL+pz0LV1G1SCdaClLbY/4koX60vfVShtcVABXdk0bQ8ZudZyXOo69ff
         bEtqoKi4yXK78oL50b60DO4A7wrcu7l+SC+pCU7Vm7Lie7G2xriSr9MlZUvIAhYSkza5
         U2Bczuh2DAn1CQV9A0z6YwTFgz738DhLxOnlwpC6BSHdA3ZsCjUY/Ns4fHIFFkvt6Kvu
         seqfXPVOXZOSmKKopqrtvNmv+miXPXRN0PiL1x0LiIF4ncmzCqeKp4T/VxZgcmjxSbSn
         MIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xx1IcUCVnmm+ltQmJpqmycxjMGQYkRxxjPLHuniV3bs=;
        b=imF3vHLUwMHSSxJ8jPonHCVRnIrqxO5ZqeGmczecMCOOBmU15WDVBPlJDfha4wHsap
         RbKEqZIziM7lmPqw+WtB5A0v4qnKUwgFGHPMNzDquWjfAliVOCOohO+RoKoGzir+Vpmo
         oo8axtRReZRUXt5xxbythR7nPONshndCuYE7NWD0hiSEJU2Me5pWleW8y45JepfRWmYA
         F9S8h+wUj1Cx+9HQveV4w0qAkQH4QoECo+ohqkVUabmZVLtQ5ZctJrjX21ZGTF7fKsNm
         n/M72hwZTL2MAc11KiihrwR2Y+kCFYS6xkKSm+nqMh6R1e0uL8UMSEyJIEwJqPJN4oPT
         +1CQ==
X-Gm-Message-State: APjAAAU+cOD8VnoKM7+IdxBWlPldrlLCkZE7x2jXkmiQQPiCdJk2LM7v
        iLBAEWzAUrDdJW6FPEnZIPAi/eLm2SUxwbhFK9c=
X-Google-Smtp-Source: APXvYqysbsxAKgbExho+j5MbF9MHIEHnmRlacbXTeCUQ3FiklrOpQzE2aFflR239WvHDV9AYjUGAnPEy7m8J+riw77Q=
X-Received: by 2002:aca:af54:: with SMTP id y81mr19088039oie.154.1575261922530;
 Sun, 01 Dec 2019 20:45:22 -0800 (PST)
MIME-Version: 1.0
References: <0101016eaadee57a-54500c6d-4751-423f-8bab-5acd8fad2175-000000@us-west-2.amazonses.com>
 <0101016eb61d9520-b0306a23-c9b9-4b57-b708-9f80ac47eef1-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eb61d9520-b0306a23-c9b9-4b57-b708-9f80ac47eef1-000000@us-west-2.amazonses.com>
From:   Justin Capella <justincapella@gmail.com>
Date:   Sun, 1 Dec 2019 20:45:08 -0800
Message-ID: <CAMrEMU-VOYeHO2F5AjyWJLqgEVq5HOUHZkMJqGio1qovFPo8ug@mail.gmail.com>
Subject: Re: [PATCH] ath10k: set WMI_PEER_AUTHORIZE after a firmware crash
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Wen Gong <wgong@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Are there security concerns here? Was the peer known to be authorized
beforehand? Would it be better to just trash the peer in the event of
a fw crash?

On Thu, Nov 28, 2019 at 11:46 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Wen Gong <wgong@codeaurora.org> wrote:
>
> > After the firmware crashes ath10k recovers via ieee80211_reconfig(),
> > which eventually leads to firmware configuration and including the
> > encryption keys. However, because there is no new auth/assoc and
> > 4-way-handshake, and firmware set the authorize flag after
> > 4-way-handshake, so the authorize flag in firmware is not set in
> > firmware without 4-way-handshake. This will lead to a failure of data
> > transmission after recovery done when using encrypted connections like
> > WPA-PSK. Set authorize flag after installing keys to firmware will fix
> > the issue.
> >
> > This was noticed by testing firmware crashing using simulate_fw_crash
> > debugfs file.
> >
> > Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> >
> > Signed-off-by: Wen Gong <wgong@codeaurora.org>
> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> Patch applied to ath-next branch of ath.git, thanks.
>
> 382e51c139ef ath10k: set WMI_PEER_AUTHORIZE after a firmware crash
>
> --
> https://patchwork.kernel.org/patch/11263357/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>
