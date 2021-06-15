Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB73A8059
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 15:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhFONix (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 09:38:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35585 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231488AbhFONiv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 09:38:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623764207; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kV2lepU7YHg/oum/Kw/cNjNOenkSvJ/HBuc7TJLba64=;
 b=QuTFipdyftgzqn+UNemN3MsR0KlbU7pWRip19Rhp3BEVmeYVje/CrBKPI2li0syX4Ur9xIhP
 DeMNv4n7IJdu51p4S0glioKXR5FRzsr+ZFvZyOmGc8hXcPeKAdcbxStG6psPMJNuaeQllpRH
 XsfyAuea00LdSLmeoI/jlYfX83U=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60c8acdeb6ccaab75326af4d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:36:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F7CFC4360C; Tue, 15 Jun 2021 13:36:30 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43569C433F1;
        Tue, 15 Jun 2021 13:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43569C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rt2x00: do not set timestamp for injected frames
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210504081220.666939-1-stf_xl@wp.pl>
References: <20210504081220.666939-1-stf_xl@wp.pl>
To:     stf_xl@wp.pl
Cc:     linux-wireless@vger.kernel.org, n0w1re <n0w1re@protonmail.ch>,
        ZeroBeat <ZeroBeat@gmx.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615133630.5F7CFC4360C@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 13:36:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

stf_xl@wp.pl wrote:

> From: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> We setup hardware to insert TSF timestamp for beacon and probe response
> frames. This is undesired for injected frames, which might want to
> set their own timestamp values, so disable this setting for injected
> frames.
> 
> Tested-by: ZeroBeat <ZeroBeat@gmx.de>
> Tested-by: n0w1re <n0w1re@protonmail.ch>
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

7af305a1245a rt2x00: do not set timestamp for injected frames

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210504081220.666939-1-stf_xl@wp.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

