Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EDC72403D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjFFK5q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 06:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjFFK5I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 06:57:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83741705
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 03:56:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso60291665e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jun 2023 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686048959; x=1688640959;
        h=message-id:to:from:subject:cc:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iiizsvCgIz8tRBFujFv+2PYyyX6I4WLqhEmLlu2Fp/s=;
        b=iupZfaBEbl28vcaaCgphKasjrMmidx0sk9K6JWDB7D7YgqN+/YwIsCJ5WrdhaAzcsL
         geB4VUXAaA7peCmlfWeKmqUZvRxWsO2hFcMw+O7iYuBuK3p5u1tHH/yO6ZWw5bEDsqNg
         FDYfBra53BM5j98JgQUY23pwGXC0PBzwyozA1HcEw9/XGNNLngNjsu2jbWtwYcQXAT3w
         zDeE8qTvf2yttad4h2t4RjGELqUWtlEL7Zn8Apwj+kbByCxon3pRJc8esPN6EjeMTpLd
         KDHmFdASac37Oc5OUnQoE2K+ScT5iiCCu7ayBtMPBXzTEDAOxbS57oReSDQmLm+FYmwi
         UIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686048959; x=1688640959;
        h=message-id:to:from:subject:cc:date:content-transfer-encoding
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiizsvCgIz8tRBFujFv+2PYyyX6I4WLqhEmLlu2Fp/s=;
        b=St5kprMe33JvwHZ318j/vasCT09TYmBBYn/Ofe8SWbMmyatwhjK/RMaePrPYj36Lnx
         /ZZPqjMcG4G0aqWGZf/fmpqVt5PzKIgW8JmIbVMB33s1+QAMKzfsJWILSpnmwwj2vH0a
         EexhGXm3IAJsAz5jjly4TghwNn6nC8jJhshYJR48y/w3rroiZ1AZh0mM4pWeQoAN/O8C
         OyuBUMnz2vWjPFDOZLFNmhMrdG0dtk5lQcveG+EjhKqLCT0lPSNOEkmN8vraYQmiB3qg
         ClmtiYyEELIL2xGrRnDb0+VFx5TwkHR2Qw4OmGxfnZodOX/CHD3WQYOLeyaLE9SFL1O5
         M5vA==
X-Gm-Message-State: AC+VfDzO/KMgWkWb8nrRVskW7ugS3K30TkaAXr5bcr0FYQEhplZee6ai
        TWJS84kD2zFgVwHEE7dFV7RoCWbO1LY=
X-Google-Smtp-Source: ACHHUZ5xWnNRKxhubmIOCBFb15ZbcsGIv2UramNb/+o/gb3JCWv+y+XTAU/Bl2ojI10e0usApzF9+Q==
X-Received: by 2002:a05:600c:3650:b0:3f7:3a31:847f with SMTP id y16-20020a05600c365000b003f73a31847fmr2038467wmq.31.1686048959079;
        Tue, 06 Jun 2023 03:55:59 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c231800b003f6041f5a6csm13590776wmo.12.2023.06.06.03.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:55:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 12:55:57 +0200
Cc:     <linux-wireless@vger.kernel.org>
Subject: [regression] STP on 80211s is broken in 6.4-rc4
From:   "Nicolas Escande" <nico.escande@gmail.com>
To:     <nbd@nbd.name>
Message-Id: <CT5GNZSK28AI.2K6M69OXM9RW5@syracuse>
X-Mailer: aerc 0.15.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Felix,

As user of the mesh part of mac80211 on multiple products at work let me sa=
y
thank you for all the work you do on wifi, especially on 80211s, and especi=
ally
the recent improvements you made for mesh fast RX/TX & cross vendor AMSDU c=
ompat

We upgraded our kernel from an older (5.15) to a newer 6.4. The problem is =
STP=20
doesn't work anymore and alas we use it for now (for the better or worse).

What I gathered so far from my setup:
 - we use ath9k & ath10k
 - in my case STP frames are received as regular packet and not as amsdu
 - the received packets have a wrong length of 44 in tcpdump
   (instead of 38 with our previous kernel)
 - llc_fixup_skb() tries to pull some 41 bytes out of a 35 bytes packet
   this makes llc_rcv() discard the frames & breaks STP

From bisecting the culprit seems to be 986e43b19ae9176093da35e0a844e65c8bf9=
ede7
(wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces)

I guess that your changes to handle both ampdu subframes & normal frames in=
 the
same datapath ends up putting a wrong skb->len for STP (multicast) frames ?
Honestly I don't understand enough of the 80211 internals & spec to pinpoin=
t the
exact problem.

It seems this change was already in the 6.3 kernel so I guess someone shoul=
d
have seen it before (but I didn't find anything..) ? Maybe I missed somethi=
ng...

Anyway I'm happy to provide more info or try anything you throw at me.

Thanks,

---
Nicolas E.
