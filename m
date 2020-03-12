Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED453182CF6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 11:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgCLKD2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 06:03:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42907 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLKD2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 06:03:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id q19so5660223ljp.9
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2020 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=archlinux-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=0kkpMn2zPJIA5BfWRCvbPM9T2WbIzv5JXK6mhm1cg0w=;
        b=Wxhhi9UxMGdd0B1KGqDZrtW609WYIxXlW2wL9DXxy7iNa2M2FtZQUCIOAlI18mejcj
         OeF3gId0zuCqq9tSJFC3cQ9A25ATMqe+So1SdtjRBiuVuSYhBh/eR/XMHxReDwV6+T/0
         NHRFByIc816+qbz+JjzFgKwhVGpdNupdxyQdmf9apc59D4QrsjVdIUrCMbeTUO2HvafJ
         kHHLYabUaBLHmR364wGkUXR3sLvBd/E0FlEH5NmNTo5pCLjslKfIbISElqPPg015DmXk
         Zf4prhRdc/UCoTzVEJBfItVZDrWEqvaBx3L6IKjvhUQ2IZD0QLmhZEwq+R052bjJk1yl
         oNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0kkpMn2zPJIA5BfWRCvbPM9T2WbIzv5JXK6mhm1cg0w=;
        b=FHB9N6s8dhmoprMVr29nd3DzNuDP7W67OSBCfiiVWwVr8zuA74zI3C2atHkJUVAjJL
         DtCFPriYlt7f38JPQim0GJOWdnfNtAXVr/PQGsMfM/E3e58zBqxM18uuynbC72W+mUwi
         ZQtcEeBknt19tHpyEN/9ru6qXY98wDGVHwYM47p95qfGu0vY7JCgD9rJ+KfTETC/Pbns
         Xk2LdRK3CrCAMW0HIdIUqKsU1/inI9euzeEQwnTegeT1BcAyVSz7dbTT09ieIhGsxhGC
         y+YOs8V6nOdw8AaiEyQvbsvDxC3Zn9ywzPTdKFK+k2Yml4wg1SCbIHv3qZ0vD4e3uTHm
         LXmg==
X-Gm-Message-State: ANhLgQ0Nfz1+Tpk+3Zfm1XVKDhWVRrx/k+1jeYACsJpsJFDNiKzMFosy
        dBNLJHwTb/P+5OzG0BRWNFLpmzeMCVAfL3jHGJBsLs+WPUc=
X-Google-Smtp-Source: ADFU+vvF82d4Gbp1sSvG3k2k+bMlzWgmRMmYZRegdDaR4BM0nDoxZsnTs1iMeMuWB8XYDbfUDApI4/Vf06UtQ10rv7c=
X-Received: by 2002:a05:651c:313:: with SMTP id a19mr4614914ljp.173.1584007406020;
 Thu, 12 Mar 2020 03:03:26 -0700 (PDT)
MIME-Version: 1.0
From:   JM <fijam@archlinux.us>
Date:   Thu, 12 Mar 2020 11:03:15 +0100
Message-ID: <CAKzmTe0_fbse0Owau3rnLSfPWOeFbqC=eT5+p1FuaBXJDZYrUQ@mail.gmail.com>
Subject: no 5GHz band with mwifiex (w8897)
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am struggling trying to get 802.11ac working on Marvell (now NXP)
W8897 (verext = w8897o-B0, RF87XX, FP68, 15.68.19.p17) using the
mwifiex driver. This is supposed to be a 2x2 dual band 801.11ac chip.

This is an ARMv7 embedded device where the wifi module in accessed via
MMC. I am using kernel 5.4.24 with 15.68.19.p17 firmware and iw
version 5.4.

#uname -a
Linux 5.4.24 #3 PREEMPT Mon Mar 9 19:59:02 CET 2020 armv7l GNU/Linux

 #dmesg | grep -i mmc
[    1.060141] mmc0: SDHCI controller on f7ab0000.sdhci
[f7ab0000.sdhci] using ADMA
[    1.189514] mmc0: new ultra high speed SDR104 SDIO card at address 0001
[  300.280194] mwifiex_sdio mmc0:0001:1: info: FW download over, size
701072 bytes
[  301.000230] mwifiex_sdio mmc0:0001:1: WLAN FW is active
[  301.062787] mwifiex_sdio mmc0:0001:1: Unknown api_id: 4
[  301.117673] mwifiex_sdio mmc0:0001:1: info: MWIFIEX VERSION:
mwifiex 1.0 (15.68.19.p17)

The regulatory domain is set to US and the kernel module is loaded
with the reg_alpha2=US hint.

#iw reg get
global
country US: DFS-FCC
        (2402 - 2472 @ 40), (N/A, 30), (N/A)
        (5170 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
        (5250 - 5330 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
        (5490 - 5730 @ 160), (N/A, 23), (0 ms), DFS
        (5735 - 5835 @ 80), (N/A, 30), (N/A)
        (57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#0
country US: DFS-FCC
        (2402 - 2472 @ 40), (N/A, 30), (N/A)
        (5170 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
        (5250 - 5330 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
        (5490 - 5730 @ 160), (N/A, 23), (0 ms), DFS
        (5735 - 5835 @ 80), (N/A, 30), (N/A)
        (57240 - 71000 @ 2160), (N/A, 40), (N/A)

Despite that, iw list only detects the 2.4GHz band https://pastebin.com/5jEQmTTt

Is this configuration not supported? I feel like I am missing something obvious.

Any help appreciated, I've been banging my head against it for a while.

Best regards,
Jan
