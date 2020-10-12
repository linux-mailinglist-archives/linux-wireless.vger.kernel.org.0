Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E283528BE22
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 18:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403821AbgJLQiD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 12:38:03 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:58321 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403815AbgJLQiD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 12:38:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602520682; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=sjfpuF6+YKnsfdv4FleQNSfze7itX1mgqGzQj3DwSSs=; b=QO3ZYfu096Dv89RTMOrKkxGhvKrpW/LZv0Ia6IeGdjVPRmNhWvip1+8bRMzGzw3SIVPFw/0D
 KFlMgyGCp9y79PTNKCPqPBosS1FdZfL7K/+foe4JnOgyCofsAbeF+cX/lzohtUBBQkL4e5Lt
 kutqak6/WvGp3kFECKom9VIqNhs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f84860a06d81bc48d7f876b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Oct 2020 16:36:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B81B1C433CB; Mon, 12 Oct 2020 16:36:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0EFDC433FE;
        Mon, 12 Oct 2020 16:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0EFDC433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7915: fix sparse warning cast from restricted __le16
References: <bdd848a347b7c5b037c76b2617f1825402895f2c.1602519389.git.ryder.lee@mediatek.com>
Date:   Mon, 12 Oct 2020 19:36:22 +0300
In-Reply-To: <bdd848a347b7c5b037c76b2617f1825402895f2c.1602519389.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Tue, 13 Oct 2020 00:21:21 +0800")
Message-ID: <87v9ffqu49.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> drivers/net/wireless/mediatek/mt76/mt7915/init.c:339:26: sparse:
> sparse: cast from restricted __le16
>
> Fixes: 00b2e16 ("mt76: mt7915: add TxBF capabilities")

Commit id is too short, it should be:

Fixes: 00b2e16e0063 ("mt76: mt7915: add TxBF capabilities")

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
