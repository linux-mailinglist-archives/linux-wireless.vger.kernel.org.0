Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFC340328D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 04:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347082AbhIHCUb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 22:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhIHCUb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 22:20:31 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753DAC061575
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 19:19:24 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s11so900637pgr.11
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 19:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:subject:date:message-id:mime-version;
        bh=9CTgsXH1OpAWsvS5kM+f8xUiLJKc/FWlzvzHe9yeiYI=;
        b=ML9CO27jlXqlKJhM7J7Os6eggFGpB/Q2BLXvut9Ot2X2iqHWeKL8G9yNxFaNVEpidd
         DdsZGhkvlHN7I+22u9RbGXTV150UvqTUmdSIHgDASuruYKD4oY+Zy5nJqWrUs+b3Yqok
         /613NOfd64eiCOE6j017BB7ZTBrXRxRWuIbtncbn5nctyumNgfmKj51JxBvRmEM4MpOv
         JDulHjbDYDQKGGSIBu1ePj6sJX3iES/Bf2Ys8ZkzV3+Nyv+HZFRyzPL9YA2eyjVN5UnJ
         pFP9H7rN0Z0CmItnqzmKrPSAjbSU3gBYYcCaw5QjoocJg6UCyCwU82qlZQWVw8Qq1Fnx
         cpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject:date
         :message-id:mime-version;
        bh=9CTgsXH1OpAWsvS5kM+f8xUiLJKc/FWlzvzHe9yeiYI=;
        b=TMhcnSHZAW8QaGPoeIwV9H6BYr4JApKwHTC5Kf5qc3nZoNGAMOX9aRetU2ubJ/rbLo
         XpsCKHTNtBYyr6rG9eTd3s6ZOe3y/R6dsTEIq1sIhbGjqBeB2I5SDJAa+DatX3meOGDh
         TgikNIVn8g0Ibju60cCfBQIkhLflEcsTA2rMqbvIype3G0WtfwXbvRHp2nKP+LWwKLc0
         07/5xgwNWzxyjQa61MqNwBXFhF1RIxh68Jk+GWwNGMd9k20VPIp8H/Z2zYar+jJAyixI
         RvFmEoKWVgJsZvZvWmtaFkHISkiOd24UEKknypJDra5UtlLphnhU7WDScEI6sAwUA/XR
         vWLw==
X-Gm-Message-State: AOAM530/2b9MkBAEdmnUMLu4uzY0sfNDDejzJy1rJi8lmJJQp0GzHv38
        +g7dQAxHExtHtJ9m5BiYkKhcQuQ3KNc=
X-Google-Smtp-Source: ABdhPJzZjqTel3W7pKO5wwIp4VJib/0ETxUmQXCIvYoXZMC2HkpbJIWcJNNNOLMG/fDG3G4Wf/tVAw==
X-Received: by 2002:a63:7012:: with SMTP id l18mr1333437pgc.167.1631067563758;
        Tue, 07 Sep 2021 19:19:23 -0700 (PDT)
Received: from localhost ([120.21.217.232])
        by smtp.gmail.com with ESMTPSA id t14sm436520pga.62.2021.09.07.19.19.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 19:19:23 -0700 (PDT)
References: <8735v9sdw6.fsf@ada>
User-agent: mu4e 1.6.6; emacs 27.2
From:   Alexis <flexibeast@gmail.com>
To:     linux-wireless@vger.kernel.org
Subject: Fwd: rtw_8821ce: "rfe 4 isn't supported". Asus D509DA laptop.
Date:   Wed, 08 Sep 2021 12:13:49 +1000
Message-ID: <87ilzbollj.fsf@ada>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi all,

Just following up on the below, which i sent back in April:

  https://marc.info/?l=linux-wireless&m=161968427506696&w=2

Using kernel 5.13.13, i'm still getting the "rfe 4 isn't 
supported" message; and additionally, someone has commented in the 
tomaspinho/rtl8821ce GitHub repo that they're getting an "rfe _6_ 
isn't supported" message:

  https://github.com/tomaspinho/rtl8821ce/issues/142#issuecomment-914574651


Alexis.


Alexis <flexibeast@gmail.com> writes:

> Hi all,
>
> i've just acquired an Asus D509DA, and wifi isn't working:
>
>    rtw_8821ce 0000:01:00.0: enabling device (0000 -> 0003)
>    rtw_8821ce 0000:01:00.0: Firmware version 24.8.0, H2C version
>    12
>    rtw_8821ce 0000:01:00.0: rfe 4 isn't supported
>    rtw_8821ce 0000:01:00.0: failed to setup chip efuse info
>    rtw_8821ce 0000:01:00.0: failed to setup chip information
>
> `uname -a`:
>
>    Linux voidlinux 5.11.16_1 #1 SMP 1619045101 x86_64 GNU/Linux
>
> Void firmware package:
>
>    linux-firmware-network-20210315_2
>
> Some previous mentions of this issue on this list:
>
>    https://marc.info/?l=linux-wireless&m=159981742905028
>    https://www.spinics.net/lists/linux-wireless/msg206075.html
>
> Some other mentions elsewhere:
>
>    https://bugzilla.kernel.org/show_bug.cgi?id=212435
>    https://github.com/tomaspinho/rtl8821ce/issues/142
>
> Please let me know if there's any further information i can
> provide. i'm not subscribed to the list.
>
> Thanks!
>
>
> Alexis.

