Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A577E21ECE3
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgGNJat (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 05:30:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18852 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgGNJat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 05:30:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594719048; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=DZ0S3Q2uXgKZiGBHfWyVdpXlBt5YiahZtDJTPFnXhQ8=;
 b=l5KhnlJVPvkj/QKVoTQ7rFd2Km8rk+TTCaGpxkWQ3s7L85QjTY8kXBdi+GQpsYnKyO6WcLRo
 kxnDrd/gyYoUyazgxw2m5Ma3PWZ6HyoM3+u+YuFx5LXzXIQ08Hk7m6pRnVy/rVgv5K0CycfR
 8KBNoSEN9DJ9K+ZRgyjqpSjBr4c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-west-2.postgun.com with SMTP id
 5f0d7b28b35196d59dfe9eb1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 09:30:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 307B1C43391; Tue, 14 Jul 2020 09:30:16 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A929BC433C8;
        Tue, 14 Jul 2020 09:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A929BC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 6/6] brcmfmac: initialize the requested dwell time
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200610152106.175257-7-chi-hsien.lin@cypress.com>
References: <20200610152106.175257-7-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Joseph Chuang <joseph.chuang@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200714093016.307B1C43391@smtp.codeaurora.org>
Date:   Tue, 14 Jul 2020 09:30:16 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> wrote:

> From: Joseph Chuang <joseph.chuang@cypress.com>
> 
> Commit 9c29da3f4e7e
> ("brcmfmac: Fix P2P Group Formation failure via Go-neg method") did not
> initialize requested_dwell properly, resulting in an always-false dwell
> time overflow check. Fix it by setting the correct requested_dwell
> value.
> 
> Fixes: 4905432b28b7 ("brcmfmac: Fix P2P Group Formation failure via Go-neg method")

The commit id is wrong, this should be:

Fixes: 9c29da3f4e7e ("brcmfmac: Fix P2P Group Formation failure via Go-neg method")

-- 
https://patchwork.kernel.org/patch/11598109/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

