Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5DC3A7C24
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 12:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhFOKki (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 06:40:38 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:59251 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhFOKkh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 06:40:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623753513; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vvpSZOXivp1zjX2TTqYHIAzFO8DzFKc+eLHE5xByJvk=;
 b=RRlYXrFNpAcalxKZGA70uK9OIhKCrKhjfKw4+y/H/9NbCvijKAzd4cB7ILaFaU8Ir/iWNnWT
 ZgNoUNeVrSNUZEZuKCOzSmGo6mLtiOmzpwI6S7qNL9Mkp8F1/PSDpxcyayO/E/8cMRFaKZ6D
 y+JLTMRP0x+Cmv95rptvEGFgh80=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60c8830bed59bf69cc3a0efa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 10:38:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2426C4323A; Tue, 15 Jun 2021 10:38:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8C76C4338A;
        Tue, 15 Jun 2021 10:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8C76C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: Delete second brcm folder hierarchy
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210602144305.4481-1-matthias.bgg@kernel.org>
References: <20210602144305.4481-1-matthias.bgg@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        netdev@vger.kernel.org,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org, Amar Shankar <amsr@cypress.com>,
        ivan.ivanov@suse.com, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        SHA-cyfmac-dev-list@infineon.com,
        Wright Feng <wright.feng@infineon.com>,
        Remi Depommier <rde@setrix.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>, dmueller@suse.de,
        Matthias Brugger <mbrugger@suse.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615103803.E2426C4323A@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 10:38:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

matthias.bgg@kernel.org wrote:

> From: Matthias Brugger <mbrugger@suse.com>
> 
> BRCMF_FW_DEFAULT_PATH already defines the brcm folder, delete the second
> folder to match with Linux firmware repository layout.
> 
> Fixes: 75729e110e68 ("brcmfmac: expose firmware config files through modinfo")
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

4a26aafe4886 brcmfmac: Delete second brcm folder hierarchy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210602144305.4481-1-matthias.bgg@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

