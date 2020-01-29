Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61DF14CBFC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 15:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgA2OBG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 09:01:06 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:37036 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgA2OBG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 09:01:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580306466; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=txp9uFGNGAo5rljrSqIdxB99FX7nLiTZswMxLgpVjKQ=; b=sX5pFhcj6UvMDPVz8rri6vtDFpN1OyaJTqFuEeZfh8X/dt9Ftxnwc1ETnZjRKaB11HbJrB6X
 /hZ2GbaFwsmRMcmX0vg4P9lUhHHaDQrdo46Gn5f9TVcBtNGiDNG1vVsgXKqzJqBrvzTzcCK4
 uvuZJf6vRGTZgIkXtS3RO6ePsp4=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e31901e.7f36f4cd8dc0-smtp-out-n03;
 Wed, 29 Jan 2020 14:01:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB20FC433A2; Wed, 29 Jan 2020 14:01:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B9CBC43383;
        Wed, 29 Jan 2020 14:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B9CBC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2019-01-27
References: <ec25181f-3a2e-0374-a30e-2744e247aea6@nbd.name>
Date:   Wed, 29 Jan 2020 16:00:58 +0200
In-Reply-To: <ec25181f-3a2e-0374-a30e-2744e247aea6@nbd.name> (Felix Fietkau's
        message of "Mon, 27 Jan 2020 19:22:06 +0100")
Message-ID: <87o8um8iqt.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> here's my pull request for 5.6
>
> - Felix
>
> The following changes since commit 2a13513f99e735184fd6f889d78da6424fda80a1:
>
>   Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2020-01-26 17:54:46 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-01-27
>
> for you to fetch changes up to bc6ea8c1cf22ef97d8ece12c433138af2f6e7573:
>
>   mt76: enable Airtime Queue Limit support (2020-01-27 19:17:16 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.6
>
> * dual-band concurrent support for MT7615
> * fixes for rx path race conditions
> * EEPROM fixes
> * MAC address handling fixes
> * coverage class support for MT7615
> * beacon fixes for USB devices
> * MT7615 LED support
> * minor cleanups/fixes for all drivers
> * set_antenna support for MT7615
> * tracing improvements
> * preparation for supporting new USB devices
>
> ----------------------------------------------------------------

Sorry, too late. Linus released v5.5 on Sunday which opened the merge
window for v5.6. And I need to get everything ready for net-next before
the merge window opens.

So this has to wait for v5.7 and I'll pull this after the merge window
has closed.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
