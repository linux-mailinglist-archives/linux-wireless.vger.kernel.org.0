Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AA41E4D64
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 20:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgE0Suq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 14:50:46 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:50500 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgE0Sup (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 14:50:45 -0400
Received: from [192.168.254.4] (unknown [50.34.197.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A803C13C2B1;
        Wed, 27 May 2020 11:30:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A803C13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1590604225;
        bh=jhOta/TXDxhvP9ffhDeszqZrtNZqXV9Z8+e8cpBjkWQ=;
        h=To:From:Subject:Date:From;
        b=b9nNy4UdeLXPhFXN5zSKmRiLltyyXfNr+RLzUxFFb/4qSZ8WLHs6/tFzzEBPVuOdx
         8OHKCY/gvn4fFM/GWjQp8w7s67uXH79cu5YM06rOOBoIyCOp/u0QgS2soXxHi+M0PF
         wenLsXkexZWipT8fp9gJdRWv2XmHBrQ7I9OmR8Aw=
To:     ath10k <ath10k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Un-recoverable ath10k 4019 NIC lockup.
Message-ID: <75f092e3-b667-341a-e810-61edd8f089ac@candelatech.com>
Date:   Wed, 27 May 2020 11:30:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While doing a torture test on OpenWrt using ath10k-ct drivers/firmware, the 5Ghz AP fell off the
air.  After debugging, I found this in the console logs.

I am guessing that the only way to recover in this case would be to reboot, but in case someone else
has ideas on additional ways to kick the 4019 chip to have it start responding again, please let me know.


Thu May 14 19:28:22 2020 daemon.info hostapd: wlan0: STA 04:f0:21:9a:16:25 IEEE 802.11: authenticated
Thu May 14 19:28:22 2020 daemon.info hostapd: wlan0: STA 04:f0:21:9a:16:25 IEEE 802.11: associated (aid 6)
Thu May 14 19:28:22 2020 daemon.notice hostapd: wlan0: AP-STA-CONNECTED 04:f0:21:9a:16:25
[ 2539.120581] ath10k_ahb a800000.wifi: bss channel survey timed out
Thu May 14 19:29:08 2020 kern.warn kernel: [ 2539.120581] ath10k_ahb a800000.wifi: bss channel survey timed out
[ 2542.160640] ath10k_ahb a800000.wifi: wmi command 36892 timeout, restarting hardware
[ 2542.160700] ath10k_ahb a800000.wifi: failed to set dtim period for vdev 0: -11
Thu May 14 19:29:11 2020 kern.warn kernel: [ 2542.160640] ath10k_ahb a800000.wifi: wmi command 36892 timeout, restarting hardware
Thu May 14 19:29:11 2020 kern.warn kernel: [ 2542.160700] ath10k_ahb a800000.wifi: failed to set dtim period for vdev 0: -11
[ 2545.200593] ath10k_ahb a800000.wifi: wmi command 40859 timeout, restarting hardware
[ 2545.200638] ath10k_ahb a800000.wifi: failed to send wmi nop: -11
[ 2545.209636] ath10k_ahb a800000.wifi: failed to recalculate rts/cts prot for vdev 0: -108
[ 2545.213377] ath10k_ahb a800000.wifi: failed to set cts protection for vdev 0: -108
[ 2545.221549] ath10k_ahb a800000.wifi: failed to set preamble for vdev 0: -108
[ 2545.228789] ath10k_ahb a800000.wifi: failed to set mgmt tx rate -108
[ 2545.236060] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer c99bfe00 vdev: 0 addr: 04:f0:21:01:0f:a2
[ 2545.242361] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer c99bea00 vdev: 0 addr: 04:f0:21:c9:8b:a2
[ 2545.253217] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer c99be800 vdev: 0 addr: 04:ed:33:dc:1e:30
[ 2545.264153] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer c99bf000 vdev: 0 addr: 04:f0:21:8d:4a:a2
[ 2545.275072] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer c8002800 vdev: 0 addr: 5c:80:b6:83:13:03
[ 2545.286016] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce738000 vdev: 0 addr: 04:f0:21:7d:fb:a2
[ 2545.296960] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce1ec600 vdev: 0 addr: 24:f5:a2:08:21:6d
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.200593] ath10k_ahb a800000.wifi: wmi command 40859 timeout, restarting hardware
hu May 14 19:29:14 2020 kern.warn kernel: [ 2545.200638] ath10k_ahb a800000.wifi: failed to send wmi nop: -11
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.209636] ath10k_ahb a800000.wifi: failed to recalculate rts/cts prot for vdev 0:[ 2545.3204
25] ath10k_ahb a800000.wifi: failed to read hi_board_data address: -16

Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.213377] ath10k_ahb a800000.wifi: failed to set cts protection for vdev 0: -108
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.221549] ath10k_ahb a800000.wifi: failed to set preamble for vdev 0: -108
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.228789] ath10k_ahb a800000.wifi: failed to set mgmt tx rate -108
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.236060] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer c99bfe00 vdev:
  0 addr: 04:f0:21:01:0f:a2
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.242361] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer c99bea00 vdev:
  0 addr: 04:f0:21:c9:8b:a2
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.253217] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer c99be800 vdev:
  0 addr: 04:ed:33:dc:1e:30
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.264153] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer c99bf000 vdev:
  0 addr: 04:f0:21:8d:4a:a2
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.275072] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer c8002800 vdev:
  0 addr: 5c:80:b6:83:13:03
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.286016] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce738000 vdev:
  0 addr: 04:f0:21:7d:fb:a2
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.296960] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce1ec600 vdev:
  0 addr: 24:f5:a2:08:21:6d
Thu May 14 19:29:14 2020 kern.warn kernel: [ 2545.320425] ath10k_ahb a800000.wifi: failed to read hi_board_data address: -16
Thu May 14 19:29:14 2020 kern.info kernel: [ 2545.359831] ieee80211 phy2: Hardware restart was requested[ 2545.370652] ath10k_ahb a800000.wi
fi: failed to halt axi bus: 0

Thu May 14 19:29:14 2020 kern.err kernel: [ 2545.370652] ath10k_ahb a800000.wifi: failed to halt axi bus: 0
[ 2548.661207] ath10k_ahb a800000.wifi: failed to receive initialized event from target: 80000000
[ 2548.671340] ath10k_ahb a800000.wifi: failed to halt axi bus: 0
Thu May 14 19:29:17 2020 kern.err kernel: [ 2548.661207] ath10k_ahb a800000.wifi: failed to receive initialized event from target: 80000000
Thu May 14 19:29:17 2020 kern.err kernel: [ 2548.671340] ath10k_ahb a800000.wifi: failed to halt axi bus: 0
[ 2548.840677] ath10k_ahb a800000.wifi: failed to reset chip: -110
[ 2548.840716] ath10k_ahb a800000.wifi: Could not init hif: -110
[ 2548.845695] ------------[ cut here ]------------
[ 2548.851832] WARNING: CPU: 3 PID: 98 at backports-4.19.98-1/net/mac80211/util.c:2040 ieee80211_reconfig+0x98/0xb64 [mac80211]
[ 2548.856020] Hardware became unavailable during restart.


....

And endless -108 errors and other funk after this.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
