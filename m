Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F151D2C666
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 14:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfE1MYz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 08:24:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfE1MYy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 08:24:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6EEA3607CA; Tue, 28 May 2019 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559046294;
        bh=ZfOKgZcqQIQIic0D0LZNKlWwGoCAeKr3nnInuCpqXV4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WyvYAwXKqP9phnH2QO1GhoeugcYXuVWqFPkC2THd85Ng/8ffNcAsbRhVMLsElaRLx
         EGgcmWpuPJwu9AfgIH3MogX3u77N9ZZIsVwmSyzBl31+r0LsUyvQfQ26lTQdcruS81
         tTV5spOr86PA70Xh0jdMQw+Qna/WZSFLvwC+jOdc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5562C60128;
        Tue, 28 May 2019 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559046294;
        bh=ZfOKgZcqQIQIic0D0LZNKlWwGoCAeKr3nnInuCpqXV4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=hl80nfIwVcuinyqkMhw8PMu3Uj5yKGm/yHZ+HkJpu+UvOoDC/Vdgbp+4CAm+vdVsZ
         buIYtrk+m6JD+iTtSPzNkDUsmXIpPemd9100qyWUj5pfF+snqrBwLl3vppMCIm7qRv
         JVVtpIZlY9eezCWCfL9hbBAmr8AYKo2whtYgq+Gw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5562C60128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] brcm80211: switch common header files to using SPDX
 license identifier
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1558008251-13692-2-git-send-email-arend.vanspriel@broadcom.com>
References: <1558008251-13692-2-git-send-email-arend.vanspriel@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190528122454.6EEA3607CA@smtp.codeaurora.org>
Date:   Tue, 28 May 2019 12:24:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> With ISC license text in place under the LICENSES folder switch
> to using the SPDX license identifier to refer to the ISC license.
> 
> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

6 patches applied to wireless-drivers-next.git, thanks.

7e5677de8e0c brcm80211: switch common header files to using SPDX license identifier
afe06f822035 brcmutil: switch source files to using SPDX license identifier
f843863d6d10 brcmsmac: switch phy source files to using SPDX license identifier
daeccac2d5e7 brcmfmac: switch source files to using SPDX license identifier
9ff8614a3dbe brcmfmac: use separate Kconfig file for brcmfmac
885a93cf3110 brcm80211: select WANT_DEV_COREDUMP conditionally for brcmfmac

-- 
https://patchwork.kernel.org/patch/10946467/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

