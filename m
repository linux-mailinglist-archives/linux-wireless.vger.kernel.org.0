Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20455164BCB
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2020 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSRVh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Feb 2020 12:21:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40746 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBSRVg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Feb 2020 12:21:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id b185so382828pfb.7
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2020 09:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KYEZ4MbknLv5iTf+an/G8/X9viBPaQav3+JngX0l2Kc=;
        b=ZL0wo2E7pIkAE0fTURvHCqEdoclpKhBaSK6d4uhBVqA2CMWxoW8Q7rTpikwKKOIo0v
         VAYBGu7lQOARumRulFn4jJWz5EWUfItSAgjDPjzeIkt9k/QPNIl8uM2F7NgjZc+JxKAB
         aHoucoJ1ryXUOSmiviapJjff87ficfEWXC+wYQLT5KS3fPJEBA89GAUlMDfDL1t4szqx
         4vADZ7XhfFE6R/HOX6vpz6gM6RzR1JfZRY0r2lzJ9e35J3gFZPRxoAnQfOuRs5lbrxKH
         s/22W0A4Y/jF5ppXkpzk13gn0HWQufUAelgoUR3m8v9rcFgV9wqaEjQ+EtSdeSK0+4Et
         pMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KYEZ4MbknLv5iTf+an/G8/X9viBPaQav3+JngX0l2Kc=;
        b=oTNs5Gmq62qw8SpmQEQtX9XyYU7fiDlgnVgeMewrKbVt1yXEJ1yotnn5nMncU9z0Q2
         HQSEgQhzGrWhpqx2k1Tewoa6Mttuj3HojDME+9LCtpvTARQ/toX9WpmaoTf6oIf+QVTh
         A5lb96H6cmJR9z3EoIlx4aOBtE4/SKvF5d2D4yyzLy3Ry8Miu81jSUq7YuIRDvkoyLQK
         aEKsGDt7xpx3Dh7dt3sj2mDycxG6c8/vsgxRrvln4rnhWExONItxmq197vjlY7dVCXRc
         h8ndZndiZ53xp0awYx8K0w+Yh76cfm4KfVn3vr2RKmFpgt9w1fQRaVl7WbK1j5om+Ies
         ED0Q==
X-Gm-Message-State: APjAAAVdYZ9zLC0rd0TzIPabxNbLKzTMt4sfoRfIfz8aGYlTTO9KY2rz
        UEQWS2cUSjfjZQtTYmUWG4BfBpL7
X-Google-Smtp-Source: APXvYqx9yh41kb4OCQ6Uate6nX65MZnTYDeiyMoR9FoAjOJFVdUA79wkeIHEIqUykToCv810fT2EJA==
X-Received: by 2002:a65:621a:: with SMTP id d26mr28099927pgv.151.1582132895531;
        Wed, 19 Feb 2020 09:21:35 -0800 (PST)
Received: from mua.localhost (99-7-172-215.lightspeed.snmtca.sbcglobal.net. [99.7.172.215])
        by smtp.gmail.com with ESMTPSA id x4sm185714pff.143.2020.02.19.09.21.34
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 09:21:34 -0800 (PST)
Reply-To: pgnet.dev@gmail.com
Subject: Re: unable to explicitly set wifi regulatory domain = US; defaults to
 =CN ?
From:   PGNet Dev <pgnet.dev@gmail.com>
To:     linux-wireless@vger.kernel.org
References: <584c4f03-a904-fdf1-5f42-5e3c1c0bde71@gmail.com>
Message-ID: <efad195f-fd67-d645-600a-a9ec936f5058@gmail.com>
Date:   Wed, 19 Feb 2020 09:21:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <584c4f03-a904-fdf1-5f42-5e3c1c0bde71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anyone with some guidance on this?
Or, is there a more appropriate forum for this question?


On 2/9/20 10:42 AM, PGNet Dev wrote:
> on
> 
> 	uname -rm
> 		5.5.2-25.g994cf1f-default x86_64
> 
> i'm trying to set my wifi's regulatory domain.
> 
> currently, with
> 
> 	cat /etc/modprobe.d/wifi.conf
> 		options iwlwifi lar_disable=1
> 		softdep ath pre: cfg80211
> 		options cfg80211 ieee80211_regdom=US
> 
> 	cat /etc/modules-load.d/wifi.conf
> 		iwlwifi
> 		ath
> 		cfg80211
> 
> 	lsmod | egrep "ath|cfg"
> 		ath9k_htc              81920  0
> 		ath9k_common           20480  1 ath9k_htc
> 		ath9k_hw              499712  2 ath9k_htc,ath9k_common
> 		mac80211              991232  4 ath9k_htc,rt2x00lib,rt2x00usb,rt2800lib
> 		usbcore               315392  6 ath9k_htc,xhci_hcd,rt2800usb,usbhid,xhci_pci,rt2x00usb
> 		ath                    36864  3 ath9k_htc,ath9k_common,ath9k_hw
> 		cfg80211              835584  6 ath9k_htc,ath9k_common,rt2x00lib,ath,iwlwifi,mac80211
> 		rfkill                 28672  6 rfkill_gpio,cfg80211
> 
> it's
> 
> 	iw reg get
> 		global
> 		country 00: DFS-UNSET
> 		        (2402 - 2472 @ 40), (6, 20), (N/A)
> 		        (2457 - 2482 @ 20), (6, 20), (N/A), AUTO-BW, PASSIVE-SCAN
> 		        (2474 - 2494 @ 20), (6, 20), (N/A), NO-OFDM, PASSIVE-SCAN
> 		        (5170 - 5250 @ 80), (6, 20), (N/A), AUTO-BW, PASSIVE-SCAN
> 		        (5250 - 5330 @ 80), (6, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
> 		        (5490 - 5730 @ 160), (6, 20), (0 ms), DFS, PASSIVE-SCAN
> 		        (5735 - 5835 @ 80), (6, 20), (N/A), PASSIVE-SCAN
> 		        (57240 - 63720 @ 2160), (N/A, 0), (N/A)
> 
> i want to set it explicitly to = US
> 
> crda's apparently no longer the method,
> 
> 	git clone git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/crda.git
> 	cat crda/README
> 		...
> 		CRDA is no longer needed as of kernel v4.15 since commit 007f6c5e6eb45
> 		("cfg80211: support loading regulatory database as firmware file") added
> 		support to use the kernel's firmware request API which looks for the
> 		firmware on /lib/firmware. Because of this CRDA is legacy software for
> 		older kernels. It will continue to be maintained.
> 		...
> 
> attempt to SET with `iw` fails
> 
> 	iw reg set --debug US
> 		not a valid ISO/IEC 3166-1 alpha2
> 		Special non-alpha2 usable entries:
> 		        00      World Regulatory domain
> 
> boot logs show,
> 
> 	dmesg | egrep "cfg|ath|wlp|wlan|iwl"
> 		[    6.817013] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> 		[    6.817976] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> 		[    6.818043] cfg80211: failed to load regulatory.db
> 		[    6.835635] iwlwifi: unknown parameter 'lar_disable' ignored
> 		[    6.835967] systemd-modules-load[221]: Inserted module 'iwlwifi'
> 		[    6.838745] systemd-modules-load[221]: Inserted module 'ath'
> 		[   15.210473] usb 1-1.2: ath9k_htc: Firmware ath9k_htc/htc_9271-1.4.0.fw requested
> 		[   15.210661] usbcore: registered new interface driver ath9k_htc
> 		[   15.401056] rt2800usb 1-1.1:1.0 wlp0s20u1u1: renamed from wlan0
> 		[   15.705527] usb 1-1.2: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
> 		[   15.957604] ath9k_htc 1-1.2:1.0: ath9k_htc: HTC initialized with 33 credits
> 		[   16.240624] ath9k_htc 1-1.2:1.0: ath9k_htc: FW Version: 1.4
> 		[   16.240630] ath9k_htc 1-1.2:1.0: FW RMW support: On
> 		[   16.240634] ath: EEPROM regdomain: 0x809c
> 		[   16.240635] ath: EEPROM indicates we should expect a country code
> 		[   16.240637] ath: doing EEPROM country->regdmn map search
> 		[   16.240640] ath: country maps to regdmn code: 0x52
> 		[   16.240642] ath: Country alpha2 being used: CN
> 		[   16.240644] ath: Regpair used: 0x52
> 		[   16.253506] ath9k_htc 1-1.2:1.0 wlp0s20u1u2: renamed from wlan0
> 		[  177.266555] ath: phy1: Short RX data len, dropping (dlen: 4)
> 		[  403.015547] ath: phy1: Short RX data len, dropping (dlen: 9)
> 		[  456.510042] ath: phy1: Short RX data len, dropping (dlen: 4)
> 		[  466.037072] ath: phy1: Short RX data len, dropping (dlen: 4)
> 		[  764.111764] ath: phy1: Short RX data len, dropping (dlen: 4)
> 		[  916.805596] ath: phy1: Short RX data len, dropping (dlen: 4)
> 		[  944.127381] ath: phy1: Short RX data len, dropping (dlen: 4)
> 
> 
> note,
> 
> there's discussion here
> 
> 	https://bugzilla.kernel.org/show_bug.cgi?id=205695
> 
> about rm'ing lar_disable options 'vs' being unable to set the reg dom,
> 
> 	https://unix.stackexchange.com/questions/286258/intel-wireless-7265d-iw-shows-wrong-regulatory-information
> 
> not clear what to _do_ abt that, here.
> 
> what's the correct/current config+method for setting the wifi intfc's reg domain?
> 
> 

