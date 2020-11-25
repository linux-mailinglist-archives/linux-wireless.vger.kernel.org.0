Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9715C2C45E8
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 17:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbgKYQuX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 11:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732054AbgKYQuW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 11:50:22 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C56C061A51
        for <linux-wireless@vger.kernel.org>; Wed, 25 Nov 2020 08:50:20 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id t23so101547oov.4
        for <linux-wireless@vger.kernel.org>; Wed, 25 Nov 2020 08:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p662Zo0RSLqTb4JLT4U6CfzJ6WskRZQe87qZSsniz3Y=;
        b=Q1q8s6c7mPSgsqr9ZxLJnLxUTKY8WbDixyuY1zp7z8hOjmRbn344GdPvs6E7vkAm2B
         4rnaReWG8dOs1WeNaMRBz1eASwe+R9q63Kj/eCTaSgrqtE0U32xG/3u9GzxIhQYrxNL8
         SukEVfnUCeXhuklHzLUyTSlZa+9cF5rUACr61MAtGIJVYBxvjLHICbPPR5uYgGcnh70V
         LETxHFzcvuvgCD8f3Vi1NuXkkUIUS1+ewXRwtXLrMqKGCnlfOmSQqvK2hoq4jqCa0W+c
         6rf8a4cco6Ct0S3aLp/TVta1px1tV4NYehITIedGinEFo6B68ClOUPSI+ks7/5L9207y
         7cBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p662Zo0RSLqTb4JLT4U6CfzJ6WskRZQe87qZSsniz3Y=;
        b=KfyTIIkJVSJnYvf6s8OcZHZA/sHbd1m7XbfO8fVAURmZYm/ipoPcX7E73g912+1jfH
         kBk+5sm1DecRRhPBh9RQ9lA6lPx3Z8paI4d2xFn+Pl3PQyiF9HhweWNI1TB9o2CbAgvk
         sXNAvwBET5n2F1DpXg+ARNc1qzHGSW3kAmpzRtNLV5uo5j8NIaMXgnbEDdncSc+0Zrqs
         VttjIZtonspLe86flc55VFvYXgOPN4KPb5F9dEj0IYFxuvQII5l1LDuOofD3GvPii1HE
         QL1vIlovVacCJAuDgGfJMN5pwJKHd/jKFHN3tuqO3121BgGIbJA0zW2+o2KlQvrDYJJ0
         1Rnw==
X-Gm-Message-State: AOAM531oUWz9lqT+8nTiQToiGoFc44NTUQgyaHnuYPqU/1Pqi05SSPmK
        Wfo0xY7hZY7qX6WTAjpSGyFNAtU+SonElv3sKobrJw==
X-Google-Smtp-Source: ABdhPJxSjwkKhjeg0CEcALBAHH7Z05iUcUDLsRgKoqtUK8YtmRixw5G4ILz8dNdARnAvKdimCqAxl7Sy5pZh9Jwe9LU=
X-Received: by 2002:a4a:b28b:: with SMTP id k11mr3368563ooo.54.1606323019928;
 Wed, 25 Nov 2020 08:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20201125162455.1690502-1-elver@google.com> <20201125084504.1030ffe4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201125084504.1030ffe4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 25 Nov 2020 17:50:08 +0100
Message-ID: <CANpmjNOpu5GN6xyYmAFuYWEPb3C6a_vwTV76pPU_8Vtw9BnF_g@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] net, mac80211, kernel: enable KCOV remote coverage
 collection for 802.11 frame handling
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksandr Nogikh <a.nogikh@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Ido Schimmel <idosch@idosch.org>,
        Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 25 Nov 2020 at 17:45, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 25 Nov 2020 17:24:52 +0100 Marco Elver wrote:
> > This patch series enables remote KCOV coverage collection during 802.11
> > frames processing. These changes make it possible to perform
> > coverage-guided fuzzing in search of remotely triggerable bugs.
>
> Hi Marco, this stuff is only present in net-next, and were not reverted.
>
> You need to rebase and replace the existing implementation.

Ah, that's fine then. I wasn't sure if you can drop and replace things
in -net. I'll send a revert and change the implementation.
