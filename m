Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28A2203A12
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgFVOzn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:55:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26762 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgFVOzn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:55:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592837742; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=OLSS+KRgX5n50AoMk56HGdDuDHRpwuXMsAFnQNuxhMo=; b=Vq8hFMlgKABRQT5Ysd2A5xNIkOHI/7BnpBRL15lj4P4jNK2eM03DTfN3IEBuayKqwZrxWRFe
 D/0Meo7CQE96lH4M959tIn2ZIVctBHW/Ay1byv18ghYY273EMeh+gY+R24UYeFam+IBAYGvB
 icDTCC6kfvLBeEMuatgwnrS6xSw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5ef0c65cf3deea03f34047c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 14:55:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA5CAC433CA; Mon, 22 Jun 2020 14:55:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2EBDC433C6;
        Mon, 22 Jun 2020 14:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2EBDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     kernel test robot <lkp@intel.com>,
        Joseph Chuang <joseph.chuang@cypress.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40: sparse: sparse: incorrect type in initializer (different base types)
References: <202006190422.VymyEbuu%lkp@intel.com>
        <87a70vgpkb.fsf@codeaurora.org>
        <76e75ef2-850b-2860-f28b-ba773ee50117@cypress.com>
Date:   Mon, 22 Jun 2020 17:55:20 +0300
In-Reply-To: <76e75ef2-850b-2860-f28b-ba773ee50117@cypress.com> (Chi-Hsien
        Lin's message of "Mon, 22 Jun 2020 22:48:18 +0800")
Message-ID: <875zbjf8vb.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> writes:

> On 06/22/2020 10:09, Kalle Valo wrote:
>> + linux-wireless
>>
>> kernel test robot <lkp@intel.com> writes:
>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   5e857ce6eae7ca21b2055cca4885545e29228fe2
>>> commit: 9c29da3f4e7ef9810bdfaf3d8aa5e6d2e33136f8 brcmfmac: Fix P2P
>>> Group Formation failure via Go-neg method
>>> date:   6 weeks ago
>>> config: riscv-randconfig-s032-20200618 (attached as .config)
>>> compiler: riscv64-linux-gcc (GCC) 9.3.0
>>> reproduce:
>>>          # apt-get install sparse
>>>          # sparse version: v0.6.2-rc1-10-gc17b1b06-dirty
>>>          git checkout 9c29da3f4e7ef9810bdfaf3d8aa5e6d2e33136f8
>>>          # save the attached .config to linux build tree
>>>          make W=1 C=1 ARCH=riscv CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>>
>>> sparse warnings: (new ones prefixed by >>)
>>>
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40:
>>>>> sparse: sparse: incorrect type in initializer (different base
>>>>> types) @@ expected signed int [usertype] requested_dwell @@ got
>>>>> restricted __le32 [usertype] dwell_time @@
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40:
>>>>> sparse: expected signed int [usertype] requested_dwell
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40:
>>>>> sparse: got restricted __le32 [usertype] dwell_time
>>
>> Joseph, please send a followup patch to fix these.
> Kalle,
>
> The fix is this one
> https://patchwork.kernel.org/patch/11598109/

Great, thanks.

> Do I need to submit a V2 with "Reported-by: kernel test robot
> <lkp@intel.com>" tag?

No need to send v2. But you can reply to that patch (so that patchwork
sees it) and ask me to add the tag during commit.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
