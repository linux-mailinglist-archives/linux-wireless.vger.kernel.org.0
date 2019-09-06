Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE51AB96D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392015AbfIFNjN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 09:39:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53460 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbfIFNjN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 09:39:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A00E2607F4; Fri,  6 Sep 2019 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567777152;
        bh=6nu1aGMoajykVnqmVIOIIQO2E0+aSq916ZcqlLEl8Iw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=A9oNTYYREukFQsov6HmusvPv1na/N4vyYPzfp7aTZgwnLd1Zs4QEUmdtJH4zTTfnV
         40NfHypY6AnM3QdaOr/3jwfSv02p3QAgbLN2vsnHAeBi1iA6s6GujlB713/JQVNQ0L
         EuxMeq9T8swuv1qibvaBrKQdC6AUTMUVflZCw4yk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-130-177-42.bb.dnainternet.fi [37.130.177.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F295602EE;
        Fri,  6 Sep 2019 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567777152;
        bh=6nu1aGMoajykVnqmVIOIIQO2E0+aSq916ZcqlLEl8Iw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=A9oNTYYREukFQsov6HmusvPv1na/N4vyYPzfp7aTZgwnLd1Zs4QEUmdtJH4zTTfnV
         40NfHypY6AnM3QdaOr/3jwfSv02p3QAgbLN2vsnHAeBi1iA6s6GujlB713/JQVNQ0L
         EuxMeq9T8swuv1qibvaBrKQdC6AUTMUVflZCw4yk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F295602EE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2019-09-05
References: <9ff2d7b9-e014-ba60-5872-289765ac3a7f@nbd.name>
Date:   Fri, 06 Sep 2019 16:39:06 +0300
In-Reply-To: <9ff2d7b9-e014-ba60-5872-289765ac3a7f@nbd.name> (Felix Fietkau's
        message of "Thu, 5 Sep 2019 18:16:28 +0200")
Message-ID: <87d0gdy26d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> here's my first pull request for 5.4
>
> - Felix
>
> The following changes since commit 84b0b66352470e6491c06159735ac916dc69a2ef:
>
>   zd1211rw: zd_usb: Use struct_size() helper (2019-09-03 16:45:35 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2019-09-05
>
> for you to fetch changes up to 0e6a29e477f3905ceba37d5ec545e5927e047bc4:
>
>   mt76: mt7615: add support to read temperature from mcu (2019-09-05 18:14:15 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.4
>
> * beacon tx fix for mt76x02
> * sparse/checkpatch warning fixes
> * DFS pattern detector for mt7615 (DFS channels not enabled yet)
> * CSA support for mt7615
> * mt7615 cleanup/fixes
> * mt7615 rate control improvements
> * usb fixes
> * mt7615 powersave buffering fix
> * new device support for mt76x0
> * support for more ciphers in mt7615
> * watchdog time fixes
> * smart carrier sense on mt7615
> * survey support on mt7615
> * multiple interfaces on mt76x02u
> * calibration data fix for mt7615
> * fix for sending BAR after disassoc
>
> ----------------------------------------------------------------

Pulled, thanks Felix.

-- 
Kalle Valo
