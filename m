Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D41FADDF
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgFPK0O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 06:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPKZe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 06:25:34 -0400
X-Greylist: delayed 513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Jun 2020 03:25:34 PDT
Received: from simonwunderlich.de (packetmixer.de [IPv6:2001:4d88:2000:24::c0de])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1817CC08C5C2
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2020 03:25:33 -0700 (PDT)
Received: from [IPv6:2003:c5:9716:5300:7e76:35ff:fe14:e6d7] (p200300c5971653007e7635fffe14e6d7.dip0.t-ipconnect.de [IPv6:2003:c5:9716:5300:7e76:35ff:fe14:e6d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by simonwunderlich.de (Postfix) with ESMTPSA id 95F6762055;
        Tue, 16 Jun 2020 12:16:51 +0200 (CEST)
Subject: Re: [PATCH] mac80211: mesh: add mesh_param "mesh_nolearn" to skip
 path discovery
To:     =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
References: <20200616095358.20143-1-linus.luessing@c0d3.blue>
From:   =?UTF-8?Q?Linus_L=c3=bcssing?= <ll@simonwunderlich.de>
Message-ID: <cbe4863e-44f3-c0e4-a4f3-1b0a69f7a386@simonwunderlich.de>
Date:   Tue, 16 Jun 2020 12:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616095358.20143-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> The new mesh_nolearn parameter allows to skip the PREQ/PREP exchange in
> this scenario, leading to a reduced delay, reduced packet buffering and
> simplifies HWMP in general.

Also another small remark regarding the simplification:

Next to the timer re-arming bug / crash [0] we also stumbled over 
another bug when using encryption on the 802.11s interfaces which we 
could quite solve yet:

We are seeing packet loss every four seconds due to a "DECRYPT CRC ERR". 
We could narrow this down to the PREQ. This somehow makes the receiver 
unable to decrypt the packet in hardware and also the fallback to 
software decryption fails as the hardware has messed up the encrypted 
data (looks completely different than what we saw in the air with a 
third device in monitor mode, unencrypted headers looked ok though). 
Furthermore, the hardware still sends ACKs for this frame... so no 
retries on the 802.11 layer, leading to ugly packet loss for one UDP 
packet every four seconds.

The hardware we were having this issue with is a Lima board with a QCA4531.

Setting ath9k nohwcrypt=1 on the sender side helps. And avoiding PREQs 
with this patch also helped in our batman-adv setup which had 
mesh_fwding disabled already anyway.

Regards, Linus


PS/Disclaimer: This bug was observed on an old LEDE version.


[0]: https://patchwork.kernel.org/patch/11566011/
