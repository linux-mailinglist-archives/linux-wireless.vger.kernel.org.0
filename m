Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85E02FA54F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 16:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405934AbhARP4o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 10:56:44 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:48887 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393414AbhARPYQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 10:24:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610983438; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=AUaCxB07pjqFZ88d229cE+qnoW0Y99tFppKDIlN2Ca4=;
 b=IYTp5ClZRLws1gTPvHpC1M0NLDRigOZTbpzix4Wj7fdYSdiN3i61mOtkLreT9ICaCWsy1rZ8
 k7/4xEvz+XYaDdH9uZShskyweZaqmpol7GZFDt0J012zw1ldnnoMAR6QDMmek23z/DGlcuQe
 t1h1H2RlD2P6inX99Ye8bU25DbE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6005a7fe75e5c01cba4e89e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 15:23:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 99099C433ED; Mon, 18 Jan 2021 15:23:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8E49C433CA;
        Mon, 18 Jan 2021 15:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8E49C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers] mt76: mt7663s: fix rx buffer refcounting
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <dca19c9d445156201bc41f7cbb6e894bbc9a678c.1610644945.git.lorenzo@kernel.org>
References: <dca19c9d445156201bc41f7cbb6e894bbc9a678c.1610644945.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kuba@kernel.org, nbd@nbd.name, sean.wang@mediatek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210118152342.99099C433ED@smtp.codeaurora.org>
Date:   Mon, 18 Jan 2021 15:23:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Similar to mt7601u driver, fix erroneous rx page refcounting
> 
> Fixes: a66cbdd6573d ("mt76: mt7615: introduce mt7663s support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

952de419b617 mt76: mt7663s: fix rx buffer refcounting

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/dca19c9d445156201bc41f7cbb6e894bbc9a678c.1610644945.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

