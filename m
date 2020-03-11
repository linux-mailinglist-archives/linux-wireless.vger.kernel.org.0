Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5730D181E39
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 17:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgCKQqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 12:46:49 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:26482 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730175AbgCKQqs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 12:46:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583945208; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=UhXC7/qsMc5z5an8m2+8QfRfmwemVdL8yXwo8p3PF1Y=;
 b=KtioJEEU3tsUT7J0EOJera4zUkw0hA+c9xPs+aDbwNqpGaKIYhAcicAYW+a48PugkRVExkf0
 fq42x1ve/BhM/W8sSS8dbiRhi8bVdP+YCgL+I47zehvI+ABuMiMKp3ZQ8+i+bB2jO5Fx4ptV
 PZbun2JPByHWUwm5Wv+E0VHKW9Q=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6915ed.7fef9be680d8-smtp-out-n03;
 Wed, 11 Mar 2020 16:46:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 549F9C433D2; Wed, 11 Mar 2020 16:46:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A13CC433CB;
        Wed, 11 Mar 2020 16:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A13CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix not registering airtime of 11a station with
 WMM disable
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1582171405-27236-1-git-send-email-yiboz@codeaurora.org>
References: <1582171405-27236-1-git-send-email-yiboz@codeaurora.org>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Yibo Zhao <yiboz@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200311164636.549F9C433D2@smtp.codeaurora.org>
Date:   Wed, 11 Mar 2020 16:46:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> wrote:

> The tid of 11a station with WMM disable reported by FW is 0x10 in
> tx completion. The tid 16 is mapped to a NULL txq since buffer
> MMPDU capbility is not supported. Then 11a station's airtime will
> not be registered due to NULL txq check. As a results, airtime of
> 11a station keeps unchanged in debugfs system.
> 
> Mask the tid along with IEEE80211_QOS_CTL_TID_MASK to make it in
> the valid range.
> 
> Hardwares tested : QCA9984
> Firmwares tested : 10.4-3.10-00047
> 
> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

f9680c75d187 ath10k: fix not registering airtime of 11a station with WMM disable

-- 
https://patchwork.kernel.org/patch/11393223/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
