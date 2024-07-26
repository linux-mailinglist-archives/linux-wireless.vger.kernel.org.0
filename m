Return-Path: <linux-wireless+bounces-10551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E758C93DAD9
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 00:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B4284532
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 22:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE3214C5B0;
	Fri, 26 Jul 2024 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Pt827JED"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA53812;
	Fri, 26 Jul 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034470; cv=none; b=a4CDPx1nb2WuXQsR4YFeKzZh8oh2Vwa9pVJTj8Fxwxlw9ZiEZYA9cVssvOIXlsdk9jsgJhgHYJiYhAZj5jzQSmXBK/OKrF5485+PAoR6pqpIcpxbSuvJaklrcrgFqWhk+mklO//Zx/AktmwqyduaPKLJyphtL+G9OpRgtWmvXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034470; c=relaxed/simple;
	bh=KKD6p/UTkke7Sr6KY++J/QdqRmvj2G3eGw3nTtCdEdQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uLlEdA2HGIfFeqBbIbRrTZ3GuhLmevy1pmKklDxrjeBYhUqxALU1RjbXWPy5ByJNe4EbLqe6cNENwFo3h25IumHpBLQo/jHxdi5EEJdHK4vZjanRNllgYjML97/lddyzAQsCTrApMuwAlhLQod2iKVEcxoHUZWHJn4oB8u1BLCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Pt827JED; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WW33M1KCdz9sWt;
	Sat, 27 Jul 2024 00:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1722034463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NtyOCnKJWBnAbIlOSCkfErDrQOfPUdHdFFyoeRL8MOs=;
	b=Pt827JEDR88sXtkDIH2dX2SiBpwr8sebvsvtn8FOasmv68TyxN+YTilDMM9JywiU4sEXKm
	+RUD7s0i8O4yG6au00czlTPWYadQDpbSguwxS7QS2IvJS8S1XuH5Q547r1dNwfJTALYutW
	hsYAOE9Hv8R1dgYl/DF5M6trNbcFABR1GmaYxMX8oCvPm5U8RNvfReMds37MuI6TThY4E+
	vHRuiRQVMMclEPEgMGL8gS2/UrvuvtqO558qEsTU9YLkf3GYBjAbO85tzX+S26cTrtIF9W
	NRwPugvB2hxYbLQX7Xo1yvdrO1omkLqPJtC4NaJdsLypr+B6HkH6wkMS8YEJTg==
Message-ID: <6d402141-a457-4096-a487-56b4140361be@hauke-m.de>
Date: Sat, 27 Jul 2024 00:54:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: stable@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com, johannes.berg@intel.com,
 quic_ramess@quicinc.com, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: stable backport: wifi: mac80211: track capability/opmode NSS
 separately
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4WW33M1KCdz9sWt

Hi,

Please backport the following patch back to the stable series 6.6 and 6.1:
commit a8bca3e9371dc5e276af4168be099b2a05554c2a
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Wed Feb 28 12:01:57 2024 +0100

     wifi: mac80211: track capability/opmode NSS separately

There is a small conflict in the copyright year update in 
net/mac80211/sta_info.h, just take the 2024 version.


On kernel 6.1 please backport this patch first to make the other one apply:
commit 57b341e9ab13e5688491bfd54f8b5502416c8905
Author: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Date:   Tue Feb 7 17:11:46 2023 +0530

     wifi: mac80211: Allow NSS change only up to capability



This commit fixes a throughput regression introduced into Linux stable 
with the backport of following commit:

commit dd6c064cfc3fc18d871107c6f5db8837e88572e4
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Jan 29 15:53:55 2024 +0100

     wifi: mac80211: set station RX-NSS on reconfig

On older kernel versions it is harder to backport the fixes, maybe 
revert the offending commit in Linux stable 5.15 and older.

This regression was found by multiple users of OpenWrt in Wifi AP mode.
See the discussion in this forum thread: 
https://forum.openwrt.org/t/openwrt-23-05-4-service-release/204514/111

Thank you KONG from the OpenWrt forum for finding the commit which 
reduced the Wifi throughput.


Hauke

