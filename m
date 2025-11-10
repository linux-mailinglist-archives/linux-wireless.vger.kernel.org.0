Return-Path: <linux-wireless+bounces-28716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B4C4511D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 07:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EB3A4E1A08
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B51F5847;
	Mon, 10 Nov 2025 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xilix.ch header.i=@xilix.ch header.b="SsXc5M6f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9914D283
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762755452; cv=none; b=bUB+bZ2GAIDMDj8fG+Zem/Hj9PGkfOPBib8VxOLfU4WRegSYm2kk1mY4vzadk+hbKTFvMx6uslkR/34p0BEOoOUASlLl8BqepwEdxd7CapNj0n2SppzLAX7Ie8c7fuV4m/1QnT6tOfD3X7U15jH6do13JU01CUfDElFMQvoeh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762755452; c=relaxed/simple;
	bh=ReWRfSV/pI4Kd/FxBAXkRl10PkmmBSbQSs+ZiYHKOuw=;
	h=Subject:Message-ID:Date:From:To:MIME-Version:Content-Type; b=S8/VSRATrlQbgnLlkoLZxosf9FiJKZwSahit7iXEPCuMolt3b+gjxGjc0fQVPO4JpdmvPemihljbfYLPSlfsFCKqB5T+X+5s/e1jahg/7veBpx5ZoUs9swanSpbjwa/57/WQKtCnXHKNDquU5n8nnUXahFElkK/lf5nQ+4r6ocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xilix.ch; spf=pass smtp.mailfrom=xilix.ch; dkim=pass (2048-bit key) header.d=xilix.ch header.i=@xilix.ch header.b=SsXc5M6f; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xilix.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xilix.ch
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d4fBL5z3Bz5XQ
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 06:59:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xilix.ch;
	s=20230710; t=1762754362;
	bh=iSa4nkHLqf5tU0LLWQgrVQTqi7i6MD6q5Oo3URQ7Ia0=;
	h=Subject:Date:From:To:Reply-To:From;
	b=SsXc5M6fw87Fhdf4UIuQloKg4nMtxryK0boi846G74pqip/6S10XN+LVi8UP/ec+w
	 Guppj1A9bslaZgKkTkyjV4DJQhudKIahMUVqKE8NT5RvedkYLXHFXmxgJJYa4axCAj
	 /rL37iuaxmcDt7osXDPu6aIQGHereNnSyjxTongChvnx+O3h19LPk2FZiyGMCwMQ9G
	 Mvw0s4MKPDASd9IVE7ex0m+A7D5uj2h+IJjao+A4H89UbQxGQRXV0vA1QsqkfWgKLa
	 TXLx2Zwz1hRhEMq2XbEGJK8HQ1I2twBQhkXolrl/BuaKkG1285eAeR8c7ERt/dVdZb
	 HMZVh4mdan6eg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4d4fBL3dMZz834
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 06:59:22 +0100 (CET)
Subject: [REGRESSION] mt7925e: NULL pointer deref in
 mt76_connac_mcu_uni_add_dev() after message timeouts (Lenovo 83JU,
 6.17.7-3-cachyos)
Message-ID: <99b7c8bb-bad4-4a75-ad9f-52c3bb4ed202@mail.infomaniak.com>
Date: Mon, 10 Nov 2025 06:59:22 +0100
From: Dominique Schaefer <dschaefer2025@xilix.ch>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Reply-To: Dominique Schaefer <dschaefer2025@xilix.ch>
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.1075)
X-WS-User-Origin: eyJpdiI6IjVzR3J1NDB3a1J3SWlqemxUaVJTTFE9PSIsInZhbHVlIjoiT3lud2JjUU5LbHhCM3ZJWXRraVhNZz09IiwibWFjIjoiZTAyMDVlNmJhMWY2MGQ1MTYxZjY1MDM0MzQ4Y2EyYmVkZjczNzgwMDEzOWY1ODE4YmFkYmNhY2I3MDhjMjZjYSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6InFDOVc4OFU4VlFvUjMzSzBsVG52NFE9PSIsInZhbHVlIjoiR0ticFhBOVV0bnhRSU9uTEJGZ0Fmdz09IiwibWFjIjoiNDI4OTE1MDI3OTdmYTY5YmY1ZTIzODFlMjNiMWY5NjU2NGFmNDYwNTk3ZThiZTZiYzdiMjliYWZjMzEzZTNmZCIsInRhZyI6IiJ9
X-WS-LOCALE: en_GB
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Infomaniak-Routing: alpha

Hi,

I'm hitting a kernel crash in the Mediatek mt76 driver (mt7925e) on a Lenov=
o Yoga AMD Ryzen AI 350 83JU
laptop. The Wi-Fi starts timing out MCU messages, then the driver attempts =
a MAC
reset and crashes with a NULL pointer dereference in
mt76_connac_mcu_uni_add_dev().

This looks like a driver/firmware issue; please find details below.

Hardware
--------
- Laptop: Lenovo 83JU / board LNVNB161216
- BIOS: QXCN12WW (2025-01-01)
- Wi-Fi: Mediatek MT7925 (PCIe at 0000:03:00.0)=C2=A0 <<< paste lspci line =
here
- Distro: CachyOS (Arch-based)

Kernel / firmware
-----------------
- Kernel: 6.17.7-3-cachyos #1 PREEMPT(full)

- linux-firmware version:=C2=A0
[root@cachyos ~]# pacman -Qi linux-firmware | grep VersionVersion =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 1:20251021-1- Firmware files pr=
esent:
[root@cachyos ~]# ls -l /lib/firmware/mediatek | grep -i 7925drwxr-xr-x 2 r=
oot root =C2=A0=C2=A0=C2=A0133 Nov =C2=A05 06:55 mt7925

Symptoms
--------
- Repeated timeouts from mt7925e:
=C2=A0=C2=A0=C2=A0 mt7925e 0000:03:00.0: Message 00020002/00020003/... time=
out
- Then a kernel Oops in a kworker running mt7925_mac_reset_work.

Other possibly related logs (context from the same boot):
- wpa_supplicant repeating:
=C2=A0=C2=A0=C2=A0 "bgscan simple: Failed to enable signal strength monitor=
ing"
=C2=A0=C2=A0=C2=A0 "nl80211: kernel reports: link ID must for MLO group key=
"
- KWin (Wayland) shows occasional "GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT"
=C2=A0 (likely unrelated, included for completeness).
- KDE powerdevil DDC errors (permission denied on /dev/i2c-*), likely unrel=
ated.

Full Oops excerpt
-----------------
Nov 09 10:21:58 cachyos kernel: BUG: kernel NULL pointer dereference, addre=
ss: 0000000000000000
Nov 09 10:21:58 cachyos kernel: #PF: supervisor read access in kernel mode
Nov 09 10:21:58 cachyos kernel: Oops: Oops: 0000 [#1] SMP NOPTI
Nov 09 10:21:58 cachyos kernel: CPU: 13 UID: 0 PID: 10517 Comm: kworker/u64=
:5 Not tainted 6.17.7-3-cachyos #1 PREEMPT(full)=C2=A0 9aee124add74d3b7eae3=
6345cf4e2d49e997594b
Nov 09 10:21:58 cachyos kernel: Hardware name: LENOVO 83JU/LNVNB161216, BIO=
S QXCN12WW 01/01/2025
Nov 09 10:21:58 cachyos kernel: Workqueue: mt76 mt7925_mac_reset_work [mt79=
25_common]
Nov 09 10:21:58 cachyos kernel: RIP: 0010:mt76_connac_mcu_uni_add_dev+0xf1/=
0x210 [mt76_connac_lib]
Nov 09 10:21:58 cachyos kernel: Call Trace:
Nov 09 10:21:58 cachyos kernel:=C2=A0 mt7925_vif_connect_iter+0x95/0x190 [m=
t7925_common]
Nov 09 10:21:58 cachyos kernel:=C2=A0 ieee80211_iterate_interfaces+0x3b/0x5=
0 [mac80211]
Nov 09 10:21:58 cachyos kernel:=C2=A0 mt7925_mac_reset_work+0x293/0x310 [mt=
7925_common]
... (full trace attached below)

Timeline (same boot)
--------------------
08:59=E2=80=9310:21=C2=A0 multiple "nl80211: link ID must for MLO group key=
"
08:49=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 powerdevil DDC i2c permissi=
on errors (likely unrelated)
10:21:41=C2=A0=C2=A0=C2=A0=C2=A0 mt7925e: Message timeouts start (seq 10..1=
4)
10:21:58=C2=A0=C2=A0=C2=A0=C2=A0 NULL pointer deref in mt76_connac_mcu_uni_=
add_dev()

Reproduction / frequency
------------------------
- Happens intermittently during normal desktop usage on Wayland (KDE),
=C2=A0 associated with Wi-Fi activity.=C2=A0 <<< add steps if you have reli=
able repro >>>

Attachments
-----------
- dmesg excerpt (from boot to crash)
- `lspci -nnk -s 03:00.0`
- `uname -a`
- `journalctl -b -0 -k | grep -i -e mt76 -e mt7925 -e nl80211` (filtered mt=
76/nl80211 lines)

If I can test patches or collect additional traces, happy to help.

[root@cachyos ~]# journalctl -b -1 -p errNov 09 08:49:07 cachyos sddm-helpe=
r[1018]: gkr-pam: unable to locate daemon control fileNov 09 08:49:10 cachy=
os org_kde_powerdevil[1419]: [ 1419] Error(s) opening ddc devicesNov 09 08:=
49:10 cachyos org_kde_powerdevil[1419]: [ 1419] Error EACCES(-13): Permissi=
on denied opening /dev/i2c-2Nov 09 08:49:10 cachyos org_kde_powerdevil[1419=
]: [ 1419] Error EACCES(-13): Permission denied opening /dev/i2c-3Nov 09 08=
:49:10 cachyos org_kde_powerdevil[1419]: [ 1419] Error EACCES(-13): Permiss=
ion denied opening /dev/i2c-4Nov 09 08:49:10 cachyos org_kde_powerdevil[141=
9]: [ 1419] Error EACCES(-13): Permission denied opening /dev/i2c-5Nov 09 0=
8:49:10 cachyos org_kde_powerdevil[1419]: [ 1419] Error EACCES(-13): Permis=
sion denied opening /dev/i2c-6Nov 09 08:49:10 cachyos org_kde_powerdevil[14=
19]: [ 1419] Error EACCES(-13): Permission denied opening /dev/i2c-7Nov 09 =
08:49:10 cachyos org_kde_powerdevil[1419]: [ 1419] Error EACCES(-13): Permi=
ssion denied opening /dev/i2c-8Nov 09 08:49:10 cachyos org_kde_powerdevil[1=
419]: [ 1419] Error EACCES(-13): Permission denied opening /dev/i2c-9Nov 09=
 08:49:10 cachyos org_kde_powerdevil[1419]: [ 1419] Error EACCES(-13): Perm=
ission denied opening /dev/i2c-10Nov 09 08:49:10 cachyos org_kde_powerdevil=
[1419]: [ 1419] Error EACCES(-13): Permission denied opening /dev/i2c-11Nov=
 09 08:49:10 cachyos org_kde_powerdevil[1419]: [ 1419] Error EACCES(-13): P=
ermission denied opening /dev/i2c-12Nov 09 08:49:10 cachyos org_kde_powerde=
vil[1419]: [ 1419] Error EACCES(-13): Permission denied opening /dev/i2c-13=
Nov 09 08:49:10 cachyos org_kde_powerdevil[1419]: [ 1419] Error EACCES(-13)=
: Permission denied opening /dev/i2c-14Nov 09 08:49:10 cachyos org_kde_powe=
rdevil[1419]: [ 1419] Error EACCES(-13): Permission denied opening /dev/i2c=
-15Nov 09 08:49:10 cachyos org_kde_powerdevil[1419]: [ 1419] Error EACCES(-=
13): Permission denied opening /dev/i2c-16Nov 09 08:49:10 cachyos org_kde_p=
owerdevil[1419]: [ 1419] Error EACCES(-13): Permission denied opening /dev/=
i2c-17Nov 09 08:49:10 cachyos org_kde_powerdevil[1419]: [ 1419] Error EACCE=
S(-13): Permission denied opening /dev/i2c-18Nov 09 08:49:10 cachyos org_kd=
e_powerdevil[1419]: [ 1419] Error EACCES(-13): Permission denied opening /d=
ev/i2c-19Nov 09 08:49:12 cachyos wpa_supplicant[866]: bgscan simple: Failed=
 to enable signal strength monitoringNov 09 08:54:26 cachyos wpa_supplicant=
[866]: bgscan simple: Failed to enable signal strength monitoringNov 09 08:=
59:32 cachyos wpa_supplicant[866]: nl80211: kernel reports: link ID must fo=
r MLO group keyNov 09 08:59:32 cachyos wpa_supplicant[866]: nl80211: kernel=
 reports: link ID must for MLO group keyNov 09 08:59:32 cachyos wpa_supplic=
ant[866]: nl80211: kernel reports: link ID must for MLO group keyNov 09 08:=
59:36 cachyos wpa_supplicant[866]: bgscan simple: Failed to enable signal s=
trength monitoringNov 09 09:04:48 cachyos wpa_supplicant[866]: bgscan simpl=
e: Failed to enable signal strength monitoringNov 09 09:09:53 cachyos wpa_s=
upplicant[866]: nl80211: kernel reports: link ID must for MLO group keyNov =
09 09:09:53 cachyos wpa_supplicant[866]: nl80211: kernel reports: link ID m=
ust for MLO group keyNov 09 09:09:53 cachyos wpa_supplicant[866]: nl80211: =
kernel reports: link ID must for MLO group keyNov 09 09:09:58 cachyos wpa_s=
upplicant[866]: bgscan simple: Failed to enable signal strength monitoringN=
ov 09 09:11:32 cachyos bluetoothd[811]: src/adv_monitor.c:btd_adv_monitor_p=
ower_down() Unexpected NULL btd_adv_monitor_manager object upon power downN=
ov 09 09:20:15 cachyos wpa_supplicant[866]: bgscan simple: Failed to enable=
 signal strength monitoringNov 09 09:25:20 cachyos wpa_supplicant[866]: nl8=
0211: kernel reports: link ID must for MLO group keyNov 09 09:25:20 cachyos=
 wpa_supplicant[866]: nl80211: kernel reports: link ID must for MLO group k=
eyNov 09 09:25:20 cachyos wpa_supplicant[866]: nl80211: kernel reports: lin=
k ID must for MLO group keyNov 09 09:25:25 cachyos wpa_supplicant[866]: bgs=
can simple: Failed to enable signal strength monitoringNov 09 09:35:36 cach=
yos wpa_supplicant[866]: nl80211: kernel reports: link ID must for MLO grou=
p keyNov 09 09:35:36 cachyos wpa_supplicant[866]: nl80211: kernel reports: =
link ID must for MLO group keyNov 09 09:35:36 cachyos wpa_supplicant[866]: =
nl80211: kernel reports: link ID must for MLO group keyNov 09 09:35:40 cach=
yos wpa_supplicant[866]: bgscan simple: Failed to enable signal strength mo=
nitoringNov 09 09:50:56 cachyos wpa_supplicant[866]: nl80211: kernel report=
s: link ID must for MLO group keyNov 09 09:50:56 cachyos wpa_supplicant[866=
]: nl80211: kernel reports: link ID must for MLO group keyNov 09 09:50:56 c=
achyos wpa_supplicant[866]: nl80211: kernel reports: link ID must for MLO g=
roup keyNov 09 09:51:01 cachyos wpa_supplicant[866]: bgscan simple: Failed =
to enable signal strength monitoringNov 09 10:06:17 cachyos wpa_supplicant[=
866]: nl80211: kernel reports: link ID must for MLO group keyNov 09 10:06:1=
7 cachyos wpa_supplicant[866]: nl80211: kernel reports: link ID must for ML=
O group keyNov 09 10:06:17 cachyos wpa_supplicant[866]: nl80211: kernel rep=
orts: link ID must for MLO group keyNov 09 10:06:21 cachyos wpa_supplicant[=
866]: bgscan simple: Failed to enable signal strength monitoringNov 09 10:1=
9:05 cachyos kwin_wayland[1193]: Invalid framebuffer status: "GL_FRAMEBUFFE=
R_INCOMPLETE_ATTACHMENT"Nov 09 10:19:58 cachyos kwin_wayland[1193]: Invalid=
 framebuffer status: "GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT"Nov 09 10:21:37 =
cachyos wpa_supplicant[866]: nl80211: kernel reports: link ID must for MLO =
group keyNov 09 10:21:37 cachyos wpa_supplicant[866]: nl80211: kernel repor=
ts: link ID must for MLO group keyNov 09 10:21:37 cachyos wpa_supplicant[86=
6]: nl80211: kernel reports: link ID must for MLO group keyNov 09 10:21:41 =
cachyos kernel: mt7925e 0000:03:00.0: Message 00020002 (seq 10) timeoutNov =
09 10:21:47 cachyos kernel: mt7925e 0000:03:00.0: Message 00020003 (seq 11)=
 timeoutNov 09 10:21:51 cachyos kernel: mt7925e 0000:03:00.0: Message 00020=
002 (seq 12) timeoutNov 09 10:21:54 cachyos kernel: mt7925e 0000:03:00.0: M=
essage 00020002 (seq 13) timeoutNov 09 10:21:57 cachyos kernel: mt7925e 000=
0:03:00.0: Message 00020001 (seq 14) timeoutNov 09 10:21:58 cachyos kernel:=
 BUG: kernel NULL pointer dereference, address: 0000000000000000Nov 09 10:2=
1:58 cachyos kernel: #PF: supervisor read access in kernel modeNov 09 10:21=
:58 cachyos kernel: #PF: error_code(0x0000) - not-present pageNov 09 10:21:=
58 cachyos kernel: Oops: Oops: 0000 [#1] SMP NOPTINov 09 10:21:58 cachyos k=
ernel: CPU: 13 UID: 0 PID: 10517 Comm: kworker/u64:5 Not tainted 6.17.7-3-c=
achyos #1 PREEMPT(full)  9aee124add74d3b7eae36345cf4e2d49e997594bNov 09 10:=
21:58 cachyos kernel: Hardware name: LENOVO 83JU/LNVNB161216, BIOS QXCN12WW=
 01/01/2025Nov 09 10:21:58 cachyos kernel: Workqueue: mt76 mt7925_mac_reset=
_work [mt7925_common]Nov 09 10:21:58 cachyos kernel: RIP: 0010:mt76_connac_=
mcu_uni_add_dev+0xf1/0x210 [mt76_connac_lib]Nov 09 10:21:58 cachyos kernel:=
 Code: 0f b7 89 b8 00 00 00 66 89 4c 24 1c c7 44 24 1e 00 00 00 00 66 89 4c=
 24 22 66 c7 44 24 24 00 00 c6 44 24 26 00 44 88 4c 24 27 <48> 8b 0e 8b 09 =
83 f9 05 7f 11 83 f9 01 74 2>Nov 09 10:21:58 cachyos kernel: RSP: 0018:ffff=
cf6309433cc0 EFLAGS: 00010286Nov 09 10:21:58 cachyos kernel: RAX: ffffcf630=
9433cf2 RBX: ffff8d6571f92020 RCX: 0000000000000013Nov 09 10:21:58 cachyos =
kernel: RDX: ffff8d6573e4e3b0 RSI: 0000000000000000 RDI: 0000000000000000No=
v 09 10:21:58 cachyos kernel: RBP: 0000000000000001 R08: 0000000000000000 R=
09: 0000000000000000Nov 09 10:21:58 cachyos kernel: R10: 0000000000000000 R=
11: ffffffff9a6c69c0 R12: 0000000000000001Nov 09 10:21:58 cachyos kernel: R=
13: 0000000000000000 R14: ffff8d6571f92020 R15: ffff8d6573e4e3b0Nov 09 10:2=
1:58 cachyos kernel: FS: 0000000000000000(0000) GS:ffff8d6ce144a000(0000) k=
nlGS:0000000000000000Nov 09 10:21:58 cachyos kernel: CS: 0010 DS: 0000 ES: =
0000 CR0: 0000000080050033Nov 09 10:21:58 cachyos kernel: CR2: 000000000000=
0000 CR3: 0000000117c06000 CR4: 0000000000f50ef0Nov 09 10:21:58 cachyos ker=
nel: PKRU: 55555554Nov 09 10:21:58 cachyos kernel: Call Trace:Nov 09 10:21:=
58 cachyos kernel: <TASK>Nov 09 10:21:58 cachyos kernel: mt7925_vif_connect=
_iter+0x95/0x190 [mt7925_common d1b14aa67c0b885399ddf2edba15580e00c34df3]No=
v 09 10:21:58 cachyos kernel: __iterate_interfaces+0x52/0x130 [mac80211 1a4=
d114bf315b116bfd732370c6efc7b6f5c3943]Nov 09 10:21:58 cachyos kernel:  ? __=
pfx_mt7925_vif_connect_iter+0x10/0x10 [mt7925_common d1b14aa67c0b885399ddf2=
edba15580e00c34df3]Nov 09 10:21:58 cachyos kernel: ? __pfx_mt7925_vif_conne=
ct_iter+0x10/0x10 [mt7925_common d1b14aa67c0b885399ddf2edba15580e00c34df3]N=
ov 09 10:21:58 cachyos kernel: ieee80211_iterate_interfaces+0x3b/0x50 [mac8=
0211 1a4d114bf315b116bfd732370c6efc7b6f5c3943]Nov 09 10:21:58 cachyos kerne=
l: mt7925_mac_reset_work+0x293/0x310 [mt7925_common d1b14aa67c0b885399ddf2e=
dba15580e00c34df3]Nov 09 10:21:58 cachyos kernel:  ? drm_sched_run_job_work=
+0x88/0x530 [gpu_sched 36b0662102cf350ac5a388aefe580dfe15dca327]Nov 09 10:2=
1:58 cachyos kernel: process_scheduled_works+0x20b/0x450Nov 09 10:21:58 cac=
hyos kernel: worker_thread+0x319/0x500


Thanks!

---------------------------------------------------------
Dominique Schaefer
Wabersackerstrasse 78
3097 Liebefeld
Mobile : +41 79 839 19 86
Home : +41 31 971 19 86
dschaefer2025@xilix.ch

