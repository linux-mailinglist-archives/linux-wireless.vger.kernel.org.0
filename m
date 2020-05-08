Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8051CA634
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 10:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgEHIjN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 04:39:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:35791 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbgEHIjN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 04:39:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588927152; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=mATukPtn6wptWyudbT5LxmuI4RgiN9J1Xcc/OTd51ck=;
 b=nUTiHwJ4/DYUdIx9PGmZScVznB6znU7+7saADnXO23wbPOltMcYtuIlgGF0V+dqykcF3TEFK
 4lwvCxQsvwgLgHNY8bS88u3R/eXVTP41v3N8lTPF+FuhPDihgyv7SDnOo+zkMtN2JIHgRPGe
 iPSFiYbmPW4GGIxoCvq/UsRawCI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb51aae.7fae599d4148-smtp-out-n05;
 Fri, 08 May 2020 08:39:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 878A3C433D2; Fri,  8 May 2020 08:39:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D1FEC433F2;
        Fri,  8 May 2020 08:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D1FEC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath9k: Set RX filter based to allow broadcast Action
 frame RX
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200426084733.7889-1-jouni@codeaurora.org>
References: <20200426084733.7889-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200508083910.878A3C433D2@smtp.codeaurora.org>
Date:   Fri,  8 May 2020 08:39:10 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> Advertise support for multicast frame registration and update the RX
> filter based on the recently added FIF_MCAST_ACTION to allow broadcast
> Action frames to be received. This is needed for Device Provisioning
> Protocol (DPP) use cases that use broadcast Public Action frames.
> 
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>

Depends on:

873b1cf61105 mac80211: Process multicast RX registration for Action frames

Currently in mac80211-next.

-- 
https://patchwork.kernel.org/patch/11510285/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
