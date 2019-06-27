Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92AC5894D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 19:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF0Rvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 13:51:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0Rvj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 13:51:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DA0C660A05; Thu, 27 Jun 2019 17:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561657898;
        bh=P5S5RT4RC03IdWV+4IPcxZGfvJQ1YXxxeZHHSea2RM0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OCtHf2ZOW1fkEbBmQoXivdkmZH6O2Htezy4U8wlTcdvKqfQzIaT04UcS0c/hrMMuS
         hXa618POpE7Ipn21rfKeB/F/yV5Ih/Me0Wi+BBF9Cc3kJD5vRgIDb0XBxN5u8B1S7Z
         YnOhulnL17HYrpJtz0jXd/kfjVeQhMbXvbHGJ6f4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 483A86016D;
        Thu, 27 Jun 2019 17:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561657898;
        bh=P5S5RT4RC03IdWV+4IPcxZGfvJQ1YXxxeZHHSea2RM0=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=eFpLntRjubyAlPgxuWHfnnt+qLSKoyT6DPn78NhISJV4mY+dPRGal0+GZi/jt1n5E
         aiTa03k+Dhnvz7FmPZmDVsyipn3Fz9oUtXNzmL8rhS+ufh2wTMNo7dnmnVFouAkrGx
         jPmzGBnNJlnvtHFx6cRicOILbVts2cjyObIu1S08=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 483A86016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/11] wil6210: do not reset FW in STA to P2P client
 interface switch
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1560669967-23706-2-git-send-email-merez@codeaurora.org>
References: <1560669967-23706-2-git-send-email-merez@codeaurora.org>
To:     Maya Erez <merez@codeaurora.org>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190627175138.DA0C660A05@smtp.codeaurora.org>
Date:   Thu, 27 Jun 2019 17:51:38 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maya Erez <merez@codeaurora.org> wrote:

> Currently the FW is reset on every interface type change, because
> of various FW bugs.
> FW reset is not required when switching from STA to P2P client, hence
> can be skipped.
> 
> Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

11 patches applied to ath-next branch of ath.git, thanks.

b913e33076c8 wil6210: do not reset FW in STA to P2P client interface switch
c903ece596cb wil6210: enlarge Tx status ring size
96b77bb04470 wil6210: increase the frequency of status ring hw tail update
c5b3a6582b1e wil6210: Add support for setting RBUFCAP configuration
dedec35b4019 wil6210: fix printout in wil_read_pmccfg
f2b6b46e483b wil6210: clear FW and ucode log address
c478ac9daae6 wil6210: update cid boundary check of wil_find_cid/_by_idx()
3e7ee09d36a6 wil6210: publish max_msdu_size to FW on BCAST ring
9b586118730e wil6210: add support for reading multiple RFs temperature via debugfs
2a32c20b76af wil6210: set WIL_WMI_CALL_GENERAL_TO_MS as wmi_call timeout
1a276003111c wil6210: drop old event after wmi_call timeout

-- 
https://patchwork.kernel.org/patch/10997287/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

