Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA38E1ED096
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 15:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgFCNMn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 09:12:43 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:46009 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbgFCNMm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 09:12:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591189962; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=t2NNF9Lqq4Bg24S6xLKEkVi4k9xUc8Spqz+zw84YqrE=; b=BSxbbvHCLGJIA6GYFS1a1hkxC4CEJ5+nxttsSkFVz/wLuV76GbGbLAyGEIm6HuQojic7sO3b
 OHA0DIWebhNBTsUK1wFWZWabWlHHqW76jbeXCwhFaE1mSYvsGyUFaYNhmwUNH8n57Ehwg81z
 0OMeIInN2drptOE8kLKHgBUWEHI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed7a1c9b65440fdba4569ec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Jun 2020 13:12:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81BD4C433CB; Wed,  3 Jun 2020 13:12:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DC4FC433C6;
        Wed,  3 Jun 2020 13:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DC4FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 0/8] add 6GHz radio support in ath11k driver
References: <20200603001724.12161-1-pradeepc@codeaurora.org>
Date:   Wed, 03 Jun 2020 16:12:37 +0300
In-Reply-To: <20200603001724.12161-1-pradeepc@codeaurora.org> (Pradeep Kumar
        Chitrapu's message of "Tue, 2 Jun 2020 17:17:16 -0700")
Message-ID: <871rmwl2d6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> writes:

> This patch series adds 6GHz frequency listing in ath11k driver and mac80211
> registration for the 6GHz band. Also, extends some of wmi command tlvs for
> supporting 6GHz.
>
> changes in v5:
>  - latest 6ghz patches on mac80211 expects driver not to pass ht/vht
>    caps for 6GHZ band at device registration. so fix that.

What are the dependencies for this patch? Is everything that is in
mac80211-next as of today enough?

Also what I do with Rajkumar's patch:

[PATCH] ath11k: build HE 6 GHz capability

Should I apply it before or after this patchset?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
