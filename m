Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3E83195
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 14:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfHFMmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 08:42:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 08:42:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A26F7608CE; Tue,  6 Aug 2019 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565095322;
        bh=6wXW1hjplkA/dgS7zmuzAdqBEDZv8Rd95Cs+I3cVw8o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Mvr6LZkELtmsa8yS3uceIxkbZMizheh9c+OkYaHpH2awxwe966Ryge/2WMHioaU8v
         lyOG8qsBfZoI4MIn6fFcFvqFAv6DK87zoLb4b1/ezAuW61pI7bKBJJVG38ke9bRZxa
         UG51lur0oB5rKqDkZBD90NN+kz5RckCpW324IhOw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D96BF60590;
        Tue,  6 Aug 2019 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565095321;
        bh=6wXW1hjplkA/dgS7zmuzAdqBEDZv8Rd95Cs+I3cVw8o=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=h5cuid3hDCzjlo0pGlwWTMuOyHqCmm2mxQr5LAp5jh7MF9PJ0ICbL5W66cQAO7oSm
         FCThRKtREMCDcn3eJiXbJHyNHqUbEo/VRiFGP9idm25V2xXlzXDV6M957tPvE9b5I/
         ak+pFeHHW1POy+OuY+i451vpe/82I18HSHF27MqE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D96BF60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] rtlwifi: rtl8188ee: Remove unused GET_XXX and SET_XXX
 descriptor macros
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190731003304.14377-2-Larry.Finger@lwfinger.net>
References: <20190731003304.14377-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190806124201.A26F7608CE@smtp.codeaurora.org>
Date:   Tue,  6 Aug 2019 12:42:01 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> As the first step in converting from macros that get/set information
> in the RX and TX descriptors, unused macros are being removed.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

5 patches applied to wireless-drivers-next.git, thanks.

b97494f48d5a rtlwifi: rtl8188ee: Remove unused GET_XXX and SET_XXX descriptor macros
66b2b064ee54 rtlwifi: rtl88188ee: Replace local bit manipulation macros
36eda7568f2e rtlwifi: rtl8188ee: Convert macros that set descriptor
e53e30ba15da rtlwifi: rtl8188ee: Convert inline routines to little-endian words
d1d1a96bdb44 rtlwifi: rtl8188ee: Remove local configuration variable

-- 
https://patchwork.kernel.org/patch/11066963/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

