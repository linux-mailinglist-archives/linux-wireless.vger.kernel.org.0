Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6815BC4E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 11:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgBMKDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 05:03:42 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:57238 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729559AbgBMKDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 05:03:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581588222; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ulluy0CBU8UaNWv77ra1pMHpAyMpLydPMtevHU+e0VM=;
 b=eM+0vnB88rC87Y+3D5VAM/os6CsX1ExGxnanJdyth8mQJqiihEFdnQVSd7UgvyyIDShy0DTk
 +kwthDB5+4pX+PZx4yuCgY+J8y1eVqwrrNP2RotgTQp55nDayhSjy+oPIFOEeWkoIHw82bwX
 SSRwMZpQqsFmiHjFCZoczJG2nr0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e451efc.7fca9a7f71f0-smtp-out-n02;
 Thu, 13 Feb 2020 10:03:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 541F4C4479C; Thu, 13 Feb 2020 10:03:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63AE8C4479F;
        Thu, 13 Feb 2020 10:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63AE8C4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 5.5] iwlwifi: mvm: Do not require PHY_SKU NVM section
 for 3168 devices
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200128093107.9740-1-dmoulding@me.com>
References: <20200128093107.9740-1-dmoulding@me.com>
To:     Dan Moulding <dmoulding@me.com>
Cc:     linux-wireless@vger.kernel.org, johannes.berg@intel.com,
        emmanuel.grumbach@intel.com, luciano.coelho@intel.com,
        linuxwifi@intel.com, Dan Moulding <dmoulding@me.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200213100340.541F4C4479C@smtp.codeaurora.org>
Date:   Thu, 13 Feb 2020 10:03:40 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Moulding <dmoulding@me.com> wrote:

> The logic for checking required NVM sections was recently fixed in
> commit b3f20e098293 ("iwlwifi: mvm: fix NVM check for 3168
> devices"). However, with that fixed the else is now taken for 3168
> devices and within the else clause there is a mandatory check for the
> PHY_SKU section. This causes the parsing to fail for 3168 devices.
> 
> The PHY_SKU section is really only mandatory for the IWL_NVM_EXT
> layout (the phy_sku parameter of iwl_parse_nvm_data is only used when
> the NVM type is IWL_NVM_EXT). So this changes the PHY_SKU section
> check so that it's only mandatory for IWL_NVM_EXT.
> 
> Fixes: b3f20e098293 ("iwlwifi: mvm: fix NVM check for 3168 devices")
> Signed-off-by: Dan Moulding <dmoulding@me.com>

Patch applied to wireless-drivers.git, thanks.

a9149d243f25 iwlwifi: mvm: Do not require PHY_SKU NVM section for 3168 devices

-- 
https://patchwork.kernel.org/patch/11353871/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
