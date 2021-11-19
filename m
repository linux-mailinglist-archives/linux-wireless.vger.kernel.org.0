Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F74456EB0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 13:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhKSMJD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 07:09:03 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:21339 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKSMJD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 07:09:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637323561; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=OwHXzHJERlawTgGr+V4bVgjQynhslmh08ITHR458hGE=; b=Zf0dH74ykpeCFwHqV9RFBjxrEBHJuKvuDIzgXsdNHu+WdjBXCz+A0JcAdOfC2BMQ0icbEhyR
 fG6rVxuKmLRHjbk5avIae+8skcE0gddrYCIphdddUbZFrXC/n1rhFL4Dg1kBebMl8H5DxbfY
 NN2PC0GZyKAnQ3wuIQxm6yi/6kM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61979329665450d43a7f1a3f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 12:06:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5372CC4360C; Fri, 19 Nov 2021 12:06:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 280AEC4338F;
        Fri, 19 Nov 2021 12:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 280AEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <tiwai@suse.de>, <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v3 0/3] rtw89: fix crash when loading firmware file on certain platforms
References: <20211119054512.10620-1-pkshih@realtek.com>
Date:   Fri, 19 Nov 2021 14:05:56 +0200
In-Reply-To: <20211119054512.10620-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 19 Nov 2021 13:45:09 +0800")
Message-ID: <87ee7cwdsr.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> First patch is to avoid writing "partition size" on read-only firmware
> buffer, so it has to fix the crash.
> The later two patches are used to make the semantics clear, but they don't
> change the logic at all.
>
> I hope at least first patch can be taken into 5.16-rc, so people can avoid
> this crash.

My plan is to take patch 1 to wireless-drivers. And, after patch 1
trickles down to wireless-drivers-next, patch 2-3 to
wireless-drivers-next. Sounds good to everyone?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
