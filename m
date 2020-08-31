Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CED257D00
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgHaPcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 11:32:46 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:56394 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729005AbgHaPca (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 11:32:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598887949; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=k1+lvSXAnBPpsSpkOapA/TLL3f9X50Un2lXUOaCwgts=;
 b=rheblRCPk2D3045hJxCvAbkdNQ90zTVic6vLeQ9rd5YsJxpFPBoE7bonu/D3bXoqqsPABCC3
 n+N+K4vsS32EmVI3fnI+04UTWu7WS/FUtkrcnM8O/MvfBa1Pc4WIhCqPycEGOhf8V8c3WUwL
 o0scaHWNCVQSV1LgNcKGZXNeFjM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f4d18049bdf68cc03670aea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Aug 2020 15:32:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B779FC433AF; Mon, 31 Aug 2020 15:32:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD00EC433AF;
        Mon, 31 Aug 2020 15:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD00EC433AF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 14/15] rtlwifi: rtl8821ae: Rename RT_TRACE to rtl_dbg
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200829005442.32318-2-Larry.Finger@lwfinger.net>
References: <20200829005442.32318-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200831153219.B779FC433AF@smtp.codeaurora.org>
Date:   Mon, 31 Aug 2020 15:32:19 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> Change the misleading macro name to one that is more descriptive for
> rtl8821ae. Changes suggested by ckeckpatch.pl have been made.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Fails to link:

ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192ee/rtl8192ee.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8821ae/rtl8821ae.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8723com/rtl8723-common.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/btcoexist/btcoexist.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rtl8188ee.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8723be/rtl8723be.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rtl8723ae.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192de/rtl8192de.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192se/rtl8192se.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rtl8192cu.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192ce/rtl8192ce.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl8192c/rtl8192c-common.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl_usb.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtl_pci.ko] undefined!
ERROR: modpost: "_rtl_dbg_out" [drivers/net/wireless/realtek/rtlwifi/rtlwifi.ko] undefined!
make[1]: *** [Module.symvers] Error 1
make[1]: *** Deleting file 'Module.symvers'
make: *** [modules] Error 2

2 patches set to Changes Requested.

11743855 [v3,14/15] rtlwifi: rtl8821ae: Rename RT_TRACE to rtl_dbg
11743853 [v3,15/15] rtlwifi: Remove temporary definition of RT_TRACE

-- 
https://patchwork.kernel.org/patch/11743855/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

