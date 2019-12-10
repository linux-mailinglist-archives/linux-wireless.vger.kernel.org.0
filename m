Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 897771185CB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 12:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfLJLFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 06:05:13 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:48071 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfLJLFN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 06:05:13 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 66440a0d
        for <linux-wireless@vger.kernel.org>;
        Tue, 10 Dec 2019 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:content-type; s=mail; bh=LZlYW9
        UCw4wqob1o2bmUzj8oWXs=; b=SRXdpZ7fKQz9nZgY2+HioBol4ptwDfZc9LNNKi
        OGH4+gXYgc+nZ3aV0GvzMR//Fld/SoxPStcoVaFGtQWlTnAy9n4u7PrXRu2CbYVq
        svxt2cZnr5W1wN9Pm+QJtSnfuDBMM0YzAfL+6K1ZwwrTUFNrcbD+4p0RH5Hpyhwy
        TdZ8Midk5roFtdEBQXqdAME4X08gPUhbgbln9yN0j/bwddVvt8LMLwBtGe+zFYKA
        2HQd1Fhyf8l03JiyXvWPJpCNCpDaz/E5tU8RYDfkjoFF3snfyorxLn1X7row7XcM
        YMJCREUn7EG6sh8EmkjkIrA9vZW3Rc40L1jQg6ARqipZJKLA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bb0c5752 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-wireless@vger.kernel.org>;
        Tue, 10 Dec 2019 10:09:40 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id h20so15141390otn.5
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2019 03:05:11 -0800 (PST)
X-Gm-Message-State: APjAAAVd7oQs9Rq/aGimvUfmg8Nq/xeZnEyqx4Xwspxy1q8C5hNBu9QT
        NT9qcskqzbLtyV9U53WGKIGaSYCfYgesKP/Tjvw=
X-Google-Smtp-Source: APXvYqzngD3FtT8ET4ICbicclgjfLTQlPnozqTq3MsLgdm6CSFh9mZl2L4CLtYGbTghNKwMIero1Zl26lKSAAq8tGnc=
X-Received: by 2002:a9d:1e88:: with SMTP id n8mr26382946otn.369.1575975911101;
 Tue, 10 Dec 2019 03:05:11 -0800 (PST)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 10 Dec 2019 12:05:00 +0100
X-Gmail-Original-Message-ID: <CAHmME9oykQsOXVeKdhToFjaHfPV6Ms6C450FYjUGh4nrOFBbtw@mail.gmail.com>
Message-ID: <CAHmME9oykQsOXVeKdhToFjaHfPV6Ms6C450FYjUGh4nrOFBbtw@mail.gmail.com>
Subject: intel ax200 not properly reinitialized on reboot
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have a Thinkpad P1 gen 2 (same as X1 extreme gen 2), which has an
AX200 -- 52:00.0 0280: 8086:2723 (rev 1a). Things mostly work, but
I've noticed that after a reboot, the card stops working.
Specifically, wpa_supplicant can't talk to it anymore. Or, sometimes
it appears to drop off the bus completely. After doing a full
poweroff+poweron (not a reboot), it works again.

Here's what one of the failure modes looks like:

zx2c4@thinkpad ~ $ journalctl -b -1|egrep '(iwl|wpa)'
Dec 10 11:57:55 thinkpad systemd[1]: Created slice system-wpa_supplicant.slice.
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: enabling device
(0000 -> 0002)
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: Direct firmware
load for iwlwifi-cc-a0-52.ucode failed with error -2
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: Direct firmware
load for iwlwifi-cc-a0-51.ucode failed with error -2
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: Direct firmware
load for iwlwifi-cc-a0-50.ucode failed with error -2
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: Direct firmware
load for iwlwifi-cc-a0-49.ucode failed with error -2
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0:
TLV_FW_FSEQ_VERSION: FSEQ Version: 43.2.23.17
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: Found debug
destination: EXTERNAL_DRAM
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: Found debug
configuration: 0
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: loaded firmware
version 48.4fa0041f.0 op_mode iwlmvm
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: Detected
Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: Applying debug
destination EXTERNAL_DRAM
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: Allocated
0x00400000 bytes for firmware monitor.
Dec 10 11:57:55 thinkpad kernel: iwlwifi 0000:52:00.0: base HW
address: sanitized
Dec 10 11:57:56 thinkpad wpa_supplicant[747]: Successfully initialized
wpa_supplicant
Dec 10 11:57:56 thinkpad wpa_supplicant[747]: Could not set interface
wlan0 flags (UP): Connection timed out
Dec 10 11:57:56 thinkpad wpa_supplicant[747]: nl80211: Could not set
interface 'wlan0' UP
Dec 10 11:57:56 thinkpad wpa_supplicant[747]: nl80211: deinit
ifname=wlan0 disabled_11b_rates=0
Dec 10 11:57:56 thinkpad wpa_supplicant[747]: wlan0: Failed to
initialize driver interface
Dec 10 11:57:56 thinkpad systemd[1]: wpa_supplicant@wlan0.service:
Main process exited, code=exited, status=255/EXCEPTION
Dec 10 11:57:56 thinkpad systemd[1]: wpa_supplicant@wlan0.service:
Failed with result 'exit-code'.
Dec 10 11:58:10 thinkpad systemd[1]: Removed slice system-wpa_supplicant.slice.

I assume this is something to do with the bios not powercycling the
pcie bus during reboot, leaving the card in some kind of inconsistent
state. Perhaps it's possible to add a quirk to always powercycle it
before initializing and loading firmware?

Thanks,
Jason
