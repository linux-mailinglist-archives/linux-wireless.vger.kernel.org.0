Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0BA1E8177
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 17:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgE2PO5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 11:14:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36411 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgE2PO4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 11:14:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590765296; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=jGsbAdA08Ii2jY8OHoUQE7j7mihEAOSvrVQBmoerbOI=; b=Myd0+GBuiHLcO4ZHhtaYRNXQlOEeaXDHyqn9T3CKYQUdSuPkL1Dvjz0McujbF5ezLikOaXms
 zgdGQ+FEo2VKAt+r3TkR1Nwhe0hSjdckUbCbtAogPHhYWwUZ5FK1CptTPA5FJhQItKE57yhj
 r/dFV9mvb/MMpcuyWSUgEW6234M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ed126f0c28b2cdd98c89b7c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 15:14:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B0BC4C43387; Fri, 29 May 2020 15:14:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 935C0C433C9;
        Fri, 29 May 2020 15:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 935C0C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-wireless@vger.kernel.org>, "Hulk Robot" <hulkci@huawei.com>
Subject: Re: [PATCH] mt76: mt7915: remove set but not used variable 'msta'
References: <20200528074829.118156-1-yuehaibing@huawei.com>
Date:   Fri, 29 May 2020 18:14:50 +0300
In-Reply-To: <20200528074829.118156-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Thu, 28 May 2020 07:48:29 +0000")
Message-ID: <87sgfisrh1.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:

> Cc: linux-wireless@vger.kernel.org,
>     linux-arm-kernel@lists.infradead.org,
>     linux-mediatek@lists.infradead.org,
>     netdev@vger.kernel.org,
>     kernel-janitors@vger.kernel.org

This patch got already applied but please don't include Cc field to the
commit log in the future.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
