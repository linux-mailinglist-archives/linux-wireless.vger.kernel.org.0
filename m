Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8B1DE46D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgEVK3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 06:29:33 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:51657 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728362AbgEVK3d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 06:29:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590143372; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=HUZUH5YolNvgBaMblVmAM3zcJ0jDBFMKrCg79sCTWsM=; b=lQPmdJVa3LQjFF03uzqMvoHJGOFAtZjnaBUV5y6y61BMnMbHx2s1GATFsOv6hLsWt5ShWqav
 +5w9NH++NOnhE5Gp63wS6LAeyEIl9AqPV2MtmE5PYgGinHrgMY8HADs6vgf8qAaSKytUeDh0
 /kfSYxk8+0xj3B+v1CNp5UJjSDY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ec7a98345598550e6a2ad5c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 10:29:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 420EBC433A1; Fri, 22 May 2020 10:29:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5888DC433C8;
        Fri, 22 May 2020 10:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5888DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     Sven Eckelmann <sven@narfation.org>, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        openwrt-devel@lists.openwrt.org,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v13] ath10k: add LED and GPIO controlling support for various chipsets
References: <1523027875-5143-1-git-send-email-kvalo@codeaurora.org>
        <2468724.JaAZLprVu6@bentobox>
        <b23e65cf-4be7-72db-7955-32eae196953e@dd-wrt.com>
Date:   Fri, 22 May 2020 13:29:15 +0300
In-Reply-To: <b23e65cf-4be7-72db-7955-32eae196953e@dd-wrt.com> (Sebastian
        Gottschall's message of "Wed, 20 May 2020 09:39:45 +0200")
Message-ID: <87wo549sas.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(please don't top post)

Sebastian Gottschall <s.gottschall@dd-wrt.com> writes:

> this code is not in use in its original form for ipq4019. i have seen
> that his patch is also dropped from ath.git but is still in use by
> openwrt. could somone clarify the state here and why it was dropped?

I dropped the patch because of the bug report from openwrt.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
