Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE47164D8
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 15:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEGNos (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 09:44:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfEGNos (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 09:44:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F46760AA8; Tue,  7 May 2019 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557236687;
        bh=5+/CuPZbzgEEDoJkq+RXNhVRlIWuk3/hjSsNj+NCNLA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DCKo2cEOR9hK/0XqV98hMP0MIM3SsMvJEsWdizALA/5nWvrMBXtwxnzOlFHw+KX20
         7rWx9KbCw+s81K/Z4tSlr4vI2oGZPpfir/C4mFk9LOlrhEnCn1TJD2hUMft1hqGFoD
         39YwJL68BEpKO2gJvbIowjqRYykpU+mo/tUF/rl8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 395B2608FC;
        Tue,  7 May 2019 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557236687;
        bh=5+/CuPZbzgEEDoJkq+RXNhVRlIWuk3/hjSsNj+NCNLA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=D9cEawQDeV4pNIzwfwMWBVd6wEO5UF3N/kVdQ4mOVJgcjC0xPGwrmYM3mw+O3Wvaf
         BDbNmFOWXyF6djE22GiZyU2WmR30LlE9AAjBLAgdVH/4FBzx7zOilZGqkaovzBhdGc
         4DLt7vj1TuPIpaykG9fT0BMU/1IvFTaKE+EWMlDg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 395B2608FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: rx_duration update for fw_stats debugfs entry
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1552389470-28405-1-git-send-email-bpothuno@codeaurora.org>
References: <1552389470-28405-1-git-send-email-bpothuno@codeaurora.org>
To:     Balaji Pothunoori <bpothuno@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Balaji Pothunoori <bpothuno@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190507134447.7F46760AA8@smtp.codeaurora.org>
Date:   Tue,  7 May 2019 13:44:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Balaji Pothunoori <bpothuno@codeaurora.org> wrote:

> Currently instant rx_duration always fetching as zero
> in fw_stats debugfs entry if extended peer stats event
> supports.
> 
> This patch updates instant rx_duration in fw_stats entry
> based on extended peer stats and maintaining backward
> compatibility for 10.2/10.x.
> 
> Tested HW: QCA9984.
> Tested FW: 10.4-3.6.0.1-00004.
> 
> Signed-off-by: Balaji Pothunoori <bpothuno@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5c51875c0943 ath10k: rx_duration update for fw_stats debugfs entry

-- 
https://patchwork.kernel.org/patch/10849119/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

