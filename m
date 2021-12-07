Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFA446C211
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhLGRuD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 12:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhLGRuC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 12:50:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0341CC061746
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 09:46:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id o4so14200704pfp.13
        for <linux-wireless@vger.kernel.org>; Tue, 07 Dec 2021 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=dHnKX7Io4O6O4OJIl/KnNmH+c+Wtvbsgcux+EmegVMg=;
        b=khBh4vk8cF29nCSKE5D+T8A/Q89lu4SYbahHrB1w0U0GfSlbGqtJQBTtTKVmJr4OYo
         ojzuSBV/beKMX6HgO1i8kiZprQNzPPqV73RgzQIiTJOWZPFJqLqhiw7gPy5eRfaeOJAj
         NjXOfgywbMG09xfwzPeI70EBDYhqt6uNV/1HfIrQuh8UlKAYbFnb/TmNQkY6TmMHSngR
         9oM/ElUqHJg2v0M/m3/xA6Tw8xFavGY2or7z2iQPm2rsypi2+6c+vHXh7XvW6P2apuEU
         FQnB8EDahA6cmWTiITOdKrIVOWLOD6nu6Zu+zsVgTLz4LbJHxKzR7aoAkLf81L9WPWkl
         LxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=dHnKX7Io4O6O4OJIl/KnNmH+c+Wtvbsgcux+EmegVMg=;
        b=65O4XfO1SMzdDlp0s5tqgxoV88wuSCFhR/quWbK/VF5RpgInil3xf4L0KHPC07kVwZ
         PJLux1xaQepcYH4cecDfNjBWKvw1EvSyemfhDSDzHYOd6xC/rLW1gnFGWGlsvKEUdSrQ
         121XShI11asNrKLQ2HWTtxW5K23lz5ReRZkbRSOhQA8volukvmuSXtSBBIKDXjhUYkVx
         ZSv+k99QjQ1Kwq4v5/A97clYb8vHvzmVQDBLk2sRHCbbiX/dwcvYbiIDINNRsG980JFo
         EhPuXthYXjvO67DifaTfAXuZHGkXsEEWwrp8PSnjMicC9amtHt8MrkvPmrrykqDcuBfm
         g92A==
X-Gm-Message-State: AOAM53344bCGa5OqbH7Elojfj4wela0uyzUZE5bLDHx05LL5HxSTnRrr
        HigvRxpjil7R++yM1O7s+uRPcPsR4JQJSQ==
X-Google-Smtp-Source: ABdhPJwTwxxrXLeWJCsFHjj1Fj/Ri3iWKDO/yyYmrSmHq+UEzA9YMbbQKgmDFGwb38+3K1blr1WQSw==
X-Received: by 2002:a05:6a00:16c7:b0:4a4:edfe:4625 with SMTP id l7-20020a056a0016c700b004a4edfe4625mr453868pfc.58.1638899191155;
        Tue, 07 Dec 2021 09:46:31 -0800 (PST)
Received: from [192.168.254.58] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id lw1sm3544962pjb.38.2021.12.07.09.46.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:46:30 -0800 (PST)
Message-ID: <7843b8e41120f9c6af8e7c51ca172999dc248df3.camel@gmail.com>
Subject: BUG: missing ROC/Cancel ROC events (iwlwifi)
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 07 Dec 2021 09:46:30 -0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have noticed a possible bug in iwlwifi related to
CMD_[CANCEL_]REMAIN_ON_CHANNEL. I have connected to an AP, then in a
loop:

- Call CMD_REMAIN_ON_CHANNEL
- Wait for NL80211 ACK
- Wait for the ROC event
- Send a frame
- Wait for CANCEL_ROC event
- Repeat

Note sometimes the driver will deny the ROC request an immediately send
Cancel ROC, which is fine.

Specifically with about a 200ms duration I notice that eventually no
ROC event comes in. NL80211 ACKs my request which has a cookie but no
events follow. Not sure what exactly is going on but it appears to be
related to iwlwifi specifically:


< Request: Remain on Channel (0x37) len 28 [ack]                      
1638898585.172028
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2437 (0x00000985)
    Duration: 200 (0x000000c8)
> Result: Remain on Channel (0x37) len 12                             
1638898585.179108
    Cookie: 7075 (0x0000000000001ba3)
> Response: Remain on Channel (0x37) len 4 [0x100]                    
1638898585.179117
    Status: Success (0)
> Event: Cancel Remain on Channel (0x38) len 56                       
1638898585.478102
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2437 (0x00000985)
    Wiphy Channel Type: 0 (0x00000000)
    Cookie: 7075 (0x0000000000001ba3)
< Request: Remain on Channel (0x37) len 28 [ack]                      
1638898585.478214
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2437 (0x00000985)
    Duration: 200 (0x000000c8)
> Result: Remain on Channel (0x37) len 12                             
1638898585.489078
    Cookie: 7076 (0x0000000000001ba4)
> Response: Remain on Channel (0x37) len 4 [0x100]                    
1638898585.489088
    Status: Success (0)
> Event: Remain on Channel (0x37) len 64                              
1638898585.672127
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2437 (0x00000985)
    Wiphy Channel Type: 0 (0x00000000)
    Cookie: 7076 (0x0000000000001ba4)
    Duration: 200 (0x000000c8)
< Request: Frame (0x3b) len 96 [ack]                                  
1638898585.672333
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2437 (0x00000985)
    Offchannel TX OK: true
    Frame: len 68
        Frame Type: 0x00d0
            Type: Management (0)
            Subtype: Action
            Action Category: Public (4)
            Public Action: Vendor-specific (9)
        d0 00 00 00 ff ff ff ff ff ff 7c 7a 91 2b d8 0b 
..........|z.+..
        ff ff ff ff ff ff 00 00 04 09 50 6f 9a 1a 01 0d 
..........Po....
        02 10 20 00 6a 1d 82 fa c1 f2 5f 48 3e 13 1b 99  ..
.j....._H>...
        a3 92 7c 93 20 90 0a 06 34 78 fe 54 04 57 42 01  ..|.
...4x.T.WB.
        7d b2 7a 89                                      }.z.         
> Result: Frame (0x3b) len 12                                         
1638898585.672377
    Cookie: 7077 (0x0000000000001ba5)
> Response: Frame (0x3b) len 4 [0x100]                                
1638898585.672380
    Status: Success (0)
> Event: Frame TX Status (0x3c) len 116                               
1638898585.673263
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Frame: len 68
        Frame Type: 0x00d0
            Type: Management (0)
            Subtype: Action
            Action Category: Public (4)
            Public Action: Vendor-specific (9)
        d0 00 00 00 ff ff ff ff ff ff 7c 7a 91 2b d8 0b 
..........|z.+..
        ff ff ff ff ff ff 00 00 04 09 50 6f 9a 1a 01 0d 
..........Po....
        02 10 20 00 6a 1d 82 fa c1 f2 5f 48 3e 13 1b 99  ..
.j....._H>...
        a3 92 7c 93 20 90 0a 06 34 78 fe 54 04 57 42 01  ..|.
...4x.T.WB.
        7d b2 7a 89                                      }.z.         
    Cookie: 7077 (0x0000000000001ba5)
    ACK: true
> Event: Cancel Remain on Channel (0x38) len 56                       
1638898585.867523
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2437 (0x00000985)
    Wiphy Channel Type: 0 (0x00000000)
    Cookie: 7076 (0x0000000000001ba4)
> Event: Frame Wait Cancel (0x43) len 56                              
1638898585.867539
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2437 (0x00000985)
    Wiphy Channel Type: 0 (0x00000000)
    Cookie: 7077 (0x0000000000001ba5)
< Request: Remain on Channel (0x37) len 28 [ack]                      
1638898585.867664
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2437 (0x00000985)
    Duration: 200 (0x000000c8)
> Result: Remain on Channel (0x37) len 12                             
1638898585.881073
    Cookie: 7078 (0x0000000000001ba6)
> Response: Remain on Channel (0x37) len 4 [0x100]                    
1638898585.881085
    Status: Success (0)
> Event: Cancel Remain on Channel (0x38) len 56                       
1638898585.975207
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2437 (0x00000985)
    Wiphy Channel Type: 0 (0x00000000)
    Cookie: 7078 (0x0000000000001ba6)
< Request: Remain on Channel (0x37) len 28 [ack]                      
1638898585.975359
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2437 (0x00000985)
    Duration: 200 (0x000000c8)
> Result: Remain on Channel (0x37) len 12                             
1638898585.987983
    Cookie: 7079 (0x0000000000001ba7)
> Response: Remain on Channel (0x37) len 4 [0x100]                    
1638898585.988007
    Status: Success (0)


... And nothing after this point. My code is waiting for the ROC/Cancel
event but it never comes.

I have tested mt76x2u, several rtl* cards, and rt2800usb and not seen
this behavior. It only happens on my iwlwifi card and only while
connected.

Thanks,
James


