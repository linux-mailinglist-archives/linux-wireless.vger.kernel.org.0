Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9575F82F1
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Oct 2022 06:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJHEcg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Oct 2022 00:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJHEcf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Oct 2022 00:32:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C4F88D0
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 21:32:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q9so10520629ejd.0
        for <linux-wireless@vger.kernel.org>; Fri, 07 Oct 2022 21:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=systemoverlord.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ROl7jv+q6JFCkJFUmb8Ib+38tcy1O1ytZLjGKvF4U10=;
        b=WaGhNRC+MTwV1QDHq4RuVpA/pTvDsMXQSHZS8/4F6XgT51ER0yIH220CzYQMxhBaw+
         RaO3YXhgz3m2V2dxN4tCrS9jmYutO8Wy+wBSfv0GJPrvfS/nCmVbpbBjd3GpouYjMcEb
         PHCDAFbfL4WRK/e0+jhBArwYXKDhHaWtS9VljtJ27K0G5pATihkOyTBPd1FksG2iVlx3
         qytu7XbecHvIti4NQ0imIdEyqkM6O0lhaTKXMUiQejTnz4oIqMG5G7W4L/A1M2sG05Mi
         q78Lxm0tA83Y1yQlwWE0G2xY0LnZaEdJElbTVdi9FnU7d7z1QV26ZY+/Jsp/S5PRhPUZ
         jEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROl7jv+q6JFCkJFUmb8Ib+38tcy1O1ytZLjGKvF4U10=;
        b=nRih5cjg8Fmea6jrCBdBqzIukYx1IeAvMiaUzrlYN7ZhixmExOVJFGHWA0p5h3xvI3
         a8jgiw6pkW54Sh05uT88jQ8YRGV0RzwEU1F7lJTcoVqu4LmAG3VcG3gARlH4vLz7v4Xc
         gjT+6fuO4SCx5V/ZBfZoQy80BNwCf0eAdFi4AJXaLqod25AwIKrXTkkFhrqTNeeDtufP
         BBFJd+uyOprAN56AYwDl+ELSHoL8VKum4AWMjn/RdU8CiAaaIC3gBH7pHziF8xrbf6SX
         SBLifEl4MAfhogOwKKI26dzcd0pOd2Tz+4spxpg7yjWnbBIOueUGrNE6OaJrW02VkJbp
         eQ2Q==
X-Gm-Message-State: ACrzQf3IRNaZ5t+l1WWeOOe5VMulZMaptAVEs/ITUwdf0Gg6gRpEfka0
        Psx1BysRH4Plb7JuaIrLN+XXB5GPNPfw0pmpjMTJFrWiZxUmzQ==
X-Google-Smtp-Source: AMsMyM6Y8OEgNidH78TGfYAgG2XBwr76d+CLSCfs0SnnEXO8/oSlXtyOGK+M7OIFdNRQw7hQmYxAdrIhEDoip1060io=
X-Received: by 2002:a17:907:2d06:b0:78d:50db:130e with SMTP id
 gs6-20020a1709072d0600b0078d50db130emr5523534ejc.371.1665203552342; Fri, 07
 Oct 2022 21:32:32 -0700 (PDT)
MIME-Version: 1.0
From:   David Tomaschik <david@systemoverlord.com>
Date:   Fri, 7 Oct 2022 21:33:16 -0700
Message-ID: <CAOy4VzfHRD0cw2jdL=pzukc1QFuXgaC55Zst7uc-dMFPrHr7Yw@mail.gmail.com>
Subject: rtl8187 triggers usb device reset on kernel driver disconnect
To:     linux-wireless@vger.kernel.org, herton@canonical.com,
        htl10@users.sourceforge.net, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

It seems that any time the rtl8187 driver is detached from an rtl8187
interface, a USB device reset is triggered.  This is not a problem in
the general case, but when working with libusb, calling
libusb_detach_kernel_driver
(https://libusb.sourceforge.io/api-1.0/group__libusb__dev.html#ga5e0cc1d666097e915748593effdc634a)
results in the device reset, which then causes the kernel driver to
re-attach to the device.  This prevents, for example, forwarding the
device into a VM using QEMU/KVM.  This seems to be due to
rtl8187_disconnect calling usb_reset_device.

The 8187 driver seems to be the only realtek driver unconditionally
resetting on disconnect -- is this technically necessary?  I'm not
sure I would call this a bug, but it's definitely behavior that was
very puzzling to me and I only understood after enough debugging to
start reading kernel source.

David

-- 
David Tomaschik
https://systemoverlord.com
david@systemoverlord.com
7FD5 8D9A 196D CEEE AD67  1F94 F4D7 A791 5DEA 789B
