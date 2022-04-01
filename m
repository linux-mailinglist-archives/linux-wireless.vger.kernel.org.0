Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA24C4EE7E6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 07:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbiDAFv5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 01:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245181AbiDAFvy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 01:51:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944655BCD
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 22:50:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b15so1698672edn.4
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 22:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ppHqKeKh+Y7gLl6VUDX29RPztSoubgtGlWJ4DyZKx/4=;
        b=SrFIMyQmbcifUZtE2XZV9zXfqRE/TCP1E4NsZnkzG13uBXCopfUUfGcv2QegxSP8ef
         RP/+bGAq/wfwxbri7yClPbM4OoLT20QZEOuzI8NNJe8vRa05ZGRe/QnpFeCFDiBAiqGv
         eKXdnJaIaVF2nIo/j5VEOsS+LO752p+I+P5C+mS7k74dOX145Prx0c1U4CZymrhxZH0G
         v0N7GLzVYAOAhzauF1mlKJnAFcX2z//yLeMvNGVI9HsZaGHbX/rwNOc4i2KpmqbnR/2+
         AgWLD2hDQybrCIFZog++dc9DEvy9zC7YntGydkLyTKNk7+fmEvFQq/wpsd1yX7qq0v3d
         cKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ppHqKeKh+Y7gLl6VUDX29RPztSoubgtGlWJ4DyZKx/4=;
        b=XExleDAbPS1pfchYDLV7ga+oQTl9bq005j7nLu/kYYzGVkv8M/tMIL2VqGwT6jVlkP
         DaNkpAuL8Hz/WoHlg3lLB7yP/VChfXj9MvDMg4Eq3jw0oPkBg6lej7cv9+7QNeKoNz9C
         OSrE9OCowZ9aAi/GYlFEeMjJ0m67lV3Plb5TrjlSgvA2MgGxC5iu/mL8N6lFfjQjBZuM
         f1bDJmtYGssZ/+D9kff/DgCCu10VG98n7G9EKnw5YXf3r18A4+qnfSqI5cV566dEN15k
         d5NhJ8KvDd7mSTTR5xKQEMjY30DgVO6VpmBdeXEWosjwTwjzxQhIFAw2QIi2XESa3CVZ
         yhfw==
X-Gm-Message-State: AOAM533QbNwQH7m2iu2sr6g4l+MA+G/vBSK+48h5emhV4/Lj8jOVo+Ec
        ME9KDeWyNPjHejEiOxeLww13lHJ1OzJ1v/LH6as=
X-Google-Smtp-Source: ABdhPJxdw69QRhZcQ645gQ1IgdvpT2+04O1H4WlJhDiamWBUDRGKhNKV0kw4z6AwIbTOtVIZGb7qJbUOnNFNlf2iu8o=
X-Received: by 2002:a50:99cd:0:b0:418:d6c2:2405 with SMTP id
 n13-20020a5099cd000000b00418d6c22405mr19628573edb.342.1648792202191; Thu, 31
 Mar 2022 22:50:02 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Fri, 1 Apr 2022 06:49:47 +0100
Message-ID: <CAHpNFcOiFu-ZUBKiEHzzbVusUVVceMaKFTsNpr5S01qjCvbCdQ@mail.gmail.com>
Subject: OT-SVG Fonts & TT-SVG Obviously Rendered in Direct X 9+ & OpenGL 3+
 Mode & Desktop Rendering modes
To:     submissions@vialicensing.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VecSR - Vector Standard Render

VESA Standards : Vector Graphics, Boxes, Ellipses, Curves & Fonts :
Consolas & other brilliant fonts : (c)RS

SiMD Render - Vector Graphics, Boxes, Ellipses, Curves & Fonts

OT-SVG Fonts & TT-SVG Obviously Rendered in Direct X 9+ & OpenGL 3+
Mode & Desktop Rendering modes

Improve Console & TV & BIOS & General Animated Render

Vector Display Standards with low relative CPU Weight
SiMD Polygon Font Method Render

Default option point scaling (the space) : Metadata Vector Fonts with
Curl mathematical vector :

16 Bit : SiMD 1 width
32 Bit : SiMD Double Width

High precision for AVX 32Bit to 256Bit width precision.

Vectoring with SiMD allows traditional CPU mastered VESA Emulation
desktops & safe mode to be super fast & displays to conform to VESA
render standards with little effort & a 1MB Table ROM.

https://science.n-helix.com/2016/04/3d-desktop-virtualization.html

https://science.n-helix.com/2019/06/vulkan-stack.html

https://science.n-helix.com/2019/06/kernel.html

https://science.n-helix.com/2022/03/fsr-focal-length.html

https://science.n-helix.com/2018/01/integer-floats-with-remainder-theory.html

https://bit.ly/VESA_BT

*

*Application of SiMD Polygon Font Method Render
*3D Render method with Console input DEMO : RS

3D Display access to correct display of fonts at angles in games &
apps without Utilizing 3rd Axis maths on a simple Shape polygon Vector
font or shape. (c)Rupert S

3rd dimensional access with vector fonts by a simple method:

Render text to virtual screen layer AKA a fully rendered monochrome, 2
colour or multi colour..

Bitmap/Texture,

Due to latency we have 3 frames ahead to render to bitmap DPT 3 / Dot 5

Can be higher resolution & we can sub sample with closer view priority...

We then rotate the texture on our output polygon & factor size differential.

The maths is simple enough to implement in games on an SSE configured
Celeron D (depending on resolution and Bilinear filter & resize

Why ? Because rotating a polygon is harder than subtracting or adding
width, Hight & direction to fully complex polygon Fonts & Polygon
lines or curves...

The maths is simple enough to implement in games on an SSE configured
Celeron D (depending on resolution and Bilinear filter & resize.

https://bit.ly/VESA_BT

https://www.phoronix.com/scan.php?page=news_item&px=FreeType-2.12-Released

FreeType 2.12 Released With Support For OT-SVG Fonts
Written by Michael Larabel in Desktop on 1 April 2022 at 12:00 AM EDT.
Add A Comment
DESKTOP -- FreeType as the widely-used, open-source library for font
rendering is out with FreeType 2.12 as its first big feature release
since last summer.

Most significant to FreeType 2.12 is introducing support for OT-SVG
(OpenType-SVG) fonts. OpenType-SVG fonts have been backed by the likes
of Adobe and Mozilla for adding an SVG table to OpenType fonts.
FreeType relies on an external SVG rendering engine via the svg-hooks
property of OT-SVG. FreeType's demo programs are making use of librsvg
as its SVG rendering engine.

FreeType 2.12 also updates its internal Zlib code, provides minor
improvements to the build system, support for non-desktop Universal
Windows Platforms, and has a wide variety of bug fixes.

Downloads and more details on FreeType 2.12 via FreeType.org.
