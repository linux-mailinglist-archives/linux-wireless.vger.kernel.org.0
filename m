Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542BCBF6C6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfIZQcf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 12:32:35 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46844 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfIZQcf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 12:32:35 -0400
Received: by mail-lj1-f179.google.com with SMTP id d1so1795468ljl.13
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2019 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exuvo-se.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=OSvR5dO8OalNTsIwOKd4HunwNDSt9hr5TxW9OQ6ta4Q=;
        b=ovMO+opFzUY8AYZBJJlakRnPBrSRgGvNfL5fYv/kA8dA3do7A0RNBAxMBTw7ZQ5m8m
         tO3LmSf+q84TEoSKiYuo1HQkh+EP66uUL+oyLWnnXSQ4J3DZz2ryXzkD/dqqkRTV/6r0
         zY9Vz5g0MX0dN6py/830ZtG1j7OMA3QSRThuwH5YdlqNkuAyebXkygh4KpyR6EXbfUIU
         /DlEv4mSwiXvxOROn7DJo39OmCdWBFoLGTqqFqwgmXWW6bXwdTltW18n4uG3eW07lm5y
         0MR2wFuqtV0POLg5bZ7k6j4tiKLHCLX/Ixl5EHyY1Av14EQe1WYNSPXeDFxNVbUcr6hT
         uYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=OSvR5dO8OalNTsIwOKd4HunwNDSt9hr5TxW9OQ6ta4Q=;
        b=OgOGdVSxi86UVaFXmOfacs8BIAaA7Y29Vd+GIAZPEx9E1WzS7F5g+AB1C8EHBt97i+
         df6ZU3jUNqkItMeRgpDqq9q4Iie30HhoQoZbHJJjU3wla599EKbyLaBp72Xs/ubW25l6
         kFMdfHSeZlDrpQWTOqzWYF4b5wX3qrpwQgflSNhwjOIAn5BoV7qJbg6hJJG+kW6+CoZT
         b/raNQw7x7Je+8YhKRByqX6wkVHNuvwO4RdthB+admgAeX6EKj5PMYQ9iOtwjYiXaNjw
         kf5bVmNBA3KyWSxvxpCjQEp5728TH/2G1kN2Nsif+siEMXJcqOZIzH4Kgt+/hKhVAS7L
         +dow==
X-Gm-Message-State: APjAAAXUmIDTRjZtkIMFMI45PqanXArmny8HwPVk7RRRPqVy5SWeywfd
        W7uBrJSDHuxZOxGQNKmw/dT2hA==
X-Google-Smtp-Source: APXvYqzsbLFZOCgBGZ1xRVBJEF0SJlyHlyP0fT0x7nJ1ScHsj/3GvOj9yqGo25+3YzLe7PfJDB692A==
X-Received: by 2002:a2e:9702:: with SMTP id r2mr3269054lji.190.1569515552727;
        Thu, 26 Sep 2019 09:32:32 -0700 (PDT)
Received: from [192.168.1.30] (c-22a0205c.06-131-73766c1.bbcust.telenor.se. [92.32.160.34])
        by smtp.gmail.com with ESMTPSA id c16sm623826lfj.8.2019.09.26.09.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 09:32:31 -0700 (PDT)
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        Helmut Schaa <helmut.schaa@googlemail.com>
From:   Anton Olsson <exuvo@exuvo.se>
Subject: rt2x00 regression
Message-ID: <bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se>
Date:   Thu, 26 Sep 2019 18:32:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello I have a USB based ID 148f:3070 Ralink Technology, Corp. RT2870/RT3070 Wireless Adapter, that stops working with recent kernels. It works on kernel 5.1.15 and does not work with 5.2.7 or 5.3.1 (I have not tested other versions). I use it in AP mode.

I found this similar bug report https://marc.info/?l=linux-wireless&m=156630037103575&w=2 but that did not have related error messages so I assume this is different?

Logs of working kernel 5.1.15-arch1-1-ARCH.
[   78.680555] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070, rev 0201 detected
[   78.690992] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
[   78.799625] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
sep 26 17:13:03 kernel: usbcore: registered new interface driver rt2800usb
sep 26 17:13:03 systemd[1]: Found device RT2870/RT3070 Wireless Adapter.
[  113.812454] ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading firmware file 'rt2870.bin'
[  113.905279] ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware detected - version: 0.36
[  114.028703] ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor Request 0x06 failed for offset 0x0404 with error -71

The last error there does not seem to affect the operation of the device.

Logs of not working with kernel 5.3.1, 5.2.7 has similar output.
sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070, rev 0201 detected
sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
sep 26 17:06:12 kernel: ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
sep 26 17:06:12 kernel: usbcore: registered new interface driver rt2800usb
sep 26 17:06:12 systemd[1]: Found device RT2870/RT3070 Wireless Adapter.
sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading firmware file 'rt2870.bin'
sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware detected - version: 0.36
sep 26 17:06:21 ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor Request 0x06 failed for offset 0x0404 with>
sep 26 17:06:22 ieee80211 phy0: rt2800_wait_csr_ready: Error - Unstable hardware
sep 26 17:06:22 ieee80211 phy0: rt2800usb_set_device_state: Error - Device failed to enter state 4 (-5)

Unable to bring up the network interface here.

Tell me if you want me to run any commands or test any patches.

