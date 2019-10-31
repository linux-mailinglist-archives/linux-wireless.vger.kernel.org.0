Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC62EAB7B
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 09:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfJaIVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 04:21:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49326 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJaIVa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 04:21:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1FD9360A03; Thu, 31 Oct 2019 08:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572510090;
        bh=FhAmZZ/+qHnbVsDk92ZCf/5RfhjRpbp8l6+DYtwPsuk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MrHtp273vaUpwyi4k3QMqYcS/4kXgR0iZlHmVMqIIbZv7NC7i9R4qDQ0baRTzXwcA
         /jylLUKbin/qQviyb6oMzlVmgDK7NhI3M2POmdAPKaXEK7xR+EE41NdUBgxTKh8ZrO
         T5t7/102oQ/LQ3JQT+4oTrIi6Jf1nHlWvg6m1TlM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57D826083E;
        Thu, 31 Oct 2019 08:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572510089;
        bh=FhAmZZ/+qHnbVsDk92ZCf/5RfhjRpbp8l6+DYtwPsuk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=TxBDn5YJBoUXbS8AAI+4AiOy28dL/eOAPdtV57LwuUPIQwBqm3b17y3uV50Ock1K6
         orXETt2gjROsiP295HF2xedJ05Jqfz4rBpUMm//1zRHYjqw+M7LNQW3EUiBefXi1m/
         srpVXf+nW9RDQT8PQvVmRT3DQSn6UNx5sMEi8Qt8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57D826083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wil6210: add SPDX license identifiers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1572283477-22976-1-git-send-email-merez@codeaurora.org>
References: <1572283477-22976-1-git-send-email-merez@codeaurora.org>
To:     Maya Erez <merez@codeaurora.org>
Cc:     Lior David <liord@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com, Maya Erez <merez@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191031082130.1FD9360A03@smtp.codeaurora.org>
Date:   Thu, 31 Oct 2019 08:21:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maya Erez <merez@codeaurora.org> wrote:

> Change all files to add SPDX license identifiers and
> remove license text.
> This is only an administrative change, there is no change
> in actual license or copyright for any file.
> 
> Signed-off-by: Lior David <liord@codeaurora.org>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

85630469d268 wil6210: add SPDX license identifiers

-- 
https://patchwork.kernel.org/patch/11216173/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

