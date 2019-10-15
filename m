Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215ABD6E9A
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 07:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfJOF2G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 01:28:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfJOF2F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 01:28:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0C01F60BDD; Tue, 15 Oct 2019 05:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571117285;
        bh=8FGb2J/wiGU3r55lQEJRsCKstDbZ2Qwho5EqzVqSYf8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XDxj/4yehBuLdsC/ns/oMKGiMiMhU9FqRl/df2/ElHY8In2y0B4qdlMdfl0nZe12u
         jNTT3iDhaCkGDtTSbkPfoJ2R9P870Z2bXkYn6EqN6XpwNmjgR0hcwWQDST6CZ2H1Dq
         sk6m3z6g1G08NfQFaUlyBYCLdmt9+gSsdDoyo1bw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD25E60610;
        Tue, 15 Oct 2019 05:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571117283;
        bh=8FGb2J/wiGU3r55lQEJRsCKstDbZ2Qwho5EqzVqSYf8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=VuLGlA8lk9NyjZcl8MpkH9/FQvmn9bmr9SU1UhdN/yFzeLu4OBTAyX7nXo9qB8+Y0
         17PxNEnrlPmE62lGxKz2TQB0gDq8+ioS2p81qCejvHX+tWMxAiSBP5ZddMUUTutCaI
         RXiTXq/az4elXX5fFhUe6TrTRvkz/b9OkPmdvU/g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD25E60610
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: =?utf-8?q?=5BPATCH=5D_net/wireless=3A_Delete_unnecessary_checks_bef?==?utf-8?q?ore_the_macro_call_=E2=80=9Cdev=5Fkfree=5Fskb=E2=80=9D?=
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <ea6c6fef-9868-196b-d914-23faf12d7f5c@web.de>
References: <ea6c6fef-9868-196b-d914-23faf12d7f5c@web.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, ath10k@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roy Luo <royluo@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Solomon Peachy <pizza@shaftnet.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191015052805.0C01F60BDD@smtp.codeaurora.org>
Date:   Tue, 15 Oct 2019 05:28:04 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 22 Aug 2019 10:20:10 +0200
> 
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the shown calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied to wireless-drivers-next.git, thanks.

868ad2149602 net/wireless: Delete unnecessary checks before the macro call “dev_kfree_skb”

-- 
https://patchwork.kernel.org/patch/11108741/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

