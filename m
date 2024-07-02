Return-Path: <linux-wireless+bounces-9870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E130E9243A8
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481CDB21380
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E9B1BD01E;
	Tue,  2 Jul 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="P2OWpqBs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C021BC094
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938096; cv=none; b=X46t+CgQV80nBcLl41xFr+fZRpGNkfDlDDDEP1Yd6/dl94nkuP6XO5877zvKPXHW53ym9aIlRlbtDNtjYRlSwDdXHEREVrHVjrE0KU05mhXxoKLD3ez3uwrWiUgwWcPx6blgzFIlVRak2XBwy6/6W7l2uBzL/HiWwaOCKMhmZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938096; c=relaxed/simple;
	bh=eUDp2ey1q/v7+G59RmOozKYa8089GRmtUvSz2/ee8Eg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=O7Pi8mcItliMNfXRYQjI4kZwFFs4shG9fZkVyqnahF3jEzcerRM0b7lITGb0WEO3tG+QegxB1F/xir0HxhI0Ap5nxSEbfTXKHZXMLHO8xaTPRs5CrJBrtiOsPdrSS0c+9ZX4K2dgaRSnS0AcGxKc3NEoTk5v+GIFd3uc8BzK1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=P2OWpqBs; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E51852C4268
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 16:18:34 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4B125600091
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 16:18:27 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2B5EE13C2B0
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 09:18:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2B5EE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1719937104;
	bh=eUDp2ey1q/v7+G59RmOozKYa8089GRmtUvSz2/ee8Eg=;
	h=Date:To:From:Subject:From;
	b=P2OWpqBsE5+PhmIjjpIN7n5kwNO2+vleUlILx7EX9JGyvnKoUlUcw/rM55SyvFE9n
	 8nDEPjeiBsTGilj2YEf7pJUknJeCaUmUDNFaWjuQzVRri7hq7T/WSY5VZGJjkkw+XS
	 OmsMf4vQmJCaQE3SkFDOwiyisSzi3/AUOlpUuHGA=
Message-ID: <59fc035c-fcc5-b027-5dd0-07edf5bfb3ca@candelatech.com>
Date: Tue, 2 Jul 2024 09:18:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: iwlwifi/be200: Does not detect AP on non-PSC channel.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1719937108-9dxzXp8YokLr
X-MDID-O:
 us5;ut7;1719937108;9dxzXp8YokLr;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

Hello,

I brought up a 40Mhz AP on 6Ghz channel-1, but my be200 radio does not see it in
a scan.  A second sniffer radio does see beacons on channel 1.  If I move
the 40Mhz AP to channel 5 (PSC channel), then be200 sees it immediately.

There is a second 'real' AP in this environment that is very likely to be
showing colocated SSID information in its 2.4/5G beacons.  Its BSSIDs for
all 3 bands show as expected.

Is be200 supposed to be able to scan non PSC channels at all?  I have
mucked a bit with supplicant in this area, so I might have broken it,
but I'm trying to understand expected behavior before I go 'fix' something
else...

Here are my coloc scan related patches, goal was to make it scan harder
every 5 attempts in case it is not finding what it wants on the PSC channels or
lower-band beacons.

https://github.com/greearb/hostap-ct/commit/4d8a0808356771aa4701ce07582a722f9ca34ce2

https://github.com/greearb/hostap-ct/commit/335ef5980a85f9ddd6facc79f27b353b62ade4d1


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


