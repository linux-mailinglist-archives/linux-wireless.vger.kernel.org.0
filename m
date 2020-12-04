Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA50C2CF5AE
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 21:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgLDUaq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 15:30:46 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:25733 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgLDUap (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 15:30:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607113821; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=9JK7fOL683AFLlg0016BK7usH8HKdvTcVFpj8iMfM7I=; b=fTFZzHmj3u9t4UHcqnXY1QnkldE7MP8D9U33PVpirhvCoOEhInIcVrBX65+R18c1fxuiDWbA
 Vd1SvMs3hiN+WVnkpi3KPowLvginx4nSMVtsdIfRDiFlDBi5d7I4XOxln9R5QNU4U5h5sG2k
 4Uf7cUGAEdzdyZ2MH65xmxQ4Bec=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fca9c4056444c6445f0d997 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 04 Dec 2020 20:29:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8892C433ED; Fri,  4 Dec 2020 20:29:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12E92C433CA;
        Fri,  4 Dec 2020 20:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12E92C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2020-12-04
References: <7ec7cc33-ccf0-ee68-755a-9d118ced3102@nbd.name>
        <20201202191852.525E8C43461@smtp.codeaurora.org>
        <85027265-15f0-6d8f-1fd5-19a88c9530d8@nbd.name>
Date:   Fri, 04 Dec 2020 22:29:47 +0200
In-Reply-To: <85027265-15f0-6d8f-1fd5-19a88c9530d8@nbd.name> (Felix Fietkau's
        message of "Fri, 4 Dec 2020 14:44:33 +0100")
Message-ID: <87y2idfh6s.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> here's my updated pull request for 5.11 with some newer changes.
>
> The following changes since commit 9eb597c74483ad5c230a884449069adfb68285ea:
>
>   Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2020-12-02 21:46:55 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-12-04
>
> for you to fetch changes up to 01ef374d9117f199ba8abc8a284aa5929a955f6d:
>
>   mt76: mt7615: Fix fall-through warnings for Clang (2020-12-04 14:31:16 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.11
>
> * mt7915 fixes
> * mt7615 fixes
> * support for more sta interfaces on mt7615/mt7915
> * mt7915 encap offload
> * performance improvements
> * channel noise report on mt7915
> * usb/sdio support improvements
> * mt7915 testmode support
> * mt7915 DBDC support
> * warning fixes
>
> ----------------------------------------------------------------

There's one new warning:

Commit

  3179dd165f42 ("mt76: mt7915: fix ht mcs in mt7915_mcu_get_rx_rate()")

is missing a Signed-off-by from its committer.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
