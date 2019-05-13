Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFB1AF79
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 06:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfEME00 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 00:26:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59284 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfEME00 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 00:26:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E18D6087A; Mon, 13 May 2019 04:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557721585;
        bh=485jr2fpmuCxUnFiaDKxVVkRWaqD5BarJ7lAxJBh3Z8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=a1gWc25C3bWuFzHUKpBtEta8SHWWEXOMBBjcMdJAiBp1K0c4FedSr/JdCKRvwor4V
         Ffp/Ipp9mWBUPFIsD5bEJkkom5Z+SXJTVJgO6TWbpK4gBei0atbIjlg62fm6/pKZVF
         ynTzGDVz/slyHtN3Mzs+n/0sf7zOwhiea6M/iDZY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 502936032C;
        Mon, 13 May 2019 04:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557721585;
        bh=485jr2fpmuCxUnFiaDKxVVkRWaqD5BarJ7lAxJBh3Z8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=a1gWc25C3bWuFzHUKpBtEta8SHWWEXOMBBjcMdJAiBp1K0c4FedSr/JdCKRvwor4V
         Ffp/Ipp9mWBUPFIsD5bEJkkom5Z+SXJTVJgO6TWbpK4gBei0atbIjlg62fm6/pKZVF
         ynTzGDVz/slyHtN3Mzs+n/0sf7zOwhiea6M/iDZY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 502936032C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
References: <cover.1557591530.git.lorenzo@kernel.org>
        <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
Date:   Mon, 13 May 2019 07:26:21 +0300
In-Reply-To: <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Sat, 11 May 2019 18:38:41 +0200")
Message-ID: <87r293ugia.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce a knob in mt7603 debugfs in order to enable/disable
> edcca processing
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

It's good to explain what edcca does and how the file is used supposed
to be used. In other words, have a small introduction for the user.

> @@ -48,6 +77,7 @@ void mt7603_init_debugfs(struct mt7603_dev *dev)
>  	if (!dir)
>  		return;
>  
> +	debugfs_create_file("edcca", 0400, dir, dev, &fops_edcca);

Why 0400 and not 0600?

-- 
Kalle Valo
