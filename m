Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188FD35B2C2
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhDKJbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:31:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60060 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhDKJbG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:31:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618133450; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=bttZmgjbqTLMtnbiTNyDFpAJBHL+t1ogkXVYHcuToiw=;
 b=nRNbxHhn4IM+I8F0LrzH1Jog+yPfOFB/YkwiOdN3H5onyB8WqOZkrYASDZpZfotqVnAITJRl
 dJr9T+h70BLpjaWoNcwxTNgAI1qxWIF9gFXLv9bbf7Q1X110YNXQ5jxEvM4oVUiR6hvEqRYF
 8Xid8U7rlcEI/hqg6EH+ctnARCU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6072c1c987ce1fbb56c26c7c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 11 Apr 2021 09:30:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E546EC43461; Sun, 11 Apr 2021 09:30:48 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D390C433ED;
        Sun, 11 Apr 2021 09:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D390C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt7601u: enable TDLS support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <8f9fd662cdbbb70ba896f1bea80e696b15011d3f.1614536496.git.lorenzo@kernel.org>
References: <8f9fd662cdbbb70ba896f1bea80e696b15011d3f.1614536496.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     kuba@kernel.org, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210411093048.E546EC43461@smtp.codeaurora.org>
Date:   Sun, 11 Apr 2021 09:30:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Notify mac80211 the mt7601u chipset support 802.11 TDLS. The feature has
> been tested with a mt7610u peer.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

670d9e53886c mt7601u: enable TDLS support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/8f9fd662cdbbb70ba896f1bea80e696b15011d3f.1614536496.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

