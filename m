Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA1181DC9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 17:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgCKQ1h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 12:27:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:22793 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730296AbgCKQ1h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 12:27:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583944056; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=i1+yg011Pxhzcve6U8J9nUSrof/NVUmQDch68w6656U=;
 b=ACNtV2LdDV2O7FuF8BFLUzvAYvzA8wBywstrsfqHRwHX2XdGbVc4EQyPLdje9tiLLOAvpOpt
 2z4jRJJTOHfXm5nru9fbL34kvAULTbm8OKsabYXchZEy5KKBDQ5oye4R6Onk8pKm8ivd1fYf
 uXZQ9AmYmUaKEjJOEKU7ggE/2us=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e691169.7ff2bed1a2d0-smtp-out-n01;
 Wed, 11 Mar 2020 16:27:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1A21CC432C2; Wed, 11 Mar 2020 16:27:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98208C433BA;
        Wed, 11 Mar 2020 16:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98208C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: handle RX fragments
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1581671652-8115-2-git-send-email-mpubbise@codeaurora.org>
References: <1581671652-8115-2-git-send-email-mpubbise@codeaurora.org>
To:     Manikanta Pubbisetty <mpubbise@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200311162720.1A21CC432C2@smtp.codeaurora.org>
Date:   Wed, 11 Mar 2020 16:27:20 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <mpubbise@codeaurora.org> wrote:

> IPQ8074 HW has support to verify the PN of the received frames.
> For all frames except for fragmented ones, HW checks the PN and
> delivers them to the driver. For fragmented frames, driver is
> required to do a little more; it has to reassemble the fragments
> and then reinject them to the HW for verifying the PN. Currently,
> to keep the logic simple, PN verifcation is disabled in HW and is
> handled in mac80211 for all the frames (fragmented and unfragmented).
> 
> On the contrary, offloading PN Validation to the HW brings important
> benefits. It reduces CPU cycles spent on the host CPU for verifying
> the same; helps in enabling features which improve performance like
> mac80211 fast RX path, enabling multiple REO rings for parallel RX
> processing, 802.11 decapsulation offloading. All these features are
> dependent on PN offload which in turn is dependent on handling of
> the received fragments in the driver.
> 
> When TKIP security is used, additional handling is required while
> processing the fragments; since MIC is computed on an MSDU in TKIP,
> only the last fragment has the MIC info. In this case, driver has to
> compute the MIC after reassembly and compare it against the MIC
> present in the frame. For this, MICHAEL_MIC kernel crypto library
> APIs are used and the dependencies are appropriately set.
> 
> Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

kbuild test robot found new warnings:

New smatch warnings:
drivers/net/wireless/ath/ath11k/dp_rx.c:3078
ath11k_dp_rx_h_defrag_reo_reinject() warn: unsigned 'buf_id' is never
less than zero.

sparse warnings: (new ones prefixed by >>)

>> drivers/net/wireless/ath/ath11k/dp_rx.c:65:30: sparse: sparse: incorrect type in return expression (different base types) @@    expected unsigned short @@    got resunsigned short @@
   drivers/net/wireless/ath/ath11k/dp_rx.c:65:30: sparse:    expected unsigned short
   drivers/net/wireless/ath/ath11k/dp_rx.c:65:30: sparse:    got restricted __le16
   drivers/net/wireless/ath/ath11k/dp_rx.c:2784:6: sparse: sparse: symbol 'ath11k_dp_rx_frag_timer' was not declared. Should it be static?

2 patches set to Changes Requested.

11381973 [1/2] ath11k: handle RX fragments
11381967 [2/2] ath11k: enable PN offload

-- 
https://patchwork.kernel.org/patch/11381973/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
