Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BBC5A1544
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbiHYPKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiHYPKB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 11:10:01 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A605E12AE2
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 08:09:59 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-333a4a5d495so548496227b3.10
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fJEZLuBCwkzDnLaIajxxc2gH/wmgymHG18QKlb1r1XI=;
        b=HdW1svQhcwcaevyopj06Ch9+NBWUAF1uu6SwBCTNhXA/d8Tln7K0YGk3WL2U3Oya4e
         C7qC3BT1muDhfGCiY36yt8xsUJsiytCWBt7aVIswmcMXIKhOz3SBoV30liLQxgJZ+RH2
         UJSYaWWa0l63nxw/n65onJnvAAM48rZk9UjLmXyBinLWDgcvpTvoO2bSo252eGmZOtgd
         RMFghlzAQWqT6VMXdCZd5Y2ZH2xCSvoQQfr2oUzJ+fdTvBUeVUWvFRBA2wp4Ze7GSIav
         03XwfjDX0Eh/wDIAD6fRuqNhkwS+g8v1i+g0adqYpZEXcbjxort7OGg1Bsep5ZFALKDs
         TgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fJEZLuBCwkzDnLaIajxxc2gH/wmgymHG18QKlb1r1XI=;
        b=ySpj14gYtuWHL29mLt4kaY+U+mBqZoHlYh2IVMbhAP0GJZJnazLyS35bwkvLCaoIoe
         FJaslucAkdPbcki/Zo323Ys6psXx3nu5c7Rwh93XZ3Yr/Ul47ZOXWF1sc+jr1yprdPbc
         PoRgXMvnB1BgS7XSEYgFXxoVUGrCMRpCrpWBmpisYmyJHyg9wRPEcl9mGMKKoGRKZwmP
         oHBgChGrK8jsMXsjDEvUZ8HR9iB2KwG1S+5BqhvFhDyT5YHqvW8ttgXro0Z1uyHpBgwz
         CaIVn7uArt7JjnkquwxlN7BbI4kKH6zBDZlahYJho3Y0zxBjTNFrSvSUK3BZDH0mFWLg
         cbsQ==
X-Gm-Message-State: ACgBeo1n/cOhnJ3F78+Ht6AUWkbjAHLKWbkpQRqibIbkv1I+R9lke9Q4
        FL8/xDz0PK0LoWcu6tTMa6i8jtF1gY/X+6il3JXnTQ==
X-Google-Smtp-Source: AA6agR6ybP9THeURexKzBZ7UB91n4A4z6bmsgwmTJUw1mBpb4Ih+eeYIZR+cyL7W8pl01QIn8DOT2qKHjkYZE4WoG0M=
X-Received: by 2002:a81:4b87:0:b0:336:9ecd:2768 with SMTP id
 y129-20020a814b87000000b003369ecd2768mr4497418ywa.299.1661440198723; Thu, 25
 Aug 2022 08:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c98a7f05ac744f53@google.com> <000000000000734fe705acb9f3a2@google.com>
 <a142d63c-7810-40ff-9c24-7160c63bafebn@googlegroups.com> <CAG_fn=U=Vfv3ymNM6W++sbivieQoUuXfAxsC9SsmdtQiTjSi8g@mail.gmail.com>
 <1a0b4d24-6903-464f-7af0-65c9788545af@I-love.SAKURA.ne.jp>
In-Reply-To: <1a0b4d24-6903-464f-7af0-65c9788545af@I-love.SAKURA.ne.jp>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 25 Aug 2022 17:09:22 +0200
Message-ID: <CAG_fn=Wq51FMbty4c_RwjBSFWS1oceL1rOAUzCyRnGEzajQRAg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ath9k_htc_rx_msg
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     phil@philpotter.co.uk, ath9k-devel@qca.qualcomm.com,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 25, 2022 at 4:34 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hello.
Hi Tetsuo,

> I found that your patch was applied. But since the reproducer tested only 0 byte
> case, I think that rejecting only less than sizeof(struct htc_frame_hdr) bytes
> is not sufficient.
>
> More complete patch with Ack from Toke is waiting at
> https://lkml.kernel.org/r/7acfa1be-4b5c-b2ce-de43-95b0593fb3e5@I-love.SAKURA.ne.jp .

Thanks for letting me know! I just checked that your patch indeed
fixes the issue I am facing.
If it is more complete, I think we'd indeed better use yours.

> Please consider overriding with my version.
