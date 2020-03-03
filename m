Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C67177AA6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgCCPig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 10:38:36 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:52184 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727079AbgCCPif (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 10:38:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583249915; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=xMbcRFa1lupH2RVlOWB+oT2CKMT8BSb25UxqgOLfzPY=; b=RR5v4h6SIjQAmyar56KNbOzY3Tfebg6lTr5DVEtLWo6c5gf85RydxlGFwyWrTs1/nQtnAQZs
 1kEpfjzclhzqhSpHDyPHHdVgiy6o4C2UawGmVwI+F0p+yfBpLyZljs6rOecE7pdCRjvylwKE
 CHGLqvWMPZrzz6JFPjGAY94aL3E=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5e79e8.7fde1a6d6ca8-smtp-out-n02;
 Tue, 03 Mar 2020 15:38:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 97E6DC447A2; Tue,  3 Mar 2020 15:38:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A9C7C433A2;
        Tue,  3 Mar 2020 15:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A9C7C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2019-02-14 v2
References: <fa565f39-c10d-4b94-ba92-3cab33f77322@nbd.name>
Date:   Tue, 03 Mar 2020 17:38:12 +0200
In-Reply-To: <fa565f39-c10d-4b94-ba92-3cab33f77322@nbd.name> (Felix Fietkau's
        message of "Fri, 14 Feb 2020 18:57:23 +0100")
Message-ID: <87lfohqwij.fsf@kamboji.qca.qualcomm.com>
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
> here's v2 of my first pull request for 5.7. Fixed the version number
> in the tag, otherwise unchanged.
>
> - Felix
>
> The following changes since commit aa7619a39acef91c5a6904f3ada7d0f20e2ad25e:
>
>   rtw88: Fix incorrect beamformee role setting (2020-02-13 12:07:25 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-02-14
>
> for you to fetch changes up to 0987295750574adc59999b8fb9890834574bc4e2:
>
>   mt76: Introduce mt76_mcu data structure (2020-02-14 10:17:46 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.7
>
> * dual-band concurrent support for MT7615
> * fixes for rx path race conditions
> * EEPROM fixes
> * MAC address handling fixes
> * coverage class support for MT7615
> * beacon fixes for USB devices
> * MT7615 LED support
> * minor cleanups/fixes for all drivers
> * set_antenna support for MT7615
> * tracing improvements
> * preparation for supporting new USB devices
> * tx power fixes
>
> ----------------------------------------------------------------

Pulled, thanks Felix.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
