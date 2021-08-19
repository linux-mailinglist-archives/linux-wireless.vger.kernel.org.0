Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F63F1F22
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhHSRaQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 13:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhHSRaQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 13:30:16 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D4C061756
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 10:29:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p38so14665586lfa.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QgtLVsr+5oO9IxoWKSZoPjh8Ntw6W8OxwbmFL5GDnpk=;
        b=KCqhexsIFEgPY77b2ty8qN77px4qfGZukAnIdzjCR3KIJP3PBC/z5nNZbqZ8cWS0bv
         ibSX43Z9KIgmyTv5B+DbMqHdoBGMLh51nVfRWVLlPkDr+KJjUngNRITthjNwz8ObYGiD
         7aMSAHxZ6NBj5ouoep9TPjghrBxDwR15+pvIaTH7+1ITlWLIZJ09ZVyHf2h9E+XuZh1+
         Vc+49nAoi8TtWomufCLmkAECS9PWc6Vrk/wOGLg4t7YQqNBSBisxp1NUtBtzBlMKCbQ9
         pdOw5S7/llhJmMXNg/j/nBHayDMtb083U22CQ4nNoP9y1j2X7zyKubBhU8F+VbuRY5Qp
         1esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QgtLVsr+5oO9IxoWKSZoPjh8Ntw6W8OxwbmFL5GDnpk=;
        b=Qbe0tRBFseBhgaNrnF0Q6OqosySb4j3QjmBnKiLrDaPBnFTqTgsBc41fRa28e7D3Di
         fUGyAR+MFuooEDYas74DBTTP2ikISGYLdxIf6bzz1gylq+LTao4fNdpKiHng687Gofj/
         QNYDg8rXy/r4idU090y/45EW6OOw1vmNyqK/DcUijJl9czovgYhwQLFhBq+wU4Djq3I9
         BKWvBjKLj4p9xq7S7FBnPHGM0Lg7PBKdKdl5WHMXJanQ2rhqQfXkL8EF/LM0dCv+2yRY
         o7B3EbZxTF+Up67c77X0jyFn+RzwpCTcAoLqd1BViVX2MccoIxktqDcBQjUlngXZpVn4
         TxXA==
X-Gm-Message-State: AOAM530bWM6DX5ZjGPsJhsVo2fTRMEk5HXHQUDjsCAKIWzP7ILiVhSDp
        nmKgFK3xrY8BtO3VDqg+pnwz4Ya8ISqVnOLV1VM=
X-Google-Smtp-Source: ABdhPJxT1q+pOP83PFCaUwAMGV5W/MyEdJz40L9jSbGFVrMwPsJO/3LmF4/056o1pBV8TMUAoT8Z6lqXPWNjQyhVoXg=
X-Received: by 2002:ac2:4143:: with SMTP id c3mr9098853lfi.295.1629394178212;
 Thu, 19 Aug 2021 10:29:38 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 19 Aug 2021 14:29:26 -0300
Message-ID: <CAOMZO5CHuYX6heA-3+jJ+wHUOBFcLsiy43E9qOoOx3WuJ_kP_g@mail.gmail.com>
Subject: ath10k: Incorrect MTU size for SDIO
To:     alagusankar@silex-india.com, erik.stromdahl@gmail.com
Cc:     ath10k@lists.infradead.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        wgong@codeaurora.org, Peter Oh <peter.oh@eero.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On a i.MX7-based board with QCA9377 chip, I received the following
report from a user running kernel 5.10.48:

"Doing scp or just pipe through files with >10 lines I get stalls and
error logs. The ath10k_sdio errors look like this:
[  196.822363] ath10k_sdio mmc2:0001:1: failed to transmit packet, dropping: -12
[  196.830109] ath10k_sdio mmc2:0001:1: failed to submit frame: -12
[  196.836279] ath10k_sdio mmc2:0001:1: failed to push frame: -12
[  196.925452] ath10k_sdio mmc2:0001:1: failed to transmit packet, dropping: -12
[  196.933090] ath10k_sdio mmc2:0001:1: failed to submit frame: -12
[  196.939334] ath10k_sdio mmc2:0001:1: failed to push frame: -12

I am able to reliably reproduce the issue by sending a lot of data
from the i.MX7 board to a host connected via the AP:
printf '=%.0s' {1..24000} | nc 192.168.0.2 1234

I was able to narrow the issue down to the mtu. If I set the mtu for
the wlan0 device to 1486 instead of 1500, the issue does not happen.

The size of frames that I see on Wireshark is exactly 1500 after
setting it to 1486."

Is this a known issue?

Alagu/Erik,

Have you ever observed such an issue?

Thanks
