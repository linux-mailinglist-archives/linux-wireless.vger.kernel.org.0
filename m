Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC3431728
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhJRLZ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhJRLZy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:25:54 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298CEC061714
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 04:23:43 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id o42so8370263vkf.9
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZVBbdFaMwDfFVe7K846PRuYPvXa7rvMmyrePdG66dk=;
        b=g04zXqgFqCOVkoL7i2AKFcVhyTFlRqNqUC4yqSx7oFtp8sq/2y/EcuZryNoqjjkxCw
         OW2+n+HlzoLb5P3VwUtg8WWAoOWLwlXjStOy1IagwdvQiMXM5xkxNHfzOA99tQHufMgp
         2POkp2ynJjdaL+qR9YxSsaI09ncTAaXZu+Su9p0CoifCPqmmOFkrMNT/EDjp63Vd85qs
         XH8Ad3Efy55e946z8owohzN21RKKplMJSoFn0prY5msf/lLiiwUGv7O5q1xrDnsnefkw
         AI52d1Z7ne0yxzSly5enlwhgxAlft0IXEdUkHxhNcAf4f2w0VDI+8Da1EFenUPbGa7L5
         KvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZVBbdFaMwDfFVe7K846PRuYPvXa7rvMmyrePdG66dk=;
        b=c44BVAiJ1SmNKcJisiTUO0MN75q2RYE7ls7rZZChdU/S3uW0k6goGoCMvaBpWjZXbt
         kjfrgUL86Ae0jmvFhx2LQDfarPbeKOmA3Fsgsig8nSMoH7Sobg2RtzPcADjEk+GkkSvp
         OWoaWvRzxHixEzM9qzolBmIvQhRBdWMGWsTpuqx1zghL2qpHZTxz7CanXYHetdnyLCSW
         lPGwUnju+dp1LlaNOgHRJAplaY31LTAqjGJR0CP/i3IGfkIIzp6Yo/qB4PJn333w34Qk
         cogQZBzE1+CIw4J011+aCHXLq+NXb91WmdwIYVHYTn8Pzyt8aGebwMiw+qhVZbD3d0D1
         yBdA==
X-Gm-Message-State: AOAM533RMZzxGJk/I4tUoVR0UnBuwvWKwOdHU7tx/TBKMRUbMdJyI4VH
        sbVK/QRFb6PyLpqK3vJwtql8SY0TQpq9QVX4+KU=
X-Google-Smtp-Source: ABdhPJyIDtYVGj48YKC4q3q9z+PUSKt/joICwLFlCzWbmxjZgrChRtZO1OS6qpJXcNyFCf+NF++LQBoy1WpTWvtCZso=
X-Received: by 2002:a1f:cc86:: with SMTP id c128mr23805844vkg.14.1634556222290;
 Mon, 18 Oct 2021 04:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
 <20210811105541.43426-7-emmanuel.grumbach@intel.com> <878ryqvatj.fsf@codeaurora.org>
In-Reply-To: <878ryqvatj.fsf@codeaurora.org>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Mon, 18 Oct 2021 14:23:31 +0300
Message-ID: <CANUX_P2-4oE3ZKcD7bAurVZrAhJM0Qxb3V56T1g2a=HC2f7r7A@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] iwlwifi: mvm: read the rfkill state and feed it to iwlmei
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach
egrumbach@gmail.com

On Mon, Oct 18, 2021 at 2:22 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>
> > Remove the corresponding vendor command as well.
>
> What vendor command? I don't get it.
>

Compared to a previous version that I sent... Sorry, this was confusing.
I'll change the commit message.
This commit message was relevant for our internal tree, but not suitable
for the upstream code base.
Will change.
