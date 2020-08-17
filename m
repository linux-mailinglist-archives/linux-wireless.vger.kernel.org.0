Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C584246465
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 12:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHQKW7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 06:22:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50066 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgHQKW6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 06:22:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597659778; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5/DUrwhzR3KlhkHB5X01hvv1/COOqlxY4mcyX8pOBx4=;
 b=LMOUBvD02QzN4pzVG4oDwJCjJwhAWAV19zxNCY5wXB/ISlJA8K5TY+R/UHrKkj3O0RNld4x+
 Jn64RcPlXFkFX+ezeWfL5dUbRZblS0BPdsCslBry2+5rxk08KMcWmB2rWeY3wba2hQCAO4fM
 6OHLIS+//zQVUUDJnBwIPEEOAWI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5f3a5a8185672017516b2215 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 10:22:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33D34C433CB; Mon, 17 Aug 2020 10:22:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5CF6C433C6;
        Mon, 17 Aug 2020 10:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5CF6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200804164152.175375-1-alexander@wetzel-home.de>
References: <20200804164152.175375-1-alexander@wetzel-home.de>
To:     Alexander Wetzel <alexander@wetzel-home.de>
Cc:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Alexander Wetzel <alexander@wetzel-home.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200817102257.33D34C433CB@smtp.codeaurora.org>
Date:   Mon, 17 Aug 2020 10:22:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexander Wetzel <alexander@wetzel-home.de> wrote:

> The ath9k driver was so far only able to rekey PTK0 keys correctly due
> to the best effort queue flush added with commit 62872a9b9a10
> ("mac80211: Fix PTK rekey freezes and clear text leak").
> 
> Add the needed queue flush and set NL80211_EXT_FEATURE_CAN_REPLACE_PTK0
> to tell mac80211 that the driver can now rekey PTK0 keys correctly and
> no longer needs the best effort flush.
> 
> Effectively this prevents mac80211 to warn when rekeying a PTK0 key
> only.
> 
> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

4bad3a2041b5 ath9k: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support

-- 
https://patchwork.kernel.org/patch/11700677/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

