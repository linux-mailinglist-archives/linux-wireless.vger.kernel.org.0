Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196791D308C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgENNC4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 09:02:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62250 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbgENNC4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 09:02:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589461376; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KUxBtgC8ifr9L7kVAsD9YPmEDY1ZfgX6B1uu1BYe5gc=; b=Zv4x+efQMEQTT5UB3J38xCjbGx3yI/uwBDqaH6W+iibaqU79gV3XkkoPcVjXRj0/7b0VZAET
 ofUSkT7WEgUrbQhI2WMmF2z3TA75impLZjWfk4iwESS3A7Av6SoOmN8dxuUqiMWMSVZuAroh
 NVkjk5zeWt/0l/0N0KYAWiDU9ZM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ebd41778ebbf95ecb6e4278 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 May 2020 13:02:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F27FC432C2; Thu, 14 May 2020 13:02:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 152DCC433D2;
        Thu, 14 May 2020 13:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 152DCC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2019-05-14
References: <f49dab4e-5dfc-a8fd-db7e-de22ff01ded1@nbd.name>
Date:   Thu, 14 May 2020 16:02:42 +0300
In-Reply-To: <f49dab4e-5dfc-a8fd-db7e-de22ff01ded1@nbd.name> (Felix Fietkau's
        message of "Thu, 14 May 2020 12:12:19 +0200")
Message-ID: <87ftc2r7nx.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my first pull request for 5.8.
>
> - Felix
>
> The following changes since commit 5bb4e125815aa769a7d2ab7dc203593925bba0ba:
>
>   ipw2x00: Fix comment for CLOCK_BOOTTIME constant (2020-05-12 11:57:26 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-05-14
>
> for you to fetch changes up to 12a87174accd29ff943d4c5fb735e1541b92630b:
>
>   mt76: mt7615: fix typo defining ps work (2020-05-14 11:08:19 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.8
>
> * new devices for mt76x0/mt76x2
> * mt7615 fixes
> * mt7663 fixes
> * support for non-offload firmware on mt7663
> * hw/sched scan support for mt7663
> * mt7615/mt7663 MSI support
> * TDLS support
> * mt7603/mt7615 rate control fixes
> * new driver for mt7915
> * wowlan support for mt7663
> * suspend/resume support for mt7663
>
> ----------------------------------------------------------------

With gcc-10 I see a new warning:

drivers/net/wireless/mediatek/mt76/mt7915/mac.c: In function 'mt7915_mac_decode_he_radiotap':
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:229:1: warning: offset '6' outside bounds of constant string [-Warray-bounds]
  229 | mt7915_mac_decode_he_radiotap(struct sk_buff *skb,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:234:44: note: 'known' declared here
  234 |  static const struct ieee80211_radiotap_he known = {
      |                                            ^~~~~

Please fix that and send it as a followup patch (no need to resend the
pull request because of this).

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
