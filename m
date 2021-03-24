Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1214B34784F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 13:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhCXMVc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhCXMVY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 08:21:24 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED92C061763
        for <linux-wireless@vger.kernel.org>; Wed, 24 Mar 2021 05:21:24 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id z9so21158971ilb.4
        for <linux-wireless@vger.kernel.org>; Wed, 24 Mar 2021 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vGGmaol1ombXTxrs/kbVBpNzooqf1zOt+C67x453TRM=;
        b=aDfIfDvAuEAL6JMmrCcU15igKhpl3jaEcO4xD7Rwtu9B+u2biKZDRWjVj+pRpC+THy
         0Zipljo+33YApqLcXAG+apSdB0MW+iy/7OhS/gwJpBfT4RFZ/PKEkyqNcrHdoOVgr8NF
         N7c2/gu/WL1xD+JrNLFxw+zx3YHQ8DAWN92TFrbWnP4X8emhfA7AVHzcOos6cX3OG1P2
         7u2Ehc5Qw1kCIg7eKFrntsv/HRgoqguGIEAhSo/uP63s3V6tuI8YZyZD0NA0k/g/ljY1
         VgzSX9sfuHks5WezpXpR50UFfmRXe+81TwzECB39JXGXdAwb2f/0xnAMVJQ55Z35PvUl
         efQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vGGmaol1ombXTxrs/kbVBpNzooqf1zOt+C67x453TRM=;
        b=hjytAzABrzxEFOe6t7hm/zV/vGbK5XUP/dbLgKshzRtF99nRn5jTtbk42lKR9dLb0q
         tdLTjTZBdAeEqVl4YrCv9appPItG0dEiIIzieizbyMUg1X/oVOyY8cuqAIs/FG6DSlco
         P6xiCQ16/KgmvGx4+lq6+l+O6FavRW8xg7eqZlkk3Fsl6jtyWalHWVNiT2hH76Quc/KP
         a49FYk5fG3JWSqRwYiV6alYG9Pi+CndH8Dp9yeIPaqd4CeRTHwLCI2aAbpui1YFVhxvy
         bAhYfAWMqhZh62YCe29935lw7SLhWpInL1CaRCPhfnEp9hagsGrqBCEjz0k+/I/zdsSw
         oBXQ==
X-Gm-Message-State: AOAM530GqnLTEzHEcL5OtwyFbPgyCoJFoUqSBAffKKOtGC7NFwPFVWEZ
        xXvCGrYK0cuU5B8XSFwM1Tmh3VVY/wJb8qC2Ln+rM1Wx+4f+jw==
X-Google-Smtp-Source: ABdhPJxB8VLYeJtSzcXZsyEzkXEibScdgoBu+5Cf3SBuVH2EYUNVcqZXkpHn1+xUA4oAXVBi25VzhLXgfQ/DdtSoJYg=
X-Received: by 2002:a05:6e02:1a09:: with SMTP id s9mr789230ild.60.1616588483828;
 Wed, 24 Mar 2021 05:21:23 -0700 (PDT)
MIME-Version: 1.0
From:   Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date:   Wed, 24 Mar 2021 14:21:13 +0200
Message-ID: <CAPiS6wC4BBANaY62sV8hxreDBsHXTHr=NKFLrOLc6SOYEiztmg@mail.gmail.com>
Subject: Intel AX210 does not work on 5.11
To:     linux-wireless@vger.kernel.org
Cc:     luciano.coelho@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It was working on 5.10.16:
[    4.274856] iwlwifi 0000:3c:00.0: enabling device (0000 -> 0002)
[    4.279014] iwlwifi 0000:3c:00.0: api flags index 2 larger than
supported by driver
[    4.279031] iwlwifi 0000:3c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
Version: 93.8.63.28
[    4.279401] iwlwifi 0000:3c:00.0: loaded firmware version
59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
[    4.456228] iwlwifi 0000:3c:00.0: Detected Intel(R) Wi-Fi 6 AX210
160MHz, REV=0x420
[    4.607524] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
[    4.673134] iwlwifi 0000:3c:00.0: base HW address: d8:f8:83:d9:35:87
[    6.055731] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
[    6.288461] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
[   72.546602] iwlwifi 0000:3c:00.0 wlan0: disabling HT/VHT/HE as
WMM/QoS is not supported by the AP

And fails to start on 5.11.8:
[    3.882744] iwlwifi 0000:3c:00.0: enabling device (0000 -> 0002)
[    3.937708] iwlwifi 0000:3c:00.0: api flags index 2 larger than
supported by driver
[    3.937720] iwlwifi 0000:3c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
Version: 93.8.63.28
[    3.937891] iwlwifi 0000:3c:00.0: loaded firmware version
59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
[    4.341262] iwlwifi 0000:3c:00.0: Detected Intel(R) Wi-Fi 6 AX210
160MHz, REV=0x420
[    4.486405] iwlwifi 0000:3c:00.0: loaded PNVM version 0x324cd670
[    4.588212] iwlwifi 0000:3c:00.0: Timeout waiting for PNVM load!
[    4.588213] iwlwifi 0000:3c:00.0: Failed to start RT ucode: -110
[    4.588215] iwlwifi 0000:3c:00.0: iwl_trans_send_cmd bad state = 1
[    4.796206] iwlwifi 0000:3c:00.0: firmware didn't ACK the reset -
continue anyway
[    4.808321] iwlwifi 0000:3c:00.0: Failed to run INIT ucode: -110

Please add me to Cc as I am not on the list.
