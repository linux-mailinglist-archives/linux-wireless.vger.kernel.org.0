Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5DFDA7B49
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 08:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfIDGNW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 02:13:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55230 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbfIDGNW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 02:13:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 54C0A6118E; Wed,  4 Sep 2019 06:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567577601;
        bh=Bzr7GV/vsaoAzgoLcUfbasrbeMk+z0lW/qGH4iW8M3Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PxvkHReWW58pibpfBcAsf64/gF9IfEWOzL821MA2Wb5UX+q5aDLnzMDT1IPRiXXKy
         0BSGLrZcflc3VHAdZNa5OqtVExlCYWvJle7O1y7wrhcLNTNkF7F2NttjVDeqn7rohF
         VRnzycNPvpTBX/SrZNU3ungvB6JJ6R+tsCJ8frjg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2309D60863;
        Wed,  4 Sep 2019 06:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567577600;
        bh=Bzr7GV/vsaoAzgoLcUfbasrbeMk+z0lW/qGH4iW8M3Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Hq/uoPpJVTq+SJVj/2p1SZkDwjlj4KCrs9ynY+B5Er3zCxUcExJCuaEaPyL55aRU6
         7sYXSHoQodwpoSZndtrFSqjyPN8CPyM/+dzb+fFT409fBpu0pJIokyS7uLhyGcMo2B
         QIWM1mTZaAeUpK9zUSAsJDDTk+i+mnFR/qq51ePY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2309D60863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] ath9k: add loader for AR92XX (and older) pci(e)
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190705175313.19482-1-chunkeey@gmail.com>
References: <20190705175313.19482-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org,
        Julian Calaby <julian.calaby@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190904061321.54C0A6118E@smtp.codeaurora.org>
Date:   Wed,  4 Sep 2019 06:13:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> Atheros cards with a AR92XX generation (and older) chip usually
> store their pci(e) initialization vectors on an external eeprom chip.
> However these chips technically don't need the eeprom chip attached,
> the AR9280 Datasheet in section "6.1.2 DEVICE_ID" describes that
> "... if the EEPROM content is not valid, a value of 0xFF1C returns
> when read from the register". So, they will show up on the system's
> pci bus. However in that state, ath9k can't load, since it relies
> on having the correct pci-id, otherwise it doesn't know what chip it
> actually is. This happens on many embedded devices like routers
> and accesspoint since they want to keep the BOM low and store the
> pci(e) initialization vectors together with the calibration data
> on the system's FLASH, which is out of reach of the ath9k chip.
> 
> Furthermore, Some devices (like the Cisco Meraki Z1 Cloud Managed
> Teleworker Gateway) need to be able to initialize the PCIe wifi device.
> Normally, this should be done as a pci quirk during the early stages of
> booting linux. However, this isn't possible for devices which have the
> init code for the Atheros chip stored on NAND in an UBI volume.
> Hence, this module can be used to initialize the chip when the
> user-space is ready to extract the init code.
> 
> Martin Blumenstingl prodived the following fixes:
> owl-loader: add support for OWL emulation PCI devices
> owl-loader: don't re-scan the bus when ath9k_pci_fixup failed
> owl-loader: use dev_* instead of pr_* logging functions
> owl-loader: auto-generate the eeprom filename as fallback
> owl-loader: add a debug message when swapping the eeprom data
> owl-loader: add missing newlines in log messages
> 
> Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5a4f2040fd07 ath9k: add loader for AR92XX (and older) pci(e)

-- 
https://patchwork.kernel.org/patch/11033133/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

