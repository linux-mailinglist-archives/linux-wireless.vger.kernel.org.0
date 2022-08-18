Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20805597AC1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 02:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiHRApL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 20:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbiHRAoa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 20:44:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6084E845
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 17:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 980F8B81FF1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 00:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42899C43146
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 00:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660783466;
        bh=3kIk1qrELETqqdtSh1vAVI42Nm+C7jEY8yunalwBG98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AI03jv2ri6hi2nxdPQ3B/awPYiJst62jfo0KJznajtFATfQ+Fw/GcU6NVUgNWyTeS
         YgB3KeB7jrNR6aNzL5+2IIQzL9J1zp1k7Ih+sVgi219vBlM/wGBn2MDXcMTK+7PUmv
         Lzhf/TIh8OlgxBp9VQgSKJIWWUgXHbuT62i+4z9v7meG/223rlOZs/2EvG5UvRRxSe
         LGzNEOnfqA6bqXgKk84jbpxM2xAYp1z/Uh8EFYXO6CVqfngKWDxcwt88ZrBPNgUDvb
         vT/oxa2RbBRdqKxLNKB8mvOsyxnnJnd+Vq6hj5OvlpNXdLrx4HtVjL+C/loVeTAZQR
         s5sNmJr+dlRuw==
Received: by mail-wm1-f43.google.com with SMTP id d5so105716wms.5
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 17:44:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo3eQ91C0PfQrjVQrCydf1IGpTdy1gzlb35ximPSWZNE/emF57g+
        MkkM038+8lkd6q7e3ZJ9Mnf8qovBwJ45py/9TUM=
X-Google-Smtp-Source: AA6agR4AdYpfuOh6x5teVCDNh6jxcqpeUvAMgqc+Wpi81TJk0UX6wtq5nPxzYV9jMHWrD2S7+mcaRBzbdnDeA3L7p+w=
X-Received: by 2002:a05:600c:5008:b0:3a6:1cd8:570d with SMTP id
 n8-20020a05600c500800b003a61cd8570dmr281830wmr.57.1660783464388; Wed, 17 Aug
 2022 17:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660606893.git.objelf@gmail.com> <44acac2a0c1ce4a5d554a24227f80c6ccb3af878.1660606893.git.objelf@gmail.com>
 <YvyV3EBXL1TBQrc0@lore-desk>
In-Reply-To: <YvyV3EBXL1TBQrc0@lore-desk>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 17 Aug 2022 17:44:12 -0700
X-Gmail-Original-Message-ID: <CAGp9LzoM6wMiQ2g3r8G-JaZS-Y=_91edM2FVbAmHZPC4d8nyQQ@mail.gmail.com>
Message-ID: <CAGp9LzoM6wMiQ2g3r8G-JaZS-Y=_91edM2FVbAmHZPC4d8nyQQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] wifi: mt76: mt7921: drop ieee80211_[start,
 stop]_queues in driver
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, lorenzo.bianconi@redhat.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren Wu <Deren.Wu@mediatek.com>, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HI Lorenzo,

<snip>
> > +
> > +     dev_dbg(dev->mt76.dev, "BSS %d is %s\n", event->bss_idx,
> > +             event->is_absent ? "Absent" : "Present");
>
> do we really need this? I guess we can just drop mt7921_mcu_bss_event entirely

That is not really necessary. That was just what I used to diagnose
firmware behavior. I think I will remove it in the next version.

     Sean
>
> Regards,
> Lorenzo
>
> >  }
> >
> >  static void
> > --
> > 2.25.1
> >
