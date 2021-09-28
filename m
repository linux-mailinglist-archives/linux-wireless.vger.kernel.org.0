Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7389241B17A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbhI1OCq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 10:02:46 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:26734 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbhI1OCq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 10:02:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632837666; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=rGRqMiSr+utsu0N2GnIEhsd+ua7sY04vP9Z7vhIgCRs=;
 b=KyDDuc0V7spfz6Z3pVimySAzvtFn72uSmT5HKEtyV54ZbgNBRO0Y03my/JfRT0OAcFUUier7
 O8Up+vnp/upa3yC6Rh33ounFcbXpt/lezA2BBOIMg1ICZTxbNtntZj+Z/RE0cRpZnM31+sTR
 +La37hnh8+nZaULLRSFA4L7tmKA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 61531ff09ffb413149970f3a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 14:00:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB592C43460; Tue, 28 Sep 2021 14:00:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8DB9C4338F;
        Tue, 28 Sep 2021 14:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C8DB9C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] ieee80211: Add new A-MPDU factor macro for HE 6 GHz
 peer
 caps
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210913175510.193005-1-jouni@codeaurora.org>
References: <20210913175510.193005-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210928140014.DB592C43460@smtp.codeaurora.org>
Date:   Tue, 28 Sep 2021 14:00:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> Add IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR as per IEEE Std 802.11ax-2021,
> 9.4.2.263 to use for peer max A-MPDU factor in 6 GHz band.
> 
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

62b8963cd84d ieee80211: Add new A-MPDU factor macro for HE 6 GHz peer caps
c3a7d7eb4c98 ath11k: add 6 GHz params in peer assoc command
6f4d70308e5e ath11k: support SMPS configuration for 6 GHz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210913175510.193005-1-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

