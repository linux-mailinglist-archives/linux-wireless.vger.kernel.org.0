Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1EA6125115
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 19:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLRS4g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 13:56:36 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:15211 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbfLRS4g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 13:56:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576695396; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Z+Xc21oBASSpgN/I6A6QSLWnjO+Qja6euVC8lYfJ37g=;
 b=aLN0/gs2WZE3kU9wbLLCzh9hq/kqfDFK1/tZ2Yz61ViMB9oSHNQPlq/mvVWRL5EYE7rTH3pG
 LuRPlNVr57WkX9d+MpDcYzxbvQdCMf5Pb7D0yIQNs7S8kbI5pw414wzArC6ZAJemDgMB5Y3E
 ojHHu8/UNH7hzBXQDomtSezkRaU=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa7663.7fd58be65688-smtp-out-n03;
 Wed, 18 Dec 2019 18:56:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6C8AC43383; Wed, 18 Dec 2019 18:56:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B40EC433CB;
        Wed, 18 Dec 2019 18:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B40EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rt2x00: implement reconfig_complete
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191128091124.15806-1-sgruszka@redhat.com>
References: <20191128091124.15806-1-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218185635.D6C8AC43383@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 18:56:35 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> mac80211 has .reconfig_complete that can be used as indicator of
> HW restart end. This will allow to configure keys/IV differently
> for HW restart and normal configuration.
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

2 patches applied to wireless-drivers-next.git, thanks.

57f9807d1ea2 rt2x00: implement reconfig_complete
2d52378a0ad0 rt2x00: use RESET state bit to prevent IV changes on restart

-- 
https://patchwork.kernel.org/patch/11265643/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
