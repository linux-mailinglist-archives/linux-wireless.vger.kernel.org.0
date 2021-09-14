Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6A40A659
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 07:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbhINF6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 01:58:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25188 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239639AbhINF6j (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 01:58:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631599043; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Hiby+UjQLayzOw0vcg+65yN3FWXMBKqTkibieqJy65Y=; b=uRxbrKTxsRVWS6k0PzFYb9k8C9I9mAu/VLsMnazKPwAlP2VyKpejIKOmRjqPVEDNdhojpERp
 FSlbsEX3RWX1TyJZnJ9eS8fOZxaWTN4Upydq9HGVJsrwpKAJoxBB4Y3U3uytXdbq3a5+oaqj
 EyuAwObFQcXuvc7tXno7qzRLRAE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 614039c0e0f78151d6e27bf8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Sep 2021 05:57:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7C736C4360D; Tue, 14 Sep 2021 05:57:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05BEEC4338F;
        Tue, 14 Sep 2021 05:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 05BEEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Muna Sinada" <msinada@codeaurora.org>
Cc:     "'Johannes Berg'" <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] nl80211: Add HE UL MU fixed rate setting
References: <1627587701-13134-1-git-send-email-msinada@codeaurora.org>
        <6d85542f47955cdac0137c72b0de04e5c0fe0799.camel@sipsolutions.net>
        <001601d79acf$4bb85b80$e3291280$@codeaurora.org>
Date:   Tue, 14 Sep 2021 08:57:16 +0300
In-Reply-To: <001601d79acf$4bb85b80$e3291280$@codeaurora.org> (Muna Sinada's
        message of "Thu, 26 Aug 2021 16:08:34 -0700")
Message-ID: <8735q78zsz.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Muna Sinada" <msinada@codeaurora.org> writes:

> I agree that it is odd to combine this new attribute with the existing
> parameters. I will be removing "he_ul_mcs" out of
> cfg80211_bitrate_mask and passing it as a separate attribute in next
> version.

Please do not top post.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#do_not_top_post_and_edit_your_quotes

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
