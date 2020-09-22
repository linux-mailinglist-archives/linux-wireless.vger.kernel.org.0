Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F88273CF7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 10:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgIVIJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 04:09:28 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:30671 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgIVIJ2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 04:09:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600762167; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=v4+tcWqwKy2CAopg2Q4QSQ9JB+tsPSMbi/VHaj4atLo=; b=a0kSG9a0PMSVql++kDUF1KwsMDXd618JmOjAVLSBdv9KQzd7mzN9TMNdq7UjJZakfKkJeSS0
 BTteACyh9RDP2lWWltJ/+XwEJslWjmo0lJPe2XU+cbtLeHlalHApbzORUrlPsIi5mBuSUcq8
 l/pvSH554n7T/7M7rpLcKIkKi2U=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f69b136aac06013542954b4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 08:09:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8EAB5C433FF; Tue, 22 Sep 2020 08:09:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C5FFC433CA;
        Tue, 22 Sep 2020 08:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C5FFC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     cjhuang@codeaurora.org
Cc:     ath11k@lists.infradead.org, briannorris@chromium.org,
        linux-wireless@vger.kernel.org, dianders@chromium.org
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power limitations.
References: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
        <f98b45b6c035085fe15c9abf16b4c0b5@codeaurora.org>
Date:   Tue, 22 Sep 2020 11:09:22 +0300
In-Reply-To: <f98b45b6c035085fe15c9abf16b4c0b5@codeaurora.org>
        (cjhuang@codeaurora.org's message of "Tue, 22 Sep 2020 13:47:24
        +0800")
Message-ID: <87sgbaz0zx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cjhuang@codeaurora.org writes:

> Sorry, send to wrong ath11k list.
> Let me resend to ath10k list for these 2 patches.

When you submit a new version mark it as "v2". Otherwise people don't
know what's the latest version.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
