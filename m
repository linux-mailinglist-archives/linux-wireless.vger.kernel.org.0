Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF69D18323A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 15:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCLOBx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 10:01:53 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:21034 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgCLOBx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 10:01:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584021713; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=hmtYUxfAomTm63zt5xJmHckLffB3I0YYLl4RqEy1ctc=; b=YA6lgb5HWTjDKrv2Q8u/7C69h6BSBclagoU0scAd7troXxUaWus4ktLvHZfIi34O/D3TXHHT
 y3ml1Wanv08cu7RKvPT4+tx5v18he/A3IVSQUMiU+oiBzuF0SI+GyxOX4bQscxBPFsXkp7x0
 GNEeVfsa25FbAbDBToVUkOjy5ko=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a40c9.7fcbb2a693e8-smtp-out-n02;
 Thu, 12 Mar 2020 14:01:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60CC0C433BA; Thu, 12 Mar 2020 14:01:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93B9CC433D2;
        Thu, 12 Mar 2020 14:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93B9CC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Maital Hahn <maitalm@ti.com>,
        Hari Nagalla <hnagalla@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wlcore: remove stray plus sign
References: <20200312090405.5b1ee546a14b.I0a6a1a4c07a68ed1a435edb9553694bdb844e3a8@changeid>
Date:   Thu, 12 Mar 2020 16:01:40 +0200
In-Reply-To: <20200312090405.5b1ee546a14b.I0a6a1a4c07a68ed1a435edb9553694bdb844e3a8@changeid>
        (Johannes Berg's message of "Thu, 12 Mar 2020 09:04:08 +0100")
Message-ID: <8736adu0xn.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> The commit mentioned below added a stray plus sign, likely
> due to some conflict resolution (i.e. as a leftover from a
> unified diff), which was harmless since it was just used as
> an integer constant modifier. Remove it anyway, now that I
> stumbled across it.
>
> Fixes: cf33a7728bf2 ("wlcore: mesh: Add support for RX Broadcast Key")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

I'll queue this to v5.6.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
