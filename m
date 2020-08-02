Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6306B2357E5
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgHBPFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:05:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22210 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHBPFz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:05:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596380754; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SGH+E5iStY8I/ql1Yd3Pyfh+TdW/ZPXB4zIhLJ3YYhs=;
 b=to7VNGxBc8jQCr9IgucRb1SrSo4c6DgozfFflXeyBy8O+G41elzfen/P9+o2Ln5oCjLPwzfl
 Xhii3JUYKSr+9B/8DUp7q2b7CwwO+bdcr7ZRRreWcMAkefg+G+haxOnx9dXsfK3jB8rmOwXk
 4jEpb1ed5IHVMlV8nVrRfKV7GiQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f26d652eecfc978d39773ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:05:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA412C433C6; Sun,  2 Aug 2020 15:05:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC8B7C433C9;
        Sun,  2 Aug 2020 15:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC8B7C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] rtw88: fix LDPC field for RA info
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200717064937.27966-2-yhchuang@realtek.com>
References: <20200717064937.27966-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802150553.AA412C433C6@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:05:53 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Tsang-Shian Lin <thlin@realtek.com>
> 
> Convert the type of LDPC field to boolen because
> LDPC field of RA info H2C command to firmware
> is only one bit.
> 
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

7 patches applied to wireless-drivers-next.git, thanks.

ae44fa993e8e rtw88: fix LDPC field for RA info
4dd86b901d13 rtw88: fix short GI capability based on current bandwidth
d8e030c74e83 rtw88: update tx descriptor of mgmt and reserved page packets
3f194bd4ca1c rtw88: coex: only skip coex triggered by BT info
40b788d15832 rtw88: add ieee80211_ops::change_interface
752310ed2b40 rtw88: allows driver to enable/disable beacon
c376c1fc87b7 rtw88: add h2c command in debugfs

-- 
https://patchwork.kernel.org/patch/11669197/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

