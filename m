Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7293845F17E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378371AbhKZQR4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:17:56 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:14935 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378377AbhKZQPx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:15:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637943161; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=j8jhlyo+9DTTT1Dy4HysPeTmQNuFpfUO64U3TDeNd7o=;
 b=S6RuYTnqLQcqo9HHyr40fHLpunLyC7itOJiV6iPVRODWdDqoLjnZrJSx6KzTC60ME45zR9yB
 yjcZnPTqJ/TtQJWxCB2kobGRUwadQGjcVaKws/8VIbqcN2/aiF4PSrtcqwRMVtd7Ng/lHtTz
 NVR8hFFqbAEv5kjGlPLm5kpJ1gQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 61a10778135a8a9d0e96d0a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 16:12:40
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0131AC4360C; Fri, 26 Nov 2021 16:12:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BA62C43617;
        Fri, 26 Nov 2021 16:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9BA62C43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw89: update scan_mac_addr during scanning period
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211111023706.14154-2-pkshih@realtek.com>
References: <20211111023706.14154-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163794315660.10370.15822860839880748383.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 16:12:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Update scan_mac_addr to address CAM as A1, so hardware can ACK probe
> response properly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply to wireless-drivers-next, please respin.

error: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtw89/txrx.h).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch' to see the failed patch
Applying: rtw89: fix incorrect channel info during scan
Patch failed at 0001 rtw89: fix incorrect channel info during scan

2 patches set to Changes Requested.

12613957 [1/2] rtw89: update scan_mac_addr during scanning period
12613959 [2/2] rtw89: fix incorrect channel info during scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211111023706.14154-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

