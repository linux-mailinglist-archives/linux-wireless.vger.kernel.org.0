Return-Path: <linux-wireless+bounces-10209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB14F92FAF0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 15:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEA01F2316F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29E16F29A;
	Fri, 12 Jul 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeNblWot"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041F1428E5
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720789918; cv=none; b=Mgl9YNmeVGR+tsZuOLNeUb0vip4Z6Vq2Y8EXTlJ0XvWV48ghGKTpPZaBYA7TD60OgviBKCnz9i/L2H9oqT7WjiEHK/wb3PDr2zU7bH+UqnCWYbMkjyn2V5MNGEsLkhLZCDKelOW5kpPByaaOY9djchDqNttXGyqNdhXu+x6DRuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720789918; c=relaxed/simple;
	bh=tyTDRiFndnO5AaPU32CxMb2nV0WpI9zoHhg4FH6pYTY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Ax3LesjGYSX504uJrDsgWm6I4MM2icxM5IHTvv5ms/FMZPNLKZ8oDbWdRASL00ZBu3ZHEoENwjWdreUn25ZXpjWWf7r7KYUEUTimceGrfkZDwYg5/s+ifIkdgwd1eUtf2DPLK2XVcllaoDDb6m4O8C/IunjiFcM6gQffkkSu7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeNblWot; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b5dc36b896so15427976d6.1
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720789916; x=1721394716; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkdKHKm/TFTtDmbppb/k1qYEcMnKiahnVrBBOEVc9Pk=;
        b=WeNblWotQOj070fppUMXf+GHAw0bFiiKz5v24hZ15t0FZHCB4XuZvbNzkU9JZcEtGL
         t+7+eExeH3A+v8YCEEj9MgpeGAR9f549HQlFDyTjfibw4rxT1FrSWgqOnfN/5pm9F38w
         1LcSMDB+EUX4kCPtjJgT/KjK7VG8+HL/OXSZ8J4KNd4ZMkuz+BHApR/44khg2gEmEg1T
         zFg+FcBZVSVvghFMXr5UtE4xZvDWeKsGsWyvSmpiCtv3LLgweozuZzrZCsEsu0Xt2qe9
         87oJmlE69jqAZUWEFidwIqqqvDfeWdc9IkDwS7qKcawoghc5Q4xqlOl99WdmutJYkknr
         uYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720789916; x=1721394716;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AkdKHKm/TFTtDmbppb/k1qYEcMnKiahnVrBBOEVc9Pk=;
        b=SAvc70+qDRjyhYN1rtYpuZOLnaXS4s2g0HydfMuH2yOs1Q6sFGN4Y86kgOFvn6h6q+
         HJQNtrfO4lifL7lKMRXwshm7ekWk5gDQsAQ/Pdkho27vXU0uibhwwmZWXX1MmelJ8Es/
         7Nbwnkhe7Ybs73hG+JY1xbM2S9+deAB0uULX+3u/4NKOQ0lQJyjsn/gggsVxhawyRs/C
         0PydxUizNOiJWu9gdfRwc8ZohkDxHSjW3dUU48kIn4c8W3hUDfHpANEShOKBpoikt7is
         SnqI2NHJ5W5tht3kecO74ithh+1dk8Yrsy1CGaHWILbXfj1/r82qv3gDJb5/YbSUjt9j
         g6/A==
X-Gm-Message-State: AOJu0YxGDNtFgs5B1DLt8Uef6OSFpCD03MPSl2Px2YmBd8K0Ucgc6gy6
	0qvB9zX75aUBX9tvubXFti3m/1JyILsobxn+EEjWxT2eijv3o+qfuGM1oA==
X-Google-Smtp-Source: AGHT+IED307hHiYmeEMqrcIph10nnRSAtmRhbG2CzZsWy9UG6Rr4DImK/4iTZu3mKhjEluoGCu2Frg==
X-Received: by 2002:a05:6214:2a47:b0:6b5:3621:cfde with SMTP id 6a1803df08f44-6b754c33341mr47044466d6.0.1720789915749;
        Fri, 12 Jul 2024 06:11:55 -0700 (PDT)
Received: from [10.102.4.159] ([50.78.19.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9fd3acsm35344876d6.56.2024.07.12.06.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 06:11:53 -0700 (PDT)
Message-ID: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
Date: Fri, 12 Jul 2024 06:11:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath10k@lists.infradead.org
From: James Prestwood <prestwoj@gmail.com>
Subject: ath10k "failed to install key for vdev 0 peer <mac>: -110"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I've seen this error mentioned on random forum posts, but its always 
associated with a kernel crash/warning or some very obvious negative 
behavior. I've noticed this occasionally and at one location very 
frequently during FT roaming, specifically just after CMD_ASSOCIATE is 
issued. For our company run networks I'm not seeing any negative 
behavior apart from a 3 second delay in sending the re-association frame 
since the kernel waits for this timeout. But we have some networks our 
clients run on that we do not own (different vendor), and we are seeing 
association timeouts after this error occurs and in some cases the AP is 
sending a deauthentication with reason code 8 instead of replying with a 
reassociation reply and an error status, which is quite odd.

We are chasing down this with the vendor of these APs as well, but the 
behavior always happens after we see this key removal failure/timeout on 
the client side. So it would appear there is potentially a problem on 
both the client and AP. My guess is _something_ about the re-association 
frame changes when this error is encountered, but I cannot see how that 
would be the case. We are working to get PCAPs now, but its through a 
3rd party, so that timing is out of my control.

 From the kernel code this error would appear innocuous, the old key is 
failing to be removed but it gets immediately replaced by the new key. 
And we don't see that addition failing. Am I understanding that logic 
correctly? I.e. this logic:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/key.c#n503

Below are a few kernel logs of the issue happening, some with the deauth 
being sent by the AP, some with just timeouts:

--- No deauth frame sent, just association timeouts after the error ---

Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for new 
assoc to <new BSS>
Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key 
for vdev 0 peer <previous BSS>: -110
Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous BSS>) 
from hardware (-110)
Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
Jul 11 00:05:36 kernel: wlan0: authenticated
Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 
status=0 aid=16)
Jul 11 00:05:36 kernel: wlan0: associated

--- Deauth frame sent amidst the association timeouts ---

Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for new 
assoc to <new BSS>
Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key 
for vdev 0 peer <previous BSS>: -110
Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous BSS>) 
from hardware (-110)
Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while 
associating (Reason: 8=DISASSOC_STA_HAS_LEFT)
Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
Jul 11 00:43:24 kernel: wlan0: authenticated
Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 
status=0 aid=101)
Jul 11 00:43:24 kernel: wlan0: associated


