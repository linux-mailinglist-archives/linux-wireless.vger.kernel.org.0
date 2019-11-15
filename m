Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C852FD6CC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 08:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfKOHPx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 02:15:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33680 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfKOHPx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 02:15:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF61A61069; Fri, 15 Nov 2019 07:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573802152;
        bh=Zwj2PlJGaJYZ2Cm+3gCzcnXOYiESlNN+0oBNClYl2cg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lFXoXJxLiHMdR8fqrddOkGXx82uAJUBK8P5ghQCDmCn8Y0mi3Siuk9X7rL3lTSMCl
         A+ZnCRpMeknVVPylpmJBIESzhTA7UJRWYvCeEd1r9O+xL1sQ0NXyxVJOQNcYoE24zd
         3DX96m0kaAaI/qKcZjhomNlVlPc85MJrj5uncFMI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 748AE61014;
        Fri, 15 Nov 2019 07:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573802152;
        bh=Zwj2PlJGaJYZ2Cm+3gCzcnXOYiESlNN+0oBNClYl2cg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lFXoXJxLiHMdR8fqrddOkGXx82uAJUBK8P5ghQCDmCn8Y0mi3Siuk9X7rL3lTSMCl
         A+ZnCRpMeknVVPylpmJBIESzhTA7UJRWYvCeEd1r9O+xL1sQ0NXyxVJOQNcYoE24zd
         3DX96m0kaAaI/qKcZjhomNlVlPc85MJrj5uncFMI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 748AE61014
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ming Chen <ming032217@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Ming Chen <ming.chen@watchguard.com>
Subject: Re: [PATCH v2] mac80211: Drop the packets whose source or destination mac address is empty
References: <20191114195712.101568-1-ming.chen@watchguard.com>
Date:   Fri, 15 Nov 2019 09:15:49 +0200
In-Reply-To: <20191114195712.101568-1-ming.chen@watchguard.com> (Ming Chen's
        message of "Thu, 14 Nov 2019 11:57:12 -0800")
Message-ID: <87r229boey.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ming Chen <ming032217@gmail.com> writes:

> We occasionally found ath9k could receive some packets from Linux IP stack
> with empty source and destination mac address,which will result in the
> driver cannot find the station node in TX complete. And thus, the driver
> will complete this buffer but without updating the block ack window.
>
> To fix this issue, we should drop this kind of error packet before it
> goes into the driver.

The s-o-b line should be here, before the "---" line.

> ---
>
> According to review feedback, use the is_zero_ether_addr to check if the
> mac address is empty.

Very good that you added the changelog, but to make it more obvious you
could, for example, mark the changelog like this:

---

v3:

Fix s-o-b location

v2:

According to review feedback, use the is_zero_ether_addr to check if the
mac address is empty.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
