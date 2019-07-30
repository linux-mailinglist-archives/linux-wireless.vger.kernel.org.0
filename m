Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7667A337
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 10:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbfG3IkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 04:40:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbfG3IkL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 04:40:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FE9E6030E; Tue, 30 Jul 2019 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564476010;
        bh=OIyAq1bn76gr6Unb9FRGUCGeR7/1wiEDGzjzyPuiHfQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kQq7x8cVF2En69MoQyiPCXqHe/qEKC2g0YUcaBW/X3ZVzdj6VvtPRzRlB6ALhSJPT
         j2GP3C2dj7O2lFYthCBMSrimOdvHYcG+yEnsQENPN7pyXMW8Oj4m95Z5oEpUYk7VXc
         /krCDtGlMDylExGyS3JLsu+AyoYUEPojoaajSuw8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB68B60364;
        Tue, 30 Jul 2019 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564476009;
        bh=OIyAq1bn76gr6Unb9FRGUCGeR7/1wiEDGzjzyPuiHfQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YOdtSJY5XhYjwLaLU2YghrbnEnwiEnTElEIKLRKI5OjHukJ3FXCsyCtklrYtoVPJ+
         YtFbCI6dBBA08lzREy/DwqehSrP2BhHajL8JsNXQ8iyPLGJTyZhWcOSmZ4R6Zq4QIp
         FyCMT3t239HY/1qYydGXmb/peNXNc/CBw+b6hONw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB68B60364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: Fix channel info parsing for non tlv target
References: <1552044366-9186-1-git-send-email-pillair@codeaurora.org>
Date:   Tue, 30 Jul 2019 11:40:06 +0300
In-Reply-To: <1552044366-9186-1-git-send-email-pillair@codeaurora.org> (Rakesh
        Pillai's message of "Fri, 8 Mar 2019 16:56:06 +0530")
Message-ID: <87ftmnncex.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> writes:

> The tlv targets such as WCN3990 send more data in
> the chan info event, which is not sent by the non tlv
> targets. There is a minimum size check in the wmi event for
> non-tlv targets and hence we cannot update the common
> channel info structure.
>
> If the common channel info structure is updated, the
> size check for chan info event for non-tlv targets
> will fail and return -EPROTO and we see the below
> error messages
>
>    ath10k_pci 0000:01:00.0: failed to parse chan info event: -71
>
> Add tlv specific channel info structure and restore the
> original size of the common channel info structure to
> mitigate this issue.
>
> Tested HW: WCN3990
> 	   QCA9887
> Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
> 	   10.2.4-1.0-00037
>
> Fixes: 13104929d2ec ("ath10k: fill the channel survey results for WCN3990 correctly")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>

I'll queue this v5.3, and also for stable v5.0 and later.

-- 
Kalle Valo
