Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F892A69D9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 17:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgKDQeD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 11:34:03 -0500
Received: from z5.mailgun.us ([104.130.96.5]:61889 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbgKDQeC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 11:34:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604507642; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=9g398sYCus/6pchotAT4Q21ccbvaxHY6VWW1VZCOQ7s=; b=skv4vRTasAPj+M6oTX8qeC05wjjaOkdJvfXIPSyUBcnBIoTDveZusf4uRuF7m2bocF5jv9ey
 tyZ6QSjM9rDom0boYR9pQw62VnIr5ATDnbiO+/79qCelMHMIEnKNIGKX1AUMRAGW5AY/gpt4
 B+qd+07J9MJQT/UG21ZxOer/o5c=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fa2d7dc8dd4beedee96a1e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 16:33:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15C3FC433C9; Wed,  4 Nov 2020 16:33:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D65AC433C8;
        Wed,  4 Nov 2020 16:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D65AC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ath11k: QCA6390 support on Linux
References: <87r1r4nukq.fsf@codeaurora.org>
Date:   Wed, 04 Nov 2020 18:33:28 +0200
In-Reply-To: <87r1r4nukq.fsf@codeaurora.org> (Kalle Valo's message of "Mon, 14
        Sep 2020 20:20:53 +0300")
Message-ID: <87mtzxqdyf.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> some of the Dell XPS 15 9500 models have QCA6390 Wi-Fi 6 device. ath11k
> will be the driver to support QCA6390 and the plan is that Linux v5.10
> (most likely released end of December) will be the first release to
> support it.
>
> But as everything is not ready yet I recommend people to test
> ath11k-qca6390-bringup branch, and specifically tag
> ath11k-qca6390-bringup-202008181507. Below are instructions how to
> install kernel and firmware.
>
> Do note that this is still experimental, there will be bugs but at least
> it should be possible to connect to an AP and have connectivity.
>
> Please send all questions, comments and bug reports to
> ath11k@lists.infradead.org list. I do not have time to reply to private
> email. I have Bcced people who have contacted me privately.

Some updates:

* QCA6390 support is now in v5.10-rc2

* pull request to linux-firmware sent, not yet pulled

* board-2.bin should be now used instead of board.bin

* there was some reorganisation in ath11k-firmware

Here are updated instructions on how to test ath11k:

# clone kernel
git clone -b v5.10-rc2 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

# clone firmware
git clone https://github.com/kvalo/ath11k-firmware.git

# Ensure below options are selected in the kernel
cd linux
make menuconfig
--> Select Device drivers
	--> Network device support
		--> Wireless LAN
			--> Enable as below
				<M> Qualcomm Technologies 11ax chipset support
				<M>       Atheros ath11k PCI support
				[*]       QCA ath11k debugging
				[*]       QCA ath11k debugfs support
				[*]       ath11k tracing support
				[*]     QCA ath11k spectral scan support

# Build and install the kernel and kernel modules

# Install firmware
cd ../ath11k-firmware
sudo mkdir -p /lib/firmware/ath11k/QCA6390/hw2.0/
sudo cp QCA6390/hw2.0/1.0.1/WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1/*.bin /lib/firmware/ath11k/QCA6390/hw2.0/
sudo cp QCA6390/hw2.0/board-2.bin /lib/firmware/ath11k/QCA6390/hw2.0/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
