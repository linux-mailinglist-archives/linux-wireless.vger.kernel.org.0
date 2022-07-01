Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6223D563618
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiGAOsO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiGAOsK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 10:48:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88872CDDC
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 07:47:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r1so2566953plo.10
        for <linux-wireless@vger.kernel.org>; Fri, 01 Jul 2022 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=St+PMXuZppFfq+3WdqCGOhy3hbP7+L8Zh2J8d5oWcgA=;
        b=oZxl8ZQQRuptScIFxh4ZLuyEW5clL4J9HohVtSaJvec5VBmDRRfuBqxKXF/n5KfIru
         cp/0nUW1Y56TjtFl+i+XFrw01JPjRPWzrcGKNK7G7tBibbSa9OKMdeAXBJk0kRAu6Mwm
         wdE2bCqPSgN1xrO26+f/S7jzo5QVtY2W2R0sFoiPNkAya+lufv52gYED1Ojgsm3uV8a/
         lgPe2TAlOeVY/Q5AlCpQGlgRH8trH7XmFFZc/I/Sn/arhFKCaO7SnKzJ80Gd45f5NzoG
         NpuH3q6vXnvT/cI3TkV2/tcmhPnWHAAuAFAmacMVBQEeXbuXLeyNNr9kPHZr5rHk7rE7
         r1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=St+PMXuZppFfq+3WdqCGOhy3hbP7+L8Zh2J8d5oWcgA=;
        b=wuyns5iBO6PWicKF0s2UQyrDcrsuNF9eOETjKzHvDvSo3CZ/05Pu4HEBzoZA79g+WF
         8fAvfawoqLH6cY3Qvfha90Anxsfb6YHwYURCFTRqg4/uSOtftPnRYBm0ma7MANDkcajG
         c1rRX5Idxlw3M2q4wKUvteDcHfCm4rXD5tM0w7aRgBQrWUHkbcJfMRunPq0tkd+XsWSW
         cok+8GVHYSuZ6/ehgxRcnHtD9EXjOa5PXJ0YtocQqiYtImMXDRy4M/6bZ3J/YWR1YFoG
         UaGK4Ztv/7kliKkX+b/2thdxVRTeNb06m1Um9B24P5O2ucaQSfJshfpON8MDIrBVTa1S
         LrCA==
X-Gm-Message-State: AJIora9DXe9ujFvD0ucEfAFliXXJoW3e/wVw96kww5VbQ381r5F1rq4n
        s7ObMPh8uCbnBrnOHlC82xatU7rhaLRdggfjWRPiZFuYcXBE
X-Google-Smtp-Source: AGRyM1tHLQsEVz458NYnnpXWwtrx2vWgqthv76sDtmbO2gxjC3vfUZaTVvZ/9h1Pen3/3yIdDKZZam/AN9/brL1RidY=
X-Received: by 2002:a17:90b:1e47:b0:1ed:2723:981a with SMTP id
 pi7-20020a17090b1e4700b001ed2723981amr18998871pjb.144.1656686877927; Fri, 01
 Jul 2022 07:47:57 -0700 (PDT)
MIME-Version: 1.0
From:   marty leisner <maleisner@gmail.com>
Date:   Fri, 1 Jul 2022 10:47:21 -0400
Message-ID: <CAPNO-hbqJD=XO=ODA1_FYATj2DW1xrmJtk_hDRhfoGhfqq9nyA@mail.gmail.com>
Subject: problems with ax201
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'm seeing a great deal of problems with the ax201 wifi on a nuc.

With ubuntu 18.04, I got lots of

     iwlwifi 0000:00:14.3: Unhandled alg: 0x707

in both client and hostapd mode.

With ubuntu 22.04 it has the same problem in hostapd mode (but it
prints a different number).

Building and running the current backport-iwlwifi works much better
(no problems yet).   (the nuc is running ubuntu 18.04 with 5.4.0-120)

Do we know why I'm seeing those problems?   How do I equate the git
commit with the binary drivers I'm running (or do I have to look at
source?)

marty
