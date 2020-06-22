Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3892038FE
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgFVOVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:21:14 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:29426 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728987AbgFVOVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:21:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592835673; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=oObGm0B9jh/uf5s3EJ3x+nhNB00UTbtnSd4CI5ZXPbM=; b=gDvg5VTfLdPoSZSXkRIx49kkqS/Zi6fEMMJfrD5L/WRue1Wb4ENEibnzuWIAqs+m6bkzdGks
 pelY3tAp7VvZwmMtarGgAzxhfB15iHp1vlBQxTTAu19BwFOLhTm9tos9KykGeQX00iZl4dPw
 dmmSmTvkaOvSfAPv8LYgfOrFfxM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5ef0be506f2ee827dae1ec01 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 14:21:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0652CC433C8; Mon, 22 Jun 2020 14:21:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E00DBC433C6;
        Mon, 22 Jun 2020 14:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E00DBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: Re: [PATCH v2 wireless-drivers] mt76: mt7663u: fix memory leaks in mt7663u_probe
References: <e4098f0c8a9ac51997de07f38c2bcdf7042d6db1.1592755166.git.lorenzo@kernel.org>
Date:   Mon, 22 Jun 2020 17:20:58 +0300
In-Reply-To: <e4098f0c8a9ac51997de07f38c2bcdf7042d6db1.1592755166.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Sun, 21 Jun 2020 18:03:38 +0200")
Message-ID: <87sgenfagl.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix the two following memory leaks in mt7663u_probe:
> 1- if device power-own times out, remove ieee80211 hw device.
> 2- if mt76u queues allocation fails, remove pending urbs.

One logical change per patch, please. If you have to create a list of
changes in the commit log that's a good sign that you need to split the
patch :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
