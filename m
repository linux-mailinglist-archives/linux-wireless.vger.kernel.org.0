Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CE03951EF
	for <lists+linux-wireless@lfdr.de>; Sun, 30 May 2021 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhE3QWD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 May 2021 12:22:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14219 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhE3QWC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 May 2021 12:22:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622391624; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fp8fg4VAC/PWprxEdS7PmHgJn0uHKSucre0dkRZgoME=;
 b=dCOu3CEqFcAylk2Eb48ZkIJNJZ4mBZ3ks3hwr9gV+gKLULcYF1g6hZpsEwbccD9Fg28001OQ
 v+gNYH0UFw51SYAoeWcMuGAH42EP7RZPThLj0SEAVQHdz1e0UYcity4vAoquEhAVvx+HRrqu
 PVKRU+qTKJB9e5t/HM8X9jADdpY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60b3bb3bea2aacd72911c952 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 30 May 2021 16:20:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B21A8C4323A; Sun, 30 May 2021 16:20:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF58AC433F1;
        Sun, 30 May 2021 16:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF58AC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 5.13] mt76: mt7615: do not set MT76_STATE_PM at
 bootstrap
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <e5a2618574007113d844874420f7855891abf167.1621085028.git.lorenzo@kernel.org>
References: <e5a2618574007113d844874420f7855891abf167.1621085028.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210530162010.B21A8C4323A@smtp.codeaurora.org>
Date:   Sun, 30 May 2021 16:20:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Remove MT76_STATE_PM in mt7615_init_device() and introduce
> __mt7663s_mcu_drv_pmctrl for fw loading in mt7663s.
> This patch fixes a crash at bootstrap for device (e.g. mt7622) that do
> not support runtime-pm
> 
> Fixes: 7f2bc8ba11a0 ("mt76: connac: introduce wake counter for fw_pmctrl synchronization")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

02de318afa7a mt76: mt7615: do not set MT76_STATE_PM at bootstrap

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/e5a2618574007113d844874420f7855891abf167.1621085028.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

