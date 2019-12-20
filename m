Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B75127BE5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 14:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLTNn7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 08:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfLTNn7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 08:43:59 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D71222C2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2019 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576849438;
        bh=Heiha3rk9Q9P3GAb7WBQF3z3L5q70uwYxvI3PwrCev0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=szl5bryIHN3/3W+NktsPpXHLSRzt88UIZ3oDuAtSnjeDvuI4ieZdzFIjinVO3fhcp
         lNlV0yuLNx3/a5jwo75Pkmnn+ClSdTX8ocm3khge5mXdSDaqy+jRfOkrM6ESncrslX
         EcL7FQfCSBY6H8LnAl0OdIpuV1K+TodzcGbhkA6c=
Received: by mail-qv1-f41.google.com with SMTP id u10so3547841qvi.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2019 05:43:58 -0800 (PST)
X-Gm-Message-State: APjAAAVUJ4HmdYnC2KzWXP0zVOSkBOosqhvpnr/lPg6CVT65PJh5ALnX
        3gjpKfkFXFPUdp2TbwGBxU60BunlEFtPUDAYCJ0=
X-Google-Smtp-Source: APXvYqzhuWUkfqdiIb4VOUkqIdnEFK0hyIk9mNE+MzAw4x8GS1lQAjRMpQLFx/Dgkt40Xs6TKaAW+QpQGtbS+9N17fc=
X-Received: by 2002:ad4:4f94:: with SMTP id em20mr11934314qvb.95.1576849437283;
 Fri, 20 Dec 2019 05:43:57 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB6006CC2E199B34B8EF53D30D922D0@BYAPR02MB6006.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB6006CC2E199B34B8EF53D30D922D0@BYAPR02MB6006.namprd02.prod.outlook.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 20 Dec 2019 08:43:46 -0500
X-Gmail-Original-Message-ID: <CA+5PVA5F13c2c8tjKAFk+v=ZvfSwiV5iCZMAQOsB8FrLnS28uw@mail.gmail.com>
Message-ID: <CA+5PVA5F13c2c8tjKAFk+v=ZvfSwiV5iCZMAQOsB8FrLnS28uw@mail.gmail.com>
Subject: Re: [PULL] ath10k firmware 20191220
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Dec 20, 2019 at 4:33 AM Kalle Valo <kvalo@qca.qualcomm.com> wrote:
>
> Hi,
>
> ath10k firmware updates and also new hardware WCN3990. Please let me know if there are any problems.
>
> Kalle
>
> The following changes since commit c4586ffaac0ca0d7045e06140b6426f2e79e96e6:
>
>   linux-firmware: Update AMD cpu microcode (2019-12-18 09:37:15 -0500)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git ath10k-20191220
>
> for you to fetch changes up to b142c2e0229bc89b44ac527f4f3c3def063bcbc6:
>
>   ath10k: WCN3990 hw1.0: add firmware WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1 (2019-12-20 11:18:46 +0200)
>
> ----------------------------------------------------------------
> Kalle Valo (6):
>       ath10k: QCA6174 hw3.0: update board-2.bin
>       ath10k: QCA9887 hw1.0: update firmware-5.bin to 10.2.4-1.0-00047
>       ath10k: QCA9888 hw2.0: update firmware-5.bin to 10.4-3.9.0.2-00070
>       ath10k: QCA988X hw2.0: update firmware-5.bin to 10.2.4-1.0-00047
>       ath10k: QCA9984 hw1.0: update firmware-5.bin to 10.4-3.9.0.2-00070
>       ath10k: WCN3990 hw1.0: add firmware WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1
>
>  WHENCE                                   |  12 +-
>  ath10k/QCA6174/hw3.0/board-2.bin         | Bin 567608 -> 584036 bytes
>  ath10k/QCA9887/hw1.0/firmware-5.bin      | Bin 238484 -> 238548 bytes
>  ath10k/QCA9888/hw2.0/firmware-5.bin      | Bin 686996 -> 688140 bytes
>  ath10k/QCA988X/hw2.0/firmware-5.bin      | Bin 248984 -> 249044 bytes
>  ath10k/QCA9984/hw1.0/firmware-5.bin      | Bin 674940 -> 675948 bytes
>  ath10k/WCN3990/hw1.0/firmware-5.bin      | Bin 0 -> 60 bytes
>  ath10k/WCN3990/hw1.0/notice.txt_wlanmdsp | 571 +++++++++++++++++++++++++++++++
>  ath10k/WCN3990/hw1.0/wlanmdsp.mbn        | Bin 0 -> 3725044 bytes
>  9 files changed, 579 insertions(+), 4 deletions(-)
>  create mode 100644 ath10k/WCN3990/hw1.0/firmware-5.bin
>  create mode 100644 ath10k/WCN3990/hw1.0/notice.txt_wlanmdsp
>  create mode 100644 ath10k/WCN3990/hw1.0/wlanmdsp.mbn

Pulled and pushed out.  Thanks.

josh
