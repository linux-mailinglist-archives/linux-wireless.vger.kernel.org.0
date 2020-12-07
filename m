Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10412D154B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 16:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgLGP51 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 10:57:27 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:63252 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgLGP51 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 10:57:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607356623; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vzDoBw8yc1eNXdNtGBHeySDIcVRoc9tcVqYzMoIBofA=;
 b=c8WP0LSHxyuhwQm1oe1wf7AA061Kep7iF6xYPXzR/0nHbHLRMgVJkvC/p81EODu/1uzgUsbE
 VoQ9hVvdMln266/XXRtuM6n0+dlexrwn7LPVgx+oyPGiqhi0smi2n9O+tthmZADcB2AAkEq3
 iD9DQY/POYRcbcr4TjTIW9XErVA=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fce50c996285165cd82e212 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 15:56:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 04E36C433CA; Mon,  7 Dec 2020 15:56:57 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8CE34C433C6;
        Mon,  7 Dec 2020 15:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CE34C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/1] ath10k_pci_wait_for_target_init() should relax cpu
 for
 other task instead of calling medelay() so that cpu can run other tasks.
 Signed-off-by: lzhou <lzhou@sonicwall.com> ---
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201203033729.382088-2-zhouliangya@126.com>
References: <20201203033729.382088-2-zhouliangya@126.com>
To:     zhouliangya@126.com
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        lzhou <zhouliangya@126.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201207155657.04E36C433CA@smtp.codeaurora.org>
Date:   Mon,  7 Dec 2020 15:56:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

zhouliangya@126.com wrote:

> From: lzhou <zhouliangya@126.com>

The subject and commit log is badly formatted, see patchwork link below.
But how is schedule_timeout_interruptible() better than msleep()?

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201203033729.382088-2-zhouliangya@126.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

