Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D51EF12667E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 17:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLSQR1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 11:17:27 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:44206 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726776AbfLSQR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 11:17:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576772246; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=wRmvMPMMMEz/k09cbFa30kXE5tyG8WMVBhxmGR4u7B4=;
 b=SIdZ/EpxGifDbwCXwRyjon718q7lZvy0Mz5gApxJpykKUSqjjJf9Is/WhIIdtdlsxEykKVe0
 us9nX9q6MKWrHsD72LbY/pgx9RHQHsp/7EqPBOyzn8rYDXjtFOdUGDRAbnNwRmT8DirnsCNL
 HSQl9kUZiQmdFpgtH6zO1K0YXPc=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfba294.7f828b998c38-smtp-out-n02;
 Thu, 19 Dec 2019 16:17:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8AD90C447A4; Thu, 19 Dec 2019 16:17:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8F2FC43383;
        Thu, 19 Dec 2019 16:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8F2FC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wil6210: dump Rx status message on errors
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191218135947.5903-2-merez@codeaurora.org>
References: <20191218135947.5903-2-merez@codeaurora.org>
To:     Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191219161723.8AD90C447A4@smtp.codeaurora.org>
Date:   Thu, 19 Dec 2019 16:17:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maya Erez <merez@codeaurora.org> wrote:

> Dump all the Rx status message on different errors to allow more
> visibility of the case.
> 
> Signed-off-by: Ahmad Masri <amasri@codeaurora.org>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

8 patches applied to ath-next branch of ath.git, thanks.

7be3c2331d50 wil6210: dump Rx status message on errors
d3214d428066 wil6210: minimize the time that mem_lock is held
c715b38473c8 wil6210: take mem_lock for writing in crash dump collection
5c5d88a29dd4 wil6210: add verification for cid upper bound
c99d5f8d6178 wil6210: reduce ucode_debug memory region
18beb61d848d wil6210: fix MID valid bits in Rx status message
5e5f069c30cc wil6210: support set_multicast_to_unicast cfg80211 operation
4315a74a482f wil6210: add support for set_cqm_rssi_config

-- 
https://patchwork.kernel.org/patch/11300815/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
