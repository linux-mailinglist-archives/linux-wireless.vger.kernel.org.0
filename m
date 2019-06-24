Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A316F50BE2
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfFXNXS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 09:23:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfFXNXS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 09:23:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 17BD560FEE; Mon, 24 Jun 2019 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561382597;
        bh=Kq3IuJxURJZhSpgDWmPzBdcu76hk3iN99KOAb+lQj6k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CmY1nLfCSgRyWR0GTbH+vjVF97EzwWCyHsJukiIyIfdTpFU1JJOfwhnt+oxILRX7a
         BrxebShvJsFer892sPnMSQA08m0HfEnzfgzN8KQj8XOgDI/J9sMjRbOd2lwLEA6zZ8
         lOx4T1oMRKwnBV64GVrJVYfdushx0WoFliz4Ll3o=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B60460DB3;
        Mon, 24 Jun 2019 13:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561382596;
        bh=Kq3IuJxURJZhSpgDWmPzBdcu76hk3iN99KOAb+lQj6k=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=eK4DEFehHcg5A2HBCJJvQyaas8hugZtb0b7wYgcOBJTNUb3nb7gC86g8a3hhLN+If
         moKSd+jqXL7fOo0qxAw3QMxVfvrmv5aXcuVHTM/piRQKNgc1gcV+Cyoy+IsV+xgiyO
         foC2cNbhRkLUt8or58Bo4tODVlHsESYB+WvFo8Kk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B60460DB3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.2 1/2] mwifiex: Don't abort on small,
 spec-compliant vendor IEs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190615001321.241808-1-briannorris@chromium.org>
References: <20190615001321.241808-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190624132317.17BD560FEE@smtp.codeaurora.org>
Date:   Mon, 24 Jun 2019 13:23:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> Per the 802.11 specification, vendor IEs are (at minimum) only required
> to contain an OUI. A type field is also included in ieee80211.h (struct
> ieee80211_vendor_ie) but doesn't appear in the specification. The
> remaining fields (subtype, version) are a convention used in WMM
> headers.
> 
> Thus, we should not reject vendor-specific IEs that have only the
> minimum length (3 bytes) -- we should skip over them (since we only want
> to match longer IEs, that match either WMM or WPA formats). We can
> reject elements that don't have the minimum-required 3 byte OUI.
> 
> While we're at it, move the non-standard subtype and version fields into
> the WMM structs, to avoid this confusion in the future about generic
> "vendor header" attributes.
> 
> Fixes: 685c9b7750bf ("mwifiex: Abort at too short BSS descriptor element")
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

Patch applied to wireless-drivers.git, thanks.

63d7ef36103d mwifiex: Don't abort on small, spec-compliant vendor IEs

-- 
https://patchwork.kernel.org/patch/10996895/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

