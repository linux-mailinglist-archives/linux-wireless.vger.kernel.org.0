Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9FF3FC2F3
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 08:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhHaGqU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Aug 2021 02:46:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56253 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237700AbhHaGqS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Aug 2021 02:46:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630392324; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=LbNEfL5UEjd7eZFXBIYNbgZmTv3bnQ8jdT2OtwxfHVI=; b=hq3VZLnGwWWwV1N7kCHbhmpJn0+xmxG7CDo4j3CAZHhwEY/WhsW8YHpgmXC1eR+p/4p9RNCw
 jsnHKYTKWycfOWekxEkHgHNIkhRrRR94FJWWXtOlTUFDRJWRPZsszxzFC5VmJ1CNBBMWKtVr
 cxA4YSiIuAK+4sz7TdecVGq9zAg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 612dcff040d2129ac1162f3d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 31 Aug 2021 06:45:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F15E5C4360C; Tue, 31 Aug 2021 06:45:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A0C3C4338F;
        Tue, 31 Aug 2021 06:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5A0C3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-wireless@vger.kernel.org, bryan.odonoghue@linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "wcn36xx: Enable firmware link monitoring"
References: <1630343360-5942-1-git-send-email-loic.poulain@linaro.org>
Date:   Tue, 31 Aug 2021 09:44:57 +0300
In-Reply-To: <1630343360-5942-1-git-send-email-loic.poulain@linaro.org> (Loic
        Poulain's message of "Mon, 30 Aug 2021 19:09:20 +0200")
Message-ID: <878s0i3yfq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> writes:

> This reverts commit 8def9ec46a5fafc0abcf34489a9e8a787bca984d.
>
> The firmware keep-alive does not cause any event in case of error
> such as non acked. It's just a basic keep alive to prevent the AP
> to kick-off the station due to inactivity. So let mac80211 submit
> its own monitoring packet (probe/null) and disconnect on timeout.
>
> Note: We want to keep firmware keep alive to prevent kick-off
> when host is in suspend-to-mem (no mac80211 monitor packet).
> Ideally fw keep alive should be enabled in suspend path and disabled
> in resume path to prevent having both firmware and mac80211 submitting
> periodic null packets.
>
> This fixes non detected AP leaving issues in active mode (nothing
> monitors beacon or connection).
>
> Cc: stable@vger.kernel.org
> Fixes: 8def9ec46a5f ("wcn36xx: Enable firmware link monitoring")
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>

I'll queue this to v5.15.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
