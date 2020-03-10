Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D7617FE63
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2020 14:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgCJNe6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Mar 2020 09:34:58 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35151 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbgCJNe5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Mar 2020 09:34:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583847297; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=hZ1Zn3qwS0GPQkSP+gMjccSMKLLOlSVGtEl8Fe/6Tcc=; b=Nm0dObcDDTd/ztqEp0VwR8Ly8S+FO6gJMWtQWUX1va/uvVwLD7d1GltbO60MDVy3lQQnOxNu
 pzoaeRQ5W/fQA+o+v/sL+nenGi4SUpIT9JxVCGv0/x0FLF80QRPqlCqrhhXedWKvzsw0BUb+
 XamMxtA3X7npWISnIs3XvN5TKwg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e679779.7f2df82590a0-smtp-out-n05;
 Tue, 10 Mar 2020 13:34:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 795F6C4478C; Tue, 10 Mar 2020 13:34:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2AE9EC433BA;
        Tue, 10 Mar 2020 13:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AE9EC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Subject: Re: pull-request: iwlwifi-fixes for v5.6 2020-03-08
References: <1ba480ddb338627ef453e32d03a238ffcdff6068.camel@coelho.fi>
Date:   Tue, 10 Mar 2020 15:34:43 +0200
In-Reply-To: <1ba480ddb338627ef453e32d03a238ffcdff6068.camel@coelho.fi> (Luca
        Coelho's message of "Sun, 08 Mar 2020 10:38:57 +0200")
Message-ID: <87v9ncnxjg.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's the first batch of fixes intended for v5.6.  This includes the
> patch series I sent a couple of days ago.  More details about the
> contents in the tag description.
>
> I pushed this to my pending branch but didn't get any results from
> kbuildbot yet.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit b102f0c522cf668c8382c56a4f771b37d011cda2:
>
>   mt76: fix array overflow on receiving too many fragments for a packet (2020-03-03 17:30:25 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-fixes.git tags/iwlwifi-for-kalle-2020-03-08
>
> for you to fetch changes up to 9352ed0165ff4313ab340c979446c3d64c531f7a:
>
>   iwlwifi: cfg: use antenna diversity with all AX101 devices (2020-03-06 15:26:33 +0200)
>
> ----------------------------------------------------------------
> First batch of fixes intended for v5.6
>
> * Fix a locking issue in time events handling;
> * A fix in rate-scaling;
> * Fix for a potential NULL pointer deref;
> * Enable antenna diversity in some devices that were erroneously not
>   doing it;
> * Allow FW dumps to continue when the FW is stuck;
> * A fix in the HE capabilities handling;
> * Another fix for FW dumps where we were reading wrong addresses.
>
> ----------------------------------------------------------------

Pulled, thanks Luca.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
