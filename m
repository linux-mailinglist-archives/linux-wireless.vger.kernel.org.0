Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52D51E920B
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2020 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgE3OUv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 May 2020 10:20:51 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:28806 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728927AbgE3OUv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 May 2020 10:20:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590848450; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=wOr7z2oIJjBSXJ1j3NScPKahKy6135QkXH294ZDk0+Q=;
 b=RbBj8vlQjUNNe/Yjy86nv/MLCRna8VkUlUp/o/vqaogsxpMJ82k6qjFEgtb2V7iv76n/qVfJ
 ZxEyRxb1GWP9haiGzV0KNXcZ7XLwTrjvg/G6seeOe02xMEMhd9oO2ORPzy4dok9a6MYBLy58
 lDSuw2O11RswmFEmG+lP+Xn4G6E=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ed26bb837a454afcb060f0d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 30 May 2020 14:20:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25821C433CB; Sat, 30 May 2020 14:20:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B35D7C433C6;
        Sat, 30 May 2020 14:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B35D7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: clear DCM max constellation tx value
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1590707417-29672-1-git-send-email-msinada@codeaurora.org>
References: <1590707417-29672-1-git-send-email-msinada@codeaurora.org>
To:     Muna Sinada <msinada@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200530142040.25821C433CB@smtp.codeaurora.org>
Date:   Sat, 30 May 2020 14:20:40 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Muna Sinada <msinada@codeaurora.org> wrote:

> According to 11ax spec. draft 4.0. DCM Max Constellation Tx data
> field should be set to "Reserved" for an AP, therefore bit is
> cleared.
> 
> Signed-off-by: Muna Sinada <msinada@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

37b76986ebd7 ath11k: clear DCM max constellation tx value

-- 
https://patchwork.kernel.org/patch/11577233/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

