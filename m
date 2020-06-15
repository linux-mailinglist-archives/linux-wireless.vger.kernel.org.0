Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22801F9C58
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgFOPyU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 11:54:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60218 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgFOPyT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 11:54:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592236458; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=vNGYViHvKwfV4DkQQ2FXTX/yCQmCfjasXlwoTH4y68U=; b=YatoTjFYSmTcqtlQCMEDlZCiUoHv/ZPWhYFKJvZbs1njE/FORL8ZmgmyG2uS76mEYHWYq+yi
 inAqXOcd6CuOxI1J5k5lfbFa9hwBs2cKimxniRiY6LM6HKWOChVuNUDCm9a6jo3uW9wJqBSN
 NgQIe7OP/aJrv2/fDffWgNKHjoU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5ee799a0bfb34e631c0feef2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 15:54:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D2AAC433CA; Mon, 15 Jun 2020 15:54:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3879BC433C8;
        Mon, 15 Jun 2020 15:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3879BC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] mt76: mt7915: add missing CONFIG_MAC80211_DEBUGFS
References: <cover.1592158312.git.ryder.lee@mediatek.com>
        <2863c9a7e14c791202738597184f4a6b75d5bc07.1592158312.git.ryder.lee@mediatek.com>
Date:   Mon, 15 Jun 2020 18:54:04 +0300
In-Reply-To: <2863c9a7e14c791202738597184f4a6b75d5bc07.1592158312.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Mon, 15 Jun 2020 02:23:33 +0800")
Message-ID: <87sgewe34z.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> Add CONFIG_MAC80211_DEBUGFS to fix a reported warning.
>
> Fixes: ec9742a ("mt76: mt7915: add .sta_add_debugfs support")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Same comments as in v2:

Fixes: ec9742a8f38e ("mt76: mt7915: add .sta_add_debugfs support")

Should this go to v5.8?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
