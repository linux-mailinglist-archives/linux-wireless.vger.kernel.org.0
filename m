Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5CE8EA45
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2019 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfHOLaR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Aug 2019 07:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfHOLaR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Aug 2019 07:30:17 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D164F2084D
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2019 11:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565868616;
        bh=rmJikXWf8Yvyy/IGFErgj7eYCo7HyQbskzop7BR0pbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WqBfzQIIN9Md0wjusYn54EDLB/BeehhvpodZ+tBdBYLeQHhxJYfXmKE4VfAgIyAZC
         Sv1Yiuuiu1ZGX0Qe3aJFwsIOF2yZkfMZdPSKCv3qSKsFIxJqkxnSPHVzcslFs5zxk/
         sMZJHwAAGd08zt3ZR3fm0osRvjHMjwCfVZnM319E=
Received: by mail-qk1-f179.google.com with SMTP id d23so1582931qko.3
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2019 04:30:15 -0700 (PDT)
X-Gm-Message-State: APjAAAWpfN49Ity4yL8tX3Rkl3Cnia7yl7+llHFCjZhBYGPSRnFrYmBH
        DcwGurN7q+IXX4rkyqeUd7soXCtowOnvtOHYMg0=
X-Google-Smtp-Source: APXvYqzJ5+AXyiemOVDVKbNDs24sH0OwNkxtnQJ1h6q4Yrr6cFadh0yjPGdvGBRJ5LK2eP5Fdd1zvvyAvtO+Rqc6bhc=
X-Received: by 2002:a37:4f41:: with SMTP id d62mr3405580qkb.302.1565868615053;
 Thu, 15 Aug 2019 04:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR02MB6006478A57983F5B4067F54392D70@BYAPR02MB6006.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB6006478A57983F5B4067F54392D70@BYAPR02MB6006.namprd02.prod.outlook.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Thu, 15 Aug 2019 07:30:04 -0400
X-Gmail-Original-Message-ID: <CA+5PVA47DT2vcSW2c=QBT-=ZZ9muwh5_GOehoZKo3avCerPmbA@mail.gmail.com>
Message-ID: <CA+5PVA47DT2vcSW2c=QBT-=ZZ9muwh5_GOehoZKo3avCerPmbA@mail.gmail.com>
Subject: Re: [PULL] ath10k firmware 20190808
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 8, 2019 at 5:56 AM Kalle Valo <kvalo@qca.qualcomm.com> wrote:
>
> Hi linux-firmware maintainers,
>
> here's a pull request to update some ath10k firmware images. Please let me know if there are any problems.
>
> Kalle
>
> The following changes since commit dff98c6c57383fe343407bcb7b6e775e0b87274f:
>
>   Merge branch 'master' of git://github.com/skeggsb/linux-firmware (2019-07-26 07:32:37 -0400)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git ath10k-20190808
>
> for you to fetch changes up to 1f0a99f6b07e24449411ccf208836b6769a5a2a4:
>
>   ath10k: QCA9984 hw1.0: update board-2.bin (2019-08-08 12:39:06 +0300)
>
> ----------------------------------------------------------------
> Kalle Valo (8):
>       ath10k: QCA4019 hw1.0: update board-2.bin
>       ath10k: QCA6174 hw3.0: update firmware-6.bin to WLAN.RM.4.4.1-00140-QCARMSWPZ-1
>       ath10k: QCA9887 hw1.0: update firmware-5.bin to 10.2.4-1.0-00045
>       ath10k: QCA9888 hw2.0: update firmware-5.bin to 10.4-3.9.0.2-00040
>       ath10k: QCA9888 hw2.0: update board-2.bin
>       ath10k: QCA988X hw2.0: update firmware-5.bin to 10.2.4-1.0-00045
>       ath10k: QCA9984 hw1.0: update firmware-5.bin to 10.4-3.9.0.2-00046
>       ath10k: QCA9984 hw1.0: update board-2.bin
>
>  WHENCE                              |  10 +++++-----
>  ath10k/QCA4019/hw1.0/board-2.bin    | Bin 449316 -> 607304 bytes
>  ath10k/QCA6174/hw3.0/firmware-6.bin | Bin 731276 -> 700988 bytes
>  ath10k/QCA9887/hw1.0/firmware-5.bin | Bin 237660 -> 238484 bytes
>  ath10k/QCA9888/hw2.0/board-2.bin    | Bin 84928 -> 84928 bytes
>  ath10k/QCA9888/hw2.0/firmware-5.bin | Bin 688536 -> 686996 bytes
>  ath10k/QCA988X/hw2.0/firmware-5.bin | Bin 248840 -> 248984 bytes
>  ath10k/QCA9984/hw1.0/board-2.bin    | Bin 171916 -> 171916 bytes
>  ath10k/QCA9984/hw1.0/firmware-5.bin | Bin 676316 -> 674940 bytes
>  9 files changed, 5 insertions(+), 5 deletions(-)

Pulled and pushed out.  Thanks.

josh
