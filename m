Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812CF100A11
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 18:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfKRRRo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 12:17:44 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:37631 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRRRo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 12:17:44 -0500
Received: by mail-qk1-f180.google.com with SMTP id e187so15120703qkf.4
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 09:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RW1qwKlPaLhHjjld22hAY1U95hYeDajGvUjA6XRiDM8=;
        b=WZwZukECfRRDlUlO1cjdo7Xpypwzohchy3RpmjwrQWNwjkwZyEA6BVRQ0QdC4GV19r
         lUUDXfNaQoNST+iHd+ev0oUt7nl2Y3b/S0lCUv9HildhUrxsh9rnEgceKvGgapD5S1hu
         UrkXcJAbFxvgMaF4oGsFObQf6ja7AXamCnKYgSfCAPbT84naPZGFrIRyVfAki2EC8+2h
         fwLWpfrRKClbLQT/EM5IVG8UU/zyebhEOqMNCm8FlgrT1msolNmPzl6j0kS+a9uJrbwv
         osj0S7o3hq7pyP6MI9ZoGICcYnGItNJWjsPh4Gv+4VZjOeVoF4jVPzy2cOYkoj12kEio
         Cpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RW1qwKlPaLhHjjld22hAY1U95hYeDajGvUjA6XRiDM8=;
        b=FXilZP+V3jd2jpNzYGN+1JsVk2MfhUtvSwEe/O0rjmcHXHtTijDIiWNunOlDmn6QhK
         U52eI/kwCdICrkDeZjvYr4wyzZmRKFKANnyNMtYgQN+MW2iYKitNqN6bGLJCrklBmARp
         n7xK86wE1dwgTXeowRXKftokRLLzVvSUM3Vko8OP6mKoDeTXEj2uOg9rgPIbPe1dzPMK
         3XR5FE82Zxeosp2HkQ9xBrNhHBVFNXRTLJcX82fz20qmpqryqc/1VKLJxvIh1tnkEgSD
         g7i/92lfkMkox8vjljoDi0HdsQKOoWM0+91MdCcDqnBS53enj/fv9EiUJs0Wn9r9J2i1
         Iq3A==
X-Gm-Message-State: APjAAAWyG0CnG/NK9p0aE0zDJtRY3Ts+E5iu/qA4d5My9qgCGjK3Jh+f
        ASQLeTuxe4a1g1IqaBPZEDWewfzo/ne8CMht4hZ/IZOFEyB95w==
X-Google-Smtp-Source: APXvYqwpVWHc9UTvCtxOD7QW5NbdNkCy+iCFFl7vq4gau3kxPpYH5jwZuVBT2nzkUwMHF7xFEOyLnxX8AF5+tBEFuug=
X-Received: by 2002:ae9:ddc1:: with SMTP id r184mr25834275qkf.454.1574097459781;
 Mon, 18 Nov 2019 09:17:39 -0800 (PST)
MIME-Version: 1.0
From:   shyam jos <shyamjosepp@gmail.com>
Date:   Mon, 18 Nov 2019 22:47:27 +0530
Message-ID: <CA+dTD9fqG95AgD9hrofkQVcRW_h6vdexTQNA-c9_a+ktjYQ7kA@mail.gmail.com>
Subject: RTL8822BE Bluetooth disconnects with error CTRL-EVENT-BEACON-LOSS - rtw88
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am facing intermittent Bluetooth disconnection issue mostly when connecte=
d
to a Bluetooth speaker, my Bluetooth speaker disconnects with error
"wlp2s0: CTRL-EVENT-BEACON-LOSS" (kernel: 5.3.0-23-generic), also
audio shutters when music played via android phone and got this
error in Syslog "[pulseaudio] module-loopback.c: Too many underruns,
increasing latency to 205.00 ms".

But Bluetooth works perfectly fine with kernel 4.19.67 (Debian 10.2 )
The only difference was in kernel 4.19.67  the driver loaded was
r8822be, so the issue is with the driver rtw_pci which is loaded in
kernel: 5.3.0-23 ??

Os: Ubuntu 19.10
kernel :5.3.0-23-generic
driver: rtw88
Wifi HW module: RTL8822BE

02:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822BE
802.11a/b/g/n/ac WiFi adapter
 Subsystem: AzureWave RTL8822BE 802.11a/b/g/n/ac WiFi adapter
 Kernel driver in use: rtw_pci
 Kernel modules: rtwpci


Please find the Logs below

Nov 18 08:29:04 Asus-VivoBook wpa_supplicant[751]: wlp2s0:
CTRL-EVENT-BEACON-LOSS
Nov 18 08:29:57 Asus-VivoBook kernel: [ 3456.258679] rtw_pci
0000:02:00.0: firmware failed to restore hardware setting
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794656] ------------[ cut
here ]------------
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794659] purge skb(s) not
reported by firmware
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794724] WARNING: CPU: 3
PID: 3116 at /home/ubuntu/rtlwifi_new/tx.c:163
rtw_tx_report_purge_timer+0x25/0x60 [rtw88]
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794725] Modules linked
in: cmac ccm rfcomm bnep nls_iso8859_1 x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel snd_hda_codec_hdmi kvm
snd_hda_codec_realtek irqbypass snd_soc_skl snd_hda_codec_generic
ledtrig_audio snd_soc_hdac_hda snd_hda_ext_core snd_soc_skl_ipc
snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi
snd_soc_core snd_compress crct10dif_pclmul ac97_bus crc32_pclmul
snd_pcm_dmaengine snd_hda_intel ghash_clmulni_intel snd_hda_codec
mei_hdcp snd_hda_core snd_hwdep intel_rapl_msr snd_pcm i915 rtwpci(OE)
uvcvideo rtw88(OE) btusb btrtl snd_seq_midi snd_seq_midi_event btbcm
aesni_intel videobuf2_vmalloc snd_rawmidi joydev btintel
videobuf2_memops mac80211 snd_seq drm_kms_helper videobuf2_v4l2
aes_x86_64 videobuf2_common crypto_simd cryptd snd_seq_device
snd_timer cfg80211 rtsx_usb_ms glue_helper bluetooth
processor_thermal_device asus_nb_wmi intel_cstate drm snd memstick
intel_rapl_perf input_leds videodev intel_xhci_usb_role_switch
spi_pxa2xx_platform
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794789]  serio_raw
i2c_algo_bit asus_wmi libarc4 dw_dmac mc wmi_bmof intel_rapl_common
mei_me dw_dmac_core sparse_keymap ecdh_generic soundcore ecc
fb_sys_fops 8250_dw syscopyarea roles hid_multitouch mei sysfillrect
intel_soc_dts_iosf sysimgblt idma64 virt_dma intel_pch_thermal
int3403_thermal int340x_thermal_zone int3400_thermal mac_hid acpi_pad
acpi_thermal_rel sch_fq_codel parport_pc ppdev lp parport ip_tables
x_tables autofs4 rtsx_usb_sdmmc rtsx_usb usbhid hid_generic i2c_i801
ahci libahci intel_lpss_pci i2c_hid intel_lpss hid wmi
pinctrl_sunrisepoint video pinctrl_intel
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794839] CPU: 3 PID: 3116
Comm: chrome Tainted: G           OE     5.3.0-23-generic #25-Ubuntu
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794841] Hardware name:
ASUSTeK COMPUTER INC. VivoBook_ASUSLaptop X412UA/X412UA, BIOS
X412UA.303 06/03/2019
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794856] RIP:
0010:rtw_tx_report_purge_timer+0x25/0x60 [rtw88]
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794860] Code: 00 00 00 00
00 0f 1f 44 00 00 8b 47 f0 85 c0 75 01 c3 55 48 89 e5 41 55 41 54 53
48 89 fb 48 c7 c7 20 d3 d6 c0 e8 16 95 99 ee <0f> 0b 4c 8d 6b d8 4c 89
ef e8 fd d9 39 ef 48 8d 7b e0 49 89 c4 e8
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794863] RSP:
0000:ffffb5ba00180e48 EFLAGS: 00010286
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794867] RAX:
0000000000000000 RBX: ffff9d6509c8dc90 RCX: 0000000000000006
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794870] RDX:
0000000000000007 RSI: 0000000000000082 RDI: ffff9d6512b97440
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794872] RBP:
ffffb5ba00180e60 R08: 00000000000003a1 R09: 0000000000000004
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794875] R10:
0000000000000000 R11: 0000000000000001 R12: ffff9d6512b9b600
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794877] R13:
ffff9d6509c8dc90 R14: ffffffffc0d01db0 R15: ffff9d6509c8dc90
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794881] FS:
00007fb897a4bd40(0000) GS:ffff9d6512b80000(0000)
knlGS:0000000000000000
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794883] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794886] CR2:
00002203021e3008 CR3: 00000002b2a28003 CR4: 00000000003606e0
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794888] Call Trace:
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794891]  <IRQ>
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794901]  call_timer_fn+0x32/0x=
130
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794908]
__run_timers.part.0+0x177/0x270
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794914]  ?
enqueue_hrtimer+0x3d/0x90
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794918]  ? ktime_get+0x42/0xa0
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794924]
run_timer_softirq+0x2a/0x50
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794929]  __do_softirq+0xe1/0x2=
d6
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794935]  ?
hrtimer_interrupt+0x13b/0x220
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794940]  irq_exit+0xae/0xb0
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794945]
smp_apic_timer_interrupt+0x7b/0x140
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794950]
apic_timer_interrupt+0xf/0x20
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794952]  </IRQ>
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794956] RIP: 0033:0x561f11cd8b=
c5
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794959] Code: b8 4c 8b 42
50 8b 42 58 4c 8b 62 68 48 89 55 c0 48 8b 4a 70 48 89 4d 98 4c 89 5d
c8 66 0f 1f 84 00 00 00 00 00 83 f8 0e 76 3b <44> 89 c7 44 21 cf 41 0f
b6 54 bc 01 89 d1 49 d3 e8 41 8a 0c bc 41
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794962] RSP:
002b:00007ffd0ef1ed58 EFLAGS: 00000216 ORIG_RAX: ffffffffffffff13
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794965] RAX:
0000000000000011 RBX: 000030289bdbba2a RCX: fffffffffffffbfe
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794968] RDX:
000030289bdbb60c RSI: 000030289bdcd645 RDI: 000000000000000b
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794970] RBP:
00007ffd0ef1ed80 R08: 000000000013b721 R09: 00000000000001ff
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794973] R10:
000030289adcfc01 R11: 000030289add5dde R12: 0000220301be9558
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794975] R13:
0000000000000402 R14: 0000000000000000 R15: 000030289bdcd645
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3456.794981] ---[ end trace
163175a10848a9db ]---
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3457.018779] rtw_pci
0000:02:00.0: timed out to flush queue 1
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3457.162670] rtw_pci
0000:02:00.0: timed out to flush queue 2
Nov 18 08:29:58 Asus-VivoBook kernel: [ 3457.162744] rtw_pci
0000:02:00.0: sta ac:dc:e2:dc:5a:e4 with macid 0 left
Nov 18 08:29:59 Asus-VivoBook kernel: [ 3457.694068] rtw_pci
0000:02:00.0: pci bus timeout, check dma status
Nov 18 08:29:57 Asus-VivoBook wpa_supplicant[751]: wlp2s0:
CTRL-EVENT-BEACON-LOSS
Nov 18 08:29:59 Asus-VivoBook wpa_supplicant[751]: wlp2s0:
CTRL-EVENT-DISCONNECTED bssid=3Dac:dc:e2:dc:5a:e4 reason=3D4
locally_generated=3D1
Nov 18 08:29:59 Asus-VivoBook wpa_supplicant[751]: dbus:
wpa_dbus_property_changed: no property SessionLength in object
/fi/w1/wpa_supplicant1/Interfaces/0
Nov 18 08:29:59 Asus-VivoBook wpa_supplicant[751]: wlp2s0:
CTRL-EVENT-REGDOM-CHANGE init=3DCORE type=3DWORLD
Nov 18 08:29:59 Asus-VivoBook NetworkManager[772]: <warn>
[1574045999.1699] sup-iface[0x563d3de17110,wlp2s0]: connection
disconnected (reason -4)
Nov 18 08:29:59 Asus-VivoBook gnome-shell[1477]:
[2200:2223:1118/082959.170049:ERROR:connection_factory_impl.cc(417)]
Failed to connect to MCS endpoint with error -106
Nov 18 08:29:59 Asus-VivoBook NetworkManager[772]: <info>
[1574045999.1739] device (wlp2s0): supplicant interface state:
completed -> disconnected
Nov 18 08:29:59 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Reject scan
trigger since one is already pending
Nov 18 08:29:59 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Failed to
initiate AP scan
Nov 18 08:30:00 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Reject scan
trigger since one is already pending
Nov 18 08:30:00 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Failed to
initiate AP scan
Nov 18 08:30:00 Asus-VivoBook NetworkManager[772]: <info>
[1574046000.5732] manager: NetworkManager state is now CONNECTED_SITE
Nov 18 08:30:00 Asus-VivoBook whoopsie[1187]: [08:30:00] offline
Nov 18 08:30:00 Asus-VivoBook dbus-daemon[750]: [system] Activating
via systemd: service name=3D'org.freedesktop.nm_dispatcher'
unit=3D'dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.13'
(uid=3D0 pid=3D772 comm=3D"/usr/sbin/NetworkManager --no-daemon "
label=3D"unconfined")
Nov 18 08:30:00 Asus-VivoBook systemd[1]: Starting Network Manager
Script Dispatcher Service...
Nov 18 08:30:00 Asus-VivoBook dbus-daemon[750]: [system] Successfully
activated service 'org.freedesktop.nm_dispatcher'
Nov 18 08:30:00 Asus-VivoBook systemd[1]: Started Network Manager
Script Dispatcher Service.
Nov 18 08:30:01 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Reject scan
trigger since one is already pending
Nov 18 08:30:01 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Failed to
initiate AP scan
Nov 18 08:30:01 Asus-VivoBook CRON[7698]: (root) CMD ([ -x
/etc/init.d/anacron ] && if [ ! -d /run/systemd/system ]; then
/usr/sbin/invoke-rc.d anacron start >/dev/null; fi)
Nov 18 08:30:01 Asus-VivoBook whoopsie[1187]: [08:30:01] Cannot reach:
https://daisy.ubuntu.com
Nov 18 08:30:02 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Reject scan
trigger since one is already pending
Nov 18 08:30:02 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Failed to
initiate AP scan
Nov 18 08:30:02 Asus-VivoBook gnome-shell[1477]: JS ERROR:
Gio.ResolverError: Error resolving =E2=80=9Copenweathermap.org=E2=80=9D: Te=
mporary
failure in name
resolution#012_asyncReadyCallback@/home/ubuntu/.local/share/gnome-shell/ext=
ensions/openweather-extension@jenslody.de/extension.js:544:27#012wrapper@re=
source:///org/gnome/gjs/modules/_legacy.js:82:22
Nov 18 08:30:02 Asus-VivoBook wpa_supplicant[751]: wlp2s0: SME: Trying
to authenticate with ac:dc:e2:dc:5a:e4 (SSID=3D'myssid' freq=3D2462 MHz)
Nov 18 08:30:02 Asus-VivoBook kernel: [ 3461.459419] wlp2s0:
authenticate with ac:dc:e2:dc:5a:e4
Nov 18 08:30:03 Asus-VivoBook kernel: [ 3461.969911] rtw_pci
0000:02:00.0: pci bus timeout, check dma status
Nov 18 08:30:03 Asus-VivoBook NetworkManager[772]: <info>
[1574046003.4442] device (wlp2s0): supplicant interface state:
disconnected -> authenticating
Nov 18 08:30:03 Asus-VivoBook kernel: [ 3461.971457] wlp2s0: send auth
to ac:dc:e2:dc:5a:e4 (try 1/3)
Nov 18 08:30:03 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Trying to
associate with ac:dc:e2:dc:5a:e4 (SSID=3D'myssid' freq=3D2462 MHz)
Nov 18 08:30:03 Asus-VivoBook NetworkManager[772]: <info>
[1574046003.4482] device (wlp2s0): supplicant interface state:
authenticating -> associating
Nov 18 08:30:03 Asus-VivoBook kernel: [ 3461.975092] wlp2s0: authenticated
Nov 18 08:30:03 Asus-VivoBook kernel: [ 3461.978544] wlp2s0: associate
with ac:dc:e2:dc:5a:e4 (try 1/3)
Nov 18 08:30:03 Asus-VivoBook kernel: [ 3462.000487] wlp2s0: RX
AssocResp from ac:dc:e2:dc:5a:e4 (capab=3D0x411 status=3D30 aid=3D3)
Nov 18 08:30:03 Asus-VivoBook kernel: [ 3462.000496] wlp2s0:
ac:dc:e2:dc:5a:e4 rejected association temporarily; comeback duration
1000 TU (1024 ms)
Nov 18 08:30:03 Asus-VivoBook kernel: [ 3462.122549] wlp2s0: associate
with ac:dc:e2:dc:5a:e4 (try 2/3)
Nov 18 08:30:03 Asus-VivoBook kernel: [ 3462.230604] wlp2s0: associate
with ac:dc:e2:dc:5a:e4 (try 3/3)
Nov 18 08:30:03 Asus-VivoBook kernel: [ 3462.342605] wlp2s0:
association with ac:dc:e2:dc:5a:e4 timed out
Nov 18 08:30:03 Asus-VivoBook NetworkManager[772]: <info>
[1574046003.8372] device (wlp2s0): supplicant interface state:
associating -> disconnected
Nov 18 08:30:04 Asus-VivoBook xdg-desktop-por[1426]: Failed to get
application states: GDBus.Error:org.freedesktop.portal.Error.Failed:
Could not get window list:
GDBus.Error:org.freedesktop.DBus.Error.AccessDenied: App introspection
not allowed
Nov 18 08:30:04 Asus-VivoBook kernel: [ 3463.369879] rtw_pci
0000:02:00.0: pci bus timeout, check dma status
Nov 18 08:30:04 Asus-VivoBook NetworkManager[772]: <info>
[1574046004.8438] device (wlp2s0): supplicant interface state:
disconnected -> scanning
Nov 18 08:30:05 Asus-VivoBook acpid: input device has been disconnected, fd=
 18
Nov 18 08:30:05 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
config/udev: removing device FC:23:BA:E1:AC:71
Nov 18 08:30:05 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (**)
Option "fd" "65"
Nov 18 08:30:05 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
event15 - FC:23:BA:E1:AC:71: device removed
Nov 18 08:30:05 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
UnloadModule: "libinput"
Nov 18 08:30:05 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
systemd-logind: releasing fd for 13:79
Nov 18 08:30:05 Asus-VivoBook gsd-media-keys[1662]: Unable to get default s=
ink
Nov 18 08:30:08 Asus-VivoBook wpa_supplicant[751]: wlp2s0: SME: Trying
to authenticate with ac:dc:e2:dc:5a:e4 (SSID=3D'myssid' freq=3D2462 MHz)
Nov 18 08:30:08 Asus-VivoBook kernel: [ 3467.111292] wlp2s0:
authenticate with ac:dc:e2:dc:5a:e4
Nov 18 08:30:09 Asus-VivoBook NetworkManager[772]: <info>
[1574046009.0936] device (wlp2s0): supplicant interface state:
scanning -> authenticating
Nov 18 08:30:09 Asus-VivoBook kernel: [ 3467.620094] wlp2s0: send auth
to ac:dc:e2:dc:5a:e4 (try 1/3)
Nov 18 08:30:09 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Trying to
associate with ac:dc:e2:dc:5a:e4 (SSID=3D'myssid' freq=3D2462 MHz)
Nov 18 08:30:09 Asus-VivoBook NetworkManager[772]: <info>
[1574046009.0971] device (wlp2s0): supplicant interface state:
authenticating -> associating
Nov 18 08:30:09 Asus-VivoBook kernel: [ 3467.622952] wlp2s0: authenticated
Nov 18 08:30:09 Asus-VivoBook kernel: [ 3467.626496] wlp2s0: associate
with ac:dc:e2:dc:5a:e4 (try 1/3)
Nov 18 08:30:09 Asus-VivoBook kernel: [ 3467.630434] wlp2s0: RX
AssocResp from ac:dc:e2:dc:5a:e4 (capab=3D0x411 status=3D0 aid=3D3)
Nov 18 08:30:09 Asus-VivoBook kernel: [ 3467.630468] rtw_pci
0000:02:00.0: sta ac:dc:e2:dc:5a:e4 joined with macid 0
Nov 18 08:30:09 Asus-VivoBook wpa_supplicant[751]: wlp2s0: Associated
with ac:dc:e2:dc:5a:e4
Nov 18 08:30:09 Asus-VivoBook wpa_supplicant[751]: wlp2s0:
CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
Nov 18 08:30:09 Asus-VivoBook kernel: [ 3467.686872] wlp2s0: associated
Nov 18 08:30:09 Asus-VivoBook wpa_supplicant[751]: wlp2s0: WPA: Key
negotiation completed with ac:dc:e2:dc:5a:e4 [PTK=3DCCMP GTK=3DCCMP]
Nov 18 08:30:09 Asus-VivoBook wpa_supplicant[751]: wlp2s0:
CTRL-EVENT-CONNECTED - Connection to ac:dc:e2:dc:5a:e4 completed [id=3D0
id_str=3D]
Nov 18 08:30:09 Asus-VivoBook NetworkManager[772]: <info>
[1574046009.1647] device (wlp2s0): supplicant interface state:
associating -> completed
Nov 18 08:30:09 Asus-VivoBook wpa_supplicant[751]: wlp2s0:
CTRL-EVENT-SIGNAL-CHANGE above=3D1 signal=3D-47 noise=3D9999 txrate=3D27000=
0
Nov 18 08:30:10 Asus-VivoBook systemd[1]:
NetworkManager-dispatcher.service: Succeeded.
Nov 18 08:30:16 Asus-VivoBook NetworkManager[772]: <info>
[1574046016.3125] manager: NetworkManager state is now
CONNECTED_GLOBAL
Nov 18 08:30:16 Asus-VivoBook dbus-daemon[750]: [system] Activating
via systemd: service name=3D'org.freedesktop.nm_dispatcher'
unit=3D'dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.13'
(uid=3D0 pid=3D772 comm=3D"/usr/sbin/NetworkManager --no-daemon "
label=3D"unconfined")
Nov 18 08:30:16 Asus-VivoBook systemd[1]: Starting Network Manager
Script Dispatcher Service...
Nov 18 08:30:16 Asus-VivoBook whoopsie[1187]: [08:30:16] The default
IPv4 route is: /org/freedesktop/NetworkManager/ActiveConnection/1
Nov 18 08:30:16 Asus-VivoBook whoopsie[1187]: [08:30:16] Not a paid
data plan: /org/freedesktop/NetworkManager/ActiveConnection/1
Nov 18 08:30:16 Asus-VivoBook whoopsie[1187]: [08:30:16] Found usable
connection: /org/freedesktop/NetworkManager/ActiveConnection/1
Nov 18 08:30:16 Asus-VivoBook dbus-daemon[750]: [system] Successfully
activated service 'org.freedesktop.nm_dispatcher'
Nov 18 08:30:16 Asus-VivoBook systemd[1]: Started Network Manager
Script Dispatcher Service.
Nov 18 08:30:17 Asus-VivoBook whoopsie[1187]: [08:30:17] online
Nov 18 08:30:26 Asus-VivoBook systemd[1]:
NetworkManager-dispatcher.service: Succeeded.
Nov 18 08:30:57 Asus-VivoBook kernel: [ 3516.270073] input:
FC:23:BA:E1:AC:71 as /devices/virtual/input/input19
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
config/udev: Adding input device FC:23:BA:E1:AC:71
(/dev/input/event15)
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (**)
FC:23:BA:E1:AC:71: Applying InputClass "libinput keyboard catchall"
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
Using input driver 'libinput' for 'FC:23:BA:E1:AC:71'
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
systemd-logind: got fd for /dev/input/event15 13:79 fd 65 paused 0
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (**)
FC:23:BA:E1:AC:71: always reports core events
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (**)
Option "Device" "/dev/input/event15"
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (**)
Option "_source" "server/udev"
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
event15 - FC:23:BA:E1:AC:71: is tagged by udev as: Keyboard
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
event15 - FC:23:BA:E1:AC:71: device is a keyboard
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
event15 - FC:23:BA:E1:AC:71: device removed
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (**)
Option "config_info" "udev:/sys/devices/virtual/input/input19/event15"
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
XINPUT: Adding extended input device "FC:23:BA:E1:AC:71" (type:
KEYBOARD, id 14)
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (**)
Option "xkb_model" "pc105"
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (**)
Option "xkb_layout" "us"
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (WW)
Option "xkb_variant" requires a string value
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (WW)
Option "xkb_options" requires a string value
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
event15 - FC:23:BA:E1:AC:71: is tagged by udev as: Keyboard
Nov 18 08:30:57 Asus-VivoBook /usr/lib/gdm3/gdm-x-session[1272]: (II)
event15 - FC:23:BA:E1:AC:71: device is a keyboard
Nov 18 08:30:57 Asus-VivoBook gnome-shell[1477]: Window manager
warning: Overwriting existing binding of keysym 32 with keysym 32
(keycode b).
Nov 18 08:30:57 Asus-VivoBook gnome-shell[1477]: Window manager
warning: Overwriting existing binding of keysym 38 with keysym 38
(keycode 11).
Nov 18 08:30:57 Asus-VivoBook gnome-shell[1477]: Window manager
warning: Overwriting existing binding of keysym 39 with keysym 39
(keycode 12).
Nov 18 08:30:57 Asus-VivoBook gnome-shell[1477]: Window manager
warning: Overwriting existing binding of keysym 33 with keysym 33
(keycode c).
Nov 18 08:30:57 Asus-VivoBook gnome-shell[1477]: Window manager
warning: Overwriting existing binding of keysym 34 with keysym 34
(keycode d).
Nov 18 08:30:57 Asus-VivoBook gnome-shell[1477]: Window manager
warning: Overwriting existing binding of keysym 35 with keysym 35
(keycode e).
Nov 18 08:30:57 Asus-VivoBook gnome-shell[1477]: Window manager
warning: Overwriting existing binding of keysym 36 with keysym 36
(keycode f).
Nov 18 08:30:57 Asus-VivoBook gnome-shell[1477]: Window manager
warning: Overwriting existing binding of keysym 37 with keysym 37
(keycode 10).
Nov 18 08:30:57 Asus-VivoBook gnome-shell[1477]: Window manager
warning: Overwriting existing binding of keysym 31 with keysym 31
(keycode a).
Nov 18 08:30:58 Asus-VivoBook gnome-shell[1477]:
_clutter_stage_queue_event: assertion 'CLUTTER_IS_STAGE (stage)'
failed
Nov 18 08:30:58 Asus-VivoBook gnome-shell[1477]: message repeated 8
times: [ _clutter_stage_queue_event: assertion 'CLUTTER_IS_STAGE
(stage)' failed]
Nov 18 08:31:00 Asus-VivoBook bluetoothd[796]:
/org/bluez/hci0/dev_FC_58_FA_E1_DC_91/fd1: fd(25) ready
Nov 18 08:31:00 Asus-VivoBook rtkit-daemon[965]: Supervising 3 threads
of 1 processes of 1 users.
Nov 18 08:31:00 Asus-VivoBook rtkit-daemon[965]: Successfully made
thread 7799 of process 1265 owned by '1000' RT at priority 5.
Nov 18 08:31:00 Asus-VivoBook rtkit-daemon[965]: Supervising 4 threads
of 1 processes of 1 users.
Nov 18 08:31:04 Asus-VivoBook xdg-desktop-por[1426]: Failed to get
application states: GDBus.Error:org.freedesktop.portal.Error.Failed:
Could not get window list:
GDBus.Error:org.freedesktop.DBus.Error.AccessDenied: App introspection
not allowed
Nov 18 08:31:09 Asus-VivoBook gnome-shell[1477]: pushModal: invocation
of begin_modal failed
