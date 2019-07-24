Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB8472E33
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 13:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbfGXLvw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 07:51:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387393AbfGXLvw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 07:51:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 729A860392; Wed, 24 Jul 2019 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969111;
        bh=uILEHRLuMnYtuEUPKP9oIKHHEQmakUzKiQ1w+eTcupc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PRBMQ7XMsgmxqKGP9A8oowZ6G5SuU4IykOqtoiddoMN0acdwp0WIyV965hrJ/GMGC
         Bwi7DsCOIOsXMyqem2SMdxAP48LXufxrV35vl+XwHMiYkSh5nKypaQZjK4Rm5HFcln
         oiWxpF+4fVyNfUPdQAcQX8aJG2ct8dcsrzzxS1qQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49AA260258;
        Wed, 24 Jul 2019 11:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969111;
        bh=uILEHRLuMnYtuEUPKP9oIKHHEQmakUzKiQ1w+eTcupc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=mizgaAp9SR8eTJk9ObCbFRS1GXfHxR6eLLBFZSVglarf6S4UeE4XU2KXxT06hbY8S
         m1GiyxwMH9CWpkZ0dZO9dmJb8uP4Mw2wvmJCcS75mNuglxdGtTPoy6DXs0XkFA7Hrh
         Vmx+rKQY4SQnFa+VjOMp4Gwoc8LgzsYaUc+QtRWQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49AA260258
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] Revert "brcmfmac: fix NULL pointer derefence during
 USB disconnect"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1562835912-1404-2-git-send-email-arend.vanspriel@broadcom.com>
References: <1562835912-1404-2-git-send-email-arend.vanspriel@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190724115151.729A860392@smtp.codeaurora.org>
Date:   Wed, 24 Jul 2019 11:51:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> This reverts commit 5cdb0ef6144f47440850553579aa923c20a63f23. Subsequent
> changes make rework the driver code fixing the issue differently.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

7 patches applied to wireless-drivers-next.git, thanks.

a84a60ccdd65 Revert "brcmfmac: fix NULL pointer derefence during USB disconnect"
14fcfd1cc0c0 brcmfmac: change the order of things in brcmf_detach()
c613085b7494 brcmfmac: avoid firmware command in brcmf_netdev_open() when bus is down
c33330ac06fe brcmfmac: clear events in brcmf_fweh_detach() will always fail
1ac11ae949dd brcmfmac: avoid firmware commands when bus is down
e0bfb9601d48 brcmfmac: simply remove flowring if bus is down
4b11c915f00c brcmfmac: remove unnecessary strlcpy() upon obtaining "ver" iovar

-- 
https://patchwork.kernel.org/patch/11039459/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

