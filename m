Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47440FEB7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 19:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbhIQRjc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhIQRj1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 13:39:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0FBC061574
        for <linux-wireless@vger.kernel.org>; Fri, 17 Sep 2021 10:38:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z24so9714260lfu.13
        for <linux-wireless@vger.kernel.org>; Fri, 17 Sep 2021 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8Ic9heAFWQvWHlsysjr0qtULCH+dzNXX6SwRzJsLh7A=;
        b=VODqn+dPezLqCkknge6fHDw1JXg8ocx1DxEQ8l7BOoEZ0mBZqDGF55bP5K8F53sNG3
         H79MiNTZpZD+ncW6wt8FHqGNJKdw0DETqBGkcnqrm69ougytiMsOhvdimSMnhiDOrgUb
         c8Y83Y0miwoNgUwIJMksl5Ik/fcyOzFLFk1pyDD/nLMGSnbWM4K7qthZVHUs8EvgcLy6
         EdFvPBhQ5+5DyoeIcTcCOEs5VofpmLhCQNEZBnuMVIVMgR+Bvogm0jwBq/PrsDyy7QJH
         u9vUd/BgtX0tWi3Mmr+83qwaL6U8LL2IeTt+3vUc6WTEhxeoOASR6XoH510M7N3azPA6
         RnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8Ic9heAFWQvWHlsysjr0qtULCH+dzNXX6SwRzJsLh7A=;
        b=AA9Wc7NRKfJsiYotWHyubZvF/0lH4XfM8e2OZXqSViYEvZWzhsQPxj2zACHtvlNmzB
         ZxIcYamvk+GfdIUVCF5Z1X1+WlBb4AOQR5naX7eOsjG6jUW9+/ybGWxPD62wXjjt/Ot6
         CBGzBTkg4fpBZhlLMUTTu+zTWMw/Md83oOPtKcbKXQ+XsyB1pRubBei7/nzv+0TM8yVM
         CxMGpVbJ2lvwbk/DqN37q8PDOr790mWRC9yyP5uF+CqfvJZ8J2UYPlkyne7uy9cOO35X
         y1hgU5xJVP23sXTj5lZFoTCJl8Om5Dbzsm+erObUGpN+FmCWdYBg9bgdlsyntmMmd6cN
         r1zg==
X-Gm-Message-State: AOAM531HWqHW4YOybMLdGc4P8B78UiUvQq4+v16i0wSD0aY5ngHQjpJX
        U34aCVgJ92f/XtF4C4U9QxboY76q+2Ds3yBrKBU=
X-Google-Smtp-Source: ABdhPJxTHBCQsAfHoZec+mfLpPPlQ4mFgEuhYjpomdT9+1VDUN79GuGeOKHuD/+mzokceEOdGQspxJI3UtBCFbHW+dc=
X-Received: by 2002:a05:651c:4d4:: with SMTP id e20mr10841946lji.402.1631900283008;
 Fri, 17 Sep 2021 10:38:03 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 17 Sep 2021 14:37:52 -0300
Message-ID: <CAOMZO5BROh1wET6vcif_8Q+aMQUFqRMP5uttBBLV8nJnbOv8rg@mail.gmail.com>
Subject: ath10k_sdio: failed to write to address
To:     Kalle Valo <kvalo@codeaurora.org>, wgong@codeaurora.org
Cc:     erik.stromdahl@gmail.com, niklas.cassel@wdc.com,
        ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        alagusankar@silex-india.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On an i.MX7-based board, I see the following "failed to write to address" error:

ath10k_sdio mmc2:0001:1: qca9377 hw1.1 sdio target 0x05020001 chip_id
0x00000000 sub 0000:0000
ath10k_sdio mmc2:0001:1: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
ath10k_sdio mmc2:0001:1: firmware ver WLAN.TF.1.1.1-00061-QCATFSWPZ-1
api 5 features ignore-otp crc32 7746e551
EXT4-fs (mmcblk0p1): re-mounted. Opts: (null)
 ath10k_sdio mmc2:0001:1: failed to fetch board data for
bus=sdio,vendor=0271,device=0701,subsystem-vendor=0000,subsystem-device=0000
from ath10k/QCA9377/hw1.0/board-2.bin
ath10k_sdio mmc2:0001:1: board_file api 1 bmi_id N/A crc32 544289f7
ath10k_sdio mmc2:0001:1: htt-ver 3.32 wmi-op 4 htt-op 3 cal otp
max-sta 32 raw 0 hwcrypto 1
ath10k_sdio mmc2:0001:1: failed to write to address 0x12ff5: -84
ath10k_sdio mmc2:0001:1: failed to write skb to 0x12ff5 asynchronously: -84

The wifi is functional despite the errors.

I tried applying Erik's patch:
https://github.com/erstrom/linux-ath/commit/6507fd8df431e1d1f1ea344224956387dc1d35aa

and the one from Niklas:
https://github.com/erstrom/linux-ath/commit/4e794a12fa89e353e38528d1ada5d86f19672c3c

but it did not help.

Does anyone have any suggestions as to how to fix it?

Thanks,

Fabio Estevam
