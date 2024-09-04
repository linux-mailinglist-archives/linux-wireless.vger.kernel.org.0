Return-Path: <linux-wireless+bounces-12473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F896B8DB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 12:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7CC1C21425
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 10:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C73C1865F0;
	Wed,  4 Sep 2024 10:46:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952B635;
	Wed,  4 Sep 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446789; cv=none; b=QpwfgHFhKNY1Xsx5LwPDWH6yHlT/gaiHGFF81XxTN6dBqEO8A9Gr0iH7848MDaZwPQXfy9TVDTFRRE5fDX/WCk9myy6RTeGg8wu1u9uiWCqlcvczH4VdZnCEjPb1gGZTFzf/k+mdn5nTDYaao10/HwtxdWU24/y6tpCqIufn8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446789; c=relaxed/simple;
	bh=C3kWlcL2V1tdfmYpVEgH9f7Fwg9KCEu5d35QHW3LQu0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=JKMn/1xPP/YQjeJzD+lqloOU+xEMjdGlUvr8wQ3SiUbuQquOVqO80Sv2r8vBCibQhlN/Ut/ZySxAr+G1YYMzrfRpnDtOyPHSptxmTps8dMxkT20Kps26UXmUEDdAcAvMR7Eiq73axWOOFoSme9ar3o+r7X6Gh//O+QdeXL2EeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.179.80] (p54b6ff28.dip0.t-ipconnect.de [84.182.255.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8E5BA61BA1843;
	Wed,  4 Sep 2024 12:45:34 +0200 (CEST)
Message-ID: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de>
Date: Wed, 4 Sep 2024 12:45:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware (-110)
 (ETIMEDOUT)
To: Kalle Valo <kvalo@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
 James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Linux 6.11-rc6+ logged the warning below when resuming from ACPI S3 (or 
unloading and loading the `ath10k_core`/`ath10k_pci` modules) having 
been connected to an AVM network:

     wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware 
(-110)

Error code 110 is the value for ETIMEDOUT. I saw James patch [1], and 
applied it, and the error is still there (as exepected).

Can the warning be improved so the user know, which component is at fault?


Kind regards,

Paul


[1]: https://lore.kernel.org/all/20240814164507.996303-1-prestwoj@gmail.com/

```
Sep 04 07:21:38.469669 abreu kernel: Linux version 
6.11.0-rc6-00027-ga91d08fcc356 (build@bohemianrhapsody.molgen.mpg.de) 
(gcc (Debian 14.2.0-4) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) 
#294 SMP PREEMPT_DYNAMIC Tue Sep  3 23:01:18 CEST 2024
Sep 04 07:21:38.469718 abreu kernel: Command line: 
BOOT_IMAGE=/vmlinuz-6.11.0-rc6-00027-ga91d08fcc356 
root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer 
mem_sleep_default=deep log_buf_len=8M cryptomgr.notests
[…]
Sep 04 12:34:55.826218 abreu sudo[25874]:  pmenzel : TTY=pts/7 ; 
PWD=/home/pmenzel ; USER=root ; COMMAND=/usr/sbin/modprobe ath10k_pci
Sep 04 12:34:55.828046 abreu sudo[25874]: pam_unix(sudo:session): 
session opened for user root(uid=0) by pmenzel(uid=5272)
Sep 04 12:34:55.869839 abreu kernel: ath10k_pci 0000:3a:00.0: pci irq 
msi oper_irq_mode 2 irq_mode 0 reset_mode 0
Sep 04 12:34:56.005202 abreu sudo[25874]: pam_unix(sudo:session): 
session closed for user root
Sep 04 12:34:56.161706 abreu kernel: ath10k_pci 0000:3a:00.0: qca6174 
hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
Sep 04 12:34:56.162591 abreu kernel: ath10k_pci 0000:3a:00.0: kconfig 
debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
Sep 04 12:34:56.163115 abreu kernel: ath10k_pci 0000:3a:00.0: firmware 
ver WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
Sep 04 12:34:56.241683 abreu kernel: ath10k_pci 0000:3a:00.0: board_file 
api 2 bmi_id N/A crc32 d2863f91
Sep 04 12:34:56.333784 abreu kernel: ath10k_pci 0000:3a:00.0: htt-ver 
3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
Sep 04 12:34:56.417649 abreu kernel: ath: EEPROM regdomain: 0x6c
Sep 04 12:34:56.417919 abreu kernel: ath: EEPROM indicates we should 
expect a direct regpair map
Sep 04 12:34:56.418022 abreu kernel: ath: Country alpha2 being used: 00
Sep 04 12:34:56.418114 abreu kernel: ath: Regpair used: 0x6c
Sep 04 12:34:56.422440 abreu NetworkManager[610]: <info> 
[1725446096.4223] device (wlan0): driver supports Access Point (AP) mode
[…]
Sep 04 12:35:12.042484 abreu wpa_supplicant[618]: wlp58s0: WPA: Group 
rekeying completed with ce:ce:1e:27:bb:e0 [GTK=CCMP]
Sep 04 12:35:21.800998 abreu sudo[25953]:  pmenzel : TTY=pts/7 ; 
PWD=/home/pmenzel ; USER=root ; COMMAND=/usr/sbin/modprobe -r ath10k_pci
Sep 04 12:35:21.803733 abreu sudo[25953]: pam_unix(sudo:session): 
session opened for user root(uid=0) by pmenzel(uid=5272)
Sep 04 12:35:21.881668 abreu kernel: wlp58s0: deauthenticating from 
ce:ce:1e:27:bb:e0 by local choice (Reason: 3=DEAUTH_LEAVING)
Sep 04 12:35:22.905717 abreu kernel: ath10k_pci 0000:3a:00.0: failed to 
install key for vdev 0 peer ce:ce:1e:27:bb:e0: -110
Sep 04 12:35:22.906604 abreu kernel: wlp58s0: failed to remove key (0, 
ce:ce:1e:27:bb:e0) from hardware (-110)
Sep 04 12:35:22.908927 abreu wpa_supplicant[618]: wlp58s0: 
CTRL-EVENT-DISCONNECTED bssid=ce:ce:1e:27:bb:e0 reason=3 locally_generated=1
Sep 04 12:35:22.908995 abreu wpa_supplicant[618]: BSSID 
ce:ce:1e:27:bb:e0 ignore list count incremented to 2, ignoring for 10 
seconds
```

