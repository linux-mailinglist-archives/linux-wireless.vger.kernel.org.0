Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CE1864F6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2020 07:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgCPGTe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Mar 2020 02:19:34 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:32624 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729319AbgCPGTe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Mar 2020 02:19:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584339573; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TeLEnDR84LZPTlQmpnU7ulIy1uNXQONasBqhvSIX1e8=;
 b=EMP5T8RyPQhGjMhPVn+XOohJZb+KA/Wo0ilGZQyh6Xz/Xa38dAT8LpFDqclt17OGEcV3FLyh
 6d8kUWD1UvzWvPHOXFnKG6MpOYVZlrAWVhOsn9wAMkM33AkExBi/lrpJxLe6MUXAzLxYZmxQ
 nGqUiLV4ZjegIGN1FOVgyDAq6oU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6f1a62.7ff087668f48-smtp-out-n03;
 Mon, 16 Mar 2020 06:19:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 170F8C43636; Mon, 16 Mar 2020 06:19:13 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57EBAC433CB;
        Mon, 16 Mar 2020 06:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57EBAC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V3 3/4] ath11k: add WMI calls required for handling BSS
 color
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191217141921.8114-3-john@phrozen.org>
References: <20191217141921.8114-3-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200316061913.170F8C43636@smtp.codeaurora.org>
Date:   Mon, 16 Mar 2020 06:19:13 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> If the he_operation field of the beacon sets a BSS color, we need to inform
> the FW of the settings. This patch adds the WMI command handlers required
> to do so.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

There were trivial conflicts in wmi.h and some checkpatch warnings, fixed those
in the pending branch.

-- 
https://patchwork.kernel.org/patch/11297707/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
