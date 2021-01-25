Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FEC30266B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbhAYOoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 09:44:03 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:64227 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbhAYOnW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 09:43:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611585783; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=N1G8HgYx4yjCIsYOGEiep9cAWYxAMa8NN2xd/w9uiZU=;
 b=FX2PG7ADXA1z2lfAgU5Y51q8QiyvxzkwS9N5D/RP72G+kBXuexu9+YxD9MZ5cXEx/d92IxIu
 xKvenO6uRVg6CA9z8ihKaBANL+GuMnW7EmB6dWn+JHBUJ9F/wCtZPdRzkg4XOfejoRO5OIsm
 OAklUsIvyMaWVvvURZwyxK8TnVQ=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 600ed8d82c36b2106d087e51 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Jan 2021 14:42:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D884C433ED; Mon, 25 Jan 2021 14:42:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3FFCC433CA;
        Mon, 25 Jan 2021 14:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3FFCC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2 ] wlcore: Fix command execute failure 19 for wl12xx
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210115065613.7731-1-tony@atomide.com>
References: <20210115065613.7731-1-tony@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        Raz Bouganim <r-bouganim@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210125144231.8D884C433ED@smtp.codeaurora.org>
Date:   Mon, 25 Jan 2021 14:42:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote:

> We can currently get a "command execute failure 19" error on beacon loss
> if the signal is weak:
> 
> wlcore: Beacon loss detected. roles:0xff
> wlcore: Connection loss work (role_id: 0).
> ...
> wlcore: ERROR command execute failure 19
> ...
> WARNING: CPU: 0 PID: 1552 at drivers/net/wireless/ti/wlcore/main.c:803
> ...
> (wl12xx_queue_recovery_work.part.0 [wlcore])
> (wl12xx_cmd_role_start_sta [wlcore])
> (wl1271_op_bss_info_changed [wlcore])
> (ieee80211_prep_connection [mac80211])
> 
> Error 19 is defined as CMD_STATUS_WRONG_NESTING from the wlcore firmware,
> and seems to mean that the firmware no longer wants to see the quirk
> handling for WLCORE_QUIRK_START_STA_FAILS done.
> 
> This quirk got added with commit 18eab430700d ("wlcore: workaround
> start_sta problem in wl12xx fw"), and it seems that this already got fixed
> in the firmware long time ago back in 2012 as wl18xx never had this quirk
> in place to start with.
> 
> As we no longer even support firmware that early, to me it seems that it's
> safe to just drop WLCORE_QUIRK_START_STA_FAILS to fix the error. Looks
> like earlier firmware got disabled back in 2013 with commit 0e284c074ef9
> ("wl12xx: increase minimum singlerole firmware version required").
> 
> If it turns out we still need WLCORE_QUIRK_START_STA_FAILS with any
> firmware that the driver works with, we can simply revert this patch and
> add extra checks for firmware version used.
> 
> With this fix wlcore reconnects properly after a beacon loss.
> 
> Cc: Raz Bouganim <r-bouganim@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied to wireless-drivers-next.git, thanks.

cb88d01b6738 wlcore: Fix command execute failure 19 for wl12xx

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210115065613.7731-1-tony@atomide.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

