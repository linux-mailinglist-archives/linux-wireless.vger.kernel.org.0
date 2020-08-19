Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF682494F6
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 08:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHSG0h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 02:26:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15652 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHSG0h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 02:26:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597818396; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PN6zE1gpjyYIM9fr5EdDm53UBzFyP2EjiyqPgnc+nnw=; b=N7XpPa9A9y8Ju6NGBC/SpifFq9ZcDySZFLN3JTOmyEZ/D2T1GXAAVFkqvWitNa4bn8qWW3Sy
 s7uSY4+WHzFgQ5+jyF/EPsJrcVWshsu/2nb4d2kFPmsfdgLRBpJGZDHxGVi6Y5E9NQNGjzg/
 tcDs9sj3aEW0Fwq5fkAPUjj+gzM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f3cc61b2889723bf871e31f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 06:26:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5FD51C43387; Wed, 19 Aug 2020 06:26:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E4AAC433C6;
        Wed, 19 Aug 2020 06:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E4AAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-drivers-next tree with the kspp-gustavo tree
References: <20200819111815.73cae4b0@canb.auug.org.au>
Date:   Wed, 19 Aug 2020 09:26:31 +0300
In-Reply-To: <20200819111815.73cae4b0@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 19 Aug 2020 11:18:15 +1000")
Message-ID: <87364jjgmg.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Today's linux-next merge of the wireless-drivers-next tree got a
> conflict in:
>
>   drivers/net/wireless/ath/ath11k/dp_rx.c
>
> between commit:
>
>   58e813cceabd ("treewide: Use fallthrough pseudo-keyword")
>
> from the kspp-gustavo tree and commit:
>
>   0b294aebb6a0 ("ath11k: Use fallthrough pseudo-keyword")
>
> from the wireless-drivers-next tree.
>
> I fixed it up (the latter removed an extra blank line) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Gustavo, why do you have patches changing ath11k in your tree? PLEASE
don't do that! Instead properly send them to linux-wireless and ath11k
lists, as you have done before. That way there are no unncessary
conflicts like this one which cause extra work for the maintainers.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
