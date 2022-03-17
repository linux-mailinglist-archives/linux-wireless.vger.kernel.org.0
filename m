Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DBC4DC9F1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 16:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiCQP3g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 11:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiCQP3d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 11:29:33 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0626D166651
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 08:28:15 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id m67so10892437ybm.4
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:mime-version:date:message-id:subject:to;
        bh=9YV+XxfN9qvqRlfP0nyAbGHXEabT3Ft7uOsdiJpOEbM=;
        b=EQx2kDRytm2uN60xkvPrnLReXdD+STj2x8uR7VC1e8gmNOR0JsPuGS4J2JvBOwTVqB
         Y5+/UWmislsgjUqLX9Y8mm1Qx2lJKyLueGLVO6CivGMLRB4slTLpuhoMXTJcVRoDWzcD
         5jFzFUhqnaidzN+MmXxUjABIs3SdTPwkRAYzfclmCpHakssLf45jt2TCc6z6cz6Yyfsz
         yoiptsBbOtFj69eFJNxbBF65lPoLZPEpsOqwBq7z9kCNmIHAOo3DdN/YAcACBZ3BHI45
         fR6f1pnnqjGjEHEgU05MkydtmP+eE4AKaYbnM2qu4JZFoKvljvZjlnMVq+aIU7RKJmyh
         xpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to;
        bh=9YV+XxfN9qvqRlfP0nyAbGHXEabT3Ft7uOsdiJpOEbM=;
        b=4hgeq0TErevZl+ogtakIxg1W5bW77raYgKpnqeWx9xZEBRvefsPp/3D07o0/F99UTc
         ohGOUNrYVv6D8PyKoZ3x6sdHTIVW/+AbGfEHMyo7yGaYvn/Aasj1Uefk6WEwArekonHK
         vri2kPijuU8xfDUo3mBXP+zfSBnFUjc1JGY9mK0GSmuo7gfejUoUQ8BLw4KziK+X+jkT
         1O1MqLa6wJfbgrq/VQzDQmK1Ff0A75vU1AHlG1UAGizX5LlVmkmbzplFI1KB7nAnOX5K
         XuuEoZj14ULcU9uzs4SNFBZjkvwwbIDsLetYzO0pAcL9PLAsyzSZufPfis04utY+9mku
         ZtOw==
X-Gm-Message-State: AOAM533A5rNZhESHmPoj+ffEGqqie5JgvTUdfrQXYwfGq/u5+1CPSnbE
        OWwwOp6V1+Hbk6S81w6JH0icKbIUyRF0S7acQfjHRpY0BTs=
X-Google-Smtp-Source: ABdhPJw4u0Jch0vKXuMsQKGQJIOqKDNiWGVevC9lSjZk9h/AcanfdgI/vMKolq0tyGM/SNZG4xv0zpll0ZxHD6EpKMQ=
X-Received: by 2002:a25:8e88:0:b0:628:bc08:7aa with SMTP id
 q8-20020a258e88000000b00628bc0807aamr5454899ybl.303.1647530894051; Thu, 17
 Mar 2022 08:28:14 -0700 (PDT)
Received: from 332509754669 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 08:28:13 -0700
From:   Scott Anderson <karban002@gmail.com>
Mime-Version: 1.0
Date:   Thu, 17 Mar 2022 08:28:13 -0700
Message-ID: <CAGcbcMBcqFGsXCYxq2E86KehdTziENc-QX=pxmLSkxJq3WsPrQ@mail.gmail.com>
Subject: Banners Order
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Good Day,
     My name is Scott Anderson and i am sending this email to your
business in regards to the order for some Banners and the sizes that i
am looking for are :

1. Measures 30 x 60 inches
2. One sided on Vinyl
3. Full copies Black Ink on White vinyl
4. I want you to write on the Banner ( DON'T MISS YOUR SHOT TO STOP
COVID-19 ) For the Artwork.
5. Hemmed With 4 grommet for outdoor use

I would like you to email me back with the total pick up price plus
tax on the quantity of 150 copies , excluding shipping. Is there a
surcharge on the use of Visa or MasterCard for payment ?Kindly respond
to me as soon as possible for us to proceed further with the order..

Urgently Waiting to hear from you soon.
Scott
