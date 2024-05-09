Return-Path: <linux-wireless+bounces-7391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5418C0F5E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4E2282043
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E114B09E;
	Thu,  9 May 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFQWcqGe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960714B090
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256538; cv=none; b=niBzVuILJue68GrC5SW/gI2aKAkduCDrOKGK2ByjKvIFxp2y9QL2K/D+MZuz2jFcrK8vkRU/7Tpzlv6oW9gQpA8N/ctZvZYktp4t0K+xeWUvGJZB2exWTQBNP4IGW6DjX2RY3rkOnugCYmSvtP14udk+uvt6NctMMSNIi26Y14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256538; c=relaxed/simple;
	bh=JOw1awT3uhHILa9hE4G9ItQgp+/4q01d+7Yyg1x5cUM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GRc4SIgDbRbYc0qpZ2m2Y/x093+lQkW2JZFBetlFC3AYgC6tLzoQSJa5hiQ+rOKBWFWyhr/iahXubb97igHp73lPx0mLYS8hPniZzqR4qUi5vf2TJikax5UyF6JO2t9xVjXYidGDF9irXFy9vUn3p/b5Mldogw4v2j6tV1bsTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFQWcqGe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34f52fc2191so461754f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 May 2024 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715256535; x=1715861335; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dznd3bjM/PeqDJaYgIJy0JnewJ/Lifz1NgwaaM3tKbU=;
        b=YFQWcqGenQgqRKeeiDvjkK84oAHqAkvjqdJXTdbtxh0sD87jQWC10ocv7hwpWTWilq
         f+2UL6p/CT84Nq2VXzN3paj9UVOsJFAGsKcmD6M/6xCvKuz16vfJl4q0tIl5IwjlfVi0
         3caCQLDtBakn6zJivkEr7KXlMfoL1uFmVQWKz+6XTM2/9Q4hyOvDiQOWJfiBEomjh+OB
         a0zFJ20zadUn6v6vfk3RDZ6nO2H7DA7g4ulyt+MQneQ2lQnatMUC/8WzlDSREeht4f9+
         CQ4kzuz6KDyIcJCCwikrY0aG3g/58dHmJVeoYDSpwc6ktq8MxDhrNwW23JKvYAwJ0H+Q
         SDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256535; x=1715861335;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dznd3bjM/PeqDJaYgIJy0JnewJ/Lifz1NgwaaM3tKbU=;
        b=VSVS3fCtLlnuW0r6GuD42TMRso217Fk9rkrxrML4XpYyDBCFo/3uIrFCeJqyq9X7gB
         DV/3xGMM7+/J5NwZZ3jhZiPQbsF43fkTac4MJKqWS/orqtwvkMUvOAvgSWjfRhCEaVFa
         PQGoIiXMs7YeA1PwiGwgdpVmf2Dsri2wdmivhyzr2ohWXM2oDuslgnEYuBH9coXEOzMh
         tpL+ePFfDGZm4IRh+KERenIphtoz1Wye+UPRHD8j/CcgHwTQqvOVtMGSnTyY/bdcjFmS
         U22sZXy9WpNpufr0EEuE4qhYoEf9ARXoMIFc1yqNQhj0Pm/JR6DqhFizPU3VeksHjj2V
         7LjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJX+Rm1EzwLKqkdAVDNe/BFxXn0jnyma2Y8sflFeLtWzJK34TwRK5loJRCJRKDi/nwaK75He6FYYBH61JbEsvgHeuI6W+zfGIGV+lvkWY=
X-Gm-Message-State: AOJu0YwUOoYsNgrCyPIbpaJuF4IolVKldGirKI3gnC7mGzEIfV6NbdTa
	+rdPb5CosEOjp0VkHqzKSSQjMZZZHiyGz54114YmfmMpbDL6fhD81VBPjW25
X-Google-Smtp-Source: AGHT+IGZP2SgmlizTixsQVtity+wyhHPJhMg697cbMWykmY9Vx62KtvD8LIiDflJivsrDTmzrW04Sw==
X-Received: by 2002:a5d:5908:0:b0:34a:2d0c:4463 with SMTP id ffacd0b85a97d-34fca149bbdmr4276260f8f.4.1715256534886;
        Thu, 09 May 2024 05:08:54 -0700 (PDT)
Received: from [10.123.13.239] ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bca6sm1550776f8f.12.2024.05.09.05.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 05:08:54 -0700 (PDT)
Message-ID: <cb6fe672-e18f-4864-980e-241749083565@gmail.com>
Date: Thu, 9 May 2024 05:08:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ath10k@lists.infradead.org,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
From: James Prestwood <prestwoj@gmail.com>
Subject: Ath10k "hardware restarting" all clients at specific location
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've got a really odd one here. We have about wifi 50 clients all 
experiencing a problem where seemingly out of the blue the ath10k driver 
times out reading a WMI command and restarts the hardware. I've poured 
though logs and cannot find any patters as far as when it happens. 
Sometimes during a scan, sometimes after a roam, and sometimes when the 
client has a stable connection. It appears completely random.

The issue looks to be isolated to a single physical location. We have 
many other locations with clients running an identical software stack 
(kernel version and ath10k firmware) and the same AP/network deployments 
and see ZERO instances of this in the last month of logs. Its only one 
physical location where clients are frequently seeing this happen. For 
this specific version of our software we are running:

Ubuntu 22.04 5.15.0-72-generic
QCA6174 HW 3.2
Ath10k firmware WLAN.RM.4.4.1-00288-QCARMSWPZ-1

I have also updated to the latest firmware (WLAN.RM.4.4.1-00309-) on a 
single client yesterday, and saw 3 instances of this still as of this 
morning.

Due to the isolated nature of this and having other locations with 
identical configurations/software it seems like some 
external/environmental difference at this location. Is there any 
external event that could cause this (rouge frame, interference, ???)

May 09 00:31:06 kernel: wlan0: disconnect from AP aa:46:8d:37:8f:48 for 
new assoc to aa:46:8d:37:80:b5
May 09 00:31:06 kernel: wlan0: associate with aa:46:8d:37:80:b5 (try 1/3)
May 09 00:31:06 kernel: wlan0: RX ReassocResp from aa:46:8d:37:80:b5 
(capab=0x1511 status=0 aid=4)
May 09 00:31:06 kernel: wlan0: associated
May 09 00:31:06 kernel: ath: EEPROM regdomain: 0x82d4
May 09 00:31:06 kernel: ath: EEPROM indicates we should expect a country 
code
May 09 00:31:06 kernel: ath: doing EEPROM country->regdmn map search
May 09 00:31:06 kernel: ath: country maps to regdmn code: 0x37
May 09 00:31:06 kernel: ath: Country alpha2 being used: ES
May 09 00:31:06 kernel: ath: Regpair used: 0x37
May 09 00:31:06 kernel: ath: regdomain 0x82d4 dynamically updated by 
country element
May 09 00:31:06 kernel: wlan0: Limiting TX power to 30 (30 - 0) dBm as 
advertised by aa:46:8d:37:80:b5
May 09 00:31:42 kernel: ath10k_pci 0000:02:00.0: timed out waiting peer 
stats info
May 09 00:31:45 kernel: ath10k_pci 0000:02:00.0: wmi command 90113 
timeout, restarting hardware
May 09 00:31:45 kernel: ath10k_pci 0000:02:00.0: could not request stats 
(-11)
May 09 00:31:45 kernel: ath10k_pci 0000:02:00.0: could not request peer 
stats info: -108
May 09 00:31:45 kernel: ath10k_pci 0000:02:00.0: failed to read 
hi_board_data address: -16
May 09 00:31:45 kernel: ieee80211 phy0: Hardware restart was requested
May 09 00:31:45 kernel: ath10k_pci 0000:02:00.0: could not request stats 
(-108)
May 09 00:31:45 kernel: ath10k_pci 0000:02:00.0: device successfully 
recovered
May 09 00:31:46 kernel: wlan0: deauthenticated from aa:46:8d:37:80:b5 
(Reason: 6=CLASS2_FRAME_FROM_NONAUTH_STA)

Thanks,

James


