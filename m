Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5311D144
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfLLPp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 10:45:57 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:42446 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfLLPp5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 10:45:57 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4AA3313C283;
        Thu, 12 Dec 2019 07:45:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4AA3313C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576165556;
        bh=sh29ygILwNnFAjg7urSWoAczFEdU+QAMuDygsG5xVD0=;
        h=To:From:Subject:Date:From;
        b=iFW2UCD0G0FNmsRUC3sbteVirsuWTza+exIoa7K5B/Awnbs6OE+pu1EWSik/MvVai
         7l6NqlNsyRwCvvV5mbuc/WG0JUA4/YBcW/VDFLOEiLV7ExDzxkeRM27R+EyVHN+PE6
         ysYc5nhhPDf7qPybgFCXQYBYshiGbzTyh1Q8max4=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Ryan Hsu <ryanhsu@qca.qualcomm.com>
From:   Ben Greear <greearb@candelatech.com>
Subject: ath10k regression for setting txpower to zero: ath10k: fix incorrect
 txpower set by P2P_DEVICE interface
Organization: Candela Technologies
Message-ID: <04f905b6-e56d-70b3-abde-e0d922a8cc16@candelatech.com>
Date:   Thu, 12 Dec 2019 07:45:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

While debugging why I could not set txpower to zero, I found that it was this change
below that caused the problem.

Can we make this more specific so that we only ignore 0 txpower on P2P interfaces
and not other types?

Or, maybe the P2P device should have a better initial value for its txpower?


[greearb@ben-dt4 ath10k]$ git show 88407beb1b146
commit 88407beb1b1462f706a1950a355fd086e1c450b6
Author: Ryan Hsu <ryanhsu@qca.qualcomm.com>
Date:   Tue Dec 13 14:55:19 2016 -0800

     ath10k: fix incorrect txpower set by P2P_DEVICE interface

     Ath10k reports the phy capability that supports P2P_DEVICE interface.

     When we use the P2P supported wpa_supplicant to start connection, it'll
     create two interfaces, one is wlan0 (vdev_id=0) and one is P2P_DEVICE
     p2p-dev-wlan0 which is for p2p control channel (vdev_id=1).

             ath10k_pci mac vdev create 0 (add interface) type 2 subtype 0
             ath10k_add_interface: vdev_id: 0, txpower: 0, bss_power: 0
             ...
             ath10k_pci mac vdev create 1 (add interface) type 2 subtype 1
             ath10k_add_interface: vdev_id: 1, txpower: 0, bss_power: 0

     And the txpower in per vif bss_conf will only be set to valid tx power when
     the interface is assigned with channel_ctx.

     But this P2P_DEVICE interface will never be used for any connection, so
     that the uninitialized bss_conf.txpower=0 is assinged to the
     arvif->txpower when interface created.

     Since the txpower configuration is firmware per physical interface.
     So the smallest txpower of all vifs will be the one limit the tx power
     of the physical device, that causing the low txpower issue on other
     active interfaces.

             wlan0: Limiting TX power to 21 (24 - 3) dBm
             ath10k_pci mac vdev_id 0 txpower 21
             ath10k_mac_txpower_recalc: vdev_id: 1, txpower: 0
             ath10k_mac_txpower_recalc: vdev_id: 0, txpower: 21
             ath10k_pci mac txpower 0

     This issue only happens when we use the wpa_supplicant that supports
     P2P or if we use the iw tool to create the control P2P_DEVICE interface.

     Signed-off-by: Ryan Hsu <ryanhsu@qca.qualcomm.com>
     Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

