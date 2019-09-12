Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4834B1183
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbfILOwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 10:52:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60776 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732777AbfILOwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 10:52:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0883B6055A; Thu, 12 Sep 2019 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568299964;
        bh=8RfWdrjwCYrwb+IsdCQVnH+JeMXsvIxcWGwEH13aXr4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=T5ei23Mcpv0urPp2evMYboASqGo3J4VusfoRP5VKoVd69F5YbU/nSUxn858d9vs/D
         DVhDnKYXE4I+gKWGmHJNOK/ducWbUkfRR8vuOpDwZO8OHn8fxYOWsKXwdcdKtEe0st
         zLY1cBbdGftcfJ/NuDEGqxS5BwW7KfeRaMqvBweo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C20BD602F8;
        Thu, 12 Sep 2019 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568299963;
        bh=8RfWdrjwCYrwb+IsdCQVnH+JeMXsvIxcWGwEH13aXr4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=TOg5aXdEJSw5qC9ep678yWn1YYYcrrgCNiACdJXc9Mh0dqY7Epe2TFzeO8ecMvdSk
         AQX7A/8Ug/08jOmhae/BNGSyDbGXScN2l0oKRj79ckIdBlFM9LtM3JlizRlKnVANfO
         Z+kdPV1MdNn99r1bXBP2QVLb7tTN5zEvEcrirmpY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C20BD602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k:  Free beacon buf later in vdev teardown.
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190227162756.13048-1-greearb@candelatech.com>
References: <20190227162756.13048-1-greearb@candelatech.com>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org,
        Ben Greear <greearb@candelatech.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190912145244.0883B6055A@smtp.codeaurora.org>
Date:   Thu, 12 Sep 2019 14:52:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com wrote:

> My wave-1 firmware often crashes when I am bringing down
> AP vdevs, and sometimes at least some machines lockup hard
> after spewing IOMMU errors.
> 
> I don't see the same issue in STA mode, so I suspect beacons
> are the issue.
> 
> Moving the beacon buf deletion to later in the vdev teardown
> logic appears to help this problem.  Firmware still crashes
> often, but several iterations did not show IOMMU errors and
> machine didn't hang.
> 
> Tested hardware: QCA9880
> Tested firmware: ath10k-ct from beginning of 2019, exact version unknown
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b3281c6cb768 ath10k: free beacon buf later in vdev teardown

-- 
https://patchwork.kernel.org/patch/10831867/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

