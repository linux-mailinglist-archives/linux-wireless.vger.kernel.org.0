Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5A98612
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfHUU4G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 16:56:06 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:35302 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUU4G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 16:56:06 -0400
Received: from [172.31.98.117] (unknown [4.30.140.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 48F5B65937;
        Wed, 21 Aug 2019 13:56:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 48F5B65937
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1566420965;
        bh=tn97RrEF9v5NWqJ32TwFzwgA90Xb3Eis2NWu7Ey627k=;
        h=Date:From:To:Subject:From;
        b=EG5QIJM/zLC0FyGqyND5e9BfZlqXN+y+j5Xy+K01a0z9QxugyeLFpmJdamWhCpSrs
         QYzvEiZZqeLa25h0QyZ8UWZjxTpW763YeWOILPtFjFqDkkpz5cV600MtbQt5vvZsgF
         jKDTy74Oqq/SaMPvtZaVZtrxP0RV3QdRYbvDAT0E=
Message-ID: <5D5DAFE4.6080706@candelatech.com>
Date:   Wed, 21 Aug 2019 13:56:04 -0700
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     ath10k <ath10k@lists.infradead.org>, pillair@codeaurora.org,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Regression with commit "ath10k: fill the channel survey results for
 WCN3990 correctly"
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I just noticed in 5.2.7+ kernel than this commit below appears to break WMI
message for my 10.1 firmware, and based on code inspection, 10.2 will be broken
as well.

10.1 struct ends with cycle_count, and 10.2 ends with one 32-bit number
after that, but which is not chan_tx_pwr_range.

I guess you need to create your own wmi msg for the WCN3990.

The change to 10.4 chan_info event is also wrong for my relatively
new version of 10.4 code, so likely breaks firmware in use.  last member
in that struct in my 10.4 fw src is 'A_UINT32 rx_11b_mode_data_duration;'


commit 13104929d2ec32aec0552007d55b9e15bc07176b
Author: Rakesh Pillai <pillair@codeaurora.org>
Date:   Wed Oct 17 16:50:03 2018 +0530

     ath10k: fill the channel survey results for WCN3990 correctly



diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 4971d61..58e33ab 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -6442,6 +6442,14 @@ struct wmi_chan_info_event {
         __le32 noise_floor;
         __le32 rx_clear_count;
         __le32 cycle_count;
+       __le32 chan_tx_pwr_range;
+       __le32 chan_tx_pwr_tp;
+       __le32 rx_frame_count;
+       __le32 my_bss_rx_cycle_count;
+       __le32 rx_11b_mode_data_duration;
+       __le32 tx_frame_cnt;
+       __le32 mac_clk_mhz;
+
  } __packed;



Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

