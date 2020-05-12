Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80BF1CF2BD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgELKm1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:42:27 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52266 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgELKm1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:42:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589280146; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=USNiSJSLhpcOh4vyRO/TCGvhEdZa/MOIT/UM/VygPmQ=; b=P1O+IxI842T+imVfsZ1lIAnOur3HMiAhCPO/HFV9kw3yC6xIhBYat/Eq1VHKMDNGlK31T6pk
 trciperDw9oelE+yiGiRsqYKkXFKfBKqfy0B9tcfLZolu63a0nlaZIWstTgwwGqdTD87Ifkp
 d4DX6yQySqJxVo4/tAc5+zMORVI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba7d8e.7ffa4ff141f0-smtp-out-n02;
 Tue, 12 May 2020 10:42:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5782CC433CB; Tue, 12 May 2020 10:42:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8156C433BA;
        Tue, 12 May 2020 10:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8156C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>
Subject: Re: [PATCH] brcmfmac: fix WPA/WPA2-PSK 4-way handshake offload and SAE offload failures
References: <1589277788-119966-1-git-send-email-chi-hsien.lin@cypress.com>
Date:   Tue, 12 May 2020 13:42:16 +0300
In-Reply-To: <1589277788-119966-1-git-send-email-chi-hsien.lin@cypress.com>
        (Chi-Hsien Lin's message of "Tue, 12 May 2020 05:03:08 -0500")
Message-ID: <8736853053.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> writes:

> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
>
> An incorrect value of use_fwsup is set for 4-way handshake offload for
> WPA//WPA2-PSK, caused by commit 3b1e0a7bdfee ("brcmfmac: add support for
> SAE authentication offload"). It results in missing bit
> BRCMF_VIF_STATUS_EAP_SUCCESS set in brcmf_is_linkup() and causes the
> failure. This patch correct the value for the case.
>
> Also setting bit BRCMF_VIF_STATUS_EAP_SUCCESS for SAE offload case in
> brcmf_is_linkup() to fix SAE offload failure.
>
> Fixes: 3b1e0a7bdfee ("brcmfmac: add support for SAE authentication
> offload")

Fixes line needs to be in one line. I can fix that during commit, no
need to resend because of this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
