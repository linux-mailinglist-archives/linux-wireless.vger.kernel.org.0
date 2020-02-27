Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9150F17141E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 10:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgB0J0D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 04:26:03 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39173 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgB0J0D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 04:26:03 -0500
Received: by mail-vk1-f194.google.com with SMTP id t129so533898vkg.6
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2020 01:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKhO1AQ00NQAb2mxlmISdfwyHlX7vjWtP3qsga5GwBM=;
        b=vXS4LjAiJ4ELHEh0mx10EpqmGWL50wYXysbYgFM+seolegvNnlf5VJqjAoEKOUsvFW
         g17Y+FeGDY4QEdlF6PX+PaPR8ITq4lBCgFq8HK7duF4qLDT+yoXc8seyiBcUR5G6j2pD
         5Tjus1dZRJ4eMJJlMQdVlmik+/GYDMxON8suKoZfE+dqwii+R/v9eKhZC9RruGLOsoCW
         cSkPM+TX+x9Pfz97h8ZKdXixr+iciwtrlBpMpoJ4SMB6xyyhBoCPozJcJBD6uSJEDEye
         XN1c5cr26sozJ5DbiYr+lxvGuLyma6R5yIIPT7+cesZmnV/cqYDr0X8Kr4gbgoh9SKov
         P6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKhO1AQ00NQAb2mxlmISdfwyHlX7vjWtP3qsga5GwBM=;
        b=eEOA4T+KZWadOxKJcqxuuLHjgFawH4Lu4nQXHrsUazWUxV3FRROFxDg4UjUIjMKwBM
         bn8AvktamKVtS2wutqG7XZ09NBPPcvpXhbErmOTnWtu91aBHdzhOUGUMHxkhSX/tKANN
         o9Fm+LoSrxy4t5E5YwXUtrdKzZTu6mZYoktjxl7vt7AQR2d4lC0n04bB9tRageRtvQUO
         jTM+Poe9omS7xf52ed6BPSxlLS10M970EGaeyZKhn+XyjUEJk47ThTvg+rziS1PFfDeN
         fyXHtfTMZOxvLaU2RK9BPJQ0G2j9zfxy5UrgroEjxsaoScYW3OtC4YxrVCU0K9CJEQ09
         vM6A==
X-Gm-Message-State: APjAAAXK1VUtmLSLjOQefVrEChJG3+6b8xtxH/C+gb0z56bVgTAF5A1m
        hfTfmFtLG8TZAppHZXme4P04dTXbez+L6JellMw=
X-Google-Smtp-Source: APXvYqwY+o2PgZpq0I8t22A/4AUUHc81pvfiagrPCAYKch0tsrlsBLxiPNwwpiA0Ygx+eqlwBwwzb6M/3tfbf1YWCjA=
X-Received: by 2002:a1f:b6d7:: with SMTP id g206mr2114238vkf.8.1582795560965;
 Thu, 27 Feb 2020 01:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-5-kyan@google.com>
In-Reply-To: <20191119060610.76681-5-kyan@google.com>
From:   Justin Capella <justincapella@gmail.com>
Date:   Thu, 27 Feb 2020 01:25:50 -0800
Message-ID: <CAMrEMU8FkUkoTB95K8cbBgcrUBPmE0cy6yUcROLTw1_BuSCKuQ@mail.gmail.com>
Subject: Re: [PATCH v11 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on
 packet dequeue
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        make-wifi-fast@lists.bufferbloat.net, nbd@nbd.name,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>, lorenzo@kernel.org,
        rmanohar@codeaurora.org, kevinhayes@google.com,
        Kan Yan <kyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> ieee80211_report_used_skb(). As an optimisation, we also subtract the
> airtime on regular TX completion, zeroing out the value stored in the
> packet afterwards, to avoid having to do an expensive lookup of the station
> from the packet data on every packet.
>
> This patch does *not* include any mechanism to wake a throttled TXQ again,
> on the assumption that this will happen anyway as a side effect of whatever
> freed the skb (most commonly a TX completion).

I recall a recent patch for ath10k sdio that disabled tx
acknowledgement for performance gains and am wondering if that will be
problematic? Presumably not since it would be caught at the dequeue,
but thought I'd ask-- wondering what the effect of failed tx's or
block acknowledgement is on this stuff I'll need to study the code
some more

https://lore.kernel.org/linux-wireless/0101016eb1903db0-ef7063b4-0f42-4a01-8886-327541e6c1a4-000000@us-west-2.amazonses.com/T/#t
