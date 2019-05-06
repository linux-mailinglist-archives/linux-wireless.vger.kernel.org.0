Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7136F146BD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 10:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEFIsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 04:48:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50588 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFIsq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 04:48:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 79D93607B9; Mon,  6 May 2019 08:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557132525;
        bh=cIyZQv7s3OiUpByuX8bv38ZcAkFQrQ+TiDmlgJT2lJs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eeSB8pUINf4NLJ4Lf+kO9OExZRshoaTqnHrxNhVmzW1fhtLBB3uAOmA5+pksQ5Z8U
         J79u8JzDB7yXMh5aL9mKaZLzdkidZ/HneUnaeFM1DUm5FORmtydMQembNZbpb/w5Q0
         +sVBtoYf86ZGfRv20OQ+QpEbvH7qmWCz0Rq17gHI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2124602DC;
        Mon,  6 May 2019 08:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557132525;
        bh=cIyZQv7s3OiUpByuX8bv38ZcAkFQrQ+TiDmlgJT2lJs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eeSB8pUINf4NLJ4Lf+kO9OExZRshoaTqnHrxNhVmzW1fhtLBB3uAOmA5+pksQ5Z8U
         J79u8JzDB7yXMh5aL9mKaZLzdkidZ/HneUnaeFM1DUm5FORmtydMQembNZbpb/w5Q0
         +sVBtoYf86ZGfRv20OQ+QpEbvH7qmWCz0Rq17gHI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2124602DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] rtw88: fix unassigned rssi_level in rtw_sta_info
References: <1556884415-23474-1-git-send-email-yhchuang@realtek.com>
        <1556884415-23474-5-git-send-email-yhchuang@realtek.com>
Date:   Mon, 06 May 2019 11:48:41 +0300
In-Reply-To: <1556884415-23474-5-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 3 May 2019 19:53:34 +0800")
Message-ID: <874l68vuhi.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> The new rssi_level should be stored in si, otherwise the rssi_level will
> never be updated and get a wrong RA mask, which is calculated by the
> rssi level
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Stanislaw suggested that this should go to 5.2. So what breaks from
user's point of view if this is not applied?

-- 
Kalle Valo
