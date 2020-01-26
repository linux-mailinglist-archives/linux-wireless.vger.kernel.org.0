Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36311149B6D
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 16:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgAZPeS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 10:34:18 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:64872 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725907AbgAZPeR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 10:34:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580052857; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=1gQyC1rfazrpNX6/BX62FITRwONug1muuMvvNB+5Z14=;
 b=nO84hQbJ/sPvR/CP1nxHgAoM6E+fpG3cwIvI5LsoMBDRDiIeedgKiSwqrIMZPZEGA4wFIdy+
 D0Nff2SNpdULlF5bPyjfGiGa7ZfHTNqj9p7ea3YwfzzUxT0xIrAgPZ4vN2IWiaznOyrsoZvO
 5pW1IsM9o3ocaUZqRkl+cRhAR/w=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2db178.7f7055e30bc8-smtp-out-n02;
 Sun, 26 Jan 2020 15:34:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91B4DC4479C; Sun, 26 Jan 2020 15:34:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D32BC433CB;
        Sun, 26 Jan 2020 15:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D32BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers-next 1/1] wlcore: mesh: Add support for
 RX Broadcast Key
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200116143353.7541-2-hnagalla@gmail.com>
References: <20200116143353.7541-2-hnagalla@gmail.com>
To:     Hari Nagalla <hnagalla@gmail.com>
Cc:     linux-wireless@vger.kernel.org, mailtalm@ti.com, hnagalla@gmail.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126153416.91B4DC4479C@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 15:34:16 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hari Nagalla <hnagalla@gmail.com> wrote:

> From: Maital Hahn <maitalm@ti.com>
> 
> In order to support authentication of equals peers,
> need to save RX Broadcast key per peer (on top of 1 TX broadcast key
> and unicast key per peer).
> 
> Signed-off-by: Maital Hahn <maitalm@ti.com>
> Acked-by: Guy Mishol <guym@ti.com>
> Signed-off-by: Hari Nagalla <hnagalla@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

cf33a7728bf2 wlcore: mesh: Add support for RX Broadcast Key

-- 
https://patchwork.kernel.org/patch/11337165/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
