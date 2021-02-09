Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745CF314979
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 08:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBIH0Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 02:26:16 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:61330 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhBIHZy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 02:25:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612855536; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=04UGIPgX5fRUfTH4wAz78bAt4RZFa/likoC69uKcovk=;
 b=Kh1oQ5Ydm5jjUIkPtPO5Wk3ZloeExHLKLfq/Evfhn46jCfMguupyQMBHhZLGGTHgNuTJTzaO
 pskw2J+vgcxTUdnSW8L1Hzdr5GJa+NJpwLGQNx6jgXOpfn+sucuG30CcO+4Yn38bVcz6aa+l
 4aX3ZzxaGnuqo0xGxVAJgc9vg+A=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 602238e4e3df861f4b464840 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 07:25:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 376BBC433C6; Tue,  9 Feb 2021 07:25:24 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9955C433CA;
        Tue,  9 Feb 2021 07:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9955C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Add new debug_mask for sta related logs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1612463738-16542-1-git-send-email-tamizhr@codeaurora.org>
References: <1612463738-16542-1-git-send-email-tamizhr@codeaurora.org>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210209072524.376BBC433C6@smtp.codeaurora.org>
Date:   Tue,  9 Feb 2021 07:25:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh chelvam <tamizhr@codeaurora.org> wrote:

> Add new level ATH10K_DBG_STA debug_mask for printing
> sta related logs. This will be useful to check the
> debug logs of connection and changes related to
> station.
> 
> Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00021
> 
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

97614c59cb72 ath10k: Add new debug level for sta related logs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1612463738-16542-1-git-send-email-tamizhr@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

