Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7326C2692FC
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 19:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgINRVW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Sep 2020 13:21:22 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:25889 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgINRVA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Sep 2020 13:21:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600104059; h=Content-Type: MIME-Version: Message-ID: Date:
 Subject: Cc: To: From: Sender;
 bh=RSw3vjlk3fh9S8oHc/dW9zUa+eld+hQ9LSaVFkbsWrc=; b=sHXH9okvN2xtMv07NU2VMYQqomjTLzOMFXUKQFT5p3/O2O7j6JtC3jJYF+DfTvgCpBVpxY8U
 4LqxpWk6uAot8aAtqsDJUtYBvaqhO1ueQ0tIQiHwrF1H/6dLNn7pQ+E5MmdftRAdsrlkMxO0
 No3eq8WHU3GlUClUrGn/ph/8m+Y=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f5fa679252c522440f0ea21 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 17:20:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84E5BC433FF; Mon, 14 Sep 2020 17:20:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        LOCALPART_IN_SUBJECT,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92C51C433FE;
        Mon, 14 Sep 2020 17:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92C51C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ath11k: QCA6390 support on Linux
Date:   Mon, 14 Sep 2020 20:20:53 +0300
Message-ID: <87r1r4nukq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

some of the Dell XPS 15 9500 models have QCA6390 Wi-Fi 6 device. ath11k
will be the driver to support QCA6390 and the plan is that Linux v5.10
(most likely released end of December) will be the first release to
support it.

But as everything is not ready yet I recommend people to test
ath11k-qca6390-bringup branch, and specifically tag
ath11k-qca6390-bringup-202008181507. Below are instructions how to
install kernel and firmware.

Do note that this is still experimental, there will be bugs but at least
it should be possible to connect to an AP and have connectivity.

Please send all questions, comments and bug reports to
ath11k@lists.infradead.org list. I do not have time to reply to private
email. I have Bcced people who have contacted me privately.

Kalle

# clone kernel
git clone -b ath11k-qca6390-bringup-202008181507 https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

# Tag ath11k-qca6390-bringup-202008181507 uses v5.9-rc1 as the baseline
# which has a regression in nvme subsystem, so this nvme patch might be
# needed as well:
# http://git.infradead.org/nvme.git/commitdiff/286155561ecd13b6c85a78eaf2880d3baea03b9e

# clone firmware
git clone https://github.com/kvalo/ath11k-firmware.git

# Ensure below options are selected in the kernel
cd ath
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
sudo cp QCA6390/hw2.0/WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1/*.bin /lib/firmware/ath11k/QCA6390/hw2.0/
sudo cp QCA6390/hw2.0/WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1/bdwlan.e04 /lib/firmware/ath11k/QCA6390/hw2.0/board.bin

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
