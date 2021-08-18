Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EF53F0D0F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 22:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhHRU7X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 16:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhHRU7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 16:59:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACAC061796
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 13:58:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d4so7453017lfk.9
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jJTY5RurtelSMfApfTPulu82aXjdVlqtKpskloZbHk=;
        b=AKqgZUaq97Yoy52AsC1xrmksvvgnRXN6lRBktw0TKuJVw6fGAaawLwp7iMr9t+XZct
         U0MGdA+roLw/J/kmo8gMgmFQC0WqUcGCeMGFu6smOOJu9X1tQlw5nZGYG1lT79iIZ+Cx
         ebpkwGJcLVX1ZnJuLTc7UWljkN1yRvQVxpdQzXu7Efg5XCKbGqkU/2YIm32eljuZN0GW
         oDpHLvz9QwJjSu3l8919b3hbhfLQlgapDVkUWGA7Oc3h7ET/XG87r+aOXhyMnkmMGZm2
         KKr7jmE3NG/6a/8+iiytMWGAzbzpO+6t9ZlgpSU+pWhheZKVkE+Z2KjB9DGfczJbhKvO
         FByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jJTY5RurtelSMfApfTPulu82aXjdVlqtKpskloZbHk=;
        b=spnWxgUgoIRDDbHbcSh3ZMT5xCCXC2Bn/88XbMNJ3ocd2ADdSnmKrMCHqLHOo0Q1T3
         3lOXuSn+l5LzOBwFo5wsCNoAuUAFnu8RTmhVI1m7HDCPiNkwKsLLRbmBHla8XaoDdr+2
         zc/FlClfgjGQanKs8PLa/dRl7JF0F+ueP/hR/6wEaaClmplHQUpTc7Xs3aHx6kYbvXO6
         F4qAMxLyQKi1pUGYiaAoJ1DefKndopDaJEURcjPWIfK5JxLSAOVaCmyWFbHgu3qvLtZa
         vymn/JTAaCNQvR3N0I418zRM6dFvBotllAIFMb7Lp01mKS/O1Su543hCnXvdhg8Cv2/B
         /b8Q==
X-Gm-Message-State: AOAM533Uj5PBejUy3VXuEGO1JLjfeIzbISlh6NSU31JCl/mSdF0z6EPa
        0c96YmErNg1nZnP4qSKkUu+YQCgrKDMWqcSmrCs=
X-Google-Smtp-Source: ABdhPJw9EbFfs6R+Cg3EX4J2J+gzDbYWl7CvmAajlIy7XoKhalcW6E8qm6r8lqRWTPZYJd8pCJCnaMC43umjzmsASBY=
X-Received: by 2002:ac2:4143:: with SMTP id c3mr5149201lfi.295.1629320318930;
 Wed, 18 Aug 2021 13:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210818150943.1630199-1-festevam@denx.de> <17b5a29d098.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <17b5a29d098.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Aug 2021 17:58:27 -0300
Message-ID: <CAOMZO5BjAp3eJtOgifDDvAa-EB--SbvtYFMD=ha8VokipVp3tA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Do not call dma_alloc_coherent() for SDIO and USB
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Fabio Estevam <festevam@denx.de>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, erik.stromdahl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On Wed, Aug 18, 2021 at 1:51 PM Arend van Spriel <aspriel@gmail.com> wrote:

> Does this mean you can not really setup a beaconing interface type for SDIO
> and USB?

As per the debug message below:

ath10k_dbg(ar, ATH10K_DBG_MAC, "mac vdev create %d (add interface)
type %d subtype %d bcnmode %s\n",
   arvif->vdev_id, arvif->vdev_type, arvif->vdev_subtype,
   arvif->beacon_buf ? "single-buf" : "per-skb");

If arvif->beacon_buf is NULL then it will be a "per-skb" beacon mode.

Thanks
