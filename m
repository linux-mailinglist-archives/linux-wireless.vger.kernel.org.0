Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5EE4E8BAF
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 16:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389527AbfJ2PVI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 11:21:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57076 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389238AbfJ2PVI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 11:21:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B7516020A; Tue, 29 Oct 2019 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572362467;
        bh=hD5oImsXmWT9bM64RWPWj8r4U3h9FcmTPdb4cQzwRJk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gZNqQKKp++ywEEIx+WmHlc1LsY6kmaJOwwB6MF6tUo/KlkEpwNTR6xH8FlJ2fFP2w
         FE1BuHQApm/OcKW81GqIvMuf2ZFfCSjBA+Cfhl/USRTxZTF6KLCs6VNE30qlj3Zgz1
         Rtgj3uqoY8calXttRYaMC+Yq003B+UDRxMpFnOm4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54C546020A;
        Tue, 29 Oct 2019 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572362467;
        bh=hD5oImsXmWT9bM64RWPWj8r4U3h9FcmTPdb4cQzwRJk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gZNqQKKp++ywEEIx+WmHlc1LsY6kmaJOwwB6MF6tUo/KlkEpwNTR6xH8FlJ2fFP2w
         FE1BuHQApm/OcKW81GqIvMuf2ZFfCSjBA+Cfhl/USRTxZTF6KLCs6VNE30qlj3Zgz1
         Rtgj3uqoY8calXttRYaMC+Yq003B+UDRxMpFnOm4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54C546020A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5.4] iwlwifi: fw api: support new  API for scan config cmd
References: <20191029141011.23299-1-luca@coelho.fi>
Date:   Tue, 29 Oct 2019 17:21:04 +0200
In-Reply-To: <20191029141011.23299-1-luca@coelho.fi> (Luca Coelho's message of
        "Tue, 29 Oct 2019 16:10:11 +0200")
Message-ID: <87zhhj37dr.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Ayala Beker <ayala.beker@intel.com>
>
> The API was reduced to include only knowledge currently needed by the
> FW scan logic, the rest is legacy.  Support the new, reduced version.
>
> This solves a problem with newer firmwares, starting from
> iwlwifi-*-50.ucode, which implements and requires the new API version.
>
> Signed-off-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

"a problem"? It would be nice to know more about the problem than just
the "a" :) Describing the bug helps both maintainers and the users.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
