Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BEC6EDEA7
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 11:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjDYJEe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjDYJEd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 05:04:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2DC10DE
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 02:04:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so42110115e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682413470; x=1685005470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nmoCLIVa9HlVHZXfy1Y47j7K/M+liTo5LThTphR/hEQ=;
        b=TWdPGtCWQlMaUEu1+qAQ39mNuBoHU7FfC63/dnlK2bcCoiqLO3GlQ+jRHhwgWL25zG
         IYXcRpq9suwH7ZXSx9IzaSK47mlMTm8bZdJjchMuLghnLJJD6JTB8Quatuwqo960LhJt
         KEe7XofZy6rx6QUR1GMgR2UH5AXaB4qxXTdklAA98o8rvMJrk/SwvD8hYWg5RC58asah
         zvbVINy99tnnlySBClQ4/Y3hj6K8OEgBaQCZ/RHZa1AyPTF9NKAaVv3RmZnZDlVBz332
         N53daiieTZ55JvF2M4jvhtLgWPV2zsgbAJxSJqbtTSI7VTOT/+A6gnLoIFxCbMaTm4W1
         1fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682413470; x=1685005470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmoCLIVa9HlVHZXfy1Y47j7K/M+liTo5LThTphR/hEQ=;
        b=GUMa5/CnqNAXpgOD7VLiHQ7P7uskoLWGB8tGYDl3bUudiPiTbQvsOsezluV8el6oUZ
         332ioJepTIAccOsvd1Nl0wV4IGQawUEDs77z+w5Ou6BEDj70RTs2tMhvBYtKXYneg6xz
         2sIA5ibONZH6DAuMG801Coo88YA3/g8ZfU8KkZU/FKLGs37QqWxOhQbdDE4P2JLXsZRB
         LHe3dmdzBd4mpM5LfNIKIxvMJk0VZ6yaIIIpK6JNnlFuf3leTtMjKtGWwKFZgEEDlplc
         cf07qDaXW8rWh9MTecb23MlhKGZCOJPQ9/wI8oYGCXpQMuOv1h4myPLpKGIfni/16IBT
         YE/w==
X-Gm-Message-State: AAQBX9dnw/JFendBb7JjWXFckLz8gB/ZpK1mODAAcLkLXVBv+ny8WKAm
        ItE1wickjEFQoecFCIGpB3qnbuOR/lw1GnJ5vVg=
X-Google-Smtp-Source: AKy350ZS/SNX9Lr8iwYkln1EWNYFKpkz7UN3kuuyKZziH0oYNnTJYRZt7GuSFS1A7PW9cDDeNmM3RyEddMWai3jC+Ag=
X-Received: by 2002:a1c:7211:0:b0:3da:1f6a:7b36 with SMTP id
 n17-20020a1c7211000000b003da1f6a7b36mr9324205wmc.0.1682413470206; Tue, 25 Apr
 2023 02:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com> <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com> <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com> <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
 <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
 <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com>
 <3ceecfc1-ab04-7d54-51bd-457a4708c0ac@gmail.com> <CALbLcfCpb8xbN+w2VvCZ6Gdr+L_ECH0UQsWZrpO1Hcpoef66UQ@mail.gmail.com>
 <8eaeb64e-3f7f-6752-4476-c0f0c88a008b@gmail.com> <CALbLcfD7AmMG72-Qxafc9533OQVBCL=RLDycjUCV2MJ0DRN6nw@mail.gmail.com>
 <2a679614-c964-dc3f-c987-6c7ee03923a0@gmail.com>
In-Reply-To: <2a679614-c964-dc3f-c987-6c7ee03923a0@gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Tue, 25 Apr 2023 11:04:20 +0200
Message-ID: <CALbLcfBGg8FTBZx-_8v6u5iLsAssr+=QgQYc+Q2bUbmEwJPRYQ@mail.gmail.com>
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
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

Hi,

> > As a workaround: What about checking the IP length field. If the
> > received packet is smaller by 4 bytes than what it should be then just
> > add extra 4 bytes at the end? Or does the MIC at the end have any
> > influence on anything?
>
> That should work, but it's ugly.

I did it and it is working, and yes, it is ugly :)

> If the router lets you change the MTU, does it help to make it smaller?

No, this is a bad idea. It will bring a lot of other issues.

> Do you have the problem with the v5.13.3 driver? If it works (other
> than completely dying after a while) we should see what it does
> differently compared to the v5.2.2.4 driver.

The v5.13.3 does not have this problem.

I have tested 3 different approaches and also made some quick speed tests:

1: I changed the skb length according the IP header so the packet is complete
2: Disabled ht by sband->ht_cap.ht_supported = false;
3: Tested v5.13.3 driver

Speedtests with iperf:
IP header hack:
24.5 Mbits/sec

HT hack:
18.7 Mbits/sec

v5.13.3 driver:
54.6 Mbits/sec

The v5.13.3 driver has the highest speed and does not have the missing
bytes bug. So it does something different...
