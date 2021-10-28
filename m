Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7264843DD04
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 10:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJ1In2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 04:43:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31149 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhJ1In1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 04:43:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635410461; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=O7AOKoJYSND+E4RnN3ie5X4QpUzInyFR/VVhy/H4E+Y=; b=HjDz95tcvrGZGZEIenasgZutZov7Zi45OTndqfOFuceSnbRb4hJp2ccR1hVOCtsnFbrq41Ij
 9HhJ6OW9jg3gWaXajQUrDNVuai2ygp8KkfSGrDKmSLL/trJ9EfqtJXWYYXi7MvaSRIa8mP2P
 IWfcLXOnTnE9lqIYXdA+SRcX+Pw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 617a6212648aeeca5cf3a13e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Oct 2021 08:40:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40677C4338F; Thu, 28 Oct 2021 08:40:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 639ECC4338F;
        Thu, 28 Oct 2021 08:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 639ECC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: linux-next: manual merge of the kspp tree with the wireless-drivers-next tree
References: <20211028192934.01520d7e@canb.auug.org.au>
Date:   Thu, 28 Oct 2021 11:40:42 +0300
In-Reply-To: <20211028192934.01520d7e@canb.auug.org.au> (Stephen Rothwell's
        message of "Thu, 28 Oct 2021 19:29:34 +1100")
Message-ID: <87ilxh5yph.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(adding Jakub and Dave so that they are aware of this)

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the kspp tree got a conflict in:
>
>   drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
>
> between commit:
>
>   dc52fac37c87 ("iwlwifi: mvm: Support new TX_RSP and COMPRESSED_BA_RES versions")
>
> from the wireless-drivers-next tree and commit:
>
>   fa7845cfd53f ("treewide: Replace open-coded flex arrays in unions")
>
> from the kspp tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

I don't know what kspp tree is and either I don't know why they didn't
submit the patch to wireless-drivers-next, so I assume they will handle
the conflict as well. But I really prefer that they would submit patches
to wireless-drivers-next instead to avoid unnecessary conflicts like
this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
