Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE1381F7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 01:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfFFXxx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 19:53:53 -0400
Received: from a1i1011.smtp2go.com ([43.228.187.243]:41121 "EHLO
        a1i1011.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfFFXxx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 19:53:53 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 19:53:52 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=mb6cr0.a1-4.dyn; x=1559866132; h=Feedback-ID:
        X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
        List-Unsubscribe; bh=t/kLg/gVmNDqBSGpmxn/btK2vfN4swjGpO91Jtvct2I=; b=TxUV5ZFZ
        jQeS2Vy2KEC2gusyEaLb8VWY0PMvAY8z/ci0iXNWZXJ2PuSFBnf31lwvCpEdiZTSRSsqVVejj8s5h
        da2pz31JhOk3OuRbUGm2hBGOsKDLe8VjNdApJp1Y1xXf74DrlElgaOAz3UWDwO5z1uscPV67NfPmq
        wRVfB2TYhXTfGZtMxMS4Qbk78APlZVlX5NHe0Ur/h2yv3NvaRlyOL2IG/wTGFD6EhBs/L5aFIFAug
        fJDNXxLhkyhyOjnA01duOWfb4LyXcSXy4k63++2uoM0ZVwRInyyeHKR5EB1uqa3YYD8IyvSzflH5a
        oSMfOah4hqx5T7P737rHihd0Cg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=balki.me; i=@balki.me; 
 q=dns/txt; s=s521451; t=1559865232; h=from : subject : to : message-id 
 : date; bh=t/kLg/gVmNDqBSGpmxn/btK2vfN4swjGpO91Jtvct2I=; 
 b=VYzBr2Hy8FYo1Iki2L2vo69HQiNWAAuMTA4/gq4Oqssj5RUoa/r69y3OSKp6ag4HS2/sPR
 YLNHYQyWecXNabMPURJJG9YeFN7yF/cy+eMP9imoEil4lZGN2rRuZoEGcJLqsSny60iJ51+l
 gtVn50yBROa9V2mi0loqBa3D1y5XyoSgyTwUzWZNBvqc3BiRYnlR4EPRcSJ5+Ep/yVwor8VB
 88KT1WEYnBrhBXnxr2x0zPzpv3thZCxrFY6rWZVX0oy95vrVUWhFZNKzZi2zHhZqGqUb6Nv5
 FqE65iQoug1j5U/pF5oRSjHs6wXdpa4rQRQfM4R45K0/QAQiWAyt3bkA==
Received: from [10.45.33.53] (helo=SmtpCorp)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <linux-wireless-list@balki.me>)
 id 1hZ23p-4pkV1F-IP
 for linux-wireless@vger.kernel.org; Thu, 06 Jun 2019 23:44:45 +0000
Received: from [10.135.23.123] (helo=zadesk.localnet)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <linux-wireless-list@balki.me>)
 id 1hZ23o-rlZAHV-Kj
 for linux-wireless@vger.kernel.org; Thu, 06 Jun 2019 23:44:44 +0000
From:   Balakrishnan Balasubramanian <linux-wireless-list@balki.me>
To:     linux-wireless@vger.kernel.org
Subject: iwlwifi module crash
Date:   Thu, 06 Jun 2019 19:44:41 -0400
Message-ID: <2455026.F8Aexx8IWb@zadesk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart9521468.TH6UdbEUSG"
Content-Transfer-Encoding: 7Bit
X-Smtpcorp-Track: 1hZ23or_ZjHVKM.AWVtp8E4Z
Feedback-ID: 521451m:521451aMgsuo0:521451soMcW_o47W
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart9521468.TH6UdbEUSG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I am using iwd demon for wifi. Once a while I loose connectivity. Restarting 
the demon does not help. But once I restart the system, it starts working fine. 
Attaching stack trace from journal.

Regards,
Bala
--nextPart9521468.TH6UdbEUSG
Content-Type: message/rfc822
Content-Disposition: inline; filename="forwarded message"
Content-Description: Denis Kenzior <denkenz@gmail.com>: Re: iwd crashes
 randomly

Received: by mail-oi1-f182.google.com with SMTP id w79so165142oif.10 for
 <iwd-lists@balki.me>; Thu, 06 Jun 2019 16:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=TfHx4aBf25yQFBMihp24A2Qbug3aCIRIVU5dq3UvmVc=;
 b=TW4EX6VrTwSCsgbl0tGFQ3WyEI4d+F3qe5Nk5xYTXUIZdC5iHZFieZtSQAW8P0bZmQ
 Q59pW+6Z0hx+dUcVj/+0lyRDOzoId7Hjn0nIGJDD3HFN85nQPc/2cS83FJm0dD3jOruK
 LRs5SHjuybzSjlnshZwYuxFlLkwSty0iMAS5nIemDT665qhxyfxgpOkaQR3Um81L55uE
 mhp5SRHIQHzEiSvOrgq6u+72uWp4diJd0DX6TvmueVhaBjkgWIKfBvL9oQbduhLd6We+
 w7YbGwrIurUiR/p1BqKdFWFwY5RzUAarUtLKLAXpC3HmL4zAiNL7KBEw0JcpEl67Auo8 6TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net;
 s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding; bh=TfHx4aBf25yQFBMihp24A2Qbug3aCIRIVU5dq3UvmVc=;
 b=mCmIa7pvL7KnZCCuEr/g3HCMWuKCRTsKUQcE3GQmokDcPxOnpM0I7Z+UlCssUx0IlW
 RQjId+cFRrA9kirJ0v7CAjs0Asjb3MEJ/ubyRhBVxEX8nkTi/x6fJSF6cawdpuJOHDF+
 nDh/ZfL7U8UmLJsUZjH6UjhBoNQmFSj2PM/wV1Rk91jzZbRZbd2x/ALSHSzBgRG+U5FC
 5gE/LZYPhaqu4tq6D35CMxGCiQdOeaDAInX2gr4afxrUEy0OFujjyQ1mefqlHdgliueR
 eN79IL/0Xdkp39+TXmVr6HpEriWz251FiRsTBh3AeBElANsmAD1zsR/0MXK6Ta0PjmWX lDWw==
X-Gm-Message-State: APjAAAWa3eZD+qphoaZ7QADoPlXrtlGDB1nK2v0R2KahTuHF2yAmmwqH
 bUg1/FVr2ow/gRWXz74MT2gvmVpa
X-Google-Smtp-Source: APXvYqxzFIy0rdw+EBRzP765ewt+PV/HnT5ZxVloMAacAcq4S1q0Sd/01NSYW5lBUWrL9vTroXvuSw==
X-Received: by 2002:aca:b1d4:: with SMTP id a203mr1844382oif.67.1559862462344;
 Thu, 06 Jun 2019 16:07:42 -0700 (PDT)
Return-Path: <denkenz@gmail.com>
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com.
 [70.114.247.242]) by smtp.googlemail.com with ESMTPSA id
 p188sm128733oia.14.2019.06.06.16.07.41 (version=TLS1_2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Jun 2019 16:07:41 -0700 (PDT)
Subject: Re: iwd crashes randomly
To: Balakrishnan Balasubramanian <iwd-lists@balki.me>, iwd@lists.01.org
References: <6429283.C9B6WLBDxO@zadesk>
From: Denis Kenzior <denkenz@gmail.com>
Message-ID: <9a29fc57-0547-203a-9e9f-417b16f9617e@gmail.com>
Date: Thu, 06 Jun 2019 18:07:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <6429283.C9B6WLBDxO@zadesk>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Peer: ('209.85.167.182', 43227)
X-MailFrom: denkenz@gmail.com
X-RcptTo: iwd-lists@balki.me

Hi Bala,

On 06/06/2019 06:00 PM, Balakrishnan Balasubramanian wrote:
> Sometimes after a week and sometimes after two days. Once crashed, restarting
> the service does not help. Had to restart the computer. Attaching stack trace
> from journal.

That implies that your kernel is crashing, not iwd.  The attached log 
shows a kernel stack trace somewhere inside iwlwifi module.  I would 
post this trace to linux-wireless@vger.kernel.org.

If you have an associated iwd backtrace, then certainly post this here, 
but if the kernel module is crashing, there isn't much we can do.

Regards,
-Denis

--nextPart9521468.TH6UdbEUSG
Content-Disposition: inline; filename="iwd_crash.log"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-log; charset="UTF-8"; name="iwd_crash.log"

Jun 03 19:53:47 zadesk dbus-daemon[475]: [system] Successfully activated se=
rvice 'org.kde.powerdevil.backlighthelper'
Jun 03 21:32:49 zadesk dhcpcd[505]: wlan0: fe80::481d:70ff:feaf:2a13 is unr=
eachable, expiring it
Jun 03 21:32:49 zadesk dhcpcd[505]: wlan0: carrier lost
Jun 03 21:32:49 zadesk dhcpcd[505]: wlan0: deleting address 2607:f2c0:e568:=
c9:3c6f:aab:250c:45d4/128
Jun 03 21:32:49 zadesk dhcpcd[505]: wlan0: deleting address 2607:f2c0:e568:=
c9:16d1:ac43:f2f7:9142/64
Jun 03 21:32:49 zadesk dhcpcd[505]: wlan0: deleting route to 2607:f2c0:e568=
:c9::/64
Jun 03 21:32:49 zadesk dhcpcd[505]: wlan0: deleting default route via fe80:=
:481d:70ff:feaf:2a13
Jun 03 21:32:52 zadesk iwd[474]: Received Deauthentication event, reason: 4=
, from_ap: false
Jun 03 21:32:52 zadesk dhcpcd[505]: wlan0: deleting route to 192.168.0.0/24
Jun 03 21:32:52 zadesk kernel: wlan0: Connection to AP 00:00:00:00:00:00 lo=
st
Jun 03 21:32:52 zadesk dhcpcd[505]: wlan0: deleting default route via 192.1=
68.0.1
Jun 03 21:33:14 zadesk kernel: wlan0: authenticate with d4:5d:df:25:ee:90
Jun 03 21:33:14 zadesk kernel: wlan0: send auth to d4:5d:df:25:ee:90 (try 1=
/3)
Jun 03 21:33:14 zadesk kernel: wlan0: authenticated
Jun 03 21:33:14 zadesk kernel: wlan0: associate with d4:5d:df:25:ee:90 (try=
 1/3)
Jun 03 21:33:14 zadesk kernel: wlan0: associate with d4:5d:df:25:ee:90 (try=
 2/3)
Jun 03 21:33:14 zadesk kernel: wlan0: RX AssocResp from d4:5d:df:25:ee:90 (=
capab=3D0x411 status=3D0 aid=3D1)
Jun 03 21:33:14 zadesk kernel: wlan0: associated
Jun 03 21:33:14 zadesk dhcpcd[505]: wlan0: carrier acquired
Jun 03 21:33:14 zadesk dhcpcd[505]: wlan0: IAID ce:1e:6b:76
Jun 03 21:33:14 zadesk kernel: wlan0: Limiting TX power to 14 (17 - 3) dBm =
as advertised by d4:5d:df:25:ee:90
Jun 03 21:33:15 zadesk dhcpcd[505]: wlan0: soliciting an IPv6 router
Jun 03 21:33:15 zadesk dhcpcd[505]: wlan0: Router Advertisement from fe80::=
481d:70ff:feaf:2a13
Jun 03 21:33:15 zadesk dhcpcd[505]: wlan0: adding address 2607:f2c0:e568:c9=
:16d1:ac43:f2f7:9142/64
Jun 03 21:33:15 zadesk dhcpcd[505]: wlan0: adding route to 2607:f2c0:e568:c=
9::/64
Jun 03 21:33:15 zadesk dhcpcd[505]: wlan0: adding default route via fe80::4=
81d:70ff:feaf:2a13
Jun 03 21:33:15 zadesk dhcpcd[505]: wlan0: confirming prior DHCPv6 lease
Jun 03 21:33:15 zadesk dhcpcd[505]: wlan0: rebinding lease of 192.168.0.16
Jun 03 21:33:16 zadesk dhcpcd[505]: wlan0: probing address 192.168.0.16/24
Jun 03 21:33:16 zadesk dhcpcd[505]: wlan0: REPLY6 received from fe80::481d:=
70ff:feaf:2a13
Jun 03 21:33:16 zadesk dhcpcd[505]: wlan0: adding address 2607:f2c0:e568:c9=
:3c6f:aab:250c:45d4/128
Jun 03 21:33:16 zadesk dhcpcd[505]: wlan0: renew in 302400, rebind in 48384=
0, expire in 604800 seconds
Jun 03 21:33:21 zadesk dhcpcd[505]: wlan0: leased 192.168.0.16 for 604800 s=
econds
Jun 03 21:33:21 zadesk dhcpcd[505]: wlan0: adding route to 192.168.0.0/24
Jun 03 21:33:21 zadesk dhcpcd[505]: wlan0: adding default route via 192.168=
=2E0.1
Jun 03 21:34:03 zadesk kernel: ------------[ cut here ]------------
Jun 03 21:34:03 zadesk kernel: Timeout waiting for hardware access (CSR_GP_=
CNTRL 0xffffffff)
Jun 03 21:34:03 zadesk kernel: WARNING: CPU: 2 PID: 0 at drivers/net/wirele=
ss/intel/iwlwifi/pcie/trans.c:1988 iwl_trans_pcie_grab_nic_access+0x1e6/0x2=
20 [iwlwifi]
Jun 03 21:34:03 zadesk kernel: Modules linked in: fuse snd_hda_codec_hdmi c=
cm algif_aead des_generic algif_skcipher 8021q garp mrp stp cmac llc md4 al=
gif_hash af_alg arc4 intel_rapl x86_pkg_temp_thermal intel_powerclamp coret=
emp kvm_intel i915 kvm iwlmvm uvcvideo irqbypass i2c_algo_bit mac80211 vide=
obuf2_vmalloc videobuf2_memops snd_hda_codec_realtek drm_kms_helper snd_hda=
_codec_generic videobuf2_v4l2 ledtrig_audio videobuf2_common snd_hda_intel =
crct10dif_pclmul videodev snd_hda_codec drm crc32_pclmul iwlwifi ghash_clmu=
lni_intel btusb btrtl btbcm btintel bluetooth snd_hda_core ofpart cmdlinepa=
rt media intel_spi_platform snd_hwdep intel_spi spi_nor iTCO_wdt mei_wdt me=
i_hdcp mtd iTCO_vendor_support aesni_intel snd_pcm aes_x86_64 crypto_simd c=
ryptd snd_timer intel_gtt glue_helper intel_cstate intel_uncore joydev mous=
edev agpgart input_leds syscopyarea r8169 intel_rapl_perf ecdh_generic cfg8=
0211 snd sysfillrect mei_me pcspkr i2c_i801 realtek sysimgblt soundcore mei=
 libphy fb_sys_fops rfkill lpc_ich fintek_cir
Jun 03 21:34:03 zadesk kernel:  rc_core tpm_tis tpm_tis_core tpm evdev rng_=
core mac_hid pcc_cpufreq pkcs8_key_parser crypto_user ip_tables x_tables ex=
t4 crc32c_generic crc16 mbcache jbd2 hid_logitech_hidpp hid_logitech_dj hid=
_generic usbhid hid sr_mod cdrom sd_mod ahci xhci_pci libahci xhci_hcd liba=
ta crc32c_intel scsi_mod ehci_pci ehci_hcd
Jun 03 21:34:03 zadesk kernel: CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.=
1.5-arch1-2-ARCH #1
Jun 03 21:34:03 zadesk kernel: Hardware name: AIO H87H3-TI/H87H3-TI, BIOS 4=
=2E6.5 07/01/2014
Jun 03 21:34:03 zadesk kernel: RIP: 0010:iwl_trans_pcie_grab_nic_access+0x1=
e6/0x220 [iwlwifi]
Jun 03 21:34:03 zadesk kernel: Code: b1 cf 49 8d 56 08 bf 40 01 00 00 e8 94=
 1b 88 ce e9 35 ff ff ff 89 c6 48 c7 c7 70 7b c4 c0 c6 05 b7 7d 03 00 01 e8=
 94 62 86 ce <0f> 0b e9 f0 fe ff ff 48 8b 7b 30 48 c7 c1 d8 7b c4 c0 31 d2 =
31 f6
Jun 03 21:34:03 zadesk kernel: RSP: 0018:ffff981696903de8 EFLAGS: 00010082
Jun 03 21:34:03 zadesk kernel: RAX: 0000000000000000 RBX: ffff981693d80018 =
RCX: 0000000000000000
Jun 03 21:34:03 zadesk kernel: RDX: 0000000000000007 RSI: 0000000000000092 =
RDI: 00000000ffffffff
Jun 03 21:34:03 zadesk kernel: RBP: 0000000000000000 R08: 00000000000003a1 =
R09: 0000000000000001
Jun 03 21:34:03 zadesk kernel: R10: 0000000000000000 R11: 0000000000000001 =
R12: ffff981693d8a3a4
Jun 03 21:34:03 zadesk kernel: R13: ffff981696903e18 R14: 00000000ffffffff =
R15: 0000000000000004
Jun 03 21:34:03 zadesk kernel: FS:  0000000000000000(0000) GS:ffff981696900=
000(0000) knlGS:0000000000000000
Jun 03 21:34:03 zadesk kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Jun 03 21:34:03 zadesk kernel: CR2: 00007ffa69d3c020 CR3: 00000001b820e002 =
CR4: 00000000001606e0
Jun 03 21:34:03 zadesk kernel: Call Trace:
Jun 03 21:34:03 zadesk kernel:  <IRQ>
Jun 03 21:34:03 zadesk kernel:  iwl_read_prph+0x32/0x80 [iwlwifi]
Jun 03 21:34:03 zadesk kernel:  iwl_trans_pcie_log_scd_error+0x139/0x210 [i=
wlwifi]
Jun 03 21:34:03 zadesk kernel:  iwl_pcie_txq_stuck_timer+0x44/0x60 [iwlwifi]
Jun 03 21:34:03 zadesk kernel:  ? iwl_pcie_txq_inc_wr_ptr+0x100/0x100 [iwlw=
ifi]
Jun 03 21:34:03 zadesk kernel:  ? iwl_pcie_txq_inc_wr_ptr+0x100/0x100 [iwlw=
ifi]
Jun 03 21:34:03 zadesk kernel:  call_timer_fn+0x2b/0x160
Jun 03 21:34:03 zadesk kernel:  ? iwl_pcie_txq_inc_wr_ptr+0x100/0x100 [iwlw=
ifi]
Jun 03 21:34:03 zadesk kernel:  expire_timers+0x99/0x110
Jun 03 21:34:03 zadesk kernel:  run_timer_softirq+0x8a/0x160
Jun 03 21:34:03 zadesk kernel:  ? sched_clock+0x5/0x10
Jun 03 21:34:03 zadesk kernel:  ? sched_clock_cpu+0xe/0xd0
Jun 03 21:34:03 zadesk kernel:  ? irqtime_account_irq+0x3d/0xc0
Jun 03 21:34:03 zadesk kernel:  __do_softirq+0x112/0x356
Jun 03 21:34:03 zadesk kernel:  irq_exit+0xd9/0xf0
Jun 03 21:34:03 zadesk kernel:  smp_apic_timer_interrupt+0x87/0x180
Jun 03 21:34:03 zadesk kernel:  apic_timer_interrupt+0xf/0x20
Jun 03 21:34:03 zadesk kernel:  </IRQ>
Jun 03 21:34:03 zadesk kernel: RIP: 0010:cpuidle_enter_state+0xbc/0x480
Jun 03 21:34:03 zadesk kernel: Code: e8 a9 c0 9f ff 80 7c 24 13 00 74 17 9c=
 58 0f 1f 44 00 00 f6 c4 02 0f 85 99 03 00 00 31 ff e8 3b 03 a6 ff fb 66 0f=
 1f 44 00 00 <45> 85 e4 0f 88 c4 02 00 00 49 63 cc 4c 8b 3c 24 4c 2b 7c 24 =
08 48
Jun 03 21:34:03 zadesk kernel: RSP: 0018:ffff9fec80cf7e98 EFLAGS: 00000246 =
ORIG_RAX: ffffffffffffff13
Jun 03 21:34:03 zadesk kernel: RAX: ffff981696900000 RBX: ffffffff906bd5c0 =
RCX: 000000000000001f
Jun 03 21:34:03 zadesk kernel: RDX: 0000083837ad6417 RSI: 000000002c3d7be3 =
RDI: 0000000000000000
Jun 03 21:34:03 zadesk kernel: RBP: ffff98169692be00 R08: 0000000000000002 =
R09: 0000000000021740
Jun 03 21:34:03 zadesk kernel: R10: 000017ceeb3a3497 R11: ffff981696920d64 =
R12: 0000000000000005
Jun 03 21:34:03 zadesk kernel: R13: ffffffff906bd7b8 R14: 0000000000000005 =
R15: 0000000000000000
Jun 03 21:34:03 zadesk kernel:  ? cpuidle_enter_state+0x97/0x480
Jun 03 21:34:03 zadesk kernel:  do_idle+0x217/0x250
Jun 03 21:34:03 zadesk kernel:  cpu_startup_entry+0x19/0x20
Jun 03 21:34:03 zadesk kernel:  start_secondary+0x180/0x1d0
Jun 03 21:34:03 zadesk kernel:  secondary_startup_64+0xa4/0xb0
Jun 03 21:34:03 zadesk kernel: ---[ end trace d9201afd2c4b3e67 ]---
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: iwlwifi transaction fa=
iled, dumping registers
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: iwlwifi device config =
registers:
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: 00000000: 08b18086 001=
00000 028000bb 00000000 00000004 00000000 00000000 00000000
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: 00000020: 00000000 000=
00000 00000000 40708086 00000000 000000c8 00000000 00000100
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: iwlwifi device memory =
mapped registers:
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: 00000000: ffffffff fff=
fffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: 00000020: ffffffff fff=
fffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: iwlwifi device AER cap=
ability structure:
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: 00000000: 14010001 001=
00000 00000000 00462031 000031c1 00002000 00000014 40000001
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: 00000020: 0000000f f7d=
00460 00000000
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: iwlwifi parent port (0=
000:00:1c.2) config registers:
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:00:1c.2: 00000000: 8c148086 001=
00407 060400d5 00810010 00000000 00000000 00020200 200000f0
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:00:1c.2: 00000020: f7d0f7d0 000=
1fff1 00000000 00000000 00000000 00000040 00000000 00120304
Jun 03 21:34:03 zadesk kernel: iwlwifi 0000:02:00.0: Queue 4 is active on f=
ifo 2 and stuck for 10000 ms. SW [87, 103] HW [90, 90] FH TRB=3D0x05a5a5a5a
Jun 03 21:34:23 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd
Jun 03 21:34:23 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFF=
LOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 03 21:34:23 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 03 21:34:23 zadesk iwd[474]: Received error during CMD_TRIGGER_SCAN: In=
put/output error (5)
Jun 03 21:35:19 zadesk dhcpcd[505]: wlan0: fe80::481d:70ff:feaf:2a13 is unr=
eachable, expiring it
Jun 03 21:35:23 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd
Jun 03 21:35:23 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFF=
LOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 03 21:35:23 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 03 21:35:23 zadesk iwd[474]: Received error during CMD_TRIGGER_SCAN: In=
put/output error (5)
Jun 03 21:36:23 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd
Jun 03 21:36:23 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFF=
LOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 03 21:36:23 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 03 21:36:23 zadesk iwd[474]: Received error during CMD_TRIGGER_SCAN: In=
put/output error (5)
Jun 03 21:37:23 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd
Jun 03 21:37:23 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFF=
LOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 03 21:37:23 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 03 21:37:23 zadesk iwd[474]: Received error during CMD_TRIGGER_SCAN: In=
put/output error (5)
Jun 03 21:38:24 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd
Jun 03 21:38:24 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFF=
LOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 03 21:38:24 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 03 21:38:24 zadesk iwd[474]: Received error during CMD_TRIGGER_SCAN: In=
put/output error (5)
Jun 03 21:39:24 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd
Jun 03 21:39:24 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFF=
LOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 03 21:39:24 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 03 21:39:24 zadesk iwd[474]: Received error during CMD_TRIGGER_SCAN: In=
put/output error (5)
Jun 03 21:40:24 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd
Jun 03 21:40:24 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFF=
LOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 03 21:40:24 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 03 21:40:24 zadesk iwd[474]: Received error during CMD_TRIGGER_SCAN: In=
put/output error (5)
Jun 03 21:41:24 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd
Jun 03 21:41:24 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFF=
LOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 03 21:41:24 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 03 21:41:24 zadesk iwd[474]: Received error during CMD_TRIGGER_SCAN: In=
put/output error (5)
Jun 03 21:42:24 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd
Jun 03 21:42:24 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFF=
LOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 03 21:42:24 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 03 21:42:24 zadesk iwd[474]: Received error during CMD_TRIGGER_SCAN: In=
put/output error (5)
Jun 03 21:43:24 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd
Jun 03 21:43:24 zadesk kernel: iwlwifi 0000:02:00.0: Error sending SCAN_OFF=
LOAD_REQUEST_CMD: enqueue_hcmd failed: -5
Jun 03 21:43:24 zadesk kernel: iwlwifi 0000:02:00.0: Scan failed! ret -5
Jun 03 21:43:24 zadesk iwd[474]: Received error during CMD_TRIGGER_SCAN: In=
put/output error (5)
Jun 03 21:44:24 zadesk kernel: iwlwifi 0000:02:00.0: Failed to wake NIC for=
 hcmd

--nextPart9521468.TH6UdbEUSG--



