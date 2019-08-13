Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C163A8B615
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2019 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfHMLBP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Aug 2019 07:01:15 -0400
Received: from mail.w1.fi ([212.71.239.96]:38656 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727097AbfHMLBO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Aug 2019 07:01:14 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Aug 2019 07:01:14 EDT
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id AD37011D2C;
        Tue, 13 Aug 2019 10:55:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RPwjbZX1A_z2; Tue, 13 Aug 2019 10:55:51 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Tue, 13 Aug 2019 13:55:49 +0300
Date:   Tue, 13 Aug 2019 13:55:49 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
Subject: Re: [PATCH v6] mac80211_hwsim: Register support for HE meshpoint
Message-ID: <20190813105549.GA26160@w1.fi>
References: <20190813063657.7544-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813063657.7544-1-sven@narfation.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 13, 2019 at 08:36:57AM +0200, Sven Eckelmann wrote:
> Some features of 802.11ax without central organizing (AP) STA can also be
> used in mesh mode. hwsim can be used to assist initial development of these
> features without having access to HW.

> * rebased on top of 690c4509e980 ("mac80211_hwsim: Fix a typo in the name
>    of function 'mac80211_hswim_he_capab()'")

I'm testing this now with a bit newer snapshot: 6a7ce95d752e
("staging/octeon: Fix build error without CONFIG_NETDEVICES").

> The patch was checked against hostapd's tests version 05822609d105
> ("HE: MCS size is always a minimum of 4 bytes") and the pending tshark < 3.1.0
> workaround [1]. The latter is only affecting test "wpas_mesh_max_peering".
> 
> The other patch  [2] I had in my hostapd queue in earlier tests [3] was not
> actually needed for hwsim+mesh.
> 
> [1] https://patchwork.ozlabs.org/patch/1131273/
> [2] https://patchwork.ozlabs.org/patch/1116968/
> [3] https://lore.kernel.org/r/2152977.f3ncjnVLFo@bentobox

And with the exact same snapshot of hostap.git.

Without [1] applied, this mac80211_hwsim patch to enable HE meshpoint
results in the following test cases failing:

mesh_secure_ocv_mix_legacy
wpas_mesh_open_ht40
wpas_mesh_max_peering
mesh_secure_ocv_mix_ht

[1] fixes wpas_mesh_max_peering

This leaves following three test cases failing ("Test exception:
Couldn't join mesh"):

mesh_secure_ocv_mix_legacy
wpas_mesh_open_ht40
mesh_secure_ocv_mix_ht

Am I missing a patch somewhere that would be needed to make those pass?


More specific reason for the failures:

wpas_mesh_open_ht40:

nl80211: mesh join (ifindex=3)
  * freq=5180
  * he_enabled=1
  * vht_enabled=0
  * ht_enabled=1
  * bandwidth=0
wlan0: mesh join error=-1

mesh_secure_ocv_mix_legacy:

same issues on dev1, but dev0 did complete join with a different set of
parameters:

nl80211: mesh join (ifindex=3)
  * freq=5200
  * he_enabled=1
  * vht_enabled=1
  * ht_enabled=1
  * bandwidth=80
  * channel_width=3
  * center_freq1=5210
  * center_freq2=0
  * Mesh ID (SSID)=wpas-mesh-sec
  * flags=0000000D
  * IEs - hexdump(len=22): 30 14 01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f ac 08 c0 40
nl80211: mesh join request send successfully


(and same for mesh_secure_ocv_mix_ht)

So is that missing of vht_enabled=1 from some configurations the problem
here and if so, would you be able to point me to a hostap.git patch that
addresses this?

-- 
Jouni Malinen                                            PGP id EFC895FA
