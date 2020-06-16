Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016DA1FAB91
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 10:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFPIrv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 04:47:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37362 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgFPIrv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 04:47:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592297270; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Spo7eC55jSJoYU1hDj3mBi9mLWk+m3pNzf3/uvqS3k0=;
 b=M2seMsV047Fp55tQcmDg5k8fGfgGt3bb9nmz1gTkB4fOcBy1X5Gy3wwdT6chc5F3QreXfJJN
 oVPrez/qFRv9tPNh/cdqySa5iXaMwRYS2yvfz9Nc2IYaIrlQCSngee4/+SQ2AvYkDcoZ5QFY
 EeLj+VyBZAk3HT0eHZMW6tr7HpQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ee8872f6bebe35deb003c24 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 08:47:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1D2CC433CB; Tue, 16 Jun 2020 08:47:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73675C433C8;
        Tue, 16 Jun 2020 08:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73675C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/8] ath11k: update firmware files read path
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1591709581-18039-3-git-send-email-akolli@codeaurora.org>
References: <1591709581-18039-3-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200616084742.E1D2CC433CB@smtp.codeaurora.org>
Date:   Tue, 16 Jun 2020 08:47:42 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> We need this so that all hardware versions can coexist and
> it's easier to manage everything then all hardware
> directories are under ath11k directory.
> 
> Copy ath11k firmware files to
> /lib/firmware/ath11k/IPQ8074/hw2.0/
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7309f7730532 ath11k: update firmware files read path

-- 
https://patchwork.kernel.org/patch/11595655/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

