Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151B9183117
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCLNTF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:19:05 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:62249 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgCLNTF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:19:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584019144; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=DETF0M10FLSFL3LogYoK1OvN3svaN69cKtPXVH0o0Iw=;
 b=luEJswFT9gFnqhnoC/74EKMgjRUvbJomqZ+SZ+nSpe3pp9rMtet0gHL8PMlFZwxOMVqjNoLV
 uMQhvjvg6MTHOxqStXUb4miq/18kg9xKNRHasTc3Wtdv8coFo7cHChifl+n0cFE0ZKw3D22C
 Ms/dR0V+1mrR+6HKb9cUkrgQKmo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a36b4.7f1afdf57340-smtp-out-n02;
 Thu, 12 Mar 2020 13:18:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D2F8C432C2; Thu, 12 Mar 2020 13:18:44 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE638C433D2;
        Thu, 12 Mar 2020 13:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE638C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] brcmfmac: Fix driver crash on USB control transfer
 timeout
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1581583476-60155-2-git-send-email-chi-hsien.lin@cypress.com>
References: <1581583476-60155-2-git-send-email-chi-hsien.lin@cypress.com>
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
Message-Id: <20200312131844.5D2F8C432C2@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:18:44 +0000 (UTC)
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

I assume there will be v2 based on comments.

6 patches set to Changes Requested.

11380001 [1/6] brcmfmac: Fix driver crash on USB control transfer timeout
11380003 [2/6] brcmfmac: Fix double freeing in the fmac usb data path
11380005 [3/6] brcmfmac: fix the incorrect return value in brcmf_inform_single_bss().
11380007 [4/6] brcmfmac: increase max hanger slots from 1K to 3K in fws layer
11380009 [5/6] brcmfmac: add USB autosuspend feature support
11380011 [6/6] brcmfmac: To support printing USB console messages

-- 
https://patchwork.kernel.org/patch/11380001/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
