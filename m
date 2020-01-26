Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30CCC149A5D
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 12:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgAZL2H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 06:28:07 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:48422 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729423AbgAZL2H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 06:28:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580038086; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=8pC1f+5TseNLOzXWnh50j9+olx1UGi1E4ktzEnfWwAA=;
 b=OOPd8ZarvHjhb8Ax+eiE6sIMhVxcNn6no+4Z5jtCONxgEU9SVc9A9sTj1QF5AP5q6QyNhODp
 WzDvy1P9dzkkCFDig/35PEXyIceWFyCPwulFfvg/P+qr6Di2LjO2/amdkqNGhn6qz0tW1a6q
 rzR72jrZzbQbcSpQD/stHLQVT0Y=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2d77c5.7fca6d599880-smtp-out-n03;
 Sun, 26 Jan 2020 11:28:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 02A83C433A2; Sun, 26 Jan 2020 11:28:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17123C43383;
        Sun, 26 Jan 2020 11:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17123C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND] ath11k: add tx hw 802.11 encapusaltion offloading support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200122142930.19239-1-john@phrozen.org>
References: <20200122142930.19239-1-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126112805.02A83C433A2@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 11:28:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> This patch adds support for ethernet rxtx mode to the driver. The feature
> is enabled via a new module parameter. If enabled to driver will enable
> the feature on a per vif basis if all other requirements were met.
> 
> Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
> Signed-off-by: John Crispin <john@phrozen.org>

Depends on:

50ff477a8639 mac80211: add 802.11 encapsulation offloading support

Currently in mac80211-next.

drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_mac_mgmt_tx_wmi':
drivers/net/wireless/ath/ath11k/mac.c:3653:30: error: 'IEEE80211_TX_CTRL_HW_80211_ENCAP' undeclared (first use in this function); did you mean 'IEEE80211_TX_CTRL_RATE_INJECT'?
  if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)) {
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                              IEEE80211_TX_CTRL_RATE_INJECT
drivers/net/wireless/ath/ath11k/mac.c:3653:30: note: each undeclared identifier is reported only once for each function it appears in
drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_mac_op_tx':
drivers/net/wireless/ath/ath11k/mac.c:3766:28: error: 'IEEE80211_TX_CTRL_HW_80211_ENCAP' undeclared (first use in this function); did you mean 'IEEE80211_TX_CTRL_RATE_INJECT'?
  if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                            IEEE80211_TX_CTRL_RATE_INJECT
drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_mac_op_add_interface':
drivers/net/wireless/ath/ath11k/mac.c:4145:6: error: implicit declaration of function 'ieee80211_set_hw_80211_encap'; did you mean 'ieee80211_get_he_sta_cap'? [-Werror=implicit-function-declaration]
  if (ieee80211_set_hw_80211_encap(vif, ath11k_ethernet_mode && hw_encap))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ieee80211_get_he_sta_cap
cc1: some warnings being treated as errors
make[5]: *** [drivers/net/wireless/ath/ath11k/mac.o] Error 1
make[5]: *** Waiting for unfinished jobs....
drivers/net/wireless/ath/ath11k/dp_tx.c: In function 'ath11k_dp_tx_get_encap_type':
drivers/net/wireless/ath/ath11k/dp_tx.c:20:31: error: 'IEEE80211_TX_CTRL_HW_80211_ENCAP' undeclared (first use in this function); did you mean 'IEEE80211_TX_CTRL_RATE_INJECT'?
  if (tx_info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                               IEEE80211_TX_CTRL_RATE_INJECT
drivers/net/wireless/ath/ath11k/dp_tx.c:20:31: note: each undeclared identifier is reported only once for each function it appears in
drivers/net/wireless/ath/ath11k/dp_tx.c: In function 'ath11k_dp_tx':
drivers/net/wireless/ath/ath11k/dp_tx.c:97:30: error: 'IEEE80211_TX_CTRL_HW_80211_ENCAP' undeclared (first use in this function); did you mean 'IEEE80211_TX_CTRL_RATE_INJECT'?
  if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) &&
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                              IEEE80211_TX_CTRL_RATE_INJECT
make[5]: *** [drivers/net/wireless/ath/ath11k/dp_tx.o] Error 1
make[4]: *** [drivers/net/wireless/ath/ath11k] Error 2
make[3]: *** [drivers/net/wireless/ath] Error 2
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2

Patch set to Awaiting Upstream.

-- 
https://patchwork.kernel.org/patch/11345841/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
