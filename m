Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABC1905FC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 08:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgCXHCc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 03:02:32 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45498 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgCXHCb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 03:02:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585033350; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=nJ3chewxtuY/kHXLvF/iaS0jMEykQS+33TUuAaJ+now=; b=savUlJMPa6ZQVH8J2765sRYuYRnRh3kl9zROtYYDiYOvTaGZ4h14qBw3/2FkRRWGb98sX5tX
 QzD6ZXieZxagHM4Sp/bCO87QPEs7/NJdPxQ3vBBjh/mESGw5OvUDQuy/uTeXqixFV2BqI1f0
 rGDJL1d8p0JIIUV1IpH5M41l6Uo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e79b02b.7f0ca6b1e110-smtp-out-n02;
 Tue, 24 Mar 2020 07:00:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01B42C432C2; Tue, 24 Mar 2020 07:00:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D18EEC433CB;
        Tue, 24 Mar 2020 07:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D18EEC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: Re: linux-next: manual merge of the wireless-drivers-next tree with the wireless-drivers tree
References: <20200324111653.35c368e4@canb.auug.org.au>
Date:   Tue, 24 Mar 2020 09:00:54 +0200
In-Reply-To: <20200324111653.35c368e4@canb.auug.org.au> (Stephen Rothwell's
        message of "Tue, 24 Mar 2020 11:16:53 +1100")
Message-ID: <87wo7a8cex.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Today's linux-next merge of the wireless-drivers-next tree got a
> conflict in:
>
>   drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>
> between commit:
>
>   cf52c8a776d1 ("iwlwifi: pcie: add 0x2526/0x401* devices back to cfg detection")
>
> from the wireless-drivers tree and commits:
>
>   67eb556da609 ("iwlwifi: combine 9260 cfgs that only change names")
>   d6f2134a3831 ("iwlwifi: add mac/rf types and 160MHz to the device tables")
>
> from the wireless-drivers-next tree.
>
> I fixed it up (I am not sure wat to do with this, so I just dropped
> the former changes for now) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks Stephen. Luca, how do you propose to fix this conflict?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
