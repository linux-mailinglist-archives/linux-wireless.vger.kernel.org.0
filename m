Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF7244800
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 12:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgHNK3f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 06:29:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50610 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgHNK3f (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 06:29:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597400974; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KrpBkM033gIFZ56EzZ3aP2meXijZYyViwP302gCUNBE=; b=SquJTcw/BYsb5gZuio3OFtjk2Mcz5LyVBtNyAn+lrpshtyCVrlUI3Lo3O+o9CekWtc4ujdxj
 0kQuHZkv0Rjq+jqu2/nCl5Q54IubR3X9J0PK3v49UHMzxsv5KFtXzkt5fRqwfjx+LdWbQ/b7
 Htk3qKKXxRkK+fXUVpyGpdF5mwY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f36678d247ccc308cad632d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 10:29:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E73F3C433C6; Fri, 14 Aug 2020 10:29:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F74FC433CA;
        Fri, 14 Aug 2020 10:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F74FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Walter Harms <wharms@bfs.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jouni Malinen <jouni@qca.qualcomm.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors\@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: AW: [PATCH] ath6kl: prevent potential array overflow in ath6kl_add_new_sta()
References: <20200813141315.GB457408@mwanda>
        <61e34f670a4845f8b1cbf6f6013f8a35@bfs.de>
Date:   Fri, 14 Aug 2020 13:29:27 +0300
In-Reply-To: <61e34f670a4845f8b1cbf6f6013f8a35@bfs.de> (Walter Harms's message
        of "Fri, 14 Aug 2020 08:49:43 +0000")
Message-ID: <874kp5msfs.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Walter Harms <wharms@bfs.de> writes:

> the debugtrace will give the impression that the function is 
> running. perhaps it is more clever to have this after the check.

But it's possible to deduce from the debug message that aid is out of
limit, so I prefer the way Dan did it.

Please don't top post. Also your mails are not visible in patchwork and
are easily missed, most likely due to using "AW:" in the subject.

https://patchwork.kernel.org/patch/11712551/

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
