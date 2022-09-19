Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB55BC0CD
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 02:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiISAc0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 20:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiISAcY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 20:32:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E713E1A
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 17:32:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c198so26543187pfc.13
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 17:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=vA3TbMJkxyuLlcSRIwos4IxPRe3TxASAviaiq5jwZ+0=;
        b=bcWdjKeuWowiGdDrIKS7iSUtb3bTnpqJtIvvLWzRk63lJU9xnQuTd3PnmVSHqgRHYJ
         Gs2HnHR3srsQcWDA3WISFo60JNaFPVp061TW24c33yYxA8qk1YCc2TsB2OniFbQuOj9w
         xuQce4ajbDNMftU9d5AlyOktbW1UTCCftByEN9o4rJB70XUnEDYkPaw/M1KRzvcyLzfA
         9r6+iIDT5kmpidq6demROWwDvcqw/cZNGD9b6kUx7VDGisvSElF3Nj855oiWzdg1B2ke
         L+iCdZ1h5BBpMyEU0Jt2cJSNlIfhJV7uKsZc05EQ3gMHmldEV3ERKZvwx3370qM4wlb8
         cxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=vA3TbMJkxyuLlcSRIwos4IxPRe3TxASAviaiq5jwZ+0=;
        b=sSQ/IFMXdESwJybfADkJgzTnOiWYgVSu6JoBF1OeGo0AdZC6FEPuJAQxrM4sKprB3M
         Biz80zgBQDra4yk+CUU7J9pwjwj/bgaYM/F4ZlAB/rYkAtebfRJq73pylRuYQqvdV3SN
         y9HfNBABU3/+OrNCcZa0TaqMtGAXBtCXRvxJC9xngBCY0s5kI6DEVpRkzt5VfSNEdyGY
         hW+pCxQGy3nctm0qElk8FwalJ9Ykani1nLM6pDaGNv/ZCDoBynmKS+yV0yn7xLp0Veh4
         EeweTWSbZFy81aeJlcyP1FQPRwhDi9cnHaHvDHoYMaHWEME4am5PZwDuK/DeplBNsNxd
         y6sw==
X-Gm-Message-State: ACrzQf3KlUlhpf3lXp/uWEg87fSZlUWoKKcw5DY6hmb2lgepJYtCFd5x
        5xP9J+Sngm3HmfVBDZdgtlaxKRLt53rWMs2w0JMU/aubqNY=
X-Google-Smtp-Source: AMsMyM7+/nVPlm4xy05u122X59BJ/v6lRSgNrfldi+mmOr4RWbImTh17IjNHr9kcSguGDvK7snhPk9Wx+OyuyFKivso=
X-Received: by 2002:aa7:95a2:0:b0:541:123f:bcac with SMTP id
 a2-20020aa795a2000000b00541123fbcacmr16568226pfk.52.1663547542789; Sun, 18
 Sep 2022 17:32:22 -0700 (PDT)
MIME-Version: 1.0
From:   bommy985 <turkenlurken@gmail.com>
Date:   Sun, 18 Sep 2022 19:32:11 -0500
Message-ID: <CAPwNHCE_LOMOKdHN7zr-MveDCN3ij0KMyhfi+nmU2v3kQff5Xw@mail.gmail.com>
Subject: wifi
To:     linux-wireless@vger.kernel.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

over the last while, i have been using your rtw8852be linux driver
which started working again...
following an update to your driver on github, your driver started
acting wonky again
by that i mean it did the same as it did before your revert in the
makefile, require a virtual connection/hotspot(kde) to be made in
order to show networks, let along connect
previously this also made it extremely inconsistent, but now it just
seems to work fine, i just have to make the virtual connection thing
happen.
i am using endeavors on arch 5.19.9 and did a git pull following the
update, and also have a backup of the previous perfectly functioning
version, if this is important

not exactly a problem, but it is evident that the weird virtualization
wifi connection thing has returned after your recent update, and i
just thought id email you on it



oh also
my email that i previously sent to you was publicized and showed up in
google results a while back, not sure if that was just internal error
on your server, assuming it was(i cant find that anymore), but it
yeah it was public for a time, if its not anymore.
