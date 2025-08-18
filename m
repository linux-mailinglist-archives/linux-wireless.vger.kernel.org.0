Return-Path: <linux-wireless+bounces-26430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B94B29D40
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 11:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD7A188A70D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467630DD1B;
	Mon, 18 Aug 2025 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XzGyshae"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B51448E0;
	Mon, 18 Aug 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508099; cv=none; b=eZTdHxqKVO43u2kZ5RWyyITsNk3kaQcLDw8gvvYslZ0a6Ketqh1BMeQBr2MIe6A2JnOElQpR6DpuRg2SPAIwo3o21i7oRqr2t/EkyLm9p4+SqUZPEnpLwJET6q2nQJVmyBHd9VPh0vpb51HwD8EqwqFTUHuP9HWW1C4ZzxB66aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508099; c=relaxed/simple;
	bh=2LbWQK8Kc8UCPCh2fjkzzVPtNWfS2kuYCyAxRMAZsik=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=Snm6UMLehEKaMzsZFyVcM/TOE0fbLJQtL3KSz3wtz2hvoadu+5EU1eIqYfwZPDxTY3Zab/gPHbt7fmBux+S/C9zQUPo4gkdRTPF9uPRE5yN/tKZBE7EJCkuJWqbGOeI93gTj9Ck5DrYx0OTdACzCUSijTY3fOyXkMcwqjz67yqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XzGyshae; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0652E1F687;
	Mon, 18 Aug 2025 09:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755508091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jU3tF0J7LfwgksEPD3q4t3xFSzgLn5j5SLP44/fRVCE=;
	b=XzGyshaebytuvOUIcG1fCNEFcBfaPlP6eMUaU2raidQ8hywJL82NZJIWez57cyX0QxNijG
	oWH5DUosl5rw564o5vU/RPmYBfOSdJr55kfNlsBu+YuJ13mTGjQivw1Hc6cMlxSxVJ9k1Y
	k2L2APZuIkMMG4WnpVMhaWEeD2KECxa60YnRw4wt2aHQ+haQS+YzLENvJ84UCIsi33qUrJ
	VWQjm+/uEJnkglwZlEna0Xwwl3ASIN68Zpgf0OtTWvYN1VY+P7ki5eBTeyCK/8DVNcFe6z
	j/xoL3U8/KtglyjJfXPDlIMn6ib4FK4h6K5tcOfzfXOq0N3o2oejd1CCH9EyqA==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 11:08:10 +0200
Message-Id: <DC5FOJFIFQQ5.1EDUTV272ZXVQ@bootlin.com>
Cc: "Fariya Fatima" <fariyaf@gmail.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ingo Molnar" <mingo@kernel.org>, "Kalle Valo"
 <kvalo@kernel.org>, "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
 "Johannes Berg" <johannes.berg@intel.com>, "Roopni Devanathan"
 <quic_rdevanat@quicinc.com>
Subject: rsi_91x: unresponsive chip after a few seconds
From: "Thomas Bonnefille" <thomas.bonnefille@bootlin.com>
To: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofesthhqredtredtjeenucfhrhhomhepfdfvhhhomhgrshcuuehonhhnvghfihhllhgvfdcuoehthhhomhgrshdrsghonhhnvghfihhllhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvffegkedvjefftedtieffteehffeutdfgieefveehkedutdffueduteeigfdukeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepthhhohhmrghsrdgsohhnnhgvfhhilhhlvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrghrihihrghfsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhon
 hhigidruggvpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvrghloheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhjrghilhhlvghtseifrghnrgguohhordhfrhdprhgtphhtthhopehjohhhrghnnhgvshdrsggvrhhgsehinhhtvghlrdgtohhm
X-GND-Sasl: thomas.bonnefille@bootlin.com

Hello,

I'm using a hardware platform that is composed of the RS9116 Bluetooth/WiFi
chip connected over SDIO to an NXP i.MX7 processor (itself located on a
Toradex Colibri SoM, if that matters).=20

I've been trying to enable Bluetooth support using the upstream rsi_91x,
without luck. However, it is important to note that my hardware works fine
with the vendor driver at https://github.com/SiliconLabs/RS911X-nLink-OSD/
so I'm confident that the hardware is OK. However, for obvious reasons, I
would very much prefer using the upstream rsi_91x driver.

I have the rs9116_wlan_bt_classic.rps firmware cloned from the latest
linux-firmware commit installed in /lib/firmware/rsi (it hasn't been
updated since it was added).

Once booted, I'm able to make some basic operations with bluetoothctl until
at some point (10s~5min), the Bluetooth chip stops answering :
```
root@colibri-imx7-emmc-recovery-mode:~# rfkill unblock all
[   26.814209] rsi_91x: =3D=3D=3D> Interface UP <=3D=3D=3D
[   26.814381] rsi_91x: rsi_disable_ps: Cannot accept disable PS in PS_NONE=
 state
root@colibri-imx7-emmc-recovery-m[   26.816874] rsi_91x: rsi_disable_ps: Ca=
nnot accept disable PS in PS_NONE state
ode:~#=20
root@colibri-imx7-emmc-recovery-mode:~# hciconfig hci0 up
root@colibri-imx7-emmc-recovery-mode:~# bluetoothctl=20
Agent registered
[CHG] Controller 80:C9:55:C2:E7:3A Pairable: yes
[bluetooth]# scan on =20
Discovery started
[CHG] Controller 80:C9:55:C2:E7:3A Discovering: yes
[NEW] Device 4D:3B:C7:21:7A:5C 4D-3B-C7-21-7A-5C
[NEW] Device 42:E1:0E:2D:61:40 42-E1-0E-2D-61-40
[bluetooth]# [   99.751498] Bluetooth: hci0: Unknown advertising packet typ=
e: 0x18
[NEW] Device C8:9B:D7:08:B6:B0 realmeThomas
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001105-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001112-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001115-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001116-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000112f-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001132-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49eee15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49eaa15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49ecc15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00000000-0000-0000-0000-000000000000
[bluetooth]# connect C8:9B:D7:08:B6:B0=20
Attempting to connect to C8:9B:D7:08:B6:B0
[CHG] Device C8:9B:D7:08:B6:B0 Connected: yes
[CHG] Device C8:9B:D7:08:B6:B0 Modalias: bluetooth:v0046p1200d1436
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001105-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001112-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001115-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001116-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000112f-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001132-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000aa15-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49eaa15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49ecc15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49eee15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 ServicesResolved: yes
Failed to connect: org.bluez.Error.Failed
[realmeThomas]# [   99.925232] Bluetooth: hci0: Unknown advertising packet =
type: 0x18
[realmeThomas]# [  111.103509] Bluetooth: hci0: unexpected event 0xff lengt=
h: 344 > 260
[  114.741141] rsi_91x: rsi_sdio_write_register_multiple: Synch Cmd53 write=
 failed -110
[  114.741235] rsi_91x: rsi_sdio_host_intf_write_pkt: Unable to write onto =
the card: -110
[  114.741286] rsi_91x: rsi_send_bt_pkt: Failed to write bt pkt
[realmeThomas]# [  116.315341] rsi_91x: rsi_sdio_write_register_multiple: S=
topping card writes
[  118.395235] Bluetooth: hci0: Opcode 0x2042 failed: -110
[  118.395310] Bluetooth: hci0: Unable to disable scanning: -110
[  118.395368] Bluetooth: hci0: command 0x2042 tx timeout
[  118.398297] rsi_91x: rsi_sdio_write_register_multiple: Stopping card wri=
tes
[  120.475236] Bluetooth: hci0: Opcode 0x0401 failed: -110
[  120.475299] Bluetooth: hci0: command 0x2042 tx timeout
[DEL] Device 4D:3B:C7:21:7A:5C 4D-3B-C7-21-7A-5C
[DEL] Device 42:E1:0E:2D:61:40 42-E1-0E-2D-61-40
[realmeThomas]# [  154.235338] rsi_91x: rsi_sdio_write_register_multiple: S=
topping card writes
[  156.315311] Bluetooth: hci0: command 0x2042 tx timeout
[CHG] Device C8:9B:D7:08:B6:B0 ServicesResolved: no
[CHG] Device C8:9B:D7:08:B6:B0 Connected: no
[DEL] Device C8:9B:D7:08:B6:B0 realmeThomas
[bluetooth]# quit
root@colibri-imx7-emmc-recovery-mode:~# [  652.912255] rsi_91x: rsi_sdio_wr=
ite_register_multiple: Stopping card writes
ls [  654.955238] Bluetooth: hci0: Opcode 0x2042 failed: -110
[  654.955314] Bluetooth: hci0: Unable to disable scanning: -110
[  654.955702] Bluetooth: hci0: command 0x2042 tx timeout
```

After this I can't communicate with the chip anymore before a complete
reboot :

```
[bluetooth]# discoverable on
[bluetooth]# [ 1749.097230] rsi_91x: rsi_sdio_write_register_multiple: Stop=
ping card writes
[ 1751.115227] Bluetooth: hci0: Opcode 0x0c1a failed: -110
[ 1751.115349] Bluetooth: hci0: command 0x2042 tx timeout
[ 1751.116152] rsi_91x: rsi_sdio_write_register_multiple: Stopping card wri=
tes
[ 1753.195234] Bluetooth: hci0: command 0x2042 tx timeout
[ 1753.195333] Bluetooth: hci0: Opcode 0x0c3a failed: -110
Failed to set discoverable on: org.bluez.Error.Failed
```

Is this problem known? Any hints on investigating further this isssue?
For the record, the exact same kernel, but with the vendor driver for the
WiFi/BT chip works which normally rules out an issue in the SDIO/MMC
controller driver.                                                         =
                  =20
For completeness, I'm providing below the complete boot logs and kernel
configuration, in case it can be helpful.
Thanks a lot!

Thomas

Here are the full logs :
```
Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.16.0-11489-gd2eedaa3909b (thomas@FWThomasV) =
(arm-linux-gcc.br_real (Buildroot 2021.11-12449-g1bef613319) 13.3.0, GNU ld=
 (GNU Binutils) 2.41) #128 SMP Mon Aug  4 15:47:01 CEST 2025
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D10c=
5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] OF: fdt: Machine model: Toradex Colibri iMX7D 1GB (eMMC) on =
Colibri Evaluation Board V3
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 64 MiB at 0xbc000000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000080000000-0x00000000afffffff]
[    0.000000]   HighMem  [mem 0x00000000b0000000-0x00000000bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000bffff=
fff]
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node i=
n the DT
[    0.000000] percpu: Embedded 14 pages/cpu s27212 r8192 d21940 u57344
[    0.000000] Kernel command line: root=3DPARTUUID=3Dcaeb09cf-02 ro rootwa=
it console=3Dtty1 console=3Dttymxc0,115200n8 consoleblank=3D0
[    0.000000] printk: log buffer data + meta data: 262144 + 819200 =3D 108=
1344 bytes
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 26214=
4
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:of=
f
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D=
2.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 1=
0 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.000000] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D2.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] arch_timer: cp15 timer(s) running at 8.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cy=
cles: 0x1d854df40, max_idle_ns: 440795202120 ns
[    0.000002] sched_clock: 56 bits at 8MHz, resolution 125ns, wraps every =
2199023255500ns
[    0.000018] Switching to timer-based delay loop, resolution 125ns
[    0.000554] Switching to timer-based delay loop, resolution 41ns
[    0.000569] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every =
89478484971ns
[    0.000586] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffff=
ffff, max_idle_ns: 79635851949 ns
[    0.002230] Console: colour dummy device 80x30
[    0.002253] printk: legacy console [tty1] enabled
[    0.002841] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 48.00 BogoMIPS (lpj=3D240000)
[    0.002887] CPU: Testing write buffer coherency: ok
[    0.002970] pid_max: default: 32768 minimum: 301
[    0.003164] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, =
linear)
[    0.003212] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes, linear)
[    0.004316] CPU0: update cpu_capacity 1024
[    0.004359] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.004415] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.006070] Setting up static identity map for 0x80100000 - 0x80100078
[    0.006345] rcu: Hierarchical SRCU implementation.
[    0.006376] rcu: 	Max phase no-delay instances is 1000.
[    0.006833] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.007495] smp: Bringing up secondary CPUs ...
[    0.008643] CPU1: update cpu_capacity 1024
[    0.008660] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.008916] smp: Brought up 1 node, 2 CPUs
[    0.008981] SMP: Total of 2 processors activated (96.00 BogoMIPS).
[    0.009009] CPU: All CPU(s) started in SVC mode.
[    0.009588] Memory: 947840K/1048576K available (15360K kernel code, 1299=
K rwdata, 4316K rodata, 1024K init, 391K bss, 32484K reserved, 65536K cma-r=
eserved, 196608K highmem)
[    0.010247] devtmpfs: initialized
[    0.021360] VFP support v0.3: implementor 41 architecture 2 part 30 vari=
ant 7 rev 5
[    0.021933] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 19112604462750000 ns
[    0.022000] posixtimers hash table entries: 1024 (order: 1, 8192 bytes, =
linear)
[    0.022089] futex hash table entries: 512 (32768 bytes on 1 NUMA nodes, =
total 32 KiB, linear).
[    0.023308] pinctrl core: initialized pinctrl subsystem
[    0.025509] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.032478] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.034153] thermal_sys: Registered thermal governor 'step_wise'
[    0.034286] cpuidle: using governor menu
[    0.034929] No ATAGs?
[    0.035061] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchp=
oint registers.
[    0.035099] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.045780] /soc/funnel@30041000: Fixed dependency cycle(s) with /soc/fu=
nnel@30083000
[    0.045858] /soc/funnel@30041000: Fixed dependency cycle(s) with /soc/et=
m@3007d000
[    0.045909] /soc/funnel@30041000: Fixed dependency cycle(s) with /soc/et=
m@3007c000
[    0.046001] /soc/etm@3007c000: Fixed dependency cycle(s) with /soc/funne=
l@30041000
[    0.046074] /soc/funnel@30083000: Fixed dependency cycle(s) with /soc/et=
f@30084000
[    0.046134] /soc/funnel@30083000: Fixed dependency cycle(s) with /soc/fu=
nnel@30041000
[    0.046203] /soc/etf@30084000: Fixed dependency cycle(s) with /replicato=
r
[    0.046379] /soc/etf@30084000: Fixed dependency cycle(s) with /soc/funne=
l@30083000
[    0.046471] /soc/etr@30086000: Fixed dependency cycle(s) with /replicato=
r
[    0.046548] /soc/tpiu@30087000: Fixed dependency cycle(s) with /replicat=
or
[    0.046593] /soc/interrupt-controller@31001000: Fixed dependency cycle(s=
) with /soc/interrupt-controller@31001000
[    0.047266] /soc/etm@3007d000: Fixed dependency cycle(s) with /soc/funne=
l@30041000
[    0.050206] /soc/bus@30000000/pinctrl@302c0000: Fixed dependency cycle(s=
) with /soc/bus@30000000/pinctrl@302c0000/gpiolpsrgrp
[    0.050480] imx7d-pinctrl 302c0000.pinctrl: initialized IMX pinctrl driv=
er
[    0.051151] /soc/bus@30000000/pinctrl@30330000: Fixed dependency cycle(s=
) with /soc/bus@30000000/pinctrl@30330000/gpio4grp
[    0.051214] /soc/bus@30000000/pinctrl@30330000: Fixed dependency cycle(s=
) with /soc/bus@30000000/pinctrl@30330000/gpio3grp
[    0.051268] /soc/bus@30000000/pinctrl@30330000: Fixed dependency cycle(s=
) with /soc/bus@30000000/pinctrl@30330000/gpio2grp
[    0.051321] /soc/bus@30000000/pinctrl@30330000: Fixed dependency cycle(s=
) with /soc/bus@30000000/pinctrl@30330000/gpio1grp
[    0.052036] imx7d-pinctrl 30330000.pinctrl: initialized IMX pinctrl driv=
er
[    0.072968] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.078633] SCSI subsystem initialized
[    0.079376] usbcore: registered new interface driver usbfs
[    0.079463] usbcore: registered new interface driver hub
[    0.079536] usbcore: registered new device driver usb
[    0.079726] usb_phy_generic usbphynop1: dummy supplies not allowed for e=
xclusive requests (id=3Dvbus)
[    0.080131] usb_phy_generic usbphynop2: dummy supplies not allowed for e=
xclusive requests (id=3Dvbus)
[    0.081348] mc: Linux media interface: v0.10
[    0.081465] videodev: Linux video capture interface: v2.00
[    0.081630] pps_core: LinuxPPS API ver. 1 registered
[    0.081661] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.081712] PTP clock support registered
[    0.082432] Advanced Linux Sound Architecture Driver Initialized.
[    0.083654] Bluetooth: Core ver 2.22
[    0.083752] NET: Registered PF_BLUETOOTH protocol family
[    0.083780] Bluetooth: HCI device and connection manager initialized
[    0.083813] Bluetooth: HCI socket layer initialized
[    0.083841] Bluetooth: L2CAP socket layer initialized
[    0.083884] Bluetooth: SCO socket layer initialized
[    0.084649] vgaarb: loaded
[    0.085191] clocksource: Switched to clocksource arch_sys_counter
[    0.085580] VFS: Disk quotas dquot_6.6.0
[    0.085637] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.099070] NET: Registered PF_INET protocol family
[    0.099428] IP idents hash table entries: 16384 (order: 5, 131072 bytes,=
 linear)
[    0.102027] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, =
4096 bytes, linear)
[    0.102097] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.102141] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes, linear)
[    0.102334] TCP bind hash table entries: 8192 (order: 5, 131072 bytes, l=
inear)
[    0.102617] TCP: Hash tables configured (established 8192 bind 8192)
[    0.102782] UDP hash table entries: 512 (order: 2, 28672 bytes, linear)
[    0.102888] UDP-Lite hash table entries: 512 (order: 2, 28672 bytes, lin=
ear)
[    0.103153] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.103847] RPC: Registered named UNIX socket transport module.
[    0.103890] RPC: Registered udp transport module.
[    0.103913] RPC: Registered tcp transport module.
[    0.103934] RPC: Registered tcp-with-tls transport module.
[    0.103955] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.106053] PCI: CLS 0 bytes, default 64
[    0.107412] Initialise system trusted keyrings
[    0.107773] workingset: timestamp_bits=3D30 max_order=3D18 bucket_order=
=3D0
[    0.108551] NFS: Registering the id_resolver key type
[    0.108660] Key type id_resolver registered
[    0.108685] Key type id_legacy registered
[    0.108735] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.108765] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...
[    0.108864] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    0.109247] fuse: init (API version 7.44)
[    0.408771] Key type asymmetric registered
[    0.408813] Asymmetric key parser 'x509' registered
[    0.408909] io scheduler mq-deadline registered
[    0.408938] io scheduler kyber registered
[    0.408982] io scheduler bfq registered
[    0.423105] 30860000.serial: ttymxc0 at MMIO 0x30860000 (irq =3D 30, bas=
e_baud =3D 1500000) is a IMX
[    0.423224] printk: console [ttymxc0] enabled
[    1.385338] 30890000.serial: ttymxc1 at MMIO 0x30890000 (irq =3D 31, bas=
e_baud =3D 1500000) is a IMX
[    1.386844] 30880000.serial: ttymxc2 at MMIO 0x30880000 (irq =3D 32, bas=
e_baud =3D 1500000) is a IMX
[    1.414993] brd: module loaded
[    1.422822] loop: module loaded
[    1.429160] CAN device driver interface
[    1.431032] usbcore: registered new device driver r8152-cfgselector
[    1.431136] usbcore: registered new interface driver r8152
[    1.431227] usbcore: registered new interface driver lan78xx
[    1.431337] usbcore: registered new interface driver asix
[    1.431431] usbcore: registered new interface driver ax88179_178a
[    1.431522] usbcore: registered new interface driver cdc_ether
[    1.431612] usbcore: registered new interface driver smsc95xx
[    1.431710] usbcore: registered new interface driver net1080
[    1.431809] usbcore: registered new interface driver cdc_subset
[    1.431904] usbcore: registered new interface driver zaurus
[    1.431997] usbcore: registered new interface driver MOSCHIP usb-etherne=
t driver
[    1.432096] usbcore: registered new interface driver cdc_ncm
[    1.432197] usbcore: registered new interface driver r8153_ecm
[    1.432365] usbcore: registered new interface driver usb-storage
[    1.432665] usbcore: registered new device driver onboard-usb-dev
[    1.440884] snvs_rtc 30370000.snvs:snvs-rtc-lp: registered as rtc1
[    1.441144] i2c_dev: i2c /dev entries driver
[    1.442295] pxp 30700000.pxp: Device registered as /dev/video0
[    1.446747] Bluetooth: HCI UART driver ver 2.3
[    1.446801] Bluetooth: HCI UART protocol H4 registered
[    1.446875] Bluetooth: HCI UART protocol LL registered
[    1.447011] Bluetooth: HCI UART protocol Broadcom registered
[    1.447289] CPUidle arm: CPU 0 failed to init idle CPU ops
[    1.447541] CPUidle PSCI: Failed to create psci-cpuidle device
[    1.447945] sdhci: Secure Digital Host Controller Interface driver
[    1.447978] sdhci: Copyright(c) Pierre Ossman
[    1.448001] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.449905] caam 30900000.crypto: RNG4 SH0 was previously instantiated w=
ithout prediction resistance. Tearing it down
[    1.449980] caam 30900000.crypto: Deinstantiated RNG4 SH0
[    1.450024] caam 30900000.crypto: Instantiated RNG4 SH0
[    1.450052] caam 30900000.crypto: RNG4 SH1 was previously instantiated w=
ithout prediction resistance. Tearing it down
[    1.450096] caam 30900000.crypto: Deinstantiated RNG4 SH1
[    1.509444] caam 30900000.crypto: Instantiated RNG4 SH1
[    1.509718] caam 30900000.crypto: device ID =3D 0x0a16030000000000 (Era =
8)
[    1.509760] caam 30900000.crypto: job rings =3D 3, qi =3D 0
[    1.528859] caam algorithms registered in /proc/crypto
[    1.529093] caam 30900000.crypto: caam pkc algorithms registered in /pro=
c/crypto
[    1.529136] caam 30900000.crypto: registering rng-caam
[    1.570498] caam 30900000.crypto: rng crypto API alg registered prng-caa=
m
[    1.608941] usbcore: registered new interface driver usbhid
[    1.608994] usbhid: USB HID core driver
[    1.629479] hw perfevents: enabled with armv7_cortex_a7 PMU driver, 5 (8=
000000f) counters available
[    1.640898] NET: Registered PF_INET6 protocol family
[    1.642638] Segment Routing with IPv6
[    1.642740] In-situ OAM (IOAM) with IPv6
[    1.642854] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.643737] NET: Registered PF_PACKET protocol family
[    1.643798] can: controller area network core
[    1.643874] NET: Registered PF_CAN protocol family
[    1.643906] can: raw protocol
[    1.643933] can: broadcast manager protocol
[    1.643964] can: netlink gateway - max_hops=3D1
[    1.644100] Key type dns_resolver registered
[    1.644751] imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 2 mkt segment=
 1 supported-hw 0x4 0x2
[    1.645433] Registering SWP/SWPB emulation handler
[    1.661423] Loading compiled-in X.509 certificates
[    1.689908] random: crng init done
[    1.705583] gpio gpiochip0: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    1.708650] gpio gpiochip1: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    1.711250] gpio gpiochip2: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    1.713914] gpio gpiochip3: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    1.716575] gpio gpiochip4: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    1.719087] gpio gpiochip5: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    1.721574] gpio gpiochip6: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    1.727984] usb_phy_generic usbphynop3: dummy supplies not allowed for e=
xclusive requests (id=3Dvbus)
[    1.729316] i2c i2c-0: using pinctrl states for GPIO recovery
[    1.729513] i2c i2c-0: using generic GPIOs for recovery
[    1.819172] i2c i2c-0: IMX I2C adapter registered
[    1.821208] i2c i2c-3: using pinctrl states for GPIO recovery
[    1.821374] i2c i2c-3: using generic GPIOs for recovery
[    1.855896] rtc-ds1307 3-0068: registered as rtc0
[    1.861582] rtc-ds1307 3-0068: setting system clock to 2025-08-06T12:14:=
32 UTC (1754482472)
[    1.861771] i2c i2c-3: IMX I2C adapter registered
[    1.867064] mxs-dma 33000000.dma-controller: initialized
[    1.875243] ci_hdrc ci_hdrc.0: EHCI Host Controller
[    1.875333] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus numb=
er 1
[    1.905218] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[    1.905580] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.16
[    1.905625] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.905660] usb usb1: Product: EHCI Host Controller
[    1.905686] usb usb1: Manufacturer: Linux 6.16.0-11489-gd2eedaa3909b ehc=
i_hcd
[    1.905714] usb usb1: SerialNumber: ci_hdrc.0
[    1.906616] hub 1-0:1.0: USB hub found
[    1.906705] hub 1-0:1.0: 1 port detected
[    1.911864] sdhci-esdhc-imx 30b40000.mmc: Got CD GPIO
[    1.956601] sgtl5000 0-000a: sgtl5000 revision 0x11
[    1.962120] mmc0: SDHCI controller on 30b60000.mmc [30b60000.mmc] using =
ADMA
[    1.962539] mmc1: SDHCI controller on 30b40000.mmc [30b40000.mmc] using =
ADMA
[    1.992912] mmc1: new high speed SDIO card at address fffd
[    2.020927] fec 30be0000.ethernet eth0: registered PHC device 0
[    2.027737] usbmisc_imx 30b10200.usbmisc: vbus is error
[    2.027802] usbmisc_imx 30b10200.usbmisc: Error occurs during detection:=
 -22
[    2.030125] imx_thermal 30360000.anatop:tempmon: Extended Commercial CPU=
 temperature grade - max:105C critical:100C passive:95C
[    2.043075] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    2.047727] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    2.052003] Problem loading in-kernel X.509 certificate (-22)
[    2.058837] Problem loading in-kernel X.509 certificate (-22)
[    2.058899] clk: Disabling unused clocks
[    2.059769] faux_driver regulatory: Direct firmware load for regulatory.=
db failed with error -2
[    2.059821] cfg80211: failed to load regulatory.db
[    2.071971] ALSA device list:
[    2.072005]   No soundcards found.
[    2.072431] check access for rdinit=3D/init failed: -2, ignoring
[    2.072520] Waiting for root device PARTUUID=3Dcaeb09cf-02...
[    2.261763] mmc0: new HS400 MMC card at address 0001
[    2.265614] mmcblk0: mmc0:0001 S40004 3.64 GiB
[    2.271832]  mmcblk0: p1 p2
[    2.272704] mmcblk0boot0: mmc0:0001 S40004 4.00 MiB
[    2.282857] mmcblk0boot1: mmc0:0001 S40004 4.00 MiB
[    2.290596] mmcblk0rpmb: mmc0:0001 S40004 4.00 MiB, chardev (242:0)
[    2.312772] EXT4-fs (mmcblk0p2): mounted filesystem a99f6e9f-d8dc-41e4-a=
fcc-6a1cee1856d0 ro with ordered data mode. Quota mode: none.
[    2.312946] VFS: Mounted root (ext4 filesystem) readonly on device 179:2=
.
[    2.331917] devtmpfs: mounted
[    2.336777] Freeing unused kernel image (initmem) memory: 1024K
[    2.343055] Run /sbin/init as init process
[    2.468269] systemd[1]: systemd 244.5+ running in system mode. (+PAM -AU=
DIT -SELINUX +IMA -APPARMOR -SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -GCRYPT -=
GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN2 -IDN -PCRE2 defa=
ult-hierarchy=3Dhybrid)
[    2.469020] systemd[1]: Detected architecture arm.
[    2.469221] /proc/cgroups lists only v1 controllers, use cgroup.controll=
ers of root cgroup for v2 info

Welcome to TDX Wayland with XWayland 5.7.6-devel-20250613150609+build.0 (du=
nfell)!

[    2.538721] systemd[1]: Set hostname to <colibri-imx7-emmc-recovery-mode=
>.
[    3.072829] systemd[1]: Created slice system-getty.slice.
[  OK  ] Created slice system-getty.slice.
[    3.096100] systemd[1]: Created slice system-serial\x2dgetty.slice.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[    3.136051] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[    3.165737] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[  OK  ] Started Dispatch Password =E2=80=A6ts to Console Directory Watch.
[    3.195694] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[  OK  ] Started Forward Password R=E2=80=A6uests to Wall Directory Watch.
[    3.225674] systemd[1]: Reached target Host and Network Name Lookups.
[  OK  ] Reached target Host and Network Name Lookups.
[    3.255406] systemd[1]: Reached target Paths.
[  OK  ] Reached target Paths.
[    3.275454] systemd[1]: Reached target Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[    3.305469] systemd[1]: Reached target Slices.
[  OK  ] Reached target Slices.
[    3.325514] systemd[1]: Reached target Swap.
[  OK  ] Reached target Swap.
[    3.378280] systemd[1]: Listening on RPCbind Server Activation Socket.
[  OK  ] Listening on RPCbind Server Activation Socket.
[    3.405517] systemd[1]: Reached target RPC Port Mapper.
[  OK  ] Reached target RPC Port Mapper.
[    3.449574] systemd[1]: syslog.socket: SO_PASSSEC failed: Operation not =
supported
[    3.449745] systemd[1]: Listening on Syslog Socket.
[  OK  ] Listening on Syslog Socket.
[    3.495884] systemd[1]: Listening on initctl Compatibility Named Pipe.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[    3.530841] systemd[1]: Condition check resulted in Journal Audit Socket=
 being skipped.
[    3.531970] systemd[1]: systemd-journald-dev-log.socket: SO_PASSSEC fail=
ed: Operation not supported
[  OK  ] Listening on [    3.532195] systemd[1]: Listening on Journal Socke=
t (/dev/log).
Journal Socket (/dev/log).
[    3.586023] systemd[1]: systemd-journald.socket: SO_PASSSEC failed: Oper=
ation not supported
[    3.586283] systemd[1]: systemd-journald.socket: SO_PASSSEC failed: Oper=
ation not supported
[    3.586414] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[    3.626929] systemd[1]: Listening on Network Service Netlink Socket.
[  OK  ] Listening on Network Service Netlink Socket.
[    3.656221] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[    3.685807] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[    3.716096] systemd[1]: Condition check resulted in Huge Pages File Syst=
em being skipped.
[    3.716738] systemd[1]: Condition check resulted in POSIX Message Queue =
File System being skipped.
[    3.745767] systemd[1]: Mounting Kernel Debug File System...
         Mounting Kernel Debug File System...
[    3.779373] systemd[1]: Mounting Temporary Directory (/tmp)...
         Mounting Temporary Directory (/tmp)...
[    3.805983] systemd[1]: Condition check resulted in Create list of stati=
c device nodes for the current kernel being skipped.
[    3.820879] systemd[1]: Starting RPC Bind...
         Starting RPC Bind...
[    3.849252] systemd[1]: Starting File System Check on Root Device...
         Starting File System Check on Root Device...
[    3.882515] systemd[1]: Starting Journal Service...
         Starting Journal Service...
         Starting Load Kernel Modules...
[    3.901483] systemd[1]: Starting Load Kernel Modules...
[    3.916103] systemd[1]: Starting udev Coldplug all Devices...
         Starting udev Coldplug all Devices...
[    3.952271] systemd[1]: Started RPC Bind.
[  OK  ] Started     3.957254] systemd[1]: Mounted Kernel Debug File System=
.
;39mRPC Bind.
[  OK  ] Mount[    3.965682] systemd[1]: Mounted Temporary Directory (/tmp)=
.
ed Kernel Debug File Sys[    3.976144] systemd[1]: Started Load Kernel Modu=
les.
tem.
[  OK  ] Mounted Temporary Directory (/tmp).
[  OK  ] Started Load Kernel Modules.
         Mounting FUSE Control File System...
[    4.013588] systemd[1]: Mounting FUSE Control File System...
[    4.038621] systemd[1]: Mounting Kernel Configuration File System...
         Mounting Kernel Configuration File System...
[    4.078427] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[    4.108755] systemd[1]: Started Journal Service.
[  OK  ] Started Journal Service.
[  OK  ] Started File System Check on Root Device.
[  OK  ] Mounted FUSE Control File System.
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Started Apply Kernel Variables.
         Starting Remount Root and Kernel File Systems...
[    4.330580] EXT4-fs (mmcblk0p2): re-mounted a99f6e9f-d8dc-41e4-afcc-6a1c=
ee1856d0 r/w.
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting Flush Journal to Persistent Storage...
         Starting Create Static Device Nodes in /dev...
[    4.411825] systemd-journald[100]: Received client request to flush runt=
ime journal.
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started Create Static Device Nodes in /dev.
[  OK  ] Reached target Local File Systems (Pre).
         Mounting /var/volatile...
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Mounted /var/volatile.
         Starting Load/Save Random Seed...
[  OK  ] Reached target Local File Systems.
         Starting Create Volatile Files and Directories...
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Create Volatile Files and Directories.
         Starting Network Time Synchronization...
         Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Started Network Time Synchronization.
[  OK  ] Reached target System Initialization.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Reached target System Time Set.
[  OK  ] Reached target System Time Synchronized.
[  OK  ] Reached target Timers.
[  OK  ] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Listening on dropbear.socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
[    5.528350] imx-sdma 30bd0000.dma-controller: loaded firmware 4.5
[  OK  ] Started Kernel Logging Service.
[  OK  ] Started System Logging Servic[    5.604504] rsi_91x: rsi_probe: 91=
16 module detected
e.
[    5.639906] rsi_91x: rsi_load_9116_firmware: Loading chunk 0
[    5.641336] rsi_91x: rsi_load_9116_firmware: Loading chunk 1
[  OK  ] Started D-Bus System Message Bus.
[    5.699840] rsi_91x: rsi_load_9116_firmware: Loading chunk 2
         Starting IPv6 Packet Filtering Framework...
         Starting IPv4 Packet Filtering Framework...
         Starting Telephony service...
         Starting Login Service...
[  OK  ] Started Timestamping service.
[  OK  ] Started IPv6 Packet Filtering Framework.
[  OK  ] Started IPv4 Packet Filtering Framework.
[    6.462247] rsi_91x: Max Stations Allowed =3D 1
[  OK  ] Started Telephony service.
[    7.211140] FAT-fs (mmcblk0p1): Volume was not properly unmounted. Some =
data may be corrupt. Please run fsck.
[  OK  ] Started Login Service.
[  OK  ] Reached target Network (Pre).
[  OK  ] Reached target Hardware activated USB gadget.
[  OK  ] Listening on Load/Save RF =E2=80=A6itch Status /dev/rfkill Watch.
         Starting Save/Restore Sound Card State...
         Starting Bluetooth service...
         Starting Connection service...
         Starting Network Service...
[  OK  ] Started Save/Restore Sound Card State.
[  OK  ] Reached target Sound Card.
         Starting Load/Save RF Kill Switch Status...
[  OK  ] Started Load/Save RF Kill Switch Status.
[  OK  ] Started     8.046350] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
;39mBluetooth service.
[    8.046438] Bluetooth: BNEP socket layer initialized
[  OK  ] Started Network Service.
[  OK  ] Reached target Bluetooth.
[    8.094768] Bluetooth: MGMT ver 1.23
[  OK  ] Started Connection service.
[  OK  ] Reached target Network.
[    8.198064] Micrel KSZ8041 30be0000.ethernet-1:00: attached PHY driver (=
mii_bus:phy_addr=3D30be0000.ethernet-1:00, irq=3DPOLL)
         Starting Avahi mDNS/DNS-SD Stack...
         Starting Hostname Service...
         Starting Permit User Sessions...
[  OK  ] Started Avahi mDNS/DNS-SD Stack.
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Getty on tty1.
[  OK  ] Started Serial Getty on ttymxc0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Reached target Multi-User System.
         Starting Update UTMP about System Runlevel Changes...
         Starting WPA supplicant...
[  OK  ] Started Hostname Service.
[  OK  ] Started WPA supplicant.
[  OK  ] Started Update UTMP about System Runlevel Changes.

TDX Wayland with XWayland 5.7.6-devel-20250804132959+build.0 (dunfell) coli=
bri-imx7-emmc-recovery-mode ttymxc0
Colibri-iMX7-eMMC_Reference-Minimal-Image

colibri-imx7-emmc-recovery-mode login: [   18.076809] sched: DL replenish l=
agged too much
root
root@colibri-imx7-emmc-recovery-mode:~# rfkill unblock all
[   26.814209] rsi_91x: =3D=3D=3D> Interface UP <=3D=3D=3D
[   26.814381] rsi_91x: rsi_disable_ps: Cannot accept disable PS in PS_NONE=
 state
root@colibri-imx7-emmc-recovery-m[   26.816874] rsi_91x: rsi_disable_ps: Ca=
nnot accept disable PS in PS_NONE state
ode:~#=20
root@colibri-imx7-emmc-recovery-mode:~# hciconfig hci0 up
root@colibri-imx7-emmc-recovery-mode:~# bluetoothctl=20
Agent registered
[CHG] Controller 80:C9:55:C2:E7:3A Pairable: yes
[bluetooth]# scan on =20
Discovery started
[CHG] Controller 80:C9:55:C2:E7:3A Discovering: yes
[NEW] Device 4D:3B:C7:21:7A:5C 4D-3B-C7-21-7A-5C
[NEW] Device 42:E1:0E:2D:61:40 42-E1-0E-2D-61-40
[bluetooth]# [   99.751498] Bluetooth: hci0: Unknown advertising packet typ=
e: 0x18
[NEW] Device C8:9B:D7:08:B6:B0 realmeThomas
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001105-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001112-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001115-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001116-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000112f-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001132-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49eee15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49eaa15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49ecc15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00000000-0000-0000-0000-000000000000
[bluetooth]# connect C8:9B:D7:08:B6:B0=20
Attempting to connect to C8:9B:D7:08:B6:B0
[CHG] Device C8:9B:D7:08:B6:B0 Connected: yes
[CHG] Device C8:9B:D7:08:B6:B0 Modalias: bluetooth:v0046p1200d1436
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001105-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001112-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001115-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001116-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000112f-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001132-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: 0000aa15-0000-1000-8000-00805f9b34fb
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49eaa15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49ecc15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 UUIDs: a49eee15-cb06-495c-9f4f-bb80a90cdf00
[CHG] Device C8:9B:D7:08:B6:B0 ServicesResolved: yes
Failed to connect: org.bluez.Error.Failed
[realmeThomas]# [   99.925232] Bluetooth: hci0: Unknown advertising packet =
type: 0x18
[realmeThomas]# [  111.103509] Bluetooth: hci0: unexpected event 0xff lengt=
h: 344 > 260
[  114.741141] rsi_91x: rsi_sdio_write_register_multiple: Synch Cmd53 write=
 failed -110
[  114.741235] rsi_91x: rsi_sdio_host_intf_write_pkt: Unable to write onto =
the card: -110
[  114.741286] rsi_91x: rsi_send_bt_pkt: Failed to write bt pkt
[realmeThomas]# [  116.315341] rsi_91x: rsi_sdio_write_register_multiple: S=
topping card writes
[  118.395235] Bluetooth: hci0: Opcode 0x2042 failed: -110
[  118.395310] Bluetooth: hci0: Unable to disable scanning: -110
[  118.395368] Bluetooth: hci0: command 0x2042 tx timeout
[  118.398297] rsi_91x: rsi_sdio_write_register_multiple: Stopping card wri=
tes
[  120.475236] Bluetooth: hci0: Opcode 0x0401 failed: -110
[  120.475299] Bluetooth: hci0: command 0x2042 tx timeout
[DEL] Device 4D:3B:C7:21:7A:5C 4D-3B-C7-21-7A-5C
[DEL] Device 42:E1:0E:2D:61:40 42-E1-0E-2D-61-40
[realmeThomas]# [  154.235338] rsi_91x: rsi_sdio_write_register_multiple: S=
topping card writes
[  156.315311] Bluetooth: hci0: command 0x2042 tx timeout
[CHG] Device C8:9B:D7:08:B6:B0 ServicesResolved: no
[CHG] Device C8:9B:D7:08:B6:B0 Connected: no
[bluetooth]#=20
```

and my kernel configuration:
```
CONFIG_SYSVIPC=3Dy
CONFIG_NO_HZ_IDLE=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
CONFIG_BPF_SYSCALL=3Dy
CONFIG_PREEMPT_VOLUNTARY=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_LOG_BUF_SHIFT=3D18
CONFIG_CGROUPS=3Dy
CONFIG_CGROUP_BPF=3Dy
CONFIG_RELAY=3Dy
CONFIG_EXPERT=3Dy
CONFIG_PERF_EVENTS=3Dy
CONFIG_KEXEC=3Dy
CONFIG_ARCH_MULTI_V6=3Dy
CONFIG_ARCH_MXC=3Dy
CONFIG_SOC_IMX31=3Dy
CONFIG_SOC_IMX35=3Dy
CONFIG_SOC_IMX50=3Dy
CONFIG_SOC_IMX51=3Dy
CONFIG_SOC_IMX53=3Dy
CONFIG_SOC_IMX6Q=3Dy
CONFIG_SOC_IMX6SL=3Dy
CONFIG_SOC_IMX6SLL=3Dy
CONFIG_SOC_IMX6SX=3Dy
CONFIG_SOC_IMX6UL=3Dy
CONFIG_SOC_IMX7D=3Dy
CONFIG_SOC_IMX7ULP=3Dy
CONFIG_SOC_VF610=3Dy
CONFIG_SMP=3Dy
CONFIG_ARM_PSCI=3Dy
CONFIG_HIGHMEM=3Dy
CONFIG_ARCH_FORCE_MAX_ORDER=3D13
CONFIG_CMDLINE=3D"noinitrd console=3Dttymxc0,115200"
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
CONFIG_CPUFREQ_DT=3Dy
CONFIG_ARM_IMX6Q_CPUFREQ=3Dy
CONFIG_ARM_IMX_CPUFREQ_DT=3Dy
CONFIG_CPU_IDLE=3Dy
CONFIG_ARM_CPUIDLE=3Dy
CONFIG_ARM_PSCI_CPUIDLE=3Dy
CONFIG_VFP=3Dy
CONFIG_NEON=3Dy
CONFIG_PM_DEBUG=3Dy
CONFIG_PM_TEST_SUSPEND=3Dy
CONFIG_KPROBES=3Dy
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_MODULE_SRCVERSION_ALL=3Dy
CONFIG_BINFMT_MISC=3Dm
# CONFIG_COMPAT_BRK is not set
CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
CONFIG_NETFILTER=3Dy
CONFIG_CAN=3Dy
CONFIG_BT=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_HCIUART=3Dy
CONFIG_BT_HCIUART_LL=3Dy
CONFIG_BT_HCIUART_BCM=3Dy
CONFIG_BT_NXPUART=3Dm
CONFIG_CFG80211=3Dy
CONFIG_CFG80211_WEXT=3Dy
CONFIG_MAC80211=3Dy
CONFIG_RFKILL=3Dy
CONFIG_RFKILL_INPUT=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_MSI=3Dy
CONFIG_PCI_IMX6_HOST=3Dy
CONFIG_DEVTMPFS=3Dy
CONFIG_DEVTMPFS_MOUNT=3Dy
# CONFIG_STANDALONE is not set
CONFIG_IMX_WEIM=3Dy
CONFIG_CONNECTOR=3Dy
CONFIG_MTD=3Dy
CONFIG_MTD_CMDLINE_PARTS=3Dy
CONFIG_MTD_BLOCK=3Dy
CONFIG_MTD_CFI=3Dy
CONFIG_MTD_JEDECPROBE=3Dy
CONFIG_MTD_CFI_INTELEXT=3Dy
CONFIG_MTD_CFI_AMDSTD=3Dy
CONFIG_MTD_CFI_STAA=3Dy
CONFIG_MTD_PHYSMAP=3Dy
CONFIG_MTD_PHYSMAP_OF=3Dy
CONFIG_MTD_DATAFLASH=3Dy
CONFIG_MTD_SST25L=3Dy
CONFIG_MTD_RAW_NAND=3Dy
CONFIG_MTD_NAND_GPMI_NAND=3Dy
CONFIG_MTD_NAND_VF610_NFC=3Dy
CONFIG_MTD_NAND_MXC=3Dy
CONFIG_MTD_SPI_NOR=3Dy
CONFIG_MTD_UBI=3Dy
CONFIG_MTD_UBI_FASTMAP=3Dy
CONFIG_MTD_UBI_BLOCK=3Dy
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D65536
CONFIG_EEPROM_AT24=3Dy
CONFIG_EEPROM_AT25=3Dy
# CONFIG_SCSI_PROC_FS is not set
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_BLK_DEV_BSG is not set
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy
CONFIG_SCSI_SCAN_ASYNC=3Dy
CONFIG_ATA=3Dy
CONFIG_SATA_AHCI_PLATFORM=3Dy
CONFIG_AHCI_IMX=3Dy
CONFIG_PATA_IMX=3Dy
CONFIG_NETDEVICES=3Dy
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_CS89x0_PLATFORM=3Dy
# CONFIG_NET_VENDOR_FARADAY is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_QCA7000_SPI=3Dm
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_SMC91X=3Dy
CONFIG_SMSC911X=3Dy
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_MICREL_PHY=3Dy
CONFIG_AT803X_PHY=3Dy
CONFIG_DP83867_PHY=3Dy
CONFIG_CAN_FLEXCAN=3Dy
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_RTL8152=3Dy
CONFIG_USB_LAN78XX=3Dy
CONFIG_USB_USBNET=3Dy
CONFIG_USB_NET_CDC_EEM=3Dm
CONFIG_USB_NET_SMSC95XX=3Dy
CONFIG_USB_NET_MCS7830=3Dy
CONFIG_ATH10K=3Dm
CONFIG_ATH10K_SDIO=3Dm
CONFIG_BRCMFMAC=3Dm
CONFIG_MWIFIEX=3Dm
CONFIG_MWIFIEX_SDIO=3Dm
CONFIG_MWIFIEX_PCIE=3Dm
CONFIG_RSI_91X=3Dm
CONFIG_WL12XX=3Dm
CONFIG_WL18XX=3Dm
CONFIG_WLCORE_SDIO=3Dm
CONFIG_INPUT_EVDEV=3Dy
CONFIG_KEYBOARD_GPIO=3Dy
CONFIG_KEYBOARD_SNVS_PWRKEY=3Dy
CONFIG_KEYBOARD_IMX=3Dy
CONFIG_MOUSE_PS2=3Dm
CONFIG_MOUSE_PS2_ELANTECH=3Dy
CONFIG_INPUT_TOUCHSCREEN=3Dy
CONFIG_TOUCHSCREEN_ADS7846=3Dy
CONFIG_TOUCHSCREEN_AD7879=3Dy
CONFIG_TOUCHSCREEN_AD7879_I2C=3Dy
CONFIG_TOUCHSCREEN_ATMEL_MXT=3Dy
CONFIG_TOUCHSCREEN_CYTTSP5=3Dy
CONFIG_TOUCHSCREEN_DA9052=3Dy
CONFIG_TOUCHSCREEN_EGALAX=3Dy
CONFIG_TOUCHSCREEN_GOODIX=3Dy
CONFIG_TOUCHSCREEN_ILI210X=3Dy
CONFIG_TOUCHSCREEN_MAX11801=3Dy
CONFIG_TOUCHSCREEN_IMX6UL_TSC=3Dy
CONFIG_TOUCHSCREEN_EDT_FT5X06=3Dy
CONFIG_TOUCHSCREEN_MC13783=3Dy
CONFIG_TOUCHSCREEN_TSC2004=3Dy
CONFIG_TOUCHSCREEN_TSC2007=3Dy
CONFIG_TOUCHSCREEN_STMPE=3Dy
CONFIG_TOUCHSCREEN_SX8654=3Dy
CONFIG_TOUCHSCREEN_COLIBRI_VF50=3Dy
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_MMA8450=3Dy
CONFIG_INPUT_GPIO_BEEPER=3Dm
CONFIG_INPUT_PWM_BEEPER=3Dy
CONFIG_SERIO_SERPORT=3Dm
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_IMX=3Dy
CONFIG_SERIAL_IMX_CONSOLE=3Dy
CONFIG_SERIAL_FSL_LPUART=3Dy
CONFIG_SERIAL_FSL_LPUART_CONSOLE=3Dy
CONFIG_SERIAL_DEV_BUS=3Dy
CONFIG_I2C_CHARDEV=3Dy
CONFIG_I2C_MUX_GPIO=3Dy
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ALGOPCA=3Dm
CONFIG_I2C_GPIO=3Dy
CONFIG_I2C_IMX=3Dy
CONFIG_SPI=3Dy
CONFIG_SPI_FSL_QUADSPI=3Dy
CONFIG_SPI_GPIO=3Dy
CONFIG_SPI_IMX=3Dy
CONFIG_SPI_FSL_DSPI=3Dy
CONFIG_GPIO_SYSFS=3Dy
CONFIG_GPIO_MXC=3Dy
CONFIG_GPIO_SIOX=3Dm
CONFIG_GPIO_MAX732X=3Dy
CONFIG_GPIO_PCA953X=3Dy
CONFIG_GPIO_PCA953X_IRQ=3Dy
CONFIG_GPIO_PCF857X=3Dy
CONFIG_GPIO_BD71815=3Dy
CONFIG_GPIO_STMPE=3Dy
CONFIG_GPIO_74X164=3Dy
CONFIG_W1=3Dm
CONFIG_W1_MASTER_DS2482=3Dm
CONFIG_W1_SLAVE_THERM=3Dm
CONFIG_POWER_RESET=3Dy
CONFIG_POWER_RESET_SYSCON=3Dy
CONFIG_POWER_RESET_SYSCON_POWEROFF=3Dy
CONFIG_RN5T618_POWER=3Dm
CONFIG_SENSORS_MC13783_ADC=3Dy
CONFIG_SENSORS_GPIO_FAN=3Dy
CONFIG_SENSORS_IIO_HWMON=3Dy
CONFIG_SENSORS_JC42=3Dm
CONFIG_SENSORS_LM75=3Dm
CONFIG_SENSORS_PWM_FAN=3Dy
CONFIG_SENSORS_SY7636A=3Dy
CONFIG_THERMAL_STATISTICS=3Dy
CONFIG_CPU_THERMAL=3Dy
CONFIG_IMX_THERMAL=3Dy
CONFIG_WATCHDOG=3Dy
CONFIG_DA9063_WATCHDOG=3Dm
CONFIG_DA9062_WATCHDOG=3Dy
CONFIG_RN5T618_WATCHDOG=3Dy
CONFIG_IMX2_WDT=3Dy
CONFIG_IMX7ULP_WDT=3Dy
CONFIG_MFD_DA9052_I2C=3Dy
CONFIG_MFD_DA9062=3Dy
CONFIG_MFD_DA9063=3Dy
CONFIG_MFD_MC13XXX_SPI=3Dy
CONFIG_MFD_MC13XXX_I2C=3Dy
CONFIG_MFD_SY7636A=3Dy
CONFIG_MFD_RN5T618=3Dy
CONFIG_MFD_STMPE=3Dy
CONFIG_MFD_ROHM_BD71828=3Dy
CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
CONFIG_REGULATOR_ANATOP=3Dy
CONFIG_REGULATOR_BD71815=3Dy
CONFIG_REGULATOR_BD71828=3Dy
CONFIG_REGULATOR_DA9052=3Dy
CONFIG_REGULATOR_DA9062=3Dy
CONFIG_REGULATOR_DA9063=3Dy
CONFIG_REGULATOR_GPIO=3Dy
CONFIG_REGULATOR_LTC3676=3Dy
CONFIG_REGULATOR_MC13783=3Dy
CONFIG_REGULATOR_MC13892=3Dy
CONFIG_REGULATOR_PFUZE100=3Dy
CONFIG_REGULATOR_RN5T618=3Dy
CONFIG_REGULATOR_SY7636A=3Dy
CONFIG_RC_CORE=3Dy
CONFIG_RC_DEVICES=3Dy
CONFIG_IR_GPIO_CIR=3Dy
CONFIG_MEDIA_SUPPORT=3Dy
CONFIG_MEDIA_USB_SUPPORT=3Dy
CONFIG_USB_VIDEO_CLASS=3Dm
CONFIG_V4L_PLATFORM_DRIVERS=3Dy
CONFIG_V4L_MEM2MEM_DRIVERS=3Dy
CONFIG_VIDEO_MUX=3Dy
CONFIG_VIDEO_CODA=3Dm
CONFIG_VIDEO_IMX_PXP=3Dy
CONFIG_VIDEO_OV2680=3Dm
CONFIG_VIDEO_OV5640=3Dm
CONFIG_VIDEO_OV5645=3Dm
CONFIG_VIDEO_ADV7180=3Dm
CONFIG_IMX_IPUV3_CORE=3Dy
CONFIG_DRM=3Dy
CONFIG_DRM_MSM=3Dy
CONFIG_DRM_PANEL_LVDS=3Dy
CONFIG_DRM_PANEL_SEIKO_43WVF1G=3Dy
CONFIG_DRM_PANEL_EDP=3Dy
CONFIG_DRM_PANEL_SIMPLE=3Dy
CONFIG_DRM_DISPLAY_CONNECTOR=3Dy
CONFIG_DRM_I2C_NXP_TDA998X=3Dy
CONFIG_DRM_LVDS_CODEC=3Dm
CONFIG_DRM_SII902X=3Dy
CONFIG_DRM_TI_TFP410=3Dy
CONFIG_DRM_DW_HDMI_AHB_AUDIO=3Dm
CONFIG_DRM_DW_HDMI_CEC=3Dy
CONFIG_DRM_IMX=3Dy
CONFIG_DRM_IMX_PARALLEL_DISPLAY=3Dy
CONFIG_DRM_IMX_TVE=3Dy
CONFIG_DRM_IMX_LDB=3Dy
CONFIG_DRM_IMX_HDMI=3Dy
CONFIG_DRM_ETNAVIV=3Dy
CONFIG_DRM_MXSFB=3Dy
CONFIG_FB=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_LCD_CLASS_DEVICE=3Dy
CONFIG_LCD_L4F00242T03=3Dy
CONFIG_LCD_PLATFORM=3Dy
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
CONFIG_BACKLIGHT_PWM=3Dy
CONFIG_BACKLIGHT_GPIO=3Dy
CONFIG_LOGO=3Dy
CONFIG_SOUND=3Dy
CONFIG_SND=3Dy
CONFIG_SND_USB_AUDIO=3Dm
CONFIG_SND_SOC=3Dy
CONFIG_SND_SOC_FSL_ASRC=3Dy
CONFIG_SND_IMX_SOC=3Dy
CONFIG_SND_SOC_EUKREA_TLV320=3Dy
CONFIG_SND_SOC_IMX_ES8328=3Dy
CONFIG_SND_SOC_IMX_SGTL5000=3Dy
CONFIG_SND_SOC_FSL_ASOC_CARD=3Dy
CONFIG_SND_SIMPLE_CARD=3Dy
CONFIG_SND_SOC_AC97_CODEC=3Dy
CONFIG_SND_SOC_CS42XX8_I2C=3Dy
CONFIG_SND_SOC_SPDIF=3Dy
CONFIG_SND_SOC_TLV320AIC3X_I2C=3Dy
CONFIG_SND_SOC_WM8960=3Dy
CONFIG_SND_SOC_WM8962=3Dy
CONFIG_HID_MULTITOUCH=3Dy
CONFIG_HID_WACOM=3Dy
CONFIG_I2C_HID_OF=3Dy
CONFIG_USB=3Dy
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
CONFIG_USB_EHCI_HCD=3Dy
CONFIG_USB_ACM=3Dm
CONFIG_USB_STORAGE=3Dy
CONFIG_USB_CHIPIDEA=3Dy
CONFIG_USB_CHIPIDEA_UDC=3Dy
CONFIG_USB_CHIPIDEA_HOST=3Dy
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_OPTION=3Dm
CONFIG_USB_TEST=3Dm
CONFIG_USB_EHSET_TEST_FIXTURE=3Dm
CONFIG_USB_HSIC_USB3503=3Dy
CONFIG_USB_ONBOARD_DEV=3Dy
CONFIG_NOP_USB_XCEIV=3Dy
CONFIG_USB_MXS_PHY=3Dy
CONFIG_USB_GADGET=3Dy
CONFIG_USB_CONFIGFS=3Dy
CONFIG_USB_CONFIGFS_SERIAL=3Dy
CONFIG_USB_CONFIGFS_ACM=3Dy
CONFIG_USB_CONFIGFS_OBEX=3Dy
CONFIG_USB_CONFIGFS_NCM=3Dy
CONFIG_USB_CONFIGFS_ECM=3Dy
CONFIG_USB_CONFIGFS_ECM_SUBSET=3Dy
CONFIG_USB_CONFIGFS_RNDIS=3Dy
CONFIG_USB_CONFIGFS_EEM=3Dy
CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy
CONFIG_USB_CONFIGFS_F_LB_SS=3Dy
CONFIG_USB_CONFIGFS_F_FS=3Dy
CONFIG_USB_CONFIGFS_F_UAC1=3Dy
CONFIG_USB_CONFIGFS_F_UAC2=3Dy
CONFIG_USB_CONFIGFS_F_MIDI=3Dy
CONFIG_USB_CONFIGFS_F_HID=3Dy
CONFIG_USB_CONFIGFS_F_UVC=3Dy
CONFIG_USB_CONFIGFS_F_PRINTER=3Dy
CONFIG_USB_ZERO=3Dm
CONFIG_USB_AUDIO=3Dm
CONFIG_USB_ETH=3Dm
CONFIG_USB_G_NCM=3Dm
CONFIG_USB_GADGETFS=3Dm
CONFIG_USB_FUNCTIONFS=3Dm
CONFIG_USB_MASS_STORAGE=3Dm
CONFIG_USB_G_SERIAL=3Dm
CONFIG_MMC=3Dy
CONFIG_MMC_SDHCI=3Dy
CONFIG_MMC_SDHCI_PLTFM=3Dy
CONFIG_MMC_SDHCI_ESDHC_IMX=3Dy
CONFIG_LEDS_GPIO=3Dy
CONFIG_LEDS_PWM=3Dy
CONFIG_LEDS_TRIGGER_TIMER=3Dy
CONFIG_LEDS_TRIGGER_ONESHOT=3Dy
CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dy
CONFIG_LEDS_TRIGGER_GPIO=3Dy
CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_INTF_DEV_UIE_EMUL=3Dy
CONFIG_RTC_DRV_DS1307=3Dy
CONFIG_RTC_DRV_ISL1208=3Dy
CONFIG_RTC_DRV_PCF8523=3Dy
CONFIG_RTC_DRV_PCF8563=3Dy
CONFIG_RTC_DRV_M41T80=3Dy
CONFIG_RTC_DRV_BD70528=3Dy
CONFIG_RTC_DRV_RC5T619=3Dy
CONFIG_RTC_DRV_RV3029C2=3Dy
CONFIG_RTC_DRV_DA9063=3Dy
CONFIG_RTC_DRV_MC13XXX=3Dy
CONFIG_RTC_DRV_MXC=3Dy
CONFIG_RTC_DRV_MXC_V2=3Dy
CONFIG_RTC_DRV_SNVS=3Dy
CONFIG_DMADEVICES=3Dy
CONFIG_FSL_EDMA=3Dy
CONFIG_IMX_SDMA=3Dm
CONFIG_MXS_DMA=3Dy
CONFIG_DMATEST=3Dm
CONFIG_STAGING=3Dy
CONFIG_STAGING_MEDIA=3Dy
CONFIG_VIDEO_IMX_MEDIA=3Dy
CONFIG_COMMON_CLK_PWM=3Dy
CONFIG_COMMON_CLK_BD718XX=3Dy
CONFIG_CLK_IMX8MM=3Dy
CONFIG_CLK_IMX8MN=3Dy
CONFIG_CLK_IMX8MP=3Dy
CONFIG_CLK_IMX8MQ=3Dy
CONFIG_SOC_IMX8M=3Dy
CONFIG_EXTCON_USB_GPIO=3Dy
CONFIG_IIO=3Dy
CONFIG_IIO_ST_ACCEL_3AXIS=3Dm
CONFIG_MMA8452=3Dy
CONFIG_IMX7D_ADC=3Dy
CONFIG_RN5T618_ADC=3Dy
CONFIG_STMPE_ADC=3Dy
CONFIG_VF610_ADC=3Dy
CONFIG_SENSORS_ISL29018=3Dy
CONFIG_MAG3110=3Dy
CONFIG_MPL3115=3Dy
CONFIG_PWM=3Dy
CONFIG_PWM_FSL_FTM=3Dy
CONFIG_PWM_IMX27=3Dy
CONFIG_PWM_IMX_TPM=3Dy
CONFIG_NVMEM_IMX_OCOTP=3Dy
CONFIG_NVMEM_SNVS_LPGPR=3Dy
CONFIG_NVMEM_VF610_OCOTP=3Dy
CONFIG_TEE=3Dy
CONFIG_OPTEE=3Dy
CONFIG_MUX_MMIO=3Dy
CONFIG_SIOX=3Dm
CONFIG_SIOX_BUS_GPIO=3Dm
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_QUOTA=3Dy
CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
CONFIG_AUTOFS_FS=3Dy
CONFIG_FUSE_FS=3Dy
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_JFFS2_FS=3Dy
CONFIG_UBIFS_FS=3Dy
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3_ACL=3Dy
CONFIG_NFS_V4=3Dy
CONFIG_NFS_V4_1=3Dy
CONFIG_NFS_V4_2=3Dy
CONFIG_ROOT_NFS=3Dy
CONFIG_NLS_DEFAULT=3D"cp437"
CONFIG_NLS_CODEPAGE_437=3Dy
CONFIG_NLS_ASCII=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_UTF8=3Dy
CONFIG_SECURITYFS=3Dy
CONFIG_CRYPTO_DEV_FSL_CAAM=3Dy
CONFIG_CRYPTO_DEV_SAHARA=3Dy
CONFIG_CRYPTO_DEV_MXS_DCP=3Dy
CONFIG_XZ_DEC=3Dy
CONFIG_CMA_SIZE_MBYTES=3D64
CONFIG_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
CONFIG_PRINTK_TIME=3Dy
# CONFIG_DEBUG_BUGVERBOSE is not set
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_FS=3Dy
# CONFIG_SLUB_DEBUG is not set
# CONFIG_FTRACE is not set
```

