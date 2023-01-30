Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD7680811
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 10:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjA3JBy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 04:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjA3JBx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 04:01:53 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D112914C
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 01:01:52 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o20so17968978lfk.5
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 01:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UZj9/cvDapyg3C3XeyJ8O7FcL+Q9vTGYpiiZhybQ3/Y=;
        b=YpZPybRH2g6b5MNlae882cJyQH3+GhaRS1KtkQ1ic4U9DQ1wAksC7l424HEbF+ADxN
         fmcDLTrktBtYMQMPkMUDNQIZxVM+BtAxgcnyQJWwaWpP0v1je0i2oRgTSbR2VLze9BqV
         1BnxymwS2i52LfRIyveXklR4p0oebRBpofJZomFe9/cTpunIeKSf8raZU6JTf07/dnv1
         GIZ2nHXbEouap68BiQOwnezKzLYrtAAmNMjYXfQejCOEfAY1k18W3dL3Q8XvBXm1rPms
         898HEjlsuc2LbxFm0rngcEx5mQIZU7LN/4ANBG5/WrHIlhPovrw4VKPZT7M4zGDb1FxL
         uzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZj9/cvDapyg3C3XeyJ8O7FcL+Q9vTGYpiiZhybQ3/Y=;
        b=pSFsM4OAJrX5b5YziN3dKGf0t4ROYc4Ndx0YtpU52lfuYKaypNLFg99xhubsKiMwsP
         khCNkLtAz4N45radmYt7DFnKwYMOS/0E5Xwxyvxd2fgCqc2tXJKv9E9wdBTKOj/TjpRF
         Dno8C3SHJDj678y17Ylv3AQtyXh+XlGXKmAiU4gx0U2Tv6VjiZCE69ZmyZQYdLWnQwU9
         tCbCkXFPQirOSw8AZFQPR3UNLqmBN5Qgp4NKYLASpH2PztAGiE85NCS946wMheQn8+v/
         dbAO1w3f1HUEuiWarrAY1il1PU7QBM4UbWS/qeUTkmIOIT7cRPs4FRv18cLtZ+l347ME
         rGHw==
X-Gm-Message-State: AFqh2krjjooeOWsyQ0rfnOeXLjDc9IO3cfaOvUezLFK1ZbHjFrNa3+v6
        1LIE1dyNxN+aYR7PGtO1hNVzYEZY2BQCX0iKs3KAHA==
X-Google-Smtp-Source: AMrXdXuWZiiyZkf/64VNhp78eRnhB3/NmfVKBBNmIECUtn74jpbV7QLgFX3t7cQcj0HXz/vx4Vtw1n340djOaOQFYX0=
X-Received: by 2002:a05:6512:2115:b0:4cb:1d3e:685b with SMTP id
 q21-20020a056512211500b004cb1d3e685bmr4243828lfr.126.1675069310153; Mon, 30
 Jan 2023 01:01:50 -0800 (PST)
MIME-Version: 1.0
References: <000000000000021e6b05b0ea60bd@google.com> <000000000000d47cbe05f375a0f1@google.com>
In-Reply-To: <000000000000d47cbe05f375a0f1@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Jan 2023 10:01:37 +0100
Message-ID: <CACT4Y+b6Uu4vcuQX+dcmiyzGRX8jnDq3v3SU94Lm2-miB1hBxg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in hif_usb_send/usb_submit_urb
To:     syzbot <syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        ca@plazainn.com.qa, davem@davemloft.net, edumazet@google.com,
        eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        khoroshilov@ispras.ru, kuba@kernel.org, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, pabeni@redhat.com, pchelkin@ispras.ru,
        quic_kvalo@quicinc.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 30 Jan 2023 at 07:50, syzbot
<syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 16ef02bad239f11f322df8425d302be62f0443ce
> Author: Fedor Pchelkin <pchelkin@ispras.ru>
> Date:   Sat Oct 8 21:15:32 2022 +0000
>
>     wifi: ath9k: verify the expected usb_endpoints are present
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1162ac2d480000
> start commit:   274a2eebf80c Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f267ed4fb258122a
> dashboard link: https://syzkaller.appspot.com/bug?extid=f5378bcf0f0cab45c1c6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1343a8eb080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17dc40eb080000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: wifi: ath9k: verify the expected usb_endpoints are present
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable, let's close the bug:

#syz fix: wifi: ath9k: verify the expected usb_endpoints are present
