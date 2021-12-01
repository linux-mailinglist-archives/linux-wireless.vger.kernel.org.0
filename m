Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C6464AE7
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348332AbhLAJxi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 04:53:38 -0500
Received: from simonwunderlich.de ([23.88.38.48]:39242 "EHLO
        simonwunderlich.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242341AbhLAJxi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 04:53:38 -0500
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2021 04:53:38 EST
Received: from [IPv6:2003:c5:973f:dc98:2d8:61ff:feb7:ca5c] (p200300c5973fdC9802d861FFfeb7CA5c.dip0.t-ipconnect.de [IPv6:2003:c5:973f:dc98:2d8:61ff:feb7:ca5c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by simonwunderlich.de (Postfix) with ESMTPSA id A79D2FA1B7;
        Wed,  1 Dec 2021 10:41:28 +0100 (CET)
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, linux-mediatek <linux-mediatek@lists.infradead.org>
From:   Jan Fuchs <jf@simonwunderlich.de>
Subject: mt76: MT7921K monitor mode not working
Message-ID: <7e156597-a206-b236-e4c8-d476614de7ef@simonwunderlich.de>
Date:   Wed, 1 Dec 2021 10:41:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

we are not able to obtain any packets when packet capturing with the 
Mediatek MT7921K in monitor mode on 2.4, 5 and 6 GHz.
tcpdump will show you 0 recorded packets. When doing a "iw dev wls1 
scan" on a parallel running managed interface on the same phy, the 
packet capture will contain beacons and probe responses from the scan 
though.
Can anyone confirm that?

mt76 (https://github.com/openwrt/mt76/commits/master): commit 
6fad970893dd26ef6e6c8344b958344254f6362a (HEAD -> master, origin/master, 
origin/HEAD)
Kernel: 5.16.0-rc2-next-20211124+
WM Firmware Version: ____010000, Build Time: 20211014150922

Steps to reproduce:
sudo iw dev wls1 del
sudo iw phy phy0 interface add mon0 type monitor
sudo ip link set dev mon0 up
sudo iw dev mon0 set freq 6115
sudo tcpdump -i mon0 -w 6g-capture.pcap

Kinds regards, Jan

