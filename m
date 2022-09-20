Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA745BE437
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiITLPc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 07:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiITLPZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 07:15:25 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A7B6F27C
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 04:15:20 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 3so2248819pga.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=6Rf6LJkgpvLk5bmpD6TE6E6GWjPQelT759rjSCzhTF8=;
        b=PZlk5/Bce/GtuFyDh8kXkVx5Yb8WrmrWDYyTF+eq7fSNAE48ax5E2rrlTZbNa/vXK/
         fDrFeqWl7XCk6oZEAIowpZhtpeHEP6gfCy6ddDT0eF55tXFOPv05rXi8x538h60Zi6rE
         8c1KqVkONAHffWmCtLepIrGJrJU3n+79+9umOB7iVsHYIm25+F+j2DaFePUjKo7BWWy+
         oL4d/FEQ4Jc1TfGD6AAG/8viL7SBVM8R3sTsKw2x1FRDGYqlWqh+szOkENPWoWEKxBL/
         /JyQ0galHgTTn71YY4a6gaaKEJK81tsZRRQaqZz5q6SvB7Yc2nEA+fafSONVjZ7XJ4UO
         +4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6Rf6LJkgpvLk5bmpD6TE6E6GWjPQelT759rjSCzhTF8=;
        b=RvxhW3KDSl/s2GbszFjk46oozshuHclRVboJ/zVgnV//rLmoF+3z9zdvlJmWrIH/ao
         b8znIfScLZe7j6j3ul09blhDQ4pTmY9RWOvUSkeeMinFK/9/1FIwBIMhrZHigG7djHfw
         iCPK44bmSlfeewp9ujE1eTgrcfgcmblPqVjbaL2P9ZHdpjEO0TdqI5y6pz+PHXBrCqxS
         dbNutdP8I1EOZjp6gKS1vUahprTE2tqA5k9scK/Qnj90+A6Z6Jvw6w8RCNCgptYhLEPJ
         ZEweTK67Dlbq1C4vzbK63MsV+46a4U4DFM+SwDvjZtk7IAo8N2wgoA2qanyf9NA2S4t2
         UeJQ==
X-Gm-Message-State: ACrzQf03ItqbVN+GdhohiJaTzTak5HuqWajr92v5gB0uBtQjf88vMRFt
        i9jD07aMdAj6Ab4Vm1+L1mcQdxwaun4GGAEHgYM=
X-Google-Smtp-Source: AMsMyM6uXyVI4zfb7Fk2s3chmzgBlKqIi2tpNCocfw3A4or4eE+yyr4MrV4g7wmxcTzgMDRiX3vrUshnAtnJxnQ9Y+k=
X-Received: by 2002:a63:fd41:0:b0:438:7670:589a with SMTP id
 m1-20020a63fd41000000b004387670589amr19510180pgj.148.1663672519938; Tue, 20
 Sep 2022 04:15:19 -0700 (PDT)
MIME-Version: 1.0
Sender: aagbidji@gmail.com
Received: by 2002:a05:6a10:6712:b0:2f4:518e:6211 with HTTP; Tue, 20 Sep 2022
 04:15:19 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Tue, 20 Sep 2022 11:15:19 +0000
X-Google-Sender-Auth: XZeAPVYRmAqDi3-5VWKKAZhP8D8
Message-ID: <CA+6YaA7gNqDz-3v6r=6VtY60LMa1M=A2AUsnq8NQaGtz+0jnUw@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hi ??
