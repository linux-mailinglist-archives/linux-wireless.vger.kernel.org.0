Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C5618FB88
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 18:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgCWRcl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 13:32:41 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47049 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727257AbgCWRcl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 13:32:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584984760; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=KQ7yAf+mOGRPKovj5/zP6Etoy+BI+zjm1+/gPx59+LE=;
 b=lSte21mqzrlBJg5MLsvy3vQJKD8m/E1zbF8VxkuNN6Y302J8FlM8/QSrlMjZtdZV0NtHMYKd
 Ir7vpEKXGeA0u08HN8/+SSYkEy/VEB66j9MkRYlo3ZZvY2VKXF1o6iizJY7v99yw9vWIwu2i
 Q5q9PDCcb/1YAkiudt/3NMJ5VT8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e78f2b8.7fa61aa46180-smtp-out-n03;
 Mon, 23 Mar 2020 17:32:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5FA3DC433CB; Mon, 23 Mar 2020 17:32:39 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A56C5C433D2;
        Mon, 23 Mar 2020 17:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A56C5C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 1/6] brcmfmac: Fix driver crash on USB control transfer
 timeout
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1584096620-101123-2-git-send-email-chi-hsien.lin@cypress.com>
References: <1584096620-101123-2-git-send-email-chi-hsien.lin@cypress.com>
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
Message-Id: <20200323173239.5FA3DC433CB@smtp.codeaurora.org>
Date:   Mon, 23 Mar 2020 17:32:39 +0000 (UTC)
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

Fails to build:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c: In function 'brcmf_usb_rx_ctlpkt':
drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c:390:3: error: label 'fail' used but not defined
   goto fail;
   ^~~~
make[6]: *** [drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.o] Error 1
make[6]: *** Waiting for unfinished jobs....
make[5]: *** [drivers/net/wireless/broadcom/brcm80211/brcmfmac] Error 2
make[4]: *** [drivers/net/wireless/broadcom/brcm80211] Error 2
make[3]: *** [drivers/net/wireless/broadcom] Error 2
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

6 patches set to Changes Requested.

11436667 [V2,1/6] brcmfmac: Fix driver crash on USB control transfer timeout
11436669 [V2,2/6] brcmfmac: Fix double freeing in the fmac usb data path
11436671 [V2,3/6] brcmfmac: fix the incorrect return value in brcmf_inform_single_bss().
11436673 [V2,4/6] brcmfmac: increase max hanger slots from 1K to 3K in fws layer
11436675 [V2,5/6] brcmfmac: add USB autosuspend feature support
11436677 [V2,6/6] brcmfmac: To support printing USB console messages

-- 
https://patchwork.kernel.org/patch/11436667/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
