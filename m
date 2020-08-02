Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0576235832
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHBPcm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:32:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58436 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHBPcj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:32:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596382358; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9dhliCp6k1QSZP0oAR9bC8A2W1IrtUjwHZIQ0kTdC+o=;
 b=LWBOZXIxF5QfKqj2FDbXk4ye7c2xx6Hc/ZhUE3lz14xA2LssCrtgaHHL0m3U3P6/3cfSfJI2
 i+Vh6+qm48bTvKZKDF+IdA8wTt/aZQcQKww8/iNMuPG3GVmUQILBCWS+RUykiTuH5HlK2ena
 41mVK/PGW8QuwpTUxLFKVK49fMs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f26dc872dfc1b5cc27cde21 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:32:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3985C43395; Sun,  2 Aug 2020 15:32:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A703C433C9;
        Sun,  2 Aug 2020 15:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A703C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] brcmfmac: Set timeout value when configuring power
 save
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200721112302.22718-1-nsaenzjulienne@suse.de>
References: <20200721112302.22718-1-nsaenzjulienne@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802153223.B3985C43395@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:32:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:

> Set the timeout value as per cfg80211's set_power_mgmt() request. If the
> requested value value is left undefined we set it to 2 seconds, the
> maximum supported value.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Patch applied to wireless-drivers-next.git, thanks.

3dc05ffb0443 brcmfmac: Set timeout value when configuring power save

-- 
https://patchwork.kernel.org/patch/11675499/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

