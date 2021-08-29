Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4906C3FAB1B
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 13:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhH2Leh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 07:34:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63782 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234987AbhH2Leh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 07:34:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630236825; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=7hc0q1Qqgev7Z96ekTwuT4hCKUmHXHGNAcoKjF349tw=; b=M570jGowmbpRgNPsSdPJnwC6JCM6VycWEgMWfyY83bCE6ET7pWSjoZhCWuVj3hIf9yMJwwTu
 onG2bGYrg91v9+Bd2YgY21ESOF8FRJNVPd/63X3Za9BXF6liw3+o8nFQ6YVoTvT+SO7oBs/W
 KnCF0w2FtqFBL5qotOMRN41fykY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 612b709640d2129ac1f2ac6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 11:33:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8AEAC43460; Sun, 29 Aug 2021 11:33:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93789C4338F;
        Sun, 29 Aug 2021 11:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 93789C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH 2/4] rtw88: add regulatory strategy by chip type
References: <20210802063140.25670-1-pkshih@realtek.com>
        <20210802063140.25670-3-pkshih@realtek.com>
Date:   Sun, 29 Aug 2021 14:33:36 +0300
In-Reply-To: <20210802063140.25670-3-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Mon, 2 Aug 2021 14:31:38 +0800")
Message-ID: <87mtp04h9r.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> Realtek chips can program a specific country domain on efuse to
> indicate what is the expected rtw_regulatory. For chips with a
> PGed country domain, we set REGULATORY_STRICT_REG to tell stack

In the commit logs please avoid using acronyms as much as possible, they
make it harder to read. Only after looking at the patch I was able to
figure out that "PGed" means "programmed", or that's I at least assume
it to mean.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
