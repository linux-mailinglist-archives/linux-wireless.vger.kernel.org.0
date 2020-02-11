Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1223158FEB
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 14:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgBKN2D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 08:28:03 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:44466 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727928AbgBKN2D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 08:28:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581427682; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=W89ehAwtPst1gi2qiqCq+6oCSobA/otg3wxwTS2uUys=; b=Jwx2XQ55x0TlfL64B+G8wMHikXcsO6kY5avxCCH8//HQ3QywY8Mrjf3sFtHxunUhei/EVU8I
 oa/j3z7y1HDCOlmquZhwQDQdVzVkgevJztfUki9J9BWD5XaJEpd2X043JPx1EzqH3EHRtF4H
 VaTpjC5Zjt1iMLKFnP0pl0rRC+g=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42abe2.7f29181d3688-smtp-out-n03;
 Tue, 11 Feb 2020 13:28:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0E1D1C4479F; Tue, 11 Feb 2020 13:28:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09FB0C43383;
        Tue, 11 Feb 2020 13:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09FB0C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Miles Hu <milehu@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 4/4] ath11k: add more HE fields into radiotap header
References: <20200204151135.25302-1-john@phrozen.org>
        <20200204151135.25302-4-john@phrozen.org>
Date:   Tue, 11 Feb 2020 15:27:56 +0200
In-Reply-To: <20200204151135.25302-4-john@phrozen.org> (John Crispin's message
        of "Tue, 4 Feb 2020 16:11:35 +0100")
Message-ID: <878sl9xnhf.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> From: Miles Hu <milehu@codeaurora.org>
>
> This patch adds code to parse HE fields inside ppdu TLVs. Then it adds the
> populates the additional info into the ratiotap header. Also fix missing QoS
> tag in native wifi mode. Finally rssi and tsf are also added.
>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Tested-by: John Crispin <john@phrozen.org>

John's s-o-b missing and loads of warnings:

drivers/net/wireless/ath/ath11k/hal_rx.c: In function 'ath11k_hal_rx_parse_mon_status_tlv':
drivers/net/wireless/ath/ath11k/hal_rx.c:1074:13: warning: variable 'cp_ltf' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath11k/hal_rx.c:822:48: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath11k/hal_rx.c:822:48:    expected unsigned int [usertype] ul_ofdma_user_v0_word0
drivers/net/wireless/ath/ath11k/hal_rx.c:822:48:    got restricted __le32 [usertype] info6
drivers/net/wireless/ath/ath11k/hal_rx.c:824:48: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath11k/hal_rx.c:824:48:    expected unsigned int [usertype] ul_ofdma_user_v0_word1
drivers/net/wireless/ath/ath11k/hal_rx.c:824:48:    got restricted __le32
drivers/net/wireless/ath/ath11k/hal_rx.c:835:17: warning: cast to restricted __le32
drivers/net/wireless/ath/ath11k/hal_rx.c:835:17: warning: restricted __le32 degrades to integer
drivers/net/wireless/ath/ath11k/hal_rx.c:835:17: warning: restricted __le32 degrades to integer
drivers/net/wireless/ath/ath11k/hal_rx.c:838:17: warning: cast to restricted __le32
drivers/net/wireless/ath/ath11k/hal_rx.c:838:17: warning: restricted __le32 degrades to integer
drivers/net/wireless/ath/ath11k/hal_rx.c:838:17: warning: restricted __le32 degrades to integer
drivers/net/wireless/ath/ath11k/hal_rx.c:951:60: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath11k/hal_rx.c:951:60:    expected unsigned int
drivers/net/wireless/ath/ath11k/hal_rx.c:951:60:    got restricted __le32
drivers/net/wireless/ath/ath11k/hal_rx.c:952:60: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath11k/hal_rx.c:952:60:    expected unsigned int
drivers/net/wireless/ath/ath11k/hal_rx.c:952:60:    got restricted __le32
drivers/net/wireless/ath/ath11k/hal_rx.c:1469:33: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath11k/hal_rx.c:1469:33:    expected unsigned long long [usertype] tsft
drivers/net/wireless/ath/ath11k/hal_rx.c:1469:33:    got restricted __le32
drivers/net/wireless/ath/ath11k/hal_rx.c:1470:84: warning: restricted __le32 degrades to integer
drivers/net/wireless/ath/ath11k/dp_rx.c:3894: braces {} are not necessary for single statement blocks

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
