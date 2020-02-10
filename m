Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220C3157CA8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgBJNpG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 08:45:06 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:15939 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727417AbgBJNpG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 08:45:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581342305; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=2wVZUyXBBNR5dh7kX1f5+nCfH26ZdrZQuTuWUwLJ9ow=; b=rELQHBuVEaB7gzDM27pd12JYftlQ8CPyUJ2QTjxx21ok4PyNYY5qRDTzBHfyMw8IMD+JEDdX
 yhjhvtIxjeUPs59qW1VsUreCFRGlzy7EVahaSYutjYITpfR4Vd36LRPSE/aGZQs2CoG9EEoO
 8IbJ8bbTHRg6yHldLUGOrWl3f1A=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e415e5f.7f37a82c6d88-smtp-out-n01;
 Mon, 10 Feb 2020 13:45:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC3B0C4479C; Mon, 10 Feb 2020 13:45:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43718C43383;
        Mon, 10 Feb 2020 13:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43718C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Miles Hu <milehu@codeaurora.org>
Subject: Re: [PATCH] mac80211: add HE support to ieee80211_calculate_rx_timestamp
References: <20200204150618.15676-1-john@phrozen.org>
Date:   Mon, 10 Feb 2020 15:45:00 +0200
In-Reply-To: <20200204150618.15676-1-john@phrozen.org> (John Crispin's message
        of "Tue, 4 Feb 2020 16:06:18 +0100")
Message-ID: <87lfpawo83.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> From: Miles Hu <milehu@codeaurora.org>
>
> The RX timestamp was not calculated for HE yet. This patch adds the
> missing case clause.
>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Tested-by: John Crispin <john@phrozen.org>

John's s-o-b missing.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
