Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32CF1F035D
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2020 01:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgFEXFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jun 2020 19:05:53 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:52822 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgFEXFx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jun 2020 19:05:53 -0400
Received: from [192.168.254.4] (unknown [50.34.197.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id DCA4713C2B0
        for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2020 16:05:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DCA4713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1591398352;
        bh=2eKu375lq/kGVxP9E8Tjkpo3aIVbwD9DXUc4KU7Osr8=;
        h=From:Subject:To:Date:From;
        b=TJwgRHkcukJpqsDnGxssscz/7xuB1wGYqauZlV+DircunZ54C+Cn6+hLPvkIG8/Ta
         uM+zAvjC9c5ykgeSHpfhIUzkawf2dxpEZdQhPX/nhJm2lNAFk0DhoilSG9zVSFW5HT
         rKI7Q+bH5TtTb24qFKt4wwEELKv2uJMhiVfFKNQs=
From:   Ben Greear <greearb@candelatech.com>
Subject: iwlwifi-backports, ax200 FW crashes, station does not notice, no
 traffic.
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <3f31b90b-1b30-3b9c-6bbd-ac6d9fb13f20@candelatech.com>
Date:   Fri, 5 Jun 2020 16:05:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It was suggested I try the iwlwifi-backports package since upstream ax200 is so broken.

I am using it on kernel 5.7.0+, iwlwifi-backports branch release/core52 (patched to compile against 5.7.0),
and with the version 55 firmware from linux-firmware repo.  (Older firmware crashes too and in that case, radios
are often not recovered and so station cannot even be manually restarted.)

This does indeed work much better, but still some issues.

My test case is udp + tcp upload + download, full speed, on each of two
ax200 radios in this system.

AP is an Asus AX AP, configured for Open auth.

After a few minutes, the firmware crashes.  The main issue in this case is that
the station does not appear to notice the FW crashes, does not reconnect, thinks
it is connected, but cannot pass any traffic.  If I manually restart the station,
then it will start passing traffic again.

It is expected that the station is not disconnected when hardware fails?


[  518.915963] wlan2: authenticate with 0c:9d:92:02:42:e4
[  518.919968] wlan2: send auth to 0c:9d:92:02:42:e4 (try 1/3)
[  519.049083] wlan2: send auth to 0c:9d:92:02:42:e4 (try 2/3)
[  519.073761] wlan2: authenticated
[  519.075073] wlan2: associate with 0c:9d:92:02:42:e4 (try 1/3)
[  519.076510] wlan2: RX AssocResp from 0c:9d:92:02:42:e4 (capab=0x1001 status=0 aid=1)
[  519.077509] iwlwifi 0000:12:00.0: Got NSS = 4 - trimming to 2
[  519.079318] wlan2: associated
[  519.080319] IPv6: ADDRCONF(NETDEV_CHANGE): wlan2: link becomes ready
[  519.085553] wlan3: authenticate with 0c:9d:92:02:42:e4
[  519.089146] wlan3: send auth to 0c:9d:92:02:42:e4 (try 1/3)
[  519.125239] wlan2: Limiting TX power to 24 (24 - 0) dBm as advertised by 0c:9d:92:02:42:e4
[  519.217193] wlan3: send auth to 0c:9d:92:02:42:e4 (try 2/3)
[  519.232491] wlan3: authenticated
[  519.233068] wlan3: associate with 0c:9d:92:02:42:e4 (try 1/3)
[  519.238227] wlan3: RX AssocResp from 0c:9d:92:02:42:e4 (capab=0x1001 status=0 aid=2)
[  519.239271] iwlwifi 0000:14:00.0: Got NSS = 4 - trimming to 2
[  519.241150] wlan3: associated
[  519.241910] IPv6: ADDRCONF(NETDEV_CHANGE): wlan3: link becomes ready
[  519.330194] wlan3: Limiting TX power to 24 (24 - 0) dBm as advertised by 0c:9d:92:02:42:e4
[  522.455935] ixgbe 0000:01:00.0: removed PHC on eth2
[  522.852258] pps pps2: new PPS source ptp2
[  522.852306] ixgbe 0000:01:00.0: registered PHC device on eth2
[  522.974821] 8021q: adding VLAN 0 to HW filter on device eth2
[  527.077758] ixgbe 0000:01:00.0 eth2: NIC Link is Up 1 Gbps, Flow Control: RX/TX
[  527.078021] IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
[  601.584303] kauditd_printk_skb: 8 callbacks suppressed
[  601.584305] audit: type=1130 audit(1591396447.963:220): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dnf-makecache comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  601.584309] audit: type=1131 audit(1591396447.963:221): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dnf-makecache comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  702.600990] iwlwifi 0000:14:00.0: reached 10 old SN frames from 0c:9d:92:02:42:e4 on queue 3, stopping BA session on TID 0
[  824.804107] iwlwifi 0000:12:00.0: Microcode SW error detected. Restarting 0x0.
[  824.810427] iwlwifi 0000:12:00.0: Start IWL Error Log Dump:
[  824.814871] iwlwifi 0000:12:00.0: Status: 0x00000040, count: 6
[  824.819533] iwlwifi 0000:12:00.0: Loaded firmware version: 55.d9698065.0 cc-a0-55.ucode
[  824.826389] iwlwifi 0000:12:00.0: 0x00000942 | ADVANCED_SYSASSERT
[  824.832260] iwlwifi 0000:12:00.0: 0x00A0A210 | trm_hw_status0
[  824.836972] iwlwifi 0000:12:00.0: 0x00000000 | trm_hw_status1
[  824.841735] iwlwifi 0000:12:00.0: 0x004FA34A | branchlink2
[  824.846165] iwlwifi 0000:12:00.0: 0x00000F86 | interruptlink1
[  824.850914] iwlwifi 0000:12:00.0: 0x00000F86 | interruptlink2
[  824.855669] iwlwifi 0000:12:00.0: 0xFFFD0020 | data1
[  824.859540] iwlwifi 0000:12:00.0: 0x6A010201 | data2
[  824.863414] iwlwifi 0000:12:00.0: 0x040C0606 | data3
[  824.867265] iwlwifi 0000:12:00.0: 0xEA814B27 | beacon time
[  824.871644] iwlwifi 0000:12:00.0: 0xEC2B9671 | tsf low
[  824.875626] iwlwifi 0000:12:00.0: 0x0000001A | tsf hi
[  824.879509] iwlwifi 0000:12:00.0: 0x00000000 | time gp1
[  824.883617] iwlwifi 0000:12:00.0: 0x126CA954 | time gp2
[  824.887714] iwlwifi 0000:12:00.0: 0x00000001 | uCode revision type
[  824.892781] iwlwifi 0000:12:00.0: 0x00000037 | uCode version major
[  824.897780] iwlwifi 0000:12:00.0: 0xD9698065 | uCode version minor
[  824.902850] iwlwifi 0000:12:00.0: 0x00000340 | hw version
[  824.907089] iwlwifi 0000:12:00.0: 0x18C89000 | board version
[  824.911615] iwlwifi 0000:12:00.0: 0x8010FD25 | hcmd
[  824.915356] iwlwifi 0000:12:00.0: 0xE6821010 | isr0
[  824.918992] iwlwifi 0000:12:00.0: 0x00440000 | isr1
[  824.922749] iwlwifi 0000:12:00.0: 0x08F80102 | isr2
[  824.926487] iwlwifi 0000:12:00.0: 0x04C33B0D | isr3
[  824.930305] iwlwifi 0000:12:00.0: 0x00000000 | isr4
[  824.934057] iwlwifi 0000:12:00.0: 0x03AF001C | last cmd Id
[  824.938522] iwlwifi 0000:12:00.0: 0x004EB008 | wait_event
[  824.942847] iwlwifi 0000:12:00.0: 0x00000288 | l2p_control
[  824.947218] iwlwifi 0000:12:00.0: 0x00010014 | l2p_duration
[  824.951633] iwlwifi 0000:12:00.0: 0x00000000 | l2p_mhvalid
[  824.955958] iwlwifi 0000:12:00.0: 0x000000EF | l2p_addr_match
[  824.960590] iwlwifi 0000:12:00.0: 0x00000009 | lmpm_pmg_sel
[  824.965042] iwlwifi 0000:12:00.0: 0x00000000 | timestamp
[  824.969192] iwlwifi 0000:12:00.0: 0x00005848 | flow_handler
[  824.973646] iwlwifi 0000:12:00.0: Start IWL Error Log Dump:
[  824.978092] iwlwifi 0000:12:00.0: Status: 0x00000040, count: 7
[  824.982846] iwlwifi 0000:12:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[  824.988359] iwlwifi 0000:12:00.0: 0x00000000 | umac branchlink1
[  824.993139] iwlwifi 0000:12:00.0: 0x80465826 | umac branchlink2
[  824.997952] iwlwifi 0000:12:00.0: 0x8048074C | umac interruptlink1
[  825.002982] iwlwifi 0000:12:00.0: 0x8048074C | umac interruptlink2
[  825.007981] iwlwifi 0000:12:00.0: 0x00000400 | umac data1
[  825.012165] iwlwifi 0000:12:00.0: 0x8048074C | umac data2
[  825.016376] iwlwifi 0000:12:00.0: 0x00000000 | umac data3
[  825.020584] iwlwifi 0000:12:00.0: 0x00000037 | umac major
[  825.024791] iwlwifi 0000:12:00.0: 0xD9698065 | umac minor
[  825.029058] iwlwifi 0000:12:00.0: 0x126CA96B | frame pointer
[  825.033563] iwlwifi 0000:12:00.0: 0xC0886270 | stack pointer
[  825.038090] iwlwifi 0000:12:00.0: 0x0095010C | last host cmd
[  825.042540] iwlwifi 0000:12:00.0: 0x00000000 | isr status reg
[  825.047141] iwlwifi 0000:12:00.0: Fseq Registers:
[  825.050613] iwlwifi 0000:12:00.0: 0x60000000 | FSEQ_ERROR_CODE
[  825.055229] iwlwifi 0000:12:00.0: 0x80290021 | FSEQ_TOP_INIT_VERSION
[  825.060412] iwlwifi 0000:12:00.0: 0x00050008 | FSEQ_CNVIO_INIT_VERSION
[  825.065807] iwlwifi 0000:12:00.0: 0x0000A503 | FSEQ_OTP_VERSION
[  825.070536] iwlwifi 0000:12:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
[  825.076022] iwlwifi 0000:12:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[  825.080756] iwlwifi 0000:12:00.0: 0x00100530 | FSEQ_CNVI_ID
[  825.085089] iwlwifi 0000:12:00.0: 0x00000532 | FSEQ_CNVR_ID
[  825.089510] iwlwifi 0000:12:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
[  825.094474] iwlwifi 0000:12:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
[  825.099406] iwlwifi 0000:12:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  825.106099] iwlwifi 0000:12:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  825.113704] iwlwifi 0000:12:00.0: WRT: Collecting data: ini trigger 4 fired.
[  825.113710] ieee80211 wiphy2: Hardware restart was requested
[  826.328717] iwlwifi 0000:12:00.0: Got NSS = 4 - trimming to 2
[  826.328956] iwlwifi 0000:12:00.0: Got NSS = 4 - trimming to 2
[  901.276085] audit: type=1130 audit(1591396747.658:222): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-clean comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  901.276110] audit: type=1131 audit(1591396747.658:223): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-clean comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  961.252627] audit: type=1130 audit(1591396807.635:224): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=sysstat-collect comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  961.252637] audit: type=1131 audit(1591396807.635:225): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=sysstat-collect comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[ 1561.307302] audit: type=1130 audit(1591397407.699:226): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=sysstat-collect comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[ 1561.307306] audit: type=1131 audit(1591397407.699:227): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=sysstat-collect comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'


[root@ct523c-0b29 backport-iwlwifi]# iw wlan2 info
Interface wlan2
	ifindex 18
	wdev 0x800000001
	addr 5c:80:b6:5a:b4:6e
	ssid asus11ax
	type managed
	wiphy 8
	channel 100 (5500 MHz), width: 80 MHz, center1: 5530 MHz
	txpower 22.00 dBm
	multicast TXQ:
		qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
		0	0	0	0	0	0	0	0		0
[root@ct523c-0b29 backport-iwlwifi]# iw wlan2 station dump
Station 0c:9d:92:02:42:e4 (on wlan2)
	inactive time:	350 ms
	rx bytes:	9045670754
	rx packets:	5930616
	tx bytes:	1255064539
	tx packets:	1090264
	tx retries:	199
	tx failed:	0
	beacon loss:	0
	beacon rx:	10455
	rx drop misc:	3
	signal:  	-36 [-40, -36] dBm
	signal avg:	38 dBm
	beacon signal avg:	-36 dBm
	tx bitrate:	245.0 MBit/s 80MHz
	rx bitrate:	6.0 MBit/s
	rx duration:	0 us
	authorized:	yes
	authenticated:	yes
	associated:	yes
	preamble:	long
	WMM/WME:	yes
	MFP:		no
	TDLS peer:	no
	DTIM period:	3
	beacon interval:100
	short slot time:yes
	connected time:	1398 seconds


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
