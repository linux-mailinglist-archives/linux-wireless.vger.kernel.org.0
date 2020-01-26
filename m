Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0BE149A28
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 11:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgAZKio (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 05:38:44 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:63966 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgAZKio (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 05:38:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580035123; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=xsLADkGhmy7OvlWwD+f2ukruY2Z/OOTtWyxS2hhwemg=;
 b=raGArcTXN6A8vuVxJAccD9bIDO7CD9TuPNP61pz7BTe3qTjsX4KwzjN9S67Zm5mmko25v7wJ
 UdIzXfzQJPn7LFj+jM2EHfQz/UY3d2e9uZk/fc2EMBaDJfaQ6d3jZFVSb8W7moJAeluXD/f2
 n9eAsyIaE5sd8StviMXMLbZ9v2c=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2d6c2f.7fc27f8e2f48-smtp-out-n03;
 Sun, 26 Jan 2020 10:38:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC67AC4479F; Sun, 26 Jan 2020 10:38:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A450C433CB;
        Sun, 26 Jan 2020 10:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A450C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: enable HE tlvs in ppdu stats for pktlog lite
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191217162140.2102-1-john@phrozen.org>
References: <20191217162140.2102-1-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126103838.EC67AC4479F@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 10:38:38 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> This patch enables HE tlvs in ppdu stats for pktlog lite mode.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

1e93a78113b4 ath11k: enable HE tlvs in ppdu stats for pktlog lite

-- 
https://patchwork.kernel.org/patch/11298211/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
