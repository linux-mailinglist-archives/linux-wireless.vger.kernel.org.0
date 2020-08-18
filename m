Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9D8248226
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHRJpz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 05:45:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33332 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRJpy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 05:45:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597743954; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=BhE5IHje2IceC7Nfyt2qFVL0QnmxyHkLzZ6DAx/nsCo=;
 b=UAmCv9XYXiOra4h0N+5tSF0GiFw3p6rFx+ss+Zsah2AnvpFUNdMJBmsQxAmX4tSIPpgG0MuV
 o1IiKNEEYqEIlUM4qNqxA3JgzOH4N0ZjsPzE/XgjXP83JPGqqlPzUy/ueGC72ooYTfIHNFo1
 Uw9dYd4io74rt5o+XSnohlKelDY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f3ba332668ab3fef6161f4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 09:45:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C89DDC433CA; Tue, 18 Aug 2020 09:45:21 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3DF7C433C6;
        Tue, 18 Aug 2020 09:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3DF7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/12] ath11k: hal: create register values dynamically
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1597576599-8857-2-git-send-email-kvalo@codeaurora.org>
References: <1597576599-8857-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200818094521.C89DDC433CA@smtp.codeaurora.org>
Date:   Tue, 18 Aug 2020 09:45:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> QCA6390 has different register offset compared to IPQ8074, so need to
> attach the register offset dynamically based on hw_params.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

12 patches applied to ath-next branch of ath.git, thanks.

6976433c4778 ath11k: hal: create register values dynamically
2b5e665bedf7 ath11k: hal: cleanup dynamic register macros
e3396b8bddd2 ath11k: ce: support different CE configurations
6e5e9f59dc5b ath11k: ce: remove host_ce_config_wlan macro
d9d4b5f35488 ath11k: ce: remove CE_COUNT() macro
7cea7c5b0e7b ath11k: hal: assign msi_addr and msi_data to srng
1a05ed37c513 ath11k: ce: get msi_addr and msi_data before srng setup
e5c860e121c2 ath11k: disable CE interrupt before hif start
5f859bc02c7b ath11k: force single pdev only for QCA6390
2d4bcbed5b7d ath11k: initialize wmi config based on hw_params
ed0192f7942e ath11k: wmi: put hardware to DBS mode
13ecd81fbad6 ath11k: dp: redefine peer_map and peer_unmap

-- 
https://patchwork.kernel.org/patch/11716083/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

