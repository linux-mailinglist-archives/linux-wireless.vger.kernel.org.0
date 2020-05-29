Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452B91E7FC3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgE2OKb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 10:10:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34473 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgE2OKb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 10:10:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590761430; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Rx+3DXfxP9+o3CIv7f/AmX0GdJC1ajVQpn9lOM4Q4Zc=; b=iuz/qv5ivpuc2PNKm31sh6XPTcH3GUSnR8SQdKhX0hEzn/8B+rfHIFDNVR5lZpOEQdn8uPKN
 fx7YakKn0q7f+Zp4CH87OuZm3c7fdukVDNPTGZvEeP6T6C3EoQM7/RIOz0eWcELeeO3qhP1/
 a9HqY49nHmkkdKHPpnQzs9rcibs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed117d52dd9e15ae380c069 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 14:10:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B75C1C433C6; Fri, 29 May 2020 14:10:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EAF5CC433CA;
        Fri, 29 May 2020 14:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAF5CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2019-05-22
References: <d0de94c9-f367-0f57-950b-c76e1808bdcb@nbd.name>
Date:   Fri, 29 May 2020 17:10:24 +0300
In-Reply-To: <d0de94c9-f367-0f57-950b-c76e1808bdcb@nbd.name> (Felix Fietkau's
        message of "Thu, 28 May 2020 18:06:05 +0200")
Message-ID: <875zceu90v.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's another pull request for 5.8, replacing the previous one.
>
> - Felix
>
> The following changes since commit 50ce4c099bebf56be86c9448f7f4bcd34f33663c:
>
>   sctp: fix typo sctp_ulpevent_nofity_peer_addr_change (2020-05-27 15:08:02 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-05-28
>
> for you to fetch changes up to d9045b18cd445e0d0a53903ffd5d79793d9df59e:
>
>   mt76: mt7915: remove set but not used variable 'msta' (2020-05-28 17:57:25 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.8
>
> * fixes for sparse warnings
> * DBDC fixes
> * mt7663 remain-on-channel support
> * mt7915 spatial reuse support
> * mt7915 radiotap fix
> * station wcid allocation fix
> * mt7663 powersave fix
> * mt7663 scan fix
> * mt7611n support
> * cleanup
>
> ----------------------------------------------------------------

One commit has the Cc field by accident, but no need to resend because
of this. Just check your workflow.

commit d9045b18cd445e0d0a53903ffd5d79793d9df59e
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Thu May 28 07:48:29 2020 +0000
Commit:     Felix Fietkau <nbd@nbd.name>
CommitDate: Thu May 28 17:57:25 2020 +0200

    mt76: mt7915: remove set but not used variable 'msta'
    
    Cc: linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org
    
    Fixes gcc '-Wunused-but-set-variable' warning:
    
    drivers/net/wireless/mediatek/mt76/mt7915/mcu.c: In function 'mt7915_mcu_sta_txbf_type':
    drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1805:21: warning:
     variable 'msta' set but not used [-Wunused-but-set-variable]
    
    It is never used, so can be removed.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
