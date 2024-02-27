Return-Path: <linux-wireless+bounces-4061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699FB868A97
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 09:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093661F24C97
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 08:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA4354F8A;
	Tue, 27 Feb 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="F0OV3dhQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD356441
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021571; cv=none; b=FZ/G3eeQGiyNCmdUELu19TckXGNhn8aHkqUQ0RTKam8ncBWYI6MalZSWeINfvYH7YYav+sHbypstivQeEVKsFKOE4djHUKwx2LQz/5ZoNdL7B97RlIZ4JWRrudjkLr+QqAr4AiS+n53bk4wo7UKzqtXSbtdWLIXBpAy/hwGDy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021571; c=relaxed/simple;
	bh=TGTRfMQt2WIwbfRvPhR0fYm/f8QTMbQPz/5vGE2EYNI=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=S5vLjqnA/6Z4Gk2tHaXJ08faodCfI5jc1BNTkVbk+Lpaj+viZlYXoxkJd4joYxAmOVNfJ2IcyYH69Wy8M+PcjGyRcQZ/Y0l7HdmwnngcJgo4aSAr3tSL03yE5zoZaxMAginm/nchIgslkM/vPQ/rotjURJhWdQNHVoHZP5Mg6XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=F0OV3dhQ; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=TGTRfMQt2WIw
	bfRvPhR0fYm/f8QTMbQPz/5vGE2EYNI=; h=subject:to:from:date;
	d=aixigo.com; b=F0OV3dhQl3BTnp+u2QuRYKxfPPNh17czBWJDgt1kHNZ3Ydc/Fs86Yk
	2FEDjeOsxWOoRfaoVkHi+F2x1HYAQMPJA/3pCOhKbec3ThGd4254pGhDE3ALhTbxLBKhNK
	8p9lSGioeVsY974PaGk1EHRqt/j4EtLicXvoufe0NqITEN4=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 69c9f0c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-wireless@vger.kernel.org>;
	Tue, 27 Feb 2024 09:12:43 +0100 (CET)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 41R8CgIl2525758
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Tue, 27 Feb 2024 09:12:43 +0100
Message-ID: <dd1e2440-bb05-48d7-9f68-29bae758110d@aixigo.com>
Date: Tue, 27 Feb 2024 09:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
To: linux-wireless@vger.kernel.org
Subject: "iwlwifi: probe of 0000:00:14.3 failed with error -22"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

Hi folks,

The Intel Wifi hardware of a colleague's Tuxedo laptop (running Debian 12,
kernel 6.1.76) isn't found at boot time anymore. It doesn't come back on a
reboot. The kernel log shows

[Mon Feb 26 13:21:23 2024] Intel(R) Wireless WiFi driver for Linux
[Mon Feb 26 13:21:23 2024] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[Mon Feb 26 13:21:23 2024] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[Mon Feb 26 13:21:23 2024] iwlwifi 0000:00:14.3: Adding cdb to rf id
[Mon Feb 26 13:21:23 2024] iwlwifi 0000:00:14.3: Detected RF 0x1010c000 from crf id 0x504
[Mon Feb 26 13:21:23 2024] iwlwifi: No config found for PCI dev 51f1/0000, rev=0x370, rfid=0x1010c000
[Mon Feb 26 13:21:23 2024] iwlwifi: probe of 0000:00:14.3 failed with error -22

Please note the last 3 lines. rfkill doesn't list wireless.

On another Tuxedo laptop with the same hardware (AFAICT) we get

[Tue Feb 27 07:35:34 2024] Intel(R) Wireless WiFi driver for Linux
[Tue Feb 27 07:35:34 2024] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[Tue Feb 27 07:35:34 2024] iwlwifi 0000:00:14.3: firmware: direct-loading firmware iwlwifi-so-a0-hr-b0-72.ucode
[Tue Feb 27 07:35:34 2024] iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
[Tue Feb 27 07:35:34 2024] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.36
[Tue Feb 27 07:35:34 2024] iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (-2)
[Tue Feb 27 07:35:34 2024] iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (-2)
[Tue Feb 27 07:35:34 2024] iwlwifi 0000:00:14.3: loaded firmware version 72.daa05125.0 so-a0-hr-b0-72.ucode op_mode iwlmvm
:
[Tue Feb 27 07:35:35 2024] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz, REV=0x370
:
[Tue Feb 27 07:35:35 2024] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
:
[Tue Feb 27 07:35:36 2024] iwlwifi 0000:00:14.3: base HW address: e4:0d:xx:xx:xx:xx


Upgrading the kernel to Debian's backports version 6.5.7 doesn't help.
No wifi. I had upgraded the firmware file to version 83 as well, but this
is moot if the firmware isn't loaded at all.


Every helpful comment is highly appreciated

Harri

