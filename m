Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1754EE950
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 09:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbiDAHxf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 03:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344002AbiDAHxY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 03:53:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555A1262401
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 00:51:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k23so655952ejd.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Apr 2022 00:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=nXjAzXLpXSZdHQ34t/UZmSG0B+pcFpFO0TzLkKO37nA=;
        b=R5qxyMq0KSgMLORzVFr6f8JZchVpBqg3vw6QZkgQMBmMpmrWvKJXEkPbDrZs+NDRNX
         Q03+2GBXLOuu+WGHr2ImgjCSP8i5ANZM6zdGZHPChpz6m1xhNKPBNPmzSPCmhFczeIiG
         zBBE5QrYUxqLcx7KAqLrrRxVbscoBuS+Nz0+d/T4WtF+Fz7Cyc0JvzCcF5/+dviBqJWY
         GhXtl/dXbzv1w9GW18RawAEXaU70jdKR1CPuevT7lUMwFRzc8G1G+ukqTCVltycG1Dwb
         4kf+VTT2GgdcwdOYxr1ksgSfhfhDaqD3WpPlg0ZS9r0RijRNPPQu60iG14SENDohcZyP
         MHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nXjAzXLpXSZdHQ34t/UZmSG0B+pcFpFO0TzLkKO37nA=;
        b=Zd6PjuUDy/sy22uZTXJY7kAVtAg9hxJNcEBVz6qVMLIDsb3ZlhPHH+vHGneEce8dzq
         ToRCk2YRnVb9xoDDSYcfvfqaa+qi3xKd67tFFi0pfDzkjLRfaD516w3Xi263+41o7a22
         dXDBfLZVTnAxjwhQYI139rWHuW5WeV/DIYelXl4NFXrlKqkCpnZTyHDZyLU0eiBIYhh+
         1IK+FKRzVNRHtLP76NDRlAFN3j4Zcf+WsOWqRtnbzlcqUqssuy355GdqWSP2vAW3Mc+e
         g6vjzVDj9XSSfppt8men5+wTZJP9+hx9m4Ne35Xi2MjpGj8H60sWndqCMtGwAUsUUcIk
         lsBg==
X-Gm-Message-State: AOAM5339TbKhRBOtI935LD8F8jkcqjwxU7ZPYIUvse7byUzOLRxZFP7x
        IcPkh0Y83n8+hqFFE44h/wRIQ0oPqjQO14ADFmc=
X-Google-Smtp-Source: ABdhPJy15tXaBUCoFtBaiXbg+DtyxG4m2FK0tsoBWDirs3TPeDTGqKEPNXZ3qdpz2WbQOSw71PF4td1cPe7M8XL04po=
X-Received: by 2002:a17:907:980d:b0:6d6:f910:513a with SMTP id
 ji13-20020a170907980d00b006d6f910513amr7769180ejc.643.1648799491620; Fri, 01
 Apr 2022 00:51:31 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Fri, 1 Apr 2022 08:51:30 +0100
Message-ID: <CAHpNFcPUVeOhEnL_10u9Omb+LDpYXjTPkYzteduPYWFiLe90bw@mail.gmail.com>
Subject: Though the VESA & HDMI & DisplayPort standards Facilitates direct low
 bandwidth transport of and transformation of 3D & 2D graphics & fonts into
 directly Rendered Super High Fidelity SiMD & AVX Rendering Vector
To:     moderator@vesa.org
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

Though the VESA & HDMI & DisplayPort standards Facilitates direct low
bandwidth transport of and transformation of 3D & 2D graphics & fonts
into directly Rendered Super High Fidelity SiMD & AVX Rendering Vector

Display Standards Vector Render : DSVR-SiMD Can and will be directly
rendered to a Surface for visual element : SfVE-Vec

As such transport of Vectors & transformation onto display (Monitor,
3D Unit, Render, TV, & Though HDMI, PCI Port & DP & RAM)

Directly resolve The total graphics pipeline into high quality output
or input & allow communication of almost infinite Floating point
values for all rendered 3D & 2D Elements on a given surface (RAM
Render Page or Surface)

In high precision that is almost unbeatable & yet consumes many levels
less RAM & Transport Protocol bandwidth,

Further more can also render Vector 3D & 2D Audio & other elements
though Vector 'Fonting' Systems, Examples exist : 3D Wave Tables,
Harmonic reproduction units for example Yamaha and Casio keyboards.

(c)Rupert S

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

https://science.n-helix.com/2022/04/vecsr.html
