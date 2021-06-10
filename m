Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995FF3A2B2E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 14:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFJMPC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 08:15:02 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39711 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJMPB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 08:15:01 -0400
Received: by mail-wr1-f48.google.com with SMTP id l2so2046712wrw.6
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=FXA5tzGHMUkUfav2C5Gvd6izEyEaZw3ZlRjZueJDiv8=;
        b=SnwyVh9fdRyLwfP1XsdThsejo6awxf8rUtyqOQV2CPb/y9phZ0De9lX7sB0lY25Hvn
         sLlBx86gw+Uqp2RbmnszDbZK2CgcypnAKTqzqObHsCLWWowz2f3039qbp0LCrtE+Jasr
         oDm8/z6OQcjQP6DPJJBae+cCFIG6lAcNcxTOn8Ovbg52gszhv2sAczECvj30HLNhY3C0
         RRnxLwegjnahSH6DwgEjF312urMhA+cbw8j4LRJymiMIn4lMZAkduLEq3dGcKcJkFaBh
         6aEyzJR6mNr4gO1HJaxtqMzyPdQo3aSEHsmKHIKngE9D4dRY7C3xFNQ7aNI5VE+zo+Xo
         8NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=FXA5tzGHMUkUfav2C5Gvd6izEyEaZw3ZlRjZueJDiv8=;
        b=OLvka9lpiGhjdkoO9wdwEPugbXQ/c79y7pTm5Zhi8QKpvylbtwDcxZR+UcU862cYT5
         sogEFNdVrKaF29Cu5ElzwbpPZv+w76xZyIG+bCEvd+EZjJzIct3X0W/U+oGnFFuvb+s1
         +rrYTLjeMz8NAgzYKmiZ+jjObGL8mYM0YjenJdmd2YUnEcJuxMIRbrk5exRZ6nYCzFpS
         fkgnj2eydo1oWibR84yNDCiyirjIh8KCPDbQvD+MUehbYHw8YY5TGFOmOAY5/+Ov0GI/
         /H4MDMEuAjh8ypm75IY+kJCjevqaprf7MpqCzva3+lfmZMNFZJx51n3gs1oSfhZqklUR
         +ZSA==
X-Gm-Message-State: AOAM531D6rtbfR9XA5QPbamxk48qBOiA1wwQycFGTWNZcMqBUGmj3o0t
        eoYhiTgPu2nWS5AH3roJh067tszunuPv0w==
X-Google-Smtp-Source: ABdhPJzpWtVjp09tSajFxTgaFtn4nosGxGVjtIRLuBtegAnTeHqfCeYYvYPgMhw4TvCR5Zu20C049g==
X-Received: by 2002:a5d:59a3:: with SMTP id p3mr3018601wrr.284.1623327110227;
        Thu, 10 Jun 2021 05:11:50 -0700 (PDT)
Received: from ptb ([213.27.192.70])
        by smtp.gmail.com with ESMTPSA id q19sm8882872wmc.44.2021.06.10.05.11.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:11:50 -0700 (PDT)
From:   Peter Breuer <peter.t.breuer@gmail.com>
X-Google-Original-From: Peter Breuer <Peter.T.Breuer@gmail.com>
Date:   Thu, 10 Jun 2021 13:11:39 +0100
To:     linux-wireless@vger.kernel.org
Subject: ipw2200 driver no longer sets encrypted WEP in ipw2200 device?
Message-ID: <20210610131139.4fce5404@ptb>
Reply-To: Peter.T.Breuer@gmail.com
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello - has somebody disabled encrypted WEP in ipw2200 firmwares, or
done something global that would have an equivalent effect, perhaps
latent until triggered?

This last week I have not been able to connect over encrypted WEP (128)
through my intel ipw2200 wifi device (venerable ibm tp x40 laptop, cerca
2006, 1.2GHz 686M processor, 1GB ram) via two or three new routers.

The background is that I have finally gotten out of pandemic-locked
london, where the laptop/device and I have together been doing encrypted
WEP  for the past 10 months (and for 10 years before that, all
over the world), to madrid, where ...  no encrypted WEP works to any
router. No - it is not dead.  It works fine in plaintext.  If you tell
me what "open" WEP means (key=0, perhaps?), I'll test that. Yes, I do
have the passwrods rite ;).

What can be going on?  It's not the kernel ..  I shifted from 4.13 to
5.12 to test.  Same in both.  It's not the wpa_supplicant, I think,
because my configuration input from iwconfig seem to behave the same.
The key is taken, the ssid is taken, it finds the AP (sometimes), and
... nothing. I twiddle power ctrl on/off, load the same key elsewhere
in the list, swap between them, set the channel specifically, name
the AP specifically, etc, and ... nothing. Nul points. 0db connection,
i.e. not connected. 

I have turned on module debugging and added more.  The ipw2200 driver
says it is associating ...  and 0.15s later it disassociates, having
received a "CMAS_INIT" (in the module code) from the hardware (?).

 [ 6171.318959] ipw2200: ipw_best_network Network 'TP-Link_0B42 (c0:c9:e3:2f:0b:42)' is a viable match.
 [ 6171.318981] ipw2200: ipw_associate_network Asociation attempt: 'TP-Link_0B42', channel 1, 802.11g [12], long[:long], enc=on (open) key=1.
 [ 6171.319015] 00000000 54 50 2D 4C 69 6E 6B 5F  30 42 34 32               TP-Link_ 0B42    
 [ 6171.319909] ipw2200: ipw_associate_network associating: 'TP-Link_0B42' c0:c9:e3:2f:0b:42
 ... 
 ... (see below)
 ...
 [ 6171.448296] ipw2200: ipw_rx_notification disassociated: 'TP-Link_0B42' c0:c9:e3:2f:0b:42

Why would this happen?  Between those two points there is

  [ 6467.685231] libipw: libipw_rx_mgt received BEACON (128)
  [ 6467.685237] libipw: libipw_rx_mgt Beacon

Good. Then some probes:

  [ 6467.685241] libipw: libipw_process_probe_response 'MiFibra-00CA' (e0:51:63:39:00:cc): 0000 0100-0001 0001
  [ 6467.685250] libipw: libipw_parse_info_param WLAN_EID_SSID: 'MiFibra-00CA' len=12.
  ...
  [ 6467.685311] libipw: libipw_process_probe_response Updating 'MiFibra-00CA' (e0:51:63:39:00:cc) via BEACON.

Then we're back in ipw2200:

  [ 6467.791322] ipw2200: ipw_rx_notification type = 11 (4 bytes)
  [ 6467.791346] ipw2200: ipw_rx_notification AUTH_SEQ_1
  [ 6467.792997] ipw2200: ipw_rx_notification type = 10 (4 bytes)

and boom! :

  [ 6467.793009] ipw2200: ipw_rx_notification disassociated: 'TP-Link_0B42' c0:c9:e3:2f:0b:42

That's all she wrote. 

Does anyone know what is going on?  And how to fix it! 

Is the driver unhappy about something in the configuration data it
receives from the radio link, perhaps?  (the libipw_parse_info...).
There are too many "UNKNOWN"s in it for my comfort.  See below.

Thanks in advance

Peter

----

 [12597.929233] libipw: libipw_process_probe_response 'TP-Link_0B42' (c0:c9:e3:2f:0b:42): 0000 0100-0001 0001
 [12597.929246] libipw: libipw_parse_info_param WLAN_EID_SSID: 'TP-Link_0B42' len=12.
 [12597.929258] libipw: libipw_parse_info_param WLAN_EID_SUPP_RATES: '82 84 8B 96 12 24 48 6C ' (8)
 [12597.929263] libipw: libipw_parse_info_param WLAN_EID_DS_PARAMS: 1
 [12597.929268] libipw: libipw_parse_info_param MFIE_TYPE_ERP_SET: 6
 [12597.929275] libipw: libipw_parse_info_param WLAN_EID_EXT_SUPP_RATES: '0C 18 30 60 ' (4)
 [12597.929280] libipw: libipw_parse_info_param Unsupported info element: UNKNOWN (45)
 [12597.929286] libipw: libipw_parse_info_param Unsupported info element: UNKNOWN (61)
 [12597.929291] libipw: libipw_parse_info_param Unsupported info element: UNKNOWN (127)
 [12597.929296] libipw: libipw_parse_info_param Unsupported info element: UNKNOWN (11)
 [12597.929302] libipw: libipw_parse_info_param WLAN_EID_VENDOR_SPECIFIC: 24 bytes
 [12597.929307] libipw: libipw_parse_info_param WLAN_ EID_VENDOR_SPECIFIC: 7 bytes
 [12597.929312] libipw: libipw_process_probe_response Updating 'TP-Link_0B42' (c0:c9:e3:2f:0b:42) via PROBE RESPONSE.

