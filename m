Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E09149A3F
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 11:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgAZKuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 05:50:10 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:43051 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgAZKuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 05:50:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580035809; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=r7sSfcS41xWORUKY2BNKZ12/WqZMFXq+AcbscqzISAE=;
 b=kXZp3TBQa6Y/di2yqyRvEMMyeLK1QY62NbbgNq5kaGZ1k1olnoyPQCBhS1xpA0ioVteP3dc5
 dGNfEaicVoQxCv/fao+aSNhaCWkWN5FBsN6V1lFSesW4DN9beIgbCDepvor8CAxx7qQ7uvoM
 C2T2X04tYhLfHD+mu92O+t3+DuU=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2d6edc.7fb4ad62cbc8-smtp-out-n01;
 Sun, 26 Jan 2020 10:50:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFB61C43383; Sun, 26 Jan 2020 10:50:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B8A7C433CB;
        Sun, 26 Jan 2020 10:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B8A7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND] ath11k: make sure to also report the RX bandwidth inside
 radiotap
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191217202057.27720-1-john@phrozen.org>
References: <20191217202057.27720-1-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126105003.DFB61C43383@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 10:50:03 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> Add IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN to the list of known
> fields. Not doing so will result in wireshark not calculating the
> bitrate correctly.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

93634c61056e ath11k: make sure to also report the RX bandwidth inside radiotap

-- 
https://patchwork.kernel.org/patch/11298569/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
