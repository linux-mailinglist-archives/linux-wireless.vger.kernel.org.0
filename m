Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF41114D822
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 10:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgA3JJ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 04:09:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgA3JJ7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 04:09:59 -0500
Received: from zn.tnic (p200300EC2F0A2D008CF13F1DEF2E182C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2d00:8cf1:3f1d:ef2e:182c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21DDC1EC0C70;
        Thu, 30 Jan 2020 10:09:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580375397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=QKQE5DSa58aSSJAZB3wMuif9DDCF4t9YREICstF9JgM=;
        b=AxAZNGZn9/xpPj5QjHLtTA8/VO6s7uwB6PdDuT37KNtGF7uX5MqrRxJ104SYbtHgVuD9Hd
        4lqmIcI+KuecV1xUwmqs6wPvhdQCXUXFux+D2FLH2GQabmmpc4p0MOQAoi0SbLKINO1Xb7
        jujHz4rLXq9F+cVY2g9Wr0PeL+2k4nI=
Date:   Thu, 30 Jan 2020 10:09:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Cc:     gartim@gmail.com
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 206317] New: PM: suspend
 entry (deep) / firmware crashed! (guid
 38de80c3-b50e-4518-ac15-5849f120b55c)]
Message-ID: <20200130090951.GB6656@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Forwarding...

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Sun, 26 Jan 2020 18:53:58 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bp@alien8.de
Subject: [Bug 206317] New: PM: suspend entry (deep) / firmware crashed! (guid 38de80c3-b50e-4518-ac15-5849f120b55c)
Message-ID: <bug-206317-6385@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=206317

            Bug ID: 206317
           Summary: PM: suspend entry (deep) / firmware crashed! (guid
                    38de80c3-b50e-4518-ac15-5849f120b55c)
           Product: Platform Specific/Hardware
           Version: 2.5
    Kernel Version: Linux linux-e0yv 5.4.14-1.gfc4ea7a-default
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: x86-64
          Assignee: platform_x86_64@kernel-bugs.osdl.org
          Reporter: gartim@gmail.com
        Regression: No

This problem is recovered from, thus the low priority, but thought it should be
reported. Let me know if you want more info?



[ 2079.513046] ath10k_pci 0000:01:00.0: failed to install key for vdev 0 peer
f8:1a:67:32:ee:14: -110
[ 2079.513050] wlan0: failed to remove key (0, f8:1a:67:32:ee:14) from hardware
(-110)
[ 2079.517803] ath10k_pci 0000:01:00.0: firmware crashed! (guid
38de80c3-b50e-4518-ac15-5849f120b55c)
[ 2079.517809] ath10k_pci 0000:01:00.0: qca6174 hw2.1 target 0x05010000 chip_id
0x003405ff sub 144d:4125
[ 2079.517812] ath10k_pci 0000:01:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs
0 testmode 0
[ 2079.518344] ath10k_pci 0000:01:00.0: firmware ver
SW_RM.1.1.1-00157-QCARMSWPZ-1 api 5 features ignore-otp,no-4addr-pad crc32
10bf8e08
[ 2079.518615] ath10k_pci 0000:01:00.0: board_file api 2 bmi_id N/A crc32
ae2e275a
[ 2079.518620] ath10k_pci 0000:01:00.0: htt-ver 3.1 wmi-op 4 htt-op 3 cal otp
max-sta 32 raw 0 hwcrypto 1
[ 2079.518954] ath10k_pci 0000:01:00.0: firmware register dump:
[ 2079.518960] ath10k_pci 0000:01:00.0: [00]: 0x05010000 0x00000000 0x0092E4DC
0x62029963
[ 2079.518963] ath10k_pci 0000:01:00.0: [04]: 0x0092E4DC 0x00060130 0x00000018
0x0041A760
[ 2079.518966] ath10k_pci 0000:01:00.0: [08]: 0x6202994F 0x00400000 0x00000000
0x000A5C88
[ 2079.518969] ath10k_pci 0000:01:00.0: [12]: 0x00000009 0x00000000 0x0096C09C
0x0096C0A7
[ 2079.518971] ath10k_pci 0000:01:00.0: [16]: 0x0096BDBC 0x009287BD 0x00000000
0x009287BD
[ 2079.518974] ath10k_pci 0000:01:00.0: [20]: 0x4092E4DC 0x0041A710 0x00000000
0x0F000000
[ 2079.518976] ath10k_pci 0000:01:00.0: [24]: 0x809432A7 0x0041A770 0x0040D400
0xC092E4DC
[ 2079.518979] ath10k_pci 0000:01:00.0: [28]: 0x80942BC4 0x0041A790 0x6202994F
0x00400000
[ 2079.518982] ath10k_pci 0000:01:00.0: [32]: 0x80947BA7 0x0041A7B0 0x004050A8
0x0040E074
[ 2079.518984] ath10k_pci 0000:01:00.0: [36]: 0x809BDECC 0x0041A7D0 0x004050A8
0x0040E074
[ 2079.518987] ath10k_pci 0000:01:00.0: [40]: 0x8099638C 0x0041A7F0 0x004050A8
0x00000000
[ 2079.518990] ath10k_pci 0000:01:00.0: [44]: 0x80992076 0x0041A810 0x0044FD68
0x0046FFE8
[ 2079.518992] ath10k_pci 0000:01:00.0: [48]: 0x80996BD3 0x0041A830 0x0044FD68
0x00000000
[ 2079.518995] ath10k_pci 0000:01:00.0: [52]: 0x800B4405 0x0041A850 0x00422318
0x00005002
[ 2079.518998] ath10k_pci 0000:01:00.0: [56]: 0x809A6C34 0x0041A8E0 0x0042932C
0x0042CA20
[ 2079.519000] ath10k_pci 0000:01:00.0: Copy Engine register dump:
[ 2079.519010] ath10k_pci 0000:01:00.0: [00]: 0x00034400   1   1   3   3
[ 2079.519019] ath10k_pci 0000:01:00.0: [01]: 0x00034800  21  21 504 505
[ 2079.519028] ath10k_pci 0000:01:00.0: [02]: 0x00034c00   9   9  72  73
[ 2079.519037] ath10k_pci 0000:01:00.0: [03]: 0x00035000  14  14  15  14
[ 2079.519046] ath10k_pci 0000:01:00.0: [04]: 0x00035400 1819 1819 207 143
[ 2079.519055] ath10k_pci 0000:01:00.0: [05]: 0x00035800   0   0   0   0
[ 2079.519065] ath10k_pci 0000:01:00.0: [06]: 0x00035c00  10  10  10  10
[ 2079.519074] ath10k_pci 0000:01:00.0: [07]: 0x00036000   1   1   1   1
[ 2079.519128] ath10k_pci 0000:01:00.0: failed to create WMI vdev 0: -108
[ 2079.598309] ieee80211 phy0: Hardware restart was requested
[ 2080.888522] ath10k_pci 0000:01:00.0: unsupported HTC service id: 1536
[ 2080.916517] ath10k_pci 0000:01:00.0: device successfully recovered
[ 2081.306142] PM: suspend entry (deep)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
