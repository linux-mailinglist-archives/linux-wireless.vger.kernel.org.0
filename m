Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867D8220833
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgGOJHu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:07:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16300 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgGOJHu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:07:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594804069; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=spJswZc1/9trakmOrwIJgC/xgH9LiWJ+I9Q/nVnY5Uk=;
 b=JEPvSSzxZk4/PaHH7rgHnx5/fCjORfCS1z0RL8vh032TeIUWQV3tYM8onU9TLORhTTyeK48X
 aD3YOoRmIXT2hqRoWTmxVGpETQG2rfEhGsrLGZdoOURN6gGvJsQB3gfyk8aGb06mgvfRkFdi
 X03Fyrm1PEmjU6SX/LOasjU8DjE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5f0ec759ee6926bb4f57490f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 09:07:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 773FEC433CB; Wed, 15 Jul 2020 09:07:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04F3FC433C9;
        Wed, 15 Jul 2020 09:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04F3FC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/7] rtw88: 8821c: add basic functions
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200616091625.26489-2-yhchuang@realtek.com>
References: <20200616091625.26489-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715090737.773FEC433CB@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 09:07:37 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Tzu-En Huang <tehuang@realtek.com>
> 
> RTL8821CE chipsets are 802.11ac dual-band WiFi + BT combo chips.
> This patch adds the basic functions such as parameter tables, chip
> information, power on flow.
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

7 patches applied to wireless-drivers-next.git, thanks.

769a29ce2af4 rtw88: 8821c: add basic functions
ad5f411b7f37 rtw88: 8821c: add set tx power index
6cf2086fd099 rtw88: 8821c: add dig related settings
58eb40c921a2 rtw88: 8821c: add set channel support
d19040618a22 rtw88: 8821c: add query rx desc support
960361238b86 rtw88: 8821c: add false alarm statistics
1a94d93e648f rtw88: 8821c: add phy calibration

-- 
https://patchwork.kernel.org/patch/11606931/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

