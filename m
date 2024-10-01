Return-Path: <linux-wireless+bounces-13381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AF198C133
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A188B1F21912
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54A1C9DCB;
	Tue,  1 Oct 2024 15:07:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5B1CBE89
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.59.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795237; cv=none; b=KY6tALIQNe7GzzAMo7KcKD7SM90PXT1fi2tEMBAbAXbScbMIUdH27ou3PfZr81DDxIJSJbDeDho5LfR3MEZmt+Hx+AmNyS2nLo2zLLr8+kvHyiWSzHIcHWM9oB45jeadcLnYaDiutHWNwW40Az6IvpSzFExPOqHxENYVoL+r62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795237; c=relaxed/simple;
	bh=P63BpGXJRAiw/MMIcWUcg8EqRpCWslgnF95bOy6a1yo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=oPgJyl6U9IKmBl6a1Tqs9XTzTv6KEOzmSmjPCaII0NRXnnxLHFNkZxaqE2emzGBh099RjzZMN3Hg1jPCKmgJcjdWVnsIhtcauSu9MvwaeHS12ky9inLu1Gb2OQ94bB5vcQsCvEFxkrDhi920KaYUFYuaXuU1LnGnBIepelTQG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=80.241.59.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XJ1Hy0xcRz9sZv;
	Tue,  1 Oct 2024 16:57:18 +0200 (CEST)
Message-ID: <95036c09-dc88-4da2-a534-4bfedfa27a25@denx.de>
Date: Tue, 1 Oct 2024 16:57:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
From: Stefan Roese <sr@denx.de>
Subject: iwlwifi on AMD ZynqMP: Timeout waiting for PNVM load!
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4XJ1Hy0xcRz9sZv

Hi,

I'm currently facing a problem loading the iwlwifi driver to support
a AX210 PCIe module in our AMD ZynqMP system.

I've tested with v6.1 LTS, v6.6 LTS and now also with v6.10. Each time
with a different firmware (latest firmwares installed on the system).

Here the log when loading the driver on v6.10.12:

[   25.643488] Intel(R) Wireless WiFi driver for Linux
[   25.648609] iwlwifi 0001:01:00.0: enabling device (0000 -> 0002)
[   25.655606] iwlwifi 0001:01:00.0: Detected crf-id 0x400410, cnv-id 
0x400410 wfpm id 0x80000000
[   25.664288] iwlwifi 0001:01:00.0: PCI dev 2725/0024, rev=0x420, 
rfid=0x10d000
[   25.694819] iwlwifi 0001:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 
0.0.2.42
[   25.704341] iwlwifi 0001:01:00.0: loaded firmware version 
89.202a2f7b.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm
[   25.752697] iwlwifi 0001:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 
160MHz, REV=0x420
[   25.960182] iwlwifi 0001:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[   25.966334] iwlwifi 0001:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[   25.972564] iwlwifi 0001:01:00.0: WFPM_AUTH_KEY_0: 0x90
[   25.977892] iwlwifi 0001:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[   25.985554] iwlwifi 0001:01:00.0: loaded PNVM version 35148b80
[   26.243282] iwlwifi 0001:01:00.0: Timeout waiting for PNVM load!
[   26.249313] iwlwifi 0001:01:00.0: Failed to start RT ucode: -110
[   26.255406] iwlwifi 0001:01:00.0: WRT: Collecting data: ini trigger 
13 fired (delay=0ms).
[   26.264833] iwlwifi 0001:01:00.0: Start IWL Error Log Dump:
[   26.270431] iwlwifi 0001:01:00.0: Transport status: 0x00000042, valid: 6
[   26.277155] iwlwifi 0001:01:00.0: Loaded firmware version: 
89.202a2f7b.0 ty-a0-gf-a0-89.ucode
[   26.285701] iwlwifi 0001:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN 

[   26.292753] iwlwifi 0001:01:00.0: 0x002002F0 | trm_hw_status0
[   26.298527] iwlwifi 0001:01:00.0: 0x00000000 | trm_hw_status1
[   26.304296] iwlwifi 0001:01:00.0: 0x004DAD6C | branchlink2
[   26.309804] iwlwifi 0001:01:00.0: 0x004D09AE | interruptlink1
[   26.315571] iwlwifi 0001:01:00.0: 0x004D09AE | interruptlink2
[   26.321339] iwlwifi 0001:01:00.0: 0x0001668E | data1
[   26.326325] iwlwifi 0001:01:00.0: 0x01000000 | data2
[   26.331314] iwlwifi 0001:01:00.0: 0x00000000 | data3
[   26.336304] iwlwifi 0001:01:00.0: 0x00000000 | beacon time
[   26.341808] iwlwifi 0001:01:00.0: 0x0005CEA6 | tsf low
[   26.346975] iwlwifi 0001:01:00.0: 0x00000000 | tsf hi
[   26.352072] iwlwifi 0001:01:00.0: 0x00000000 | time gp1
[   26.357328] iwlwifi 0001:01:00.0: 0x00071E47 | time gp2
[   26.362572] iwlwifi 0001:01:00.0: 0x00000001 | uCode revision type
[   26.368833] iwlwifi 0001:01:00.0: 0x00000059 | uCode version major
[   26.375040] iwlwifi 0001:01:00.0: 0x202A2F7B | uCode version minor
...

I've also tested w/o the PNVM file:

https://bugzilla.kernel.org/show_bug.cgi?id=212371#c13

This results in the same problem though.

On a Raspberry Pi based system the exact same module loads just fine.
So somehow this is related to this Xilinx / AMD ZynqMP based system.

The connected PCIe RP is tested successfully with multiple other
PCIe devices, also using busmastering (e.g. NVMe drive, i210). So
I don't think that it's a general problem of the PCIe RP used in this
setup.

Does anyone have any idea why this driver fails on our ZynqMP based
system? Anything else I could / should test? Or any other test results
I should provide that might help fixing this issue?

Best regards in advance,
Stefan

