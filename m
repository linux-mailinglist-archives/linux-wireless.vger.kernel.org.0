Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894914A6997
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 02:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242997AbiBBBZd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 20:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbiBBBZc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 20:25:32 -0500
X-Greylist: delayed 2591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Feb 2022 17:25:31 PST
Received: from mxout013.mail.hostpoint.ch (mxout013.mail.hostpoint.ch [IPv6:2a00:d70:0:e::313])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70F9C061714
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 17:25:31 -0800 (PST)
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.94.2 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1nF3iz-000LFp-3t; Wed, 02 Feb 2022 01:42:17 +0100
Received: from dynamic-145-014-211-090.glattnet.ch ([145.14.211.90] helo=[192.168.33.151])
        by asmtp014.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1nF3iz-0006nQ-24; Wed, 02 Feb 2022 01:42:17 +0100
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
Message-ID: <2e5161a6-d273-4f76-429a-12dc2a6c7322@reto-schneider.ch>
Date:   Wed, 2 Feb 2022 01:42:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     chris.chiu@canonical.com, linux-wireless@vger.kernel.org,
        Jes.Sorensen@gmail.com
Cc:     pkshih@realtek.com
From:   Reto Schneider <code@reto-schneider.ch>
Subject: rtl8xxxu: Performance findings and questions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

While trying to improve the retransmission percentage on my rtl8188cus 
devices, I found the following:

rtl8xxxu_tx() takes every sk_buf handed by mac80211 and relays it to the 
rtl8188cus right away. This results in 10k+ URBs/s, each ~1500 bytes in 
size on my x86 workstation. On my low-end ARMv5 devices the URBs peak 
out at ~5k/s, with lower throughput and higher retransmission rates 
(~30% in a shielded RF box, ~10% for my workstation).

The Realtek 8192cu bundles the TX frames [1] and sends up to 18kB sized 
URBs, resulting in just 1k URBs/s. The retransmission rates with this 
driver are below 1%.

Questions:
- Any chance this URB "spam" is the root cause for the rtl8188cus being
   too slow to ACK received frames in time, causing retransmissions by
   the AP?
- Is implementing wake_tx_queue() the proper way to improve this?

Kind regards,
Reto

[1] 
https://github.com/husqvarnagroup/rtl8xxxu-8192cu-for-rtl8188cus/blob/d8c03db466bbb3e9c4e8e6cb0a589cfef55db756/core/rtw_xmit.c#L1688
