Return-Path: <linux-wireless+bounces-9024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5579909D97
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 15:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6641F281783
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 13:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C0517F397;
	Sun, 16 Jun 2024 13:11:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2A19D8BA;
	Sun, 16 Jun 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718543481; cv=none; b=SFDRUaQ0Daleflo+f9u5T4uMmzdIBg3mDuAorRB/hPLk94nHVyyjdV+MlQGN2eERVxir/usoTtWc6dIYXgzWwid+fccm31gAkOeUcZ9SrAE9gWAiwOrpE+DQSdQkMELUI5aOIwNi8ambNkWrEJy8ryLBT56xO/Fp55rhk5JVc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718543481; c=relaxed/simple;
	bh=6PvgRI9Yol2o20j2EJGx9Xs1iEwNeR4MJGDT8YlKfF8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sMuBLLD0PAYtpBJmgsmAtFXl4ZQB1PgkbzTxzjdrHlax9m6wPqJgzJsTpwgFHPnMjxlEZ0UOaQJBTSbpvEwcB/YemWJy1LRQ9N77W8Y9r4yIh94d8evRNfAz1rBl+wO9KvdaqPiOC2KqkfjOYel2atl9Kg0r/sSsDcQbHA5V+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.16.184.163] (i68973E31.versanet.de [104.151.62.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 743FC61E5FE01;
	Sun, 16 Jun 2024 15:10:34 +0200 (CEST)
Message-ID: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
Date: Sun, 16 Jun 2024 15:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: invalid vht params rate 1920 100kbps nss 2 mcs 9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Linux 6.10-rc3 (commit a3e18a540541) logged the warning below when 
connecting to a public WiFi:

     ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 2 
mcs 9


Kind regards,

Paul


```
Jun 16 11:38:15 abreu kernel: Linux version 
6.10.0-rc3-00174-ga3e18a540541 (build@bohemianrhapsody.molgen.mpg.de) 
(gcc (Debian 13.2.0-25) 13.2.0, GNU ld (GNU Binutils for Debian) 2.42) 
#196 SMP PREEMPT_DYNAMIC Sun Jun 16 06:02:29 CEST 2024
[…]
Jun 16 11:38:15 abreu kernel: DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 
2.21.0 06/02/2022
[…]
Jun 16 11:38:33 abreu kernel: ath10k_pci 0000:3a:00.0: enabling device 
(0000 -> 0002)
Jun 16 11:38:33 abreu kernel: ath10k_pci 0000:3a:00.0: pci irq msi 
oper_irq_mode 2 irq_mode 0 reset_mode 0
Jun 16 11:38:34 abreu kernel: ath10k_pci 0000:3a:00.0: qca6174 hw3.2 
target 0x05030000 chip_id 0x00340aff sub 1a56:1535
Jun 16 11:38:34 abreu kernel: ath10k_pci 0000:3a:00.0: kconfig debug 0 
debugfs 0 tracing 0 dfs 0 testmode 0
Jun 16 11:38:34 abreu kernel: ath10k_pci 0000:3a:00.0: firmware ver 
WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp crc32 bf907c7c
Jun 16 11:38:34 abreu kernel: ath10k_pci 0000:3a:00.0: board_file api 2 
bmi_id N/A crc32 d2863f91
Jun 16 11:38:34 abreu kernel: ath10k_pci 0000:3a:00.0: htt-ver 3.87 
wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
Jun 16 11:38:34 abreu kernel: ath: EEPROM regdomain: 0x6c
Jun 16 11:38:34 abreu kernel: ath: EEPROM indicates we should expect a 
direct regpair map
Jun 16 11:38:34 abreu kernel: ath: Country alpha2 being used: 00
Jun 16 11:38:34 abreu kernel: ath: Regpair used: 0x6c
[…]
Jun 16 11:39:20 abreu kernel: wlp58s0: authenticate with 
70:18:a7:0e:f7:cb (local address=9c:b6:d0:d1:6a:b1)
Jun 16 11:39:20 abreu kernel: wlp58s0: send auth to 70:18:a7:0e:f7:cb 
(try 1/3)
Jun 16 11:39:20 abreu kernel: wlp58s0: send auth to 70:18:a7:0e:f7:cb 
(try 2/3)
Jun 16 11:39:20 abreu kernel: wlp58s0: send auth to 70:18:a7:0e:f7:cb 
(try 3/3)
Jun 16 11:39:20 abreu kernel: wlp58s0: authentication with 
70:18:a7:0e:f7:cb timed out
Jun 16 11:39:22 abreu kernel: wlp58s0: authenticate with 
4c:bc:48:39:16:ab (local address=9c:b6:d0:d1:6a:b1)
Jun 16 11:39:22 abreu kernel: wlp58s0: send auth to 4c:bc:48:39:16:ab 
(try 1/3)
Jun 16 11:39:22 abreu kernel: wlp58s0: send auth to 4c:bc:48:39:16:ab 
(try 2/3)
Jun 16 11:39:22 abreu kernel: wlp58s0: send auth to 4c:bc:48:39:16:ab 
(try 3/3)
Jun 16 11:39:22 abreu kernel: wlp58s0: authentication with 
4c:bc:48:39:16:ab timed out
Jun 16 11:39:24 abreu kernel: wlp58s0: authenticate with 
4c:bc:48:38:d8:4b (local address=9c:b6:d0:d1:6a:b1)
Jun 16 11:39:24 abreu kernel: wlp58s0: send auth to 4c:bc:48:38:d8:4b 
(try 1/3)
Jun 16 11:39:24 abreu kernel: wlp58s0: authenticated
Jun 16 11:39:24 abreu kernel: wlp58s0: associate with 4c:bc:48:38:d8:4b 
(try 1/3)
Jun 16 11:39:24 abreu kernel: wlp58s0: RX AssocResp from 
4c:bc:48:38:d8:4b (capab=0x1101 status=0 aid=30)
Jun 16 11:39:24 abreu kernel: wlp58s0: associated
Jun 16 11:39:24 abreu kernel: wlp58s0: Limiting TX power to 20 (23 - 3) 
dBm as advertised by 4c:bc:48:38:d8:4b
Jun 16 11:39:50 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:39:56 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:40:02 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:40:08 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:40:20 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:40:26 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:40:32 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:40:38 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:40:43 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:40:49 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:41:01 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:41:13 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:41:19 abreu kernel: ath10k_pci 0000:3a:00.0: invalid vht 
params rate 1920 100kbps nss 2 mcs 9
Jun 16 11:41:21 abreu kernel: wlp58s0: deauthenticating from 
4c:bc:48:38:d8:4b by local choice (Reason: 3=DEAUTH_LEAVING)

