Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4739821EB88
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGNIiS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 04:38:18 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32992 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgGNIiR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 04:38:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594715897; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=51hp/USD0dg5omYZt+llUDWYFVl2K0lEexBWzerpfA0=; b=vZtcuR0PpWqTuNCzOgMuN5jZAPF7EOgvIh2ltbUT21tPJwmCPYnIsUnuKs78H3/pwLSz+M65
 KCy4tPN0RNPnjPlRBE41GJ7BBuFrDPJStw3ISrw0c1lyAdZflEIpEMFNsKSz12c2yaDv5XHd
 3yLh3PFp/HoUNMlMZoAUw0mVAmE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5f0d6eed10127684904844f9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 08:38:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9FC2C43391; Tue, 14 Jul 2020 08:38:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64FDFC433C8;
        Tue, 14 Jul 2020 08:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64FDFC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: Re: [PATCH] mt76: mt7615: always compile mt7615_mcu_set_bss_pm
References: <d486c81f9902961539574d50348cbd29fd53760e.1594203928.git.lorenzo@kernel.org>
Date:   Tue, 14 Jul 2020 11:37:59 +0300
In-Reply-To: <d486c81f9902961539574d50348cbd29fd53760e.1594203928.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Wed, 8 Jul 2020 12:26:11 +0200")
Message-ID: <87r1tecx08.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Move mt7615_mcu_set_bss_pm out of CONFIG_PM in order to fix the
> following issue reported by kernel test robot
>
> ERROR: modpost: "mt7615_mcu_set_bss_pm"
> [drivers/net/wireless/mediatek/mt76/mt7615/mt7615-common.ko] undefined!
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

What commit caused this? Should this go to v5.8?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
