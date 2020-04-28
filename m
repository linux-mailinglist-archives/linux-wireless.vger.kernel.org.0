Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4331BBC8B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 13:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD1LjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 07:39:06 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:42628 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbgD1LjG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 07:39:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588073946; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=a8/TpkMVFPqNezmywV/i3J7uCyQ73bxSaPegLhAQg5I=; b=CXgK3yFlQuyo8poBuFBVCTDKwlyPi+wvWDwVmdqqFcNKunsIohoDYm1oONFO0SWmUt9+5fZz
 Kk/bhdFphMcH9vJkfDq28eE/LwG4H639iNnEjPUp76VganPqtMe7gWrUFmlkqzGizfJznE88
 Bmz/h67qucILPVtBcM+IfRGf1l8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea815cf.7fb2f0e8edf8-smtp-out-n04;
 Tue, 28 Apr 2020 11:38:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 45E58C433F2; Tue, 28 Apr 2020 11:38:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CA15C433CB;
        Tue, 28 Apr 2020 11:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4CA15C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7663: add the possibility to load firmware v2
References: <db72b648024aba3243ee3b7deceb548c9bc2bdf1.1587911939.git.lorenzo@kernel.org>
        <87ftcnj2be.fsf@tynnyri.adurom.net>
        <fd49291e-173e-20b0-ee67-c4f519ce8419@nbd.name>
Date:   Tue, 28 Apr 2020 14:38:51 +0300
In-Reply-To: <fd49291e-173e-20b0-ee67-c4f519ce8419@nbd.name> (Felix Fietkau's
        message of "Tue, 28 Apr 2020 13:16:56 +0200")
Message-ID: <87k11zlu0k.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-04-28 13:07, Kalle Valo wrote:
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>>> mt7663 firmware v2 is used for embedded devices since it has more completed
>>> features in AP mode.
>>> Add the capability to specify in mt7615 Kconfig which firmware load first
>>> (v3 or v2) and fallback to the other one if the selected firmware fails
>>> to load
>>>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>>  .../net/wireless/mediatek/mt76/mt7615/Kconfig | 13 +++++
>>>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 50 ++++++++++++++++---
>>>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 ++-
>>>  .../net/wireless/mediatek/mt76/mt7615/pci.c   |  2 +
>>>  .../net/wireless/mediatek/mt76/mt7615/usb.c   |  2 +
>>>  5 files changed, 65 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
>>> index e25db1135eda..c04d6a182bf0 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
>>> @@ -38,3 +38,16 @@ config MT7663U
>>>  	  This adds support for MT7663U 802.11ax 2x2:2 wireless devices.
>>>  
>>>  	  To compile this driver as a module, choose M here.
>>> +
>>> +config MT7615_OFFLOAD_FIRMWARE
>>> +	bool "Prefer client mode offload firmware (MT7663)"
>>> +	depends on MT7615E || MT7663U
>>> +	default y
>>> +	help
>>> +	  Load MT7663 client mode offload firmware (v3) as primary option
>>> +	  and fallback to MT7663 firmware v2 in case of failure.
>>> +	  If MT7615_OFFLOAD_FIRMWARE is not selected MT7663 firmware v2
>>> +	  will be used as primary option.
>>> +	  MT7663 client mode offload firmware supports low power features
>>> +	  (hw frequency scanning, scheduled frequency scanning, WoW,
>>> +	  802.11 power save) but is more limited in AP mode
>> 
>> Why does this need a compile time config? Wouldn't some kind of runtime
>> configuration be better?
>
> I don't think supporting runtime configuration is worth the extra
> complexity of adding an API for shutting down and restarting the
> firmware and dealing with potential errors along the way.
>
> Both firmware types support AP and client mode. Which one you use
> depends on the kind of system you're building for.
>
> If you're building an embedded AP, you don't need any low power offloads
> and may want to support more than 32 clients, so you'd disable this
> configuration option.
>
> If you run the driver on a laptop or desktop machine, you will most
> likely stick to the default.

Yeah, the need for this kind of "firmware settings" interface comes up
frequently, for example to provide settings to the firmware before it's
loaded or choosing which firmware image to load. It would be great to
find a generic solution for that. IIRC someone suggested devlink at some
point but no idea if that would help here.

> If you want to switch without recompiling, you can always just delete
> the set of firmware files you don't want to use. The driver will fall
> back to the other type.

My problem here is the new Kconfig option and the way I see is that this
feature doesn't justify the need of a new Kconfig option. A Kconfig
option shouldn't change the driver behaviour, it should be more about
enabling and disabling components and other compilation specific
configuration.

What about a module parameter? That would be much better and at least I
can't think of a technical reason why it wouldn't work.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
