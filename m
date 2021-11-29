Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FBD461CD3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 18:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbhK2Rkr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 12:40:47 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:25748 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349201AbhK2Rir (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 12:38:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638207329; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/Nz2n8B5CK6zvRX+dqM+u/MZiiDWyNjNr1+48lfQyYI=;
 b=BHjfHIfW05r/8AerhChZ5y6yl0sHksvc8Eb1NJkIiO/5ckXMm0Xt2JxlfRXa6ZA1NSOtUsut
 pCzjoHWOucclCL08AdiBucUOxou3x1Y675ioQQAaFcbQNmG1o+CKh38rzgG/AR6m1tqzNi7N
 wUuOazCnCbFTcdiJt3eTHOGJrpU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61a50f0be7d68470af221d62 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Nov 2021 17:34:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0262C43619; Mon, 29 Nov 2021 17:34:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9CEAC4338F;
        Mon, 29 Nov 2021 17:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B9CEAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers] mt76: fix key pointer overwrite in
 mt7921s_write_txwi/mt7663_usb_sdio_write_txwi
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <eba40c84b6d114f618e2ae486cc6d0f2e9272cf9.1638193069.git.lorenzo@kernel.org>
References: <eba40c84b6d114f618e2ae486cc6d0f2e9272cf9.1638193069.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        deren.wu@mediatek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163820723532.19014.2703891302334752399.kvalo@codeaurora.org>
Date:   Mon, 29 Nov 2021 17:34:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix pointer overwrite in mt7921s_tx_prepare_skb and
> mt7663_usb_sdio_tx_prepare_skb routines since in
> commit '2a9e9857473b ("mt76: fix possible pktid leak")
> mt76_tx_status_skb_add() has been moved out of
> mt7921s_write_txwi()/mt7663_usb_sdio_write_txwi() overwriting
> hw key pointer in ieee80211_tx_info structure. Fix the issue saving
> key pointer before running mt76_tx_status_skb_add().
> 
> Fixes: 2a9e9857473b ("mt76: fix possible pktid leak")
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

191587cd1a5f mt76: fix key pointer overwrite in mt7921s_write_txwi/mt7663_usb_sdio_write_txwi

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/eba40c84b6d114f618e2ae486cc6d0f2e9272cf9.1638193069.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

