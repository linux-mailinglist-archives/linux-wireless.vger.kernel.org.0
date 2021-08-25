Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72D73F7EFB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 01:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhHYXZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 19:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbhHYXZa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 19:25:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773CBC061757
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 16:24:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j4so2366754lfg.9
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohnyH/sYJ4RhitC7WS5XOqlr5Fq+L2Nsz7HS2qyXv2Y=;
        b=fFTMTLVaSYyrU35PgaGSgyyOg1shsRQ+Vfs/Ao7B4oHszJKMa7Zb9cRkHJZH29RFgO
         q9xVAdKnNr+tuNBJ+fYIGc5UOMoTpdrKSiE+v4QqVwEA9KVFSiD69ThhdrTIkdUfILiM
         AcBYL50IBx3zgSyuh5EEkh6mn4UzaT1Xyx1SZuv8uG2LQsa6bKGXAv1Bijq4BfbNMyEb
         9emQnQH9e0/+9TAhi//CJOgs0TLz7sPAKIVbnTG5ymqKpeG+A3mNyGTrCOURPbGI5Peb
         tCoC3ri3zUPvFid8hu/lauw5jj4o4pvzWQX3bhFIc/V8fNmOhdntAl/xQzYpAKZ0gkyh
         dUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohnyH/sYJ4RhitC7WS5XOqlr5Fq+L2Nsz7HS2qyXv2Y=;
        b=VXbv6i5oJYi8QWZUMGg1AkkXLP+P3XiHw+tbxQDXDPa1Cu6pR1uJpw5zgxfZj/uDf6
         t9Xp7PsaMluTABfjth1ro4PPiJvrWN0IM/IHEoBEc/NIA7m4nSaw9fOEHXgMfevxIfO1
         88Ik/vkhnRR6kFe5RlXEtCaWWgDBgPFxvrE1rdstecFzyR/ENm5rTsJbdJjNzsa6iKOR
         1HT+IYonmaJlED3ukecqWXvlJ+H/b6u9aUrasNi3JOCc+Afwh5rAMejFOTB73wdu0Kbx
         F/9pD9fN/q9L2HYn24oTw2fI2q6dMhgr62FuX1O6BWieJvuB1uXzN3j7TX+iiZXuBudj
         6gCQ==
X-Gm-Message-State: AOAM533ZHI1JdhHkvN/RjUK2JO0jH3f5KzZBxnE9RX7MR8+7zVJQWZr/
        gtBkWs+JDbZmg0zwuDP9N6ms+4ybfT43a23yN/8=
X-Google-Smtp-Source: ABdhPJx0yuexm2urpVSvrUS46piujDlfdC3y6Zpjw9XL+wDgCd6LNhL1oaONJBO/qYI4XxDSIfnnEBzIDSad6f4E2Ak=
X-Received: by 2002:a05:6512:3d15:: with SMTP id d21mr431412lfv.474.1629933881878;
 Wed, 25 Aug 2021 16:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <51ddd9063eddbd5ffb880728f610fba95428a313.1629925713.git.ryder.lee@mediatek.com>
In-Reply-To: <51ddd9063eddbd5ffb880728f610fba95428a313.1629925713.git.ryder.lee@mediatek.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Thu, 26 Aug 2021 09:24:30 +1000
Message-ID: <CAGRGNgW+4CG=TWxDMcocA3VuxLtY-d0MZAoWhFO3G-D0sDZm6g@mail.gmail.com>
Subject: Re: [PATCH v3] mt76: mt7915: introduce mt7915_mcu_beacon_check_caps()
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ryder,

On Thu, Aug 26, 2021 at 7:22 AM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> Beacon elements might be changed by hostapd configuraion, so driver
> should compare both IEs and PHY capabilities to get the least common
> denominator before association.
>
> Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> v3 - rebase and rework LDPC part.
> v2 - clean up codes.
> ---
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 164 +++++++++++++-----
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  12 ++
>  2 files changed, 137 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index ab8fc27646e0..640e0f06bb97 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -83,12 +83,24 @@ struct mt7915_sta {
>         struct mt7915_sta_key_conf bip;
>  };
>
> ++struct mt7915_vif_cap {

Extra +?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
