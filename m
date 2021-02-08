Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DD931334F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 14:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhBHNa6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 08:30:58 -0500
Received: from so15.mailgun.net ([198.61.254.15]:61535 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhBHNap (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 08:30:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612791027; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=wW+ovX0j9NCHrcswrYPNeqnjUtDF+zzU1fp/jCvrAKY=; b=VTzGpNZRZ3oh+Ly6lZkgSsnDYmgUx2eq/1oqdkV0lFKhxSnL56lMOVi7lK1oKbcx+ADZlg5n
 Bb3+PawDHysBECQOE0ok/r8ct4MrVCE0Ibwv8GETZLmyu35966F5XibHOMKXJiaDB9MRCfeU
 gN881cNFxE56EEpkxN/MNO8BcIA=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60213cc93919dfb455ee4ea5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 13:29:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A3C2C433CA; Mon,  8 Feb 2021 13:29:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F65FC433ED;
        Mon,  8 Feb 2021 13:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F65FC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 08/12] iwlwifi: pcie: add CDB bit to the device configuration parsing
References: <20210208124847.1934441-1-luca@coelho.fi>
        <iwlwifi.20210208144305.f93bec1cf3f3.I3bb2cf9b9afb0457583f786dc52d4d1b1ad75ffc@changeid>
Date:   Mon, 08 Feb 2021 15:29:41 +0200
In-Reply-To: <iwlwifi.20210208144305.f93bec1cf3f3.I3bb2cf9b9afb0457583f786dc52d4d1b1ad75ffc@changeid>
        (Luca Coelho's message of "Mon, 8 Feb 2021 14:48:43 +0200")
Message-ID: <875z32662i.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Matti Gottlieb <matti.gottlieb@intel.com>
>
> Some new devices contain and extra bit in the CRF ID register to
> denote

s/and/an/?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
