Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9403813BD
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 00:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhENWYq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 May 2021 18:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhENWYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 May 2021 18:24:45 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C2CC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 14 May 2021 15:23:32 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v13so1036337ilj.8
        for <linux-wireless@vger.kernel.org>; Fri, 14 May 2021 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7lEtx/KwXhZt/gwGv2b4T0d+HMnLuKrEg/kRh+C8u4=;
        b=cvFQB5T4vZKzDFfKG8IjrHbfixJd/rXGN3vTHJrzBwdM4R8CY4G7jKQSBP1tbiTxGU
         /Q9lCUSR+4B3+n6LiR0E7xvRTElCBHxveRpU27e0Ygrp5RZQdtHHnNQ9Ck+L08tR5JHU
         yAHbT4obMBgnVCEDctyDI517NxKZpsFMLBP7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7lEtx/KwXhZt/gwGv2b4T0d+HMnLuKrEg/kRh+C8u4=;
        b=XLHz6mMVej8bhjMRk6ntKREwSTrIrje4M/yt81K/bkyRSzMUuwLaRCD8DWRk7Tesiz
         SG7wMk/YFYvVX22BFQ4kdC7LlkCJsloGeZzcI94o6mmdcHdpoO59plQnHk+HbqYAQjYn
         Xk7jhBkuT1KD7m1VEZShmzEUX6lwAhcM5e34JEwW8smksPxi4qbQsCcIuWBoxQXw2VBq
         bRetd2EzwxLMAFaXNuOySAIg+oY2vUPML/BL9t3Fi9/oTtKPQx2QzO3N3vZt2WWpzzqq
         znr187uOOvJDRUuUz7H/H1CcUkO7QFj8sDsJsnsrbQSa6+18TQYYLLPOPZgtlc7w8XcP
         v76Q==
X-Gm-Message-State: AOAM530oXyFduvXvQf3JHmBRl1H5JyrCo5tb6vEexSTbVk4xBTlFWQUw
        7S0I+xfJMD8lMMFLrkTomJtXFBjIGzDahgXzTlXSBw==
X-Google-Smtp-Source: ABdhPJxSciJ6E1hfB4DyXoMeQoNc4YXWPLNLYWnvJqaj+dNle4KPzXIuKD8MPTCSIIZW18eJdhAfmadE4BUFdiSqWc4=
X-Received: by 2002:a92:2a09:: with SMTP id r9mr25039606ile.300.1621031012064;
 Fri, 14 May 2021 15:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210511180259.159598-1-johannes@sipsolutions.net> <20210511200110.9ba2664866a4.I756e47b67e210dba69966d989c4711ffc02dc6bc@changeid>
In-Reply-To: <20210511200110.9ba2664866a4.I756e47b67e210dba69966d989c4711ffc02dc6bc@changeid>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Fri, 14 May 2021 15:23:21 -0700
Message-ID: <CACTWRwvOFV=Yws=ZrR01YCOnzbc4AcXN8+dDK4vEsuc=svv4dg@mail.gmail.com>
Subject: Re: [PATCH 11/18] ath10k: add CCMP PN replay protection for
 fragmented frames for PCIe
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Wen Gong <wgong@codeaurora.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> +static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
> +                                         struct sk_buff *skb,
> +                                         u16 peer_id,
> +                                         u16 offset,
> +                                         enum htt_rx_mpdu_encrypt_type enctype)
> +{
> +       struct ath10k_peer *peer;
> +       union htt_rx_pn_t *last_pn, new_pn = {0};
> +       struct ieee80211_hdr *hdr;
> +       bool more_frags;
The variable more_frags is not getting used.
> +       new_pn.pn48 = ath10k_htt_rx_h_get_pn(ar, skb, offset, enctype);
> +       more_frags = ieee80211_has_morefrags(hdr->frame_control);
"more_frags is assigned here but not used anywhere.

I have raised a patch for remove this, I have raised a patch for this,
https://patchwork.kernel.org/project/linux-wireless/patch/20210514220644.1.Iad576de95836b74aba80a5fc28d7131940eca190@changeid/

-Abhishek
