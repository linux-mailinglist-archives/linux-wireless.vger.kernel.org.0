Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66701B7126
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDXJqM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 05:46:12 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38514 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgDXJqM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 05:46:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587721571; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=nCC+pwO41YYGyZcsMl3gOUvBsD5vaGSUUfWswhpkVxQ=; b=iEQS7s2wmUWob+XO/RVZE3DUHu9fCYk7AQeaHsqoiD6KdCSCok+sOGg5KB8/SWZYO12/aZZ8
 f0J2p2dBgMznvxfabK4HLIEketVnuvfBPG4bh5jh1lrzLVpZi0X2ViUppo2XqZF2gEJmW9LL
 f+PXFV+l6BlNtFTLW6J1QDUMNhk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea2b553.7f35eede4928-smtp-out-n04;
 Fri, 24 Apr 2020 09:45:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25AAEC433BA; Fri, 24 Apr 2020 09:45:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C03BC433CB;
        Fri, 24 Apr 2020 09:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C03BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, kbuild-all@lists.01.org,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [wireless-drivers-next:master 41/48] drivers/net/wireless/realtek/rtw88/mac.c:653:5: sparse: sparse: symbol '__rtw_download_firmware' was not declared. Should it be static?
References: <202004241610.NSbGjIMy%lkp@intel.com>
Date:   Fri, 24 Apr 2020 12:45:49 +0300
In-Reply-To: <202004241610.NSbGjIMy%lkp@intel.com> (kbuild test robot's
        message of "Fri, 24 Apr 2020 16:57:52 +0800")
Message-ID: <87r1wdgqsy.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

kbuild test robot <lkp@intel.com> writes:

> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git
> master
> head:   75e69fb11b40ba1256b14f943c7050682c1f5458
> commit: 15d2fcc6b2dea46986e55cd3808c0dbb480a6c8d [41/48] rtw88: add
> legacy firmware download for 8723D devices
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-191-gc51a0382-dirty
>         git checkout 15d2fcc6b2dea46986e55cd3808c0dbb480a6c8d
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/net/wireless/realtek/rtw88/mac.c:653:5: sparse: sparse:
>>> symbol '__rtw_download_firmware' was not declared. Should it be
>>> static?
>>> drivers/net/wireless/realtek/rtw88/mac.c:817:5: sparse: sparse:
>>> symbol '__rtw_download_firmware_legacy' was not declared. Should it
>>> be static?
>
> Please review and possibly fold the followup patch.

Tony, please send the patch via linux-wireless so that patchwork sees
it.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
