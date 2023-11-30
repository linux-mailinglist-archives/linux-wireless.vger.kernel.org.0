Return-Path: <linux-wireless+bounces-237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F077FF347
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 16:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F591C2085C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AA448CF7;
	Thu, 30 Nov 2023 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLFGwp5b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A20310EA
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 07:15:14 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2988d62eso613810a34.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 07:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701357313; x=1701962113; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYxQGcpqvZSnTdrcZYKUf6MgQycD5OfPTFYBGRzJOrw=;
        b=lLFGwp5bvo6H9TV2i3ohbsPIcdOMHW7AFAMU3F3hNSgVHEbVbCz4cCVeVsc0KFSYbi
         KoceKntmZcd0rxJRjuAxmD7g06djAqcgRaQdHgDKsPoMoJNvYH4/pTmrJk+JTGSx089C
         ecEywJJBthGzMKOKJGGxOqm3FoSO88rxSxavw0wZDbBcwdqOC+xYCWB4X2K8NNzSVPKN
         /xUp9wyn6aBvmPrvvDpeQyx3MKi5tWxuBFrRnWVlu6ur4BY3wQBCDmWuwcKkJow7XGri
         W8VLrllePh+5SLEH2UDVlr2FcOUf4vqU7UMZQaDaLeu1dZ7go8XTd6PBZ8aMUnzPSVGa
         vItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357313; x=1701962113;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYxQGcpqvZSnTdrcZYKUf6MgQycD5OfPTFYBGRzJOrw=;
        b=t34csDRbarifAfrb1NecgLEzwtiVtpCfYi9KTK0x3CzHYswPi6Mx6VnSvukeQ8cfW4
         D5veOJBVuzrF9dKW0ZLEjkbo9/sR67j+DUZY3r/9p3oiHCxzbuX2HXqJWfMvty99bZOw
         OYDQi/TFKtamkKE36Jfs7QARGlKALJqWz6YJI6c0CRNAIslxB80UeS6G4IQxTp6CZSHV
         eG7XLZOxkougqW1taIZyVkww2zKeGOKaI9ncB6P5yAWRBjcGGIGO2aZ3kGX9C/xLSeq8
         m0LcBPDzXvDdPsb/8kD6Uzz7L8cQYhXikzFfWqKucY6M6s/ozK7SyjCIaFvi/5tsvfNX
         gyZA==
X-Gm-Message-State: AOJu0YyLamGDZQ0L8ViwA3uWhdIKvNPxyFjdaYMiLGOpdiOA7jRIRwnB
	5hi4uMe8QcN9zjzrCddH3UJt+JGDNvQ=
X-Google-Smtp-Source: AGHT+IEai8Tld1vj5hVV4wJzYu+GSLDgLCyYtvTxx8tyPc23vfH9xk48vWnkxyzijpKSnYTynDE4kg==
X-Received: by 2002:a05:6830:1245:b0:6bf:3f4:3edc with SMTP id s5-20020a056830124500b006bf03f43edcmr23607904otp.22.1701357313036;
        Thu, 30 Nov 2023 07:15:13 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bs44-20020a05620a472c00b0077d7eaefc08sm565423qkb.87.2023.11.30.07.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 07:15:12 -0800 (PST)
Message-ID: <2515fe0a-107e-40dc-800f-6ca3d65a291a@gmail.com>
Date: Thu, 30 Nov 2023 07:15:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org
From: James Prestwood <prestwoj@gmail.com>
Subject: Ping/IP network loss post-roam
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

We have noticed a sporadic problem that seems to come and go. It was 
first noticed only on a specific AP manufacturer but more recently seen 
on another which is why I'm revisiting the problem.

The client is using ath10k QCA6174 hw 3.2 hardware. The network is WPA2, 
configured with FT. This has been seen both with over-Air and over-DS.

The client will always roam using FT without a problem. No indication of 
failed FT (ft-auth/ft-action and assoc are both successful). Sometimes 
though, after the roam, the client seems to lose all IP networking 
capabilities (pings, tcp/udp all fail).

IWD is getting zero indication there there is a problem after the roam. 
No packet/beacon loss CQM events, no deauths. On the AP side (if we even 
get any indication of a problem) we see "client not responding". It 
appears there is some disconnect between the clients state and the state 
the AP thinks the client is in. The client thinks its connected, the AP 
thinks the client has disappeared.

After noticing this problem a watchdog was implemented which starts 
pinging post-roam and if enough pings fail it triggers a deauth and 
authenticates again. This at least gets the client back on the network, 
but obviously isn't great because the client loses networking for an 
extended period waiting for pings to fail, then deauth/reauthing, doing 
DHCP etc. We hadn't gotten any traction trying to explain the issue to 
the AP vendor. Its always a client issue...

These are production devices and ath10k debugging is not built in to the 
module. All I have is kernel/IWD logs which just shows the roam was 
successful, and we deauthed later. Not particularly useful.

I'm trying to determine where the problem is, is it client side or 
infrastructure, and if there is anything that can be done either from an 
ath10k driver or supplicant (IWD) perspective. Getting ath10k logs is 
something I'd like to eventually do but its easier said than done. These 
devices are always running and customers generally don't want them 
messed with. I have ssh access so if there is any additional info I can 
get without kernel changes I'm happy to try.

Nov 30 13:33:11 kernel: wlan0: disconnect from AP xx:xx:xx:xx:xx:xx for 
new assoc to yy:yy:yy:yy:yy:yy
Nov 30 13:33:11 kernel: wlan0: associate with yy:yy:yy:yy:yy:yy (try 1/3)
Nov 30 13:33:11 kernel: wlan0: RX ReassocResp from yy:yy:yy:yy:yy:yy 
(capab=0x411 status=0 aid=6)
Nov 30 13:33:11 kernel: wlan0: associated
Nov 30 13:33:11 kernel: ath: EEPROM regdomain: 0x809c
Nov 30 13:33:11 kernel: ath: EEPROM indicates we should expect a country 
code
Nov 30 13:33:11 kernel: ath: doing EEPROM country->regdmn map search
Nov 30 13:33:11 kernel: ath: country maps to regdmn code: 0x52
Nov 30 13:33:11 kernel: ath: Country alpha2 being used: CN
Nov 30 13:33:11 kernel: ath: Regpair used: 0x52
Nov 30 13:33:11 kernel: ath: regdomain 0x809c dynamically updated by 
country element

# This condition is detected by watchdog, and we deauth

Nov 30 13:33:34 kernel: wlan0: deauthenticating from yy:yy:yy:yy:yy:yy 
by local choice (Reason: 3=DEAUTH_LEAVING)

# We then auth to the very same BSS, successfully and have no problems 
(until it happens sometime later)

Nov 30 13:33:36 kernel: wlan0: authenticate with yy:yy:yy:yy:yy:yy
Nov 30 13:33:36 kernel: wlan0: send auth to yy:yy:yy:yy:yy:yy (try 1/3)
Nov 30 13:33:36 kernel: wlan0: authenticated
Nov 30 13:33:36 kernel: wlan0: associate with yy:yy:yy:yy:yy:yy (try 1/3)
Nov 30 13:33:36 kernel: wlan0: RX AssocResp from yy:yy:yy:yy:yy:yy 
(capab=0x411 status=0 aid=6)
Nov 30 13:33:36 kernel: wlan0: associated

Thanks,

James


