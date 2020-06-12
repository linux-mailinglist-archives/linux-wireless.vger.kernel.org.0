Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD981F74DA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2020 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgFLHyg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jun 2020 03:54:36 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:30331 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbgFLHyf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jun 2020 03:54:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591948475; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=TAQa8pz/uhCFETvqXcv51ctZVhrbd+jQyrZTWQ8xwOM=; b=nfgxDRIldEk/R6olj1UZ0FCTTO6aAoi4Q6LnOlbTBi4zzExdN8CexouhT/tOVCcVMVSs0pdf
 kmYzNqxt52NgJvoQyWGF8dDQ4EEHGTekQtylPs0WwWHvJIEOFKCYhq3uTsvu58lKIW0f0PMP
 nnsCr9Ohn67Sqa7EJCIbccw9DfI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ee334aaf3deea03f3287de3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Jun 2020 07:54:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4AAAEC433C8; Fri, 12 Jun 2020 07:54:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47AC5C433C8;
        Fri, 12 Jun 2020 07:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47AC5C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/mediatek/mt76/pci.c:8:6: warning: no previous prototype for 'mt76_pci_disable_aspm'
References: <202006121458.U2yugTnM%lkp@intel.com>
Date:   Fri, 12 Jun 2020 10:54:11 +0300
In-Reply-To: <202006121458.U2yugTnM%lkp@intel.com> (kernel test robot's
        message of "Fri, 12 Jun 2020 14:35:01 +0800")
Message-ID: <87h7vgk9cs.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b791d1bdf9212d944d749a5c7ff6febdba241771
> commit: f37f05503575c59020dacd36e999f4e8b3dbc115 mt76: mt76x2e: disable pcie_aspm by default
> date:   8 months ago
> config: microblaze-randconfig-r023-20200612 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout f37f05503575c59020dacd36e999f4e8b3dbc115
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
>>> drivers/net/wireless/mediatek/mt76/pci.c:8:6: warning: no previous prototype for 'mt76_pci_disable_aspm' [-Wmissing-prototypes]
> 8 | void mt76_pci_disable_aspm(struct pci_dev *pdev)
> |      ^~~~~~~~~~~~~~~~~~~~~
>
> vim +/mt76_pci_disable_aspm +8 drivers/net/wireless/mediatek/mt76/pci.c
>
>      7	
>    > 8	void mt76_pci_disable_aspm(struct pci_dev *pdev)

Looks like "include mt76.h" is missing in pci.c. Can someone send a
patch, please?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
