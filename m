Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B8718F9FE
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 17:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCWQhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 12:37:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:23224 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727491AbgCWQhN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 12:37:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584981433; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=JABNH9me6YoAvfQF0Gj/4JSQfCTEIukFytCuQr0lzIc=;
 b=Oqk9mDdNB+jTj7cGo2x2M67aGHm1vXesNh/kErp0YNwvujfBJt/OYMSwVOk1Z6TkNSy0zK3P
 QEAGqPM0wfmleLOV/b0ihUKRM8WPz1q251zKH80nNnS0qvZJ5+TfJe0JapZ2ap8AYwkmqKFn
 Wj7jt+ai/JEXH7FUHyUkcxMvjF4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e78e5b7.7f9ac832ab90-smtp-out-n02;
 Mon, 23 Mar 2020 16:37:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F063AC432C2; Mon, 23 Mar 2020 16:37:10 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DFE5FC433BA;
        Mon, 23 Mar 2020 16:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFE5FC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.6] iwlwifi: pcie: add 0x2526/0x401* devices back to cfg
 detection
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20200317123331.16762b29f26c.I928bcaa799e7b3d33838c0667714eeb9fa665290@changeid>
References: <iwlwifi.20200317123331.16762b29f26c.I928bcaa799e7b3d33838c0667714eeb9fa665290@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200323163710.F063AC432C2@smtp.codeaurora.org>
Date:   Mon, 23 Mar 2020 16:37:10 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> Three devices, with PCI device ID 0x2526 and subdevice IDs 0x4010,
> 0x4018 and 0x401C were removed accidentally.  Add them back.
> 
> Reported-by: Brett Hassal <brett.hassal@gmail.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206661
> Fixes: 0b295a1eb81f ("iwlwifi: add device name to device_info")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

cf52c8a776d1 iwlwifi: pcie: add 0x2526/0x401* devices back to cfg detection

-- 
https://patchwork.kernel.org/patch/11442507/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
