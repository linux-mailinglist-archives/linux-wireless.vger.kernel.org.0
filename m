Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21914193C21
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 10:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgCZJo5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 05:44:57 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:59974 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbgCZJo4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 05:44:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585215896; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=qpH3bjwKLqREnf9vNAyia835JUrbonkVHaKkJ/XH9Lk=;
 b=bjlh0yx03GpSiK0A73AGi3piEmNOmz8gZEz3WoIHwYxjEIC0l+R30sDfHfXckOsZt2XGsFjI
 rSXYVWS2l1xn33k3vgdywAcNftEo/hlZuncwqlsU+6iOASAiei81eG//0zhWffxJdbxH9lfF
 REFRHRg61kn258WyCLiJOSTIWX0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7c7992.7feec07238b8-smtp-out-n02;
 Thu, 26 Mar 2020 09:44:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BF39FC43637; Thu, 26 Mar 2020 09:44:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8D52C433F2;
        Thu, 26 Mar 2020 09:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8D52C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V3 1/6] brcmfmac: Fix driver crash on USB control transfer
 timeout
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585124429-97371-2-git-send-email-chi-hsien.lin@cypress.com>
References: <1585124429-97371-2-git-send-email-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Raveendran Somu <raveendran.somu@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200326094450.BF39FC43637@smtp.codeaurora.org>
Date:   Thu, 26 Mar 2020 09:44:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> wrote:

> From: Raveendran Somu <raveendran.somu@cypress.com>
> 
> When the control transfer gets timed out, the error status
> was returned without killing that urb, this leads to using
> the same urb. This issue causes the kernel crash as the same
> urb is sumbitted multiple times. The fix is to kill the
> urb for timeout transfer before returning error
> 
> Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>

5 patches applied to wireless-drivers-next.git, thanks.

93a5bfbc7cad brcmfmac: Fix driver crash on USB control transfer timeout
78179869dc3f brcmfmac: Fix double freeing in the fmac usb data path
bd9944918ceb brcmfmac: fix the incorrect return value in brcmf_inform_single_bss().
2bc50d8828ad brcmfmac: increase max hanger slots from 1K to 3K in fws layer
7f1d42304d93 brcmfmac: add USB autosuspend feature support

-- 
https://patchwork.kernel.org/patch/11457137/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
