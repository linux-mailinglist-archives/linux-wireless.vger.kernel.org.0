Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD7126BC04
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 07:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgIPF44 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 01:56:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48712 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPF4v (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 01:56:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600235810; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6ACuA2ZtMqqz/JJUQVQhrMJD1lLDbZc6P1a66rk3zdk=;
 b=PTgD5r6CQwT4ijlvJ+gWAcP1mSfbk1hpTw6g8mre9Slc8pk7omRZJNd04Ik55ZnT55CWZBnZ
 jP/9UL7C9T1kRubszBa4QjyUAyfplQ9m1ktV///SzUXM729Luiu6ZuTO0SWsqKvwOTc0f3be
 5khMzpvFBN5i33E9bywV7hNlX0A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f61a90d238e1efa37080290 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 05:56:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63130C433FE; Wed, 16 Sep 2020 05:56:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BC78C433C8;
        Wed, 16 Sep 2020 05:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BC78C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/4] brcmfmac: support 4-way handshake offloading for
 WPA/WPA2-PSK in AP mode
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200817073316.33402-3-stanley.hsu@cypress.com>
References: <20200817073316.33402-3-stanley.hsu@cypress.com>
To:     Chung-Hsien Hsu <stanley.hsu@cypress.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200916055628.63130C433FE@smtp.codeaurora.org>
Date:   Wed, 16 Sep 2020 05:56:28 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chung-Hsien Hsu <stanley.hsu@cypress.com> wrote:

> Firmware may have authenticator code built-in. This is detected by the
> driver and indicated in the wiphy features flags. User space can use
> this flag to determine whether or not to provide the pre-shared key
> material in the nl80211 start AP command to offload the 4-way handshake
> in AP mode.
> 
> Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>

2 patches applied to wireless-drivers-next.git, thanks.

787fb926f8cc brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK in AP mode
d5f59c964e15 brcmfmac: support SAE authentication offload in AP mode

-- 
https://patchwork.kernel.org/patch/11716713/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

