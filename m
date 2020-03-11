Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771A9181E30
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 17:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgCKQo6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 12:44:58 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38108 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730176AbgCKQo6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 12:44:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583945097; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=yqUUzYTZSKsJGZNloBjfOtyOaBdtWY7mkZ/cLqK4vik=;
 b=HelcYrgmbdQbBM8+tmnkmGXfoN8TYwT5wwdhECj+0cgg4TaqpkOABimzBm751XcuynjnExTC
 BPe8D+mZw7LsKKGKku6VQelTjUh+XHTu355kc0Np4B72YTdf217mtorNNzjuwRHZGgVt+Ni/
 ZMUXiWnUKNWN5uGs0ZbRPfEukYA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e691578.7fcc07c08810-smtp-out-n04;
 Wed, 11 Mar 2020 16:44:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ABB36C43636; Wed, 11 Mar 2020 16:44:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 289C0C432C2;
        Wed, 11 Mar 2020 16:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 289C0C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: config reorder queue for all tids during peer
 setup
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1581646724-23098-1-git-send-email-tamizhr@codeaurora.org>
References: <1581646724-23098-1-git-send-email-tamizhr@codeaurora.org>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        Tamizh Chelvam <tamizhr@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200311164439.ABB36C43636@smtp.codeaurora.org>
Date:   Wed, 11 Mar 2020 16:44:39 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh Chelvam <tamizhr@codeaurora.org> wrote:

> Currently rx tid setup is happening for TID 0 and TID 16
> during peer setup. And if other TID packets received for
> the peer it will be redirected to rx error ring and not through
> reo ring. And this rx tid configuration cannot be done
> in the rx error ring path since it is a atomic context.
> So moving the rx tid setup for all tids during the peer setup.
> This is required to enable PN offload functionality to route
> all packets through reo ring.
> 
> Co-developed-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

a36adf54cbc8 ath11k: config reorder queue for all tids during peer setup

-- 
https://patchwork.kernel.org/patch/11381557/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
