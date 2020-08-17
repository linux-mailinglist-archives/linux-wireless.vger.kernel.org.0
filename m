Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBF1246469
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 12:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgHQKYS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 06:24:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50066 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgHQKYR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 06:24:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597659857; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=hNp2oCF8x5e4utKwxAAq7/4bAaBvzDdRhYy4tDswErY=;
 b=FoELXDKw3fAKdh32vuEU/p5m7xwxd7LaYdYKVDYLsLehzpL47EQNAMeiZ/nrRE9qLOlc1K5R
 fVrvuDso/SiHIDno4W6g7qCNys/0CFkeY6Rbw4vtm+bbd8Unz9MR7J2+N5BvsbJafElNfp4K
 W8pV+jPgj6vbPaCOzuWwzNj7cYk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f3a5acf1e4d3989d4d2f006 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 10:24:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1F20C43387; Mon, 17 Aug 2020 10:24:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82797C433CA;
        Mon, 17 Aug 2020 10:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82797C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: Fix potential out of bounds in
 ath9k_htc_txcompletion_cb()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200813141253.GA457408@mwanda>
References: <20200813141253.GA457408@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Vasanthakumar Thiagarajan <vasanth@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Senthil Balasubramanian <senthilkumar@atheros.com>,
        Sujith <Sujith.Manoharan@atheros.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200817102414.F1F20C43387@smtp.codeaurora.org>
Date:   Mon, 17 Aug 2020 10:24:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The value of "htc_hdr->endpoint_id" comes from skb->data so Smatch marks
> it as untrusted so we have to check it before using it as an array
> offset.
> 
> This is similar to a bug that syzkaller found in commit e4ff08a4d727
> ("ath9k: Fix use-after-free Write in ath9k_htc_rx_msg") so it is
> probably a real issue.
> 
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

2705cd7558e7 ath9k: Fix potential out of bounds in ath9k_htc_txcompletion_cb()

-- 
https://patchwork.kernel.org/patch/11712553/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

