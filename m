Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9EA204CC5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgFWIne (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 04:43:34 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:16358 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731158AbgFWIne (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 04:43:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592901813; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=cjswwIuMBZljgHBncnhDWWLdG7k+vPIo1u1U31Px7M0=;
 b=ddLm4t2oydSKSGfH7jDTeLUPmfE5D33HiF8I6TFZ8/mdmsDdjAdMlhbdw3NztkEXNUtC0tTI
 kx+V1Uby9oqDZwk2fLfIWqoI4qdowlntBeATvcQh0CBJw/K+WSlLV9Srp3EjS9PyCdwcDALd
 FovDYNwdAC0/eUBdigjnA8TX5rg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ef1c0b46bebe35deb9b7245 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 08:43:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 08DB8C433CA; Tue, 23 Jun 2020 08:43:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9262DC433C8;
        Tue, 23 Jun 2020 08:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9262DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 wireless-drivers] mt76: mt7663u: fix memory leaks in
 mt7663u_probe
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <e4098f0c8a9ac51997de07f38c2bcdf7042d6db1.1592755166.git.lorenzo@kernel.org>
References: <e4098f0c8a9ac51997de07f38c2bcdf7042d6db1.1592755166.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200623084332.08DB8C433CA@smtp.codeaurora.org>
Date:   Tue, 23 Jun 2020 08:43:32 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix the two following memory leaks in mt7663u_probe:
> 1- if device power-own times out, remove ieee80211 hw device.
> 2- if mt76u queues allocation fails, remove pending urbs.
> 
> Fixes: eb99cc95c3b65 ("mt76: mt7615: introduce mt7663u support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

b1e79d105516 mt76: mt7663u: fix memory leaks in mt7663u_probe

-- 
https://patchwork.kernel.org/patch/11616619/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

