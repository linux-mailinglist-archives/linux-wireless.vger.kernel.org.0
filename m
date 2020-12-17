Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A78D2DCCC2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 07:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgLQGwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 01:52:45 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:34081 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgLQGwo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 01:52:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608187940; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=1tFdk1HImY7HvyqmBuLBOx5ZUzxETF4m+tuA78a/ybI=;
 b=sfLC/F8sLGwmlt/A/KDJWKulSZYhKid95PfAGiSxHRxiz087sKbPdaDA7IaNQYNdNyi+g+nR
 OVwDo5ZhqyO4+ifnL/AhEe+ozAMJ62MB9g9kk2uZUzp62ry2l0mREbzSpIv25Rr279+cn8TH
 Pu+4UOIltBWVPpEHT4xQO4MrW4o=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fdb0004065be8d8357bb6d8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 06:51:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 188F7C433ED; Thu, 17 Dec 2020 06:51:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A74DCC433CA;
        Thu, 17 Dec 2020 06:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A74DCC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] ath: Use safer key clearing with key cache entries
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201214172118.18100-2-jouni@codeaurora.org>
References: <20201214172118.18100-2-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201217065148.188F7C433ED@smtp.codeaurora.org>
Date:   Thu, 17 Dec 2020 06:51:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> It is possible for there to be pending frames in TXQs with a reference
> to the key cache entry that is being deleted. If such a key cache entry
> is cleared, those pending frame in TXQ might get transmitted without
> proper encryption. It is safer to leave the previously used key into the
> key cache in such cases. Instead, only clear the MAC address to prevent
> RX processing from using this key cache entry.
> 
> This is needed in particularly in AP mode where the TXQs cannot be
> flushed on station disconnection. This change alone may not be able to
> address all cases where the key cache entry might get reused for other
> purposes immediately (the key cache entry should be released for reuse
> only once the TXQs do not have any remaining references to them), but
> this makes it less likely to get unprotected frames and the more
> complete changes may end up being significantly more complex.
> 
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

5 patches applied to ath-next branch of ath.git, thanks.

56c5485c9e44 ath: Use safer key clearing with key cache entries
73488cb2fa3b ath9k: Clear key cache explicitly on disabling hardware
d2d3e36498dd ath: Export ath_hw_keysetmac()
144cd24dbc36 ath: Modify ath_key_delete() to not need full key entry
ca2848022c12 ath9k: Postpone key cache entry deletion for TXQ frames reference it

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201214172118.18100-2-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

