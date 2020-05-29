Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A09A1E8561
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 19:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgE2Rm0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 13:42:26 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:24164 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbgE2RmX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 13:42:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590774143; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=mS0L5M5Zyxrfx3FqEsEhN7PolZq2SbMS2JzRaG3QdDM=;
 b=MGwBd9AB0o2/05W+nS9dRfBU4CP3PVxqrYqnlJwHiRYKqysjblsVQ0oKyonPiTd4XyJcaUbm
 LoQQv0SRfPvIWDlQzBlmV28A4TRu3IslvFY2uZbiF3c4p+cc6ingAxomalFYgJ5zx9/xcKTN
 TjTLO1neafGV+ZwjEMrQWThDth0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed14976b65440fdba16a288 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:42:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0567C4339C; Fri, 29 May 2020 17:42:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65DDBC433C9;
        Fri, 29 May 2020 17:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65DDBC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mwifiex: Add support for NL80211_ATTR_MAX_AP_ASSOC_STA
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200521123559.29028-1-pali@kernel.org>
References: <20200521123559.29028-1-pali@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <marek.behun@nic.cz>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529174213.D0567C4339C@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:42:13 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Rohár <pali@kernel.org> wrote:

> SD8997 firmware sends TLV_TYPE_MAX_CONN with struct hw_spec_max_conn to
> inform kernel about maximum number of p2p connections and stations in AP
> mode.
> 
> During initialization of SD8997 wifi chip kernel prints warning:
> 
>   mwifiex_sdio mmc0:0001:1: Unknown GET_HW_SPEC TLV type: 0x217
> 
> This patch adds support for parsing TLV_TYPE_MAX_CONN (0x217) and sets
> appropriate cfg80211 member 'max_ap_assoc_sta' from retrieved structure.
> 
> It allows userspace to retrieve NL80211_ATTR_MAX_AP_ASSOC_STA attribute.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

982d7287f8da mwifiex: Add support for NL80211_ATTR_MAX_AP_ASSOC_STA

-- 
https://patchwork.kernel.org/patch/11562835/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

