Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA171A73BD
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406041AbgDNGcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 02:32:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:34400 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405991AbgDNGcp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 02:32:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586845965; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4FdGEmSfSLCLdc/nHt2xIO+4z1F2g07xbIFX8SpYQDo=; b=vC95RlcIbGVPbfpENarMZ6WHFUD334dvkqoZKDUhMufwp3KJMXV43HqqXZswyg5whHL4tySW
 E69O24uyPHGwiKZ3AnKKWiwfel5j9c2DxDxQXj/25+AVINJO4kcnmrRhCxQp2DxlOszyyVhx
 U4LdLKhDi150m92/qeDXWnNSn/c=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e955908.7f58d7f0fea0-smtp-out-n02;
 Tue, 14 Apr 2020 06:32:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D80DC432C2; Tue, 14 Apr 2020 06:32:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B025DC433CB;
        Tue, 14 Apr 2020 06:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B025DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org,
        Soul Huang <Soul.Huang@mediatek.com>
Subject: Re: [PATCH] mt76: mt7615: rework IRQ handling to prepare for MSI support
References: <20200409155902.58185-1-nbd@nbd.name>
Date:   Tue, 14 Apr 2020 09:32:36 +0300
In-Reply-To: <20200409155902.58185-1-nbd@nbd.name> (Felix Fietkau's message of
        "Thu, 9 Apr 2020 17:59:02 +0200")
Message-ID: <87v9m2lgqj.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> With MSI interrupts, IRQs must not be enabled from within the IRQ handler,
> because that can lead to lost events.
> Defer IRQ processing to a tasklet, which is also responsible for enabling
> IRQs (to avoid race conditions against the handler)
>
> Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>

Soul's s-o-b is missing.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
