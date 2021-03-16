Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46033D338
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 12:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhCPLjL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Mar 2021 07:39:11 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:38616 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237381AbhCPLiy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Mar 2021 07:38:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id DFCAC205B5;
        Tue, 16 Mar 2021 12:38:50 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c4XMXJzbRnmy; Tue, 16 Mar 2021 12:38:44 +0100 (CET)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id EED162059C;
        Tue, 16 Mar 2021 12:38:44 +0100 (CET)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 12:38:44 +0100
Received: from [172.18.16.185] (172.18.16.185) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 16 Mar
 2021 12:38:44 +0100
To:     <luciano.coelho@intel.com>
CC:     <linux-wireless@vger.kernel.org>
From:   Torsten Hilbrich <torsten.hilbrich@secunet.com>
Autocrypt: addr=torsten.hilbrich@secunet.com; prefer-encrypt=mutual; keydata=
 mQENBFs5uIIBCAD4qbEieyT7sBmcro1VrCE1sSnV29a9ub8c0Xj0yw0Cz2N7LalBn4a+YeJN
 OMfL1MQvEiTxZNIzb1I0bRYcfhkhjN4+vAoPJ3q1OpSY+WUgphUbzseUk/Bq3gwvfa6/U+Hm
 o2lvEfN2dewBGptQ+DrWz+SPM1TQiwShKjowY/avaVgrABBGen3LgB0XZXEH8Q720kjP7htK
 tCGRt1T+qNIj3tZDZfPkqEVb8lTRcyn1hI3/FbDTysletRrCmkHSVbnxNzO6lw2G1H61wQhw
 YVbIVNohY61ieSJFhNLL6/UTGHtUE2IAicnsUAUKR8GiI1+3cTf233O5HaWYeOjBmTCLABEB
 AAG0L1RvcnN0ZW4gSGlsYnJpY2ggPHRvcnN0ZW4uaGlsYnJpY2hAc2VjdW5ldC5jb20+iQE3
 BBMBCAAhBQJbObiCAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEJ7rXZh78/h8+tIH
 +QFYRQH4qh3WagcmjbG/zCe2RmZZePO8bmut2fAxY04aqJZGYUBxb5lfaWaHkstqM5sFD8Jo
 k1j5E7f1cnfwB21azdUO8fzYL889kdVOzatdT/uTjR7OjR59gpJMd4lx7fwFuZUg8z6rfWJ3
 ImjxxBgaJRL6pqaZ9lOst82O0qJKEFBR+HDUVvgh4n8TTOfKNv/dGPQhaed+2or98asdYRWo
 S/zc4ltTh4SxZjLd98pDxjlUyOJoMJeWdlMmLgWV3h1qjy4DxgQzvgATEaKjOuwtkCOcwHn7
 Unf0F2V9p4O7NFOuoVyqTBRX+5xKgzSM7VP1RlTT4FA9/7wkhhG+FEK5AQ0EWzm4ggEIAL9F
 IIPQYMx5x+zMjm8lDsmh12zoqCtMfn9QWrERd2gDS3GsORbe/i6DhYvzsulH8vsviPle4ocU
 +PaTwadfnEqm0FS7xCONYookDGfAiPS4cHWX7WrTNBP7mK3Gl1KaAOJJsMbCVAA9q4d8WL+A
 e+XrfOAetZq5gxLxDMYySNI1pIMJVrGECiboLa/LPPh2yw4jieAedW96CPuZs7rUY/5uIVt0
 Dn4/aSzV+Ixr52Z2McvNmH/VxDt59Z6jBztZIJBXpX3BC/UyH7rJOJTaqEF+EVWEpOmSoZ6u
 i1DWyqOBKnQrbUa0fpNd3aaOl2KnlgTH9upm70XZGpeJik/pQGcAEQEAAYkBHwQYAQgACQUC
 Wzm4ggIbDAAKCRCe612Ye/P4fEzqB/9gcM/bODO8o9YR86BLp0S8bF73lwIJyDHg5brjqAnz
 CtCdb4I+evI4iyU9zuN1x4V+Te5ej+mUu5CbIte8gQbo4cc9sbe/AEDoOh0lGoXKZiwtHqoh
 RZ4jOFrZJsEjOSUCLE8E8VR1afPf0SkFXLXWZfZDU28K80JWeV1BCtxutZ39bz6ybMbcCvMS
 UfwCTY0IJOiDga1K4H2HzHAqlvfzCurqe616S4S1ax+erg3KTEXylxmzcFjJU8AUZURy/lQt
 VElzs4Km1p3v6GUciCAb+Uhd12sQG2mL05jmEems9uRe3Wfke/RKp8A+Yq+p6E0A0ZOP+Okm
 LXB2q+ckPvZG
Subject: [iwlwifi] v5.12-rc1: Unable to move phy0 to other network namespace
Message-ID: <28fee372-0dc6-6351-2b1d-c79e924952a5@secunet.com>
Date:   Tue, 16 Mar 2021 12:38:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------153C8659B46D87393B8A6C29"
Content-Language: en-US
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--------------153C8659B46D87393B8A6C29
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

starting with kernel v5.12-rc1 (and still not working in v5.12-rc3) I'm no longer able to move a wlan interface into another namespace.

I have created a new network namespace, like in the following example:

# ip netns add black

Then I move the phy0 interface to that network namespace. I then expect the wlan0 interface to be removed from the initial network namespace and then to appear in the new one.

# iw phy phy0 set netns name black

However, starting with v5.12-rc1 (last known to be working with v5.11) the command never finishes execution. Instead, I get a number of rntl warnings and a soft hangup.

Kernel log is attached.

Here some relevant excerpts:

2021-03-16 11:26:49.124 kernel: iwlwifi 0000:3a:00.0: Detected Intel(R) Dual Band Wireless AC 8265, REV=0x230

2021-03-16 11:27:14.269 kernel: WARNING: CPU: 0 PID: 467 at net/core/dev.c:10988 dev_change_net_namespace+0x44d/0x480
2021-03-16 11:27:14.269 kernel: WARNING: CPU: 0 PID: 467 at net/core/dev.c:381 unlist_netdevice+0xdb/0xf0
2021-03-16 11:27:14.275 kernel: WARNING: CPU: 0 PID: 467 at net/core/dev.c:2054 call_netdevice_notifiers_info+0x7c/0x80
2021-03-16 11:27:14.275 kernel: WARNING: CPU: 0 PID: 467 at net/core/fib_rules.c:1227 fib_rules_event+0x18f/0x1a0
2021-03-16 11:27:14.275 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/devinet.c:1526 inetdev_event+0x39f/0x5c0
2021-03-16 11:27:14.276 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/devinet.c:309 inetdev_event+0x4a9/0x5c0
2021-03-16 11:27:14.276 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/igmp.c:1793 ip_mc_destroy_dev+0x67/0x70
2021-03-16 11:27:14.277 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/igmp.c:1721 ip_mc_down+0x84/0x90
2021-03-16 11:27:14.277 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/igmp.c:1664 __ip_mc_dec_group+0x162/0x1a0

2021-03-16 11:27:14.278 kernel: ---[ end trace 6b632a15496dddfa ]---
2021-03-16 11:30:24.753 kernel: INFO: task iw:467 blocked for more than 122 seconds.
2021-03-16 11:30:24.753 kernel:       Tainted: P        W  O      5.12.0-devel+ #1
2021-03-16 11:30:24.753 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
2021-03-16 11:30:24.753 kernel: task:iw              state:D stack:12720 pid:  467 ppid:   457 flags:0x00004000
2021-03-16 11:30:24.753 kernel: Call Trace:
2021-03-16 11:30:24.753 kernel:  __schedule+0x275/0x660
2021-03-16 11:30:24.753 kernel:  schedule+0x3c/0xa0
2021-03-16 11:30:24.753 kernel:  schedule_preempt_disabled+0xa/0x10
2021-03-16 11:30:24.753 kernel:  __mutex_lock.isra.12+0x2c7/0x4c0
2021-03-16 11:30:24.753 kernel:  ? trace_hardirqs_on+0x2a/0xb0
2021-03-16 11:30:24.753 kernel:  ? skb_dequeue+0x57/0x70
2021-03-16 11:30:24.753 kernel:  cfg80211_netdev_notifier_call+0x23d/0x3e0
2021-03-16 11:30:24.753 kernel:  raw_notifier_call_chain+0x41/0x50
2021-03-16 11:30:24.753 kernel:  dev_change_net_namespace+0xe1/0x480
2021-03-16 11:30:24.753 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:30:24.753 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:30:24.753 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:30:24.753 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0x150
2021-03-16 11:30:24.753 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:30:24.753 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:30:24.753 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150/0x150
2021-03-16 11:30:24.753 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:30:24.753 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:30:24.754 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:30:24.754 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:30:24.754 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:30:24.754 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:30:24.754 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:30:24.754 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:30:24.754 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:30:24.754 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:30:24.754 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:30:24.754 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae


With regards,

	Torsten


--------------153C8659B46D87393B8A6C29
Content-Type: text/x-log; charset="UTF-8"; name="dmesg.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dmesg.log"

----- New boot: 9b009808d75c48b69e98cae8acf7fa3f ------
2021-03-16 11:26:49.106 kernel: microcode: microcode updated early to rev=
ision 0xd6, date =3D 2020-04-27
2021-03-16 11:26:49.106 kernel: Linux version 5.12.0-devel+ (thilbrich@ws=
-3) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1)=
 #1 SMP Tue Mar 16 09:39:34 CET 2021
2021-03-16 11:26:49.106 kernel: Command line: BOOT_IMAGE=3D/isolinux/bzIm=
age loglevel=3D1 sina_toram console=3Dtty1 intel_iommu=3Don,igfx_off
2021-03-16 11:26:49.106 kernel: x86/fpu: Supporting XSAVE feature 0x001: =
'x87 floating point registers'
2021-03-16 11:26:49.106 kernel: x86/fpu: Supporting XSAVE feature 0x002: =
'SSE registers'
2021-03-16 11:26:49.106 kernel: x86/fpu: Supporting XSAVE feature 0x004: =
'AVX registers'
2021-03-16 11:26:49.106 kernel: x86/fpu: Supporting XSAVE feature 0x008: =
'MPX bounds registers'
2021-03-16 11:26:49.106 kernel: x86/fpu: Supporting XSAVE feature 0x010: =
'MPX CSR'
2021-03-16 11:26:49.106 kernel: x86/fpu: xstate_offset[2]:  576, xstate_s=
izes[2]:  256
2021-03-16 11:26:49.106 kernel: x86/fpu: xstate_offset[3]:  832, xstate_s=
izes[3]:   64
2021-03-16 11:26:49.106 kernel: x86/fpu: xstate_offset[4]:  896, xstate_s=
izes[4]:   64
2021-03-16 11:26:49.106 kernel: x86/fpu: Enabled xstate features 0x1f, co=
ntext size is 960 bytes, using 'compacted' format.
2021-03-16 11:26:49.106 kernel: BIOS-provided physical RAM map:
2021-03-16 11:26:49.106 kernel: BIOS-e820: [mem 0x0000000000000000-0x0000=
000000057fff] usable
2021-03-16 11:26:49.106 kernel: BIOS-e820: [mem 0x0000000000058000-0x0000=
000000058fff] reserved
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x0000000000059000-0x0000=
00000009cfff] usable
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x000000000009d000-0x0000=
0000000fffff] reserved
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x0000000000100000-0x0000=
000090b6cfff] usable
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x0000000090b6d000-0x0000=
000090b6dfff] ACPI NVS
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x0000000090b6e000-0x0000=
000090b6efff] reserved
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x0000000090b6f000-0x0000=
00009a4abfff] usable
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x000000009a4ac000-0x0000=
00009a573fff] type 20
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x000000009a574000-0x0000=
00009b52bfff] reserved
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x000000009b52c000-0x0000=
00009b54cfff] ACPI NVS
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x000000009b54d000-0x0000=
00009b54dfff] reserved
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x000000009b54e000-0x0000=
00009b599fff] ACPI NVS
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x000000009b59a000-0x0000=
00009b5fefff] ACPI data
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x000000009b5ff000-0x0000=
00009b5fffff] usable
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x000000009b600000-0x0000=
00009f7fffff] reserved
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x00000000f8000000-0x0000=
0000fbffffff] reserved
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x00000000fe010000-0x0000=
0000fe010fff] reserved
2021-03-16 11:26:49.107 kernel: BIOS-e820: [mem 0x0000000100000000-0x0000=
00065f7fffff] usable
2021-03-16 11:26:49.107 kernel: SMT: disabled
2021-03-16 11:26:49.107 kernel: NX (Execute Disable) protection: active
2021-03-16 11:26:49.107 kernel: user-defined physical RAM map:
2021-03-16 11:26:49.107 kernel: user: [mem 0x0000000000000000-0x000000000=
0057fff] usable
2021-03-16 11:26:49.107 kernel: user: [mem 0x0000000000058000-0x000000000=
0058fff] reserved
2021-03-16 11:26:49.107 kernel: user: [mem 0x0000000000059000-0x000000000=
009cfff] usable
2021-03-16 11:26:49.107 kernel: user: [mem 0x000000000009d000-0x000000000=
00fffff] reserved
2021-03-16 11:26:49.107 kernel: user: [mem 0x0000000000100000-0x000000003=
fffffff] usable
2021-03-16 11:26:49.107 kernel: user: [mem 0x0000000040000000-0x000000004=
1ffffff] reserved
2021-03-16 11:26:49.107 kernel: user: [mem 0x0000000042000000-0x000000009=
0b6cfff] usable
2021-03-16 11:26:49.107 kernel: user: [mem 0x0000000090b6d000-0x000000009=
0b6dfff] ACPI NVS
2021-03-16 11:26:49.107 kernel: user: [mem 0x0000000090b6e000-0x000000009=
0b6efff] reserved
2021-03-16 11:26:49.107 kernel: user: [mem 0x0000000090b6f000-0x000000009=
a4abfff] usable
2021-03-16 11:26:49.107 kernel: user: [mem 0x000000009a4ac000-0x000000009=
a573fff] type 20
2021-03-16 11:26:49.107 kernel: user: [mem 0x000000009a574000-0x000000009=
b52bfff] reserved
2021-03-16 11:26:49.107 kernel: user: [mem 0x000000009b52c000-0x000000009=
b54cfff] ACPI NVS
2021-03-16 11:26:49.107 kernel: user: [mem 0x000000009b54d000-0x000000009=
b54dfff] reserved
2021-03-16 11:26:49.107 kernel: user: [mem 0x000000009b54e000-0x000000009=
b599fff] ACPI NVS
2021-03-16 11:26:49.107 kernel: user: [mem 0x000000009b59a000-0x000000009=
b5fefff] ACPI data
2021-03-16 11:26:49.107 kernel: user: [mem 0x000000009b5ff000-0x000000009=
b5fffff] usable
2021-03-16 11:26:49.107 kernel: user: [mem 0x000000009b600000-0x000000009=
f7fffff] reserved
2021-03-16 11:26:49.107 kernel: user: [mem 0x00000000f8000000-0x00000000f=
bffffff] reserved
2021-03-16 11:26:49.107 kernel: user: [mem 0x00000000fe010000-0x00000000f=
e010fff] reserved
2021-03-16 11:26:49.107 kernel: user: [mem 0x0000000100000000-0x000000065=
f7fffff] usable
2021-03-16 11:26:49.107 kernel: efi: EFI v2.50 by Lenovo
2021-03-16 11:26:49.107 kernel: efi: TPMFinalLog=3D0x9b592000 SMBIOS=3D0x=
9a6d8000 SMBIOS 3.0=3D0x9a6d5000 ACPI=3D0x9b5fe000 ACPI 2.0=3D0x9b5fe014 =
ESRT=3D0x9a5a2000 MEMATTR=3D0x953e5298=20
2021-03-16 11:26:49.107 kernel: SMBIOS 3.0.0 present.
2021-03-16 11:26:49.107 kernel: DMI: LENOVO 20HGS0TW00/20HGS0TW00, BIOS N=
1WET46S (1.25s ) 03/30/2018
2021-03-16 11:26:49.107 kernel: tsc: Detected 2900.000 MHz processor
2021-03-16 11:26:49.107 kernel: tsc: Detected 2899.886 MHz TSC
2021-03-16 11:26:49.107 kernel: e820: update [mem 0x00000000-0x00000fff] =
usable =3D=3D> reserved
2021-03-16 11:26:49.107 kernel: e820: remove [mem 0x000a0000-0x000fffff] =
usable
2021-03-16 11:26:49.107 kernel: last_pfn =3D 0x65f800 max_arch_pfn =3D 0x=
400000000
2021-03-16 11:26:49.107 kernel: x86/PAT: Configuration [0-7]: WB  WC  UC-=
 UC  WB  WP  UC- WT =20
2021-03-16 11:26:49.107 kernel: last_pfn =3D 0x9b600 max_arch_pfn =3D 0x4=
00000000
2021-03-16 11:26:49.107 kernel: esrt: Reserving ESRT space from 0x0000000=
09a5a2000 to 0x000000009a5a2088.
2021-03-16 11:26:49.107 kernel: check: Scanning 1 areas for low memory co=
rruption
2021-03-16 11:26:49.107 kernel: Using GB pages for direct mapping
2021-03-16 11:26:49.107 kernel: Secure boot could not be determined
2021-03-16 11:26:49.107 kernel: RAMDISK: [mem 0x327cb000-0x353dcfff]
2021-03-16 11:26:49.107 kernel: ACPI: Early table checksum verification d=
isabled
2021-03-16 11:26:49.107 kernel: ACPI: RSDP 0x000000009B5FE014 000024 (v02=
 LENOVO)
2021-03-16 11:26:49.107 kernel: ACPI: XSDT 0x000000009B5C2188 000104 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: FACP 0x000000009B5F5000 0000F4 (v05=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: DSDT 0x000000009B5D0000 020CF2 (v02=
 LENOVO SKL      00000000 INTL 20160527)
2021-03-16 11:26:49.107 kernel: ACPI: FACS 0x000000009B53C000 000040
2021-03-16 11:26:49.107 kernel: ACPI: SSDT 0x000000009B5FC000 0003CC (v02=
 LENOVO Tpm2Tabl 00001000 INTL 20160527)
2021-03-16 11:26:49.107 kernel: ACPI: TPM2 0x000000009B5FB000 000034 (v03=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: UEFI 0x000000009B553000 000042 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: SSDT 0x000000009B5F7000 003246 (v02=
 LENOVO SaSsdt   00003000 INTL 20160527)
2021-03-16 11:26:49.107 kernel: ACPI: SSDT 0x000000009B5F6000 0005B6 (v02=
 LENOVO PerfTune 00001000 INTL 20160527)
2021-03-16 11:26:49.107 kernel: ACPI: HPET 0x000000009B5F4000 000038 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: APIC 0x000000009B5F3000 0000BC (v03=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: MCFG 0x000000009B5F2000 00003C (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: ECDT 0x000000009B5F1000 000053 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: SSDT 0x000000009B5CE000 0016F3 (v02=
 LENOVO ProjSsdt 00000010 INTL 20160527)
2021-03-16 11:26:49.107 kernel: ACPI: BOOT 0x000000009B5CD000 000028 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: BATB 0x000000009B5CC000 00004A (v02=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: SLIC 0x000000009B5CB000 000176 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: SSDT 0x000000009B5C9000 0017AE (v02=
 LENOVO CpuSsdt  00003000 INTL 20160527)
2021-03-16 11:26:49.107 kernel: ACPI: SSDT 0x000000009B5C8000 00056D (v02=
 LENOVO CtdpB    00001000 INTL 20160527)
2021-03-16 11:26:49.107 kernel: ACPI: SSDT 0x000000009B5C7000 000634 (v02=
 LENOVO UsbCTabl 00001000 INTL 20160527)
2021-03-16 11:26:49.107 kernel: ACPI: WSMT 0x000000009B5C6000 000028 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: SSDT 0x000000009B5C5000 000141 (v02=
 LENOVO HdaDsp   00000000 INTL 20160527)
2021-03-16 11:26:49.107 kernel: ACPI: SSDT 0x000000009B5C4000 0004C5 (v02=
 LENOVO TbtTypeC 00000000 INTL 20160527)
2021-03-16 11:26:49.107 kernel: ACPI: DBGP 0x000000009B5C3000 000034 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: DBG2 0x000000009B5FD000 000054 (v00=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: MSDM 0x000000009B5C1000 000055 (v03=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: DMAR 0x000000009B5C0000 0000A8 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: ASF! 0x000000009B5BF000 0000A0 (v32=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: FPDT 0x000000009B5BE000 000044 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: BGRT 0x000000009B5BD000 000038 (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: UEFI 0x000000009B539000 00013E (v01=
 LENOVO TP-N1W   00001250 PTEC 00000002)
2021-03-16 11:26:49.107 kernel: ACPI: Local APIC address 0xfee00000
2021-03-16 11:26:49.107 kernel: No NUMA configuration found
2021-03-16 11:26:49.107 kernel: Faking a node at [mem 0x0000000000000000-=
0x000000065f7fffff]
2021-03-16 11:26:49.107 kernel: NODE_DATA(0) allocated [mem 0x65f7fc000-0=
x65f7fffff]
2021-03-16 11:26:49.107 kernel: Zone ranges:
2021-03-16 11:26:49.107 kernel:   DMA      [mem 0x0000000000001000-0x0000=
000000ffffff]
2021-03-16 11:26:49.107 kernel:   DMA32    [mem 0x0000000001000000-0x0000=
0000ffffffff]
2021-03-16 11:26:49.107 kernel:   Normal   [mem 0x0000000100000000-0x0000=
00065f7fffff]
2021-03-16 11:26:49.107 kernel: Movable zone start for each node
2021-03-16 11:26:49.107 kernel: Early memory node ranges
2021-03-16 11:26:49.107 kernel:   node   0: [mem 0x0000000000001000-0x000=
0000000057fff]
2021-03-16 11:26:49.107 kernel:   node   0: [mem 0x0000000000059000-0x000=
000000009cfff]
2021-03-16 11:26:49.107 kernel:   node   0: [mem 0x0000000000100000-0x000=
000003fffffff]
2021-03-16 11:26:49.107 kernel:   node   0: [mem 0x0000000042000000-0x000=
0000090b6cfff]
2021-03-16 11:26:49.107 kernel:   node   0: [mem 0x0000000090b6f000-0x000=
000009a4abfff]
2021-03-16 11:26:49.107 kernel:   node   0: [mem 0x000000009b5ff000-0x000=
000009b5fffff]
2021-03-16 11:26:49.107 kernel:   node   0: [mem 0x0000000100000000-0x000=
000065f7fffff]
2021-03-16 11:26:49.107 kernel: Initmem setup node 0 [mem 0x0000000000001=
000-0x000000065f7fffff]
2021-03-16 11:26:49.107 kernel: On node 0 totalpages: 6257734
2021-03-16 11:26:49.107 kernel:   DMA zone: 64 pages used for memmap
2021-03-16 11:26:49.107 kernel:   DMA zone: 22 pages reserved
2021-03-16 11:26:49.107 kernel:   DMA zone: 3995 pages, LIFO batch:0
2021-03-16 11:26:49.107 kernel:   DMA zone: 28773 pages in unavailable ra=
nges
2021-03-16 11:26:49.107 kernel:   DMA32 zone: 9683 pages used for memmap
2021-03-16 11:26:49.107 kernel:   DMA32 zone: 619691 pages, LIFO batch:63=

2021-03-16 11:26:49.107 kernel:   DMA32 zone: 31573 pages in unavailable =
ranges
2021-03-16 11:26:49.107 kernel:   Normal zone: 88032 pages used for memma=
p
2021-03-16 11:26:49.107 kernel:   Normal zone: 5634048 pages, LIFO batch:=
63
2021-03-16 11:26:49.107 kernel:   Normal zone: 2048 pages in unavailable =
ranges
2021-03-16 11:26:49.107 kernel: Reserving Intel graphics memory at [mem 0=
x9d800000-0x9f7fffff]
2021-03-16 11:26:49.107 kernel: ACPI: PM-Timer IO Port: 0x1808
2021-03-16 11:26:49.107 kernel: ACPI: Local APIC address 0xfee00000
2021-03-16 11:26:49.107 kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge =
lint[0x1])
2021-03-16 11:26:49.107 kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge =
lint[0x1])
2021-03-16 11:26:49.107 kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge =
lint[0x1])
2021-03-16 11:26:49.107 kernel: ACPI: LAPIC_NMI (acpi_id[0x04] high edge =
lint[0x1])
2021-03-16 11:26:49.107 kernel: ACPI: LAPIC_NMI (acpi_id[0x05] high edge =
lint[0x1])
2021-03-16 11:26:49.107 kernel: ACPI: LAPIC_NMI (acpi_id[0x06] high edge =
lint[0x1])
2021-03-16 11:26:49.107 kernel: ACPI: LAPIC_NMI (acpi_id[0x07] high edge =
lint[0x1])
2021-03-16 11:26:49.107 kernel: ACPI: LAPIC_NMI (acpi_id[0x08] high edge =
lint[0x1])
2021-03-16 11:26:49.107 kernel: IOAPIC[0]: apic_id 2, version 32, address=
 0xfec00000, GSI 0-119
2021-03-16 11:26:49.107 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global=
_irq 2 dfl dfl)
2021-03-16 11:26:49.107 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global=
_irq 9 high level)
2021-03-16 11:26:49.107 kernel: ACPI: IRQ0 used by override.
2021-03-16 11:26:49.107 kernel: ACPI: IRQ9 used by override.
2021-03-16 11:26:49.107 kernel: Using ACPI (MADT) for SMP configuration i=
nformation
2021-03-16 11:26:49.107 kernel: ACPI: HPET id: 0x8086a201 base: 0xfed0000=
0
2021-03-16 11:26:49.107 kernel: e820: update [mem 0x94dcb000-0x94f0afff] =
usable =3D=3D> reserved
2021-03-16 11:26:49.107 kernel: TSC deadline timer available
2021-03-16 11:26:49.107 kernel: smpboot: Allowing 4 CPUs, 0 hotplug CPUs
2021-03-16 11:26:49.107 kernel: [mem 0x9f800000-0xf7ffffff] available for=
 PCI devices
2021-03-16 11:26:49.107 kernel: clocksource: refined-jiffies: mask: 0xfff=
fffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
2021-03-16 11:26:49.107 kernel: setup_percpu: NR_CPUS:32 nr_cpumask_bits:=
32 nr_cpu_ids:4 nr_node_ids:1
2021-03-16 11:26:49.107 kernel: percpu: Embedded 53 pages/cpu s177240 r81=
92 d31656 u524288
2021-03-16 11:26:49.107 kernel: pcpu-alloc: s177240 r8192 d31656 u524288 =
alloc=3D1*2097152
2021-03-16 11:26:49.107 kernel: pcpu-alloc: [0] 0 1 2 3=20
2021-03-16 11:26:49.107 kernel: Built 1 zonelists, mobility grouping on. =
 Total pages: 6159933
2021-03-16 11:26:49.107 kernel: Policy zone: Normal
2021-03-16 11:26:49.107 kernel: Kernel command line: memmap=3D0x2000000$0=
x40000000 ramoops.mem_address=3D0x40000000 ramoops.mem_size=3D0x2000000 r=
amoops.ecc=3D1 ramoops.record_size=3D0x200000 ramoops.console_size=3D0 ra=
moops.ftrace_size=3D0 ramoops.pmsg_size=3D0 mem_sleep_default=3Ddeep l1tf=
=3Dfull mds=3Dfull nosmt BOOT_IMAGE=3D/isolinux/bzImage loglevel=3D1 sina=
_toram console=3Dtty1 intel_iommu=3Don,igfx_off
2021-03-16 11:26:49.107 kernel: DMAR: IOMMU enabled
2021-03-16 11:26:49.107 kernel: DMAR: Disable GFX device mapping
2021-03-16 11:26:49.107 kernel: Dentry cache hash table entries: 4194304 =
(order: 13, 33554432 bytes, linear)
2021-03-16 11:26:49.107 kernel: Inode-cache hash table entries: 2097152 (=
order: 12, 16777216 bytes, linear)
2021-03-16 11:26:49.107 kernel: mem auto-init: stack:off, heap alloc:off,=
 heap free:off
2021-03-16 11:26:49.107 kernel: Memory: 24362148K/25030936K available (16=
396K kernel code, 9092K rwdata, 5984K rodata, 1600K init, 2612K bss, 6685=
28K reserved, 0K cma-reserved)
2021-03-16 11:26:49.107 kernel: SLUB: HWalign=3D64, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D4, Nodes=3D1
2021-03-16 11:26:49.107 kernel: Kernel/User page tables isolation: enable=
d
2021-03-16 11:26:49.108 kernel: ftrace: allocating 50937 entries in 199 p=
ages
2021-03-16 11:26:49.108 kernel: ftrace: allocated 199 pages with 5 groups=

2021-03-16 11:26:49.108 kernel: rcu: Hierarchical RCU implementation.
2021-03-16 11:26:49.108 kernel: rcu: 	RCU event tracing is enabled.
2021-03-16 11:26:49.108 kernel: rcu: 	RCU restricting CPUs from NR_CPUS=3D=
32 to nr_cpu_ids=3D4.
2021-03-16 11:26:49.108 kernel: 	Rude variant of Tasks RCU enabled.
2021-03-16 11:26:49.108 kernel: 	Tracing variant of Tasks RCU enabled.
2021-03-16 11:26:49.108 kernel: rcu: RCU calculated value of scheduler-en=
listment delay is 100 jiffies.
2021-03-16 11:26:49.108 kernel: rcu: Adjusting geometry for rcu_fanout_le=
af=3D16, nr_cpu_ids=3D4
2021-03-16 11:26:49.108 kernel: NR_IRQS: 4352, nr_irqs: 1024, preallocate=
d irqs: 16
2021-03-16 11:26:49.108 kernel: random: get_random_bytes called from star=
t_kernel+0x3a7/0x565 with crng_init=3D0
2021-03-16 11:26:49.108 kernel: Console: colour dummy device 80x25
2021-03-16 11:26:49.108 kernel: printk: console [tty1] enabled
2021-03-16 11:26:49.108 kernel: ACPI: Core revision 20210105
2021-03-16 11:26:49.108 kernel: clocksource: hpet: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 79635855245 ns
2021-03-16 11:26:49.108 kernel: APIC: Switch to symmetric I/O mode setup
2021-03-16 11:26:49.108 kernel: ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2=
 apic2=3D-1 pin2=3D-1
2021-03-16 11:26:49.108 kernel: clocksource: tsc-early: mask: 0xfffffffff=
fffffff max_cycles: 0x29ccd767b87, max_idle_ns: 440795223720 ns
2021-03-16 11:26:49.108 kernel: Calibrating delay loop (skipped), value c=
alculated using timer frequency.. 5799.77 BogoMIPS (lpj=3D2899886)
2021-03-16 11:26:49.108 kernel: pid_max: default: 32768 minimum: 301
2021-03-16 11:26:49.108 kernel: LSM: Security Framework initializing
2021-03-16 11:26:49.108 kernel: Mount-cache hash table entries: 65536 (or=
der: 7, 524288 bytes, linear)
2021-03-16 11:26:49.108 kernel: Mountpoint-cache hash table entries: 6553=
6 (order: 7, 524288 bytes, linear)
2021-03-16 11:26:49.108 kernel: CPU0: Thermal monitoring enabled (TM1)
2021-03-16 11:26:49.108 kernel: process: using mwait in idle threads
2021-03-16 11:26:49.108 kernel: Last level iTLB entries: 4KB 64, 2MB 8, 4=
MB 8
2021-03-16 11:26:49.108 kernel: Last level dTLB entries: 4KB 64, 2MB 0, 4=
MB 0, 1GB 4
2021-03-16 11:26:49.108 kernel: Spectre V1 : Mitigation: usercopy/swapgs =
barriers and __user pointer sanitization
2021-03-16 11:26:49.108 kernel: Spectre V2 : Mitigation: Full generic ret=
poline
2021-03-16 11:26:49.108 kernel: Spectre V2 : Spectre v2 / SpectreRSB miti=
gation: Filling RSB on context switch
2021-03-16 11:26:49.108 kernel: Spectre V2 : Enabling Restricted Speculat=
ion for firmware calls
2021-03-16 11:26:49.108 kernel: Spectre V2 : mitigation: Enabling conditi=
onal Indirect Branch Prediction Barrier
2021-03-16 11:26:49.108 kernel: Spectre V2 : User space: Mitigation: STIB=
P via seccomp and prctl
2021-03-16 11:26:49.108 kernel: Speculative Store Bypass: Mitigation: Spe=
culative Store Bypass disabled via prctl and seccomp
2021-03-16 11:26:49.108 kernel: SMT: disabled
2021-03-16 11:26:49.108 kernel: SRBDS: Mitigation: Microcode
2021-03-16 11:26:49.108 kernel: MDS: Mitigation: Clear CPU buffers
2021-03-16 11:26:49.108 kernel: Freeing SMP alternatives memory: 40K
2021-03-16 11:26:49.108 kernel: smpboot: Estimated ratio of average max f=
requency by base frequency (times 1024): 1235
2021-03-16 11:26:49.108 kernel: smpboot: CPU0: Intel(R) Core(TM) i7-7500U=
 CPU @ 2.70GHz (family: 0x6, model: 0x8e, stepping: 0x9)
2021-03-16 11:26:49.108 kernel: Performance Events: PEBS fmt3+, Skylake e=
vents, 32-deep LBR, full-width counters, Intel PMU driver.
2021-03-16 11:26:49.108 kernel: ... version:                4
2021-03-16 11:26:49.108 kernel: ... bit width:              48
2021-03-16 11:26:49.108 kernel: ... generic registers:      4
2021-03-16 11:26:49.108 kernel: ... value mask:             0000fffffffff=
fff
2021-03-16 11:26:49.108 kernel: ... max period:             00007ffffffff=
fff
2021-03-16 11:26:49.108 kernel: ... fixed-purpose events:   3
2021-03-16 11:26:49.108 kernel: ... event mask:             0000000700000=
00f
2021-03-16 11:26:49.108 kernel: rcu: Hierarchical SRCU implementation.
2021-03-16 11:26:49.108 kernel: NMI watchdog: Enabled. Permanently consum=
es one hw-PMU counter.
2021-03-16 11:26:49.108 kernel: smp: Bringing up secondary CPUs ...
2021-03-16 11:26:49.108 kernel: x86: Booting SMP configuration:
2021-03-16 11:26:49.108 kernel: .... node  #0, CPUs:      #1 #2 #3
2021-03-16 11:26:49.108 kernel: smp: Brought up 1 node, 2 CPUs
2021-03-16 11:26:49.108 kernel: smpboot: Max logical packages: 2
2021-03-16 11:26:49.108 kernel: smpboot: Total of 2 processors activated =
(11599.54 BogoMIPS)
2021-03-16 11:26:49.108 kernel: devtmpfs: initialized
2021-03-16 11:26:49.108 kernel: PM: Registering ACPI NVS region [mem 0x90=
b6d000-0x90b6dfff] (4096 bytes)
2021-03-16 11:26:49.108 kernel: PM: Registering ACPI NVS region [mem 0x9b=
52c000-0x9b54cfff] (135168 bytes)
2021-03-16 11:26:49.108 kernel: PM: Registering ACPI NVS region [mem 0x9b=
54e000-0x9b599fff] (311296 bytes)
2021-03-16 11:26:49.108 kernel: clocksource: jiffies: mask: 0xffffffff ma=
x_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
2021-03-16 11:26:49.108 kernel: futex hash table entries: 1024 (order: 4,=
 65536 bytes, linear)
2021-03-16 11:26:49.108 kernel: pinctrl core: initialized pinctrl subsyst=
em
2021-03-16 11:26:49.108 kernel: PM: RTC time: 11:26:18, date: 2021-03-16
2021-03-16 11:26:49.108 kernel: NET: Registered protocol family 16
2021-03-16 11:26:49.108 kernel: ramoops: using module parameters
2021-03-16 11:26:49.108 kernel: pstore: Registered ramoops as persistent =
store backend
2021-03-16 11:26:49.108 kernel: ramoops: using 0x2000000@0x40000000, ecc:=
 16
2021-03-16 11:26:49.108 kernel: thermal_sys: Registered thermal governor =
'step_wise'
2021-03-16 11:26:49.108 kernel: thermal_sys: Registered thermal governor =
'user_space'
2021-03-16 11:26:49.108 kernel: cpuidle: using governor menu
2021-03-16 11:26:49.108 kernel: Simple Boot Flag at 0x47 set to 0x1
2021-03-16 11:26:49.108 kernel: ACPI FADT declares the system doesn't sup=
port PCIe ASPM, so disable it
2021-03-16 11:26:49.108 kernel: ACPI: bus type PCI registered
2021-03-16 11:26:49.108 kernel: acpiphp: ACPI Hot Plug PCI Controller Dri=
ver version: 0.5
2021-03-16 11:26:49.108 kernel: PCI: MMCONFIG for domain 0000 [bus 00-3f]=
 at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
2021-03-16 11:26:49.108 kernel: PCI: MMCONFIG at [mem 0xf8000000-0xfbffff=
ff] reserved in E820
2021-03-16 11:26:49.108 kernel: PCI: Using configuration type 1 for base =
access
2021-03-16 11:26:49.108 kernel: ENERGY_PERF_BIAS: Set to 'normal', was 'p=
erformance'
2021-03-16 11:26:49.108 kernel: Kprobes globally optimized
2021-03-16 11:26:49.108 kernel: cryptomgr_test (39) used greatest stack d=
epth: 15736 bytes left
2021-03-16 11:26:49.108 kernel: cryptomgr_test (64) used greatest stack d=
epth: 15720 bytes left
2021-03-16 11:26:49.108 kernel: cryptomgr_test (70) used greatest stack d=
epth: 15464 bytes left
2021-03-16 11:26:49.108 kernel: ACPI: Added _OSI(Module Device)
2021-03-16 11:26:49.108 kernel: ACPI: Added _OSI(Processor Device)
2021-03-16 11:26:49.108 kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
2021-03-16 11:26:49.108 kernel: ACPI: Added _OSI(Processor Aggregator Dev=
ice)
2021-03-16 11:26:49.108 kernel: ACPI: Added _OSI(Linux-Dell-Video)
2021-03-16 11:26:49.108 kernel: ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Aud=
io)
2021-03-16 11:26:49.108 kernel: ACPI: Added _OSI(Linux-HPI-Hybrid-Graphic=
s)
2021-03-16 11:26:49.108 kernel: ACPI: 10 ACPI AML tables successfully acq=
uired and loaded
2021-03-16 11:26:49.108 kernel: ACPI: EC: EC started
2021-03-16 11:26:49.108 kernel: ACPI: EC: interrupt blocked
2021-03-16 11:26:49.108 kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D=
0x62
2021-03-16 11:26:49.108 kernel: ACPI: EC: Boot ECDT EC used to handle tra=
nsactions
2021-03-16 11:26:49.108 kernel: ACPI: [Firmware Bug]: BIOS _OSI(Linux) qu=
ery ignored
2021-03-16 11:26:49.108 kernel: ACPI: Dynamic OEM Table Load:
2021-03-16 11:26:49.108 kernel: ACPI: SSDT 0xFFFF9531C0CAB000 0006F6 (v02=
 PmRef  Cpu0Ist  00003000 INTL 20160527)
2021-03-16 11:26:49.108 kernel: ACPI: \_PR_.PR00: _OSC native thermal LVT=
 Acked
2021-03-16 11:26:49.108 kernel: ACPI: Dynamic OEM Table Load:
2021-03-16 11:26:49.108 kernel: ACPI: SSDT 0xFFFF9531C09EF000 0003FF (v02=
 PmRef  Cpu0Cst  00003001 INTL 20160527)
2021-03-16 11:26:49.108 kernel: ACPI: Dynamic OEM Table Load:
2021-03-16 11:26:49.108 kernel: ACPI: SSDT 0xFFFF9531C0CD0A80 0000BA (v02=
 PmRef  Cpu0Hwp  00003000 INTL 20160527)
2021-03-16 11:26:49.108 kernel: ACPI: Dynamic OEM Table Load:
2021-03-16 11:26:49.108 kernel: ACPI: SSDT 0xFFFF9531C0CAB800 000628 (v02=
 PmRef  HwpLvt   00003000 INTL 20160527)
2021-03-16 11:26:49.108 kernel: ACPI: Dynamic OEM Table Load:
2021-03-16 11:26:49.108 kernel: ACPI: SSDT 0xFFFF9531C0D31000 000D14 (v02=
 PmRef  ApIst    00003000 INTL 20160527)
2021-03-16 11:26:49.108 kernel: ACPI: Dynamic OEM Table Load:
2021-03-16 11:26:49.108 kernel: ACPI: SSDT 0xFFFF9531C09EF400 000317 (v02=
 PmRef  ApHwp    00003000 INTL 20160527)
2021-03-16 11:26:49.108 kernel: ACPI: Dynamic OEM Table Load:
2021-03-16 11:26:49.108 kernel: ACPI: SSDT 0xFFFF9531C09EF800 00030A (v02=
 PmRef  ApCst    00003000 INTL 20160527)
2021-03-16 11:26:49.108 kernel: ACPI: Interpreter enabled
2021-03-16 11:26:49.108 kernel: ACPI: (supports S0 S3 S5)
2021-03-16 11:26:49.108 kernel: ACPI: Using IOAPIC for interrupt routing
2021-03-16 11:26:49.108 kernel: PCI: Using host bridge windows from ACPI;=
 if necessary, use "pci=3Dnocrs" and report a bug
2021-03-16 11:26:49.108 kernel: ACPI: Enabled 7 GPEs in block 00 to 7F
2021-03-16 11:26:49.108 kernel: ACPI: PM: Power Resource [PUBS] (on)
2021-03-16 11:26:49.108 kernel: ACPI: PM: Power Resource [WRST] (on)
2021-03-16 11:26:49.108 kernel: ACPI: PM: Power Resource [WRST] (on)
2021-03-16 11:26:49.108 kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000=
 [bus 00-3e])
2021-03-16 11:26:49.108 kernel: acpi PNP0A08:00: _OSC: OS supports [Exten=
dedConfig ASPM ClockPM Segments MSI HPX-Type3]
2021-03-16 11:26:49.109 kernel: acpi PNP0A08:00: _OSC: platform does not =
support [PCIeHotplug SHPCHotplug PME PCIeCapability]
2021-03-16 11:26:49.109 kernel: acpi PNP0A08:00: _OSC: not requesting con=
trol; platform does not support [PCIeCapability]
2021-03-16 11:26:49.109 kernel: acpi PNP0A08:00: _OSC: OS requested [PCIe=
Hotplug SHPCHotplug PME PCIeCapability LTR]
2021-03-16 11:26:49.109 kernel: acpi PNP0A08:00: _OSC: platform willing t=
o grant [LTR]
2021-03-16 11:26:49.109 kernel: acpi PNP0A08:00: _OSC: platform retains c=
ontrol of PCIe features (AE_SUPPORT)
2021-03-16 11:26:49.109 kernel: PCI host bridge to bus 0000:00
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [io  0=
x0000-0x0cf7 window]
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [io  0=
x0d00-0xffff window]
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000a0000-0x000bffff window]
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000c0000-0x000c3fff window]
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000c4000-0x000c7fff window]
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000c8000-0x000cbfff window]
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000cc000-0x000cffff window]
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000d0000-0x000d3fff window]
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000d4000-0x000d7fff window]
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000d8000-0x000dbfff window]
2021-03-16 11:26:49.109 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000dc000-0x000dffff window]
2021-03-16 11:26:49.110 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000e0000-0x000e3fff window]
2021-03-16 11:26:49.110 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000e4000-0x000e7fff window]
2021-03-16 11:26:49.110 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000e8000-0x000ebfff window]
2021-03-16 11:26:49.110 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000ec000-0x000effff window]
2021-03-16 11:26:49.110 kernel: pci_bus 0000:00: root bus resource [mem 0=
x000f0000-0x000fffff window]
2021-03-16 11:26:49.110 kernel: pci_bus 0000:00: root bus resource [mem 0=
x9f800000-0xf7ffffff window]
2021-03-16 11:26:49.110 kernel: pci_bus 0000:00: root bus resource [mem 0=
xfd000000-0xfe7fffff window]
2021-03-16 11:26:49.110 kernel: pci_bus 0000:00: root bus resource [bus 0=
0-3e]
2021-03-16 11:26:49.110 kernel: pci 0000:00:00.0: [8086:5904] type 00 cla=
ss 0x060000
2021-03-16 11:26:49.110 kernel: pci 0000:00:02.0: [8086:5916] type 00 cla=
ss 0x030000
2021-03-16 11:26:49.110 kernel: pci 0000:00:02.0: reg 0x10: [mem 0xeb0000=
00-0xebffffff 64bit]
2021-03-16 11:26:49.110 kernel: pci 0000:00:02.0: reg 0x18: [mem 0xa00000=
00-0xafffffff 64bit pref]
2021-03-16 11:26:49.110 kernel: pci 0000:00:02.0: reg 0x20: [io  0xe000-0=
xe03f]
2021-03-16 11:26:49.111 kernel: pci 0000:00:02.0: BAR 2: assigned to efif=
b
2021-03-16 11:26:49.111 kernel: pci 0000:00:14.0: [8086:9d2f] type 00 cla=
ss 0x0c0330
2021-03-16 11:26:49.111 kernel: pci 0000:00:14.0: reg 0x10: [mem 0xec2200=
00-0xec22ffff 64bit]
2021-03-16 11:26:49.111 kernel: pci 0000:00:14.0: PME# supported from D3h=
ot D3cold
2021-03-16 11:26:49.111 kernel: pci 0000:00:14.2: [8086:9d31] type 00 cla=
ss 0x118000
2021-03-16 11:26:49.111 kernel: pci 0000:00:14.2: reg 0x10: [mem 0xec2480=
00-0xec248fff 64bit]
2021-03-16 11:26:49.111 kernel: pci 0000:00:16.0: [8086:9d3a] type 00 cla=
ss 0x078000
2021-03-16 11:26:49.111 kernel: pci 0000:00:16.0: reg 0x10: [mem 0xec2490=
00-0xec249fff 64bit]
2021-03-16 11:26:49.111 kernel: pci 0000:00:16.0: PME# supported from D3h=
ot
2021-03-16 11:26:49.111 kernel: pci 0000:00:1c.0: [8086:9d10] type 01 cla=
ss 0x060400
2021-03-16 11:26:49.111 kernel: pci 0000:00:1c.0: PME# supported from D0 =
D3hot D3cold
2021-03-16 11:26:49.111 kernel: pci 0000:00:1c.0: Intel SPT PCH root port=
 ACS workaround enabled
2021-03-16 11:26:49.111 kernel: pci 0000:00:1c.2: [8086:9d12] type 01 cla=
ss 0x060400
2021-03-16 11:26:49.111 kernel: pci 0000:00:1c.2: PME# supported from D0 =
D3hot D3cold
2021-03-16 11:26:49.112 kernel: pci 0000:00:1c.2: Intel SPT PCH root port=
 ACS workaround enabled
2021-03-16 11:26:49.112 kernel: pci 0000:00:1d.0: [8086:9d18] type 01 cla=
ss 0x060400
2021-03-16 11:26:49.112 kernel: pci 0000:00:1d.0: PME# supported from D0 =
D3hot D3cold
2021-03-16 11:26:49.112 kernel: pci 0000:00:1d.0: Intel SPT PCH root port=
 ACS workaround enabled
2021-03-16 11:26:49.112 kernel: pci 0000:00:1f.0: [8086:9d58] type 00 cla=
ss 0x060100
2021-03-16 11:26:49.112 kernel: pci 0000:00:1f.2: [8086:9d21] type 00 cla=
ss 0x058000
2021-03-16 11:26:49.112 kernel: pci 0000:00:1f.2: reg 0x10: [mem 0xec2440=
00-0xec247fff]
2021-03-16 11:26:49.112 kernel: pci 0000:00:1f.3: [8086:9d71] type 00 cla=
ss 0x040300
2021-03-16 11:26:49.112 kernel: pci 0000:00:1f.3: reg 0x10: [mem 0xec2400=
00-0xec243fff 64bit]
2021-03-16 11:26:49.112 kernel: pci 0000:00:1f.3: reg 0x20: [mem 0xec2300=
00-0xec23ffff 64bit]
2021-03-16 11:26:49.112 kernel: pci 0000:00:1f.3: PME# supported from D3h=
ot D3cold
2021-03-16 11:26:49.112 kernel: pci 0000:00:1f.4: [8086:9d23] type 00 cla=
ss 0x0c0500
2021-03-16 11:26:49.113 kernel: pci 0000:00:1f.4: reg 0x10: [mem 0xec24a0=
00-0xec24a0ff 64bit]
2021-03-16 11:26:49.113 kernel: pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0=
xefbf]
2021-03-16 11:26:49.113 kernel: pci 0000:00:1f.6: [8086:15d8] type 00 cla=
ss 0x020000
2021-03-16 11:26:49.113 kernel: pci 0000:00:1f.6: reg 0x10: [mem 0xec2000=
00-0xec21ffff]
2021-03-16 11:26:49.113 kernel: pci 0000:00:1f.6: PME# supported from D0 =
D3hot D3cold
2021-03-16 11:26:49.113 kernel: pci 0000:00:1c.0: PCI bridge to [bus 01-3=
9]
2021-03-16 11:26:49.113 kernel: pci 0000:00:1c.0:   bridge window [mem 0x=
d4000000-0xea0fffff]
2021-03-16 11:26:49.113 kernel: pci 0000:00:1c.0:   bridge window [mem 0x=
b0000000-0xd1ffffff 64bit pref]
2021-03-16 11:26:49.113 kernel: pci 0000:3a:00.0: [8086:24fd] type 00 cla=
ss 0x028000
2021-03-16 11:26:49.113 kernel: pci 0000:3a:00.0: reg 0x10: [mem 0xec1000=
00-0xec101fff 64bit]
2021-03-16 11:26:49.113 kernel: pci 0000:3a:00.0: PME# supported from D0 =
D3hot D3cold
2021-03-16 11:26:49.113 kernel: pci 0000:00:1c.2: PCI bridge to [bus 3a]
2021-03-16 11:26:49.113 kernel: pci 0000:00:1c.2:   bridge window [mem 0x=
ec100000-0xec1fffff]
2021-03-16 11:26:49.114 kernel: pci 0000:3c:00.0: [144d:a804] type 00 cla=
ss 0x010802
2021-03-16 11:26:49.114 kernel: pci 0000:3c:00.0: reg 0x10: [mem 0xec0000=
00-0xec003fff 64bit]
2021-03-16 11:26:49.114 kernel: pci 0000:00:1d.0: PCI bridge to [bus 3c]
2021-03-16 11:26:49.114 kernel: pci 0000:00:1d.0:   bridge window [mem 0x=
ec000000-0xec0fffff]
2021-03-16 11:26:49.114 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4=
 5 6 10 *11 12 14 15)
2021-03-16 11:26:49.114 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4=
 5 6 *10 11 12 14 15)
2021-03-16 11:26:49.114 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4=
 5 6 10 *11 12 14 15)
2021-03-16 11:26:49.114 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4=
 5 6 10 *11 12 14 15)
2021-03-16 11:26:49.114 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4=
 5 6 10 *11 12 14 15)
2021-03-16 11:26:49.114 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4=
 5 6 10 *11 12 14 15)
2021-03-16 11:26:49.114 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4=
 5 6 10 *11 12 14 15)
2021-03-16 11:26:49.114 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4=
 5 6 10 *11 12 14 15)
2021-03-16 11:26:49.114 kernel: ACPI: EC: interrupt unblocked
2021-03-16 11:26:49.114 kernel: ACPI: EC: event unblocked
2021-03-16 11:26:49.114 kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D=
0x62
2021-03-16 11:26:49.114 kernel: ACPI: EC: GPE=3D0x16
2021-03-16 11:26:49.114 kernel: ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC =
initialization complete
2021-03-16 11:26:49.114 kernel: ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to h=
andle transactions and events
2021-03-16 11:26:49.114 kernel: iommu: Default domain type: Translated=20
2021-03-16 11:26:49.114 kernel: SCSI subsystem initialized
2021-03-16 11:26:49.114 kernel: libata version 3.00 loaded.
2021-03-16 11:26:49.114 kernel: ACPI: bus type USB registered
2021-03-16 11:26:49.114 kernel: usbcore: registered new interface driver =
usbfs
2021-03-16 11:26:49.114 kernel: usbcore: registered new interface driver =
hub
2021-03-16 11:26:49.114 kernel: usbcore: registered new device driver usb=

2021-03-16 11:26:49.114 kernel: pps_core: LinuxPPS API ver. 1 registered
2021-03-16 11:26:49.114 kernel: pps_core: Software ver. 5.3.6 - Copyright=
 2005-2007 Rodolfo Giometti <giometti@linux.it>
2021-03-16 11:26:49.114 kernel: PTP clock support registered
2021-03-16 11:26:49.114 kernel: Registered efivars operations
2021-03-16 11:26:49.114 kernel: Advanced Linux Sound Architecture Driver =
Initialized.
2021-03-16 11:26:49.114 kernel: PCI: Using ACPI for IRQ routing
2021-03-16 11:26:49.114 kernel: PCI: pci_cache_line_size set to 64 bytes
2021-03-16 11:26:49.114 kernel: e820: reserve RAM buffer [mem 0x00058000-=
0x0005ffff]
2021-03-16 11:26:49.114 kernel: e820: reserve RAM buffer [mem 0x0009d000-=
0x0009ffff]
2021-03-16 11:26:49.114 kernel: e820: reserve RAM buffer [mem 0x90b6d000-=
0x93ffffff]
2021-03-16 11:26:49.114 kernel: e820: reserve RAM buffer [mem 0x94dcb000-=
0x97ffffff]
2021-03-16 11:26:49.114 kernel: e820: reserve RAM buffer [mem 0x9a4ac000-=
0x9bffffff]
2021-03-16 11:26:49.114 kernel: e820: reserve RAM buffer [mem 0x9b600000-=
0x9bffffff]
2021-03-16 11:26:49.114 kernel: e820: reserve RAM buffer [mem 0x65f800000=
-0x65fffffff]
2021-03-16 11:26:49.114 kernel: acpi PNP0C14:02: duplicate WMI GUID 05901=
221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
2021-03-16 11:26:49.114 kernel: acpi PNP0C14:03: duplicate WMI GUID 05901=
221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
2021-03-16 11:26:49.114 kernel: clocksource: Switched to clocksource tsc-=
early
2021-03-16 11:26:49.114 kernel: pnp: PnP ACPI init
2021-03-16 11:26:49.114 kernel: system 00:00: [mem 0xfd000000-0xfdabffff]=
 has been reserved
2021-03-16 11:26:49.114 kernel: system 00:00: [mem 0xfdad0000-0xfdadffff]=
 has been reserved
2021-03-16 11:26:49.114 kernel: system 00:00: [mem 0xfdb00000-0xfdffffff]=
 has been reserved
2021-03-16 11:26:49.114 kernel: system 00:00: [mem 0xfe000000-0xfe01ffff]=
 could not be reserved
2021-03-16 11:26:49.115 kernel: system 00:00: [mem 0xfe036000-0xfe03bfff]=
 has been reserved
2021-03-16 11:26:49.115 kernel: system 00:00: [mem 0xfe03d000-0xfe3fffff]=
 has been reserved
2021-03-16 11:26:49.115 kernel: system 00:00: [mem 0xfe410000-0xfe7fffff]=
 has been reserved
2021-03-16 11:26:49.115 kernel: system 00:00: Plug and Play ACPI device, =
IDs PNP0c02 (active)
2021-03-16 11:26:49.115 kernel: system 00:01: [io  0xff00-0xfffe] has bee=
n reserved
2021-03-16 11:26:49.115 kernel: system 00:01: Plug and Play ACPI device, =
IDs PNP0c02 (active)
2021-03-16 11:26:49.115 kernel: system 00:02: [io  0x0680-0x069f] has bee=
n reserved
2021-03-16 11:26:49.115 kernel: system 00:02: [io  0xffff] has been reser=
ved
2021-03-16 11:26:49.115 kernel: system 00:02: [io  0xffff] has been reser=
ved
2021-03-16 11:26:49.115 kernel: system 00:02: [io  0xffff] has been reser=
ved
2021-03-16 11:26:49.115 kernel: system 00:02: [io  0x1800-0x18fe] has bee=
n reserved
2021-03-16 11:26:49.115 kernel: system 00:02: [io  0x164e-0x164f] has bee=
n reserved
2021-03-16 11:26:49.115 kernel: system 00:02: Plug and Play ACPI device, =
IDs PNP0c02 (active)
2021-03-16 11:26:49.115 kernel: pnp 00:03: Plug and Play ACPI device, IDs=
 PNP0b00 (active)
2021-03-16 11:26:49.116 kernel: system 00:04: [io  0x1854-0x1857] has bee=
n reserved
2021-03-16 11:26:49.116 kernel: system 00:04: Plug and Play ACPI device, =
IDs INT3f0d PNP0c02 (active)
2021-03-16 11:26:49.116 kernel: pnp 00:05: Plug and Play ACPI device, IDs=
 LEN0071 PNP0303 (active)
2021-03-16 11:26:49.116 kernel: pnp 00:06: Plug and Play ACPI device, IDs=
 LEN006c PNP0f13 (active)
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x1800-0x189f] could n=
ot be reserved
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x0800-0x087f] has bee=
n reserved
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x0880-0x08ff] has bee=
n reserved
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x0900-0x097f] has bee=
n reserved
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x0980-0x09ff] has bee=
n reserved
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x0a00-0x0a7f] has bee=
n reserved
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x0a80-0x0aff] has bee=
n reserved
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x0b00-0x0b7f] has bee=
n reserved
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x0b80-0x0bff] has bee=
n reserved
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x15e0-0x15ef] has bee=
n reserved
2021-03-16 11:26:49.116 kernel: system 00:07: [io  0x1600-0x167f] could n=
ot be reserved
2021-03-16 11:26:49.117 kernel: system 00:07: [io  0x1640-0x165f] could n=
ot be reserved
2021-03-16 11:26:49.117 kernel: system 00:07: [mem 0xf8000000-0xfbffffff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:07: [mem 0xfed10000-0xfed13fff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:07: [mem 0xfed18000-0xfed18fff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:07: [mem 0xfed19000-0xfed19fff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:07: [mem 0xfeb00000-0xfebfffff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:07: [mem 0xfed20000-0xfed3ffff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:07: [mem 0xfed90000-0xfed93fff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:07: [mem 0xf7fe0000-0xf7ffffff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:07: Plug and Play ACPI device, =
IDs PNP0c02 (active)
2021-03-16 11:26:49.117 kernel: system 00:08: [mem 0xfdaf0000-0xfdafffff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:08: [mem 0xfdae0000-0xfdaeffff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:08: [mem 0xfdac0000-0xfdacffff]=
 has been reserved
2021-03-16 11:26:49.117 kernel: system 00:08: Plug and Play ACPI device, =
IDs PNP0c02 (active)
2021-03-16 11:26:49.117 kernel: system 00:09: [mem 0xfed10000-0xfed17fff]=
 could not be reserved
2021-03-16 11:26:49.118 kernel: system 00:09: [mem 0xfed18000-0xfed18fff]=
 has been reserved
2021-03-16 11:26:49.118 kernel: system 00:09: [mem 0xfed19000-0xfed19fff]=
 has been reserved
2021-03-16 11:26:49.118 kernel: system 00:09: [mem 0xf8000000-0xfbffffff]=
 has been reserved
2021-03-16 11:26:49.118 kernel: system 00:09: [mem 0xfed20000-0xfed3ffff]=
 has been reserved
2021-03-16 11:26:49.118 kernel: system 00:09: [mem 0xfed90000-0xfed93fff]=
 has been reserved
2021-03-16 11:26:49.118 kernel: system 00:09: [mem 0xfed45000-0xfed8ffff]=
 has been reserved
2021-03-16 11:26:49.118 kernel: system 00:09: [mem 0xff000000-0xffffffff]=
 has been reserved
2021-03-16 11:26:49.118 kernel: system 00:09: [mem 0xfee00000-0xfeefffff]=
 has been reserved
2021-03-16 11:26:49.118 kernel: system 00:09: [mem 0xf7fe0000-0xf7ffffff]=
 has been reserved
2021-03-16 11:26:49.118 kernel: system 00:09: Plug and Play ACPI device, =
IDs PNP0c02 (active)
2021-03-16 11:26:49.118 kernel: system 00:0a: [mem 0x00000000-0x0009ffff]=
 could not be reserved
2021-03-16 11:26:49.118 kernel: system 00:0a: [mem 0x000f0000-0x000fffff]=
 could not be reserved
2021-03-16 11:26:49.118 kernel: system 00:0a: [mem 0x00100000-0x9f7fffff]=
 could not be reserved
2021-03-16 11:26:49.118 kernel: system 00:0a: [mem 0xfec00000-0xfed3ffff]=
 could not be reserved
2021-03-16 11:26:49.118 kernel: system 00:0a: [mem 0xfed4c000-0xffffffff]=
 could not be reserved
2021-03-16 11:26:49.119 kernel: system 00:0a: Plug and Play ACPI device, =
IDs PNP0c01 (active)
2021-03-16 11:26:49.119 kernel: pnp: PnP ACPI: found 11 devices
2021-03-16 11:26:49.119 kernel: clocksource: acpi_pm: mask: 0xffffff max_=
cycles: 0xffffff, max_idle_ns: 2085701024 ns
2021-03-16 11:26:49.119 kernel: NET: Registered protocol family 2
2021-03-16 11:26:49.119 kernel: tcp_listen_portaddr_hash hash table entri=
es: 16384 (order: 6, 262144 bytes, linear)
2021-03-16 11:26:49.119 kernel: TCP established hash table entries: 26214=
4 (order: 9, 2097152 bytes, linear)
2021-03-16 11:26:49.119 kernel: TCP bind hash table entries: 65536 (order=
: 8, 1048576 bytes, linear)
2021-03-16 11:26:49.119 kernel: TCP: Hash tables configured (established =
262144 bind 65536)
2021-03-16 11:26:49.119 kernel: UDP hash table entries: 16384 (order: 7, =
524288 bytes, linear)
2021-03-16 11:26:49.119 kernel: UDP-Lite hash table entries: 16384 (order=
: 7, 524288 bytes, linear)
2021-03-16 11:26:49.119 kernel: NET: Registered protocol family 1
2021-03-16 11:26:49.119 kernel: pci 0000:00:1c.0: bridge window [io  0x10=
00-0x0fff] to [bus 01-39] add_size 1000
2021-03-16 11:26:49.119 kernel: pci 0000:00:1c.0: BAR 7: assigned [io  0x=
2000-0x2fff]
2021-03-16 11:26:49.119 kernel: pci 0000:00:1c.0: PCI bridge to [bus 01-3=
9]
2021-03-16 11:26:49.119 kernel: pci 0000:00:1c.0:   bridge window [io  0x=
2000-0x2fff]
2021-03-16 11:26:49.119 kernel: pci 0000:00:1c.0:   bridge window [mem 0x=
d4000000-0xea0fffff]
2021-03-16 11:26:49.119 kernel: pci 0000:00:1c.0:   bridge window [mem 0x=
b0000000-0xd1ffffff 64bit pref]
2021-03-16 11:26:49.119 kernel: pci 0000:00:1c.2: PCI bridge to [bus 3a]
2021-03-16 11:26:49.119 kernel: pci 0000:00:1c.2:   bridge window [mem 0x=
ec100000-0xec1fffff]
2021-03-16 11:26:49.119 kernel: pci 0000:00:1d.0: PCI bridge to [bus 3c]
2021-03-16 11:26:49.119 kernel: pci 0000:00:1d.0:   bridge window [mem 0x=
ec000000-0xec0fffff]
2021-03-16 11:26:49.119 kernel: pci_bus 0000:00: resource 4 [io  0x0000-0=
x0cf7 window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0=
xffff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 6 [mem 0x000a00=
00-0x000bffff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 7 [mem 0x000c00=
00-0x000c3fff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 8 [mem 0x000c40=
00-0x000c7fff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 9 [mem 0x000c80=
00-0x000cbfff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 10 [mem 0x000cc=
000-0x000cffff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 11 [mem 0x000d0=
000-0x000d3fff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 12 [mem 0x000d4=
000-0x000d7fff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 13 [mem 0x000d8=
000-0x000dbfff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 14 [mem 0x000dc=
000-0x000dffff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 15 [mem 0x000e0=
000-0x000e3fff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 16 [mem 0x000e4=
000-0x000e7fff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 17 [mem 0x000e8=
000-0x000ebfff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 18 [mem 0x000ec=
000-0x000effff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 19 [mem 0x000f0=
000-0x000fffff window]
2021-03-16 11:26:49.120 kernel: pci_bus 0000:00: resource 20 [mem 0x9f800=
000-0xf7ffffff window]
2021-03-16 11:26:49.121 kernel: pci_bus 0000:00: resource 21 [mem 0xfd000=
000-0xfe7fffff window]
2021-03-16 11:26:49.121 kernel: pci_bus 0000:01: resource 0 [io  0x2000-0=
x2fff]
2021-03-16 11:26:49.121 kernel: pci_bus 0000:01: resource 1 [mem 0xd40000=
00-0xea0fffff]
2021-03-16 11:26:49.121 kernel: pci_bus 0000:01: resource 2 [mem 0xb00000=
00-0xd1ffffff 64bit pref]
2021-03-16 11:26:49.121 kernel: pci_bus 0000:3a: resource 1 [mem 0xec1000=
00-0xec1fffff]
2021-03-16 11:26:49.121 kernel: pci_bus 0000:3c: resource 1 [mem 0xec0000=
00-0xec0fffff]
2021-03-16 11:26:49.121 kernel: pci 0000:00:02.0: Video device with shado=
wed ROM at [mem 0x000c0000-0x000dffff]
2021-03-16 11:26:49.121 kernel: PCI: CLS 0 bytes, default 64
2021-03-16 11:26:49.121 kernel: Unpacking initramfs...
2021-03-16 11:26:49.121 kernel: Freeing initrd memory: 45128K
2021-03-16 11:26:49.121 kernel: DMAR: Host address width 39
2021-03-16 11:26:49.121 kernel: DMAR: DRHD base: 0x000000fed90000 flags: =
0x0
2021-03-16 11:26:49.121 kernel: DMAR: dmar0: reg_base_addr fed90000 ver 1=
:0 cap 1c0000c40660462 ecap 19e2ff0505e
2021-03-16 11:26:49.121 kernel: DMAR: DRHD base: 0x000000fed91000 flags: =
0x1
2021-03-16 11:26:49.121 kernel: DMAR: dmar1: reg_base_addr fed91000 ver 1=
:0 cap d2008c40660462 ecap f050da
2021-03-16 11:26:49.121 kernel: DMAR: RMRR base: 0x0000009aa9f000 end: 0x=
0000009aabefff
2021-03-16 11:26:49.121 kernel: DMAR: RMRR base: 0x0000009d000000 end: 0x=
0000009f7fffff
2021-03-16 11:26:49.121 kernel: DMAR: No ATSR found
2021-03-16 11:26:49.121 kernel: DMAR: No SATC found
2021-03-16 11:26:49.121 kernel: DMAR: dmar1: Using Queued invalidation
2021-03-16 11:26:49.121 kernel: pci 0000:00:00.0: Adding to iommu group 0=

2021-03-16 11:26:49.121 kernel: pci 0000:00:14.0: Adding to iommu group 1=

2021-03-16 11:26:49.121 kernel: pci 0000:00:14.2: Adding to iommu group 1=

2021-03-16 11:26:49.121 kernel: pci 0000:00:16.0: Adding to iommu group 2=

2021-03-16 11:26:49.121 kernel: pci 0000:00:1c.0: Adding to iommu group 3=

2021-03-16 11:26:49.122 kernel: pci 0000:00:1c.2: Adding to iommu group 4=

2021-03-16 11:26:49.122 kernel: pci 0000:00:1d.0: Adding to iommu group 5=

2021-03-16 11:26:49.122 kernel: pci 0000:00:1f.0: Adding to iommu group 6=

2021-03-16 11:26:49.122 kernel: pci 0000:00:1f.2: Adding to iommu group 6=

2021-03-16 11:26:49.122 kernel: pci 0000:00:1f.3: Adding to iommu group 6=

2021-03-16 11:26:49.122 kernel: pci 0000:00:1f.4: Adding to iommu group 6=

2021-03-16 11:26:49.122 kernel: pci 0000:00:1f.6: Adding to iommu group 6=

2021-03-16 11:26:49.122 kernel: pci 0000:3a:00.0: Adding to iommu group 7=

2021-03-16 11:26:49.122 kernel: pci 0000:3c:00.0: Adding to iommu group 8=

2021-03-16 11:26:49.122 kernel: DMAR: Intel(R) Virtualization Technology =
for Directed I/O
2021-03-16 11:26:49.122 kernel: PCI-DMA: Using software bounce buffering =
for IO (SWIOTLB)
2021-03-16 11:26:49.122 kernel: software IO TLB: mapped [mem 0x0000000095=
b13000-0x0000000099b13000] (64MB)
2021-03-16 11:26:49.122 kernel: RAPL PMU: API unit is 2^-32 Joules, 5 fix=
ed counters, 655360 ms ovfl timer
2021-03-16 11:26:49.122 kernel: RAPL PMU: hw unit of domain pp0-core 2^-1=
4 Joules
2021-03-16 11:26:49.122 kernel: RAPL PMU: hw unit of domain package 2^-14=
 Joules
2021-03-16 11:26:49.122 kernel: RAPL PMU: hw unit of domain dram 2^-14 Jo=
ules
2021-03-16 11:26:49.122 kernel: RAPL PMU: hw unit of domain pp1-gpu 2^-14=
 Joules
2021-03-16 11:26:49.122 kernel: RAPL PMU: hw unit of domain psys 2^-14 Jo=
ules
2021-03-16 11:26:49.122 kernel: resource sanity check: requesting [mem 0x=
fed10000-0xfed15fff], which spans more than pnp 00:07 [mem 0xfed10000-0xf=
ed13fff]
2021-03-16 11:26:49.122 kernel: caller snb_uncore_imc_init_box+0x7a/0xc0 =
mapping multiple BARs
2021-03-16 11:26:49.122 kernel: check: Scanning for low memory corruption=
 every 60 seconds
2021-03-16 11:26:49.122 kernel: Initialise system trusted keyrings
2021-03-16 11:26:49.122 kernel: workingset: timestamp_bits=3D56 max_order=
=3D23 bucket_order=3D0
2021-03-16 11:26:49.122 kernel: squashfs: version 4.0 (2009/01/31) Philli=
p Lougher
2021-03-16 11:26:49.122 kernel: Key type asymmetric registered
2021-03-16 11:26:49.122 kernel: Asymmetric key parser 'x509' registered
2021-03-16 11:26:49.122 kernel: Block layer SCSI generic (bsg) driver ver=
sion 0.4 loaded (major 249)
2021-03-16 11:26:49.122 kernel: io scheduler mq-deadline registered
2021-03-16 11:26:49.122 kernel: io scheduler kyber registered
2021-03-16 11:26:49.122 kernel: shpchp: Standard Hot Plug PCI Controller =
Driver version: 0.4
2021-03-16 11:26:49.122 kernel: acpiphp_ibm: ibm_acpiphp_init: acpi_walk_=
namespace failed
2021-03-16 11:26:49.122 kernel: efifb: probing for efifb
2021-03-16 11:26:49.122 kernel: efifb: framebuffer at 0xa0000000, using 8=
128k, total 8128k
2021-03-16 11:26:49.122 kernel: efifb: mode is 1920x1080x32, linelength=3D=
7680, pages=3D1
2021-03-16 11:26:49.122 kernel: efifb: scrolling: redraw
2021-03-16 11:26:49.122 kernel: efifb: Truecolor: size=3D8:8:8:8, shift=3D=
24:16:8:0
2021-03-16 11:26:49.122 kernel: Console: switching to colour frame buffer=
 device 240x67
2021-03-16 11:26:49.122 kernel: fb0: EFI VGA frame buffer device
2021-03-16 11:26:49.122 kernel: ACPI: AC: AC Adapter [AC] (on-line)
2021-03-16 11:26:49.122 kernel: input: Sleep Button as /devices/LNXSYSTM:=
00/LNXSYBUS:00/PNP0C0E:00/input/input0
2021-03-16 11:26:49.122 kernel: ACPI: button: Sleep Button [SLPB]
2021-03-16 11:26:49.122 kernel: input: Lid Switch as /devices/LNXSYSTM:00=
/LNXSYBUS:00/PNP0C0D:00/input/input1
2021-03-16 11:26:49.122 kernel: ACPI: button: Lid Switch [LID]
2021-03-16 11:26:49.122 kernel: input: Power Button as /devices/LNXSYSTM:=
00/LNXPWRBN:00/input/input2
2021-03-16 11:26:49.122 kernel: ACPI: button: Power Button [PWRF]
2021-03-16 11:26:49.122 kernel: smpboot: Estimated ratio of average max f=
requency by base frequency (times 1024): 1235
2021-03-16 11:26:49.122 kernel: thermal LNXTHERM:00: registered as therma=
l_zone0
2021-03-16 11:26:49.122 kernel: ACPI: thermal: Thermal Zone [THM0] (47 C)=

2021-03-16 11:26:49.123 kernel: Serial: 8250/16550 driver, 4 ports, IRQ s=
haring disabled
2021-03-16 11:26:49.123 kernel: serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4=
, base_baud =3D 115200) is a 16550A
2021-03-16 11:26:49.123 kernel: Non-volatile memory driver v1.3
2021-03-16 11:26:49.123 kernel: Linux agpgart interface v0.103
2021-03-16 11:26:49.123 kernel: i915 0000:00:02.0: enabling device (0006 =
-> 0007)
2021-03-16 11:26:49.123 kernel: checking generic (a0000000 7f0000) vs hw =
(eb000000 1000000)
2021-03-16 11:26:49.123 kernel: checking generic (a0000000 7f0000) vs hw =
(a0000000 10000000)
2021-03-16 11:26:49.123 kernel: fb0: switching to inteldrmfb from EFI VGA=

2021-03-16 11:26:49.123 kernel: Console: switching to colour dummy device=
 80x25
2021-03-16 11:26:49.123 kernel: i915 0000:00:02.0: [drm] Finished loading=
 DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
2021-03-16 11:26:49.123 kernel: ACPI: battery: Slot [BAT0] (battery prese=
nt)
2021-03-16 11:26:49.123 kernel: random: fast init done
2021-03-16 11:26:49.123 kernel: ACPI: battery: Slot [BAT1] (battery prese=
nt)
2021-03-16 11:26:49.123 kernel: [drm] Initialized i915 1.6.0 20201103 for=
 0000:00:02.0 on minor 0
2021-03-16 11:26:49.123 kernel: ACPI: video: Video Device [GFX0] (multi-h=
ead: yes  rom: no  post: no)
2021-03-16 11:26:49.123 kernel: input: Video Bus as /devices/LNXSYSTM:00/=
LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
2021-03-16 11:26:49.123 kernel: loop: module loaded
2021-03-16 11:26:49.123 kernel: nvme nvme0: pci function 0000:3c:00.0
2021-03-16 11:26:49.123 kernel: tun: Universal TUN/TAP device driver, 1.6=

2021-03-16 11:26:49.123 kernel: e100: Intel(R) PRO/100 Network Driver
2021-03-16 11:26:49.123 kernel: e100: Copyright(c) 1999-2006 Intel Corpor=
ation
2021-03-16 11:26:49.123 kernel: e1000: Intel(R) PRO/1000 Network Driver
2021-03-16 11:26:49.123 kernel: e1000: Copyright (c) 1999-2006 Intel Corp=
oration.
2021-03-16 11:26:49.123 kernel: e1000e: Intel(R) PRO/1000 Network Driver
2021-03-16 11:26:49.123 kernel: e1000e: Copyright(c) 1999 - 2015 Intel Co=
rporation.
2021-03-16 11:26:49.123 kernel: e1000e 0000:00:1f.6: Interrupt Throttling=
 Rate (ints/sec) set to dynamic conservative mode
2021-03-16 11:26:49.123 kernel: nvme nvme0: 4/0/0 default/read/poll queue=
s
2021-03-16 11:26:49.123 kernel:  nvme0n1: p3 p4 < p5 >
2021-03-16 11:26:49.123 kernel: fbcon: i915drmfb (fb0) is primary device
2021-03-16 11:26:49.123 kernel: e1000e 0000:00:1f.6 0000:00:1f.6 (uniniti=
alized): registered PHC clock
2021-03-16 11:26:49.123 kernel: e1000e 0000:00:1f.6 eth0: (PCI Express:2.=
5GT/s:Width x1) 54:e1:ad:0c:2e:01
2021-03-16 11:26:49.123 kernel: e1000e 0000:00:1f.6 eth0: Intel(R) PRO/10=
00 Network Connection
2021-03-16 11:26:49.123 kernel: e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 1=
2, PBA No: 1000FF-0FF
2021-03-16 11:26:49.123 kernel: sky2: driver version 1.30
2021-03-16 11:26:49.123 kernel: Intel(R) Wireless WiFi driver for Linux
2021-03-16 11:26:49.123 kernel: iwlwifi 0000:3a:00.0: enabling device (00=
00 -> 0002)
2021-03-16 11:26:49.124 kernel: iwlwifi 0000:3a:00.0: Found debug destina=
tion: EXTERNAL_DRAM
2021-03-16 11:26:49.124 kernel: iwlwifi 0000:3a:00.0: Found debug configu=
ration: 0
2021-03-16 11:26:49.124 kernel: iwlwifi 0000:3a:00.0: loaded firmware ver=
sion 36.79ff3ccf.0 8265-36.ucode op_mode iwlmvm
2021-03-16 11:26:49.124 kernel: iwlwifi 0000:3a:00.0: Detected Intel(R) D=
ual Band Wireless AC 8265, REV=3D0x230
2021-03-16 11:26:49.124 kernel: modprobe (90) used greatest stack depth: =
14296 bytes left
2021-03-16 11:26:49.124 kernel: thermal thermal_zone1: failed to read out=
 thermal zone (-61)
2021-03-16 11:26:49.124 kernel: iwlwifi 0000:3a:00.0: Applying debug dest=
ination EXTERNAL_DRAM
2021-03-16 11:26:49.124 kernel: iwlwifi 0000:3a:00.0: Allocated 0x0040000=
0 bytes for firmware monitor.
2021-03-16 11:26:49.124 kernel: iwlwifi 0000:3a:00.0: base HW address: 00=
:28:f8:84:36:40
2021-03-16 11:26:49.124 kernel: ieee80211 phy0: Selected rate control alg=
orithm 'iwl-mvm-rs'
2021-03-16 11:26:49.124 kernel: usbcore: registered new interface driver =
r8152
2021-03-16 11:26:49.124 kernel: usbcore: registered new interface driver =
asix
2021-03-16 11:26:49.124 kernel: usbcore: registered new interface driver =
ax88179_178a
2021-03-16 11:26:49.124 kernel: usbcore: registered new interface driver =
cdc_ether
2021-03-16 11:26:49.124 kernel: usbcore: registered new interface driver =
net1080
2021-03-16 11:26:49.124 kernel: usbcore: registered new interface driver =
zaurus
2021-03-16 11:26:49.124 kernel: usbcore: registered new interface driver =
cdc_ncm
2021-03-16 11:26:49.124 kernel: usbcore: registered new interface driver =
qmi_wwan
2021-03-16 11:26:49.124 kernel: usbcore: registered new interface driver =
cdc_mbim
2021-03-16 11:26:49.124 kernel: ehci_hcd: USB 2.0 'Enhanced' Host Control=
ler (EHCI) Driver
2021-03-16 11:26:49.124 kernel: ehci-pci: EHCI PCI platform driver
2021-03-16 11:26:49.124 kernel: ohci_hcd: USB 1.1 'Open' Host Controller =
(OHCI) Driver
2021-03-16 11:26:49.124 kernel: ohci-pci: OHCI PCI platform driver
2021-03-16 11:26:49.124 kernel: uhci_hcd: USB Universal Host Controller I=
nterface driver
2021-03-16 11:26:49.124 kernel: xhci_hcd 0000:00:14.0: xHCI Host Controll=
er
2021-03-16 11:26:49.125 kernel: xhci_hcd 0000:00:14.0: new USB bus regist=
ered, assigned bus number 1
2021-03-16 11:26:49.125 kernel: xhci_hcd 0000:00:14.0: hcc params 0x20007=
7c1 hci version 0x100 quirks 0x0000000081109810
2021-03-16 11:26:49.125 kernel: usb usb1: New USB device found, idVendor=3D=
1d6b, idProduct=3D0002, bcdDevice=3D 5.12
2021-03-16 11:26:49.125 kernel: usb usb1: New USB device strings: Mfr=3D3=
, Product=3D2, SerialNumber=3D1
2021-03-16 11:26:49.125 kernel: usb usb1: Product: xHCI Host Controller
2021-03-16 11:26:49.125 kernel: usb usb1: Manufacturer: Linux 5.12.0-deve=
l+ xhci-hcd
2021-03-16 11:26:49.125 kernel: usb usb1: SerialNumber: 0000:00:14.0
2021-03-16 11:26:49.125 kernel: hub 1-0:1.0: USB hub found
2021-03-16 11:26:49.125 kernel: hub 1-0:1.0: 12 ports detected
2021-03-16 11:26:49.125 kernel: xhci_hcd 0000:00:14.0: xHCI Host Controll=
er
2021-03-16 11:26:49.125 kernel: xhci_hcd 0000:00:14.0: new USB bus regist=
ered, assigned bus number 2
2021-03-16 11:26:49.125 kernel: xhci_hcd 0000:00:14.0: Host supports USB =
3.0 SuperSpeed
2021-03-16 11:26:49.126 kernel: usb usb2: New USB device found, idVendor=3D=
1d6b, idProduct=3D0003, bcdDevice=3D 5.12
2021-03-16 11:26:49.126 kernel: usb usb2: New USB device strings: Mfr=3D3=
, Product=3D2, SerialNumber=3D1
2021-03-16 11:26:49.126 kernel: usb usb2: Product: xHCI Host Controller
2021-03-16 11:26:49.126 kernel: usb usb2: Manufacturer: Linux 5.12.0-deve=
l+ xhci-hcd
2021-03-16 11:26:49.126 kernel: usb usb2: SerialNumber: 0000:00:14.0
2021-03-16 11:26:49.126 kernel: hub 2-0:1.0: USB hub found
2021-03-16 11:26:49.126 kernel: hub 2-0:1.0: 6 ports detected
2021-03-16 11:26:49.126 kernel: usb: port power management may be unrelia=
ble
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
cdc_acm
2021-03-16 11:26:49.126 kernel: cdc_acm: USB Abstract Control Model drive=
r for USB modems and ISDN adapters
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
usblp
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
cdc_wdm
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
uas
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
usb-storage
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
ums-datafab
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
ums-freecom
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
ums-isd200
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
ums-jumpshot
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
ums-sddr09
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
ums-sddr55
2021-03-16 11:26:49.126 kernel: usbcore: registered new interface driver =
ums-usbat
2021-03-16 11:26:49.126 kernel: usb 1-1: new full-speed USB device number=
 2 using xhci_hcd
2021-03-16 11:26:49.126 kernel: usb 1-1: New USB device found, idVendor=3D=
076b, idProduct=3D3021, bcdDevice=3D 3.02
2021-03-16 11:26:49.126 kernel: usb 1-1: New USB device strings: Mfr=3D1,=
 Product=3D2, SerialNumber=3D0
2021-03-16 11:26:49.126 kernel: usb 1-1: Product: Smart Card Reader USB
2021-03-16 11:26:49.127 kernel: usb 1-1: Manufacturer: OMNIKEY AG
2021-03-16 11:26:49.127 kernel: tsc: Refined TSC clocksource calibration:=
 2903.987 MHz
2021-03-16 11:26:49.127 kernel: clocksource: tsc: mask: 0xfffffffffffffff=
f max_cycles: 0x29dbf97d6fc, max_idle_ns: 440795270090 ns
2021-03-16 11:26:49.127 kernel: clocksource: Switched to clocksource tsc
2021-03-16 11:26:49.127 kernel: usb 2-3: new SuperSpeed Gen 1 USB device =
number 2 using xhci_hcd
2021-03-16 11:26:49.127 kernel: usb 2-3: New USB device found, idVendor=3D=
0bda, idProduct=3D0316, bcdDevice=3D 2.04
2021-03-16 11:26:49.127 kernel: usb 2-3: New USB device strings: Mfr=3D1,=
 Product=3D2, SerialNumber=3D3
2021-03-16 11:26:49.127 kernel: usb 2-3: Product: USB3.0-CRW
2021-03-16 11:26:49.127 kernel: usb 2-3: Manufacturer: Generic
2021-03-16 11:26:49.127 kernel: usb 2-3: SerialNumber: 20120501030900000
2021-03-16 11:26:49.127 kernel: usb-storage 2-3:1.0: USB Mass Storage dev=
ice detected
2021-03-16 11:26:49.127 kernel: scsi host0: usb-storage 2-3:1.0
2021-03-16 11:26:49.127 kernel: usb 1-4: new high-speed USB device number=
 3 using xhci_hcd
2021-03-16 11:26:49.127 kernel: usb 1-4: New USB device found, idVendor=3D=
8564, idProduct=3D1000, bcdDevice=3D10.75
2021-03-16 11:26:49.128 kernel: usb 1-4: New USB device strings: Mfr=3D1,=
 Product=3D2, SerialNumber=3D3
2021-03-16 11:26:49.128 kernel: usb 1-4: Product: Mass Storage Device
2021-03-16 11:26:49.128 kernel: usb 1-4: Manufacturer: JetFlash
2021-03-16 11:26:49.128 kernel: usb 1-4: SerialNumber: 3395704885
2021-03-16 11:26:49.128 kernel: usb-storage 1-4:1.0: USB Mass Storage dev=
ice detected
2021-03-16 11:26:49.128 kernel: scsi host1: usb-storage 1-4:1.0
2021-03-16 11:26:49.128 kernel: Console: switching to colour frame buffer=
 device 240x67
2021-03-16 11:26:49.128 kernel: i915 0000:00:02.0: [drm] fb0: i915drmfb f=
rame buffer device
2021-03-16 11:26:49.128 kernel: usb 1-5: new full-speed USB device number=
 4 using xhci_hcd
2021-03-16 11:26:49.128 kernel: usb 1-5: New USB device found, idVendor=3D=
058f, idProduct=3D9540, bcdDevice=3D 1.20
2021-03-16 11:26:49.128 kernel: usb 1-5: New USB device strings: Mfr=3D1,=
 Product=3D2, SerialNumber=3D0
2021-03-16 11:26:49.128 kernel: usb 1-5: Product: EMV Smartcard Reader
2021-03-16 11:26:49.128 kernel: usb 1-5: Manufacturer: Generic
2021-03-16 11:26:49.129 kernel: i8042: PNP: PS/2 Controller [PNP0303:KBD,=
PNP0f13:MOU] at 0x60,0x64 irq 1,12
2021-03-16 11:26:49.129 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
2021-03-16 11:26:49.129 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12=

2021-03-16 11:26:49.129 kernel: mousedev: PS/2 mouse device common for al=
l mice
2021-03-16 11:26:49.129 kernel: rtc_cmos 00:03: RTC can wake from S4
2021-03-16 11:26:49.129 kernel: rtc_cmos 00:03: registered as rtc0
2021-03-16 11:26:49.129 kernel: rtc_cmos 00:03: alarms up to one month, y=
3k, 242 bytes nvram, hpet irqs
2021-03-16 11:26:49.129 kernel: i801_smbus 0000:00:1f.4: enabling device =
(0000 -> 0003)
2021-03-16 11:26:49.129 kernel: input: AT Translated Set 2 keyboard as /d=
evices/platform/i8042/serio0/input/input4
2021-03-16 11:26:49.129 kernel: i801_smbus 0000:00:1f.4: SPD Write Disabl=
e is set
2021-03-16 11:26:49.129 kernel: i801_smbus 0000:00:1f.4: SMBus using PCI =
interrupt
2021-03-16 11:26:49.129 kernel: i2c i2c-6: 2/2 memory slots populated (fr=
om DMI)
2021-03-16 11:26:49.129 kernel: i2c i2c-6: Successfully instantiated SPD =
at 0x51
2021-03-16 11:26:49.129 kernel: intel_pstate: Intel P-state driver initia=
lizing
2021-03-16 11:26:49.129 kernel: intel_pstate: HWP enabled
2021-03-16 11:26:49.129 kernel: EFI Variables Facility v0.08 2004-May-17
2021-03-16 11:26:49.129 kernel: usb 1-6: new high-speed USB device number=
 5 using xhci_hcd
2021-03-16 11:26:49.129 kernel: hid: raw HID events driver (C) Jiri Kosin=
a
2021-03-16 11:26:49.129 kernel: usbcore: registered new interface driver =
usbhid
2021-03-16 11:26:49.129 kernel: usbhid: USB HID core driver
2021-03-16 11:26:49.129 kernel: fujitsu_laptop: driver 0.6.0 successfully=
 loaded
2021-03-16 11:26:49.129 kernel: thinkpad_acpi: ThinkPad ACPI Extras v0.26=

2021-03-16 11:26:49.129 kernel: thinkpad_acpi: http://ibm-acpi.sf.net/
2021-03-16 11:26:49.129 kernel: thinkpad_acpi: ThinkPad BIOS N1WET46S (1.=
25s ), EC N1WHT37W
2021-03-16 11:26:49.129 kernel: thinkpad_acpi: Lenovo ThinkPad T470s, mod=
el 20HGS0TW00
2021-03-16 11:26:49.129 kernel: thinkpad_acpi: radio switch found; radios=
 are enabled
2021-03-16 11:26:49.129 kernel: thinkpad_acpi: This ThinkPad has standard=
 ACPI backlight brightness control, supported by the ACPI video driver
2021-03-16 11:26:49.129 kernel: thinkpad_acpi: Disabling thinkpad-acpi br=
ightness events by default...
2021-03-16 11:26:49.129 kernel: thinkpad_acpi: rfkill switch tpacpi_bluet=
ooth_sw: radio is unblocked
2021-03-16 11:26:49.129 kernel: thinkpad_acpi: rfkill switch tpacpi_wwan_=
sw: radio is unblocked
2021-03-16 11:26:49.129 kernel: thinkpad_acpi: battery 2 registered (star=
t 0, stop 100)
2021-03-16 11:26:49.129 kernel: thinkpad_acpi: battery 1 registered (star=
t 0, stop 100)
2021-03-16 11:26:49.129 kernel: ACPI: battery: new extension: ThinkPad Ba=
ttery Extension
2021-03-16 11:26:49.129 kernel: input: ThinkPad Extra Buttons as /devices=
/platform/thinkpad_acpi/input/input7
2021-03-16 11:26:49.129 kernel: intel_rapl_common: Found RAPL domain pack=
age
2021-03-16 11:26:49.129 kernel: intel_rapl_common: Found RAPL domain core=

2021-03-16 11:26:49.129 kernel: intel_rapl_common: Found RAPL domain unco=
re
2021-03-16 11:26:49.129 kernel: intel_rapl_common: Found RAPL domain dram=

2021-03-16 11:26:49.129 kernel: intel_rapl_common: Found RAPL domain psys=

2021-03-16 11:26:49.129 kernel: snd_hda_intel 0000:00:1f.3: bound 0000:00=
:02.0 (ops i915_audio_component_bind_ops)
2021-03-16 11:26:49.129 kernel: usbcore: registered new interface driver =
snd-usb-audio
2021-03-16 11:26:49.129 kernel: IPv4 over IPsec tunneling driver
2021-03-16 11:26:49.129 kernel: Initializing XFRM netlink socket
2021-03-16 11:26:49.129 kernel: NET: Registered protocol family 10
2021-03-16 11:26:49.129 kernel: Segment Routing with IPv6
2021-03-16 11:26:49.130 kernel: sit: IPv6, IPv4 and MPLS over IPv4 tunnel=
ing driver
2021-03-16 11:26:49.130 kernel: NET: Registered protocol family 17
2021-03-16 11:26:49.130 kernel: NET: Registered protocol family 15
2021-03-16 11:26:49.130 kernel: microcode: sig=3D0x806e9, pf=3D0x80, revi=
sion=3D0xd6
2021-03-16 11:26:49.130 kernel: microcode: Microcode Update Driver: v2.2.=

2021-03-16 11:26:49.130 kernel: IPI shorthand broadcast: enabled
2021-03-16 11:26:49.130 kernel: sched_clock: Marking stable (6184699424, =
3641913)->(6193782581, -5441244)
2021-03-16 11:26:49.130 kernel: Loading compiled-in X.509 certificates
2021-03-16 11:26:49.130 kernel: Loaded X.509 cert 'Build time autogenerat=
ed kernel key: 02ec95c049f756b3c6a9587fe4b63a0778948acb'
2021-03-16 11:26:49.130 kernel: pstore: Using crash dump compression: def=
late
2021-03-16 11:26:49.130 kernel: PM:   Magic number: 13:722:428
2021-03-16 11:26:49.130 kernel: acpi LEN006C:00: hash matches
2021-03-16 11:26:49.130 kernel: cfg80211: Loading compiled-in X.509 certi=
ficates for regulatory database
2021-03-16 11:26:49.130 kernel: cfg80211: Loaded X.509 cert 'sforshee: 00=
b28ddf47aef9cea7'
2021-03-16 11:26:49.130 kernel: ALSA device list:
2021-03-16 11:26:49.130 kernel:   No soundcards found.
2021-03-16 11:26:49.130 kernel: Freeing unused kernel image (initmem) mem=
ory: 1600K
2021-03-16 11:26:49.130 kernel: Write protecting the kernel read-only dat=
a: 24576k
2021-03-16 11:26:49.130 kernel: Freeing unused kernel image (text/rodata =
gap) memory: 2032K
2021-03-16 11:26:49.130 kernel: Freeing unused kernel image (rodata/data =
gap) memory: 160K
2021-03-16 11:26:49.130 kernel: Run /init as init process
2021-03-16 11:26:49.130 kernel:   with arguments:
2021-03-16 11:26:49.130 kernel:     /init
2021-03-16 11:26:49.130 kernel:     sina_toram
2021-03-16 11:26:49.130 kernel:   with environment:
2021-03-16 11:26:49.130 kernel:     HOME=3D/
2021-03-16 11:26:49.130 kernel:     TERM=3Dlinux
2021-03-16 11:26:49.130 kernel:     BOOT_IMAGE=3D/isolinux/bzImage
2021-03-16 11:26:49.130 kernel:     intel_iommu=3Don,igfx_off
2021-03-16 11:26:49.130 kernel: snd_hda_codec_realtek hdaudioC0D0: autoco=
nfig for ALC298: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
2021-03-16 11:26:49.130 kernel: snd_hda_codec_realtek hdaudioC0D0:    spe=
aker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
2021-03-16 11:26:49.130 kernel: snd_hda_codec_realtek hdaudioC0D0:    hp_=
outs=3D2 (0x17/0x21/0x0/0x0/0x0)
2021-03-16 11:26:49.130 kernel: snd_hda_codec_realtek hdaudioC0D0:    mon=
o: mono_out=3D0x0
2021-03-16 11:26:49.130 kernel: snd_hda_codec_realtek hdaudioC0D0:    inp=
uts:
2021-03-16 11:26:49.130 kernel: snd_hda_codec_realtek hdaudioC0D0:      M=
ic=3D0x18
2021-03-16 11:26:49.130 kernel: snd_hda_codec_realtek hdaudioC0D0:      D=
ock Mic=3D0x19
2021-03-16 11:26:49.130 kernel: snd_hda_codec_realtek hdaudioC0D0:      I=
nternal Mic=3D0x12
2021-03-16 11:26:49.130 kernel: usb 1-6: config 1 has an invalid interfac=
e number: 12 but max is 1
2021-03-16 11:26:49.131 kernel: usb 1-6: config 1 has an invalid interfac=
e number: 13 but max is 1
2021-03-16 11:26:49.131 kernel: usb 1-6: config 1 has an invalid interfac=
e number: 13 but max is 1
2021-03-16 11:26:49.131 kernel: usb 1-6: config 1 has no interface number=
 0
2021-03-16 11:26:49.131 kernel: usb 1-6: config 1 has no interface number=
 1
2021-03-16 11:26:49.131 kernel: usb 1-6: New USB device found, idVendor=3D=
1199, idProduct=3D9079, bcdDevice=3D 0.06
2021-03-16 11:26:49.131 kernel: usb 1-6: New USB device strings: Mfr=3D1,=
 Product=3D2, SerialNumber=3D3
2021-03-16 11:26:49.131 kernel: usb 1-6: Product: Sierra Wireless EM7455 =
Qualcomm Snapdragon X7 LTE-A
2021-03-16 11:26:49.131 kernel: usb 1-6: Manufacturer: Sierra Wireless, I=
ncorporated
2021-03-16 11:26:49.131 kernel: usb 1-6: SerialNumber: LF71027892011020
2021-03-16 11:26:49.131 kernel: input: HDA Intel PCH Mic as /devices/pci0=
000:00/0000:00:1f.3/sound/card0/input8
2021-03-16 11:26:49.131 kernel: input: HDA Intel PCH Dock Mic as /devices=
/pci0000:00/0000:00:1f.3/sound/card0/input9
2021-03-16 11:26:49.131 kernel: input: HDA Intel PCH Dock Headphone as /d=
evices/pci0000:00/0000:00:1f.3/sound/card0/input10
2021-03-16 11:26:49.131 kernel: input: HDA Intel PCH Headphone as /device=
s/pci0000:00/0000:00:1f.3/sound/card0/input11
2021-03-16 11:26:49.131 kernel: input: HDA Intel PCH HDMI/DP,pcm=3D3 as /=
devices/pci0000:00/0000:00:1f.3/sound/card0/input12
2021-03-16 11:26:49.131 kernel: input: HDA Intel PCH HDMI/DP,pcm=3D7 as /=
devices/pci0000:00/0000:00:1f.3/sound/card0/input13
2021-03-16 11:26:49.131 kernel: input: HDA Intel PCH HDMI/DP,pcm=3D8 as /=
devices/pci0000:00/0000:00:1f.3/sound/card0/input14
2021-03-16 11:26:49.131 kernel: input: HDA Intel PCH HDMI/DP,pcm=3D9 as /=
devices/pci0000:00/0000:00:1f.3/sound/card0/input15
2021-03-16 11:26:49.131 kernel: input: HDA Intel PCH HDMI/DP,pcm=3D10 as =
/devices/pci0000:00/0000:00:1f.3/sound/card0/input16
2021-03-16 11:26:49.131 kernel: cdc_mbim 1-6:1.12: cdc-wdm0: USB WDM devi=
ce
2021-03-16 11:26:49.132 kernel: cdc_mbim 1-6:1.12 wwan0: register 'cdc_mb=
im' at usb-0000:00:14.0-6, CDC MBIM, 5e:dd:66:22:8f:01
2021-03-16 11:26:49.132 kernel: usb 1-7: new full-speed USB device number=
 6 using xhci_hcd
2021-03-16 11:26:49.132 kernel: ucsi_acpi USBC000:00: con1: failed to get=
 usb role switch
2021-03-16 11:26:49.132 kernel: usb 1-7: New USB device found, idVendor=3D=
8087, idProduct=3D0a2b, bcdDevice=3D 0.10
2021-03-16 11:26:49.132 kernel: usb 1-7: New USB device strings: Mfr=3D0,=
 Product=3D0, SerialNumber=3D0
2021-03-16 11:26:49.132 kernel: scsi 0:0:0:0: Direct-Access     Generic- =
SD/MMC           1.00 PQ: 0 ANSI: 6
2021-03-16 11:26:49.132 kernel: sd 0:0:0:0: [sda] Attached SCSI removable=
 disk
2021-03-16 11:26:49.132 kernel: usb 1-8: new high-speed USB device number=
 7 using xhci_hcd
2021-03-16 11:26:49.132 kernel: random: plymouthd: uninitialized urandom =
read (8 bytes read)
2021-03-16 11:26:49.132 kernel: random: plymouthd: uninitialized urandom =
read (8 bytes read)
2021-03-16 11:26:49.132 kernel: random: plymouthd: uninitialized urandom =
read (8 bytes read)
2021-03-16 11:26:49.132 kernel: scsi 1:0:0:0: Direct-Access     JetFlash =
Transcend 64GB   1.00 PQ: 0 ANSI: 6
2021-03-16 11:26:49.132 kernel: sd 1:0:0:0: [sdb] 123527168 512-byte logi=
cal blocks: (63.2 GB/58.9 GiB)
2021-03-16 11:26:49.133 kernel: sd 1:0:0:0: [sdb] Write Protect is off
2021-03-16 11:26:49.133 kernel: sd 1:0:0:0: [sdb] Mode Sense: 23 00 00 00=

2021-03-16 11:26:49.133 kernel: sd 1:0:0:0: [sdb] Write cache: disabled, =
read cache: disabled, doesn't support DPO or FUA
2021-03-16 11:26:49.133 kernel:  sdb: sdb1
2021-03-16 11:26:49.133 kernel: sd 1:0:0:0: [sdb] Attached SCSI removable=
 disk
2021-03-16 11:26:49.133 kernel: usb 1-8: New USB device found, idVendor=3D=
5986, idProduct=3D111c, bcdDevice=3D37.27
2021-03-16 11:26:49.133 kernel: usb 1-8: New USB device strings: Mfr=3D3,=
 Product=3D1, SerialNumber=3D2
2021-03-16 11:26:49.133 kernel: usb 1-8: Product: Integrated Camera
2021-03-16 11:26:49.133 kernel: usb 1-8: Manufacturer: Bison
2021-03-16 11:26:49.133 kernel: usb 1-8: SerialNumber: 200901010001
2021-03-16 11:26:49.133 kernel: psmouse serio1: synaptics: queried max co=
ordinates: x [..5676], y [..4762]
2021-03-16 11:26:49.133 kernel: psmouse serio1: synaptics: queried min co=
ordinates: x [1266..], y [1094..]
2021-03-16 11:26:49.134 kernel: psmouse serio1: synaptics: Trying to set =
up SMBus access
2021-03-16 11:26:49.134 kernel: rmi4_smbus 6-002c: registering SMbus-conn=
ected sensor
2021-03-16 11:26:49.134 kernel: vgscan (149) used greatest stack depth: 1=
3768 bytes left
2021-03-16 11:26:49.134 kernel: rmi4_f01 rmi4-00.fn01: found RMI device, =
manufacturer: Synaptics, product: TM3145-005, fw id: 2491761
2021-03-16 11:26:49.134 kernel: device-mapper: ioctl: 4.44.0-ioctl (2021-=
02-01) initialised: dm-devel@redhat.com
2021-03-16 11:26:49.134 kernel: dm-0: detected capacity change from 0 to =
2097152
2021-03-16 11:26:49.134 kernel: dm-1: detected capacity change from 0 to =
2097152
2021-03-16 11:26:49.134 kernel: dm-2: detected capacity change from 0 to =
2097152
2021-03-16 11:26:49.134 kernel: dm-3: detected capacity change from 0 to =
2097152
2021-03-16 11:26:49.134 kernel: dm-4: detected capacity change from 0 to =
16384
2021-03-16 11:26:49.134 kernel: dm-5: detected capacity change from 0 to =
24576
2021-03-16 11:26:49.134 kernel: dm-6: detected capacity change from 0 to =
27320320
2021-03-16 11:26:49.134 kernel: dm-7: detected capacity change from 0 to =
188751872
2021-03-16 11:26:49.134 kernel: dm-8: detected capacity change from 0 to =
4333568
2021-03-16 11:26:49.134 kernel: vgchange (150) used greatest stack depth:=
 13648 bytes left
2021-03-16 11:26:49.134 kernel: input: Synaptics TM3145-005 as /devices/r=
mi4-00/input/input17
2021-03-16 11:26:49.134 kernel: serio: RMI4 PS/2 pass-through port at rmi=
4-00.fn03
2021-03-16 11:26:49.134 kernel: psmouse serio2: trackpoint: IBM TrackPoin=
t firmware: 0x0e, buttons: 3/3
2021-03-16 11:26:49.134 kernel: input: TPPS/2 IBM TrackPoint as /devices/=
rmi4-00/rmi4-00.fn03/serio2/input/input18
2021-03-16 11:26:49.134 kernel: random: crng init done
2021-03-16 11:26:49.134 kernel: random: 7 urandom warning(s) missed due t=
o ratelimiting
2021-03-16 11:26:49.134 kernel: udevd (130) used greatest stack depth: 13=
616 bytes left
2021-03-16 11:26:49.134 kernel: sha512sum (162) used greatest stack depth=
: 12864 bytes left
2021-03-16 11:26:49.134 kernel: loop8: detected capacity change from 0 to=
 1523304
2021-03-16 11:26:49.134 kernel: Failed to find module 'autofs4'
2021-03-16 11:26:49.134 kernel: systemd 246-2-gf40a43b running in system =
mode. (-PAM -AUDIT -SELINUX -IMA -APPARMOR -SMACK -SYSVINIT -UTMP -LIBCRY=
PTSETUP -GCRYPT -GNUTLS -ACL -XZ -LZ4 -ZSTD +SECCOMP +BLKID -ELFUTILS +KM=
OD -IDN2 -IDN -PCRE2 default-hierarchy=3Dunified)
2021-03-16 11:26:49.134 kernel: Detected architecture x86-64.
2021-03-16 11:26:49.134 kernel: Running with unpopulated /etc.
2021-03-16 11:26:49.134 kernel: No hostname configured.
2021-03-16 11:26:49.134 kernel: Set hostname to <localhost>.
2021-03-16 11:26:49.134 kernel: Failed to populate /etc with preset unit =
settings, ignoring: File exists
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/systemd-udevd.service=
=2Ed/sina-lsm-label.conf:2: Unknown key name 'LSMProcessLabel' in section=
 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/debugshell.service:17=
: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/syslog.service:16: Un=
known key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/vwnetstatic.service:2=
1: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/failsafe.service:9: U=
nknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/rcd.service:16: Unkno=
wn key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/net-ns-id@.service:10=
: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/wpa-supplicant.servic=
e:16: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/timemachine.service:1=
4: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/radd.service:12: Unkn=
own key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/net-ns-id@.service:10=
: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/logstat.service:13: U=
nknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/ldap-config.service:1=
2: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/hw-inventory-writer.s=
ervice:17: Unknown key name 'LSMProcessLabel' in section 'Service', ignor=
ing.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/adns.service:12: Unkn=
own key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/admin-command.service=
:10: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/vwroutingd.service:13=
: Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: /etc/systemd/system/triggerd.service:17: =
Unknown key name 'LSMProcessLabel' in section 'Service', ignoring.
2021-03-16 11:26:49.134 kernel: Queued start job for default target The S=
INA workstation.
2021-03-16 11:26:49.134 kernel: Created slice system-net\x2dns.slice.
2021-03-16 11:26:49.134 kernel: Created slice system-net\x2dns\x2did.slic=
e.
2021-03-16 11:26:49.134 kernel: Reached target Slices.
2021-03-16 11:26:49.134 kernel: Listening on LVM2 metadata daemon socket.=

2021-03-16 11:26:49.134 kernel: Listening on Process Core Dump Socket.
2021-03-16 11:26:49.134 kernel: Condition check resulted in Journal Audit=
 Socket being skipped.
2021-03-16 11:26:49.134 kernel: Listening on Journal Socket (/dev/log).
2021-03-16 11:26:49.134 kernel: Listening on Journal Socket.
2021-03-16 11:26:49.134 kernel: Listening on udev Control Socket.
2021-03-16 11:26:49.134 kernel: Listening on udev Kernel Socket.
2021-03-16 11:26:49.134 kernel: Mounting System mountpoint (/media)...
2021-03-16 11:26:49.134 kernel: Mounting Container Data Exchange...
2021-03-16 11:26:49.134 kernel: Mounting Dynamic Kernel Debugging...
2021-03-16 11:26:49.134 kernel: Mounting Machines mountpoint...
2021-03-16 11:26:49.134 kernel: Starting Dump bootsplash log...
2021-03-16 11:26:49.134 kernel: Started Debug Shell.
2021-03-16 11:26:49.134 kernel: Reached target Debug Mode.
2021-03-16 11:26:49.134 kernel: Starting Reserves memory for gpt-update..=
=2E
2021-03-16 11:26:49.134 kernel: Starting pstore util...
2021-03-16 11:26:49.134 kernel: Starting Identification of SINA sound car=
d...
2021-03-16 11:26:49.134 kernel: Starting Journal Service...
2021-03-16 11:26:49.134 kernel: Starting Load Kernel Modules...
2021-03-16 11:26:49.134 kernel: Starting Coldplug All udev Devices...
2021-03-16 11:26:49.134 kernel: Starting Rule-based Manager for Device Ev=
ents and Files...
2021-03-16 11:26:49.134 kernel: Starting Setup Virtual Console...
2021-03-16 11:26:49.134 kernel: Finished Identification of SINA sound car=
d.
2021-03-16 11:26:49.134 kernel: cryptoapi_plugger: loading out-of-tree mo=
dule taints kernel.
2021-03-16 11:26:49.134 kernel: chiasmus: module license 'SECUNET' taints=
 kernel.
2021-03-16 11:26:49.134 kernel: Disabling lock debugging due to kernel ta=
int
2021-03-16 11:26:49.134 kernel: pstore-util.service: Succeeded.
2021-03-16 11:26:49.134 kernel: Finished pstore util.
2021-03-16 11:26:49.138 kernel: Started Journal Service.
2021-03-16 11:26:51.232 kernel: Cipher test completed
2021-03-16 11:26:51.307 kernel: vboxdrv: Found 2 processor cores
2021-03-16 11:26:51.330 kernel: vboxdrv: TSC mode is Invariant, tentative=
 frequency 2903987380 Hz
2021-03-16 11:26:51.330 kernel: vboxdrv: Successfully loaded version 6.1.=
18 (interface 0x00300000)
2021-03-16 11:26:51.334 kernel: vtx: Detected Intel cpu
2021-03-16 11:26:51.334 kernel: vtx: HAS_VTX: 1, VTX_ENABLED: 1
2021-03-16 11:26:51.708 kernel: SUPR0GipMap: fGetGipCpu=3D0x1b
2021-03-16 11:26:51.862 kernel: vboxdrv: 00000000875a9154 VMMR0.r0
2021-03-16 11:26:51.882 kernel: vboxdrv: 00000000a209d862 VBoxDDR0.r0
2021-03-16 11:26:53.410 kernel: EXT4-fs (dm-3): mounted filesystem with o=
rdered data mode. Opts: (null). Quota mode: disabled.
2021-03-16 11:27:14.269 kernel: ------------[ cut here ]------------
2021-03-16 11:27:14.269 kernel: RTNL: assertion failed at net/core/dev.c =
(10988)
2021-03-16 11:27:14.269 kernel: WARNING: CPU: 0 PID: 467 at net/core/dev.=
c:10988 dev_change_net_namespace+0x44d/0x480
2021-03-16 11:27:14.269 kernel: Modules linked in: vtx(O) vboxdrv(O) waco=
m dm_crypt_sina(O) chiasmus(PO) cryptoapi_plugger(O) dm_mod
2021-03-16 11:27:14.269 kernel: CPU: 0 PID: 467 Comm: iw Tainted: P      =
     O      5.12.0-devel+ #1
2021-03-16 11:27:14.269 kernel: Hardware name: LENOVO 20HGS0TW00/20HGS0TW=
00, BIOS N1WET46S (1.25s ) 03/30/2018
2021-03-16 11:27:14.269 kernel: RIP: 0010:dev_change_net_namespace+0x44d/=
0x480
2021-03-16 11:27:14.269 kernel: Code: 16 3a 67 01 00 0f 85 17 fc ff ff ba=
 ec 2a 00 00 48 c7 c6 22 87 72 a5 48 c7 c7 60 77 62 a5 c6 05 f6 39 67 01 =
01 e8 cf 12 28 00 <0f> 0b e9 f1 fb ff ff 0f 0b e9 22 ff ff ff 0f 0b e9 03=
 ff ff ff b8
2021-03-16 11:27:14.269 kernel: RSP: 0018:ffffa09583cc79d0 EFLAGS: 000102=
86
2021-03-16 11:27:14.269 kernel: RAX: 0000000000000000 RBX: ffff9531c02460=
00 RCX: 0000000000000027
2021-03-16 11:27:14.269 kernel: RDX: 0000000000000027 RSI: ffff9537074174=
70 RDI: ffff953707417478
2021-03-16 11:27:14.269 kernel: RBP: ffffffffa5737f99 R08: 00000000000000=
00 R09: c0000000fffeffff
2021-03-16 11:27:14.269 kernel: R10: 0000000000000001 R11: ffffa09583cc77=
f8 R12: ffff9531c0ec6000
2021-03-16 11:27:14.269 kernel: R13: ffff9531c0ec6000 R14: ffffffffa5737f=
99 R15: ffffa09583cc7b40
2021-03-16 11:27:14.269 kernel: FS:  00007fa4eacd8b80(0000) GS:ffff953707=
400000(0000) knlGS:0000000000000000
2021-03-16 11:27:14.269 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
2021-03-16 11:27:14.269 kernel: CR2: 00007ffc813841d8 CR3: 0000000105d940=
03 CR4: 00000000003706f0
2021-03-16 11:27:14.269 kernel: Call Trace:
2021-03-16 11:27:14.269 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:27:14.269 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:27:14.269 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:27:14.269 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:27:14.269 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:27:14.269 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:27:14.269 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:27:14.269 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:27:14.269 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:27:14.269 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:27:14.269 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:27:14.269 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:27:14.269 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:27:14.269 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:27:14.269 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:27:14.269 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:27:14.269 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:27:14.269 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:27:14.269 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:27:14.269 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:27:14.269 kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff=
 ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 69 31 0c 00 8b 00 85 c0 75 13 b8 =
2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55=
 48 89 f5 53
2021-03-16 11:27:14.269 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:27:14.269 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:27:14.269 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:27:14.269 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:27:14.269 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:27:14.269 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:27:14.269 kernel: ---[ end trace 6b632a15496dddf2 ]---
2021-03-16 11:27:14.269 kernel: ------------[ cut here ]------------
2021-03-16 11:27:14.269 kernel: RTNL: assertion failed at net/core/dev.c =
(381)
2021-03-16 11:27:14.269 kernel: WARNING: CPU: 0 PID: 467 at net/core/dev.=
c:381 unlist_netdevice+0xdb/0xf0
2021-03-16 11:27:14.269 kernel: Modules linked in: vtx(O) vboxdrv(O) waco=
m dm_crypt_sina(O) chiasmus(PO) cryptoapi_plugger(O) dm_mod
2021-03-16 11:27:14.269 kernel: CPU: 0 PID: 467 Comm: iw Tainted: P      =
  W  O      5.12.0-devel+ #1
2021-03-16 11:27:14.269 kernel: Hardware name: LENOVO 20HGS0TW00/20HGS0TW=
00, BIOS N1WET46S (1.25s ) 03/30/2018
2021-03-16 11:27:14.269 kernel: RIP: 0010:unlist_netdevice+0xdb/0xf0
2021-03-16 11:27:14.269 kernel: Code: 0d 8d 67 01 00 0f 85 5a ff ff ff ba=
 7d 01 00 00 48 c7 c6 22 87 72 a5 48 c7 c7 60 77 62 a5 c6 05 ed 8c 67 01 =
01 e8 a1 65 28 00 <0f> 0b e9 34 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00=
 0f 1f 00 0f
2021-03-16 11:27:14.269 kernel: RSP: 0018:ffffa09583cc79c0 EFLAGS: 000102=
82
2021-03-16 11:27:14.269 kernel: RAX: 0000000000000000 RBX: ffff9531c02460=
00 RCX: 0000000000000027
2021-03-16 11:27:14.269 kernel: RDX: 0000000000000027 RSI: ffff9537074174=
70 RDI: ffff953707417478
2021-03-16 11:27:14.269 kernel: RBP: ffffffffa5737f99 R08: 00000000000000=
00 R09: c0000000fffeffff
2021-03-16 11:27:14.269 kernel: R10: 0000000000000001 R11: ffffa09583cc77=
e8 R12: ffff9531c0ec6000
2021-03-16 11:27:14.269 kernel: R13: ffff9531c0ec6000 R14: ffffffffa5737f=
99 R15: ffffa09583cc7b40
2021-03-16 11:27:14.269 kernel: FS:  00007fa4eacd8b80(0000) GS:ffff953707=
400000(0000) knlGS:0000000000000000
2021-03-16 11:27:14.269 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
2021-03-16 11:27:14.269 kernel: CR2: 00007ffc813841d8 CR3: 0000000105d940=
03 CR4: 00000000003706f0
2021-03-16 11:27:14.269 kernel: Call Trace:
2021-03-16 11:27:14.269 kernel:  dev_change_net_namespace+0xb7/0x480
2021-03-16 11:27:14.269 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:27:14.269 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:27:14.269 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:27:14.269 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:27:14.269 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:27:14.269 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:27:14.269 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:27:14.269 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:27:14.269 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:27:14.269 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:27:14.269 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:27:14.269 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:27:14.269 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:27:14.269 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:27:14.269 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:27:14.269 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:27:14.269 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:27:14.269 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:27:14.269 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:27:14.269 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:27:14.269 kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff=
 ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 69 31 0c 00 8b 00 85 c0 75 13 b8 =
2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55=
 48 89 f5 53
2021-03-16 11:27:14.269 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:27:14.269 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:27:14.269 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:27:14.269 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:27:14.269 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:27:14.269 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:27:14.269 kernel: ---[ end trace 6b632a15496dddf3 ]---
2021-03-16 11:27:14.275 kernel: ------------[ cut here ]------------
2021-03-16 11:27:14.275 kernel: RTNL: assertion failed at net/core/dev.c =
(2054)
2021-03-16 11:27:14.275 kernel: WARNING: CPU: 0 PID: 467 at net/core/dev.=
c:2054 call_netdevice_notifiers_info+0x7c/0x80
2021-03-16 11:27:14.275 kernel: Modules linked in: vtx(O) vboxdrv(O) waco=
m dm_crypt_sina(O) chiasmus(PO) cryptoapi_plugger(O) dm_mod
2021-03-16 11:27:14.275 kernel: CPU: 0 PID: 467 Comm: iw Tainted: P      =
  W  O      5.12.0-devel+ #1
2021-03-16 11:27:14.275 kernel: Hardware name: LENOVO 20HGS0TW00/20HGS0TW=
00, BIOS N1WET46S (1.25s ) 03/30/2018
2021-03-16 11:27:14.275 kernel: RIP: 0010:call_netdevice_notifiers_info+0=
x7c/0x80
2021-03-16 11:27:14.275 kernel: Code: 68 ff 80 3d 02 72 67 01 00 75 c5 ba=
 06 08 00 00 48 c7 c6 22 87 72 a5 48 c7 c7 60 77 62 a5 c6 05 e6 71 67 01 =
01 e8 a0 4a 28 00 <0f> 0b eb a2 0f 1f 44 00 00 48 83 ec 18 65 48 8b 04 25=
 28 00 00 00
2021-03-16 11:27:14.275 kernel: RSP: 0018:ffffa09583cc79b0 EFLAGS: 000102=
82
2021-03-16 11:27:14.275 kernel: RAX: 0000000000000000 RBX: ffffffffa602cc=
80 RCX: 0000000000000027
2021-03-16 11:27:14.275 kernel: RDX: 0000000000000027 RSI: ffff9537074174=
70 RDI: ffff953707417478
2021-03-16 11:27:14.275 kernel: RBP: ffffa09583cc79f0 R08: 00000000000000=
00 R09: c0000000fffeffff
2021-03-16 11:27:14.275 kernel: R10: 0000000000000001 R11: ffffa09583cc77=
d8 R12: 0000000000000006
2021-03-16 11:27:14.275 kernel: R13: ffff9531c0ec6000 R14: ffffffffa5737f=
99 R15: ffffa09583cc7b40
2021-03-16 11:27:14.275 kernel: FS:  00007fa4eacd8b80(0000) GS:ffff953707=
400000(0000) knlGS:0000000000000000
2021-03-16 11:27:14.275 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
2021-03-16 11:27:14.275 kernel: CR2: 00007f2720ae1000 CR3: 0000000105d940=
03 CR4: 00000000003706f0
2021-03-16 11:27:14.275 kernel: Call Trace:
2021-03-16 11:27:14.275 kernel:  dev_change_net_namespace+0xe1/0x480
2021-03-16 11:27:14.275 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:27:14.275 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:27:14.275 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:27:14.275 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:27:14.275 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:27:14.275 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:27:14.275 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:27:14.275 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:27:14.275 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:27:14.275 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:27:14.275 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:27:14.275 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:27:14.275 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:27:14.275 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:27:14.275 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:27:14.275 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:27:14.275 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:27:14.275 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:27:14.275 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:27:14.275 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:27:14.275 kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff=
 ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 69 31 0c 00 8b 00 85 c0 75 13 b8 =
2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55=
 48 89 f5 53
2021-03-16 11:27:14.275 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:27:14.275 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:27:14.275 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:27:14.275 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:27:14.275 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:27:14.275 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:27:14.275 kernel: ---[ end trace 6b632a15496dddf4 ]---
2021-03-16 11:27:14.275 kernel: ------------[ cut here ]------------
2021-03-16 11:27:14.275 kernel: RTNL: assertion failed at net/core/fib_ru=
les.c (1227)
2021-03-16 11:27:14.275 kernel: WARNING: CPU: 0 PID: 467 at net/core/fib_=
rules.c:1227 fib_rules_event+0x18f/0x1a0
2021-03-16 11:27:14.275 kernel: Modules linked in: vtx(O) vboxdrv(O) waco=
m dm_crypt_sina(O) chiasmus(PO) cryptoapi_plugger(O) dm_mod
2021-03-16 11:27:14.275 kernel: CPU: 0 PID: 467 Comm: iw Tainted: P      =
  W  O      5.12.0-devel+ #1
2021-03-16 11:27:14.275 kernel: Hardware name: LENOVO 20HGS0TW00/20HGS0TW=
00, BIOS N1WET46S (1.25s ) 03/30/2018
2021-03-16 11:27:14.275 kernel: RIP: 0010:fib_rules_event+0x18f/0x1a0
2021-03-16 11:27:14.275 kernel: Code: 61 f6 63 01 00 0f 85 b3 fe ff ff ba=
 cb 04 00 00 48 c7 c6 b9 a3 72 a5 48 c7 c7 60 77 62 a5 c6 05 41 f6 63 01 =
01 e8 dd ce 24 00 <0f> 0b e9 8d fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f=
 1f 44 00 00
2021-03-16 11:27:14.275 kernel: RSP: 0018:ffffa09583cc7988 EFLAGS: 000102=
82
2021-03-16 11:27:14.275 kernel: RAX: 0000000000000000 RBX: ffff9531c02460=
00 RCX: 0000000000000027
2021-03-16 11:27:14.275 kernel: RDX: 0000000000000027 RSI: ffff9537074174=
70 RDI: ffff953707417478
2021-03-16 11:27:14.275 kernel: RBP: ffffffffa602cc80 R08: 00000000000000=
00 R09: c0000000fffeffff
2021-03-16 11:27:14.275 kernel: R10: 0000000000000001 R11: ffffa09583cc77=
b0 R12: 0000000000000006
2021-03-16 11:27:14.275 kernel: R13: ffffa09583cc79f0 R14: ffffffffa5737f=
99 R15: ffffa09583cc7b40
2021-03-16 11:27:14.275 kernel: FS:  00007fa4eacd8b80(0000) GS:ffff953707=
400000(0000) knlGS:0000000000000000
2021-03-16 11:27:14.275 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
2021-03-16 11:27:14.275 kernel: CR2: 00007f2720ae1000 CR3: 0000000105d940=
03 CR4: 00000000003706f0
2021-03-16 11:27:14.275 kernel: Call Trace:
2021-03-16 11:27:14.275 kernel:  raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.275 kernel:  dev_change_net_namespace+0xe1/0x480
2021-03-16 11:27:14.275 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:27:14.275 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:27:14.275 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:27:14.275 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:27:14.275 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:27:14.275 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:27:14.275 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:27:14.275 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:27:14.275 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:27:14.275 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:27:14.275 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:27:14.275 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:27:14.275 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:27:14.275 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:27:14.275 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:27:14.275 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:27:14.275 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:27:14.275 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:27:14.275 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:27:14.275 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:27:14.275 kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff=
 ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 69 31 0c 00 8b 00 85 c0 75 13 b8 =
2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55=
 48 89 f5 53
2021-03-16 11:27:14.275 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:27:14.275 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:27:14.275 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:27:14.275 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:27:14.275 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:27:14.275 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:27:14.275 kernel: ---[ end trace 6b632a15496dddf5 ]---
2021-03-16 11:27:14.275 kernel: ------------[ cut here ]------------
2021-03-16 11:27:14.275 kernel: RTNL: assertion failed at net/ipv4/devine=
t.c (1526)
2021-03-16 11:27:14.275 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/devi=
net.c:1526 inetdev_event+0x39f/0x5c0
2021-03-16 11:27:14.275 kernel: Modules linked in: vtx(O) vboxdrv(O) waco=
m dm_crypt_sina(O) chiasmus(PO) cryptoapi_plugger(O) dm_mod
2021-03-16 11:27:14.275 kernel: CPU: 0 PID: 467 Comm: iw Tainted: P      =
  W  O      5.12.0-devel+ #1
2021-03-16 11:27:14.275 kernel: Hardware name: LENOVO 20HGS0TW00/20HGS0TW=
00, BIOS N1WET46S (1.25s ) 03/30/2018
2021-03-16 11:27:14.275 kernel: RIP: 0010:inetdev_event+0x39f/0x5c0
2021-03-16 11:27:14.275 kernel: Code: ea 6c 58 01 00 0f 85 ce fc ff ff ba=
 f6 05 00 00 48 c7 c6 37 0c 73 a5 48 c7 c7 60 77 62 a5 c6 05 ca 6c 58 01 =
01 e8 3d 45 19 00 <0f> 0b e9 a8 fc ff ff 4c 89 ef e8 b2 fa ff ff 48 89 c1=
 48 3d 00 f0
2021-03-16 11:27:14.275 kernel: RSP: 0018:ffffa09583cc7940 EFLAGS: 000102=
86
2021-03-16 11:27:14.275 kernel: RAX: 0000000000000000 RBX: 00000000000000=
06 RCX: 0000000000000027
2021-03-16 11:27:14.275 kernel: RDX: 0000000000000027 RSI: ffff9537074174=
70 RDI: ffff953707417478
2021-03-16 11:27:14.275 kernel: RBP: ffffa09583cc7990 R08: 00000000000000=
00 R09: c0000000fffeffff
2021-03-16 11:27:14.275 kernel: R10: 0000000000000001 R11: ffffa09583cc77=
68 R12: ffff9531cb58c600
2021-03-16 11:27:14.275 kernel: R13: ffff9531c0246000 R14: ffffffffa5737f=
99 R15: ffffa09583cc7b40
2021-03-16 11:27:14.275 kernel: FS:  00007fa4eacd8b80(0000) GS:ffff953707=
400000(0000) knlGS:0000000000000000
2021-03-16 11:27:14.276 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
2021-03-16 11:27:14.276 kernel: CR2: 00007f2720ae1000 CR3: 0000000105d940=
03 CR4: 00000000003706f0
2021-03-16 11:27:14.276 kernel: Call Trace:
2021-03-16 11:27:14.276 kernel:  ? trace_hardirqs_on+0x2a/0xb0
2021-03-16 11:27:14.276 kernel:  ? raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.276 kernel:  raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.276 kernel:  dev_change_net_namespace+0xe1/0x480
2021-03-16 11:27:14.276 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:27:14.276 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:27:14.276 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:27:14.276 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:27:14.276 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:27:14.276 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:27:14.276 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:27:14.276 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:27:14.276 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:27:14.276 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:27:14.276 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:27:14.276 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:27:14.276 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:27:14.276 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:27:14.276 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:27:14.276 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:27:14.276 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:27:14.276 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:27:14.276 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:27:14.276 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:27:14.276 kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff=
 ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 69 31 0c 00 8b 00 85 c0 75 13 b8 =
2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55=
 48 89 f5 53
2021-03-16 11:27:14.276 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:27:14.276 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:27:14.276 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:27:14.276 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:27:14.276 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:27:14.276 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:27:14.276 kernel: ---[ end trace 6b632a15496dddf6 ]---
2021-03-16 11:27:14.276 kernel: ------------[ cut here ]------------
2021-03-16 11:27:14.276 kernel: RTNL: assertion failed at net/ipv4/devine=
t.c (309)
2021-03-16 11:27:14.276 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/devi=
net.c:309 inetdev_event+0x4a9/0x5c0
2021-03-16 11:27:14.276 kernel: Modules linked in: vtx(O) vboxdrv(O) waco=
m dm_crypt_sina(O) chiasmus(PO) cryptoapi_plugger(O) dm_mod
2021-03-16 11:27:14.276 kernel: CPU: 0 PID: 467 Comm: iw Tainted: P      =
  W  O      5.12.0-devel+ #1
2021-03-16 11:27:14.276 kernel: Hardware name: LENOVO 20HGS0TW00/20HGS0TW=
00, BIOS N1WET46S (1.25s ) 03/30/2018
2021-03-16 11:27:14.276 kernel: RIP: 0010:inetdev_event+0x4a9/0x5c0
2021-03-16 11:27:14.276 kernel: Code: e7 6b 58 01 00 0f 85 84 fd ff ff ba=
 35 01 00 00 48 c7 c6 37 0c 73 a5 48 c7 c7 60 77 62 a5 c6 05 c7 6b 58 01 =
01 e8 33 44 19 00 <0f> 0b e9 5e fd ff ff 48 8b 3d f1 1f c5 00 ba 78 00 00=
 00 be c0 0d
2021-03-16 11:27:14.276 kernel: RSP: 0018:ffffa09583cc7940 EFLAGS: 000102=
86
2021-03-16 11:27:14.276 kernel: RAX: 0000000000000000 RBX: 00000000000000=
06 RCX: 0000000000000027
2021-03-16 11:27:14.276 kernel: RDX: 0000000000000027 RSI: ffff9537074174=
70 RDI: ffff953707417478
2021-03-16 11:27:14.276 kernel: RBP: ffffa09583cc7990 R08: 00000000000000=
00 R09: c0000000fffeffff
2021-03-16 11:27:14.276 kernel: R10: 0000000000000001 R11: ffffa09583cc77=
68 R12: ffff9531cb58c600
2021-03-16 11:27:14.276 kernel: R13: ffff9531c0246000 R14: ffffffffa5737f=
99 R15: ffffa09583cc7b40
2021-03-16 11:27:14.276 kernel: FS:  00007fa4eacd8b80(0000) GS:ffff953707=
400000(0000) knlGS:0000000000000000
2021-03-16 11:27:14.276 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
2021-03-16 11:27:14.276 kernel: CR2: 00007f2720ae1000 CR3: 0000000105d940=
03 CR4: 00000000003706f0
2021-03-16 11:27:14.276 kernel: Call Trace:
2021-03-16 11:27:14.276 kernel:  ? trace_hardirqs_on+0x2a/0xb0
2021-03-16 11:27:14.276 kernel:  ? raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.276 kernel:  raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.276 kernel:  dev_change_net_namespace+0xe1/0x480
2021-03-16 11:27:14.276 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:27:14.276 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:27:14.276 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:27:14.276 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:27:14.276 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:27:14.276 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:27:14.276 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:27:14.276 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:27:14.276 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:27:14.276 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:27:14.276 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:27:14.276 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:27:14.276 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:27:14.276 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:27:14.276 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:27:14.276 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:27:14.276 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:27:14.276 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:27:14.276 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:27:14.276 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:27:14.276 kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff=
 ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 69 31 0c 00 8b 00 85 c0 75 13 b8 =
2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55=
 48 89 f5 53
2021-03-16 11:27:14.276 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:27:14.276 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:27:14.276 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:27:14.276 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:27:14.276 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:27:14.276 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:27:14.276 kernel: ---[ end trace 6b632a15496dddf7 ]---
2021-03-16 11:27:14.276 kernel: ------------[ cut here ]------------
2021-03-16 11:27:14.276 kernel: RTNL: assertion failed at net/ipv4/igmp.c=
 (1793)
2021-03-16 11:27:14.276 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/igmp=
=2Ec:1793 ip_mc_destroy_dev+0x67/0x70
2021-03-16 11:27:14.276 kernel: Modules linked in: vtx(O) vboxdrv(O) waco=
m dm_crypt_sina(O) chiasmus(PO) cryptoapi_plugger(O) dm_mod
2021-03-16 11:27:14.276 kernel: CPU: 0 PID: 467 Comm: iw Tainted: P      =
  W  O      5.12.0-devel+ #1
2021-03-16 11:27:14.276 kernel: Hardware name: LENOVO 20HGS0TW00/20HGS0TW=
00, BIOS N1WET46S (1.25s ) 03/30/2018
2021-03-16 11:27:14.276 kernel: RIP: 0010:ip_mc_destroy_dev+0x67/0x70
2021-03-16 11:27:14.276 kernel: Code: 5b c3 80 3d 2f 20 58 01 00 75 ca ba=
 01 07 00 00 48 c7 c6 b8 11 73 a5 48 c7 c7 60 77 62 a5 c6 05 13 20 58 01 =
01 e8 75 f8 18 00 <0f> 0b eb a7 0f 1f 44 00 00 0f 1f 44 00 00 e9 46 f3 ff=
 ff 66 0f 1f
2021-03-16 11:27:14.276 kernel: RSP: 0018:ffffa09583cc7930 EFLAGS: 000102=
86
2021-03-16 11:27:14.276 kernel: RAX: 0000000000000000 RBX: ffff9531cb58c6=
00 RCX: 0000000000000027
2021-03-16 11:27:14.276 kernel: RDX: 0000000000000027 RSI: ffff9537074174=
70 RDI: ffff953707417478
2021-03-16 11:27:14.276 kernel: RBP: ffffa09583cc7990 R08: 00000000000000=
00 R09: c0000000fffeffff
2021-03-16 11:27:14.276 kernel: R10: 0000000000000001 R11: ffffa09583cc77=
58 R12: ffff9531cb58c600
2021-03-16 11:27:14.276 kernel: R13: ffffffffa4aefe90 R14: ffff9531cb58c6=
10 R15: ffff9531c0246000
2021-03-16 11:27:14.276 kernel: FS:  00007fa4eacd8b80(0000) GS:ffff953707=
400000(0000) knlGS:0000000000000000
2021-03-16 11:27:14.276 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
2021-03-16 11:27:14.276 kernel: CR2: 00007f2720ae1000 CR3: 0000000105d940=
03 CR4: 00000000003706f0
2021-03-16 11:27:14.276 kernel: Call Trace:
2021-03-16 11:27:14.276 kernel:  inetdev_event+0x22f/0x5c0
2021-03-16 11:27:14.276 kernel:  ? trace_hardirqs_on+0x2a/0xb0
2021-03-16 11:27:14.276 kernel:  ? raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.276 kernel:  raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.276 kernel:  dev_change_net_namespace+0xe1/0x480
2021-03-16 11:27:14.276 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:27:14.276 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:27:14.276 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:27:14.276 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:27:14.276 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:27:14.276 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:27:14.276 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:27:14.276 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:27:14.277 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:27:14.277 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:27:14.277 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:27:14.277 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:27:14.277 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:27:14.277 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:27:14.277 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:27:14.277 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:27:14.277 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:27:14.277 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:27:14.277 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:27:14.277 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:27:14.277 kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff=
 ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 69 31 0c 00 8b 00 85 c0 75 13 b8 =
2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55=
 48 89 f5 53
2021-03-16 11:27:14.277 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:27:14.277 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:27:14.277 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:27:14.277 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:27:14.277 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:27:14.277 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:27:14.277 kernel: ---[ end trace 6b632a15496dddf8 ]---
2021-03-16 11:27:14.277 kernel: ------------[ cut here ]------------
2021-03-16 11:27:14.277 kernel: RTNL: assertion failed at net/ipv4/igmp.c=
 (1721)
2021-03-16 11:27:14.277 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/igmp=
=2Ec:1721 ip_mc_down+0x84/0x90
2021-03-16 11:27:14.277 kernel: Modules linked in: vtx(O) vboxdrv(O) waco=
m dm_crypt_sina(O) chiasmus(PO) cryptoapi_plugger(O) dm_mod
2021-03-16 11:27:14.277 kernel: CPU: 0 PID: 467 Comm: iw Tainted: P      =
  W  O      5.12.0-devel+ #1
2021-03-16 11:27:14.277 kernel: Hardware name: LENOVO 20HGS0TW00/20HGS0TW=
00, BIOS N1WET46S (1.25s ) 03/30/2018
2021-03-16 11:27:14.277 kernel: RIP: 0010:ip_mc_down+0x84/0x90
2021-03-16 11:27:14.277 kernel: Code: ff ff 80 3d 85 21 58 01 00 75 ae ba=
 b9 06 00 00 48 c7 c6 b8 11 73 a5 48 c7 c7 60 77 62 a5 c6 05 69 21 58 01 =
01 e8 c8 f9 18 00 <0f> 0b eb 8b 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53=
 48 89 fb e8
2021-03-16 11:27:14.277 kernel: RSP: 0018:ffffa09583cc7918 EFLAGS: 000102=
86
2021-03-16 11:27:14.277 kernel: RAX: 0000000000000000 RBX: ffff9531cb58c6=
00 RCX: 0000000000000027
2021-03-16 11:27:14.277 kernel: RDX: 0000000000000027 RSI: ffff9537074174=
70 RDI: ffff953707417478
2021-03-16 11:27:14.277 kernel: RBP: ffff9531cb58c600 R08: 00000000000000=
00 R09: c0000000fffeffff
2021-03-16 11:27:14.277 kernel: R10: 0000000000000001 R11: ffffa09583cc77=
40 R12: ffff9531cb58c600
2021-03-16 11:27:14.277 kernel: R13: ffffffffa4aefe90 R14: ffff9531cb58c6=
10 R15: ffff9531c0246000
2021-03-16 11:27:14.277 kernel: FS:  00007fa4eacd8b80(0000) GS:ffff953707=
400000(0000) knlGS:0000000000000000
2021-03-16 11:27:14.277 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
2021-03-16 11:27:14.277 kernel: CR2: 00007f2720ae1000 CR3: 0000000105d940=
03 CR4: 00000000003706f0
2021-03-16 11:27:14.277 kernel: Call Trace:
2021-03-16 11:27:14.277 kernel:  ip_mc_destroy_dev+0x1a/0x70
2021-03-16 11:27:14.277 kernel:  inetdev_event+0x22f/0x5c0
2021-03-16 11:27:14.277 kernel:  ? trace_hardirqs_on+0x2a/0xb0
2021-03-16 11:27:14.277 kernel:  ? raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.277 kernel:  raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.277 kernel:  dev_change_net_namespace+0xe1/0x480
2021-03-16 11:27:14.277 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:27:14.277 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:27:14.277 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:27:14.277 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:27:14.277 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:27:14.277 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:27:14.277 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:27:14.277 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:27:14.277 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:27:14.277 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:27:14.277 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:27:14.277 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:27:14.277 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:27:14.277 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:27:14.277 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:27:14.277 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:27:14.277 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:27:14.277 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:27:14.277 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:27:14.277 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:27:14.277 kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff=
 ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 69 31 0c 00 8b 00 85 c0 75 13 b8 =
2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55=
 48 89 f5 53
2021-03-16 11:27:14.277 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:27:14.277 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:27:14.277 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:27:14.277 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:27:14.277 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:27:14.277 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:27:14.277 kernel: ---[ end trace 6b632a15496dddf9 ]---
2021-03-16 11:27:14.277 kernel: ------------[ cut here ]------------
2021-03-16 11:27:14.277 kernel: RTNL: assertion failed at net/ipv4/igmp.c=
 (1664)
2021-03-16 11:27:14.277 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/igmp=
=2Ec:1664 __ip_mc_dec_group+0x162/0x1a0
2021-03-16 11:27:14.277 kernel: Modules linked in: vtx(O) vboxdrv(O) waco=
m dm_crypt_sina(O) chiasmus(PO) cryptoapi_plugger(O) dm_mod
2021-03-16 11:27:14.277 kernel: CPU: 0 PID: 467 Comm: iw Tainted: P      =
  W  O      5.12.0-devel+ #1
2021-03-16 11:27:14.277 kernel: Hardware name: LENOVO 20HGS0TW00/20HGS0TW=
00, BIOS N1WET46S (1.25s ) 03/30/2018
2021-03-16 11:27:14.277 kernel: RIP: 0010:__ip_mc_dec_group+0x162/0x1a0
2021-03-16 11:27:14.277 kernel: Code: 9e 29 58 01 00 0f 85 dc fe ff ff ba=
 80 06 00 00 48 c7 c6 b8 11 73 a5 48 c7 c7 60 77 62 a5 c6 05 7e 29 58 01 =
01 e8 da 01 19 00 <0f> 0b e9 b6 fe ff ff 48 8b 03 8b 73 08 c6 43 77 00 48=
 8b 38 e8 55
2021-03-16 11:27:14.277 kernel: RSP: 0018:ffffa09583cc7900 EFLAGS: 000102=
86
2021-03-16 11:27:14.277 kernel: RAX: 0000000000000000 RBX: ffff9531cb58c6=
00 RCX: 0000000000000027
2021-03-16 11:27:14.277 kernel: RDX: 0000000000000027 RSI: ffff9537074174=
70 RDI: ffff953707417478
2021-03-16 11:27:14.277 kernel: RBP: 00000000010000e0 R08: 00000000000000=
00 R09: c0000000fffeffff
2021-03-16 11:27:14.277 kernel: R10: 0000000000000001 R11: ffffa09583cc77=
28 R12: ffff9531cb58c600
2021-03-16 11:27:14.277 kernel: R13: ffffffffa4aefe90 R14: ffff9531cb58c6=
10 R15: ffff9531c0246000
2021-03-16 11:27:14.277 kernel: FS:  00007fa4eacd8b80(0000) GS:ffff953707=
400000(0000) knlGS:0000000000000000
2021-03-16 11:27:14.277 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
2021-03-16 11:27:14.277 kernel: CR2: 00007f2720ae1000 CR3: 0000000105d940=
03 CR4: 00000000003706f0
2021-03-16 11:27:14.277 kernel: Call Trace:
2021-03-16 11:27:14.277 kernel:  ? in_dev_rcu_put+0x40/0x40
2021-03-16 11:27:14.277 kernel:  ip_mc_destroy_dev+0x1a/0x70
2021-03-16 11:27:14.277 kernel:  inetdev_event+0x22f/0x5c0
2021-03-16 11:27:14.277 kernel:  ? trace_hardirqs_on+0x2a/0xb0
2021-03-16 11:27:14.277 kernel:  ? raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.277 kernel:  raw_notifier_call_chain+0x41/0x50
2021-03-16 11:27:14.277 kernel:  dev_change_net_namespace+0xe1/0x480
2021-03-16 11:27:14.277 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:27:14.277 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:27:14.277 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:27:14.277 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:27:14.277 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:27:14.277 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:27:14.277 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:27:14.277 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:27:14.277 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:27:14.277 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:27:14.277 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:27:14.277 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:27:14.277 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:27:14.277 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:27:14.277 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:27:14.277 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:27:14.277 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:27:14.277 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:27:14.277 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:27:14.277 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:27:14.277 kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff=
 ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 69 31 0c 00 8b 00 85 c0 75 13 b8 =
2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55=
 48 89 f5 53
2021-03-16 11:27:14.278 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:27:14.278 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:27:14.278 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:27:14.278 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:27:14.278 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:27:14.278 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:27:14.278 kernel: ---[ end trace 6b632a15496dddfa ]---
2021-03-16 11:30:24.753 kernel: INFO: task iw:467 blocked for more than 1=
22 seconds.
2021-03-16 11:30:24.753 kernel:       Tainted: P        W  O      5.12.0-=
devel+ #1
2021-03-16 11:30:24.753 kernel: "echo 0 > /proc/sys/kernel/hung_task_time=
out_secs" disables this message.
2021-03-16 11:30:24.753 kernel: task:iw              state:D stack:12720 =
pid:  467 ppid:   457 flags:0x00004000
2021-03-16 11:30:24.753 kernel: Call Trace:
2021-03-16 11:30:24.753 kernel:  __schedule+0x275/0x660
2021-03-16 11:30:24.753 kernel:  schedule+0x3c/0xa0
2021-03-16 11:30:24.753 kernel:  schedule_preempt_disabled+0xa/0x10
2021-03-16 11:30:24.753 kernel:  __mutex_lock.isra.12+0x2c7/0x4c0
2021-03-16 11:30:24.753 kernel:  ? trace_hardirqs_on+0x2a/0xb0
2021-03-16 11:30:24.753 kernel:  ? skb_dequeue+0x57/0x70
2021-03-16 11:30:24.753 kernel:  cfg80211_netdev_notifier_call+0x23d/0x3e=
0
2021-03-16 11:30:24.753 kernel:  raw_notifier_call_chain+0x41/0x50
2021-03-16 11:30:24.753 kernel:  dev_change_net_namespace+0xe1/0x480
2021-03-16 11:30:24.753 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:30:24.753 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:30:24.753 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:30:24.753 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:30:24.753 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:30:24.753 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:30:24.753 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:30:24.753 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:30:24.753 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:30:24.754 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:30:24.754 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:30:24.754 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:30:24.754 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:30:24.754 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:30:24.754 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:30:24.754 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:30:24.754 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:30:24.754 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:30:24.754 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:30:24.754 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:30:24.754 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:30:24.754 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:30:24.754 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:30:24.754 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:30:24.754 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:30:24.754 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:31:53.032 kernel: kworker/dying (7) used greatest stack dep=
th: 12824 bytes left
2021-03-16 11:32:27.633 kernel: INFO: task iw:467 blocked for more than 2=
45 seconds.
2021-03-16 11:32:27.633 kernel:       Tainted: P        W  O      5.12.0-=
devel+ #1
2021-03-16 11:32:27.633 kernel: "echo 0 > /proc/sys/kernel/hung_task_time=
out_secs" disables this message.
2021-03-16 11:32:27.633 kernel: task:iw              state:D stack:12720 =
pid:  467 ppid:   457 flags:0x00004000
2021-03-16 11:32:27.633 kernel: Call Trace:
2021-03-16 11:32:27.633 kernel:  __schedule+0x275/0x660
2021-03-16 11:32:27.633 kernel:  schedule+0x3c/0xa0
2021-03-16 11:32:27.633 kernel:  schedule_preempt_disabled+0xa/0x10
2021-03-16 11:32:27.633 kernel:  __mutex_lock.isra.12+0x2c7/0x4c0
2021-03-16 11:32:27.633 kernel:  ? trace_hardirqs_on+0x2a/0xb0
2021-03-16 11:32:27.633 kernel:  ? skb_dequeue+0x57/0x70
2021-03-16 11:32:27.633 kernel:  cfg80211_netdev_notifier_call+0x23d/0x3e=
0
2021-03-16 11:32:27.633 kernel:  raw_notifier_call_chain+0x41/0x50
2021-03-16 11:32:27.633 kernel:  dev_change_net_namespace+0xe1/0x480
2021-03-16 11:32:27.633 kernel:  ? __rtnl_unlock+0x25/0x50
2021-03-16 11:32:27.633 kernel:  cfg80211_switch_netns+0x65/0x1c0
2021-03-16 11:32:27.633 kernel:  nl80211_wiphy_netns+0x4b/0xc0
2021-03-16 11:32:27.633 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0=
x150
2021-03-16 11:32:27.633 kernel:  genl_rcv_msg+0xde/0x1e0
2021-03-16 11:32:27.633 kernel:  ? nl80211_authenticate+0x310/0x310
2021-03-16 11:32:27.633 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150=
/0x150
2021-03-16 11:32:27.633 kernel:  netlink_rcv_skb+0x50/0x100
2021-03-16 11:32:27.634 kernel:  genl_rcv+0x24/0x40
2021-03-16 11:32:27.634 kernel:  netlink_unicast+0x1a5/0x280
2021-03-16 11:32:27.634 kernel:  netlink_sendmsg+0x21b/0x450
2021-03-16 11:32:27.634 kernel:  sock_sendmsg+0x5b/0x60
2021-03-16 11:32:27.634 kernel:  ____sys_sendmsg+0x1ad/0x1e0
2021-03-16 11:32:27.634 kernel:  ? copy_msghdr_from_user+0x5c/0x90
2021-03-16 11:32:27.634 kernel:  ___sys_sendmsg+0x84/0xc0
2021-03-16 11:32:27.634 kernel:  ? do_filp_open+0xa7/0x100
2021-03-16 11:32:27.634 kernel:  __sys_sendmsg+0x51/0x90
2021-03-16 11:32:27.634 kernel:  do_syscall_64+0x33/0x40
2021-03-16 11:32:27.634 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae=

2021-03-16 11:32:27.634 kernel: RIP: 0033:0x7fa4eadf1594
2021-03-16 11:32:27.634 kernel: RSP: 002b:00007ffc81386148 EFLAGS: 000002=
46 ORIG_RAX: 000000000000002e
2021-03-16 11:32:27.634 kernel: RAX: ffffffffffffffda RBX: 0000562bd91b83=
50 RCX: 00007fa4eadf1594
2021-03-16 11:32:27.634 kernel: RDX: 0000000000000000 RSI: 00007ffc813861=
80 RDI: 0000000000000003
2021-03-16 11:32:27.634 kernel: RBP: 0000562bd91bd740 R08: 00000000000000=
01 R09: 00007fa4eae6de80
2021-03-16 11:32:27.634 kernel: R10: fffffffffffffd2d R11: 00000000000002=
46 R12: 0000562bd91bd880
2021-03-16 11:32:27.634 kernel: R13: 00007ffc81386180 R14: 0000562bd91bd7=
90 R15: 0000562bd91bd880
2021-03-16 11:33:34.176 kernel: usb 1-4: USB disconnect, device number 3
2021-03-16 11:33:38.303 kernel: thinkpad_acpi: deprecated sysfs attribute=
: access by process with PID 739
2021-03-16 11:33:38.303 kernel: thinkpad_acpi: WARNING: sysfs attribute h=
otkey_bios_mask is deprecated and will be removed. This attribute is usel=
ess.
2021-03-16 11:33:38.304 kernel: thinkpad_acpi: deprecated sysfs attribute=
: access by process with PID 739
2021-03-16 11:33:38.304 kernel: thinkpad_acpi: WARNING: sysfs attribute w=
wan_enable is deprecated and will be removed. Please switch to generic rf=
kill before year 2010
2021-03-16 11:33:38.305 kernel: thinkpad_acpi: deprecated sysfs attribute=
: access by process with PID 739
2021-03-16 11:33:38.305 kernel: thinkpad_acpi: WARNING: sysfs attribute b=
luetooth_enable is deprecated and will be removed. Please switch to gener=
ic rfkill before year 2010
2021-03-16 11:33:38.403 kernel: thinkpad_acpi: deprecated sysfs attribute=
: access by process with PID 739
2021-03-16 11:33:38.403 kernel: thinkpad_acpi: WARNING: sysfs attribute h=
otkey_enable is deprecated and will be removed. Hotkey reporting is alway=
s enabled
2021-03-16 11:33:39.358 kernel: WARNING! power/level is deprecated; use p=
ower/control instead
2021-03-16 11:33:39.450 kernel: thinkpad_acpi: deprecated sysfs attribute=
: access by process with PID 742
2021-03-16 11:33:39.450 kernel: thinkpad_acpi: WARNING: sysfs attribute b=
luetooth_enable is deprecated and will be removed. Please switch to gener=
ic rfkill before year 2010
2021-03-16 11:33:39.451 kernel: thinkpad_acpi: deprecated sysfs attribute=
: access by process with PID 742
2021-03-16 11:33:39.451 kernel: thinkpad_acpi: WARNING: sysfs attribute h=
otkey_bios_mask is deprecated and will be removed. This attribute is usel=
ess.
2021-03-16 11:33:39.451 kernel: thinkpad_acpi: deprecated sysfs attribute=
: access by process with PID 742
2021-03-16 11:33:39.451 kernel: thinkpad_acpi: WARNING: sysfs attribute h=
otkey_enable is deprecated and will be removed. Hotkey reporting is alway=
s enabled
2021-03-16 11:33:39.451 kernel: thinkpad_acpi: deprecated sysfs attribute=
: access by process with PID 742
2021-03-16 11:33:39.451 kernel: thinkpad_acpi: WARNING: sysfs attribute w=
wan_enable is deprecated and will be removed. Please switch to generic rf=
kill before year 2010
2021-03-16 11:33:39.483 kernel: bdi 254:0: the stable_pages_required attr=
ibute has been removed. Use the stable_writes queue attribute instead.
2021-03-16 11:33:39.815 kernel: usb 1-4: new high-speed USB device number=
 8 using xhci_hcd
2021-03-16 11:33:39.949 kernel: usb 1-4: New USB device found, idVendor=3D=
8564, idProduct=3D1000, bcdDevice=3D 1.00
2021-03-16 11:33:39.949 kernel: usb 1-4: New USB device strings: Mfr=3D1,=
 Product=3D2, SerialNumber=3D3
2021-03-16 11:33:39.949 kernel: usb 1-4: Product: Mass Storage Device
2021-03-16 11:33:39.949 kernel: usb 1-4: Manufacturer: JetFlash
2021-03-16 11:33:39.949 kernel: usb 1-4: SerialNumber: 29A5O54E
2021-03-16 11:33:39.951 kernel: usb-storage 1-4:1.0: USB Mass Storage dev=
ice detected
2021-03-16 11:33:39.953 kernel: scsi host1: usb-storage 1-4:1.0
2021-03-16 11:33:40.978 kernel: scsi 1:0:0:0: Direct-Access     JetFlash =
Transcend 8GB    8.07 PQ: 0 ANSI: 4
2021-03-16 11:33:40.980 kernel: sd 1:0:0:0: [sdb] 15679486 512-byte logic=
al blocks: (8.03 GB/7.48 GiB)
2021-03-16 11:33:40.981 kernel: sd 1:0:0:0: [sdb] Write Protect is off
2021-03-16 11:33:40.981 kernel: sd 1:0:0:0: [sdb] Mode Sense: 23 00 00 00=

2021-03-16 11:33:40.983 kernel: sd 1:0:0:0: [sdb] Write cache: disabled, =
read cache: enabled, doesn't support DPO or FUA
2021-03-16 11:33:40.992 kernel:  sdb: sdb1
2021-03-16 11:33:40.994 kernel: sd 1:0:0:0: [sdb] Attached SCSI removable=
 disk

--------------153C8659B46D87393B8A6C29--
