Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF33482653
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jan 2022 03:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiAACXd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Dec 2021 21:23:33 -0500
Received: from titan58.planetwebservers.net ([51.79.1.102]:54019 "EHLO
        titan58.planetwebservers.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231938AbiAACXc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Dec 2021 21:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=719pbIjP2fnsARJCr/TTFgLmRia4I6Lq3qNliheHZvQ=; b=IJvNbyWCFXvahzAuXNHe4XtFfQ
        NYb/L3ygV1lLAdD2EB2DSFAP+/RB9Qyn5KrtWjv5VSqd9PfmE0QSdOVB9SRR/LlyJfTkP9GJ+4vT+
        FfMdqDOfozKleKHYmTaX19h/aF8LTGGP5PzeF89iUwPwxAonRPHUABtw+BYMnpbzL1HrwDSIxLCPt
        ybzez8JX2NCqo0IikrDbKc6F64hkjVQ7QAxIONzKG6Z4LNIwOD52g0TeeKB/UXg+IRcwz9jYWTz7c
        r2qTyi0/pUkalzP+V1JexqDbSC+Az9He+vb+qBUlCvU6ULftA+BGqjzcQ3GiEL5JkRI3Z/fo2e3LQ
        y9T+OYXA==;
Received: from [37.19.213.90] (port=41066 helo=[10.5.0.2])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1n3U3S-0005q0-12
        for linux-wireless@vger.kernel.org; Sat, 01 Jan 2022 13:23:31 +1100
Message-ID: <ada800c1-8404-2dd4-0d1e-a72a4643b261@lockie.ca>
Date:   Fri, 31 Dec 2021 21:23:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
From:   James <bjlockie@lockie.ca>
Subject: Intel Ice Lake-LP PCH CNVi WiFi (rev 30) unknown rate information
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is the unknown rate information error.
And it is VERY slow to negotiate a higher tx bitrate.
It always starts at 245.0 MBit/s then eventually gets to 1200.9 MBit/s.

$ lspci
00:14.3 Network controller: Intel Corporation Ice Lake-LP PCH CNVi WiFi 
(rev 30)

$ iwlist wlp0s20f3 bitrate
wlp0s20f3  unknown bit-rate information.
           Current Bit Rate:245 Mb/s

$ ifconfig
wlp0s20f3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 192.168.68.73  netmask 255.255.252.0  broadcast 192.168.71.255
         inet6 fe80::242d:b7ca:92cc:79d0  prefixlen 64  scopeid 0x20<link>
         ether 84:1b:77:02:d9:6a  txqueuelen 1000  (Ethernet)
         RX packets 298984  bytes 281963663 (281.9 MB)
         RX errors 0  dropped 58  overruns 0  frame 0
         TX packets 55874  bytes 6700470 (6.7 MB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

$ uname -a
Linux james-aspirea51555 5.13.0-22-generic #22-Ubuntu SMP Fri Nov 5 
13:21:36 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

$ iw dev wlp0s20f3 link
Connected to xxx (on wlp0s20f3)
         SSID: xxx
         freq: 5240
         RX: 32287683 bytes (32648 packets)
         TX: 586902 bytes (4676 packets)
         signal: -39 dBm
         rx bitrate: 1200.9 MBit/s 80MHz HE-MCS 11 HE-NSS 2 HE-GI 0 HE-DCM 0
         tx bitrate: 245.0 MBit/s 80MHz HE-MCS 3 HE-NSS 2 HE-GI 2 HE-DCM 0

         bss flags:      short-slot-time
         dtim period:    1
         beacon int:     100


