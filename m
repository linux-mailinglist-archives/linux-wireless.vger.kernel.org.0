Return-Path: <linux-wireless+bounces-36191-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NvP1LONdAWq3WgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36191-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:41:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4155C507DD8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 198B73001FC8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 04:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F4D26B0A9;
	Mon, 11 May 2026 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4DDGP0b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236A1CD2C
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778474464; cv=pass; b=rmAVQ/C6vB+y06PPpRcLDy/gCrl/a8usYxs3fZeXJ6oKAw7lNHqZB2ymZUZBVDPQCal4y8/KNZqY+bOPwT4Utgv2Afhr/kf6CthF3gFff/y2BpbOMSzinAagFy2H2KD8xvKlh5mFmwIoIQO0PwHtBlsAiUeVxrsAL2Cnsgk0AhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778474464; c=relaxed/simple;
	bh=Io9/yFcIfU3VzunCWWV7UieRcQe3pKnj/zFh0qtmuF8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=i9Bjhq3MyN/Ehp2Rx/MyZzOz4w6jbe5M1SQc75TkIQ+5ji6WPmJ8dP9SA6JJULbvaTfRQ0HAZpp66haAYxmsoEnBJHVjBOxLBtnzvSZLUx+6rJJE0LTCjOkOJW97Cpik+FnQerVgc0JiVlTqJpEpn45aU6HEl+WlpEYD1YuXGDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4DDGP0b; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so6571214a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 21:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778474460; cv=none;
        d=google.com; s=arc-20240605;
        b=U6zSAfkp8Ix9BAjxQEN2aiE2CpjjmEQFK4zQux3xh8miPzWsrLLzL1vVu02itNdgKv
         rCxX6RX9bxWZAk/qFXP1nTddA31xmBSXZww5zfa+YZ23XUJSQf5Hv9wbRdLd/L04sZBQ
         jqo0QK6SbdLL6Uw0SEco2mUWo1mmUupj36aOLWft6uu9Yxb6hEMKq/0TDTqstviVlEUa
         VTIsipA8CK9aCaeYx/wL42apvfOWa1iPMJBoiFbLFGf7A0+7NFpD815Xox4MxJLFFKfn
         uzdb4CM9RXt1RzCIErLlKr8esDGBmheX02ifwiMTZ6KbtBp/6GWNe6pR0SIRyXSFziRo
         myWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Io9/yFcIfU3VzunCWWV7UieRcQe3pKnj/zFh0qtmuF8=;
        fh=UPiHA1Mir8Kr2L3kuGO6mB/4wkFv3H5IcTneGMCSl/o=;
        b=SJl1KBOw4rK0x6WsbQneBmFMMteQtBSYSDqD5XaswlALGL1/fW6oXJ1/qh7t7Qend5
         de8GTjwnYqtoJfvGpIXc5GBKZ1H1vUMAnMt9TuRM3LWiMvEQkmn4yF2NWA8eJ7Df0Zwf
         r2B4lABaqaDXwZklUrBWm/lGWzWDzuyHmlIAcWGbu6WBJvyQFBYOBGcD+dLiX8xa3wC+
         1abYHX8VDRMqopXrmkHos8n/maPSKa40VQh7Etsatg0SzKbGT+n5OLe71qttu67g4dfu
         NgTXHoY6OI5M+VJ0nW8J6aTKn8jJ53sI/oZJ7eyynvh0y/trMD9T6wPApIi9DPmNSxAq
         wDhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778474460; x=1779079260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Io9/yFcIfU3VzunCWWV7UieRcQe3pKnj/zFh0qtmuF8=;
        b=T4DDGP0bukl0foh7pg7oSUW++LAUkTDPOtf5umCA1HysuPO/7bzJ+3WfVLOzxR+mBI
         tcN2SVGtI1HB2emZvc2RcRNKFaVmDB/ykbagI0RwGO1pAJ8XPQTvfcKtaZ+M0PzBF7dl
         QE+NPSeDO1Sj4czfvd5GSqji969x6/vghHL96lPpiFCWE3IrV0F2ZCurXPJPYxMpLnwI
         4b3VhLmhQ8+0NWrIb+921uuj6KxQoDcvA+S7yfpdvSo5pNkMBB74e41dfngQos9l7zXU
         Qe6W9zmEZ3jbGg8G4ZV1FzqbfqDBKFB1I1yQYF+QDdUBNTb0ywLA0smsvM78VkTyxbIN
         cjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778474460; x=1779079260;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io9/yFcIfU3VzunCWWV7UieRcQe3pKnj/zFh0qtmuF8=;
        b=JFO63RAsEVpvfvP04euFL1KU80V+F15NRvX3cmuXwCKSkyw60uHVp/Mm0BPyRZN0qI
         0dkQFuhjA/GTu7PIZ0E7+frpXs46SVG3Cmz4XdHeGzzFOcUCs/xqzJ9wbko1vc8pU1//
         cKJdlW34KwV+XPU9AA+tE0UlRDVYvCOutbf6aInGZr7OGeYh1+nPJZvdm6pr/gbN5kdi
         lNUJ3wokOiUhnnqaI9JibzNZu1xdLf9iIVOiS2cw4mxmoai4FZgKXflshEwsUm7QFQsO
         RBt0e6OlQF7vlOkKvlk0hl6dG+ZYBF07SPq4mU/LWRtCX5stFC49FgIwnX2dtN1bl1fH
         LPSA==
X-Gm-Message-State: AOJu0Yw+ggHfuAqrVRBp+sVaZVPlRHxJFQAOO+pGKncBm5gvtomBI94w
	3lg/hzVTtMudDsSXBtRlKKc/o6MrgVNp4kulaN354mlzgWCGF0XcSEJ5rl0y0DcHcXNevM5TG09
	W4qRrtzGvaSOkcydr/SVeGVkF4yab5P+EYZvh
X-Gm-Gg: Acq92OF2kw+xK3OFNVZ5iqougD3hsxfZweqCiX6I4sa0FjgchMg3PK0uM49FDOCEdns
	POTQnIz/m0CP7RbsPOqKpOVBS/M+mF1Ti5ic6Zu5X8ry+cecRCMC0aeuVItPbIhmgWShXopDaIB
	EmYHZWx2GprMPoHpPHcaWDTNmfec3qL9nrwZv0y9lPH5QB1hDbzrk7PAQbUArHjShiz4pDBqFaf
	05miAIUzWjRdMqNbjjnzC2UahNAaivdE7A7EE6TIOqbk0OTn7qYdymgKq8FglVaVmZS1E2MsKLY
	YHdNUv1XTvZU0HVRrkKQusw19kDZjbM=
X-Received: by 2002:a05:6402:5017:b0:67d:6c95:9c8e with SMTP id
 4fb4d7f45d1cf-67d6c95a081mr10680972a12.14.1778474459528; Sun, 10 May 2026
 21:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: MobyGaming <professionalgamerr.a@gmail.com>
Date: Mon, 11 May 2026 12:40:41 +0800
X-Gm-Features: AVHnY4JNAJasFpqPJAirddQxs5B2JJlmmbBR3A2Gf61d1vE15CPMp6pfKRqksXM
Message-ID: <CAME3dYPSrEwiC5ZVb+5ohirWXxDVKZt8eTTdgtrZdiGj-Ntb+w@mail.gmail.com>
Subject: Testing MT7921e: MT7902 TX stuck at 6Mbps on 5Ghz VHT connection;
 only stable at 802.11n or lower at 2.4GHz Non-dual band AP.
To: linux-wireless@vger.kernel.org
Cc: lorenzo@kernel.org, nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4155C507DD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-36191-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[professionalgamerra@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

Hi. I'm using linux on a laptop with an MT7902 wifi card. It's been
years since I wanted to get proper connectivity on this OS and with
the announcement of Kernel 7.1, it was pure bliss to finally see some
support pop up.

Here are some data I gathered as I tested Mt7902 on my laptop, an Acer
Aspire 315-24p. If you need anything, let me know.

Kernel: 7.1.0-070100rc3-generic

Hardware: Azurwave AW-XB552NF

lspci output:

peppermintcapsicum@pop-os:~$ sudo lspci -vnn | grep -A8 7902
pcilib: Error reading /sys/bus/pci/devices/0000:00:08.3/label:
Operation not permitted
01:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7902]
Subsystem: AzureWave Device [1a3b:5524]
Flags: bus master, fast devsel, latency 0, IRQ 75, IOMMU group 8
Memory at 7ef0200000 (64-bit, prefetchable) [size=1M]
Memory at c0500000 (64-bit, non-prefetchable) [size=32K]
Capabilities: [80] Express Endpoint, MSI 00
Capabilities: [e0] MSI: Enable+ Count=1/32 Maskable+ 64bit+
Capabilities: [f8] Power Management version 3
Capabilities: [100] Vendor Specific Information: ID=1556 Rev=1 Len=008 "<?>"
dmesg:

[ 9.599861] mt7921e 0000:01:00.0: enabling device (0000 -> 0002)
[ 9.600227] mt7921e 0000:01:00.0: disabling ASPM L1
[ 9.606554] mt7921e 0000:01:00.0: ASIC revision: 79020000
[ 9.722020] mt7921e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build
Time: 20251212032046a
[ 9.913603] mt7921e 0000:01:00.0: WM Firmware Version: ____000000,
Build Time: 20251212032127
[ 10.942072] mt7921e 0000:01:00.0 wlp1s0: renamed from wlan0

iw link info:

SSID: dlink-5798-5GHz freq: 5765.0 RX: 4382 bytes (33 packets) TX:
8464 bytes (53 packets) signal: -72 dBm tx bitrate: 6.0 MBit/s bss
flags: short-slot-time dtim period: 1 beacon int: 100

SSID: dlink-5798-5GHz freq: 5765.0 RX: 39910 bytes (273 packets) TX:
24409 bytes (161 packets) signal: -73 dBm rx bitrate: 58.5 MBit/s
VHT-MCS 1 80MHz VHT-NSS 1 tx bitrate: 6.0 MBit/s bss flags:
short-slot-time dtim period: 1 beacon int: 100

iw phy info:

Wiphy phy0
wiphy index: 0
max # scan SSIDs: 4
max scan IEs length: 482 bytes
max # sched scan SSIDs: 10
max # match sets: 16
Retry short limit: 7
Retry long limit: 4
Coverage class: 0 (up to 0m)
Device supports AP-side u-APSD.
Device supports T-DLS.
Supported Ciphers:
WEP40 (00-0f-ac:1)
WEP104 (00-0f-ac:5)
TKIP (00-0f-ac:2)
CCMP-128 (00-0f-ac:4)
CCMP-256 (00-0f-ac:10)
GCMP-128 (00-0f-ac:8)
GCMP-256 (00-0f-ac:9)
CMAC (00-0f-ac:6)
CMAC-256 (00-0f-ac:13)
GMAC-128 (00-0f-ac:11)
GMAC-256 (00-0f-ac:12)
Available Antennas: TX 0x1 RX 0x1
Configured Antennas: TX 0x1 RX 0x1
Supported interface modes:
managed
AP
AP/VLAN
monitor
P2P-client
P2P-GO
P2P-device
Band 1:
Capabilities: 0x97f
RX LDPC
HT20/HT40
SM Power Save disabled
RX Greenfield
RX HT20 SGI
RX HT40 SGI
RX STBC 1-stream
Max AMSDU length: 7935 bytes
No DSSS/CCK HT40
Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
Minimum RX AMPDU time spacing: No restriction (0x00)
HT TX/RX MCS rate indexes supported: 0-7
HE Iftypes: managed
HE MAC Capabilities (0x08011a000040):
+HTC HE Supported
Trigger Frame MAC Padding Duration: 2
OM Control
Maximum A-MPDU Length Exponent: 3
A-MSDU in A-MPDU
HE PHY Capabilities: (0x2270ce120dc0b306423f00):
HE40/2.4GHz
242 tone RUs/2.4GHz
Device Class: 1
LDPC Coding in Payload
HE SU PPDU with 1x HE-LTF and 0.8us GI
NDP with 4x HE-LTF and 3.2us GI
STBC Tx <= 80MHz
STBC Rx <= 80MHz
Full Bandwidth UL MU-MIMO
Partial Bandwidth UL MU-MIMO
DCM Max Constellation: 2
DCM Max Constellation Rx: 2
SU Beamformee
Beamformee STS <= 80Mhz: 3
Ng = 16 SU Feedback
Ng = 16 MU Feedback
Codebook Size SU Feedback
Codebook Size MU Feedback
Triggered CQI Feedback
Partial Bandwidth Extended Range
PPE Threshold Present
Power Boost Factor ar
HE SU PPDU & HE PPDU 4x HE-LTF 0.8us GI
20MHz in 40MHz HE PPDU 2.4GHz
DCM Max BW: 1
Longer Than 16HE SIG-B OFDM Symbols
Non-Triggered CQI Feedback
TX 1024-QAM
RX 1024-QAM
RX Full BW SU Using HE MU PPDU with Compression SIGB
RX Full BW SU Using HE MU PPDU with Non-Compression SIGB
HE RX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
HE TX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
PPE Threshold 0x18 0x1c 0x07
HE Iftypes: AP
HE MAC Capabilities (0x00011a081044):
+HTC HE Supported
BSR
OM Control
Maximum A-MPDU Length Exponent: 3
BQR
A-MSDU in A-MPDU
OM Control UL MU Data Disable RX
HE PHY Capabilities: (0x0220ce120000a000000c00):
HE40/2.4GHz
LDPC Coding in Payload
NDP with 4x HE-LTF and 3.2us GI
STBC Tx <= 80MHz
STBC Rx <= 80MHz
Full Bandwidth UL MU-MIMO
Partial Bandwidth UL MU-MIMO
DCM Max Constellation: 2
DCM Max Constellation Rx: 2
Partial Bandwidth Extended Range
PPE Threshold Present
TX 1024-QAM
RX 1024-QAM
HE RX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
HE TX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
PPE Threshold 0x18 0x1c 0x07
Bitrates (non-HT):
1.0 Mbps (short preamble supported)
2.0 Mbps (short preamble supported)
5.5 Mbps (short preamble supported)
11.0 Mbps (short preamble supported)
6.0 Mbps
9.0 Mbps
12.0 Mbps
18.0 Mbps
24.0 Mbps
36.0 Mbps
48.0 Mbps
54.0 Mbps
Frequencies:
2412.0 MHz [1] (20.0 dBm)
2417.0 MHz [2] (20.0 dBm)
2422.0 MHz [3] (20.0 dBm)
2427.0 MHz [4] (20.0 dBm)
2432.0 MHz [5] (20.0 dBm)
2437.0 MHz [6] (20.0 dBm)
2442.0 MHz [7] (20.0 dBm)
2447.0 MHz [8] (20.0 dBm)
2452.0 MHz [9] (20.0 dBm)
2457.0 MHz [10] (20.0 dBm)
2462.0 MHz [11] (20.0 dBm)
2467.0 MHz [12] (20.0 dBm)
2472.0 MHz [13] (20.0 dBm)
2484.0 MHz [14] (disabled)
Band 2:
Capabilities: 0x97f
RX LDPC
HT20/HT40
SM Power Save disabled
RX Greenfield
RX HT20 SGI
RX HT40 SGI
RX STBC 1-stream
Max AMSDU length: 7935 bytes
No DSSS/CCK HT40
Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
Minimum RX AMPDU time spacing: No restriction (0x00)
HT TX/RX MCS rate indexes supported: 0-7
VHT Capabilities (0x33907132):
Max MPDU length: 11454
Supported Channel Width: neither 160 nor 80+80
RX LDPC
short GI (80 MHz)
SU Beamformee
MU Beamformee
RX antenna pattern consistency
TX antenna pattern consistency
VHT RX MCS set:
1 streams: MCS 0-9
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
VHT RX highest supported: 0 Mbps
VHT TX MCS set:
1 streams: MCS 0-9
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
VHT TX highest supported: 0 Mbps
VHT extended NSS: supported
HE Iftypes: managed
HE MAC Capabilities (0x08011a000040):
+HTC HE Supported
Trigger Frame MAC Padding Duration: 2
OM Control
Maximum A-MPDU Length Exponent: 3
A-MSDU in A-MPDU
HE PHY Capabilities: (0x4470ce120dc0b306423f00):
HE40/HE80/5GHz
242 tone RUs/5GHz
Device Class: 1
LDPC Coding in Payload
HE SU PPDU with 1x HE-LTF and 0.8us GI
NDP with 4x HE-LTF and 3.2us GI
STBC Tx <= 80MHz
STBC Rx <= 80MHz
Full Bandwidth UL MU-MIMO
Partial Bandwidth UL MU-MIMO
DCM Max Constellation: 2
DCM Max Constellation Rx: 2
SU Beamformee
Beamformee STS <= 80Mhz: 3
Ng = 16 SU Feedback
Ng = 16 MU Feedback
Codebook Size SU Feedback
Codebook Size MU Feedback
Triggered CQI Feedback
Partial Bandwidth Extended Range
PPE Threshold Present
Power Boost Factor ar
HE SU PPDU & HE PPDU 4x HE-LTF 0.8us GI
20MHz in 40MHz HE PPDU 2.4GHz
DCM Max BW: 1
Longer Than 16HE SIG-B OFDM Symbols
Non-Triggered CQI Feedback
TX 1024-QAM
RX 1024-QAM
RX Full BW SU Using HE MU PPDU with Compression SIGB
RX Full BW SU Using HE MU PPDU with Non-Compression SIGB
HE RX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
HE TX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
PPE Threshold 0x78 0x1c 0xc7 0x71
HE Iftypes: AP
HE MAC Capabilities (0x00011a081044):
+HTC HE Supported
BSR
OM Control
Maximum A-MPDU Length Exponent: 3
BQR
A-MSDU in A-MPDU
OM Control UL MU Data Disable RX
HE PHY Capabilities: (0x0420ce120000a000000c00):
HE40/HE80/5GHz
LDPC Coding in Payload
NDP with 4x HE-LTF and 3.2us GI
STBC Tx <= 80MHz
STBC Rx <= 80MHz
Full Bandwidth UL MU-MIMO
Partial Bandwidth UL MU-MIMO
DCM Max Constellation: 2
DCM Max Constellation Rx: 2
Partial Bandwidth Extended Range
PPE Threshold Present
TX 1024-QAM
RX 1024-QAM
HE RX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
HE TX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
PPE Threshold 0x78 0x1c 0xc7 0x71
Bitrates (non-HT):
6.0 Mbps
9.0 Mbps
12.0 Mbps
18.0 Mbps
24.0 Mbps
36.0 Mbps
48.0 Mbps
54.0 Mbps
Frequencies:
5180.0 MHz [36] (23.0 dBm)
5200.0 MHz [40] (23.0 dBm)
5220.0 MHz [44] (23.0 dBm)
5240.0 MHz [48] (23.0 dBm)
5260.0 MHz [52] (23.0 dBm) (radar detection)
5280.0 MHz [56] (23.0 dBm) (radar detection)
5300.0 MHz [60] (23.0 dBm) (radar detection)
5320.0 MHz [64] (23.0 dBm) (radar detection)
5500.0 MHz [100] (24.0 dBm) (radar detection)
5520.0 MHz [104] (24.0 dBm) (radar detection)
5540.0 MHz [108] (24.0 dBm) (radar detection)
5560.0 MHz [112] (24.0 dBm) (radar detection)
5580.0 MHz [116] (24.0 dBm) (radar detection)
5600.0 MHz [120] (24.0 dBm) (radar detection)
5620.0 MHz [124] (24.0 dBm) (radar detection)
5640.0 MHz [128] (24.0 dBm) (radar detection)
5660.0 MHz [132] (24.0 dBm) (radar detection)
5680.0 MHz [136] (24.0 dBm) (radar detection)
5700.0 MHz [140] (24.0 dBm) (radar detection)
5720.0 MHz [144] (24.0 dBm) (radar detection)
5745.0 MHz [149] (24.0 dBm)
5765.0 MHz [153] (24.0 dBm)
5785.0 MHz [157] (24.0 dBm)
5805.0 MHz [161] (24.0 dBm)
5825.0 MHz [165] (24.0 dBm)
5845.0 MHz [169] (disabled)
5865.0 MHz [173] (disabled)
5885.0 MHz [177] (disabled)
Band 4:
HE Iftypes: managed
HE MAC Capabilities (0x08011a000040):
+HTC HE Supported
Trigger Frame MAC Padding Duration: 2
OM Control
Maximum A-MPDU Length Exponent: 3
A-MSDU in A-MPDU
HE PHY Capabilities: (0x4470ce120dc0b306423f00):
HE40/HE80/5GHz
242 tone RUs/5GHz
Device Class: 1
LDPC Coding in Payload
HE SU PPDU with 1x HE-LTF and 0.8us GI
NDP with 4x HE-LTF and 3.2us GI
STBC Tx <= 80MHz
STBC Rx <= 80MHz
Full Bandwidth UL MU-MIMO
Partial Bandwidth UL MU-MIMO
DCM Max Constellation: 2
DCM Max Constellation Rx: 2
SU Beamformee
Beamformee STS <= 80Mhz: 3
Ng = 16 SU Feedback
Ng = 16 MU Feedback
Codebook Size SU Feedback
Codebook Size MU Feedback
Triggered CQI Feedback
Partial Bandwidth Extended Range
PPE Threshold Present
Power Boost Factor ar
HE SU PPDU & HE PPDU 4x HE-LTF 0.8us GI
20MHz in 40MHz HE PPDU 2.4GHz
DCM Max BW: 1
Longer Than 16HE SIG-B OFDM Symbols
Non-Triggered CQI Feedback
TX 1024-QAM
RX 1024-QAM
RX Full BW SU Using HE MU PPDU with Compression SIGB
RX Full BW SU Using HE MU PPDU with Non-Compression SIGB
HE RX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
HE TX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
PPE Threshold 0x78 0x1c 0xc7 0x71
HE Iftypes: AP
HE MAC Capabilities (0x00011a081044):
+HTC HE Supported
BSR
OM Control
Maximum A-MPDU Length Exponent: 3
BQR
A-MSDU in A-MPDU
OM Control UL MU Data Disable RX
HE PHY Capabilities: (0x0420ce120000a000000c00):
HE40/HE80/5GHz
LDPC Coding in Payload
NDP with 4x HE-LTF and 3.2us GI
STBC Tx <= 80MHz
STBC Rx <= 80MHz
Full Bandwidth UL MU-MIMO
Partial Bandwidth UL MU-MIMO
DCM Max Constellation: 2
DCM Max Constellation Rx: 2
Partial Bandwidth Extended Range
PPE Threshold Present
TX 1024-QAM
RX 1024-QAM
HE RX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
HE TX MCS and NSS set <= 80 MHz
1 streams: MCS 0-11
2 streams: not supported
3 streams: not supported
4 streams: not supported
5 streams: not supported
6 streams: not supported
7 streams: not supported
8 streams: not supported
PPE Threshold 0x78 0x1c 0xc7 0x71
Bitrates (non-HT):
6.0 Mbps
9.0 Mbps
12.0 Mbps
18.0 Mbps
24.0 Mbps
36.0 Mbps
48.0 Mbps
54.0 Mbps
Frequencies:
5955.0 MHz [1] (disabled)
5975.0 MHz [5] (disabled)
5995.0 MHz [9] (disabled)
6015.0 MHz [13] (disabled)
6035.0 MHz [17] (disabled)
6055.0 MHz [21] (disabled)
6075.0 MHz [25] (disabled)
6095.0 MHz [29] (disabled)
6115.0 MHz [33] (disabled)
6135.0 MHz [37] (disabled)
6155.0 MHz [41] (disabled)
6175.0 MHz [45] (disabled)
6195.0 MHz [49] (disabled)
6215.0 MHz [53] (disabled)
6235.0 MHz [57] (disabled)
6255.0 MHz [61] (disabled)
6275.0 MHz [65] (disabled)
6295.0 MHz [69] (disabled)
6315.0 MHz [73] (disabled)
6335.0 MHz [77] (disabled)
6355.0 MHz [81] (disabled)
6375.0 MHz [85] (disabled)
6395.0 MHz [89] (disabled)
6415.0 MHz [93] (disabled)
6435.0 MHz [97] (disabled)
6455.0 MHz [101] (disabled)
6475.0 MHz [105] (disabled)
6495.0 MHz [109] (disabled)
6515.0 MHz [113] (disabled)
6535.0 MHz [117] (disabled)
6555.0 MHz [121] (disabled)
6575.0 MHz [125] (disabled)
6595.0 MHz [129] (disabled)
6615.0 MHz [133] (disabled)
6635.0 MHz [137] (disabled)
6655.0 MHz [141] (disabled)
6675.0 MHz [145] (disabled)
6695.0 MHz [149] (disabled)
6715.0 MHz [153] (disabled)
6735.0 MHz [157] (disabled)
6755.0 MHz [161] (disabled)
6775.0 MHz [165] (disabled)
6795.0 MHz [169] (disabled)
6815.0 MHz [173] (disabled)
6835.0 MHz [177] (disabled)
6855.0 MHz [181] (disabled)
6875.0 MHz [185] (disabled)
6895.0 MHz [189] (disabled)
6915.0 MHz [193] (disabled)
6935.0 MHz [197] (disabled)
6955.0 MHz [201] (disabled)
6975.0 MHz [205] (disabled)
6995.0 MHz [209] (disabled)
7015.0 MHz [213] (disabled)
7035.0 MHz [217] (disabled)
7055.0 MHz [221] (disabled)
7075.0 MHz [225] (disabled)
7095.0 MHz [229] (disabled)
7115.0 MHz [233] (disabled)
Supported commands:
new_interface
set_interface
new_key
start_ap
new_station
new_mpath
set_mesh_config
set_bss
authenticate
associate
deauthenticate
disassociate
join_ibss
join_mesh
set_tx_bitrate_mask
frame
frame_wait_cancel
set_wiphy_netns
set_channel
tdls_mgmt
tdls_oper
start_sched_scan
probe_client
set_noack_map
register_beacons
start_p2p_device
set_mcast_rate
connect
disconnect
channel_switch
set_qos_map
set_multicast_to_unicast
set_sar_specs
Unknown command (156)
WoWLAN support:
wake up on disconnect
wake up on magic packet
wake up on pattern match, up to 1 patterns of 1-128 bytes,
maximum packet offset 0 bytes
can do GTK rekeying
wake up on network detection, up to 10 match sets
software interface modes (can always be added):
AP/VLAN
monitor
valid interface combinations:
#{ managed } <= 4, #{ AP } <= 1,
total <= 4, #channels <= 1, STA/AP BI must match
HT Capability overrides:
MCS: ff ff ff ff ff ff ff ff ff ff
maximum A-MSDU length
supported channel width
short GI for 40 MHz
max A-MPDU length exponent
min MPDU start spacing
Device supports TX status socket option.
Device supports HT-IBSS.
Device supports SAE with AUTHENTICATE command
Device supports scan flush.
Device supports per-vif TX power setting
P2P GO supports CT window setting
P2P GO supports opportunistic powersave setting
Driver supports full state transitions for AP/GO clients
Driver supports a userspace MPM
Device supports active monitor (which will ACK incoming frames)
Driver/device bandwidth changes during BSS lifetime (AP/GO mode)
Device supports configuring vdev MAC-addr on create.
Device supports randomizing MAC-addr in scans.
Device supports randomizing MAC-addr in sched scans.
max # scan plans: 1
max scan plan interval: 65535
max scan plan iterations: 0
Supported TX frame types:
IBSS: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0
0xd0 0xe0 0xf0
managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0
0xc0 0xd0 0xe0 0xf0
AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0
0xd0 0xe0 0xf0
AP/VLAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0
0xc0 0xd0 0xe0 0xf0
mesh point: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0
0xb0 0xc0 0xd0 0xe0 0xf0
P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0
0xb0 0xc0 0xd0 0xe0 0xf0
P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0
0xc0 0xd0 0xe0 0xf0
P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0
0xb0 0xc0 0xd0 0xe0 0xf0
NAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0
0xd0 0xe0 0xf0
Supported RX frame types:
IBSS: 0x40 0xb0 0xc0 0xd0
managed: 0x40 0xb0 0xd0
AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
AP/VLAN: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
mesh point: 0xb0 0xc0 0xd0
P2P-client: 0x40 0xd0
P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
P2P-device: 0x40 0xb0 0xd0
NAN: 0xb0 0xd0
Supported extended features:
[ RRM ]: RRM
[ SET_SCAN_DWELL ]: scan dwell setting
[ BEACON_RATE_LEGACY ]: legacy beacon rate setting
[ BEACON_RATE_HT ]: HT beacon rate setting
[ BEACON_RATE_VHT ]: VHT beacon rate setting
[ FILS_STA ]: STA FILS (Fast Initial Link Setup)
[ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
[ CONTROL_PORT_OVER_NL80211 ]: control port over nl80211
[ ACK_SIGNAL_SUPPORT ]: ack signal level support
[ TXQS ]: FQ-CoDel-enabled intermediate TXQs
[ CAN_REPLACE_PTK0 ]: can safely replace PTK 0 when rekeying
[ AIRTIME_FAIRNESS ]: airtime fairness scheduling
[ AQL ]: Airtime Queue Limits (AQL)
[ CONTROL_PORT_NO_PREAUTH ]: disable pre-auth over nl80211 control port support
[ SCAN_FREQ_KHZ ]: scan on kHz frequency support
[ CONTROL_PORT_OVER_NL80211_TX_STATUS ]: tx status for nl80211 control
port support
[ BEACON_RATE_HE ]: HE beacon rate support (AP/mesh)
* [ POWERED_ADDR_CHANGE ]: can change MAC address while up

hex form:
pcilib: Error reading /sys/bus/pci/devices/0000:00:08.3/label:
Operation not permitted
01:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7902]
Subsystem: AzureWave Device [1a3b:5524]
Flags: bus master, fast devsel, latency 0, IRQ 75, IOMMU group 8
Memory at 7ef0200000 (64-bit, prefetchable) [size=1M]
Memory at c0500000 (64-bit, non-prefetchable) [size=32K]

