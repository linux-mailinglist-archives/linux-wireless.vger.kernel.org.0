Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BDB24BA7A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgHTMJo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 08:09:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43386 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgHTMIx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 08:08:53 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k8jNC-00056q-K7
        for linux-wireless@vger.kernel.org; Thu, 20 Aug 2020 12:08:50 +0000
Received: by mail-pl1-f197.google.com with SMTP id g17so1438068plg.10
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 05:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=mjchfL9evM/xQH2T8tucHnWJ3UafXQUAcWo9OBT0Lw0=;
        b=c3iC5EbfbQxZqytTmDVGAs5IBwyuKGNeMRzbNYsv+868lXcr9Fkb/qLKpfWK/EwU+N
         iu9Wi50vuTb7e9bKEhiscayLmgegCNIGnwwc8lR50c9E+gDzfrDOCVXlUNzaYd1rWOpr
         sbqliiczOZyJVR56Kr2Dq4fl9QP1BQZWh+JPJbGeA+Wdy88PsG7MAY8KlSzsEmzHTMsZ
         MNCfJRHy4Vn4KP87Fu1rZYuMJdzE8MeKw04SKuJjka/KMwURGeixuNleTz2AxhnV1KBN
         xqUeSSJEVguH8MV5d89P/a9xq5AlDntbLKTy4Lt1DZA3cDZbejNhhzv5gQVRvr40/opV
         pVVg==
X-Gm-Message-State: AOAM531FJYjycI0GMeXr1lhoXaahWdcm+92AmXeykZpZkO0PmHfmeVzz
        W7RR+2o2CUKFjVgiicXWD3bDuykJi4KZBr3OmFDki1v227j6rMjgPg6uhNEq9k+618Xi1TF5zMp
        riQ2SJRKPilBvPopuC3wDCHgEhzfxXXdHLT/+L2ypO7Hm
X-Received: by 2002:a17:902:b20d:: with SMTP id t13mr2354386plr.312.1597925329005;
        Thu, 20 Aug 2020 05:08:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywPOb3waDUAaPcj+Z4fgRTQzuufrn+J7f/fR6Ld13anut5T3aSsqitdJHEOlNna0cpc1aN4Q==
X-Received: by 2002:a17:902:b20d:: with SMTP id t13mr2354369plr.312.1597925328653;
        Thu, 20 Aug 2020 05:08:48 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id e9sm2793343pfh.151.2020.08.20.05.08.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 05:08:48 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: rtw88 8723de WiFi speed drops when BT is connected
Message-Id: <E4A0310D-6C59-49D0-B618-8B1635BC3F81@canonical.com>
Date:   Thu, 20 Aug 2020 20:08:45 +0800
Cc:     Anthony Wong <anthony.wong@canonical.com>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>
To:     Tony Chuang <yhchuang@realtek.com>, pkshih@realtek.com
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WiFi becomes super slow after a while, if BT is connected.
Output from `iperf3 -R`:
[ 4] 334.00-335.00 sec 112 MBytes 941 Mbits/sec
[ 4] 335.00-336.00 sec 72.5 MBytes 608 Mbits/sec
[ 4] 336.00-337.00 sec 0.00 Bytes 0.00 bits/sec
[ 4] 337.00-338.00 sec 3.36 MBytes 28.2 Mbits/sec
[ 4] 338.00-339.00 sec 2.98 MBytes 25.0 Mbits/sec

Still reproducible on latest wireless-drivers-next, top commit for rtw88 is 7b080e085943 ("rtw88: 8821c: coex: add functions and parameters").

Firmwares are also latest:
u@u:/lib/firmware/rtw88$ md5sum *8723d*
ea7a621393871e579bcca1b9539e9639 rtw8723d_fw.bin

u@u:/lib/firmware/rtl_bt$ md5sum *8723d*
6551d1f5c5a9c4ce7ab755d58576e0b0 rtl8723d_config.bin
e66f08b49eb0c8b79b175298b1be328a rtl8723d_fw.bin

Thanks!

Kai-Heng
