Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4B35AF91
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2019 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfF3Jag (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jun 2019 05:30:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3Jag (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jun 2019 05:30:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B03D6083E; Sun, 30 Jun 2019 09:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561887035;
        bh=BUy9Z0b2NevtsPnaqr0weFyBIAceVJ1ANq1Rb6C70tU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kSPSvSW0Wo02qt73mfHyhmFBl53MxJsTln0OvFR5S5GTIS0U7JjC3IwaBz0FpLhnN
         Y46lDj5J/TDIIdlqI4IqSlV3vVvnI7bx9Bd2ulQ9W51RzSdKiijHohyLWfD8zPpkpk
         YRRmV5kr3djQ1Wt+Ppdy7U4FxNFVZdnjeVfihocQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-112-134-nat.elisa-mobile.fi [85.76.112.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FC5060300;
        Sun, 30 Jun 2019 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561887035;
        bh=BUy9Z0b2NevtsPnaqr0weFyBIAceVJ1ANq1Rb6C70tU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kSPSvSW0Wo02qt73mfHyhmFBl53MxJsTln0OvFR5S5GTIS0U7JjC3IwaBz0FpLhnN
         Y46lDj5J/TDIIdlqI4IqSlV3vVvnI7bx9Bd2ulQ9W51RzSdKiijHohyLWfD8zPpkpk
         YRRmV5kr3djQ1Wt+Ppdy7U4FxNFVZdnjeVfihocQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FC5060300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2019-06-27
References: <a0e08791-e4e0-6772-751c-be05a4d25d8c@nbd.name>
Date:   Sun, 30 Jun 2019 12:30:30 +0300
In-Reply-To: <a0e08791-e4e0-6772-751c-be05a4d25d8c@nbd.name> (Felix Fietkau's
        message of "Thu, 27 Jun 2019 13:03:00 +0200")
Message-ID: <87muhzqv2h.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my first pull request for 5.3
>
> - Felix
>
> The following changes since commit e5db0ad7563c38b7b329504836c9a64ae025a47a:
>
>   airo: switch to skcipher interface (2019-06-25 08:12:20 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2019-06-27
>
> for you to fetch changes up to 676fabd1d2f089f9fb8bece3476c2ab5584b4a1a:
>
>   mt76: mt7603: fix sparse warnings: warning: incorrect type in assignment (different base types) (2019-06-27 12:59:07 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.3
>
> * use NAPI polling for tx cleanup on mt7603/mt7615
> * various fixes for mt7615
> * unify some code between mt7603 and mt7615
> * fix locking issues on mt76x02
> * add support for toggling edcca on mt7603
> * fix reading target tx power with ext PA on mt7603/mt7615
> * fix initalizing channel maximum power
> * fix rate control / tx status reporting issues on mt76x02/mt7603
> * add support for eeprom calibration data from mtd on mt7615
> * support configuring tx power on mt7615
> * fix external PA support on mt76x0
> * per-chain signal reporting on mt7615
> * rx/tx buffer fixes for USB devices
>
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Kalle Valo
